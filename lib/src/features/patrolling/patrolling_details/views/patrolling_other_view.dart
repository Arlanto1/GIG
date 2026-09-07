
import 'dart:developer';
import 'dart:ui';
import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/patrolling/models/patrolling_model.dart';
import 'package:db_atom/src/features/patrolling/models/patrolling_other_model.dart';
import 'package:db_atom/src/features/patrolling/patrolling_details/cubit/patrolling_details_cubit.dart';

class PatrollingOtherView extends StatefulWidget {
  final PatrollingOtherModel? otherModel;
  final String title;
  final ExtraProperties? extraProperties;
  final PatrollingModel? model;

  const PatrollingOtherView({
    super.key,
    this.otherModel,
    required this.title,
    this.extraProperties,
    this.model,
  });

  @override
  State<PatrollingOtherView> createState() => _PatrollingOtherViewState();
}

class _PatrollingOtherViewState extends State<PatrollingOtherView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isReadOnly = false;
  bool showSaveSubmitButton = false;
  // ── Per-item controllers keyed by item index ──────────────────────────────
  final Map<int, TextEditingController> _remarksControllers = {};
  final Map<int, TextEditingController> _actionOwnerControllers = {};
  final Map<int, TextEditingController> _dbSponsorControllers = {};
  final Map<int, TextEditingController> _severityControllers = {};
  final Map<int, TextEditingController> _ownerControllers = {};
  final Map<int, TextEditingController> _ownerRemarksControllers = {};
  final Map<int, TextEditingController> _etaDateControllers = {};
  final Map<int, TextEditingController> _progressStatusControllers = {};
  final Map<int, TextEditingController> _reviewCommentControllers = {};
  final Map<int, TextEditingController> _reviewStatusControllers = {};
  // ── Action Owner combined field (text + dropdown-arrow) state ─────────────
  final Map<int, FocusNode> _actionOwnerFocusNodes = {};
  final Map<int, LayerLink> _actionOwnerLayerLinks = {};
  OverlayEntry? _ownerDropdownOverlay;
  int? _openDropdownIndex;

  // ── DB Sponsor combined field (text + dropdown-arrow) state ───────────────
  final Map<int, FocusNode> _dbSponsorFocusNodes = {};
  final Map<int, LayerLink> _dbSponsorLayerLinks = {};
  OverlayEntry? _dbSponsorDropdownOverlay;
  int? _openDbSponsorDropdownIndex;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<PatrollingDetailsCubit>(context)
          .updateGetOtherInfoModelValue(
        widget.model?.id?.toString(),
        widget.otherModel?.subsectionId?.toString(),
      );
    });
  }

  @override
  void dispose() {
    for (final c in _remarksControllers.values) {
      c.dispose();
    }
    for (final c in _actionOwnerControllers.values) {
      c.dispose();
    }
    for (final c in _dbSponsorControllers.values) {
      c.dispose();
    }
    for (final c in _severityControllers.values) {
      c.dispose();
    }
    for (final c in _ownerControllers.values) {
      c.dispose();
    }
    for (final c in _ownerRemarksControllers.values) {
      c.dispose();
    }
    for (final c in _etaDateControllers.values) {
      c.dispose();
    }
    for (final f in _actionOwnerFocusNodes.values) {
      f.dispose();
    }
    _ownerDropdownOverlay?.remove();
    _ownerDropdownOverlay = null;

    for (final f in _dbSponsorFocusNodes.values) {
      f.dispose();
    }
    _dbSponsorDropdownOverlay?.remove();
    _dbSponsorDropdownOverlay = null;

    super.dispose();
  }

  /// Helpers

  String _severityLabel(int? severity) {
    final match = severityDropDown.firstWhere(
          (label) => label.value == severity?.toString(),
      orElse: () => const Label(key: '', value: ''),
    );
    return match.key;
  }

  String _ownerValueFromKey(String? ownerTypeKey) {
    if (ownerTypeKey == null || ownerTypeKey.isEmpty) return '';
    final match = ownerDropDownValues.firstWhere(
          (label) => label.key == ownerTypeKey,
      orElse: () => const Label(key: '', value: ''),
    );
    return match.value;
  }

  String _etaToDisplay(String? eta) {
    if (eta == null || eta.isEmpty) return '';
    final parsed = int.tryParse(eta);
    if (parsed == null) return eta;
    return Utils.timestampToDateConversion(parsed, Constants.fulldateFormat);
  }

  // Maps the review-status int (1 = approve, 2 = reject, etc.) to its
  // display label from the same lookup pattern used for severity/progress.
  String _reviewStatusLabel(int? reviewStatus) {
    if (reviewStatus == null) return '';
    switch (reviewStatus) {
      case 1:
        return 'Approved';
      case 2:
        return 'Rejected';
      default:
        return reviewStatus.toString();
    }
  }

  // ── Attachment type filters ────────────────────────────────────────────────
  // Guard section attachments are tagged type == 1, Owner/DB Sponsor section
  // attachments are tagged type == 2. Both sections previously read from the
  // full `item.attachments` list unfiltered, which is why the same files
  // showed up under both "Attachments" blocks. These helpers restrict each
  // section to only its own type, and are now actually used below.
  List<ImageContent> _guardAttachments(Items item) =>
      (item.attachments ?? []).where((a) => a.type == 1).toList();

  List<ImageContent> _ownerAttachments(Items item) =>
      (item.attachments ?? []).where((a) => a.type == 2).toList();


  /// Controller lifecycle

  void _ensureControllers(int i, Items item) {
    _remarksControllers.putIfAbsent(
        i, () => TextEditingController(text: item.remarks ?? ''));

    _actionOwnerControllers.putIfAbsent(
        i,
            () => TextEditingController(
            text: item.actionOwner?.email ?? ''));

    _dbSponsorControllers.putIfAbsent(
        i, () => TextEditingController(text: item.dbSponsor?.email ?? ''));

    _severityControllers.putIfAbsent(
        i, () => TextEditingController(text: _severityLabel(item.severity)));

    _ownerControllers.putIfAbsent(
        i, () => TextEditingController(text: item.ownerType ?? ''));

    _ownerRemarksControllers.putIfAbsent(
        i, () => TextEditingController(text: item.ownerUpdates ?? ''));

    _reviewCommentControllers.putIfAbsent(
        i, () => TextEditingController(text: item.reviewComment ?? ''));

    // FIX: item.reviewStatus is an int? (elsewhere it's set via
    // `item.reviewStatus = 1` / `= val`), so `item.reviewStatus ?? ''` was
    // mixing int? with String, which Dart widens to Object — not assignable
    // to TextEditingController's String? `text` parameter. Convert to a
    // display string first.
    _reviewStatusControllers.putIfAbsent(
        i,
            () =>
            TextEditingController(text: _reviewStatusLabel(item.reviewStatus)));

    _etaDateControllers.putIfAbsent(
        i, () => TextEditingController(text: _etaToDisplay(item.eta)));

    _actionOwnerFocusNodes.putIfAbsent(i, () => FocusNode());
    _actionOwnerLayerLinks.putIfAbsent(i, () => LayerLink());

    _dbSponsorFocusNodes.putIfAbsent(i, () => FocusNode());
    _dbSponsorLayerLinks.putIfAbsent(i, () => LayerLink());
  }

  void _syncControllers(int i, Items item) {
    final remarks = item.remarks ?? '';
    if (_remarksControllers[i]!.text != remarks) {
      _remarksControllers[i]!.text = remarks;
    }

    final owner = item.ownerUpdates ?? '';
    if (_ownerControllers[i]!.text != owner) {
      _ownerControllers[i]!.text = owner;
    }

    final severity = _severityLabel(item.severity);
    if (_severityControllers[i]!.text != severity) {
      _severityControllers[i]!.text = severity;
    }

    final actionOwner =
        item.actionOwner?.email ?? '';
    if (actionOwner.isNotEmpty &&
        _actionOwnerControllers[i]!.text != actionOwner) {
      _actionOwnerControllers[i]!.text = actionOwner;
    }

    final dbSponsor = item.dbSponsor?.email ?? '';
    if (dbSponsor.isNotEmpty && _dbSponsorControllers[i]!.text != dbSponsor) {
      _dbSponsorControllers[i]!.text = dbSponsor;
    }
    final ownerRemarks = item.ownerUpdates ?? '';
    if (_ownerRemarksControllers[i]!.text != ownerRemarks) {
      _ownerRemarksControllers[i]!.text = ownerRemarks;
    }

    // Keep the review-status text field in sync with the underlying int,
    // same fix as in _ensureControllers — always go through the label
    // helper so we never assign a non-String value.
    final reviewStatus = _reviewStatusLabel(item.reviewStatus);
    if (_reviewStatusControllers[i]!.text != reviewStatus) {
      _reviewStatusControllers[i]!.text = reviewStatus;
    }

    final reviewComment = item.reviewComment ?? '';
    if (_reviewCommentControllers[i]!.text != reviewComment) {
      _reviewCommentControllers[i]!.text = reviewComment;
    }

    final eta = _etaToDisplay(item.eta);
    if (_etaDateControllers[i]!.text != eta) {
      _etaDateControllers[i]!.text = eta;
    }
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double height = size.height;

    return BlocConsumer<PatrollingDetailsCubit, PatrollingDetailsState>(
      listener: (context, state) {
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);
        if (state.status == FormStatus.success) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (dialogContext) => CustomAlertDialog(
              title: Constants.generalInfo,
              message: state.message ?? '',
              positiveBtnText: Constants.ok,
              onPositivePressed: () {
                Navigator.of(dialogContext).pop();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  patrollingListCardRoute,
                      (route) => false,
                  arguments: {
                    ConstantsArgument.title: Constants.patrolling,
                    'model': state.model,
                  },
                );
              },
            ),
          );
        }
      },

      builder: (context, state) {
        if (state.model.status == null ||state.model.status == 0)
          isReadOnly = false;
        // showSaveSubmitButton =
        //     state.model.status != 9 && state.model.lock.isEmptyOrNull;
        // final items = state.otherModel.items ?? [];
        // showSaveSubmitButton = items.
        final items = state.otherModel.items ?? [];
        final bool hasEditableField = state.otherModel.status == 0 ||
            items.any((item) =>
            item.canEditGuardFields == true ||
                item.canEditLsmFields == true ||
                item.canEditOwnerFields == true ||
                item.canEditEta == true ||
                item.canReview == true);

        log('showSaveSubmitButton ${showSaveSubmitButton}');
        showSaveSubmitButton = hasEditableField;
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.title,
            showPopUp: false,
            showSaveButton:
            (showSaveSubmitButton) && state.model.lock.isEmptyOrNull,
            // =
            //     state.model.lock.isEmptyOrNull &&
            //     items.any((item) => item.canEditOwnerFields == true || item.canEditLsmFields == true),
            showSubmitButton: false,
            showDisLikeButton: false,
            showLikeButton: false,
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<PatrollingDetailsCubit>(context).submitForm(
                isSaveOnly: false,
                id: widget.model?.id?.toString(),
                subId: state.otherModel.subsectionId?.toString(),
              );
            },
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<PatrollingDetailsCubit>(context).submitForm(
                isSaveOnly: false,
                id: widget.model?.id?.toString(),
                subId: state.otherModel.subsectionId?.toString(),
              );
            },
          ),
          backgroundColor: AppColors.newColor,
          body: getBodyBuilder(context, state, height),
        );
      },
    );
  }

  // ── Body ───────────────────────────────────────────────────────────────────

  Widget getBodyBuilder(
      BuildContext context, PatrollingDetailsState state, double height) {
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }
    final items = state.otherModel.items ?? [];

    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('assets/images/bg2.png', fit: BoxFit.cover),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
            child: Container(
              color: Colors.black.withValues(alpha: 0.08),
            ),
          ),
        ),
        SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: isReadOnly
                ? AutovalidateMode.disabled
                : AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!state.model.lock.isEmptyOrNull)
                        RecordLockedWidget(text: '${state.model.lock}'),
                      CommonWidgets.verticalSpacerWidget(height * 0.04),
                      Column(
                        children: items.asMap().entries.map((entry) {
                          final i = entry.key;
                          final item = entry.value;
                          _ensureControllers(i, item);
                          _syncControllers(i, item);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: _buildItemRow(
                              context: context,
                              state: state,
                              index: i,
                              item: item,
                              height: height,
                            ),
                          );
                        }).toList(),
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.03),
                    ],
                  ),
                ),
                CommonWidgets.verticalSpacerWidget(height * 0.02),
                if ((showSaveSubmitButton) && state.model.lock.isEmptyOrNull)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _cancelButton(),
                      _submitButton(state),
                    ],
                  ),
                if ((showSaveSubmitButton && state.model.lock.isEmptyOrNull) ? false :true)
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Center(child: _cancelButton()),
                  ),
                CommonWidgets.verticalSpacerWidget(height * 0.03),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Item Row

  Widget _buildItemRow({
    required BuildContext context,
    required PatrollingDetailsState state,
    required int index,
    required Items item,
    required double height,
  }) {
    final bool isDisabled =
         state.otherModel.status != 0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        border: Border.all(color: Colors.white.withValues(alpha: 0.45)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Question row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Sequence badge
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.newColor.withValues(alpha: 0.22),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                /// Question text
                Expanded(
                  child: Text(
                    item.question ?? '',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.5,
                    ),
                  ),
                ),

                CommonWidgets.verticalSpacerWidget(height * 0.02),

                /// Yes / No radio chips
                _RadioYesNo(
                  value: item.response,
                  isReadOnly: isDisabled,
                  onChanged: (val) {
                    setState(() => item.response = val);
                    BlocProvider.of<PatrollingDetailsCubit>(context)
                        .onItemChanged(state.otherModel);
                  },
                ),
                CommonWidgets.verticalSpacerWidget(height * 0.02),
              ],
            ),
          ),

          // Expanded content shown only when response == 2 ("No")
          if (item.response == 2)
            _buildExpandedContent(
              context: context,
              state: state,
              index: index,
              item: item,
              height: height,
              isDisabled: isDisabled,
            ),
        ],
      ),
    );
  }

  /// Expanded Content

  Widget _buildExpandedContent({
    required BuildContext context,
    required PatrollingDetailsState state,
    required int index,
    required Items item,
    required double height,
    required bool isDisabled,
  }) {
    log('item.ownerType ${item.ownerType}');
    log('item.ownerUpdates1 ${item.ownerUpdates}');
    log('item.attachments123 ${item.attachments?.length}');

    final statusController = buildDropdownController(
      index: index,
      controllerMap: _progressStatusControllers,
      items: progressStatus,
      value: item.progressStatus?.toString(),
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.02),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(14),
          bottomRight: Radius.circular(14),
        ),
        border: Border(
          top: BorderSide(
            color: Colors.white.withValues(alpha: 0.0),
            width: 0.5,
          ),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Guard Remarks
          CommonWidgets.textDisplay(
            Constants.guardRemarks,
            isMandatory: true,
            Styles.textStyleWhite14,
          ),
          FlutterInputField(
            textInputType: TextInputType.text,
            textFormKey: Keys.challanKey,
            controller: _remarksControllers[index]!,
            characterLimit: Constants.characterLimitIdTextFormField,
            hintText: '',
            isEnable:
            state.otherModel.status == 0 || item.canEditGuardFields == true,
            isDisableColor: state.otherModel.status != 0 &&
                item.canEditGuardFields == false,
            onChange: (String value) {
              item.remarks = value;
              BlocProvider.of<PatrollingDetailsCubit>(context)
                  .onItemChanged(state.otherModel);
            },
            validateTextField: (String? user) {},
          ),
          CommonWidgets.verticalSpacerWidget(height * 0.02),

          /// Attachments (Guard) — type == 1 only.
          CommonWidgets.textDisplay(
            Constants.attachments,
            isMandatory: false,
            Styles.textStyleWhite14,
          ),
          BaseImageUpload().uploadWidget(
            context: context,
            isDisabled:
            state.otherModel.status != 0 && item.canEditGuardFields == false,
            loggedInUserDetails: state.loggedInUserDetails ?? User(),
            getFiles: _guardAttachments(item),
            onImageSelected: (ImageContent data) {
              // Tag new uploads from this section as guard-type (1) so they
              // are correctly filtered into the guard list and not shown
              // under Owner/DB Sponsor attachments.
              data.type = 1;
              final current = List<ImageContent>.from(item.attachments ?? []);
              current.insert(0, data);
              setState(() => item.attachments = current);
              BlocProvider.of<PatrollingDetailsCubit>(context)
                  .addAttachment(files: current, itemIndex: index);
            },
          ),
          if (_guardAttachments(item).isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: BaseImageUpload().getAttachment(
                height: height,
                attachments: _guardAttachments(item),
                files: _guardAttachments(item),
                moduleCode: '',
                isDisabled: false,
                showDeleteIcon:   state.otherModel.status == 0 || item.canEditGuardFields == true,
                // Guard block
                onDelete: (deleteIndex, imageData) {
                  context.read<PatrollingDetailsCubit>().removeAttachment(
                    itemIndex: index,
                    imageToRemove: imageData,
                  );
                },
              ),
            ),
          CommonWidgets.verticalSpacerWidget(height * 0.02),

          if (state.otherModel.status != null &&
              state.otherModel.status != 0) ...[
            /// Owner dropdown
            CommonWidgets.textDisplay(
              Constants.owner,
              isMandatory: true,
              Styles.textStyleWhite14,
            ),
            BaseDropDown().getDropDown(
              isDisabled: item.canEditLsmFields == false,
              textController: _ownerControllers[index]!,
              items: ownerDropDownValues,
              initialValue: _ownerValueFromKey(item.ownerType),
              onTap: () {
                if (item.canEditLsmFields == true) {
                  BaseDropDown().assetTypeDialog(
                      context: context,
                      dropDownValues: ownerDropDownValues
                          .map((label) => label.key)
                          .toList(),
                      onTap: (String value) async {
                        final selectedLabel = ownerDropDownValues.firstWhere(
                              (label) => label.key == value,
                          orElse: () => const Label(key: '', value: ''),
                        );

                        setState(() {
                          item.ownerType = selectedLabel.key;
                          _ownerControllers[index]!.text = selectedLabel.key;
                        });

                        ///  CALL API HERE
                        await context.read<PatrollingDetailsCubit>().getOwnerUsers(
                            state.otherModel.locationId!, selectedLabel.key);

                        /// optional: clear previous selection
                        setState(() {
                          item.actionOwnerName = null;
                          _actionOwnerControllers[index]!.clear();
                        });
                      });
                }
              },
            ),
            CommonWidgets.verticalSpacerWidget(height * 0.02),

            /// Severity dropdown
            CommonWidgets.textDisplay(
              Constants.severity,
              isMandatory: true,
              Styles.textStyleWhite14,
            ),
            BaseDropDown().getDropDown(
              isDisabled: item.canEditLsmFields == false,
              textController: _severityControllers[index]!,
              items: severityDropDown,
              initialValue: '${item.severity}',
              onTap: () {
                if (item.canEditLsmFields == true) {
                  BaseDropDown().assetTypeDialog(
                    context: context,
                    dropDownValues:
                    severityDropDown.map((label) => label.key).toList(),
                    onTap: (String value) {
                      final selectedLabel = severityDropDown.firstWhere(
                            (label) => label.key == value,
                        orElse: () => const Label(key: '', value: ''),
                      );
                      setState(() {
                        item.severity = int.tryParse(selectedLabel.value);
                        _severityControllers[index]!.text = selectedLabel.key;
                      });
                      BlocProvider.of<PatrollingDetailsCubit>(context)
                          .onItemChanged(state.otherModel);
                    },
                  );
                }
              },
            ),
            CommonWidgets.verticalSpacerWidget(height * 0.02),

            /// Action Owner — combined free-text field + dropdown-arrow full list
            CommonWidgets.textDisplay(
              Constants.actionOwner,
              isMandatory: true,
              Styles.textStyleWhite14,
            ),
            _buildActionOwnerField(
              context: context,
              state: state,
              index: index,
              item: item,
            ),
            CommonWidgets.verticalSpacerWidget(height * 0.02),
          ],

          if (state.otherModel.status != null &&
              state.otherModel.status != 0 &&
              state.otherModel.status != 1) ...[
            /// ETA
            CommonWidgets.textDisplay(
              Constants.eta,
              isMandatory: true,
              Styles.textStyleWhite14,
            ),
            BaseDate().datePickerWidgetLoading(
              textController: _etaDateControllers[index]!,
              isDisabled: item.canEditEta == false,
              onlyDate: false,
              showPastDate: false,
              showFutureDate: true,
              onChange: (String value) {
                _etaDateControllers[index]!.text = value;
                item.eta = Utils().formatTime(value);
                BlocProvider.of<PatrollingDetailsCubit>(context)
                    .onItemChanged(state.otherModel);
              },
              context: context,
            ),
            CommonWidgets.verticalSpacerWidget(height * 0.02),

            /// Status
            CommonWidgets.textDisplay(
              Constants.status,
              isMandatory: true,
              Styles.textStyleWhite14,
            ),
            CommonWidgets.verticalSpacerWidget(height * 0.002),
            BaseDropDown().getDropDown(
              isDisabled: item.canEditOwnerFields == false,
              textController: statusController,
              items: progressStatus,
              initialValue: item.progressStatus?.toString(),
              onTap: () {
                if (item.canEditOwnerFields == true) {
                  BaseDropDown().assetTypeDialog(
                    context: context,
                    labelDropDownValue: progressStatus,
                    onTap: (selectedValue) {
                      final selectedLabel = progressStatus.firstWhere(
                            (e) => e.key == selectedValue,
                      );
                      setState(() {
                        statusController.text = selectedLabel.key;
                        item.progressStatus =
                            int.tryParse(selectedLabel.value.toString());
                      });
                    },
                  );
                }
              },
            ),
            CommonWidgets.verticalSpacerWidget(height * 0.02),

            /// Owner Remarks
            CommonWidgets.textDisplay(
              Constants.ownerRemarks,
              isMandatory: true,
              Styles.textStyleWhite14,
            ),
            FlutterInputField(
              textInputType: TextInputType.text,
              textFormKey: Keys.challanKey,
              controller: _ownerRemarksControllers[index]!,
              characterLimit: Constants.characterLimitIdTextFormField,
              hintText: '',
              isEnable: item.canEditOwnerFields == true,
              isDisableColor: item.canEditOwnerFields == false,
              onChange: (String value) {
                item.ownerUpdates = value;
                BlocProvider.of<PatrollingDetailsCubit>(context)
                    .onItemChanged(state.otherModel);
              },
              validateTextField: (String? user) {},
            ),
            CommonWidgets.verticalSpacerWidget(height * 0.02),

            /// DB Sponsor — combined free-text field + dropdown-arrow full list
            CommonWidgets.textDisplay(
              Constants.dbSponsor,
              isMandatory: true,
              Styles.textStyleWhite14,
            ),
            _buildDbSponsorField(
              context: context,
              state: state,
              index: index,
              item: item,
            ),
            CommonWidgets.verticalSpacerWidget(height * 0.02),

            /// Attachments (Owner / DB Sponsor) — type == 2 only.
            CommonWidgets.textDisplay(
              Constants.attachments,
              isMandatory: true,
              Styles.textStyleWhite14,
            ),
            BaseImageUpload().uploadWidget(
              context: context,
              isDisabled: item.canEditOwnerFields == false,
              loggedInUserDetails: state.loggedInUserDetails ?? User(),
              getFiles: _ownerAttachments(item),
              onImageSelected: (ImageContent data) {
                // Tag new uploads from this section as owner-type (2) so
                // they are correctly filtered into the owner list and not
                // shown under the Guard attachments above.
                data.type = 2;
                final current = List<ImageContent>.from(item.attachments ?? []);
                current.insert(0, data);
                setState(() => item.attachments = current);
                BlocProvider.of<PatrollingDetailsCubit>(context)
                    .addAttachment(files: current, itemIndex: index);
              },
            ),
            if (_ownerAttachments(item).isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: BaseImageUpload().getAttachment(
                  height: height,
                  attachments: _ownerAttachments(item),
                  files: _ownerAttachments(item),
                  moduleCode: '',
                  isDisabled: false,
                  showDeleteIcon: item.canEditOwnerFields == true,
                  onDelete: (deleteIndex, imageData) {
                    context.read<PatrollingDetailsCubit>().removeAttachment(
                      itemIndex: index,
                      imageToRemove: imageData,
                    );
                  },
                ),
              ),
            CommonWidgets.verticalSpacerWidget(height * 0.02),
          ],

          // ── Review Section ──────────────────────────────────────────────
          // FIX: previously this whole block (thumbs-up/down AND the
          // status==5 review-status/comment fields) was nested inside a
          // parent `if` that required `status == 3`. Since the inner check
          // required `status == 5`, that combination could never be true —
          // review status/comment were unreachable dead code. Now the
          // parent allows either 3 or 5, and each sub-section is gated to
          // its own specific status so both actually render when expected.
          if (state.otherModel.status != null &&
              state.otherModel.status != 0 &&
              state.otherModel.status != 1 &&
              state.otherModel.status != 2 &&
              (state.otherModel.status == 3 ||
                  state.otherModel.status == 5)) ...[
            if (state.otherModel.status == 3) ...[
              /// Review label
              CommonWidgets.textDisplay(
                Constants.review,
                isMandatory: true,
                Styles.textStyleWhite14,
              ),
              const SizedBox(height: 12),

              /// Thumbs Up / Thumbs Down
              Row(
                children: [
                  // ── Approve ──
                  _ThumbButton(
                    icon: Icons.thumb_up_alt_rounded,
                    label: 'Approve',
                    isSelected: item.reviewStatus == 1,
                    selectedColor: const Color(0xFF2E7D32),
                    isDisabled: item.canReview == false,
                    // onTap: () {
                    //   if (item.canReview == true) {
                    //     setState(() => item.reviewStatus = 1);
                    //     BlocProvider.of<PatrollingDetailsCubit>(context)
                    //         .onItemChanged(state.otherModel);
                    //     BlocProvider.of<PatrollingDetailsCubit>(context)
                    //         .submitForm(
                    //       isSaveOnly: true,
                    //       id: state.model.id?.toString(),
                    //       subId: state.otherModel.subsectionId?.toString(),
                    //     );
                    //
                    //
                    //     WidgetsBinding.instance.addPostFrameCallback((_) {
                    //       if (context.mounted) {
                    //         Navigator.of(context).pushNamed(patrollingListCardRoute);
                    //       }
                    //     });
                    //   }
                    // },
                    onTap: () async {
                      if (item.canReview == true) {
                        setState(() => item.reviewStatus = 1);

                        BlocProvider.of<PatrollingDetailsCubit>(context)
                            .onItemChanged(state.otherModel);

                        bool isSaveSuccess = await BlocProvider.of<PatrollingDetailsCubit>(context)
                            .submitForm(
                          isSaveOnly: true,
                          id: state.model.id?.toString(),
                          subId: state.otherModel.subsectionId?.toString(),
                        );

                        if (!context.mounted) return;

                        if (isSaveSuccess) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (context.mounted) {
                              Navigator.of(context).pushNamed(patrollingListRoute);
                            }
                          });
                        }
                      }
                    },
                  ),
                  const SizedBox(width: 12),

                  // ── Reject ──
                  _ThumbButton(
                    icon: Icons.thumb_down_alt_rounded,
                    label: 'Reject',
                    isSelected: item.reviewStatus == 2,
                    selectedColor: const Color(0xFFC62828),
                    isDisabled: item.canReview == false,
                    onTap: () {
                      if (item.canReview == true) {
                        final parentContext = context; // Save correct context

                        TextEditingController commentController =
                        TextEditingController();

                        showDialog(
                          context: parentContext,
                          barrierDismissible: false,
                          barrierColor: Colors.black.withValues(alpha: 0.4),
                          builder: (dialogContext) {
                            return Dialog(
                              backgroundColor: Colors.transparent,
                              insetPadding:
                              const EdgeInsets.symmetric(horizontal: 24),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: BackdropFilter(
                                  filter:
                                  ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 20, 20, 12),
                                    decoration: BoxDecoration(
                                      color:
                                      Colors.black.withValues(alpha: 0.45),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: Colors.white
                                            .withValues(alpha: 0.15),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        // ── Title, matching "General Info" style ──
                                        const Text(
                                          "Enter Review Comment",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 16),

                                        // ── Comment field ──
                                        TextField(
                                          controller: commentController,
                                          maxLines: 3,
                                          style: const TextStyle(
                                              color: Colors.white),
                                          cursorColor: Colors.white,
                                          decoration: InputDecoration(
                                            hintText: "Enter comment",
                                            hintStyle: TextStyle(
                                              color: Colors.white
                                                  .withValues(alpha: 0.5),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white
                                                .withValues(alpha: 0.06),
                                            contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 10,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                                color: Colors.white
                                                    .withValues(alpha: 0.25),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(8),
                                              borderSide: const BorderSide(
                                                  color: Colors.white),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),

                                        // ── Actions, right-aligned like "Ok" in the reference image ──
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(dialogContext);
                                              },
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withValues(alpha: 0.7),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                if (commentController.text.trim().isEmpty) {
                                                  ScaffoldMessenger.of(parentContext).showSnackBar(
                                                    const SnackBar(content: Text("Comment is required")),
                                                  );
                                                  return;
                                                }

                                                setState(() {
                                                  item.reviewStatus = 2;
                                                  item.reviewComment = commentController.text.trim();
                                                });

                                                final cubit = BlocProvider.of<PatrollingDetailsCubit>(parentContext);
                                                cubit.onItemChanged(state.otherModel);
                                                cubit.submitForm(
                                                  isSaveOnly: false,
                                                  id: state.model.id?.toString(),
                                                  subId: state.otherModel.subsectionId?.toString(),
                                                );

                                                Navigator.pop(dialogContext); // close the comment dialog

                                                Navigator.of(context).pushNamedAndRemoveUntil(
                                                  dashboardViewRoute,
                                                      (route) => false,
                                                );

                                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                                  if (context.mounted) {
                                                    Navigator.of(context).pushNamed(patrollingListRoute);
                                                  }
                                                });
                                              },
                                              child: const Text(
                                                "OK",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
              CommonWidgets.verticalSpacerWidget(height * 0.02),
            ],

            if (state.otherModel.status == 5) ...[
              /// Review Status
              CommonWidgets.textDisplay(
                Constants.reviewStatus,
                isMandatory: true,
                Styles.textStyleWhite14,
              ),
              FlutterInputField(
                textInputType: TextInputType.text,
                textFormKey: Keys.challanKey,
                controller: _reviewStatusControllers[index],
                characterLimit: Constants.characterLimitIdTextFormField,
                hintText: '',
                isEnable: false,
                isDisableColor: true,
                onChange: (String value) {
                  // Read-only display field — no user-driven change to
                  // persist, this callback exists only to satisfy the
                  // FlutterInputField API.
                },
                validateTextField: (String? user) {},
              ),
              CommonWidgets.verticalSpacerWidget(height * 0.02),

              /// Review Comment
              CommonWidgets.textDisplay(
                Constants.reviewComment,
                isMandatory: true,
                Styles.textStyleWhite14,
              ),
              FlutterInputField(
                textInputType: TextInputType.text,
                textFormKey: Keys.challanKey,
                controller: _reviewCommentControllers[index],
                characterLimit: Constants.characterLimitIdTextFormField,
                hintText: '',
                isEnable: item.canReview == true,
                isDisableColor: item.canReview == false,
                onChange: (String value) {
                  item.reviewComment = value;
                  BlocProvider.of<PatrollingDetailsCubit>(context)
                      .onItemChanged(state.otherModel);
                },
                validateTextField: (String? user) {},
              ),
              CommonWidgets.verticalSpacerWidget(height * 0.02),
            ],
          ],
        ],
      ),
    );
  }

  TextEditingController buildDropdownController({
    required int index,
    required Map<int, TextEditingController> controllerMap,
    required List<Label> items,
    required String? value,
  }) {
    final selectedLabel = items.firstWhere(
          (label) => label.value == value?.toString(),
      orElse: () => const Label(key: '', value: ''),
    );

    if (!controllerMap.containsKey(index)) {
      controllerMap[index] = TextEditingController(text: selectedLabel.key);
    } else {
      if (controllerMap[index]!.text != selectedLabel.key) {
        controllerMap[index]!.text = selectedLabel.key;
      }
    }

    return controllerMap[index]!;
  }

  // ── Action Owner: combined field + dropdown-arrow overlay ─────────────────

  final Map<int, GlobalKey> _actionOwnerFieldKeys = {};

  void _closeOwnerDropdown() {
    _ownerDropdownOverlay?.remove();
    _ownerDropdownOverlay = null;
    _openDropdownIndex = null;
  }

  void _openOwnerDropdown({
    required BuildContext context,
    required PatrollingDetailsState state,
    required int index,
    required Items item,
  }) {
    _closeOwnerDropdown();

    final layerLink =
    _actionOwnerLayerLinks.putIfAbsent(index, () => LayerLink());
    final owners = state.owner;

    final fieldKey = _actionOwnerFieldKeys[index];
    final RenderBox? fieldBox =
    fieldKey?.currentContext?.findRenderObject() as RenderBox?;
    final double fieldWidth = fieldBox?.size.width ?? 280;
    final double fieldHeight = fieldBox?.size.height ?? 56;

    _ownerDropdownOverlay = OverlayEntry(
      builder: (overlayContext) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  _closeOwnerDropdown();
                  setState(() {});
                },
              ),
            ),
            CompositedTransformFollower(
              link: layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, fieldHeight + 6),
              child: Align(
                alignment: Alignment.topLeft,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: fieldWidth,
                    constraints: const BoxConstraints(maxHeight: 240),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.18),
                      ),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.35),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.fromLTRB(14, 10, 10, 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () {
                                      _closeOwnerDropdown();
                                      setState(() {});
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(4),
                                      child: Icon(
                                        Icons.close,
                                        size: 18,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              child: owners.isEmpty
                                  ? const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 14,
                                ),
                                child: Text(
                                  'No owners found',
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 13,
                                  ),
                                ),
                              )
                                  : ListView.separated(
                                padding:
                                const EdgeInsets.only(bottom: 8),
                                shrinkWrap: true,
                                itemCount: owners.length,
                                separatorBuilder: (_, __) => Divider(
                                  height: 1,
                                  color: Colors.white
                                      .withValues(alpha: 0.08),
                                ),
                                itemBuilder: (listCtx, i) {
                                  final option = owners[i];
                                  final label = [
                                    option.name ?? '',
                                    if ((option.email ?? '').isNotEmpty) option.email,
                                    if ((option.employeeId ?? '').isNotEmpty) option.employeeId,
                                  ].where((e) => (e ?? '').isNotEmpty).join(', ');

                                  return InkWell(
                                    onTap: () {
                                      _closeOwnerDropdown();
                                      setState(() {});

                                      item.actionOwnerName = option.email;
                                      item.actionOwnerId = option.id;
                                      item.actionOwner = User(
                                        userId: option.id,
                                        name: option.name,
                                        email: option.email,
                                        employeeId: option.employeeId,
                                      );
                                      _actionOwnerControllers[index]!
                                          .text = option.email ?? '';

                                      BlocProvider.of<
                                          PatrollingDetailsCubit>(
                                          context)
                                          .onItemChanged(
                                          state.otherModel);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 11,
                                      ),
                                      child: Text(
                                        label,
                                        style: const TextStyle(
                                          fontSize: 13.5,
                                          color: Colors.white,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(_ownerDropdownOverlay!);
    _openDropdownIndex = index;
  }

  Widget _buildActionOwnerField({
    required BuildContext context,
    required PatrollingDetailsState state,
    required int index,
    required Items item,
  }) {
    final bool isDisabled = item.canEditLsmFields == false;

    final focusNode =
    _actionOwnerFocusNodes.putIfAbsent(index, () => FocusNode());
    final layerLink =
    _actionOwnerLayerLinks.putIfAbsent(index, () => LayerLink());
    final fieldKey = _actionOwnerFieldKeys.putIfAbsent(index, () => GlobalKey());
    final controller = _actionOwnerControllers[index]!;

    return CompositedTransformTarget(
      link: layerLink,
      child: Container(
        key: fieldKey,
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          enabled: !isDisabled,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.05),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            suffixIcon: isDisabled
                ? null
                : IconButton(
              icon: Icon(
                _openDropdownIndex == index
                    ? Icons.arrow_drop_up
                    : Icons.arrow_drop_down,
                color: Colors.white.withValues(alpha: 0.7),
              ),
              onPressed: () async {
                if (_openDropdownIndex == index) {
                  _closeOwnerDropdown();
                  setState(() {});
                  return;
                }

                if (state.owner.isEmpty &&
                    item.ownerType != null &&
                    item.ownerType!.isNotEmpty) {
                  await context
                      .read<PatrollingDetailsCubit>()
                      .getOwnerUsers(
                    state.otherModel.locationId!,
                    item.ownerType!,
                  );
                }

                if (!context.mounted) return;
                _openOwnerDropdown(
                  context: context,
                  state: context.read<PatrollingDetailsCubit>().state,
                  index: index,
                  item: item,
                );
                setState(() {});
              },
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
              BorderSide(color: Colors.white.withValues(alpha: 0.3)),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onChanged: (value) {
            item.actionOwnerName = value;
            BlocProvider.of<PatrollingDetailsCubit>(context)
                .onItemChanged(state.otherModel);
          },
        ),
      ),
    );
  }

  // ── DB Sponsor: combined field + dropdown-arrow overlay ───────────────────

  final Map<int, GlobalKey> _dbSponsorFieldKeys = {};

  void _closeDbSponsorDropdown() {
    _dbSponsorDropdownOverlay?.remove();
    _dbSponsorDropdownOverlay = null;
    _openDbSponsorDropdownIndex = null;
  }

  void _openDbSponsorDropdown({
    required BuildContext context,
    required PatrollingDetailsState state,
    required int index,
    required Items item,
  }) {
    _closeDbSponsorDropdown();

    final layerLink =
    _dbSponsorLayerLinks.putIfAbsent(index, () => LayerLink());
    final dbSponsor = state.dbSponsor ?? const <BaseUser>[];

    final fieldKey = _dbSponsorFieldKeys[index];
    final RenderBox? fieldBox =
    fieldKey?.currentContext?.findRenderObject() as RenderBox?;
    final double fieldWidth = fieldBox?.size.width ?? 280;
    final double fieldHeight = fieldBox?.size.height ?? 56;

    _dbSponsorDropdownOverlay = OverlayEntry(
      builder: (overlayContext) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  _closeDbSponsorDropdown();
                  setState(() {});
                },
              ),
            ),
            CompositedTransformFollower(
              link: layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, fieldHeight + 6),
              child: Align(
                alignment: Alignment.topLeft,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: fieldWidth,
                    constraints: const BoxConstraints(maxHeight: 240),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.18),
                      ),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.35),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.fromLTRB(14, 10, 10, 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () {
                                      _closeDbSponsorDropdown();
                                      setState(() {});
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(4),
                                      child: Icon(
                                        Icons.close,
                                        size: 18,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              child: dbSponsor.isEmpty
                                  ? const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 14,
                                ),
                                child: Text(
                                  'No users found',
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 13,
                                  ),
                                ),
                              )
                                  : ListView.separated(
                                padding:
                                const EdgeInsets.only(bottom: 8),
                                shrinkWrap: true,
                                itemCount: dbSponsor.length,
                                separatorBuilder: (_, __) => Divider(
                                  height: 1,
                                  color: Colors.white
                                      .withValues(alpha: 0.08),
                                ),
                                itemBuilder: (listCtx, i) {
                                  final option = dbSponsor[i];
                                  final label = [
                                    option.name ?? '',
                                    if ((option.email ?? '').isNotEmpty) option.email,
                                    if ((option.employeeId ?? '').isNotEmpty) option.employeeId,
                                  ].where((e) => (e ?? '').isNotEmpty).join(', ');

                                  return InkWell(
                                    onTap: () {
                                      _closeDbSponsorDropdown();
                                      setState(() {});

                                      item.dbSponsorName = option.email;
                                      item.dbSponsor = User(
                                        userId: option.id,
                                        name: option.name,
                                        email: option.email,
                                        employeeId: option.employeeId,
                                      );
                                      _dbSponsorControllers[index]!
                                          .text = option.email ?? '';

                                      BlocProvider.of<
                                          PatrollingDetailsCubit>(
                                          context)
                                          .onItemChanged(
                                          state.otherModel);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 11,
                                      ),
                                      child: Text(
                                        label,
                                        style: const TextStyle(
                                          fontSize: 13.5,
                                          color: Colors.white,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(_dbSponsorDropdownOverlay!);
    _openDbSponsorDropdownIndex = index;
  }

  /// Combined free-text field + dropdown-arrow-triggered full list for DB Sponsor.
  Widget _buildDbSponsorField({
    required BuildContext context,
    required PatrollingDetailsState state,
    required int index,
    required Items item,
  }) {
    final bool isDisabled = item.canEditOwnerFields == false;

    final focusNode =
    _dbSponsorFocusNodes.putIfAbsent(index, () => FocusNode());
    final layerLink =
    _dbSponsorLayerLinks.putIfAbsent(index, () => LayerLink());
    final fieldKey = _dbSponsorFieldKeys.putIfAbsent(index, () => GlobalKey());
    final controller = _dbSponsorControllers[index]!;

    return CompositedTransformTarget(
      link: layerLink,
      child: Container(
        key: fieldKey,
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          enabled: !isDisabled,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.05),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            suffixIcon: isDisabled
                ? null
                : IconButton(
              icon: Icon(
                _openDbSponsorDropdownIndex == index
                    ? Icons.arrow_drop_up
                    : Icons.arrow_drop_down,
                color: Colors.white.withValues(alpha: 0.7),
              ),
              onPressed: () async {
                if (_openDbSponsorDropdownIndex == index) {
                  _closeDbSponsorDropdown();
                  setState(() {});
                  return;
                }

                await context
                    .read<PatrollingDetailsCubit>()
                    .getDbSponsorUsers(
                  state.otherModel.locationId!,
                );

                if (!context.mounted) return;
                final freshState =
                    context.read<PatrollingDetailsCubit>().state;
                log('DB Sponsor count at dropdown-open time: ${freshState.dbSponsor?.length}');
                _openDbSponsorDropdown(
                  context: context,
                  state: freshState,
                  index: index,
                  item: item,
                );
                setState(() {});
              },
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
              BorderSide(color: Colors.white.withValues(alpha: 0.3)),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onChanged: (value) {
            item.dbSponsorName = value;
            BlocProvider.of<PatrollingDetailsCubit>(context)
                .onItemChanged(state.otherModel);
          },
        ),
      ),
    );
  }

  /// Buttons

  Widget _cancelButton() {
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

  Widget _submitButton(PatrollingDetailsState state) {
    return AppButton(
      width: 150,
      key: const Key(Keys.submitButton),
      buttonText: Constants.save,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        FocusScope.of(context).unfocus();
        BlocProvider.of<PatrollingDetailsCubit>(context).submitForm(
          isSaveOnly: false,
          id: state.model.id?.toString(),
          subId: state.otherModel.subsectionId?.toString(),
        );
      },
    );
  }
}

// ── Thumb Button Widget ────────────────────────────────────────────────────────

class _ThumbButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final Color selectedColor;
  final bool isDisabled;
  final VoidCallback onTap;

  const _ThumbButton({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.selectedColor,
    required this.isDisabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? selectedColor.withValues(alpha: 0.18)
              : Colors.white.withValues(alpha: 0.05),
          border: Border.all(
            color:
            isSelected ? selectedColor : Colors.white.withValues(alpha: 0.3),
            width: isSelected ? 1.5 : 1.0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected
                  ? selectedColor
                  : Colors.white.withValues(alpha: 0.55),
            ),
            const SizedBox(width: 7),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: isSelected
                    ? selectedColor
                    : Colors.white.withValues(alpha: 0.55),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Radio Yes / No ─────────────────────────────────────────────────────────────

class _RadioYesNo extends StatelessWidget {
  final int? value;
  final bool isReadOnly;
  final ValueChanged<int> onChanged;

  const _RadioYesNo({
    required this.value,
    required this.isReadOnly,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _RadioChip(
          label: 'Yes',
          selected: value == 1,
          isReadOnly: isReadOnly,
          onTap: () => onChanged(1),
        ),
        const SizedBox(width: 6),
        _RadioChip(
          label: 'No',
          selected: value == 2,
          isReadOnly: isReadOnly,
          onTap: () => onChanged(2),
        ),
      ],
    );
  }
}

class _RadioChip extends StatelessWidget {
  final String label;
  final bool selected;
  final bool isReadOnly;
  final VoidCallback onTap;

  const _RadioChip({
    required this.label,
    required this.selected,
    required this.isReadOnly,
    required this.onTap,
  });

  Color get _selectedColor =>
      label == 'Yes' ? const Color(0xFF2E7D32) : const Color(0xFFC62828);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isReadOnly ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
            selected ? _selectedColor : Colors.white.withValues(alpha: 0.25),
          ),
          color:
          selected ? _selectedColor : Colors.white.withValues(alpha: 0.07),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 7,
              height: 7,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: Colors.white,
                fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}