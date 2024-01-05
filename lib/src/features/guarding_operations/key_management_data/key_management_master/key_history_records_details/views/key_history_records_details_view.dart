import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/key_management_master_details/cubits/key_management_master_details_cubit.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/models/key_management_master_model.dart';

import '../cubits/key_history_records_details_cubit.dart';

class KeyHistoryRecordsDetailsView extends StatefulWidget {
  final KeyManagementMasterModel? model;
  final String title;

  const KeyHistoryRecordsDetailsView({
    super.key,
    this.model,
    required this.title,
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
        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: 'Key Management Master',
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popAndPushNamed(
                context,
                keyHistoryRecordsViewRoute,
                arguments: {},
              );
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
                            isDisabled: state.model.status != 6,
                            textController: statusController,
                            items: keyManagementStatus,
                            initialValue: '${state.model.status ?? 0}',
                            onTap: () {
                              if (widget.model != null) {
                                BaseDropDown().assetTypeDialog(
                                  context: context,
                                  dropDownValues: statusDropDownValues
                                      .map((label) => label.key)
                                      .toList(),
                                  onTap: (String value) {
                                    Label? selectedLabel;
                                    selectedLabel =
                                        statusDropDownValues.firstWhere(
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

                          /// Floor
                          CommonWidgets.textDisplay(
                              //  state.labels?.locale.guardingPOC ??
                              // state.labels?.defaultLocale.guardingPOC ??
                              Constants.floor,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            keyboardType: TextInputType.text,
                            initialValue: state.model.floor,
                            textFormKey: Keys.guardingPOCKey,
                            hintText: '',
                            isEnable: true,
                            isDisableColor: false,
                            onChange: (String value) {
                              state.model.floor = value;
                              context
                                  .read<KeyHistoryRecordsDetailsCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
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
                              items: keysDropDownValues,
                              initialValue: state.model.keyType.toString(),
                              onTap: () {
                                //  if (isDisabled) {
                                BaseDropDown().assetTypeDialog(
                                    context: context,
                                    dropDownValues: keysDropDownValues
                                        .map((label) => label.key)
                                        .toList(),
                                    onTap: (String value) {
                                      Label? selectedLabel;
                                      selectedLabel =
                                          keysDropDownValues.firstWhere(
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

                          /// Key Type
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
                              items: keysDropDownValues,
                              initialValue: state.model.keyType.toString(),
                              onTap: () {
                                //  if (isDisabled) {
                                BaseDropDown().assetTypeDialog(
                                    context: context,
                                    dropDownValues: keysDropDownValues
                                        .map((label) => label.key)
                                        .toList(),
                                    onTap: (String value) {
                                      Label? selectedLabel;
                                      selectedLabel =
                                          keysDropDownValues.firstWhere(
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
                          /// Key Description
                          CommonWidgets.textDisplay(
                              //state.labels?.locale.employeeCode ??
                              //state.labels?.defaultLocale.employeeCode ??
                              Constants.keyDescription,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            keyboardType: TextInputType.number,
                            initialValue: state.model.doorName,
                            textFormKey: Keys.guardingAgencyKey,
                            hintText: '',
                            isEnable: widget.model == null
                                ? true
                                : (widget.model != null &&
                                        (widget.model?.doorName == null))
                                    ? false
                                    : true,
                            isDisableColor: false,
                            onChange: (String value) {
                              state.model.doorName = value;
                              context
                                  .read<KeyHistoryRecordsDetailsCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Door Has Access Control
                          CommonWidgets.textDisplay(
                              // state.labels?.locale.deploymentOrderSubmitted ??
                              //   state.labels?.defaultLocale
                              //     .deploymentOrderSubmitted ??
                              Constants.doorHasAccessControl,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          RadioButtonsYesNo(
                              status: state.model.status ?? 0,
                              selectedValue:
                                  state.model.doorAccessControl ? 1 : 0,
                              onChangedYes: widget.model?.status == 6
                                  ? null
                                  : (val) {
                                      state.model.doorAccessControl = true;
                                      BlocProvider.of<
                                                  KeyHistoryRecordsDetailsCubit>(
                                              context)
                                          .onCheckBoxChange(state.model);
                                    },
                              onChangedNo: widget.model?.status == 6
                                  ? null
                                  : (val) {
                                      state.model.doorAccessControl = false;
                                      BlocProvider.of<
                                                  KeyHistoryRecordsDetailsCubit>(
                                              context)
                                          .onCheckBoxChange(state.model);
                                    }),

                          /// Door Has Lock And Key Mechanism
                          CommonWidgets.textDisplay(
                              // state.labels?.locale.deploymentOrderSubmitted ??
                              //   state.labels?.defaultLocale
                              //     .deploymentOrderSubmitted ??
                              Constants.doorHasLockAndKeyMechanism,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          RadioButtonsYesNo(
                              status: state.model.status ?? 0,
                              selectedValue: state.model.doorLockKey ? 1 : 0,
                              onChangedYes: widget.model?.status == 6
                                  ? null
                                  : (val) {
                                      state.model.doorLockKey = true;
                                      BlocProvider.of<
                                                  KeyHistoryRecordsDetailsCubit>(
                                              context)
                                          .onCheckBoxChange(state.model);
                                    },
                              onChangedNo: widget.model?.status == 6
                                  ? null
                                  : (val) {
                                      state.model.doorLockKey = false;
                                      BlocProvider.of<
                                                  KeyHistoryRecordsDetailsCubit>(
                                              context)
                                          .onCheckBoxChange(state.model);
                                    }),

                          /// Key No
                          CommonWidgets.textDisplay(
                              //state.labels?.locale.employeeCode ??
                              //state.labels?.defaultLocale.employeeCode ??
                              Constants.keyNo,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            keyboardType: TextInputType.text,
                            initialValue: state.model.keyNo,
                            textFormKey: Keys.guardingAgencyKey,
                            hintText: '',
                            isEnable: widget.model == null
                                ? true
                                : (widget.model != null &&
                                        (widget.model?.keyNo == null))
                                    ? false
                                    : true,
                            isDisableColor: false,
                            onChange: (String value) {
                              state.model.keyNo = value;
                              context
                                  .read<KeyHistoryRecordsDetailsCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          // /// Key Tagging Done?
                          // CommonWidgets.textDisplay(
                          //     //state.labels?.locale.gender ??
                          //     //  state.labels?.defaultLocale.gender ??
                          //     Constants.keyTaggingDone,
                          //     isMandatory: true,
                          //     Styles.textStyleBlack14),
                          // CommonWidgets.verticalSpacerWidget(height * 0.001),
                          // CommonWidgets.verticalSpacerWidget(height * 0.001),
                          // BaseDropDown().getDropDown(
                          //     isDisabled: state.model.status != 6,
                          //     textController: keyTaggingController,
                          //     items: keysDropDownValues,
                          //     initialValue: state.model.keyTagging.toString(),
                          //     onTap: () {
                          //       //  if (isDisabled) {
                          //       BaseDropDown().assetTypeDialog(
                          //           context: context,
                          //           dropDownValues: keysDropDownValues
                          //               .map((label) => label.key)
                          //               .toList(),
                          //           onTap: (String value) {
                          //             Label? selectedLabel;
                          //             selectedLabel =
                          //                 keysDropDownValues.firstWhere(
                          //               (label) => label.key == value,
                          //               orElse: () =>
                          //                   const Label(key: '', value: ''),
                          //             );
                          //             BlocProvider.of<
                          //                         KeyHistoryRecordsDetailsCubit>(
                          //                     context)
                          //                 .updateDropdownValues(
                          //                     keyType: int.tryParse(
                          //                         selectedLabel.value));
                          //           });
                          //       //}
                          //     }),
                          // CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// No. of  Keys
                          CommonWidgets.textDisplay(
                              //state.labels?.locale.employeeCode ??
                              //state.labels?.defaultLocale.employeeCode ??
                              Constants.noOfKeys,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            keyboardType: TextInputType.text,
                            initialValue: '${state.model.noKeys}',
                            textFormKey: Keys.guardingAgencyKey,
                            hintText: '',
                            isEnable: widget.model == null
                                ? true
                                : (widget.model != null &&
                                        (widget.model?.noKeys == null))
                                    ? false
                                    : true,
                            isDisableColor: false,
                            onChange: (String value) {
                              state.model.noKeys = int.tryParse(value);
                              context
                                  .read<KeyHistoryRecordsDetailsCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// No. of  Master Keys
                          CommonWidgets.textDisplay(
                              //state.labels?.locale.employeeCode ??
                              //state.labels?.defaultLocale.employeeCode ??
                              Constants.noOfMasterKeys,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            keyboardType: TextInputType.text,
                            initialValue: '${state.model.noMasterKey}',
                            textFormKey: Keys.guardingAgencyKey,
                            hintText: '',
                            isEnable: widget.model == null
                                ? true
                                : (widget.model != null &&
                                        (widget.model?.noMasterKey == null))
                                    ? false
                                    : true,
                            isDisableColor: false,
                            onChange: (String value) {
                              state.model.noMasterKey = int.tryParse(value);
                              context
                                  .read<KeyHistoryRecordsDetailsCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///total
                          CommonWidgets.textDisplay(
                              // state.labels?.locale.budget ??
                              //     state.labels?.defaultLocale.budget ??
                              Constants.totalKeys,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            keyboardType: TextInputType.number,
                            initialValue: '',
                            // (state.model.noKeys.toString()) +
                            //     (state.model.noKeys) +
                            //     (state.model.noMasterKey ?? 0),
                            textFormKey: Keys.budgetKey,
                            hintText: '',
                            isEnable: !isDisabled,
                            isDisableColor: isDisabled,
                            onChange: (String value) {
                              state.model.total = value;
                              context
                                  .read<KeyHistoryRecordsDetailsCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// How And Where The Keys Are Stored
                          CommonWidgets.textDisplay(
                              //state.labels?.locale.employeeCode ??
                              //state.labels?.defaultLocale.employeeCode ??
                              Constants.howAndWhereTheKeysAreStored,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            keyboardType: TextInputType.text,
                            initialValue: state.model.keysStored,
                            textFormKey: Keys.guardingAgencyKey,
                            hintText: '',
                            isEnable: widget.model == null
                                ? true
                                : (widget.model != null &&
                                        (widget.model?.keysStored == null))
                                    ? false
                                    : true,
                            isDisableColor: false,
                            onChange: (String value) {
                              state.model.keysStored = value;
                              context
                                  .read<KeyHistoryRecordsDetailsCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          CommonWidgets.verticalSpacerWidget(height * 0.02),

                          /// SubmitButton
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              cancelButtonDisplay(),
                              submitButtonDisplay()
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
