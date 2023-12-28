import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/key_management_master_details/cubits/key_management_master_details_cubit.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/models/key_management_master_model.dart';

class KeyManagementMasterDetailsView extends StatefulWidget {
  final KeyManagementMasterModel? model;
  final String title;

  const KeyManagementMasterDetailsView({
    super.key,
    this.model,
    required this.title,
  });

  @override
  State<KeyManagementMasterDetailsView> createState() =>
      _KeyManagementMasterDetailsViewState();
}

class _KeyManagementMasterDetailsViewState
    extends State<KeyManagementMasterDetailsView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User? userDetails;
  TextEditingController genderController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  bool isDisabled = true;
  bool isReadOnly = false;

  get guardingMasterData => null;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<KeyManagementMasterDetailsCubit>(context)
        .initializeValues();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return BlocConsumer<KeyManagementMasterDetailsCubit,
        KeyManagementMasterDetailsState>(
      listener: (context, state) {
        log('-state.status---${state.status}----');
        log('-deploymentOrderSubmitted---${state.model.deploymentOrderSubmitted}----');

        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: 'Key Management Master',
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPostivePressed: () {
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
        if (state.model.status == 6 || !state.model.lock.isEmptyOrNull) {
          isReadOnly = true;
        }
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
              BlocProvider.of<KeyManagementMasterDetailsCubit>(context)
                  .submitForm(isSaveOnly: true);
            },
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<KeyManagementMasterDetailsCubit>(context)
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

  getBodybuilder(KeyManagementMasterDetailsState state, height) {
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
                          if (!state.model.lock.isEmptyOrNull) ...[
                            RecordLockedWidget(text: '${state.model.lock}'),
                          ],
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
                            items: statusDropDownValues,
                            initialValue: '${state.model.status ?? 1}',
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
                                                KeyManagementMasterDetailsCubit>(
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
                              state.labels?.locale.inputDate ??
                                  state.labels?.defaultLocale.inputDate ??
                                  Constants.dateofcreation,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          BaseDate()
                              .creationDateDisplay(state.model.inputDate ?? ''),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Location
                          CommonWidgets.textDisplay(
                              //state.labels?.locale.location ??
                                //  state.labels?.defaultLocale.location ??
                                  Constants.location,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          locationWidgetdislay(state),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Entity
                          CommonWidgets.textDisplay(
                            Constants.entity,
                            isMandatory: true,
                            Styles.textStyleBlack14,
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),

                          TextfieldAddButton(
                              title: state.model.entity?.name ?? '',
                              height: 70,
                              isDisableColor: false,
                              onTap: () {
                                BaseDepartmentDialog().userDialog(
                                  context: context,
                                  entities: state.listOfEntities,
                                  // TODO: Need to change EntrySecurity to BaseUser
                                  onTap: (Organisation entity) {
                                    BlocProvider.of<
                                                KeyManagementMasterDetailsCubit>(
                                            context)
                                        .updateDropdownValues(
                                      entity: entity,
                                    );
                                  },
                                );
                              }),
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
                            initialValue: state.model.guardingPOC,
                            textFormKey: Keys.guardingPOCKey,
                            hintText: '',
                            isEnable: true,
                            isDisableColor: false,
                            onChange: (String value) {
                              state.model.guardingPOC = value;
                              context
                                  .read<KeyManagementMasterDetailsCubit>()
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
                          TextfieldAddButton(
                            title: state.model.vendor?.name,
                            height: 60,
                            isDisableColor: false,
                            onTap: () {
                              BaseDepartmentDialog().departmentDialog(
                                context: context,
                                departments: state.departments,
                                onTap: (Organisation department) {
                                  BlocProvider.of<
                                              KeyManagementMasterDetailsCubit>(
                                          context)
                                      .updateDropdownValues(vendor: department);
                                },
                              );
                            },
                          ),

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
                            initialValue: state.model.employeeCode,
                            textFormKey: Keys.guardingAgencyKey,
                            hintText: '',
                            isEnable: widget.model == null
                                ? true
                                : (widget.model != null &&
                                        (widget.model?.employeeCode == null))
                                    ? false
                                    : true,
                            isDisableColor: false,
                            onChange: (String value) {
                              state.model.employeeCode = value;
                              context
                                  .read<KeyManagementMasterDetailsCubit>()
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
                                state.model.deploymentOrderSubmitted ? 1 : 0,
                            onChangedYes: widget.model?.status == 6
                                ? null
                                : (val) {
                                    state.model.deploymentOrderSubmitted = true;
                                    BlocProvider.of<
                                                KeyManagementMasterDetailsCubit>(
                                            context)
                                        .showFields(
                                            deploymentOrderSubmitted: true);
                                    //.onModelValueChange(state.guardingMasterData
                                    //);
                                  },
                            onChangedNo: widget.model?.status == 4
                                ? null
                                : (val) {
                                    state.model.deploymentOrderSubmitted =
                                        false;
                                    BlocProvider.of<
                                                KeyManagementMasterDetailsCubit>(
                                            context)
                                        .showFields(
                                            deploymentOrderSubmitted: false);
                                  },
                          ),

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
                            selectedValue:
                                state.model.deploymentOrderSubmitted ? 1 : 0,
                            onChangedYes: widget.model?.status == 6
                                ? null
                                : (val) {
                                    state.model.deploymentOrderSubmitted = true;
                                    BlocProvider.of<
                                                KeyManagementMasterDetailsCubit>(
                                            context)
                                        .showFields(
                                            deploymentOrderSubmitted: true);
                                    //.onModelValueChange(state.guardingMasterData
                                    //);
                                  },
                            onChangedNo: widget.model?.status == 4
                                ? null
                                : (val) {
                                    state.model.deploymentOrderSubmitted =
                                        false;
                                    BlocProvider.of<
                                                KeyManagementMasterDetailsCubit>(
                                            context)
                                        .showFields(
                                            deploymentOrderSubmitted: false);
                                  },
                          ),

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
                            initialValue: state.model.employeeCode,
                            textFormKey: Keys.guardingAgencyKey,
                            hintText: '',
                            isEnable: widget.model == null
                                ? true
                                : (widget.model != null &&
                                        (widget.model?.employeeCode == null))
                                    ? false
                                    : true,
                            isDisableColor: false,
                            onChange: (String value) {
                              state.model.employeeCode = value;
                              context
                                  .read<KeyManagementMasterDetailsCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Key Tagging Done?
                          CommonWidgets.textDisplay(
                              //state.labels?.locale.gender ??
                              //  state.labels?.defaultLocale.gender ??
                              Constants.keyTaggingDone,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          BaseDropDown().getDropDown(
                            isDisabled: state.model.status != 6,
                            textController: genderController,
                            items: genderDropDownValues,
                            initialValue: state.model.gender.toString(),
                            onTap: () {
                              if (isDisabled) {
                                BaseDropDown().assetTypeDialog(
                                  context: context,
                                  dropDownValues: genderDropDownValues
                                      .map((label) => label.key)
                                      .toList(),
                                  onTap: (String value) {
                                    Label? selectedLabel;
                                    selectedLabel =
                                        genderDropDownValues.firstWhere(
                                      (label) => label.key == value,
                                      orElse: () =>
                                          const Label(key: '', value: ''),
                                    );
                                    BlocProvider.of<
                                                KeyManagementMasterDetailsCubit>(
                                            context)
                                        .updateDropdownValues(
                                            gender: int.tryParse(
                                                selectedLabel.value));
                                  },
                                );
                              }
                            },
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

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
                            initialValue: state.model.employeeCode,
                            textFormKey: Keys.guardingAgencyKey,
                            hintText: '',
                            isEnable: widget.model == null
                                ? true
                                : (widget.model != null &&
                                        (widget.model?.employeeCode == null))
                                    ? false
                                    : true,
                            isDisableColor: false,
                            onChange: (String value) {
                              state.model.employeeCode = value;
                              context
                                  .read<KeyManagementMasterDetailsCubit>()
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
                            initialValue: state.model.employeeCode,
                            textFormKey: Keys.guardingAgencyKey,
                            hintText: '',
                            isEnable: widget.model == null
                                ? true
                                : (widget.model != null &&
                                        (widget.model?.employeeCode == null))
                                    ? false
                                    : true,
                            isDisableColor: false,
                            onChange: (String value) {
                              state.model.employeeCode = value;
                              context
                                  .read<KeyManagementMasterDetailsCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          CommonWidgets.textDisplay(
                              // state.labels?.locale.budget ??
                              //     state.labels?.defaultLocale.budget ??
                              Constants.totalKeys,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            keyboardType: TextInputType.number,
                            initialValue: '',
                            textFormKey: Keys.budgetKey,
                            hintText: '',
                            isEnable: !isDisabled,
                            isDisableColor: isDisabled,
                            onChange: (String value) {
                              state.model.employeeCode = value;
                              context
                                  .read<KeyManagementMasterDetailsCubit>()
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
                            initialValue: state.model.employeeCode,
                            textFormKey: Keys.guardingAgencyKey,
                            hintText: '',
                            isEnable: widget.model == null
                                ? true
                                : (widget.model != null &&
                                        (widget.model?.employeeCode == null))
                                    ? false
                                    : true,
                            isDisableColor: false,
                            onChange: (String value) {
                              state.model.employeeCode = value;
                              context
                                  .read<KeyManagementMasterDetailsCubit>()
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

  String getStatusString(int status) {
    switch (status) {
      case 1:
        return 'Active';
      case 2:
        return 'InActive';
      case 3:
        return 'Leave';
      case 4:
        return 'Week Off ';
      default:
        return 'Unknown Status';
    }
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

  Widget locationWidgetdislay(KeyManagementMasterDetailsState state) {
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
