import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:intl/intl.dart';

import '../../../../guarding_operations/key_management_data/key_management_issuance/services/key_management_issuance_services.dart';

class IncidentGeneralInfoView extends StatefulWidget {
  const IncidentGeneralInfoView({
    super.key,
    required this.viaOccurrence,
    required this.viaKeyIssuance,
    this.extraProperties,
    this.keyType,
    this.keyLostType,
    this.keyIssuanceId,
    this.kmId,
  });

  final bool viaOccurrence;
  final bool viaKeyIssuance;
  final ExtraProperties? extraProperties;
  final int? keyType;
  final int? keyLostType;
  final int? keyIssuanceId;
  final int? kmId;

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
  TextEditingController claimantController = TextEditingController();

  bool disableForm = false;
  final FocusNode complainantFocusNode = FocusNode();
  final FocusNode incidentLocationFocusNode = FocusNode();
  final FocusNode incidentDescriptionFocusNode = FocusNode();
  final FocusNode complainantEmpIdFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<IncidentGeneralInfoCubit>(context).initializeValues();
  }

  @override
  Widget build(BuildContext context) {
    log('---viaOccurrence-----${widget.viaOccurrence}-----');
    log('---viaKeyIssuance-----${widget.viaKeyIssuance}-----');

    final size = MediaQuery.of(context).size;
    final height = size.height;
    return BlocConsumer<IncidentGeneralInfoCubit, IncidentGeneralInfoState>(
      listener: (context, state) {
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);
        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: Constants.incidentManagementTitle,
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPositivePressed: () async {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              if (!widget.viaOccurrence && !widget.viaKeyIssuance) {
                Navigator.popAndPushNamed(
                  context,
                  incidentManagementsRoute,
                );
              }
              if (widget.viaOccurrence) {
                Navigator.popAndPushNamed(
                  context,
                  shiftOccurrenceDetailsRoute,
                  arguments: {
                    'id': state.model.occurrence?.id.toString(),
                    "title": Constants.editOccurrence,
                  },
                );
                // return;
              }

              log('--widget.viaKeyIssuance-${state.model.keyLossGi?.id}--');
              if (widget.viaKeyIssuance) {
                log('--widget.viaKeyIssuance-ifwidget.keyIssuanceId---${widget.keyIssuanceId}--');

                KeyHistoryModel keyHistoryModel =
                    await KeyManagementIssuanceServices().getIssuanceKHById(
                  widget.kmId!,
                  widget.keyIssuanceId!,
                  widget.keyLostType!,
                );

                Navigator.pushReplacementNamed(
                  context,
                  keyHistoryRecordsDetailsRoute,
                  arguments: {
                    ConstantsArgument.model: keyHistoryModel,
                    ConstantsArgument.id: widget.keyIssuanceId,
                    ConstantsArgument.title: Constants.editKeyLostHistory,
                    ConstantsArgument.keyType: widget.keyType,
                    ConstantsArgument.keyLostType: widget.keyLostType,
                    // ConstantsArgument.parentId: widget.keyIssuanceId,
                  },
                );
                return;
              }
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
      },
      builder: (context, state) {
        claimantController.text = state.model.complainant?.userInfo !=null ? state.model.complainant?.userInfo ?? '' : state.model.complainant?.name ?? '';


        state.model.status ??= 0;
        if (state.model.status! > 0 || !state.model.lock.isEmptyOrNull) {
          disableForm = true;
        }
        if (state.model.status! < 0 || !state.model.lock.isEmptyOrNull) {
          disableForm = true;
        }
        log('EntrySecurity ${state.model.entrySecurity?.name}');
        log('EntrySecurity1 ${state.loggedInUserDetails?.name}');
        log('111${state.model.entrySecurity?.name == state.loggedInUserDetails?.name}');
        if(state.model.status == 0 && state.model.entrySecurity?.name != state.loggedInUserDetails?.name){
          disableForm = true;
        }
        // if (widget.extraProperties != null &&
        //     !widget.extraProperties!.hasWritePermission!) {
        //   disableForm = true;
        // }
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: Constants.generalInformation,
            showPopUp: false,
            showSaveButton: !disableForm && state.status != FormStatus.loading,
            showSubmitButton: !disableForm && state.status != FormStatus.loading,
            showDisLikeButton: false,
            showLikeButton: false,
            pdfAPIName:
                '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=${Constants.incidentManagementModule}',
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<IncidentGeneralInfoCubit>(context)
                  .submitForm(isSaveOnly: true);
            },
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<IncidentGeneralInfoCubit>(context).submitForm(
                isSaveOnly: false,
              );
            },
          ),
          backgroundColor: AppColors.newColor,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void initializeDates(IncidentGeneralInfoState state) {
    if (state.model.incidentDate != null) {
      incidentDateTimeController.text = Utils.timestampToDateConversion(
          int.tryParse(state.model.incidentDate ?? '0'),
          Constants.fulldateFormat);
    }

    if (state.model.closureTargetDate.isEmptyOrNull) {
      DateTime currentDate = DateTime.now();
      DateTime futureDate = currentDate.add(const Duration(days: 14));
      String formattedDate =
          DateFormat(Constants.fulldateFormat).format(futureDate);
      closureTargetDateController.text = formattedDate;

      DateTime dateTime;
      dateTime = DateFormat("dd/MM/yyyy HH:mm:ss")
          .parse(closureTargetDateController.text);
      int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
      state.model.closureTargetDate = inputDate.toString();
    } else {
      closureTargetDateController.text = Utils.timestampToDateConversion(
          int.tryParse(state.model.closureTargetDate ?? '0'),
          Constants.fulldateFormat);
      // state.model.closureTargetDate = closureTargetDateController.text;
    }
  }

  getBodybuilder(IncidentGeneralInfoState state, height) {
    initializeDates(state);
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }
    log('-state.status--222-${state.status}-incidentType--2----${state.model.incidentType}--');

    return Container(
      color: AppColors.lavender,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 0.01,
              color: AppColors.lavender,
            ),
            Container(
              decoration: const ShapeDecoration(
                  color: AppColors.lavender,
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
                            if (!state.model.lock.isEmptyOrNull) ...[
                              RecordLockedWidget(text: '${state.model.lock}'),
                            ],
                            Container(
                              alignment: Alignment.topLeft,
                              child: const Text(
                                Constants.generalinformation,
                                style: Styles.textStyleRegularNormalWhite18,
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Status
                            CommonWidgets.textDisplay(
                                state.labels?.locale.status ??
                                    state.labels?.defaultLocale.status ??
                                    Constants.status,
                                Styles.textStyleWhite16,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDropDown().getDropDown(
                                isDisabled: true,
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
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// Date of creation
                            CommonWidgets.textDisplay(
                                state.labels?.locale.inputDate ??
                                    state.labels?.defaultLocale.inputDate ??
                                    Constants.dateofcreation,
                                Styles.textStyleWhite16,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDate().creationDateDisplay(
                                state.model.inputDate ?? ''),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// Created By
                            CommonWidgets.horizentaltextHandling(
                                state.labels?.locale.entrySecurity ??
                                    state.labels?.defaultLocale.entrySecurity ??
                                    Constants.createdby,
                                isMandatory: true,
                                '${state.model.entrySecurity?.firstName ?? ''} ${state.model.entrySecurity?.lastName ?? ''}'),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// Location
                            CommonWidgets.textDisplay(
                                state.labels?.locale.location ??
                                    state.labels?.defaultLocale.location ??
                                    Constants.location,
                                Styles.textStyleWhite16,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            locationWidgetdislay(
                                selectedLocation:
                                    state.model.location?.name ?? '',
                                enabled: state.model.id == null ||
                                    state.model.status == 0 ||
                                    (state.model.location?.name ?? '').isEmpty,
                                locations: state.locations,
                                onTap: (Organisation? location) async {
                                  log('location?.name-----${location?.name}');

                                  state.model.location = location;

                                  BlocProvider.of<IncidentGeneralInfoCubit>(
                                          context)
                                      .updateLocationDropdownValue(
                                          location: location);
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// Sl No.
                            CommonWidgets.horizentaltextHandling(
                                state.labels?.locale.slNo ??
                                    state.labels?.defaultLocale.slNo ??
                                    Constants.slno,
                                state.model.slNo ?? '',
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// Entity
                            CommonWidgets.textDisplay(
                                state.labels?.locale.entity ??
                                    state.labels?.defaultLocale.entity ??
                                    Constants.entity,
                                Styles.textStyleWhite16,
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
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              orgName: 'ATOM_ENTITIES',
                              functionToCall: () {
                                // refresh the list
                                BlocProvider.of<IncidentGeneralInfoCubit>(
                                        context)
                                    .refreshList();
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),


                            /// Incident Type
                            CommonWidgets.textDisplay(
                                state.labels?.locale.incidentType ??
                                    state.labels?.defaultLocale.incidentType ??
                                    Constants.incidentType,
                                Styles.textStyleWhite16,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDropDown().getDropDown(
                              isDisabled: state.model.status != 6,
                              textController: incidentTypeController,
                              items: incidentTypeValues,
                              initialValue: '${state.model.incidentType ?? 0}',
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
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// Asset Type
                            if (state.model.incidentType == null ||
                                state.model.incidentType == 0 ||
                                state.model.incidentType == 1) ...[
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.typeOfAsset ??
                                      state.labels?.defaultLocale.typeOfAsset ??
                                      Constants.assetType,
                                  Styles.textStyleWhite16,
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
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Article Type
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.typeOfArticle ??
                                      state.labels?.defaultLocale
                                          .typeOfArticle ??
                                      Constants.articleType,
                                  Styles.textStyleWhite16,
                                  isMandatory: true),
                              TextFieldAddButton(
                                title: state.model.typeOfArticle?.name,
                                height: 70,
                                isDisableColor: disableForm,
                                onTap: () {
                                  BaseOrganisationDialog().departmentDialog(
                                    context: context,
                                    organisations: state.getArticleTypeResponse,
                                    onTap: (Organisation articleType) {
                                      BlocProvider.of<IncidentGeneralInfoCubit>(
                                              context)
                                          .updateDropdownValues(
                                              typeOfArticle: articleType);
                                    },
                                    leftImage: false,
                                    orgName: 'ARTICLE_LIST',
                                    functionToCall: () {
                                      // refresh the list
                                      BlocProvider.of<IncidentGeneralInfoCubit>(
                                              context)
                                          .refreshList();
                                    },
                                  );
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Colour
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.color ??
                                      state.labels?.defaultLocale.color ??
                                      Constants.colourMake,
                                  Styles.textStyleWhite16,
                                  isMandatory: true),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                lineHeight: 1,
                                initialValue: state.model.color,
                                textFormKey: Keys.claimantTextController,
                                hintText: Constants.informationhere,
                                isEnable: state.model.status != 6,
                                isDisableColor: disableForm,
                                onChange: (String value) {
                                  state.model.color = value;
                                  context
                                      .read<IncidentGeneralInfoCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),
                            ],

                            /// DB Complaint
                            CommonWidgets.textDisplay(
                                state.labels?.locale.complainantDbEmp ??
                                    state.labels?.defaultLocale
                                        .complainantDbEmp ??
                                    Constants.dbComplaint,
                                Styles.textStyleWhite16,
                                isMandatory: true),
                            RadioButtonsYesNo(
                              status: state.model.status ?? 0,
                              selectedValue:
                                  state.model.complainantDbEmp ? 1 : 0,
                              onChangedYes: state.model.status == 0
                                  ? (val) {
                                      state.model.complainantDbEmp = true;
                                      state.model.complainantName = null;
                                      state.model.employeeId = null;
                                      state.model.complainantDepartment = null;
                                      state.model.complainantHr = null;
                                      state.model.complainant = null;

                                      BlocProvider.of<IncidentGeneralInfoCubit>(
                                              context)
                                          .onCheckBoxChange(state.model);
                                    }
                                  : null,
                              onChangedNo: state.model.status == 0
                                  ? (val) {
                                      state.model.complainantDbEmp = false;
                                      state.model.complainantName = null;
                                      state.model.employeeId = null;
                                      state.model.complainantDepartment = null;
                                      state.model.complainantHr = null;
                                      state.model.complainant = null;

                                      BlocProvider.of<IncidentGeneralInfoCubit>(
                                              context)
                                          .onCheckBoxChange(state.model);
                                      FocusScope.of(context)
                                          .requestFocus(complainantFocusNode);
                                    }
                                  : null,
                            ),

                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// Complainant Employee Id
                            if (state.model.complainantDbEmp == true) ...[
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.employeeId ??
                                      state.labels?.defaultLocale.employeeId ??
                                      Constants.complaintEmployeeId,
                                  Styles.textStyleWhite16,
                                  isMandatory: true),
                              TextFieldAddButton(
                                title: state.model.employeeId,
                                height: 70,
                                isDisableColor: disableForm,
                                onTap: () {
                                  BaseOrganisationDialog().userDialog(
                                    employeeId: true,
                                    context: context,
                                    enabled: !disableForm,
                                    users: state.emailUsers!,
                                    isDbUser: true,
                                    onTap: (BaseUser user) {
                                      BlocProvider.of<IncidentGeneralInfoCubit>(
                                              context)
                                          .updateEmailsValue(
                                        complainant: user,
                                      );
                                      FocusScope.of(context).requestFocus(
                                          complainantEmpIdFocusNode);
                                    },
                                    roleName: ConstantUserRoles.atomStaticUser,
                                    locationId: state.model.location!.id!,
                                    functionToCall: (BaseUser user) {
                                      BlocProvider.of<IncidentGeneralInfoCubit>(
                                              context)
                                          .updateEmailsValue(
                                        complainant: user,
                                      );
                                      FocusScope.of(context).requestFocus(
                                          complainantEmpIdFocusNode);
                                      // refresh the list
                                      BlocProvider.of<IncidentGeneralInfoCubit>(
                                              context)
                                          .refreshList();
                                    },
                                  );
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),
                            ],

                            if (state.model.complainantDbEmp == false) ...[
                              /// Complainant
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.complainant ??
                                      state.labels?.defaultLocale.complainant ??
                                      Constants.complaint,
                                  Styles.textStyleWhite16,
                                  isMandatory: true),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              Row(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 105,
                                    child: FlutterInputField(
                                      lineHeight: 1,
                                      initialValue: state.model.complainantName,
                                      // controller: claimantController,
                                      textFormKey: Keys.claimantTextController,
                                      hintText: Constants.informationhere,
                                      focusNode: complainantFocusNode,
                                      isEnable: state.model.status == 0,
                                      isDisableColor: state.model.status != 0,
                                      onChange: (String value) {
                                        state.model.complainantName =
                                            value + dbEmailId;
                                        context
                                            .read<IncidentGeneralInfoCubit>()
                                            .onModelValueChange(state.model);
                                      },
                                      validateTextField: (String? user) {},
                                    ),
                                  ),
                                  const Text('@db.com')
                                ],
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),
                            ],

                            if (state.model.complainantDbEmp) ...[
                              /// Complainant
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.complainant ??
                                      state.labels?.defaultLocale.complainant ??
                                      Constants.complaint,
                                  Styles.textStyleWhite16,
                                  isMandatory: true),

                              FlutterInputField(
                                // initialValue: state.model.employeeId,
                                controller: claimantController,
                                textFormKey: Keys.claimantEmpIdTextController,
                                textInputType: TextInputType.text,
                                isEnable: false,
                                isDisableColor: true,
                                hintText: '',
                                focusNode: complainantEmpIdFocusNode,
                                onChange: (String value) {
                                  // state.model.employeeId = value;
                                  // context
                                  //     .read<IncidentGeneralInfoCubit>()
                                  //     .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),

                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Complainant Department
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.complainantDepartment ??
                                      state.labels?.defaultLocale
                                          .complainantDepartment ??
                                      Constants.complaintDepartment,
                                  Styles.textStyleWhite16,
                                  isMandatory: true),
                              TextFieldAddButton(
                                title: state.model.complainantDepartment?.name,
                                height: 70,
                                isDisableColor: disableForm,
                                onTap: () {
                                  BaseOrganisationDialog().departmentDialog(
                                      context: context,
                                      organisations: state.departments,
                                      onTap: (Organisation org) {
                                        BlocProvider.of<
                                                    IncidentGeneralInfoCubit>(
                                                context)
                                            .updateDropdownValues(
                                                complainantDepartment: org);
                                      },
                                      orgName: 'EMPLOYEE_DEPARTMENTS',
                                      createEntity: false,
                                      title: 'Add Claimant Department',
                                      functionToCall: () {
                                        // refresh the list
                                        BlocProvider.of<
                                                    IncidentGeneralInfoCubit>(
                                                context)
                                            .refreshList();
                                      });
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),
                            ],

                            /// Complainant HR / Complainant Manager/Host
                            CommonWidgets.textDisplay(
                                !state.model.complainantDbEmp
                                    ? state.labels?.locale.complainantHost ??
                                        state.labels?.defaultLocale
                                            .complainantHost ??
                                        Constants.complaintManagerHost
                                    : state.labels?.locale.complainantHr ??
                                        state.labels?.defaultLocale
                                            .complainantHr ??
                                        Constants.complaintHR,
                                Styles.textStyleWhite16,
                                isMandatory: true),
                            TextFieldAddButton(
                              title: state.model.complainantHr?.userInfo ??
                                  state.model.complainantHr?.name,
                              height: 70,
                              isDisableColor: disableForm,
                              onTap: () {
                                BaseOrganisationDialog().userDialog(
                                  context: context,
                                  enabled: !disableForm,
                                  users: state.emailUsers!,
                                  isDbUser: true,
                                  onTap: (BaseUser user) {
                                    BlocProvider.of<IncidentGeneralInfoCubit>(
                                            context)
                                        .updateEmailsValue(
                                      complainantHr: user,
                                    );
                                  },
                                  roleName: ConstantUserRoles.atomStaticUser,
                                  locationId: state.model.location!.id!,
                                  functionToCall: (BaseUser user) {
                                    BlocProvider.of<IncidentGeneralInfoCubit>(
                                            context)
                                        .updateEmailsValue(
                                      complainantHr: user,
                                    );
                                    // refresh the list
                                    BlocProvider.of<IncidentGeneralInfoCubit>(
                                            context)
                                        .refreshList();
                                  },
                                );
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// Incident Date and Time
                            CommonWidgets.textDisplay(
                              state.labels?.locale.incidentDate ??
                                  state.labels?.defaultLocale.incidentDate ??
                                  Constants.incidentDateTime,
                              Styles.textStyleWhite16,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              textController: incidentDateTimeController,
                              onlyDate: false,
                              showFutureDate: false,
                              context: context,
                              onChange: (String value) {
                                log('---value-$value------');
                                log('---incidentDateTimeController------###-${incidentDateTimeController.text}------');
                                state.model.incidentDate =
                                    Utils().formatTime(value);
                                log('---value11-${state.model.incidentDate}------');
                                BlocProvider.of<IncidentGeneralInfoCubit>(
                                        context)
                                    .onModelValueChange(state.model);
                                FocusScope.of(context)
                                    .requestFocus(incidentLocationFocusNode);

                                log('---incidentDateTimeController----222--###-${incidentDateTimeController.text}------');
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// Incident Location
                            CommonWidgets.textDisplay(
                                state.labels?.locale.incidentLocation ??
                                    state.labels?.defaultLocale
                                        .incidentLocation ??
                                    Constants.incidentLocation,
                                isMandatory: true,
                                Styles.textStyleWhite16),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              textInputType: TextInputType.text,
                              initialValue: state.model.incidentLocation,
                              textFormKey: Keys.lsm1ContactNOKey,
                              hintText: '',
                              focusNode: incidentLocationFocusNode,
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
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// Incident Manager
                            CommonWidgets.textDisplay(
                              state.labels?.locale.incidentManager ??
                                  state.labels?.defaultLocale.incidentManager ??
                                  Constants.incidentManager,
                              Styles.textStyleWhite16,
                              isMandatory: true,
                            ),
                            TextFieldAddButton(
                              title: state.model.incidentManager?.userInfo ??
                                  state.model.incidentManager?.name,
                              height: 70,
                              isDisableColor: disableForm,
                              onTap: () {
                                if (state.model.status == 0) {
                                  BaseOrganisationDialog().userDialog(
                                    context: context,
                                    enabled: !disableForm,
                                    users: state.incidentManager,
                                    isDbUser: true,
                                    onTap: (BaseUser user) {
                                      BlocProvider.of<IncidentGeneralInfoCubit>(
                                              context)
                                          .updateDropdownValues(
                                        incidentManager: user,
                                      );
                                    },
                                    roleName: ConstantUserRoles
                                        .atomSeniorSecurityManagerUser,
                                    locationId: state.model.location!.id!,
                                    functionToCall: (BaseUser user) {
                                      BlocProvider.of<IncidentGeneralInfoCubit>(
                                              context)
                                          .updateDropdownValues(
                                        incidentManager: user,
                                      );
                                      // refresh the list
                                      BlocProvider.of<IncidentGeneralInfoCubit>(
                                              context)
                                          .refreshList();
                                    },
                                  );
                                }
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// Incident Owner
                            CommonWidgets.textDisplay(
                              state.labels?.locale.incidentOwner ??
                                  state.labels?.defaultLocale.incidentOwner ??
                                  Constants.incidentOwner,
                              Styles.textStyleWhite16,
                              isMandatory: true,
                            ),
                            TextFieldAddButton(
                              title: state.model.incidentOwner?.userInfo ??
                                  state.model.incidentOwner?.name,
                              height: 70,
                              isDisableColor: disableForm,
                              onTap: () {
                                if (state.model.status == 0) {
                                  BaseOrganisationDialog().userDialog(
                                    context: context,
                                    enabled: !disableForm,
                                    users: state.incidentOwner,
                                    isDbUser: true,
                                    onTap: (BaseUser user) {
                                      BlocProvider.of<IncidentGeneralInfoCubit>(
                                              context)
                                          .updateDropdownValues(
                                        incidentOwner: user,
                                      );
                                      FocusScope.of(context).requestFocus(
                                          incidentDescriptionFocusNode);
                                    },
                                    roleName: ConstantUserRoles
                                        .atomSubRegionalHeadUser,
                                    locationId: state.model.location!.id!,
                                    functionToCall: (BaseUser user) {
                                      BlocProvider.of<IncidentGeneralInfoCubit>(
                                              context)
                                          .updateDropdownValues(
                                        incidentOwner: user,
                                      );
                                      FocusScope.of(context).requestFocus(
                                          incidentDescriptionFocusNode);
                                      // refresh the list
                                      BlocProvider.of<IncidentGeneralInfoCubit>(
                                              context)
                                          .refreshList();
                                    },
                                  );
                                }
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// Incident Description
                            CommonWidgets.textDisplay(
                                state.labels?.locale.description ??
                                    state.labels?.defaultLocale.description ??
                                    Constants.incidentDescription,
                                isMandatory: true,
                                Styles.textStyleWhite16),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              showBorder: true,
                              lineHeight: 6,
                              characterLimit:
                                  Constants.characterLimitDescTextFormField,
                              initialValue: state.model.description,
                              textFormKey: Keys.incidentDescription,
                              hintText: Constants.informationhere,
                              focusNode: incidentDescriptionFocusNode,
                              isEnable: state.model.status != 6,
                              isDisableColor: disableForm,
                              onChange: (String value) {
                                state.model.description = value;
                                context
                                    .read<IncidentGeneralInfoCubit>()
                                    .onModelValueChange(state.model);
                              },
                              textInputAction: TextInputAction.newline,
                              textInputType: TextInputType.multiline,
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// Target Date of Closure
                            CommonWidgets.textDisplay(
                              state.labels?.locale.closureTargetDate ??
                                  state.labels?.defaultLocale
                                      .closureTargetDate ??
                                  Constants.closureTargetDate,
                              Styles.textStyleWhite16,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              textController: closureTargetDateController,
                              isDisabled: (state.model.status != null &&
                                      state.model.status! >= 1) ||
                                  !state.model.lock.isEmptyOrNull,
                              onlyDate: false,
                              showPastDate: false,
                              onChange: (String value) {
                                state.model.closureTargetDate =
                                    Utils().formatTime(value);
                                log('---value11-${state.model.closureTargetDate}------');
                                BlocProvider.of<IncidentGeneralInfoCubit>(
                                        context)
                                    .onModelValueChange(state.model);
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),
                          ]),
                        ),
                      ),

                      /// SubmitButton
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          cancelButtonDisplay(),
                          if (state.model.status == 0 && !disableForm) ...[
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

  // Widget cancelButtonDisplay(IncidentGeneralInfoState state) {
  //   bool condition = (state.model.status != ConstantsIntValue.cancelledStatus &&
  //           state.model.status != ConstantsIntValue.incidentStatusClosed &&
  //           state.model.status != ConstantsIntValue.incidentStatusCancelled &&
  //           !state.model.lock.isEmptyOrNull) &&
  //       !(state.model.incidentManager!.userName
  //               .equalsIgnoreCase(state.loggedInUserDetails?.userName) ||
  //           (state.model.incidentOwner!.userName
  //               .equalsIgnoreCase(state.loggedInUserDetails?.userName)));
  //   return AppButton(
  //     width: Constants.cancelButtonWidth,
  //     backgroundColor: Colors.white,
  //     key: const Key(Keys.cancelButton),
  //     buttonText: condition ? Constants.cancelRecord : Constants.close,
  //     buttonTextKey: Keys.cancelButton,
  //     onTap: () {
  //       if (!condition) {
  //         Navigator.pop(context);
  //         return;
  //       }
  //       var dialog = CustomAlertDialog(
  //           title: Constants.cancelRecord,
  //           message: Constants.cancelRecordWarningMessage,
  //           onPositivePressed: () {
  //             Navigator.pop(context);
  //             Navigator.pop(context);
  //             updateRecordStatus(state);
  //           },
  //           positiveBtnText: Constants.yes,
  //           negativeBtnText: Constants.no);
  //       showDialog(context: context, builder: (BuildContext context) => dialog);
  //     },
  //   );
  // }

  // void updateRecordStatus(IncidentGeneralInfoState state) {
  //   if (state.model.id != null && state.model.id != 0) {
  //     BlocProvider.of<IncidentGeneralInfoCubit>(context)
  //         .updateStatus(id: state.model.id.toString());
  //     Navigator.popAndPushNamed(context, incidentManagementsRoute);
  //   } else {
  //     Navigator.pop(context);
  //   }
  // }

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
