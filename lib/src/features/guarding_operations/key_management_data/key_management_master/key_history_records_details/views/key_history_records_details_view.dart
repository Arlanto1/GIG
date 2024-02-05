import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/key_management_master_details/cubits/key_management_master_details_cubit.dart';

import '../cubits/key_history_records_details_cubit.dart';

class KeyHistoryRecordsDetailsView extends StatefulWidget {
  final KeyManagementMasterModel? model;
  final String title;
  final int type;
  final int parentId;

  const KeyHistoryRecordsDetailsView({
    super.key,
    this.model,
    required this.title,
    required this.type,
    required this.parentId,
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

  get guardingMasterData => null;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<KeyHistoryRecordsDetailsCubit>(context).initializeValues();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return BlocConsumer<KeyHistoryRecordsDetailsCubit,
        KeyHistoryRecordsDetailsState>(
      listener: (context, state) {
        log('--widget.type--${widget.type}--');
        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: 'Key Management Master',
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              // Navigator.pop(context);
              Navigator.popAndPushNamed(context, keyHistoryRecordsViewRoute,
                  arguments: {
                    ConstantsArgument.id: widget.parentId,
                    ConstantsArgument.type: widget.type,
                    ConstantsArgument.title: widget.title,
                  });
            },
          );
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => dialog);

          // Utils.dynamicAlert(
          //     context, state.message ?? '', 'Material Movement', '');
        }
        if (state.status == FormStatus.error) {
          Validator().showToast(
            context,
            state.message ?? 'Invalid Information',
          );
        }
      },
      builder: (context, state) {
        // if (state.model.status == 6 || !state.model.lock.isEmptyOrNull) {
        //   isReadOnly = true;
        // }
        if (state.model.status == null) {
          isReadOnly = false;
        }

        initializeDates();
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.title,
            showPopUp: false,
            showSaveButton: state.model.status != 5 ? true : false,
            showSubmitButton: state.model.status != 5 ? true : false,
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<KeyHistoryRecordsDetailsCubit>(context)
                  .submitForm(isSaveOnly: true);
            },
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<KeyHistoryRecordsDetailsCubit>(context)
                  .submitForm(isSaveOnly: false);
            },
          ),
          backgroundColor: AppColors.backgroundWhitecolor,
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
                      child: Column(children: [
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
                          isDisabled:true,
                          textController: statusController,
                          items: keyManagementHistoryStatus,
                          initialValue: '${state.model.status ?? 0}',
                          onTap: () {
                            if (state.model.status ==null) {
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
                                              KeyHistoryRecordsDetailsCubit>(
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
                            '${state.loggedInUserDetails?.firstName ?? ''} ${state.loggedInUserDetails?.lastName ?? ''}'),
                        CommonWidgets.verticalSpacerWidget(height * 0.01),

                        /// Date of creation
                        CommonWidgets.textDisplay(
                            // state.labels?.locale.inputDate ??
                            //     state.labels?.defaultLocale.inputDate ??
                            Constants.dateofcreation,
                            isMandatory: true,
                            Styles.textStyleBlack14),
                        CommonWidgets.verticalSpacerWidget(height * 0.001),
                        BaseDate()
                            .creationDateDisplay(state.model.createdDate ?? ''),
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
                          //state.labels?.locale.vendor ??
                          //  state.labels?.defaultLocale.vendor ??
                          Constants.keyType,
                          isMandatory: true,
                          Styles.textStyleBlack14,
                        ),
                        BaseDropDown().getDropDown(
                            isDisabled: state.model.status != 6,
                            textController: keyTypeController,
                            items: keyTypeDropDownValues,
                            initialValue: state.model.keyType.toString(),
                            onTap: () {
                              //  if (isDisabled) {
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
                                                KeyHistoryRecordsDetailsCubit>(
                                            context)
                                        .updateDropdownValues(
                                            keyType: int.tryParse(
                                                selectedLabel.value));
                                  });
                              //}
                            }),
                        CommonWidgets.verticalSpacerWidget(height * 0.01),

                        ///Type
                        CommonWidgets.textDisplay(
                          //state.labels?.locale.vendor ??
                          //  state.labels?.defaultLocale.vendor ??
                          Constants.type,
                          isMandatory: true,
                          Styles.textStyleBlack14,
                        ),
                        BaseDropDown().getDropDown(
                            isDisabled: state.model.status != 6,
                            textController: typeController,
                            items: typesDropDownValues,
                            initialValue: state.model.type.toString(),
                            onTap: () {
                              //  if (isDisabled) {
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
                                            type: int.tryParse(
                                                selectedLabel.value));
                                  });
                              //}
                            }),
                        CommonWidgets.verticalSpacerWidget(height * 0.01),

                        if (widget.type == Constants.keyLostHistoryInt ||
                            widget.type == Constants.keyDamageHistoryInt) ...[
                          /// SRH
                          CommonWidgets.textDisplay(
                              //state.labels?.locale.approver ??
                              //  state.labels?.defaultLocale.approver ??
                              Constants.srh,
                              Styles.textStyleBlack14,
                              isMandatory: true),
                          TextfieldAddButton(
                            title: state.model.srh?.name,
                            height: 60,
                            isDisableColor: isReadOnly,
                            onTap: () {
                              BaseOrganisationDialog().userDialog(
                                context: context,
                                enabled: !isReadOnly,
                                users: state.users!,
                                onTap: (BaseUser user) {
                                  BlocProvider.of<
                                              KeyHistoryRecordsDetailsCubit>(
                                          context)
                                      .updateDropdownValues(
                                    srh: user,
                                  );
                                },
                              );
                            },
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),
                        ],

                        if (widget.type == Constants.keyDestroyHistoryInt) ...[
                          /// Security Manager
                          CommonWidgets.textDisplay(
                            //state.labels?.locale.approver ??
                            //  state.labels?.defaultLocale.approver ??
                            Constants.securityManager,
                            Styles.textStyleBlack14,
                            isMandatory: true,
                          ),
                          TextfieldAddButton(
                            title: state.model.securityManager?.name,
                            height: 60,
                            isDisableColor: isReadOnly,
                            onTap: () {
                              BaseOrganisationDialog().userDialog(
                                context: context,
                                enabled: !isReadOnly,
                                users: state.users!,
                                onTap: (BaseUser user) {
                                  BlocProvider.of<
                                              KeyHistoryRecordsDetailsCubit>(
                                          context)
                                      .updateDropdownValues(
                                    securityManager: user,
                                  );
                                },
                              );
                            },
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Reason for Key Destruction
                          CommonWidgets.textDisplay(
                            // state.labels?.locale.vendor ??
                            //     state.labels?.defaultLocale.vendor ??
                            Constants.destructionReason,
                            isMandatory: true,
                            Styles.textStyleBlack14,
                          ),
                          TextfieldAddButton(
                            title: state.model.destructionReason?.name,
                            height: 60,
                            isDisableColor: false,
                            onTap: () {
                              BaseOrganisationDialog().departmentDialog(
                                context: context,
                                organisations: state.destructionReasons,
                                onTap: (Organisation department) {
                                  BlocProvider.of<
                                              KeyHistoryRecordsDetailsCubit>(
                                          context)
                                      .updateDropdownValues(
                                          destructionReason: department);
                                },
                              );
                            },
                          ),

                          CommonWidgets.verticalSpacerWidget(height * 0.01),
                        ],

                        /// Details of Lost Keys
                        if (widget.type == Constants.keyLostHistoryInt ||
                            widget.type == Constants.keyDamageHistoryInt) ...[
                          CommonWidgets.textDisplay(
                              // state.labels?.locale.additionalinformation ??
                              //     state.labels?.defaultLocale
                              //         .additionalinformation ??
                              Constants.detailsOfLostKey,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            lineHeight: 6,
                            initialValue: state.model.lostKeyDetails,
                            textFormKey: Keys.additionInitiativesKey,
                            hintText: Constants.informationhere,
                            showBorder: true,
                            isEnable: state.model.status != 6,
                            isDisableColor: state.model.status == 6,
                            onChange: (String value) {
                              state.model.lostKeyDetails = value;
                              context
                                  .read<KeyHistoryRecordsDetailsCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),
                        ],

                        if (widget.type == Constants.lockChangeHistoryInt) ...[
                          /// No Of Keys
                          CommonWidgets.textDisplay(
                              //  state.labels?.locale.guardingPOC ??
                              // state.labels?.defaultLocale.guardingPOC ??
                              Constants.noOfKeys,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            textInputType: TextInputType.number,
                            initialValue: '${state.model.noOfKeys ?? ''}',
                            textFormKey: Keys.guardingPOCKey,
                            hintText: '',
                            isEnable: true,
                            isDisableColor: false,
                            onChange: (String value) {
                              state.model.noOfKeys = int.tryParse(value);
                              context
                                  .read<KeyHistoryRecordsDetailsCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),
                        ],

                        /// Additional Information
                        CommonWidgets.textDisplay(
                            // state.labels?.locale.additionalinformation ??
                            //     state.labels?.defaultLocale
                            //         .additionalinformation ??
                            Constants.additionalinformation,
                            isMandatory: true,
                            Styles.textStyleBlack14),
                        CommonWidgets.verticalSpacerWidget(height * 0.001),
                        FlutterInputField(
                          lineHeight: 6,
                          initialValue: state.model.additionalInformation,
                          textFormKey: Keys.additionInitiativesKey,
                          hintText: Constants.informationhere,
                          showBorder: true,
                          isEnable: state.model.status != 6,
                          isDisableColor: state.model.status == 6,
                          onChange: (String value) {
                            state.model.additionalInformation = value;
                            context
                                .read<KeyHistoryRecordsDetailsCubit>()
                                .onModelValueChange(state.model);
                          },
                          validateTextField: (String? user) {},
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.01),

                        /// Investigation Required
                        if (widget.type == Constants.keyLostHistoryInt ||
                            widget.type == Constants.keyDamageHistoryInt) ...[
                          CommonWidgets.textDisplay(
                              // state.labels?.locale.deploymentOrderSubmitted ??
                              //   state.labels?.defaultLocale
                              //     .deploymentOrderSubmitted ??
                              Constants.investigationRequired,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          RadioButtonsYesNo(
                              status: state.model.status ?? 0,
                              selectedValue:
                                  state.model.investigationRequired ? 1 : 0,
                              onChangedYes: widget.model?.status == 6
                                  ? null
                                  : (val) {
                                      state.model.investigationRequired = true;
                                      BlocProvider.of<
                                                  KeyHistoryRecordsDetailsCubit>(
                                              context)
                                          .onCheckBoxChange(state.model);
                                    },
                              onChangedNo: widget.model?.status == 6
                                  ? null
                                  : (val) {
                                      state.model.investigationRequired = false;
                                      BlocProvider.of<
                                                  KeyHistoryRecordsDetailsCubit>(
                                              context)
                                          .onCheckBoxChange(state.model);
                                    }),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),
                        ],

                        if (state.model.id != null) ...[
                          /// Modified By
                          CommonWidgets.horizentaltextHandling(
                              state.labels?.locale.entrySecurity ??
                                  state.labels?.defaultLocale.entrySecurity ??
                                  Constants.modifiedBy,
                              isMandatory: true,
                              '${state.loggedInUserDetails?.email ?? ''} '),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Modified On
                          CommonWidgets.textDisplay(
                              // state.labels?.locale.inputDate ??
                              //     state.labels?.defaultLocale.inputDate ??
                              Constants.modifiedOn,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          BaseDate().creationDateDisplay(
                              state.model.modifiedDate ?? ''),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),
                        ],
                      ]),
                    ),
                    CommonWidgets.verticalSpacerWidget(height * 0.01),
                    CommonWidgets.verticalSpacerWidget(height * 0.02),

                    /// SubmitButton
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [cancelButtonDisplay(), submitButtonDisplay()],
                    ),

                    CommonWidgets.verticalSpacerWidget(height * 0.04),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cancelButtonDisplay() {
    return AppButton(
      // Customize the button properties as needed
      width: 150,
      backgroundColor: Colors.white,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.cancel,
      buttonTextKey: Keys.cancelButton,
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  Widget submitButtonDisplay() {
    return AppButton(
      width: 150,
      key: const Key(Keys.submitButton),
      buttonText: Constants.submit,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        FocusScope.of(context).unfocus();
        BlocProvider.of<KeyManagementMasterDetailsCubit>(context)
            .submitForm(isSaveOnly: false);
      },
    );
  }

  Widget locationWidgetdislay(KeyHistoryRecordsDetailsState state) {
    return GestureDetector(
      onTap: () {
        // if (widget.occurrence == null ||
        //     (state.occurrence.location?.name ?? '').isEmpty)
        //     {
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            // print(state.getLocationsResponse);
            return CustomExpansionListTexts(
              locationList: state.locations,
              onTap: (Organisation? list) async {
                log('list?.name-----${list?.name}');

                Organisation location = Organisation();
                location.id = list?.id;
                location.name = list?.name;
                state.model.location = location;

                BlocProvider.of<KeyManagementMasterDetailsCubit>(context)
                    .updateDropdownValues(location: location);
              },
            );
          },
        );
        // }
      },
      child: SelectedTileValueWidget(name: state.model.location?.name ?? ''),
    );
  }
}
