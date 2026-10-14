
import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/additional_deployments/cubits/additional_deployments_cubit.dart';

import '../models/adhoc_attendance_model.dart' as adhoc;

class DeploymentFormEntry {
  final String id;

  // All four fields are now dropdown selections sourced from cubit state.
  Organisation? selectedDutyPost;
  Organisation? selectedDesignation;
  Organisation? selectedShift;
  Organisation? selectedDutyHours;

  DeploymentFormEntry({required this.id});

  bool get isComplete =>
      selectedDutyPost !=null &&
          selectedDesignation != null &&
          selectedShift != null &&
          selectedDutyHours != null;

  int get dutyHoursValue {
    final id = selectedDutyHours?.id;
    if (id != null) return id;
    final match = RegExp(r'\d+').firstMatch(selectedDutyHours?.name ?? '');
    return match != null ? int.parse(match.group(0)!) : 0;
  }
  // No controllers to dispose anymore, kept for call-site compatibility.
  void dispose() {}
}

class SlaViolation {
  final String id;
  final String region;
  final String location;
  final String dateOfCreation;
  final String createdBy;
  final String asl;
  final String typeOfService;
  final String status;

  SlaViolation({
    required this.id,
    required this.region,
    required this.location,
    required this.dateOfCreation,
    required this.createdBy,
    required this.asl,
    required this.typeOfService,
    required this.status,
  });
}

class ShiftDetail {
  final String shiftLabel;
  final String timeRange;
  final int dutyHours;
  final String status;
  final bool isSubmitted;
  final int required;
  final int supplied;
  final int shortage;
  final int overTime;
  final List<String> attendedGuards;
  final List<SlaViolation> slaViolations;

  // id used to key this shift's edits (added/removed guards) in
  // `_attendedGuardsByEntry` / `_slaViolationsByEntry`. Set for BOTH:
  //  - local drafts added via "+" (the DeploymentFormEntry.id), and
  //  - shifts already returned by the API (a synthetic 'api_<shiftId>' key).
  // A non-null entryId is what makes the card render as editable (shows
  // the "AVAILABLE GUARDS" picker and the "Add SLA Violation" action).
  // Null => fully read-only summary (used only when the overall record is
  // locked/cancelled, see `isReadOnly` in the State class).
  //
  // NOTE: whether the "Remove" action shows on a given ATTENDED row is no
  // longer decided by `isSubmitted` / Draft-vs-Submitted status. It is
  // decided per-guard by whether that guard's id is present in
  // `_newlyAddedGuardIdsByEntry[entryId]` — i.e. whether the guard was
  // added in THIS session via the "AVAILABLE GUARDS" dropdown. Guards that
  // were already attended (seeded from the API, or from an earlier
  // save/submit) never get "Remove". See `_attendedGuardsList`.
  final String? entryId;

  // The actual Organisation objects behind `attendedGuards`, kept alongside
  // the plain-string list so the editable card can remove a specific guard
  // by id (two guards can share a display name).
  final List<Organisation> attendedGuardObjects;

  ShiftDetail({
    required this.shiftLabel,
    required this.timeRange,
    required this.dutyHours,
    required this.status,
    this.isSubmitted = false,
    this.required = 0,
    this.supplied = 0,
    this.shortage = 0,
    this.overTime = 0,
    this.attendedGuards = const [],
    this.slaViolations = const [],
    this.entryId,
    this.attendedGuardObjects = const [],
  });
}

class RankGroup {
  final String rankLabel; // "RANK: SECURITY SUPERVISOR"
  final List<ShiftDetail> shifts;
  RankGroup({required this.rankLabel, required this.shifts});
}

class DutyPostGroup {
  final String dutyPostLabel; // "A", "C", "Basement" ...
  final List<RankGroup> ranks;
  DutyPostGroup({required this.dutyPostLabel, required this.ranks});
}

class AdditionalDeploymentsView extends StatefulWidget {
  final AttendanceModel? model;
  final ExtraProperties? extraProperties;
  static int flag = 0;
  final int attInfoId;
  final Organisation location;
  final Organisation locationRegion;

  const AdditionalDeploymentsView({
    super.key,
    this.model,
    this.extraProperties,
    required this.attInfoId,
    required this.location,
    required this.locationRegion,
  });

  @override
  State<AdditionalDeploymentsView> createState() =>
      _AdditionalDeploymentsViewState();
}

