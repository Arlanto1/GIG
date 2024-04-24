import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_loss_destruction_list/key_loss_destruction_details/cubits/key_loss_destruction_details_cubit.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_loss_destruction_list/models/key_loss_destruction_list_model.dart';

import '../../../../../material_movement/material_movement_details/views/addRejectionCommnetPopUp.dart';

class KeyLossDestructionDetailsView extends StatefulWidget {
  final KeyLossDestructionListModel? model;
  final String title;
  final int type;

  const KeyLossDestructionDetailsView({
    super.key,
    this.model,
    required this.title,
    required this.type,
  });

  @override
  State<KeyLossDestructionDetailsView> createState() =>
      _KeyLossDestructionDetailsViewState();
}

class _KeyLossDestructionDetailsViewState
    extends State<KeyLossDestructionDetailsView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User? userDetails;
  TextEditingController keyTypeController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  bool isDisabled = true;
  bool isReadOnly = false;
  final FocusNode floorFocusNode = FocusNode();
  final FocusNode keyDescriptionFocusNode = FocusNode();
  final FocusNode noOfKeysFocusNode = FocusNode();

  get guardingMasterData => null;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<KeyLossDestructionDetailsCubit>(context).initializeValues();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return BlocConsumer<KeyLossDestructionDetailsCubit,
        KeyLossDestructionDetailsState>(
      listener: (context, state) {
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);

        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: 'Key Loss Destruction List',
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popAndPushNamed(
                context,
                keyManagementMasterListRoute,
                arguments: {},
              );
            },
          );
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => dialog);
        }
      },
      builder: (context, state) {
        // if (state.model.status == 6 || !state.model.lock.isEmptyOrNull) {
        //   isReadOnly = true;
        // }
        isReadOnly = state.isReadOnly ?? true;

        if (state.model.status == null) {
          isReadOnly = false;
        }

        initializeDates();
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.title,
            showPopUp: false,
            showSaveButton: state.model.status != 7 && !isReadOnly,
            showSubmitButton: state.model.status != 7 && !isReadOnly,
            showDisLikeButton: state.model.status == 7 && !isReadOnly,
            showLikeButton: state.model.status == 7 && !isReadOnly,
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<KeyLossDestructionDetailsCubit>(context)
                  .submitForm(isSaveOnly: true);
            },
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<KeyLossDestructionDetailsCubit>(context)
                  .submitForm(isSaveOnly: false);
            },
            onTapLikeButton: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<KeyLossDestructionDetailsCubit>(context)
                  .submitForm(
                isApprovedOnly: true,
                isSaveOnly: false,
                isRejectOnly: false,
              );
            },
            onTapDislikeButton: () {
              // FocusScope.of(context).unfocus();
              showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return AddRejectionCommentPopUp(
                    mainContext: context,
                    onSubmit: (value) {
                      log('--value--$value--');
                      // state.model.rejectionComment = value;
                      // BlocProvider.of<KeyHistoryRecordsDetailsCubit>(context)
                      //     .onAddRejectionComment(value);

                      BlocProvider.of<KeyLossDestructionDetailsCubit>(context)
                          .submitForm(
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
          backgroundColor: AppColors.backgroundWhitecolor,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void initializeDates() {}

  getBodybuilder(KeyLossDestructionDetailsState state, height) {
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }
    return Container(
      color: AppColors.navigationSkybluecolor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 0.01,
              color: AppColors.navigationSkybluecolor,
            ),
            Container(
              decoration: const ShapeDecoration(
                  color: AppColors.backgroundWhitecolor,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.0)),
                  )),
              child: AbsorbPointer(
                absorbing: isReadOnly,
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
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                Constants.generalinformation,
                                style: Styles.styleHeaderGreyText16,
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Status
                            CommonWidgets.textDisplay(
                                state.labels?.locale.status ??
                                    state.labels?.defaultLocale.status ??
                                    Constants.status,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDropDown().getDropDown(
                              isDisabled: true,
                              textController: statusController,
                              items: keyManagementHistoryStatus,
                              initialValue: '${state.model.status ?? 0}',
                              onTap: () {
                                if (!isDisabled) {
                                  BaseDropDown().assetTypeDialog(
                                    context: context,
                                    dropDownValues: keyManagementHistoryStatus
                                        .map((label) => label.key)
                                        .toList(),
                                    onTap: (String value) {
                                      Label? selectedLabel;
                                      selectedLabel =
                                          keyManagementHistoryStatus.firstWhere(
                                        (label) => label.key == value,
                                        orElse: () =>
                                            const Label(key: '', value: ''),
                                      );
                                      BlocProvider.of<
                                                  KeyLossDestructionDetailsCubit>(
                                              context)
                                          .updateDropdownValues(
                                              status: int.tryParse(
                                                  selectedLabel.value));
                                    },
                                  );
                                }
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Created By
                            CommonWidgets.horizentaltextHandling(
                                state.labels?.locale.entrySecurity ??
                                    state.labels?.defaultLocale.entrySecurity ??
                                    Constants.createdby,
                                isMandatory: true,
                                '${state.model.createdBy?.firstName ?? ''} ${state.model.createdBy?.lastName ?? ''}'),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Date of creation
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.inputDate ??
                                //     state.labels?.defaultLocale.inputDate ??
                                Constants.dateofcreation,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDate().creationDateDisplay(
                                state.model.createdDate ?? ''),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Sl No.
                            CommonWidgets.horizentaltextHandling(
                              state.labels?.locale.slNo ??
                                  state.labels?.defaultLocale.slNo ??
                                  Constants.slno,
                              state.model.slNo ?? '',
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Key Type
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.keyType ??
                              //     state.labels?.defaultLocale.keyType ??
                              Constants.keyType,
                              isMandatory: true,
                              Styles.textStyleBlack14,
                            ),
                            BaseDropDown().getDropDown(
                                isDisabled: false,
                                textController: keyTypeController,
                                items: keyTypeDropDownValues,
                                initialValue: state.model.keyType.toString(),
                                onTap: () {
                                  if (isReadOnly) {
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
                                          BlocProvider.of<
                                                      KeyLossDestructionDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                                  keyType: int.tryParse(
                                                      selectedLabel.value));
                                        });
                                  }
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Type
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.type ??
                              //  state.labels?.defaultLocale.type ??
                              Constants.type,
                              isMandatory: true,
                              Styles.textStyleBlack14,
                            ),
                            BaseDropDown().getDropDown(
                                isDisabled: true,
                                textController: typeController,
                                items: typesDropDownValues,
                                initialValue: '${state.model.type}',
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
                                                      KeyLossDestructionDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                                  type: int.tryParse(
                                                      selectedLabel.value));
                                        });
                                  }
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                            if (state.model.type ==
                                ConstantsIntValue.keyDamageHistoryInt) ...[
                              /// SRH
                              CommonWidgets.textDisplay(
                                  // state.labels?.locale.srh ??
                                  //     state.labels?.defaultLocale.srh ??
                                  Constants.srh,
                                  Styles.textStyleBlack14,
                                  isMandatory: true),
                              TextFieldAddButton(
                                title: state.model.srh?.userInfo,
                                height: 60,
                                isDisableColor: isReadOnly,
                                onTap: () {
                                  BaseOrganisationDialog().userDialog(
                                    context: context,
                                    enabled: !isReadOnly,
                                    users: state.srh,
                                    onTap: (BaseUser user) {
                                      BlocProvider.of<
                                                  KeyLossDestructionDetailsCubit>(
                                              context)
                                          .updateDropdownValues(
                                        srh: user,
                                      );
                                    },
                                    functionToCall: () {
                                      // refresh the list
                                      BlocProvider.of<
                                                  KeyLossDestructionDetailsCubit>(
                                              context)
                                          .refreshList();
                                    },
                                  );
                                },
                              ),

                              /// Details of Lost Key
                              CommonWidgets.textDisplay(
                                  // state.labels?.locale.additionalInformation ??
                                  //     state.labels?.defaultLocale
                                  //         .additionalInformation ??
                                  Constants.detailsOfLostKey,
                                  Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                lineHeight: 6,
                                initialValue: state.model.lostKeyDetails,
                                textFormKey: Keys.additionInitiativesKey,
                                hintText: Constants.informationhere,
                                showBorder: true,
                                isEnable: state.model.status != 6,
                                isDisableColor: isReadOnly,
                                onChange: (String value) {
                                  state.model.lostKeyDetails = value;
                                  context
                                      .read<KeyLossDestructionDetailsCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                            ],

                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                            if (state.model.type ==
                                ConstantsIntValue.keyDestroyHistoryInt) ...[
                              /// Security Manager
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.securityManager ??
                                //     state.labels?.defaultLocale.securityManager ??
                                Constants.securityManager,
                                Styles.textStyleBlack14,
                                isMandatory: true,
                              ),
                              TextFieldAddButton(
                                title:
                                    '${state.model.securityManager?.userName}',
                                height: 70,
                                isDisableColor: state.model.status != null &&
                                    state.model.status != 0 &&
                                    isReadOnly,
                                onTap: () {
                                  if (state.model.status == 0 ||
                                      state.model.status == null ||
                                      !isReadOnly) {
                                    BaseOrganisationDialog().userDialog(
                                      context: context,
                                      users: state.securityManager,
                                      onTap: (BaseUser user) {
                                        BlocProvider.of<
                                                    KeyLossDestructionDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                          securityManager: user,
                                        );
                                      },
                                      functionToCall: () {
                                        // refresh the list
                                        BlocProvider.of<
                                                    KeyLossDestructionDetailsCubit>(
                                                context)
                                            .refreshList();
                                      },
                                    );
                                  }
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Reason for Key Destruction
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.destructionReason ??
                                //     state.labels?.defaultLocale.destructionReason ??
                                Constants.destructionReason,
                                isMandatory: true,
                                Styles.textStyleBlack14,
                              ),
                              TextFieldAddButton(
                                title: '${state.model.destructionReason?.name}',
                                height: 70,
                                isDisableColor: state.model.status != null &&
                                    state.model.status != 0 &&
                                    isReadOnly,
                                onTap: () {
                                  if (state.model.status == 0 ||
                                      state.model.status == null ||
                                      !isReadOnly) {
                                    BaseOrganisationDialog().departmentDialog(
                                      context: context,
                                      organisations: state.destructionReasons,
                                      onTap: (Organisation department) {
                                        BlocProvider.of<
                                                    KeyLossDestructionDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                                destructionReason: department);
                                      },
                                    );
                                  }
                                },
                              ),

                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                            ],

                            /// No. of  Keys
                            CommonWidgets.textDisplay(
                                //state.labels?.locale.employeeCode ??
                                //state.labels?.defaultLocale.employeeCode ??
                                Constants.noOfKeys,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              textInputType: TextInputType.number,
                              initialValue: '${state.model.noOfKeys ?? ''}',
                              textFormKey: Keys.guardingAgencyKey,
                              hintText: '',
                              focusNode: noOfKeysFocusNode,
                              isEnable: isReadOnly,
                              isDisableColor: !isReadOnly,
                              onChange: (String value) {
                                state.model.noOfKeys = int.tryParse(value);

                                int noKeys = state.model.noOfKeys ?? 0;
                                // int noMasterKey = state.model.noMasterKey ?? 0;
                                // totalKeyController.text =
                                //     (noKeys + noMasterKey).toString();
                                // widget.model?.total =
                                //     int.tryParse(totalKeyController.text);
                                context
                                    .read<KeyLossDestructionDetailsCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Additional Information
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.additionalInformation ??
                                //     state.labels?.defaultLocale
                                //         .additionalInformation ??
                                Constants.additionalinformation,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              lineHeight: 6,
                              initialValue: state.model.additionalInformation,
                              textFormKey: Keys.additionInitiativesKey,
                              hintText: Constants.informationhere,
                              showBorder: true,
                              isDisableColor: isReadOnly,
                              onChange: (String value) {
                                state.model.additionalInformation = value;
                                context
                                    .read<KeyLossDestructionDetailsCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                            if (widget.type ==
                                    ConstantsIntValue.keyLostHistoryInt ||
                                widget.type ==
                                    ConstantsIntValue.keyDamageHistoryInt) ...[
                              /// Investigation Required
                              // if (widget.type ==
                              //     ConstantsIntValue.keyLostHistoryInt ||
                              //     widget.type ==
                              //         ConstantsIntValue.keyDamageHistoryInt) ...[
                              CommonWidgets.textDisplay(
                                  // state.labels?.locale.investigationRequired ??
                                  //     state.labels?.defaultLocale
                                  //         .investigationRequired ??
                                  Constants.investigationRequired,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              RadioButtonsYesNo(
                                  status: state.model.status ?? 0,
                                  selectedValue:
                                      state.model.investigationRequired ? 1 : 0,
                                  onChangedYes: isReadOnly
                                      ? null
                                      : (val) {
                                          state.model.investigationRequired =
                                              true;
                                          BlocProvider.of<
                                                      KeyLossDestructionDetailsCubit>(
                                                  context)
                                              .onCheckBoxChange(state.model);
                                        },
                                  onChangedNo: isReadOnly
                                      ? null
                                      : (val) {
                                          state.model.investigationRequired =
                                              false;
                                          BlocProvider.of<
                                                      KeyLossDestructionDetailsCubit>(
                                                  context)
                                              .onCheckBoxChange(state.model);
                                        }),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                            ],
                            if (state.model.investigationRequired) ...[
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  Constants.incident,
                                  style: Styles.styleHeaderGreyText16,
                                ),
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                              GestureDetector(
                                onTap: () async {
                                  NavigatorState nav = Navigator.of(context);
                                  bool isSaveSuccess = await BlocProvider.of<
                                              KeyLossDestructionDetailsCubit>(
                                          context)
                                      .submitForm(
                                    isSaveOnly: true,
                                    navigateToNextScreen: true,
                                  );
                                  if (!isSaveSuccess) {
                                    return;
                                  }
                                  nav.pushNamed(
                                    incidentManagementDetailsRoute,
                                    arguments: {
                                      ConstantsArgument.title:
                                          Constants.incident,
                                      ConstantsArgument.id: state.model.id,
                                      // ConstantsArgument.type:
                                      //     ConstantsIntValue.lockChangeHistoryInt,
                                    },
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      AppIcon.pluscircle,
                                      color: AppColors.navigationSkybluecolor,
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      'Add/View Incident(S)',
                                      style: TextStyle(
                                        color: AppColors.navigationSkybluecolor,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                            ],
                            if (state.model.id != null) ...[
                              /// Modified By
                              CommonWidgets.horizentaltextHandling(
                                  // state.labels?.locale.modifiedBy ??
                                  //     state.labels?.defaultLocale.modifiedBy ??
                                  Constants.modifiedBy,
                                  isMandatory: true,
                                  '${state.model.modifiedBy ?? ''} '),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Modified On
                              CommonWidgets.textDisplay(
                                  // state.labels?.locale.modifiedDate ??
                                  //     state.labels?.defaultLocale.modifiedDate ??
                                  Constants.modifiedOn,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              BaseDate().creationDateDisplay(
                                  state.model.modifiedDate ?? ''),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                            ],

                            /// SubmitButton
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                cancelButtonDisplay(state),
                                if (!isReadOnly) ...[submitButtonDisplay()],
                              ],
                            ),

                            CommonWidgets.verticalSpacerWidget(height * 0.04),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cancelButtonDisplay(KeyLossDestructionDetailsState state) {
    return AppButton(
      // Customize the button properties as needed
      width: 150,
      backgroundColor: Colors.white,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.cancel,
      buttonTextKey: Keys.cancelButton,
      onTap: () {
        updateRecordStatus(state);
      },
    );
  }

  void updateRecordStatus(KeyLossDestructionDetailsState state) {
    if (state.model.id != null) {
      BlocProvider.of<KeyLossDestructionDetailsCubit>(context)
          .updateStatus(id: state.model.id.toString());
      Navigator.popAndPushNamed(context, keyManagementMasterListRoute);
    } else {
      Navigator.pop(context);
    }
  }

  Widget submitButtonDisplay() {
    return AppButton(
      width: 150,
      key: const Key(Keys.submitButton),
      buttonText: Constants.submit,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        FocusScope.of(context).unfocus();
        BlocProvider.of<KeyLossDestructionDetailsCubit>(context)
            .submitForm(isSaveOnly: false);
      },
    );
  }
}
