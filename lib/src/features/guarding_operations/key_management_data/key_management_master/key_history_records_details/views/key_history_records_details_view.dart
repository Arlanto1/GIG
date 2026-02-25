import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';

import '../../../../../material_movement/material_movement_details/views/add_rejection_commnet_pop_up.dart';
import '../cubits/key_history_records_details_cubit.dart';

class KeyHistoryRecordsDetailsView extends StatefulWidget {
  final KeyHistoryModel? model;
  final String title;
  final int keyLostType;
  final int parentId;
  final int? id;
  final ExtraProperties? extraProperties;
  final String? lock;
  final int? keyType;
  final bool parentIsEligibleToEdit;
  final int locationId;
  final int parentStatus;

  const KeyHistoryRecordsDetailsView({
    super.key,
    this.model,
    required this.title,
    required this.keyLostType,
    required this.parentId,
    this.id,
    this.extraProperties,
    this.lock,
    this.keyType,
    required this.parentIsEligibleToEdit,
    required this.locationId,
    required this.parentStatus,
  });

  @override
  State<KeyHistoryRecordsDetailsView> createState() =>
      _KeyHistoryRecordsDetailsViewState();
}

class _KeyHistoryRecordsDetailsViewState
    extends State<KeyHistoryRecordsDetailsView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User? userDetails;
  TextEditingController keyTypeController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  bool isDisabled = true;
  bool isReadOnly = false;
  bool showLikeDisLikeButtons = false;
  bool showSaveAndSubmitButtons = false;
  bool editSrhAndDetailsOfLostKeys = false;
  bool editSecurityManagerAndReason = false;
  bool editNumOfKeys = false;
  bool srh = false;
  bool securityManager = false;
  bool lockChangeInitiatedAndUser = false;
  bool keyLostOrDamageScreen = false;
  bool hasPermission = false;
  bool initialStatus = false;
  bool loginAndCreatedByUser = false;

  get guardingMasterData => null;
  final FocusNode noOfKeysFocusNode = FocusNode();
  final FocusNode detailsOfLostKeyFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<KeyHistoryRecordsDetailsCubit>(context).initializeValues();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.keyType != null) {
      keyTypeController.text = Utils().getKeyFromValue(
            value: widget.keyType!,
            dropdownValues: keyTypeDropDownValues,
          ) ??
          '';
    }
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return BlocConsumer<KeyHistoryRecordsDetailsCubit,
        KeyHistoryRecordsDetailsState>(
      listener: (context, state) {
        log('--widget.type--${widget.keyLostType}--');
        log('--widget.keyType--${widget.keyType}--');
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);
        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: 'Key Management Master',
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              if (widget.keyLostType != ConstantsIntValue.keyLostHistoryInt &&
                  widget.keyLostType != ConstantsIntValue.keyDamageHistoryInt) {
                Navigator.popAndPushNamed(
                  context,
                  keyHistoryRecordsViewRoute,
                  arguments: {
                    ConstantsArgument.title: widget.title,
                    ConstantsArgument.id: widget.parentId,
                    ConstantsArgument.keyLostType: widget.keyLostType,
                    ConstantsArgument.isEligibleToEdit:
                        widget.parentIsEligibleToEdit,
                    ConstantsArgument.parentStatus: widget.parentStatus,
                    ConstantsArgument.locationId: widget.locationId,
                  },
                );
              }
              // Navigator.pop(context);
              // return;
            },
          );
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => dialog,
          );

          // Utils.dynamicAlert(
          //     context, state.message ?? '', 'Material Movement', '');
        }
      },
      builder: (context, state) {
        if (state.model.status == null ||
            state.model.status == ConstantsIntValue.created ||
            state.model.status == ConstantsIntValue.lostInitiated ||
            state.model.status == ConstantsIntValue.damagedInitiated ||
            state.model.status == ConstantsIntValue.lostApproved) {
          isReadOnly = false;
        }

        if (state.model.status == null ||
            state.model.status == ConstantsIntValue.created) {
          initialStatus = true;
        }
        if ((widget.extraProperties != null &&
            !widget.extraProperties!.hasWritePermission!)) {
          hasPermission = true;
        }
        if (state.loggedInUserDetails!.userName.equalsIgnoreCase(
          state.model.createdBy?.userName,
        )) {
          loginAndCreatedByUser = true;
        }
        if (state.loggedInUserDetails!.userName.equalsIgnoreCase(
              state.model.srh?.userName,
            ) &&
            (widget.model?.type == ConstantsIntValue.keyLostHistoryInt ||
                widget.model?.type == ConstantsIntValue.keyDamageHistoryInt)) {
          srh = true;
        }
        if (state.loggedInUserDetails!.userName.equalsIgnoreCase(
              state.model.securityManager?.userName,
            ) &&
            (widget.model?.type == ConstantsIntValue.lockChangeHistoryInt ||
                widget.model?.type == ConstantsIntValue.keyDestroyHistoryInt)) {
          securityManager = true;
        }

        if ((state.model.status != ConstantsIntValue.closed && srh) ||
            state.model.status == null) {
          editSrhAndDetailsOfLostKeys = true;
        }

        if ((securityManager || initialStatus) &&
            state.model.status != ConstantsIntValue.closed) {
          editSecurityManagerAndReason = true;
        }

        if (initialStatus &&
            (widget.keyLostType == ConstantsIntValue.lockChangeHistoryInt ||
                widget.keyLostType == ConstantsIntValue.keyDestroyHistoryInt)) {
          editNumOfKeys = true;
        }

        if (state.model.status == ConstantsIntValue.lockChangeInitiated &&
            loginAndCreatedByUser) {
          lockChangeInitiatedAndUser = true;
        }

        if ((state.model.status == ConstantsIntValue.destroyInitiated &&
                widget.keyLostType == ConstantsIntValue.keyDestroyHistoryInt) &&
            securityManager) {
          showLikeDisLikeButtons = true;
        }

        if (widget.keyLostType == ConstantsIntValue.keyLostHistoryInt ||
            widget.keyLostType == ConstantsIntValue.keyDamageHistoryInt) {
          keyLostOrDamageScreen = true;
        }
        if (initialStatus ||
            state.model.status != ConstantsIntValue.destroyInitiated &&
                (lockChangeInitiatedAndUser ||
                    ((state.model.status == ConstantsIntValue.lostInitiated ||
                            state.model.status ==
                                ConstantsIntValue.damagedApproved) &&
                        srh) ||
                    (state.model.status == ConstantsIntValue.lostApproved &&
                        lockChangeInitiatedAndUser) ||
                    (state.model.status == ConstantsIntValue.destroyApproved &&
                        securityManager))) {
          showSaveAndSubmitButtons = true;
        }
        initializeDates();
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.title,
            showPopUp: false,
            showSaveButton: false,
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<KeyHistoryRecordsDetailsCubit>(
                context,
              ).submitForm(isSaveOnly: true);
            },
            showSubmitButton:
                showSaveAndSubmitButtons && state.status != FormStatus.loading
                    ? true
                    : false,
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<KeyHistoryRecordsDetailsCubit>(
                context,
              ).submitForm(isSaveOnly: false);
            },
            showLikeButton:
                showLikeDisLikeButtons && state.status != FormStatus.loading,
            onTapLikeButton: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<KeyHistoryRecordsDetailsCubit>(
                context,
              ).submitForm(
                isApprovedOnly: true,
                isSaveOnly: false,
                isRejectOnly: false,
              );
            },
            showDisLikeButton:
                showLikeDisLikeButtons && state.status != FormStatus.loading,
            onTapDislikeButton: () {
              // FocusScope.of(context).unfocus();
              showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return AddRejectionCommentPopUp(
                    mainContext: context,
                    onSubmit: (value) {
                      log('--value--$value--');
                      state.model.comment = value;
                      // BlocProvider.of<KeyHistoryRecordsDetailsCubit>(context)
                      //     .onAddRejectionComment(value);
                      BlocProvider.of<KeyHistoryRecordsDetailsCubit>(
                        context,
                      ).submitForm(
                        isRejectOnly: true,
                        isSaveOnly: false,
                        isApprovedOnly: false,
                      );
                      Navigator.pop(context);
                    },
                  );
                },
              );
            },
          ),
          backgroundColor: Colors.transparent,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void initializeDates() {}

  getBodybuilder(KeyHistoryRecordsDetailsState state, height) {
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }
    return Stack(
      children: [
        // 🔹 Background Image
        Positioned.fill(
          child: Image.asset(
            'assets/images/bg2.png',
            fit: BoxFit.cover,
          ),
        ),

        // 🔹 Blur Layer
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
                child: Form(
                  key: _formKey,
                  autovalidateMode: state.model.status == 4
                      ? AutovalidateMode.disabled
                      : AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: Column(
                          children: [
                            //if (!state.model.lock.isEmptyOrNull) ...[
                            //   RecordLockedWidget(text: '${state.model.lock}'),
                            // ],
                            CommonWidgets.verticalSpacerWidget(height * 0.02),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                Constants.generalinformation,
                                style: Styles.styleHeaderWhiteText16,
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// Status
                            CommonWidgets.textDisplay(
                              state.labels?.locale.status ??
                                  state.labels?.defaultLocale.status ??
                                  Constants.status,
                              Styles.textStyleWhite14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.002),
                            CommonWidgets.verticalSpacerWidget(height * 0.002),
                            BaseDropDown().getDropDown(
                              isDisabled: true,
                              textController: statusController,
                              items: keyManagementHistoryStatus,
                              initialValue: '${state.model.status ?? 0}',
                              onTap: () {
                                // if (!isDisabled) {
                                //   BaseDropDown().assetTypeDialog(
                                //     context: context,
                                //     dropDownValues: keyManagementHistoryStatus
                                //         .map((label) => label.key)
                                //         .toList(),
                                //     onTap: (String value) {
                                //       Label? selectedLabel;
                                //       selectedLabel =
                                //           keyManagementHistoryStatus.firstWhere(
                                //                 (label) => label.key == value,
                                //             orElse: () =>
                                //             const Label(key: '', value: ''),
                                //           );
                                //       BlocProvider.of<
                                //           KeyHistoryRecordsDetailsCubit>(
                                //           context)
                                //           .updateDropdownValues(
                                //           status: int.tryParse(
                                //               selectedLabel.value));
                                //     },
                                //   );
                                // }
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// Created By
                            CommonWidgets.horizentaltextHandling(
                              state.labels?.locale.createdBy ??
                                  state.labels?.defaultLocale.createdBy ??
                                  Constants.createdby,
                              isMandatory: true,
                              '${state.model.createdBy?.firstName ?? ''} ${state.model.createdBy?.lastName ?? ''}',
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// Date of creation
                            CommonWidgets.textDisplay(
                              state.labels?.locale.createdDate ??
                                  state.labels?.defaultLocale.createdDate ??
                                  Constants.createOn,
                              isMandatory: true,
                              Styles.textStyleWhite14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.002),
                            BaseDate().creationDateDisplay(
                              state.model.createdDate ?? '',
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// Sl No.
                            CommonWidgets.horizentaltextHandling(
                              state.labels?.locale.slNo ??
                                  state.labels?.defaultLocale.slNo ??
                                  Constants.slno,
                              state.model.slNo ?? '',
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// Key Type
                            CommonWidgets.textDisplay(
                              state.labels?.locale.keyType ??
                                  state.labels?.defaultLocale.keyType ??
                                  Constants.keyType,
                              isMandatory: true,
                              Styles.textStyleWhite14,
                            ),
                            BaseDropDown().getDropDown(
                              isDisabled:
                                  !initialStatus || keyLostOrDamageScreen,
                              textController: keyTypeController,
                              items: keyTypeDropDownValues,
                              // initialValue: state.model.keyType.toString(),
                              onTap: () {
                                if (initialStatus && !keyLostOrDamageScreen) {
                                  BaseDropDown().assetTypeDialog(
                                    context: context,
                                    dropDownValues: keyTypeDropDownValues
                                        .map((label) => label.key)
                                        .toList(),
                                    onTap: (String value) {
                                      Label? selectedLabel;
                                      selectedLabel =
                                          keyTypeDropDownValues.firstWhere(
                                        (label) => label.key == value,
                                        orElse: () =>
                                            const Label(key: '', value: ''),
                                      );
                                      keyTypeController.text = value;
                                      BlocProvider.of<
                                                  KeyHistoryRecordsDetailsCubit>(
                                              context)
                                          .updateDropdownValues(
                                        keyType: int.tryParse(
                                          selectedLabel.value,
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            ///Type
                            CommonWidgets.textDisplay(
                              state.labels?.locale.type ??
                                  state.labels?.defaultLocale.type ??
                                  Constants.type,
                              isMandatory: true,
                              Styles.textStyleWhite14,
                            ),
                            BaseDropDown().getDropDown(
                              isDisabled: true,
                              textController: typeController,
                              items: typesDropDownValues,
                              initialValue:
                                  '${widget.keyLostType == ConstantsIntValue.lockChangeHistoryInt ? state.model.type ?? 0 : widget.keyLostType == ConstantsIntValue.keyLostHistoryInt ? state.model.type ?? 1 : widget.keyLostType == ConstantsIntValue.keyDamageHistoryInt ? state.model.type ?? 2 : widget.keyLostType == ConstantsIntValue.keyDestroyHistoryInt ? state.model.type ?? 3 : state.model.type.toString()}',
                              onTap: () {
                                if (!isDisabled) {
                                  BaseDropDown().assetTypeDialog(
                                    context: context,
                                    dropDownValues: typesDropDownValues
                                        .map((label) => label.key)
                                        .toList(),
                                    onTap: (String value) {
                                      Label? selectedLabel;
                                      selectedLabel =
                                          typesDropDownValues.firstWhere(
                                        (label) => label.key == value,
                                        orElse: () =>
                                            const Label(key: '', value: ''),
                                      );
                                      BlocProvider.of<
                                                  KeyHistoryRecordsDetailsCubit>(
                                              context)
                                          .updateDropdownValues(
                                        type: int.tryParse(selectedLabel.value),
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            if (keyLostOrDamageScreen) ...[
                              /// SRH
                              CommonWidgets.textDisplay(
                                state.labels?.locale.srh ??
                                    state.labels?.defaultLocale.srh ??
                                    Constants.srh,
                                Styles.textStyleWhite14,
                                isMandatory: true,
                              ),
                              TextFieldAddButton(
                                title: state.model.srh?.userInfo ??
                                    state.model.srh?.name,
                                height: 70,
                                isDisableColor: !editSrhAndDetailsOfLostKeys,
                                onTap: () {
                                  if (editSrhAndDetailsOfLostKeys) {
                                    BaseOrganisationDialog().userDialog(
                                      context: context,
                                      enabled: showSaveAndSubmitButtons,
                                      users: state.sRHs,
                                      onTap: (BaseUser user) {
                                        BlocProvider.of<
                                                    KeyHistoryRecordsDetailsCubit>(
                                                context)
                                            .updateDropdownValues(srh: user);
                                      },
                                      roleName: ConstantUserRoles
                                          .atomSubRegionalHeadUser,
                                      locationId: widget.locationId,
                                      isDbUser: false,
                                      functionToCall: (BaseUser user) {
                                        BlocProvider.of<
                                                    KeyHistoryRecordsDetailsCubit>(
                                                context)
                                            .updateDropdownValues(srh: user);
                                        // refresh the list
                                        BlocProvider.of<
                                                    KeyHistoryRecordsDetailsCubit>(
                                                context)
                                            .refreshList();
                                      },
                                    );
                                  }
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),
                            ],

                            if (widget.keyLostType ==
                                ConstantsIntValue.keyDestroyHistoryInt) ...[
                              /// Security Manager
                              CommonWidgets.textDisplay(
                                state.labels?.locale.securityManager ??
                                    state.labels?.defaultLocale
                                        .securityManager ??
                                    Constants.securityManager,
                                Styles.textStyleWhite14,
                                isMandatory: true,
                              ),
                              TextFieldAddButton(
                                title: state.model.securityManager?.userInfo ??
                                    state.model.securityManager?.name,
                                height: 70,
                                isDisableColor: !editSecurityManagerAndReason,
                                onTap: () {
                                  if (editSecurityManagerAndReason) {
                                    BaseOrganisationDialog().userDialog(
                                      context: context,
                                      users: state.securityManagers!,
                                      onTap: (BaseUser user) {
                                        BlocProvider.of<
                                                    KeyHistoryRecordsDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                          securityManager: user,
                                        );
                                      },
                                      roleName: ConstantUserRoles
                                          .atomSecurityManagerUser,
                                      locationId: 0,
                                      isDbUser: false,
                                      functionToCall: (BaseUser user) {
                                        BlocProvider.of<
                                                    KeyHistoryRecordsDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                          securityManager: user,
                                        );
                                        // refresh the list
                                        BlocProvider.of<
                                                    KeyHistoryRecordsDetailsCubit>(
                                                context)
                                            .refreshList();
                                      },
                                    );
                                  }
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Reason for Key Destruction
                              CommonWidgets.textDisplay(
                                state.labels?.locale.destructionReason ??
                                    state.labels?.defaultLocale
                                        .destructionReason ??
                                    Constants.destructionReason,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              TextFieldAddButton(
                                title: state.model.destructionReason?.name,
                                height: 70,
                                isDisableColor: !editSecurityManagerAndReason,
                                onTap: () {
                                  if (editSecurityManagerAndReason) {
                                    BaseOrganisationDialog().departmentDialog(
                                      context: context,
                                      organisations: state.destructionReasons,
                                      onTap: (Organisation department) {
                                        BlocProvider.of<
                                                    KeyHistoryRecordsDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                          destructionReason: department,
                                        );
                                        FocusScope.of(
                                          context,
                                        ).requestFocus(noOfKeysFocusNode);
                                      },
                                      orgName:
                                          'KEY_MANAGEMENT_DESTRUCTION_REASON',
                                      createEntity: false,
                                      title: 'Add Reason for Key Destruction',
                                      functionToCall: () {
                                        // refresh the list
                                        BlocProvider.of<
                                                    KeyHistoryRecordsDetailsCubit>(
                                                context)
                                            .refreshList();
                                      },
                                    );
                                  }
                                },
                              ),

                              CommonWidgets.verticalSpacerWidget(height * 0.02),
                            ],

                            /// Details of Lost Keys
                            if (keyLostOrDamageScreen) ...[
                              CommonWidgets.textDisplay(
                                state.labels?.locale.lostKeyDetails ??
                                    state
                                        .labels?.defaultLocale.lostKeyDetails ??
                                    Constants.detailsOfLostKey,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.002),
                              FlutterInputField(
                                lineHeight: 6,
                                characterLimit:
                                    Constants.characterLimitDescTextFormField,
                                initialValue: state.model.lostKeyDetails,
                                textFormKey: Keys.additionInitiativesKey,
                                hintText: Constants.informationhere,
                                showBorder: true,
                                isEnable: editSrhAndDetailsOfLostKeys,
                                isDisableColor: !(editSrhAndDetailsOfLostKeys),
                                onChange: (String value) {
                                  state.model.lostKeyDetails = value;
                                  context
                                      .read<KeyHistoryRecordsDetailsCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),
                            ],

                            if (widget.keyLostType ==
                                    ConstantsIntValue.lockChangeHistoryInt ||
                                widget.keyLostType ==
                                    ConstantsIntValue.keyDestroyHistoryInt ||
                                widget.keyLostType ==
                                    ConstantsIntValue.keyDamageHistoryInt ||
                                widget.keyLostType ==
                                    ConstantsIntValue.keyLostHistoryInt) ...[
                              /// No Of Keys
                              CommonWidgets.textDisplay(
                                state.labels?.locale.noOfKeys ??
                                    state.labels?.defaultLocale.noOfKeys ??
                                    Constants.noOfKeys,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.002),
                              FlutterInputField(
                                textInputType: TextInputType.number,
                                initialValue: '${state.model.noOfKeys ?? ''}',
                                textFormKey: Keys.guardingPOCKey,
                                hintText: '',
                                focusNode: noOfKeysFocusNode,
                                isEnable: editNumOfKeys,
                                onChange: (String value) {
                                  state.model.noOfKeys = int.tryParse(value);
                                  context
                                      .read<KeyHistoryRecordsDetailsCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),
                            ],

                            /// Additional Information
                            CommonWidgets.textDisplay(
                              state.labels?.locale.additionalInformation ??
                                  state.labels?.defaultLocale
                                      .additionalInformation ??
                                  Constants.additionalinformation,
                              Styles.textStyleWhite14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.002),
                            FlutterInputField(
                              lineHeight: 6,
                              characterLimit:
                                  Constants.characterLimitDescTextFormField,
                              initialValue: state.model.additionalInformation,
                              textFormKey: Keys.additionInitiativesKey,
                              hintText: Constants.informationhere,
                              showBorder: true,
                              isEnable: ((securityManager ||
                                      srh ||
                                      initialStatus ||
                                      lockChangeInitiatedAndUser)) &&
                                  state.model.status !=
                                      ConstantsIntValue.closed &&
                                  state.model.status !=
                                      ConstantsIntValue.lockChangeInitiated,
                              isDisableColor:
                                  !((securityManager || srh || initialStatus) ||
                                          lockChangeInitiatedAndUser) ||
                                      state.model.status ==
                                          ConstantsIntValue.closed ||
                                      state.model.status ==
                                          ConstantsIntValue.lockChangeInitiated,
                              onChange: (String value) {
                                state.model.additionalInformation = value;
                                context
                                    .read<KeyHistoryRecordsDetailsCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// Investigation Required
                            if (keyLostOrDamageScreen) ...[
                              CommonWidgets.textDisplay(
                                state.labels?.locale.investigationRequired ??
                                    state.labels?.defaultLocale
                                        .investigationRequired ??
                                    Constants.investigationRequired,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              RadioButtonsYesNo(
                                status: state.model.status ?? 0,
                                selectedValue:
                                    state.model.investigationRequired ?? false
                                        ? 1
                                        : 0,
                                onChangedYes:
                                    // !((initialStatus ||
                                    //                 state.model.status ==
                                    //                     ConstantsIntValue
                                    //                         .lostInitiated) &&
                                    //             keyLostOrDamageScreen &&
                                    //             loginAndCreatedByUser) &&
                                    //         hasPermission
                                    !(((securityManager ||
                                                srh ||
                                                initialStatus ||
                                                lockChangeInitiatedAndUser)) &&
                                            state.model.status !=
                                                ConstantsIntValue.closed)
                                        ? null
                                        : (val) {
                                            state.model.investigationRequired =
                                                true;
                                            BlocProvider.of<
                                                        KeyHistoryRecordsDetailsCubit>(
                                                    context)
                                                .onCheckBoxChange(state.model);
                                          },
                                onChangedNo: !(((securityManager ||
                                            srh ||
                                            initialStatus ||
                                            lockChangeInitiatedAndUser)) &&
                                        state.model.status !=
                                            ConstantsIntValue.closed)
                                    ? null
                                    : (val) {
                                        state.model.investigationRequired =
                                            false;
                                        BlocProvider.of<
                                                    KeyHistoryRecordsDetailsCubit>(
                                                context)
                                            .onCheckBoxChange(state.model);
                                      },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),
                            ],
                            if (state.model.investigationRequired == true) ...[
                              CommonWidgets.textDisplay(
                                Constants.incidentItemList,
                                Styles.textStyleBlack14,
                              ),
                              GestureDetector(
                                onTap: () =>
                                    navigateToCreateIncident(state: state),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    if (state.model.status !=
                                        ConstantsIntValue.submitted) ...[
                                      const SizedBox(width: 14),
                                      SvgPicture.asset(
                                        AppIcon.pluscircle,
                                        colorFilter: const ColorFilter.mode(
                                          AppColors.navigationSkyBlueColor,
                                          BlendMode.srcIn,
                                        ),
                                        // color: AppColors.navigationSkyBlueColor,
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        'Add Incident Item List',
                                        style: TextStyle(
                                          color:
                                              AppColors.navigationSkyBlueColor,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      // if (state.model.incidentItems != null &&
                                      //     !state.model.incidentItems!.where(
                                      //         (element) =>
                                      //             element.incidentType ==
                                      //             1).isEmptyOrNull) ...[
                                      CommonWidgets.horizontalSpacerWidget(
                                        height * 0.02,
                                      ),
                                    ],
                                    showButtonDisplay(
                                      kldId: state.model.id.toString(),
                                      state: state,
                                    ),
                                    // ],
                                  ],
                                ),
                              ),
                            ],

                            // if (state.model.investigationRequired ?? false) ...[
                            //   Container(
                            //     alignment: Alignment.topLeft,
                            //     child: Text(
                            //       Constants.incident,
                            //       style: Styles.styleHeaderGreyText16,
                            //     ),
                            //   ),
                            //   CommonWidgets.verticalSpacerWidget(height * 0.01),
                            //   GestureDetector(
                            //     onTap: () async {
                            //       NavigatorState nav = Navigator.of(context);
                            //       bool isSaveSuccess = await BlocProvider.of<
                            //           KeyHistoryRecordsDetailsCubit>(context)
                            //           .submitForm(
                            //         isSaveOnly: true,
                            //         navigateToNextScreen: true,
                            //       );
                            //       if (!isSaveSuccess) {
                            //         return;
                            //       }
                            //       nav.pushNamed(
                            //         incidentManagementDetailsRoute,
                            //         arguments: {
                            //           ConstantsArgument.title: Constants.incident,
                            //           // ConstantsArgument.id: state.model.id,
                            //           ConstantsArgument.kldId:
                            //               state.model.id,
                            //         },
                            //       );
                            //     },
                            //     child: Row(
                            //       mainAxisAlignment: MainAxisAlignment.start,
                            //       children: <Widget>[
                            //         SvgPicture.asset(
                            //           AppIcon.pluscircle,
                            //           colorFilter: const ColorFilter.mode(
                            //             AppColors.navigationSkyBlueColor,
                            //             BlendMode.srcIn,
                            //           ),
                            //           // color: AppColors.navigationSkyBlueColor,
                            //         ),
                            //         const SizedBox(width: 10),
                            //         const Text(
                            //           'Add/View Incident(S)',
                            //           style: TextStyle(
                            //             color: AppColors.navigationSkyBlueColor,
                            //             decoration: TextDecoration.underline,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            //   CommonWidgets.verticalSpacerWidget(height * 0.01),
                            // ],
                            if (state.model.status ==
                                ConstantsIntValue.destroyRejected) ...[
                              /// Rejection Comment
                              CommonWidgets.horizentaltextHandling(
                                state.labels?.locale.statusDestroyReject ??
                                    state.labels?.defaultLocale
                                        .statusDestroyReject ??
                                    Constants.rejectionComment,
                                isMandatory: true,
                                '${state.model.comment}',
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),
                            ],
                            if (state.model.id != null) ...[
                              /// Modified By
                              CommonWidgets.horizentaltextHandling(
                                state.labels?.locale.modifiedBy ??
                                    state.labels?.defaultLocale.modifiedBy ??
                                    Constants.modifiedBy,
                                isMandatory: true,
                                '${state.model.modifiedBy}',
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Modified On
                              CommonWidgets.textDisplay(
                                state.labels?.locale.modifiedDate ??
                                    state.labels?.defaultLocale.modifiedDate ??
                                    Constants.modifiedOn,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.002),
                              BaseDate().creationDateDisplay(
                                state.model.modifiedDate ?? '',
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),
                            ],
                          ],
                        ),
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      CommonWidgets.verticalSpacerWidget(height * 0.02),

                      /// SubmitButton
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          cancelButtonDisplay(state),
                          if (showSaveAndSubmitButtons) ...[
                            submitButtonDisplay()
                          ],
                        ],
                      ),

                      CommonWidgets.verticalSpacerWidget(height * 0.04),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget cancelButtonDisplay(KeyHistoryRecordsDetailsState state) {
    bool condition = widget.model?.id == null ||
        widget.model?.status == ConstantsIntValue.cancelledStatus ||
        widget.lock.isEmptyOrNull;
    return AppButton(
      width: Constants.cancelButtonWidth,
      backgroundColor: Colors.white,
      key: const Key(Keys.cancelButton),
      buttonText: condition ? Constants.close : Constants.cancelRecord,
      buttonTextKey: Keys.cancelButton,
      onTap: () {
        // updateRecordStatus(state);
        Navigator.pop(context);
        CommonServices().unlock();
      },
    );
  }

  Widget showButtonDisplay({
    required String kldId,
    bool? showPopUp,
    required KeyHistoryRecordsDetailsState state,
  }) {
    log('--kld-ogi--$kldId--');

    return AbsorbPointer(
      absorbing: false,
      child: AppButton(
        height: 40,
        width: 100,
        backgroundColor: Colors.white,
        key: const Key(Keys.showButton),
        buttonText: Constants.showList,
        buttonTextKey: Keys.showButton,
        onTap: () => {
          showPopUp ?? false
              ? openSecuritySystemSLATypePopUp(state: state, showListing: true)
              : Navigator.pushNamed(
                  context,
                  incidentManagementsRoute,
                  arguments: {'kldId': kldId},
                ),
        },
      ),
    );
  }

  openSecuritySystemSLATypePopUp({
    required KeyHistoryRecordsDetailsState state,
    required bool showListing,
  }) {
    BaseDropDown().assetTypeDialog(
      context: context,
      dropDownValues: sstIncidentType.map((label) => label.key).toList(),
      pop: false,
      onTap: (String value) {
        log('--state.model.id----${state.model.id}---');
        if (showListing) {
          // Navigate to Listing Page
          Navigator.pushNamed(
            context,
            incidentManagementsRoute,
            arguments: {
              "kldId": state.model.id.toString(), // TODO: Need to check
            },
          );
          return;
        }
      },
    );
  }

  Future<void> navigateToCreateIncident({
    required KeyHistoryRecordsDetailsState state,
  }) async {
    if (isReadOnly) {
      return;
    }
    NavigatorState nav = Navigator.of(context);
    bool isSaveSuccess = await BlocProvider.of<KeyHistoryRecordsDetailsCubit>(
      context,
    ).submitForm(isSaveOnly: true, navigateToNextScreen: true);

    // For checking validations
    if (!isSaveSuccess) {
      return;
    }
    log(
      '--state.model.id-----keyLossGi-------${state.model.id.toString()}-----',
    );

    var map = {
      ConstantsArgument.kldId: state.model.id.toString(),
      ConstantsArgument.keyType: state.model.keyType,
      ConstantsArgument.keyLostType: state.model.type,
      ConstantsArgument.keyIssuanceId: widget.parentId,
      ConstantsArgument.kmId: widget.parentId,
      ConstantsArgument.location: state.keyManagementMasterModel?.location,
    };
    nav.pushNamed(incidentManagementDetailsRoute, arguments: map);
  }

  // void updateRecordStatus(KeyHistoryRecordsDetailsState state) {
  //   if (state.model.id != null) {
  //     BlocProvider.of<KeyHistoryRecordsDetailsCubit>(context)
  //         .updateStatus(id: state.model.keyManagementId.toString(),type: widget.type);
  //     Navigator.popAndPushNamed(context, keyHistoryRecordsViewRoute);
  //   } else {
  //     Navigator.pop(context);
  //   }
  // }

  Widget submitButtonDisplay() {
    return AppButton(
      width: 150,
      key: const Key(Keys.submitButton),
      buttonText: Constants.submit,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        FocusScope.of(context).unfocus();
        BlocProvider.of<KeyHistoryRecordsDetailsCubit>(
          context,
        ).submitForm(isSaveOnly: false);
      },
    );
  }
}