class _AdditionalDeploymentsViewState
    extends State<AdditionalDeploymentsView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User? userDetails;
  TextEditingController genderController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController dutyTypeController = TextEditingController();
  TextEditingController attendanceTypeController = TextEditingController();
  TextEditingController approvalStatusController = TextEditingController();

  // ---------------------------------------------------------------
  // Dedicated controller/key for the "Add Comment" (Dislike) dialog.
  // These MUST be state fields (not locals declared inline inside the
  // onTapDislikeButton callback) so they survive rebuilds and so the
  // TextFormField/Form actually have something valid to bind to — a
  // previous inline version referenced an undefined `commentFormKey`
  // and an undefined `value`, which doesn't compile.
  // ---------------------------------------------------------------
  final TextEditingController _dislikeCommentController =
  TextEditingController();
  final GlobalKey<FormState> _dislikeCommentFormKey = GlobalKey<FormState>();

  bool isDisabled = true;
  bool isReadOnly = false;
  int flag = 0;

  // Separate flag for the state locked/cancelled cases that should ALSO
  // block adding new deployments. This is intentionally NOT the same as
  // `isReadOnly`, because `isReadOnly` also gets set true whenever
  // `state.model.isEligibleToEdit` is false — which was silently hiding
  // the "+" button on records where it should still show. Only truly
  // locked or cancelled records should block adding a new deployment.
  bool _dutyPostLocked = false;
  bool get _canAddDeployment => !_dutyPostLocked;

  // ---------------------------------------------------------------
  // Tracks whether the LAST submitForm(...) call we made was a
  // save-only call (isSaveOnly: true). The BlocConsumer listener below
  // shows a "Duty Post Master" success dialog whenever
  // state.status == FormStatus.success — but that dialog should only
  // appear for a real Submit/Like/Dislike action, not for a background
  // save (the header's Save button, or the auto-save that now runs
  // before opening the SLA Violation screen). Set this to `true`
  // immediately before any submitForm(isSaveOnly: true) call, and to
  // `false` before any submitForm(isSaveOnly: false) call; the listener
  // consumes and resets it.
  // ---------------------------------------------------------------
  bool _lastSubmitWasSaveOnly = false;

  // Tracks which deployment cards are expanded/collapsed (by id).
  final Set<String> _collapsedDeploymentIds = {};
  // Tracks which duty-post / rank accordion sections are expanded.
  final Set<String> _collapsedSectionKeys = {};
  // Tracks which SLA-violation cards (inside a shift's SLA list) are
  // expanded/collapsed, keyed by the violation's own id. New cards are
  // added collapsed so the list stays scannable, same as the mock.
  final Set<String> _collapsedSlaIds = {};

  // ---------------------------------------------------------------
  // Live list of deployment cards added via the "+" button.
  // ---------------------------------------------------------------
  final List<DeploymentFormEntry> _deploymentForms = [];
  final Map<String, List<Organisation>> _attendedGuardsByEntry = {};
  final Map<String, List<SlaViolation>> _slaViolationsByEntry = {};
  final Map<String, Set<int>> _newlyAddedGuardIdsByEntry = {};

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AdditionalDeploymentsCubit>(context).initializeValues();
    AdditionalDeploymentsView.flag = 0;
  }

  @override
  void dispose() {
    for (final f in _deploymentForms) {
      f.dispose();
    }
    genderController.dispose();
    statusController.dispose();
    dutyTypeController.dispose();
    attendanceTypeController.dispose();
    approvalStatusController.dispose();
    _dislikeCommentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return BlocConsumer<AdditionalDeploymentsCubit, AdditionalDeploymentsState>(
      listener: (context, state) {
        log('-state.status---${state.status}----');
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);

        if (state.status == FormStatus.success) {
          if (_lastSubmitWasSaveOnly) {
            // Background/save-only call (header Save button, or the
            // auto-save before opening the SLA Violation screen) —
            // don't interrupt the user with the success popup.
            _lastSubmitWasSaveOnly = false;
          } else {
            var dialog = CustomAlertDialog(
              title: 'Duty Post Master',
              message: state.message ?? '',
              positiveBtnText: Constants.ok,
              onPositivePressed: () {
                // TODO: Need to improve this code
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.popAndPushNamed(
                  context,
                  attendanceListRoute,
                  arguments: {},
                );
              },
            );
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => dialog,
            );
          }
        }
      },
      builder: (context, state) {
        if (widget.model == null) {
          isReadOnly = false;
        }
        if (state.model.status == null) {
          isReadOnly = false;
        }
        if (state.model.status == ConstantsIntValue.cancelledStatus) {
          isReadOnly = true;
        }
        if (!state.model.lock.isEmptyOrNull) {
          isReadOnly = true;
        }

        log('isEligible -----  ${!state.model.isEligibleToEdit}');
        if (!state.model.isEligibleToEdit) {
          isReadOnly = true;
        }

        final bool _isApprovedAndActive =
            state.model.approvalStatus == ConstantsIntValue.attendanceApprovalApproved &&
                state.model.status == 1;
        if (_isApprovedAndActive) {
          isReadOnly = true;
        }
        _dutyPostLocked = !state.model.lock.isEmptyOrNull ||
            state.model.status == ConstantsIntValue.cancelledStatus;

        bool _canShowApprovalActions(AdditionalDeploymentsState state) {
          if (_dutyPostLocked) return false; // locked or cancelled
          if (!state.model.isEligibleToEdit) return false;

          final deployments = state.adhocModel?.deployments ?? const [];
          return deployments.any((d) => d.attendanceStatus == 2);
        }
        initializeDates();
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: 'Additional Deployments',
            showPopUp: false,
            showSubmitButton:state.model.approvalStatus != ConstantsIntValue.attendanceApprovalPending && state.model.approvalStatus != ConstantsIntValue.attendanceApprovalApproved,
            // showSubmitButton: !_canShowApprovalActions(state),
            showSaveButton: false,
            // showDisLikeButton: true,
            showLikeButton: state.model.approvalStatus == ConstantsIntValue.attendanceApprovalPending,
            showDisLikeButton: state.model.approvalStatus == ConstantsIntValue.attendanceApprovalPending,
            // showLikeButton: _canShowApprovalActions(state),
            pdfAPIName:
            '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=${Constants.attendanceModuleCode}',
            onTapSave: () {
              FocusScope.of(context).unfocus();
              _syncAllDeploymentEditsToCubit();
              _lastSubmitWasSaveOnly = true;
              BlocProvider.of<AdditionalDeploymentsCubit>(context)
                  .submitForm(isSaveOnly: true,);
            },
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              _syncAllDeploymentEditsToCubit();
              _lastSubmitWasSaveOnly = false;
              BlocProvider.of<AdditionalDeploymentsCubit>(context)
                  .submitForm(isSaveOnly: false,);
            },
            onTapLikeButton: () {
              FocusScope.of(context).unfocus();
              _syncAllDeploymentEditsToCubit();
              _lastSubmitWasSaveOnly = false;
              BlocProvider.of<AdditionalDeploymentsCubit>(context)
                  .submitForm(isSaveOnly: false, isApprovedStatus: true);
            },
            // onTapDislikeButton: () {
            //   FocusScope.of(context).unfocus();
            //   _syncAllDeploymentEditsToCubit();
            //   BlocProvider.of<AdditionalDeploymentsCubit>(context)
            //       .submitForm(isSaveOnly: false,isApprovedStatus: false);
            // },
            onTapDislikeButton: () {
              FocusScope.of(context).unfocus();
              _showDislikeCommentDialog(context, state);
            },
          ),
          backgroundColor: Colors.transparent,
          body: SizedBox.expand(
            child: getBodybuilder(state, height),
          ),
        );
      },
    );
  }

  // -----------------------------------------------------------------
  // "Add Comment" (Dislike) dialog — frosted/dark card styled to match
  // the app's existing alert popups (blurred backdrop, translucent dark
  // card, rounded corners, bold title, actions right-aligned).
  // Uses the state-level `_dislikeCommentFormKey` /
  // `_dislikeCommentController` declared above.
  // -----------------------------------------------------------------
  void _showDislikeCommentDialog(
      BuildContext context, AdditionalDeploymentsState state) {
    _dislikeCommentController.clear();
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.35),
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white24),
                ),
                child: Form(
                  key: _dislikeCommentFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Add Comment',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 14),
                      TextFormField(
                        controller: _dislikeCommentController,
                        maxLines: 4,
                        autofocus: true,
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          hintText: 'Enter your comment',
                          hintStyle: const TextStyle(color: Colors.white54),
                          filled: true,
                          fillColor: Colors.white.withValues(alpha: 0.06),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                            const BorderSide(color: Colors.white24),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                            const BorderSide(color: Colors.white24),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                            const BorderSide(color: Colors.redAccent),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                            const BorderSide(color: Colors.redAccent),
                          ),
                          errorStyle:
                          const TextStyle(color: Colors.redAccent),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Comment is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(dialogContext),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white70,
                            ),
                            child: const Text('Cancel'),
                          ),
                          const SizedBox(width: 4),
                          TextButton(
                            onPressed: () {
                              if (!(_dislikeCommentFormKey.currentState
                                  ?.validate() ??
                                  false)) {
                                return;
                              }
                              final comment =
                              _dislikeCommentController.text.trim();

                              // Write the comment onto the adhoc model
                              // before syncing/submitting so it travels
                              // along with the rest of the payload.
                              state.adhocModel?.approvalComment = comment;

                              Navigator.pop(dialogContext);

                              _syncAllDeploymentEditsToCubit();
                              _lastSubmitWasSaveOnly = false;
                              BlocProvider.of<AdditionalDeploymentsCubit>(
                                  context)
                                  .submitForm(
                                  isSaveOnly: false,
                                  isApprovedStatus: false);
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                            ),
                            child: const Text(
                              'Ok',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void initializeDates() {}

  // Rebuilds and pushes EVERY deployment currently on screen — both
  // brand-new local drafts AND deployments already merged into
  // `state.adhocModel.deployments` from an earlier Save/Submit — so any
  // guard added/removed after that first merge (e.g. removing Apple and
  // adding Pooja on a shift that's already in state.adhocModel) actually
  // makes it into the payload instead of silently staying stale.
  //
  // Previously this only looked at `_deploymentForms` (brand-new drafts),
  // so an edit made to an already-merged shift never got written back —
  // the cubit kept serving its original snapshot from the first merge.
  void _syncAllDeploymentEditsToCubit() {
    final cubit = BlocProvider.of<AdditionalDeploymentsCubit>(context);
    final state = cubit.state;
    final apiDeployments =
        state.adhocModel?.deployments ?? const <adhoc.Deployments>[];

    // 1) Refresh every deployment already known to the cubit with
    // whatever attended-guard edits are currently sitting in
    // `_attendedGuardsByEntry`. Uses the SAME key derivation as
    // `_buildDutyPostGroups` so this reads exactly what the card on
    // screen is currently showing.
    final refreshedExisting = <adhoc.Deployments>[];
    for (var i = 0; i < apiDeployments.length; i++) {
      final d = apiDeployments[i];
      final apiEntryKey = 'api_${i}_${d.attendanceShiftId}';
      final attended = _attendedGuardsByEntry[apiEntryKey];

      if (attended == null) {
        // No local edits recorded for this shift — pass it through as-is.
        refreshedExisting.add(d);
        continue;
      }

      refreshedExisting.add(
        adhoc.Deployments(
          attendanceShiftId: d.attendanceShiftId,
          dutyPostName: d.dutyPostName,
          shiftId: d.shiftId,
          shift: d.shift,
          rankId: d.rankId,
          designation: d.designation,
          dutyHours: d.dutyHours,
          required: d.required,
          supplied: attended.length,
          shortage: d.shortage,
          overTime: d.overTime,
          attendanceStatus: d.attendanceStatus,
          attendanceStatusLabel: d.attendanceStatusLabel,
          attendedGuards: attended
              .map((g) =>
              adhoc.AttendedGuard(guardId: g.id, guardName: g.name))
              .toList(),
          // Violations aren't editable on an already-merged shift through
          // this View yet, so pass the existing ones through unchanged.
          violations: d.violations,
        ),
      );
    }

    // 2) Brand-new local drafts that haven't been merged in yet — same
    // as before.
    final completedDrafts =
    _deploymentForms.where((e) => e.isComplete).toList();
    final newDeployments = completedDrafts.map((entry) {
      final attendedGuards = _attendedGuardsByEntry[entry.id] ?? const [];
      final violations = _slaViolationsByEntry[entry.id] ?? const [];

      return adhoc.Deployments(
        attendanceShiftId: null, // new deployment — not yet persisted
        dutyPostName: entry.selectedDutyPost?.name,
        shiftId: entry.selectedShift?.id,
        shift: entry.selectedShift?.name,
        rankId: entry.selectedDesignation?.id,
        designation: entry.selectedDesignation?.name,
        dutyHours: entry.dutyHoursValue,
        required: 0,
        supplied: attendedGuards.length,
        shortage: 0,
        overTime: 0,
        attendanceStatus: 0,
        attendanceStatusLabel: 'Draft',
        attendedGuards: attendedGuards
            .map((g) => adhoc.AttendedGuard(guardId: g.id, guardName: g.name))
            .toList(),
        violations: violations
            .map((v) => {
          'id': v.id,
          'region': v.region,
          'location': v.location,
          'dateOfCreation': v.dateOfCreation,
          'createdBy': v.createdBy,
          'asl': v.asl,
          'typeOfService': v.typeOfService,
          'status': v.status,
        })
            .toList(),
      );
    }).toList();

    if (refreshedExisting.isEmpty && newDeployments.isEmpty) return;

    // CAVEAT — I don't have AdditionalDeploymentsCubit's source, so this
    // assumes `mergeDraftDeployments` UPSERTS by identity (dutyPostName /
    // shiftId / rankId / attendanceShiftId) rather than blindly appending
    // whatever list it's given. That's the only reading of "merge" that
    // makes sense here. If it turns out to be a plain append instead,
    // passing `refreshedExisting` back through it (entries that already
    // exist in state.adhocModel.deployments) will duplicate cards instead
    // of updating them in place — in that case this needs a dedicated
    // replace/update method on the cubit rather than reusing this one.
    // Share the cubit file if that happens and I'll wire it precisely.
    cubit.mergeDraftDeployments([...refreshedExisting, ...newDeployments]);

    setState(() {
      for (final entry in completedDrafts) {
        _deploymentForms.remove(entry);
        _attendedGuardsByEntry.remove(entry.id);
        _slaViolationsByEntry.remove(entry.id);
        _newlyAddedGuardIdsByEntry.remove(entry.id);
      }
    });
  }
  // -----------------------------------------------------------------
  // BODY
  // -----------------------------------------------------------------
  Widget getBodybuilder(AdditionalDeploymentsState state, height) {
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('assets/images/bg2.png', fit: BoxFit.cover),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
            child: Container(
              color: Colors.black.withValues(alpha: 0.08), // optional tint
            ),
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    AbsorbPointer(
                      absorbing: false,
                      child: Padding(
                        padding:
                        const EdgeInsets.only(left: 20.0, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (!state.model.lock.isEmptyOrNull) ...[
                              RecordLockedWidget(text: '${state.model.lock}'),
                            ],
                            CommonWidgets.verticalSpacerWidget(height * 0.02),
                            Container(
                              alignment: Alignment.topLeft,
                              child: const Text(
                                Constants.generalinformation,
                                style: Styles.textStyleWhite16,
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            // ---------------------------------------------
                            // "Additional Deployments" header with +
                            // button that adds a new empty deployment card.
                            // ---------------------------------------------
                            _additionalDeploymentsHeader(),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            // ---------------------------------------------
                            // Deployment cards (Shift A / Shift B ...)
                            // ---------------------------------------------
                            buildDeploymentCardsSection(state, height),

                            // ---------------------------------------------
                            // Duty Post -> Rank -> Shift accordion, built
                            // dynamically from completed deployment cards.
                            // ---------------------------------------------
                            CommonWidgets.verticalSpacerWidget(height * 0.02),
                            buildDutyPostAccordionSection(state, height),
                          ],
                        ),
                      ),
                    ),
                    CommonWidgets.verticalSpacerWidget(height * 0.02),

                    // /// SubmitButton
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     cancelButtonDisplay(),
                    //     if (!isReadOnly) ...[submitButtonDisplay()],
                    //   ],
                    // ),
                    CommonWidgets.verticalSpacerWidget(height * 0.04),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // -----------------------------------------------------------------
  // "Additional Deployments" header with the + button that pushes a new
  // empty deployment card onto the list.
  // -----------------------------------------------------------------
  Widget _additionalDeploymentsHeader() {
    return Container(
      width: double.infinity, // <-- fixes the collapsed "+" button
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF5B4FCF)),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white.withValues(alpha: 0.04),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 12,
            backgroundColor: Colors.white24,
            child: Text(
              'AD',
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Additional Deployments',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
          if (!isReadOnly)
            InkWell(
              onTap: _addDeployment,
              child: Container(
                width: 26,
                height: 26,
                decoration: const BoxDecoration(
                  color: Color(0xFF5B4FCF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 16),
              ),
            ),
        ],
      ),
    );
  }

  void _addDeployment() {
    setState(() {
      final entry = DeploymentFormEntry(
        id: 'deployment_${DateTime.now().microsecondsSinceEpoch}',
      );
      _deploymentForms.add(entry);
      // Newly added cards start expanded so the user can fill them in.
      _collapsedDeploymentIds.remove(entry.id);
    });
  }

  void _removeDeployment(String id) {
    setState(() {
      _deploymentForms.removeWhere((f) => f.id == id);
      _collapsedDeploymentIds.remove(id);
      _attendedGuardsByEntry.remove(id);
      _slaViolationsByEntry.remove(id);
      _newlyAddedGuardIdsByEntry.remove(id);
    });
  }

  // -----------------------------------------------------------------
  // DEPLOYMENT CARDS  (top of the design: "Shift A" / "Shift B" cards)
  // -----------------------------------------------------------------
  Widget buildDeploymentCardsSection(
      AdditionalDeploymentsState state, double height) {
    final apiDeployments = state.adhocModel?.deployments ?? const [];

    if (apiDeployments.isEmpty && _deploymentForms.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final d in apiDeployments) ...[
          _apiDeploymentCard(d),
          CommonWidgets.verticalSpacerWidget(height * 0.02),
        ],
        for (final entry in _deploymentForms) ...[
          _deploymentCard(entry, state),
          CommonWidgets.verticalSpacerWidget(height * 0.02),
        ],
      ],
    );
  }

  String _deploymentHeaderText(DeploymentFormEntry entry) {
    if (entry.isComplete) {
      return '${entry.selectedDutyPost?.name}   '
          '${entry.selectedShift?.name}   '
          '${entry.selectedDesignation?.name}   '
          'Hours: ${entry.selectedDutyHours?.name}';
    }
    return 'Duty Post   Shift   Designation   Hours: '
        '${entry.selectedDutyHours?.name ?? '-'}';
  }

  Widget _apiDeploymentCard(adhoc.Deployments d) {
    final cardId = 'api_${d.attendanceShiftId}';
    final isCollapsed = _collapsedDeploymentIds.contains(cardId);
    final dutyPost = d.dutyPostName ?? '-';
    final shiftLabel = (d.shift == null || d.shift!.isEmpty)
        ? '-'
        : 'Shift ${d.shift}';
    final designation = d.designation ?? '-';
    final dutyHours = d.dutyHours ?? 0;

    final headerText =
        '$dutyPost   $shiftLabel   $designation   Hours: $dutyHours';

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white24),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: const Color(0xFF3D6DB0),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.white24,
                  child: Text(
                    dutyPost.isNotEmpty ? dutyPost[0] : '?',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    headerText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      if (isCollapsed) {
                        _collapsedDeploymentIds.remove(cardId);
                      } else {
                        _collapsedDeploymentIds.add(cardId);
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.red),
                    ),
                    child: Icon(
                      isCollapsed
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_up,
                      size: 14,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (!isCollapsed)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _readOnlyField(
                          label: 'DUTY POST',
                          value: dutyPost,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _readOnlyField(
                          label: 'DESIGNATION',
                          value: designation,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _readOnlyField(
                          label: 'SHIFT',
                          value: shiftLabel,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _readOnlyField(
                          label: 'DUTY HOURS',
                          value: '$dutyHours hrs',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _readOnlyField({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xFF3D6DB0)),
          ),
          child: Text(
            value,
            style: const TextStyle(color: Colors.black87),
          ),
        ),
      ],
    );
  }

  Widget _deploymentCard(DeploymentFormEntry entry, AdditionalDeploymentsState state) {
    final isCollapsed = _collapsedDeploymentIds.contains(entry.id);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white24),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: const Color(0xFF3D6DB0),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.white24,
                  child: Text(
                    entry.selectedDutyPost?.name?.isNotEmpty == true
                        ? entry.selectedDutyPost!.name![0].toUpperCase()
                        : '?',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),

                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _deploymentHeaderText(entry),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                InkWell(
                  onTap: () => _removeDeployment(entry.id),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.red),
                    ),
                    child: const Icon(Icons.close, size: 14, color: Colors.red),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      if (isCollapsed) {
                        _collapsedDeploymentIds.remove(entry.id);
                      } else {
                        _collapsedDeploymentIds.add(entry.id);
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.red),
                    ),
                    child: Icon(
                      isCollapsed
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_up,
                      size: 14,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (!isCollapsed)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _dutyPostDropdownField(entry, state)),
                      const SizedBox(width: 12),
                      Expanded(child: _designationDropdownField(entry, state)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _shiftDropdownField(entry, state)),
                      const SizedBox(width: 12),
                      Expanded(child: _dutyHoursDropdownField(entry, state)),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }


  Widget _dutyPostDropdownField(
      DeploymentFormEntry entry, AdditionalDeploymentsState state) {
    return _organisationDropdownField(
      label: 'Duty Post',
      value: entry.selectedDutyPost,
      items: state.dutyPostList,
      hint: 'Select Duty Post',
      onChanged: (value) {
        setState(() {
          entry.selectedDutyPost = value;
        });
      },
    );
  }
  // Finds the matching item in `items` by id so DropdownButton's `value`
  // is always object-identical to one of its `items` entries (required by
  // Flutter, since Organisation likely doesn't override `==`).
  Organisation? _matchInList(List<Organisation> items, Organisation? value) {
    if (value == null) return null;
    for (final item in items) {
      if (item.id == value.id) return item;
    }
    return null;
  }

  // Generic dropdown for any Organisation-shaped API list (designation,
  // shift, duty hours).
  Widget _organisationDropdownField({
    required String label,
    required Organisation? value,
    required List<Organisation> items,
    required ValueChanged<Organisation?> onChanged,
    String hint = 'Select',
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xFF3D6DB0)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<Organisation>(
              isExpanded: true,
              value: _matchInList(items, value),
              hint: Text(hint, style: const TextStyle(color: Colors.black38)),
              items: items
                  .map(
                    (o) => DropdownMenuItem<Organisation>(
                  value: o,
                  child: Text(o.name ?? '-'),
                ),
              )
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _designationDropdownField(
      DeploymentFormEntry entry, AdditionalDeploymentsState state) {
    return _organisationDropdownField(
      label: 'DESIGNATION',
      value: entry.selectedDesignation,
      items: state.designations,
      hint: 'Select designation',
      onChanged: (value) {
        setState(() {
          entry.selectedDesignation = value;
        });
      },
    );
  }

  Widget _shiftDropdownField(
      DeploymentFormEntry entry, AdditionalDeploymentsState state) {
    return _organisationDropdownField(
      label: 'SHIFT',
      value: entry.selectedShift,
      items: state.shifts,
      hint: 'Select shift',
      onChanged: (value) {
        setState(() {
          entry.selectedShift = value;
        });
      },
    );
  }

  Widget _dutyHoursDropdownField(
      DeploymentFormEntry entry, AdditionalDeploymentsState state) {
    return _organisationDropdownField(
      label: 'DUTY HOURS',
      value: entry.selectedDutyHours,
      items: state.dutyHoursList,
      hint: 'Select duty hours',
      onChanged: (value) {
        setState(() {
          entry.selectedDutyHours = value;
        });
      },
    );
  }

  // -----------------------------------------------------------------
  // DUTY POST -> RANK -> SHIFT ACCORDION
  // (Attendance marking + SLA violations, bottom of the design)
  // -----------------------------------------------------------------
  Widget buildDutyPostAccordionSection(
      AdditionalDeploymentsState state, double height) {
    final List<DutyPostGroup> dutyPostGroups = _buildDutyPostGroups(state);

    if (dutyPostGroups.isEmpty) {
      final message = state.adhocModel?.emptyStateMessage ??
          'Select duty post, shift, and designation above to generate adhoc attendance cards.';
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final group in dutyPostGroups) ...[
          _dutyPostAccordion(group, height, state),
          CommonWidgets.verticalSpacerWidget(height * 0.02),
        ],
      ],
    );
  }

  bool _isSubmittedStatus(String status) {
    final normalized = status.toLowerCase();
    return normalized.contains('submit') || normalized.contains('approve');
  }

  List<DutyPostGroup> _buildDutyPostGroups(AdditionalDeploymentsState state) {
    final Map<String, Map<String, List<ShiftDetail>>> grouped = {};

    void addShift(String dutyPost, String designation, ShiftDetail shift) {
      grouped.putIfAbsent(dutyPost, () => {});
      grouped[dutyPost]!.putIfAbsent(designation, () => []);
      grouped[dutyPost]![designation]!.add(shift);
    }

    final apiDeployments =
        state.adhocModel?.deployments ?? const <adhoc.Deployments>[];
    for (var i = 0; i < apiDeployments.length; i++) {
      final d = apiDeployments[i];
      final dutyPost = d.dutyPostName ?? '-';
      final designation = (d.designation ?? '-').trim();
      final statusLabel = d.attendanceStatusLabel ?? 'Draft';
      final isSubmitted = _isSubmittedStatus(statusLabel);

      // Synthetic key for a shift that already came back from the API (or
      // was already merged in from a completed local draft), so it can
      // share the same edit/available-guards machinery as a fresh local
      // draft (see `_attendedGuardsByEntry` docs above).
      //
      // IMPORTANT: this can NOT be keyed off `d.attendanceShiftId` alone —
      // a deployment merged in locally (e.g. via mergeDraftDeployments)
      // still has `attendanceShiftId == null` until the backend actually
      // persists it, so multiple such deployments would all collide on
      // the same literal key 'api_null' and silently share/overwrite each
      // other's attended-guard edits. Including the list index keeps each
      // one distinct as long as the list's ordering is stable across
      // rebuilds (true here, since it comes straight from `state.adhocModel`).
      final apiEntryKey = 'api_${i}_${d.attendanceShiftId}';
      _attendedGuardsByEntry.putIfAbsent(
        apiEntryKey,
            () => (d.attendedGuards ?? const [])
            .map((g) => Organisation(id: g.guardId, name: g.guardName))
            .toList(),
      );
      final attendedObjects = _attendedGuardsByEntry[apiEntryKey]!;

      addShift(
        dutyPost,
        designation,
        ShiftDetail(
          shiftLabel: 'SHIFT ${d.shift ?? '-'}',
          timeRange: _timeRangeForShift(d.shift ?? ''),
          dutyHours: d.dutyHours ?? 0,
          status: statusLabel,
          isSubmitted: isSubmitted,
          attendedGuards: attendedObjects.map((g) => g.name ?? '-').toList(),
          attendedGuardObjects: attendedObjects,
          // entryId is set for every shift regardless of Draft/Submitted —
          // that only ever gated whether the card is editable at all.
          // Per-guard "Remove" visibility is now handled separately in
          // `_attendedGuardsList` via `_newlyAddedGuardIdsByEntry`.
          entryId: apiEntryKey,
          slaViolations: (d.violations ?? const []).map((v) {
            if (v is Map) {
              final location = v['location'] as Map?;
              final locationRegion = v['locationRegion'] as Map?;
              final entrySecurity = v['entrySecurity'] as Map?;
              final approver = v['approver'] as Map?;
              final typeOfServiceList = v['typeOfService'] as List?;

              String _fullName(Map? user) {
                if (user == null) return '-';
                final userInfo = user['userInfo'] as String?;
                if (userInfo != null && userInfo.isNotEmpty) return userInfo;
                final first = user['firstName'] as String? ?? '';
                final last = user['lastName'] as String? ?? '';
                final combined = '$first $last'.trim();
                return combined.isNotEmpty ? combined : '-';
              }

              String _formatEpochMs(dynamic epochMs) {
                if (epochMs == null) return '-';
                final millis = epochMs is int ? epochMs : int.tryParse('$epochMs');
                if (millis == null) return '-';
                final date = DateTime.fromMillisecondsSinceEpoch(millis);
                return '${date.day.toString().padLeft(2, '0')}/'
                    '${date.month.toString().padLeft(2, '0')}/'
                    '${date.year} ${date.hour.toString().padLeft(2, '0')}:'
                    '${date.minute.toString().padLeft(2, '0')}';
              }

              return SlaViolation(
                id: '${v['id'] ?? v['slNo'] ?? '-'}',
                region: locationRegion?['name'] as String? ?? '-',
                location: location?['name'] as String? ?? '-',
                dateOfCreation: _formatEpochMs(v['inputDate']),
                createdBy: _fullName(entrySecurity),
                asl: _fullName(approver),
                typeOfService: (typeOfServiceList ?? const [])
                    .map((t) => (t as Map?)?['name'] as String? ?? '')
                    .where((s) => s.isNotEmpty)
                    .join(', '),
                status: v['statusLabel'] as String? ?? statusLabel,
              );
            }
            return SlaViolation(
              id: '-', region: '-', location: '-', dateOfCreation: '-',
              createdBy: '-', asl: '-', typeOfService: '', status: statusLabel,
            );
          }).toList(),
        ),
      );
    }

    for (final entry in _deploymentForms) {
      if (!entry.isComplete) continue;
      final attendedObjects = _attendedGuardsByEntry[entry.id] ?? const [];
      addShift(
        entry.selectedDutyPost!.name ?? '',
        entry.selectedDesignation!.name ?? '-',
        ShiftDetail(
          shiftLabel: 'SHIFT ${entry.selectedShift!.name ?? '-'}',
          timeRange: _timeRangeForShift(entry.selectedShift!.name ?? ''),
          dutyHours: entry.dutyHoursValue,
          status: 'Draft',
          isSubmitted: false,
          attendedGuards:
          attendedObjects.map((g) => g.name ?? '-').toList(),
          attendedGuardObjects: attendedObjects,
          slaViolations: _slaViolationsByEntry[entry.id] ?? const [],
          entryId: entry.id,
        ),
      );
    }

    return grouped.entries.map((dutyPostEntry) {
      final ranks = dutyPostEntry.value.entries
          .map((rankEntry) => RankGroup(
        rankLabel: 'RANK: ${rankEntry.key.toUpperCase()}',
        shifts: rankEntry.value,
      ))
          .toList();
      return DutyPostGroup(dutyPostLabel: dutyPostEntry.key, ranks: ranks);
    }).toList();
  }

  String _timeRangeForShift(String shiftLabel) {
    final normalized = shiftLabel.toLowerCase().trim();
    if (normalized.contains('a')) return '7AM - 3PM';
    if (normalized.contains('b')) return '3PM - 11PM';
    if (normalized.contains('c')) return '11PM - 7AM';
    return '-';
  }

  Widget _dutyPostAccordion(
      DutyPostGroup group, double height, AdditionalDeploymentsState state) {
    final key = 'dutypost_${group.dutyPostLabel}';
    final isExpanded = !_collapsedSectionKeys.contains(key);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightGreyBackground),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white.withValues(alpha: 0.04),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _accordionHeader(
            avatarText: group.dutyPostLabel.isNotEmpty
                ? group.dutyPostLabel[0]
                : '?',
            title: group.dutyPostLabel,
            isExpanded: isExpanded,
            onTap: () => setState(() {
              if (isExpanded) {
                _collapsedSectionKeys.add(key);
              } else {
                _collapsedSectionKeys.remove(key);
              }
            }),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Column(
                children: [
                  for (final rank in group.ranks) ...[
                    _rankAccordion(rank, height, state),
                    const SizedBox(height: 10),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _rankAccordion(
      RankGroup rank, double height, AdditionalDeploymentsState state) {
    final key = 'rank_${rank.rankLabel}';
    final isExpanded = !_collapsedSectionKeys.contains(key);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightGreyBackground),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white.withValues(alpha: 0.01),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _accordionHeader(
            avatarText: _initialsFor(''),
            title: rank.rankLabel,
            isExpanded: isExpanded,
            onTap: () => setState(() {
              if (isExpanded) {
                _collapsedSectionKeys.add(key);
              } else {
                _collapsedSectionKeys.remove(key);
              }
            }),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Column(
                children: [
                  for (final shift in rank.shifts) ...[
                    _shiftDetailCard(shift, height, state),
                    const SizedBox(height: 10),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }

  String _initialsFor(String rankLabel) {
    final words = rankLabel.replaceFirst('RANK:', '').trim().split(' ');
    if (words.isEmpty) return '?';
    return words.map((w) => w.isNotEmpty ? w[0] : '').join().toUpperCase();
  }

  Widget _accordionHeader({
    required String avatarText,
    required String title,
    required bool isExpanded,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: Colors.white24,
              child: Text(
                avatarText,
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ),
            Icon(
              isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: Colors.white70,
            ),
          ],
        ),
      ),
    );
  }

  // -----------------------------------------------------------------
  // Guards still available to pick for a given draft shift = the full
  // `state.guardsList` (from getAdhocAvailableGuards) minus whoever is
  // already in that shift's Attended list. Matched by id so two guards
  // with the same name don't collide.
  // -----------------------------------------------------------------
  List<Organisation> _availableGuardsFor(
      AdditionalDeploymentsState state, String entryId) {
    final attendedIds = (_attendedGuardsByEntry[entryId] ?? const [])
        .map((g) => g.id)
        .toSet();
    return state.guardsList
        .where((g) => !attendedIds.contains(g.id))
        .toList();
  }

  // Adding a guard via the "AVAILABLE GUARDS" dropdown both (a) puts them
  // in the attended list, and (b) marks their id as "newly added this
  // session" for this entryId — which is what makes "Remove" appear on
  // their row in `_attendedGuardsList`.
  void _onGuardSelected(String entryId, Organisation guard) {
    setState(() {
      _attendedGuardsByEntry.putIfAbsent(entryId, () => []);
      // Guard against picking the same guard twice.
      if (!_attendedGuardsByEntry[entryId]!.any((g) => g.id == guard.id)) {
        _attendedGuardsByEntry[entryId]!.add(guard);
      }
      if (guard.id != null) {
        _newlyAddedGuardIdsByEntry
            .putIfAbsent(entryId, () => <int>{})
            .add(guard.id!);
      }
    });
  }

  // Removing a guard also clears their "newly added" flag for this
  // entryId, so if they're picked again later in the same session they're
  // treated as a fresh add (and still removable, which is correct).
  void _onGuardRemoved(String entryId, Organisation guard) {
    setState(() {
      _attendedGuardsByEntry[entryId]?.removeWhere((g) => g.id == guard.id);
      if (guard.id != null) {
        _newlyAddedGuardIdsByEntry[entryId]?.remove(guard.id);
      }
    });
  }


  Widget _shiftDetailCard(
      ShiftDetail shift, double height, AdditionalDeploymentsState state) {
    final statusColor = shift.isSubmitted ? Colors.green : Colors.red;
    final statusText =
    shift.isSubmitted ? 'Attendance submitted' : shift.status;

     final bool isEditable = shift.entryId != null && !isReadOnly;
    final availableGuards =
    isEditable ? _availableGuardsFor(state, shift.entryId!) : const [];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        // Draft shifts keep the orange outline; once attendance is
        // submitted, switch to the indigo/blue treatment from the mock.
        border: Border.all(
          color: shift.isSubmitted ? const Color(0xFF5B4FCF) : Colors.orange,
        ),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white.withValues(alpha: 0.9),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: Colors.orange.shade100,
                child: Text(
                  shift.shiftLabel.isNotEmpty
                      ? shift.shiftLabel.split(' ').last
                      : '?',
                  style: const TextStyle(color: Colors.black87, fontSize: 11),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(shift.shiftLabel,
                        style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w700,
                            fontSize: 12)),
                    Text('${shift.timeRange} | Duty: ${shift.dutyHours} hrs',
                        style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: 13)),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration:
                    BoxDecoration(color: statusColor, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 4),
                  Text(statusText,
                      style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 12)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          const SizedBox(height: 14),

          const Text('ATTENDANCE MARKING',
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                  letterSpacing: 0.5)),
          const SizedBox(height: 10),

          const Text('AVAILABLE GUARDS',
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                  letterSpacing: 0.5)),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFF3D6DB0)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<Organisation>(
                isExpanded: true,
                value: null,
                hint: Text(
                  availableGuards.isEmpty
                      ? 'No guards available'
                      : 'Select available guard',
                  style: const TextStyle(color: Colors.black38),
                ),
                items: availableGuards
                    .map(
                      (g) => DropdownMenuItem<Organisation>(
                    value: g,
                    child: Text(g.name ?? '-'),
                  ),
                )
                    .toList(),
                onChanged: (!isEditable || availableGuards.isEmpty)
                    ? null
                    : (guard) {
                  if (guard != null) {
                    _onGuardSelected(shift.entryId!, guard);
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 14),

          const Text('ATTENDED',
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                  letterSpacing: 0.5)),
          const SizedBox(height: 6),
          if (isEditable)
            _attendedGuardsList(shift)
          else if (shift.attendedGuards.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 18),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.05),
                border: Border.all(color: Colors.red.withValues(alpha: 0.4)),
                borderRadius: BorderRadius.circular(6),
              ),
              alignment: Alignment.center,
              child: const Text('No attended guards marked yet',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
            )
          else
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: shift.attendedGuards
                  .map((g) =>
                  Chip(label: Text(g), backgroundColor: Colors.green.shade50))
                  .toList(),
            ),
          const SizedBox(height: 16),
    //
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           const Text('SLA VIOLATION LIST',
    //               style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
    //           if (isEditable)
    //             InkWell(
    //                 onTap: () {
    //                   FocusScope.of(context).unfocus();
    // _syncAllDeploymentEditsToCubit();
    //                   _lastSubmitWasSaveOnly = true;
    //                   BlocProvider.of<AdditionalDeploymentsCubit>(context)
    //                       .submitForm(isSaveOnly: true);
    //
    //                   Navigator.pushNamed(
    //                     context,
    //                     slaViolationPenaltyDetailsRoute,
    //                     arguments: {
    //                       ConstantsArgument.title: Constants.slaViolationPenaltyTitle,
    //                       ConstantsArgument.attdId: state.model.id,
    //                       ConstantsArgument.location: widget.location,
    //                       ConstantsArgument.locationRegion: widget.locationRegion,
    //                       ConstantsArgument.vendor: state.model.vendor,
    //
    //                     },
    //                   ).then((_) => BlocProvider.of<AdditionalDeploymentsCubit>(context)
    //                       .initializeValues());
    //                   log('Returned from SLA screen — refreshing AdditionalDeploymentsCubit');
    //                 },
    //                 child: Row(
    //                   children: <Widget>[
    //                     const SizedBox(width: 14),
    //                     SvgPicture.asset(
    //                       AppIcon.plusCircle,
    //                       colorFilter: const ColorFilter.mode(
    //                         AppColors.black,
    //                         BlendMode.srcIn,
    //                       ),
    //                     ),
    //                     const SizedBox(width: 10),
    //                     const Text(
    //                       'Add SLA Violation',
    //                       style: TextStyle(
    //                         color: AppColors.black,
    //                         decoration: TextDecoration.underline,
    //                         decorationColor: AppColors.black,
    //                       ),
    //                     ),
    //                     CommonWidgets.verticalSpacerWidget(
    //                         MediaQuery.of(context).size.height * 0.08),
    //                   ],
    //                 )
    //              ),
    //         ],
    //       ),
          const SizedBox(height: 8),

          // ---------------------------------------------------------
          // SLA violations for this shift, each rendered as its own
          // collapsible detail card (see _slaViolationCard below).
          // ---------------------------------------------------------
          if (shift.slaViolations.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(6),
              ),
              alignment: Alignment.center,
              child: const Text('No SLA violations added yet',
                  style: TextStyle(color: Colors.black45)),
            )
          else
            Column(
              children: shift.slaViolations
                  .map((v) => _slaViolationCard(v))
                  .toList(),
            ),
        ],
      ),
    );
  }

  Widget _slaViolationCard(SlaViolation v) {
    final isCollapsed = _collapsedSlaIds.contains(v.id);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                if (isCollapsed) {
                  _collapsedSlaIds.remove(v.id);
                } else {
                  _collapsedSlaIds.add(v.id);
                }
              });
            },
            child: Container(
              width: double.infinity,
              color: const Color(0xFF3D6DB0),
              padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: v.typeOfService,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                          TextSpan(
                            text: '   ${v.status}   ${v.dateOfCreation}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    isCollapsed
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up,
                    color: Colors.white,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
          if (!isCollapsed)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: _readOnlyField(label: 'ID', value: v.id)),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _readOnlyField(
                              label: 'REGION', value: v.region)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: _readOnlyField(
                              label: 'LOCATION', value: v.location)),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _readOnlyField(
                              label: 'DATE OF CREATION',
                              value: v.dateOfCreation)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: _readOnlyField(
                              label: 'CREATED BY', value: v.createdBy)),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _readOnlyField(label: 'ASL', value: v.asl)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: _readOnlyField(
                              label: 'TYPE OF SERVICE',
                              value: v.typeOfService)),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _readOnlyField(
                              label: 'STATUS', value: v.status)),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // Renders the ATTENDED list for an editable shift (Draft OR Attendance
  // submitted).
  //
  // "Remove" now shows PER GUARD based solely on whether that guard's id
  // is in `_newlyAddedGuardIdsByEntry[shift.entryId]` — i.e. whether the
  // guard was added via the "AVAILABLE GUARDS" dropdown during THIS
  // session. Guards seeded from the API (already attended before the
  // screen opened) never get "Remove", even on a Draft shift. This
  // replaces the old `!shift.isSubmitted` check, which incorrectly tied
  // "Remove" to the shift's overall status rather than to the individual
  // guard's origin.
  Widget _attendedGuardsList(ShiftDetail shift) {
    if (shift.attendedGuardObjects.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: Colors.red.withValues(alpha: 0.05),
          border: Border.all(color: Colors.red.withValues(alpha: 0.4)),
          borderRadius: BorderRadius.circular(6),
        ),
        alignment: Alignment.center,
        child: const Text('No attended guards marked yet',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
      );
    }

    final Set<int> newlyAddedIds =
        _newlyAddedGuardIdsByEntry[shift.entryId] ?? const <int>{};

    return Column(
      children: shift.attendedGuardObjects.map((guard) {
        final name = guard.name ?? '-';
        final bool canRemove =
            guard.id != null && newlyAddedIds.contains(guard.id);

        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: const Color(0xFFEDE9FE),
                child: Text(
                  name.isNotEmpty ? name[0].toUpperCase() : '?',
                  style: const TextStyle(
                    color: Color(0xFF5B4FCF),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                            fontSize: 13)),
                    Text(
                      canRemove ? 'ADHOC' : 'ATTENDANCE SUBMITTED',
                      style: const TextStyle(
                          color: Color(0xFFB05A1D),
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                          letterSpacing: 0.5),
                    ),
                  ],
                ),
              ),
              if (canRemove)
                OutlinedButton(
                  onPressed: () => _onGuardRemoved(shift.entryId!, guard),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    minimumSize: const Size(0, 32),
                  ),
                  child: const Text('Remove',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget cancelButtonDisplay() {
    return AppButton(
      width: Constants.cancelButtonWidth,
      backgroundColor: Colors.white,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.close,
      buttonTextKey: Keys.cancelButton,
      onTap: () {
        Navigator.pop(context);
        CommonServices().unlock();
      },
    );
  }


}