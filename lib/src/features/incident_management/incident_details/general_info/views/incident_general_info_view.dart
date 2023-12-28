import 'dart:developer';

import 'package:db_atom/index.dart';

class IncidentGeneralInfoView extends StatefulWidget {
  const IncidentGeneralInfoView({
    super.key,
    required this.viaOccurrence,
  });

  final bool viaOccurrence;

  @override
  State<IncidentGeneralInfoView> createState() =>
      _IncidentGeneralInfoViewState();
}

class _IncidentGeneralInfoViewState extends State<IncidentGeneralInfoView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController incidentDateTimeController = TextEditingController();
  TextEditingController closureTargetDateController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController assetTypeController = TextEditingController();
  TextEditingController assetController = TextEditingController();
  TextEditingController incidentTypeController = TextEditingController();
  bool disableForm = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<IncidentGeneralInfoCubit>(context).initializeValues();
  }

  @override
  Widget build(BuildContext context) {
    log('---viaOccurrence-----${widget.viaOccurrence}-----');

    final size = MediaQuery.of(context).size;
    final height = size.height;
    return BlocConsumer<IncidentGeneralInfoCubit, IncidentGeneralInfoState>(
      listener: (context, state) {
        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: Constants.generalInformation,
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPostivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              if (widget.viaOccurrence) {
                return Navigator.pushNamed(
                  context,
                  occurrenceDetailsRoute,
                  arguments: {
                    'id': state.model.occurrence?.id.toString(),
                    "title": Constants.editOccurrence,
                  },
                );
              }
              Navigator.popAndPushNamed(
                context,
                incidentManagementsRoute,
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
        log('--state.message-----${state.message}-');
        if (state.status == FormStatus.error) {
          Validator().showToast(
            context,
            state.message ?? 'Invalid Information',
          );
        }
      },
      builder: (context, state) {
        state.model.status ??= 0;
        if (state.model.status! > 0) {
          disableForm = true;
        }
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: Constants.generalInformation,
            showPopUp: false,
            showSaveButton: disableForm ? false : true,
            showSubmitButton: disableForm ? false : true,
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<IncidentGeneralInfoCubit>(context)
                  .submitForm(isSaveOnly: true);
            },
          ),
          backgroundColor: AppColors.backgroundWhitecolor,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void initializeDates(IncidentGeneralInfoState state) {
    if (state.model.incidentDate != null) {
      incidentDateTimeController.text = Utils.timestamptoDateConversion(
          int.tryParse(state.model.incidentDate ?? '0'),
          Constants.fulldateFormat);
    }
    if (state.model.closureTargetDate != null) {
      closureTargetDateController.text = Utils.timestamptoDateConversion(
          int.tryParse(state.model.closureTargetDate ?? '0'),
          Constants.fulldateFormat);
    }
  }

  getBodybuilder(IncidentGeneralInfoState state, height) {
    initializeDates(state);
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }
    log('-state.status--222-${state.status}-incidentType--2----${state.model.incidentType}--');

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
                autovalidateMode: disableForm
                    ? AutovalidateMode.disabled
                    : AutovalidateMode.onUserInteraction,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      AbsorbPointer(
                        absorbing: disableForm,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: Column(children: [
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
                                Constants.status, Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDropDown().getDropDown(
                                isDisabled: state.model.status != 0,
                                textController: statusController,
                                items: incidentManagementStatus,
                                initialValue: '${state.model.status ?? 0}',
                                onTap: () {
                                  if (state.model.id == null &&
                                      state.model.id != null) {
                                    BaseDropDown().assetTypeDialog(
                                      context: context,
                                      dropDownValues: incidentManagementStatus
                                          .map((label) => label.key)
                                          .toList(),
                                      onTap: (String value) {
                                        Label? selectedLabel;
                                        selectedLabel =
                                            incidentManagementStatus.firstWhere(
                                          (label) => label.key == value,
                                          orElse: () =>
                                              const Label(key: '', value: ''),
                                        );
                                        BlocProvider.of<
                                                    IncidentGeneralInfoCubit>(
                                                context)
                                            .updateDropdownValues(
                                          status:
                                              int.tryParse(selectedLabel.value),
                                        );
                                      },
                                    );
                                  }
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Date of creation
                            CommonWidgets.textDisplay(Constants.dateofcreation,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDate().creationDateDisplay(
                                state.model.inputDate ?? ''),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Location
                            CommonWidgets.textDisplay(
                                Constants.location, Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            locationWidgetdislay(
                                selectedLocation:
                                    state.model.location?.name ?? '',
                                enabled: state.model.id == null ||
                                    (state.model.location?.name ?? '').isEmpty,
                                locations: state.locations,
                                onTap: (Organisation? location) async {
                                  log('location?.name-----${location?.name}');

                                  state.model.location = location;

                                  BlocProvider.of<IncidentGeneralInfoCubit>(
                                          context)
                                      .updateDropdownValues(location: location);
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Sl No.
                            CommonWidgets.horizentaltextHandling(
                                Constants.slno, state.model.slNo ?? '',
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Entity
                            CommonWidgets.textDisplay(
                                Constants.entity, Styles.textStyleBlack14,
                                isMandatory: true),
                            BaseEntitiesSelection().entityDropDownSelection(
                                context: context,
                                selectedValues: state.model.entities ?? [],
                                all: state.listOfEntities ?? [],
                                enabled: !disableForm,
                                onTap: (List<Organisation> selectedEntities) {
                                  log('--selectedEntities----${selectedEntities.length}');
                                  BlocProvider.of<IncidentGeneralInfoCubit>(
                                          context)
                                      .updateDropdownValues(
                                          entities: selectedEntities);
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            /// Incident Type
                            CommonWidgets.textDisplay(
                                Constants.incidentType, Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDropDown().getDropDown(
                              isDisabled: state.model.status != 6,
                              textController: incidentTypeController,
                              items: incidentTypeValues,
                              initialValue: state.model.incidentType.toString(),
                              onTap: () {
                                BaseDropDown().assetTypeDialog(
                                  context: context,
                                  dropDownValues: incidentTypeValues
                                      .map((label) => label.key)
                                      .toList(),
                                  onTap: (String value) {
                                    Label? selectedLabel;
                                    selectedLabel =
                                        incidentTypeValues.firstWhere(
                                      (label) => label.key == value,
                                      orElse: () =>
                                          const Label(key: '', value: ''),
                                    );
                                    BlocProvider.of<IncidentGeneralInfoCubit>(
                                            context)
                                        .updateDropdownValues(
                                            incidentType: int.tryParse(
                                                selectedLabel.value));
                                  },
                                );
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Asset Type
                            if (state.model.incidentType == 0 ||
                                state.model.incidentType == 1) ...[
                              CommonWidgets.textDisplay(
                                  Constants.assetType, Styles.textStyleBlack14,
                                  isMandatory: true),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              BaseDropDown().getDropDown(
                                isDisabled: state.model.status != 6,
                                textController: assetController,
                                items: assetTypeValues,
                                initialValue:
                                    state.model.typeOfAsset.toString(),
                                onTap: () {
                                  BaseDropDown().assetTypeDialog(
                                    context: context,
                                    dropDownValues: assetTypeValues
                                        .map((label) => label.key)
                                        .toList(),
                                    onTap: (String value) {
                                      Label? selectedLabel;
                                      selectedLabel =
                                          assetTypeValues.firstWhere(
                                        (label) => label.key == value,
                                        orElse: () =>
                                            const Label(key: '', value: ''),
                                      );
                                      BlocProvider.of<IncidentGeneralInfoCubit>(
                                              context)
                                          .updateDropdownValues(
                                              typeOfAsset: int.tryParse(
                                                  selectedLabel.value));
                                    },
                                  );
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Article Type

                              CommonWidgets.textDisplay(Constants.articleType,
                                  Styles.textStyleBlack14,
                                  isMandatory: true),
                              TextfieldAddButton(
                                title: state.model.typeOfArticle?.name,
                                height: 70,
                                isDisableColor: disableForm,
                                onTap: () {
                                  BaseDepartmentDialog().departmentDialog(
                                    context: context,
                                    departments: state.getArticleTypeResponse,
                                    onTap: (Organisation articleType) {
                                      BlocProvider.of<IncidentGeneralInfoCubit>(
                                              context)
                                          .updateDropdownValues(
                                              typeOfArticle: articleType);
                                    },
                                  );
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Colour
                              CommonWidgets.textDisplay(
                                  Constants.colourMake, Styles.textStyleBlack14,
                                  isMandatory: true),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                lineHeight: 1,
                                initialValue: state.model.color,
                                textFormKey: Keys.claimantTextController,
                                hintText: Constants.informationhere,
                                isEnable: state.model.status != 6,
                                isDisableColor: state.model.status == 6,
                                onChange: (String value) {
                                  state.model.color = value;
                                  context
                                      .read<IncidentGeneralInfoCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                            ],

                            /// DB Complaint
                            CommonWidgets.textDisplay(
                                Constants.dbComplaint, Styles.textStyleBlack14,
                                isMandatory: true),
                            RadioButtonsYesNo(
                              status: state.model.status ?? 0,
                              selectedValue:
                                  state.model.complainantDbEmp ? 1 : 0,
                              onChangedYes: state.model.status == 39
                                  ? null
                                  : (val) {
                                      state.model.complainantDbEmp = true;
                                      BlocProvider.of<IncidentGeneralInfoCubit>(
                                              context)
                                          .onCheckBoxChange(state.model);
                                    },
                              onChangedNo: state.model.status == 39
                                  ? null
                                  : (val) {
                                      state.model.complainantDbEmp = false;
                                      BlocProvider.of<IncidentGeneralInfoCubit>(
                                              context)
                                          .onCheckBoxChange(state.model);
                                    },
                            ),

                            /// Complainant
                            if (state.model.complainantDbEmp == true) ...[
                              CommonWidgets.textDisplay(
                                  Constants.complaint, Styles.textStyleBlack14,
                                  isMandatory: true),
                              TextfieldAddButton(
                                title: state.model.complainant?.name,
                                height: 70,
                                isDisableColor: disableForm,
                                onTap: () {
                                  BaseDepartmentDialog().userDialog(
                                    context: context,
                                    enabled: !disableForm,
                                    users: state.emailUsers!,
                                    onTap: (BaseUser user) {
                                      BlocProvider.of<IncidentGeneralInfoCubit>(
                                              context)
                                          .updateDropdownValues(
                                        complainant: user,
                                      );
                                    },
                                  );
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                            ],

                            if (state.model.complainantDbEmp == false) ...[
                              /// Complainant
                              CommonWidgets.textDisplay(
                                  Constants.complaint, Styles.textStyleBlack14,
                                  isMandatory: true),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                lineHeight: 1,
                                initialValue: state.model.complainantName,
                                textFormKey: Keys.claimantTextController,
                                hintText: Constants.informationhere,
                                isEnable: state.model.status != 6,
                                isDisableColor: state.model.status == 6,
                                onChange: (String value) {
                                  state.model.complainantName = value;
                                  context
                                      .read<IncidentGeneralInfoCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                            ],

                            if (state.model.complainantDbEmp) ...[
                              /// Complainant Employee Id
                              CommonWidgets.textDisplay(
                                  Constants.complaintEmployeeId,
                                  Styles.textStyleBlack14,
                                  isMandatory: true),

                              FlutterInputField(
                                initialValue: state.model.employeeId,
                                textFormKey: Keys.claimantEmpIdTextController,
                                isEnable: state.model.status != 39,
                                isDisableColor: state.model.status == 39,
                                hintText: '',
                                onChange: (String value) {
                                  state.model.employeeId = value;
                                  context
                                      .read<IncidentGeneralInfoCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),

                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Complainant Department
                              CommonWidgets.textDisplay(
                                  Constants.complaintDepartment,
                                  Styles.textStyleBlack14,
                                  isMandatory: true),
                              TextfieldAddButton(
                                title: state.model.complainantDepartment?.name,
                                height: 70,
                                isDisableColor: disableForm,
                                onTap: () {
                                  BaseDepartmentDialog().departmentDialog(
                                    context: context,
                                    departments: state.departments,
                                    onTap: (Organisation department) {
                                      BlocProvider.of<IncidentGeneralInfoCubit>(
                                              context)
                                          .updateDropdownValues(
                                              complainantDepartment:
                                                  department);
                                    },
                                  );
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                            ],

                            /// Complainant Manager/Host
                            CommonWidgets.textDisplay(
                                Constants.complaintHR, Styles.textStyleBlack14,
                                isMandatory: true),
                            TextfieldAddButton(
                              title: state.model.complainantHr?.name,
                              height: 70,
                              isDisableColor: disableForm,
                              onTap: () {
                                BaseDepartmentDialog().userDialog(
                                  context: context,
                                  enabled: !disableForm,
                                  users: state.emailUsers!,
                                  onTap: (BaseUser user) {
                                    BlocProvider.of<IncidentGeneralInfoCubit>(
                                            context)
                                        .updateDropdownValues(
                                      complainantHR: user,
                                    );
                                  },
                                );
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Created By
                            CommonWidgets.horizentaltextHandling(
                                Constants.createdby,
                                isMandatory: true,
                                '${state.loggedInUserDetails?.firstName ?? ''} ${state.loggedInUserDetails?.lastName ?? ''}'),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Incident Date and Time
                            CommonWidgets.textDisplay(
                              Constants.incidentDateTime,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              textController: incidentDateTimeController,
                              onlyDate: false,
                              onChange: (String value) {
                                log('---value-$value------');
                                state.model.incidentDate =
                                    Utils().formatTime(value);
                                log('---value11-${state.model.incidentDate}------');
                                BlocProvider.of<IncidentGeneralInfoCubit>(
                                        context)
                                    .onModelValueChange(state.model);
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Incident Location
                            CommonWidgets.textDisplay(
                                Constants.incidentLocation,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.text,
                              initialValue: state.model.incidentLocation,
                              textFormKey: Keys.lsm1ContactNOKey,
                              hintText: '',
                              isEnable: !disableForm,
                              isDisableColor: disableForm,
                              onChange: (String value) {
                                state.model.incidentLocation = value;
                                context
                                    .read<IncidentGeneralInfoCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Incident Manager
                            CommonWidgets.textDisplay(
                              Constants.incidentManager,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            TextfieldAddButton(
                              title: state.model.incidentManager?.name,
                              height: 70,
                              isDisableColor: disableForm,
                              onTap: () {
                                BaseDepartmentDialog().userDialog(
                                  context: context,
                                  enabled: !disableForm,
                                  users: state.emailUsers!,
                                  onTap: (BaseUser user) {
                                    BlocProvider.of<IncidentGeneralInfoCubit>(
                                            context)
                                        .updateDropdownValues(
                                      incidentManager: user,
                                    );
                                  },
                                );
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Incident Owner
                            CommonWidgets.textDisplay(
                              Constants.incidentOwner,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            TextfieldAddButton(
                              title: state.model.incidentOwner?.name,
                              height: 70,
                              isDisableColor: disableForm,
                              onTap: () {
                                BaseDepartmentDialog().userDialog(
                                  context: context,
                                  enabled: !disableForm,
                                  users: state.emailUsers!,
                                  onTap: (BaseUser user) {
                                    BlocProvider.of<IncidentGeneralInfoCubit>(
                                            context)
                                        .updateDropdownValues(
                                      incidentOwner: user,
                                    );
                                  },
                                );
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Incident Description
                            CommonWidgets.textDisplay(
                                Constants.incidentDescription,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              lineHeight: 6,
                              initialValue: state.model.description,
                              textFormKey: Keys.incidentDescription,
                              hintText: Constants.informationhere,
                              isEnable: state.model.status != 6,
                              isDisableColor: state.model.status == 6,
                              onChange: (String value) {
                                state.model.description = value;
                                context
                                    .read<IncidentGeneralInfoCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Target Date of Closure
                            CommonWidgets.textDisplay(
                              Constants.closureTargetDate,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              textController: closureTargetDateController,
                              onlyDate: false,
                              onChange: (String value) {
                                log('---value-$value------');
                                state.model.closureTargetDate =
                                    Utils().formatTime(value);
                                log('---value11-${state.model.incidentDate}------');
                                BlocProvider.of<IncidentGeneralInfoCubit>(
                                        context)
                                    .onModelValueChange(state.model);
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                          ]),
                        ),
                      ),

                      /// SubmitButton
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          cancelButtonDisplay(),
                          if (!disableForm) ...[
                            submitButtonDisplay(onTap: () {
                              FocusScope.of(context).unfocus();
                              BlocProvider.of<IncidentGeneralInfoCubit>(context)
                                  .submitForm(
                                      isSaveOnly: false, isSubmit: true);
                            })
                          ],
                        ],
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.04),
                    ]),
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

  Widget submitButtonDisplay(
      {required Function onTap, String? label = Constants.submit}) {
    return AppButton(
      width: 150,
      buttonText: label,
      buttonTextKey: Keys.submitButton,
      onTap: onTap,
    );
  }

  // Widget submitButtonDisplay() {
  //   return AppButton(
  //     width: 150,
  //     key: const Key(Keys.submitButton),
  //     buttonText: Constants.submit,
  //     buttonTextKey: Keys.submitButton,
  //     onTap: () async {
  //       FocusScope.of(context).unfocus();
  //       BlocProvider.of<GeneralInfoCubit>(context)
  //           .submitForm(isSaveOnly: false);
  //     },
  //   );
  // }

  Widget locationWidgetdislay({
    required bool enabled,
    Locations? locations,
    required String selectedLocation,
    Function? onTap,
  }) {
    return GestureDetector(
      onTap: () {
        if (enabled) {
          selectLocation(
            locations: locations,
            onTap: onTap,
          );
        }
      },
      child: SelectedTileValueWidget(name: selectedLocation),
    );
  }

  void selectLocation({Locations? locations, Function? onTap}) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        // print(state.getLocationsResponse);
        return CustomExpansionListTexts(
          locationList: locations,
          onTap: onTap,
        );
      },
    );
  }

  TextEditingController addEPOfficerController = TextEditingController();
}
