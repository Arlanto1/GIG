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

  /// Controller lifecycle

  void _ensureControllers(int i, Items item) {
    _remarksControllers.putIfAbsent(
        i, () => TextEditingController(text: item.remarks ?? ''));

    _actionOwnerControllers.putIfAbsent(
        i,
            () => TextEditingController(
            text: item.actionOwnerName ?? item.actionOwner?.userName ?? ''));

    _dbSponsorControllers.putIfAbsent(
        i, () => TextEditingController(text: item.dbSponsor?.userName ?? ''));

    _severityControllers.putIfAbsent(
        i, () => TextEditingController(text: _severityLabel(item.severity)));

    _ownerControllers.putIfAbsent(
        i, () => TextEditingController(text: item.ownerType ?? ''));

    _ownerRemarksControllers.putIfAbsent(
        i, () => TextEditingController(text: item.ownerUpdates ?? ''));

    _reviewCommentControllers.putIfAbsent(
        i, () => TextEditingController(text: item.reviewComment ?? ''));


    _etaDateControllers.putIfAbsent(
        i, () => TextEditingController(text: _etaToDisplay(item.eta)));

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

    final actionOwner = item.actionOwnerName ?? item.actionOwner?.userName ?? '';
    if (actionOwner.isNotEmpty && _actionOwnerControllers[i]!.text != actionOwner) {
      _actionOwnerControllers[i]!.text = actionOwner;
    }

    final dbSponsor = item.dbSponsor?.userName ?? '';
    if (_dbSponsorControllers[i]!.text != dbSponsor) {
      _dbSponsorControllers[i]!.text = dbSponsor;
    }

    final ownerRemarks = item.ownerUpdates ?? '';
    if (_ownerRemarksControllers[i]!.text != ownerRemarks) {
      _ownerRemarksControllers[i]!.text = ownerRemarks;
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
                    'model':state.model,
                  },
                );
              },
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.model.status == null) isReadOnly = false;
        showSaveSubmitButton =
            state.model.status != 9 && state.model.lock.isEmptyOrNull;

        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.title,
            showPopUp: false,
            showSaveButton:
            showSaveSubmitButton && state.status != FormStatus.loading,
            showSubmitButton: false,
            showDisLikeButton: false,
            showLikeButton: false,
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<PatrollingDetailsCubit>(context).submitForm(
                isSaveOnly: true,
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
                if (state.model.status != 9)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _cancelButton(),
                      _submitButton(state),
                    ],
                  ),
                if (state.model.status == 9)
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
    final bool isDisabled = !showSaveSubmitButton;

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
            isEnable: state.otherModel.status == 0 || item.canEditGuardFields == true,
            isDisableColor: state.otherModel.status != 0 && item.canEditGuardFields == false,
            onChange: (String value) {
              item.remarks = value;
              BlocProvider.of<PatrollingDetailsCubit>(context)
                  .onItemChanged(state.otherModel);
            },
            validateTextField: (String? user) {},
          ),
          CommonWidgets.verticalSpacerWidget(height * 0.02),

          /// Attachments
          CommonWidgets.textDisplay(
            Constants.attachments,
            isMandatory: true,
            Styles.textStyleWhite14,
          ),
          BaseImageUpload().uploadWidget(
            context: context,
            isDisabled: state.otherModel.status !=0 && item.canEditGuardFields == false,
            loggedInUserDetails: state.loggedInUserDetails ?? User(),
            getFiles: item.attachments ?? [],
            onImageSelected: (ImageContent data) {
              final current = List<ImageContent>.from(item.attachments ?? []);
              current.insert(0, data);
              setState(() => item.attachments = current);
              BlocProvider.of<PatrollingDetailsCubit>(context)
                  .addAttachment(files: current, itemIndex: index);
            },
          ),
          if ((item.attachments ?? []).isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: BaseImageUpload().getAttachment(
                height: height,
                attachments: item.attachments,
                files: item.attachments ?? [],
                moduleCode: '',
                isDisabled: item.canEditGuardFields == false,
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
                    dropDownValues:
                    ownerDropDownValues.map((label) => label.key).toList(),
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
                        await context
                            .read<PatrollingDetailsCubit>()
                            .getOwnerUsers(state.otherModel.locationId!, selectedLabel.key);

                        /// optional: clear previous selection
                        setState(() {
                          item.actionOwnerName = null;
                          _actionOwnerControllers[index]!.clear();
                        });
                      }
                  );
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

            /// Action Owner
            if (item.ownerType != 'Other') ...[
              CommonWidgets.textDisplay(
                Constants.actionOwner,
                isMandatory: true,
                Styles.textStyleWhite14,
              ),
              TextFieldAddButton(
                title: item.actionOwnerName ?? item.actionOwner?.userInfo,
                height: 70,
                isDisableColor: item.canEditLsmFields == false,
                onTap: () async {
                  if (item.canEditLsmFields == true) {
                    final cubit = context.read<PatrollingDetailsCubit>();

                    //  If owner list is empty (e.g. state was reset), re-fetch
                    if (item.ownerType != null && item.ownerType!.isNotEmpty) {
                      await cubit.getOwnerUsers(
                        state.otherModel.locationId!,
                        item.ownerType!,
                      );
                    }

                    if (!context.mounted) return;
                    final freshUsers = context
                        .read<PatrollingDetailsCubit>()
                        .state
                        .owner;
                    BaseOrganisationDialog().userDialog(
                      employeeId: false,
                      context: context,
                      isDbUser: true,
                      users: freshUsers,
                      roleName: ConstantUserRoles.atomStaticUser,
                      locationId: 0,
                      onTap: (BaseUser user) {
                        final cubit = context.read<PatrollingDetailsCubit>();
                        final otherModel = cubit.state.otherModel;
                        final items = List<Items>.from(otherModel.items ?? []);

                        //  Update BOTH actionOwnerName AND actionOwner id
                        items[index].actionOwnerName = user.name;
                        items[index].actionOwnerId = user.id;
                        items[index].actionOwner = User(
                          userId: user.id,
                          name: user.name,
                          email: user.email,
                          employeeId: user.employeeId,
                        );

                        setState(() {
                          _actionOwnerControllers[index]!.text =
                              user.name ?? '';
                        });

                        //  Emit updated otherModel with new items
                        cubit.onItemChanged(otherModel..items = items);
                      },
                      functionToCall: (BaseUser user) {},
                    );
                  };
                }
              ),
            ],

            if (item.ownerType == 'Other') ...[
              CommonWidgets.textDisplay(
                Constants.actionOwner,
                isMandatory: true,
                Styles.textStyleWhite14,
              ),
              FlutterInputField(
                textInputType: TextInputType.text,
                textFormKey: Keys.challanKey,
                controller: _actionOwnerControllers[index]!,
                characterLimit: Constants.characterLimitIdTextFormField,
                hintText: '',
                isEnable: item.canEditLsmFields == true,
                isDisableColor: item.canEditLsmFields == false,
                onChange: (String value) {
                  item.actionOwnerName = value;
                  BlocProvider.of<PatrollingDetailsCubit>(context)
                      .onItemChanged(state.otherModel);
                },
                validateTextField: (String? user) {},
              ),
            ],
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
              showPastDate: true,
              showFutureDate: false,
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
                if(item.canEditOwnerFields == true) {
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

            /// DB Sponsor
            CommonWidgets.textDisplay(
              Constants.dbSponsor,
              isMandatory: true,
              Styles.textStyleWhite14,
            ),
            FlutterInputField(
              textInputType: TextInputType.text,
              textFormKey: Keys.challanKey,
              controller: _dbSponsorControllers[index]!,
              characterLimit: Constants.characterLimitIdTextFormField,
              hintText: '',
              isEnable: item.canEditOwnerFields == true,
              isDisableColor: item.canEditOwnerFields == false,
              onChange: (String value) {
                item.dbSponsorName = value;
                BlocProvider.of<PatrollingDetailsCubit>(context)
                    .onItemChanged(state.otherModel);
              },
              validateTextField: (String? user) {},
            ),
            CommonWidgets.verticalSpacerWidget(height * 0.02),

            /// Attachments
            CommonWidgets.textDisplay(
              Constants.attachments,
              isMandatory: true,
              Styles.textStyleWhite14,
            ),
            BaseImageUpload().uploadWidget(
              context: context,
              isDisabled: item.canEditOwnerFields == false,
              loggedInUserDetails: state.loggedInUserDetails ?? User(),
              getFiles: item.attachments ?? [],
              onImageSelected: (ImageContent data) {
                final current = List<ImageContent>.from(item.attachments ?? []);
                current.insert(0, data);
                setState(() => item.attachments = current);
                BlocProvider.of<PatrollingDetailsCubit>(context)
                    .addAttachment(files: current, itemIndex: index);
              },
            ),
            if ((item.attachments ?? []).isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: BaseImageUpload().getAttachment(
                  height: height,
                  attachments: item.attachments,
                  files: item.attachments ?? [],
                  moduleCode: '',
                  isDisabled: item.canEditOwnerFields == false,
                ),
              ),
            CommonWidgets.verticalSpacerWidget(height * 0.02),
          ],

          // ── Review Section (status == 3)
          if (state.otherModel.status != null &&
              state.otherModel.status != 0 &&
              state.otherModel.status != 1 &&
              state.otherModel.status != 2 &&
              state.otherModel.status == 3) ...[

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
                  onTap: () {
                    if(item.canReview == true) {
                      setState(() => item.reviewStatus = 1);
                      BlocProvider.of<PatrollingDetailsCubit>(context)
                          .onItemChanged(state.otherModel);
                      BlocProvider.of<PatrollingDetailsCubit>(context)
                          .submitForm(
                        isSaveOnly: false,
                        id: state.model.id?.toString(),
                        subId: state.otherModel.subsectionId?.toString(),
                      );
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
                        final parentContext = context; //  Save correct context

                        TextEditingController commentController = TextEditingController();

                        showDialog(
                          context: parentContext,
                          builder: (dialogContext) {
                            return AlertDialog(
                              title: const Text("Enter Review Comment"),
                              content: TextField(
                                controller: commentController,
                                decoration: const InputDecoration(
                                  hintText: "Enter comment",
                                ),
                                maxLines: 3,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(dialogContext);
                                  },
                                  child: const Text("Cancel"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
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

                                    //  Use parentContext here
                                    BlocProvider.of<PatrollingDetailsCubit>(parentContext)
                                        .onItemChanged(state.otherModel);

                                    BlocProvider.of<PatrollingDetailsCubit>(parentContext)
                                        .submitForm(
                                      isSaveOnly: false,
                                      id: state.model.id?.toString(),
                                      subId: state.otherModel.subsectionId?.toString(),
                                    );

                                    Navigator.pop(dialogContext);
                                  },
                                  child: const Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                ),
              ],
            ),
            CommonWidgets.verticalSpacerWidget(height * 0.02),

         ///Review Comment
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
            color: isSelected
                ? selectedColor
                : Colors.white.withValues(alpha: 0.3),
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
                fontWeight:
                isSelected ? FontWeight.w600 : FontWeight.normal,
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
            color: selected
                ? _selectedColor
                : Colors.white.withValues(alpha: 0.25),
          ),
          color: selected
              ? _selectedColor
              : Colors.white.withValues(alpha: 0.07),
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