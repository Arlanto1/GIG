import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/transport_medical_incident/models/transport_medical_incident_model.dart';
import 'package:db_atom/src/features/transport_medical_incident/transport_medical_details/cubits/transport_medical_details_cubit.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class TransportMedicalDetailsView extends StatefulWidget {
  final TransportMedicalModel? model;
  final ExtraProperties? extraProperties;
  final bool isTransport;
  final String? title;

  const TransportMedicalDetailsView({
    this.model,
    super.key,
    this.extraProperties,
    required this.isTransport,
    required this.title,
  });

  @override
  State<TransportMedicalDetailsView> createState() =>
      _TransportMedicalDetailsViewState();
}

class _TransportMedicalDetailsViewState
    extends State<TransportMedicalDetailsView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController eventStartDateController = TextEditingController();
  TextEditingController eventEndDateController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  bool disableForm = false;
  TextEditingController incidentTypeController = TextEditingController();
  TextEditingController incidentDateTimeController = TextEditingController();
  TextEditingController shiftLoginDateTimeController = TextEditingController();
  TextEditingController shiftLogoutDateTimeController = TextEditingController();
  TextEditingController transportTypeController = TextEditingController();
  TextEditingController employeeReachedDateTimeController = TextEditingController();
  final FocusNode incidentLocationFocusNode = FocusNode();
  final FocusNode lSM2ContactNoFocusNode = FocusNode();
  final FocusNode pocContactNoFocusNode = FocusNode();
  final FocusNode pocEscalationContactNoFocusNode = FocusNode();
  List<ImageContent> uploadFiles = [];
  List<ImageContent> uploadPhotographyFiles = [];
  List<ImageContent> uploadVendorStaffFiles = [];
  final HtmlEditorController quillController = HtmlEditorController();
  TextEditingController employeeIdController = TextEditingController();

  bool isTemplateLoading = false;
  bool isLoading = false;
  List<ImageContent> getFiles = [];
  bool isEditable = false;
  String selectedTemplateHtml = "";

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TransportMedicalDetailsCubit>(context).initializeValues();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final height = size.height;
    return BlocConsumer<TransportMedicalDetailsCubit,
        TransportMedicalDetailsState>(
      listenWhen: (previous, current) =>
      previous.status != current.status &&
          (current.status == FormStatus.success ||
              current.status == FormStatus.templateLoaded ||
              current.status == FormStatus.formError),
      listener: (context, state) {
        log('widget.isTransport ${widget.isTransport}');
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);
        log('Status123${state.status}');

        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: 'General Information',
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushNamed(
                context,
                transportMedicalListRoute,
                arguments: {"isTransport": widget.isTransport},
              );
              // Navigator.popAndPushNamed(
              //   context,
              //   transportMedicalListRoute,
              //   arguments: {"isTransport": widget.isTransport},
              // );
            },
          );
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => dialog);

          // Utils.dynamicAlert(
          //     context, state.message ?? '', 'Material Movement', '');
        }
      },
      builder: (context, state) {
        if (state.model.status == -1 || !state.model.lock.isEmptyOrNull) {
          disableForm = true;
        }
        if (state.model.status == null) {
          disableForm = false;
        }
        if (state.model.status != 0 && state.model.status != null) {
          disableForm = false;
        }
        // if (widget.extraProperties != null &&
        //     !widget.extraProperties!.hasWritePermission!) {
        //   disableForm = true;
        // }
        state.model.status ??= 0;

        if (state.model.status != 0 && state.model.status != null) {
          disableForm = false;
        }
        isEditable = (state.model.status == 0 || state.model.status == null) && state.model.lock.isEmptyOrNull && state.model.status != -1;

        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.isTransport
                ? Constants.transportIncidentList
                : Constants.medicalEmergencyTitle,
            showPopUp: false,
            showSaveButton: true,
            showSubmitButton: true,
            showDisLikeButton: false,
            showLikeButton: false,
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<TransportMedicalDetailsCubit>(context)
                  .submitForm(isSaveOnly: true);
            },
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<TransportMedicalDetailsCubit>(context)
                  .submitForm(isSaveOnly: false);
            },
            pdfAPIName:
            '${CommonApis.exportDetailPagePDF}${state.model
                .id}&moduleCode=${Constants.eventProtectionModuleCode}',
          ),
          backgroundColor: AppColors.newColor,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void initializeDates(TransportMedicalDetailsState state) {
    // log('--sdd--${state.model.eventStartDate}-------');
    // log('--sdd-eventEndDate-${state.model.eventEndDate}-------');
    if (state.model.incidentDate != null) {
      incidentDateTimeController.text = Utils.timestampToDateConversion(
          int.tryParse(state.model.incidentDate ?? '0'),
          Constants.fulldateFormat);
    }
    if (state.model.shiftLoginDate != null) {
      shiftLoginDateTimeController.text = Utils.timestampToDateConversion(
          int.tryParse(state.model.shiftLoginDate ?? '0'),
          Constants.fulldateFormat);
    }
    if (state.model.shiftLogoutDate != null) {
      shiftLogoutDateTimeController.text = Utils.timestampToDateConversion(
          int.tryParse(state.model.shiftLogoutDate ?? '0'),
          Constants.fulldateFormat);
    }

    if (state.model.employeeReachedTime != null) {
      employeeReachedDateTimeController.text = Utils.timestampToDateConversion(
          int.tryParse(state.model.employeeReachedTime ?? '0'),
          Constants.fulldateFormat);
    }
  }

  getBodybuilder(TransportMedicalDetailsState state, height) {
    initializeDates(state);
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    if (state.status == FormStatus.addAttachment ||
        state.status == FormStatus.initial) {
      getFiles = state.loadAttachments;
    }
    // mediaExposureController.text = state.model.mediaExposure.toString();
    // sensitiveInfoController.text = state.model.sensitiveInfoRisk.toString();

    if (state.status == FormStatus.addAttachment ||
        state.status == FormStatus.initial) {
      uploadFiles = [...state.mapAttachments];

      if (state.model.map != null) {
        uploadFiles.add(state.model.map!);
      }
    }
    if (state.status == FormStatus.addAttachment ||
        state.status == FormStatus.initial) {
      uploadPhotographyFiles = state.loadAttachments;
    }

    return Stack(
      children: [
        //  Background Image
        Positioned.fill(
          child: Image.asset(
            'assets/images/bg2.png',
            fit: BoxFit.cover,
          ),
        ),

        //  Blur Layer
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
            child: Container(
              color: Colors.black.withValues(alpha: 0.08), // optional tint
            ),
          ),
        ),

        // color: AppColors.newColor3,
        // color: AppColors.navigationSkyBlueColor,
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.transparent,
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
                          absorbing: false,
                          child: Padding(
                            padding:
                            const EdgeInsets.only(left: 20.0, right: 20),
                            child: Column(children: [
                              // if (!state.model.lock.isEmptyOrNull) ...[
                              //   RecordLockedWidget(text: '${state.model.lock}'),
                              // ],
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
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
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              BaseDropDown().getDropDown(
                                  isDisabled: state.model.status!=2 ? true : false,
                                  textController: statusController,
                                  items: transportMedicalStatusValues,
                                  initialValue: '${state.model.status ?? 0}',
                                onTap: () {
                                  if (state.model.status==2) {
                                    BaseDropDown().assetTypeDialog(
                                      context: context,
                                      dropDownValues:
                                      transportIncidentStatusValues
                                          .map((label) => label.key)
                                          .toList(),
                                      onTap: (String value) {
                                        Label? selectedLabel;
                                        selectedLabel =
                                            transportIncidentStatusValues
                                                .firstWhere(
                                                  (label) => label.key == value,
                                              orElse: () =>
                                              const Label(key: '', value: ''),
                                            );
                                        BlocProvider.of<
                                            TransportMedicalDetailsCubit>(
                                            context)
                                            .updateDropdownValues(
                                            status: int.tryParse(
                                                selectedLabel.value));
                                      },
                                    );
                                  }
                                },),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Date of creation
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.inputDate ??
                                      state.labels?.defaultLocale.inputDate ??
                                      Constants.dateofcreation,
                                  Styles.textStyleWhite16,
                                  isMandatory: true),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              BaseDate().creationDateDisplay(
                                  state.model.inputDate ?? ''),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Created By
                              CommonWidgets.horizontalTextHandling(
                                // state.labels?.locale.entrySecurity ??
                                //     state.labels?.defaultLocale.entrySecurity ??
                                  Constants.createdby,
                                  isMandatory: true,
                                  '${state.model.entrySecurity?.firstName ??
                                      ''} ${state.model.entrySecurity
                                      ?.lastName ?? ''}'),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Location
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.location ??
                                      state.labels?.defaultLocale.location ??
                                      Constants.location,
                                  Styles.textStyleWhite16,
                                  isMandatory: true),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              BaseLocationDropdown().locationWidgetDisplay(
                                  isEnabled: isEditable,
                                  context: context,
                                  locations: state.locations ?? Locations(),
                                  selectedLocationName:
                                  state.model.location?.name ?? '',
                                  onTap: (Organisation? location) {
                                    BlocProvider.of<
                                        TransportMedicalDetailsCubit>(
                                        context)
                                        .updateLocationDropdownValue(
                                        location: location);
                                  }),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Sl No.
                              CommonWidgets.horizontalTextHandling(
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
                                enabled: isEditable,
                                onTap: (List<Organisation> selectedEntities) {
                                  log('--selectedEntities----${selectedEntities
                                      .length}');
                                  BlocProvider.of<TransportMedicalDetailsCubit>(
                                      context)
                                      .updateDropdownValues(
                                      entities: selectedEntities);
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                orgName: 'ATOM_ENTITIES',
                                functionToCall: () {
                                  // refresh the list
                                  BlocProvider.of<TransportMedicalDetailsCubit>(
                                      context)
                                      .refreshList();
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Incident Type
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.incidentType ??
                                //     state.labels?.defaultLocale.incidentType ??
                                  Constants.incidentType,
                                  Styles.textStyleWhite16,
                                  isMandatory: true),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              BaseDropDown().getDropDown(
                                isDisabled: true,
                                textController: incidentTypeController,
                                items: transportIncidentTypeValues,
                                initialValue: widget.isTransport
                                    ? '${state.model.incidentType ?? 0}'
                                    : '${state.model.incidentType ?? 1}',
                                onTap: () {
                                  // BaseDropDown().assetTypeDialog(
                                  //   context: context,
                                  //   dropDownValues: transportIncidentTypeValues
                                  //       .map((label) => label.key)
                                  //       .toList(),
                                  //   onTap: (String value) {
                                      // Label? selectedLabel;
                                      // selectedLabel =
                                      //     transportIncidentTypeValues.firstWhere(
                                      //           (label) => label.key == value,
                                      //       orElse: () =>
                                      //       const Label(key: '', value: ''),
                                      //     );
                                      // BlocProvider.of<TransportMedicalDetailsCubit>(
                                      //     context)
                                      //     .updateDropdownValues(
                                      //     incidentType: int.tryParse(
                                      //         selectedLabel.value));
                                    // },
                                  // );
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
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),

                              BaseDate().datePickerWidgetLoading(
                                isDisabled: !isEditable,
                                textController: incidentDateTimeController,
                                onlyDate: false,
                                showFutureDate: false,
                                context: context,
                                onChange: (String value) {
                                  state.model.incidentDate =
                                      Utils().formatTime(value);
                                  log('---value11-${state.model
                                      .incidentDate}------');
                                  BlocProvider.of<TransportMedicalDetailsCubit>(
                                      context)
                                      .onModelValueChange(state.model);
                                  FocusScope.of(context)
                                      .requestFocus(incidentLocationFocusNode);
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Incident Location
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.incidentLocation ??
                                //     state.labels?.defaultLocale
                                //         .incidentLocation ??
                                  Constants.incidentLocation,
                                  isMandatory: true,
                                  Styles.textStyleWhite16),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                textInputType: TextInputType.text,
                                initialValue: state.model.incidentLocation,
                                textFormKey: Keys.lsm1ContactNOKey,
                                hintText: '',
                                // focusNode: incidentLocationFocusNode,
                                isEnable: isEditable,
                                isDisableColor: !isEditable,
                                onChange: (String value) {
                                  state.model.incidentLocation = value;
                                  context
                                      .read<TransportMedicalDetailsCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Incident Description
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.incidentLocation ??
                                //     state.labels?.defaultLocale
                                //         .incidentLocation ??
                                  Constants.incidentDescription,
                                  isMandatory: true,
                                  Styles.textStyleWhite16),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                textInputType: TextInputType.text,
                                initialValue: state.model.description,
                                textFormKey: Keys.lsm1ContactNOKey,
                                hintText: '',
                                // focusNode: incidentLocationFocusNode,
                                isEnable: isEditable,
                                isDisableColor: !isEditable,
                                onChange: (String value) {
                                  state.model.description = value;
                                  context
                                      .read<TransportMedicalDetailsCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Vehicle Registration No
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.incidentLocation ??
                                //     state.labels?.defaultLocale
                                //         .incidentLocation ??
                                  Constants.vehicleRegistrationNo,
                                  isMandatory: true,
                                  Styles.textStyleWhite16),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                textInputType: TextInputType.text,
                                initialValue: state.model.vehicleRegistrationNo,
                                textFormKey: Keys.lsm1ContactNOKey,
                                hintText: '',
                                // focusNode: incidentLocationFocusNode,
                                isEnable: isEditable,
                                isDisableColor: !isEditable,
                                onChange: (String value) {
                                  state.model.vehicleRegistrationNo = value;
                                  context
                                      .read<TransportMedicalDetailsCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              if (!widget.isTransport) ...[

                                /// Employee attended by DB wellness
                                CommonWidgets.textDisplay(
                                  // state.labels?.locale.shiftBrfngAttnded ??
                                  //     state.labels?.defaultLocale
                                  //         .shiftBrfngAttnded ??
                                  Constants.employeeAttendedByDB,
                                  isMandatory: true,
                                  Styles.textStyleWhite14,
                                ),
                                RadioButtonsYesNo(
                                  status: state.model.status ?? 0,
                                  selectedValue:
                                  state.model.wellnessTeamAttended ? 1 : 0,
                                  onChangedYes: !isEditable
                                      ? null
                                      : (val) {
                                    state.model.wellnessTeamAttended = true;
                                    BlocProvider.of<
                                        TransportMedicalDetailsCubit>(
                                        context)
                                        .showFields(
                                      escortDeployed: true,
                                    );
                                  },
                                  onChangedNo: !isEditable
                                      ? null
                                      : (val) {
                                    state.model.wellnessTeamAttended = false;
                                    BlocProvider.of<
                                        TransportMedicalDetailsCubit>(
                                        context)
                                        .showFields(
                                      escortDeployed: false,
                                    );
                                  },
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// Employee taken to nearest hospital
                                CommonWidgets.textDisplay(
                                  // state.labels?.locale.shiftBrfngAttnded ??
                                  //     state.labels?.defaultLocale
                                  //         .shiftBrfngAttnded ??
                                  Constants.employeeTakenToHsptl,
                                  isMandatory: true,
                                  Styles.textStyleWhite14,
                                ),
                                RadioButtonsYesNo(
                                  status: state.model.status ?? 0,
                                  selectedValue:
                                  state.model.takenToHospital ? 1 : 0,
                                  onChangedYes: !isEditable
                                      ? null
                                      : (val) {
                                    state.model.takenToHospital = true;
                                    BlocProvider.of<
                                        TransportMedicalDetailsCubit>(
                                        context)
                                        .showFields(
                                      escortDeployed: true,
                                    );
                                  },
                                  onChangedNo: !isEditable
                                      ? null
                                      : (val) {
                                    state.model.takenToHospital = false;
                                    BlocProvider.of<
                                        TransportMedicalDetailsCubit>(
                                        context)
                                        .showFields(
                                      escortDeployed: false,
                                    );
                                  },
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),


                                if(state.model.takenToHospital == true)...[

                                  /// Transport Type
                                  CommonWidgets.textDisplay(
                                    // state.labels?.locale.incidentType ??
                                    //     state.labels?.defaultLocale.incidentType ??
                                      Constants.transportType,
                                      Styles.textStyleWhite16,
                                      isMandatory: true),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.002),

                                  BaseDropDown().getDropDown(
                                    isDisabled: !isEditable,
                                    textController: transportTypeController,
                                    items: transportTypeValues,
                                    initialValue: state.model.transportType
                                        .toString(),
                                    onTap: () {
                                      if(isEditable) {
                                        BaseDropDown().assetTypeDialog(
                                          context: context,
                                          dropDownValues: transportTypeValues
                                              .map((label) => label.key)
                                              .toList(),
                                          onTap: (String value) {
                                            Label? selectedLabel;
                                            selectedLabel =
                                                transportTypeValues.firstWhere(
                                                      (label) =>
                                                  label.key == value,
                                                  orElse: () =>
                                                  const Label(
                                                      key: '', value: ''),
                                                );
                                            BlocProvider.of<
                                                TransportMedicalDetailsCubit>(
                                                context)
                                                .updateDropdownValues(
                                                transportType: int.tryParse(
                                                    selectedLabel.value));
                                          },
                                        );
                                      }
                                    },
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),

                                  /// Name of Hospital
                                  CommonWidgets.textDisplay(
                                    // state.labels?.locale.incidentLocation ??
                                    //     state.labels?.defaultLocale
                                    //         .incidentLocation ??
                                      Constants.nameOfHospital,
                                      isMandatory: true,
                                      Styles.textStyleWhite16),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    textInputType: TextInputType.text,
                                    initialValue: state.model.hospitalName,
                                    textFormKey: Keys.lsm1ContactNOKey,
                                    hintText: '',
                                    // focusNode: incidentLocationFocusNode,
                                    isEnable: isEditable,
                                    isDisableColor: !isEditable,
                                    onChange: (String value) {
                                      state.model.hospitalName = value;
                                      context
                                          .read<TransportMedicalDetailsCubit>()
                                          .onModelValueChange(state.model);
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),


                                  /// Hospital Location/Details
                                  CommonWidgets.textDisplay(
                                    // state.labels?.locale.incidentLocation ??
                                    //     state.labels?.defaultLocale
                                    //         .incidentLocation ??
                                      Constants.hospitalLocation,
                                      isMandatory: true,
                                      Styles.textStyleWhite16),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    lineHeight: 5,
                                    textInputType: TextInputType.text,
                                    initialValue: state.model.hospitalLocation,
                                    textFormKey: Keys.lsm1ContactNOKey,
                                    hintText: '',
                                    // focusNode: incidentLocationFocusNode,
                                    isEnable: isEditable,
                                    isDisableColor: !isEditable,
                                    onChange: (String value) {
                                      state.model.hospitalLocation = value;
                                      context
                                          .read<TransportMedicalDetailsCubit>()
                                          .onModelValueChange(state.model);
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),

                                  /// Accompanied By
                                  CommonWidgets.textDisplay(
                                    // state.labels?.locale.handoverSecurity ??
                                    //     state.labels?.defaultLocale
                                    //         .handoverSecurity ??
                                    Constants.accompaniedBy,
                                    isMandatory: true,
                                    Styles.textStyleWhite14,
                                  ),
                                  TextFieldAddButton(
                                    title: state.model.accompaniedEmployee
                                        ?.userInfo ??
                                        state.model.accompaniedEmployee?.name,
                                    height: 70,
                                    isDisableColor: !isEditable,
                                    onTap: () {
                                      if (isEditable) {
                                        BaseOrganisationDialog().userDialog(
                                          context: context,
                                          users: state.employees,
                                          onTap: (BaseUser user) {
                                            BlocProvider.of<
                                                TransportMedicalDetailsCubit>(
                                                context)
                                                .updateDropdownValues(
                                              accompaniedEmployee: user,
                                            );
                                          },
                                          roleName: ConstantUserRoles
                                              .atomStaticUser,
                                          locationId: state.model.location!.id!,
                                          isDbUser: false,
                                          functionToCall: (BaseUser user) {
                                            BlocProvider.of<
                                                TransportMedicalDetailsCubit>(
                                                context)
                                                .updateDropdownValues(
                                              accompaniedEmployee: user,
                                            );
                                            // refresh the list
                                            BlocProvider.of<
                                                TransportMedicalDetailsCubit>(
                                                context)
                                                .refreshList();
                                          },
                                        );
                                      }
                                    },
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),
                                ],

                                /// Medical home drop provided
                                CommonWidgets.textDisplay(
                                  // state.labels?.locale.shiftBrfngAttnded ??
                                  //     state.labels?.defaultLocale
                                  //         .shiftBrfngAttnded ??
                                  Constants.medicalHomeDrop,
                                  isMandatory: true,
                                  Styles.textStyleWhite14,
                                ),
                                RadioButtonsYesNo(
                                  status: state.model.status ?? 0,
                                  selectedValue:
                                  state.model.dropProvided ? 1 : 0,
                                  onChangedYes: !isEditable
                                      ? null
                                      : (val) {
                                    state.model.dropProvided = true;
                                    BlocProvider.of<
                                        TransportMedicalDetailsCubit>(
                                        context)
                                        .showFields(
                                      escortDeployed: true,
                                    );
                                  },
                                  onChangedNo: !isEditable
                                      ? null
                                      : (val) {
                                    state.model.dropProvided = false;
                                    BlocProvider.of<
                                        TransportMedicalDetailsCubit>(
                                        context)
                                        .showFields(
                                      escortDeployed: false,
                                    );
                                  },
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                if(state.model.dropProvided == true)...[

                                  /// Accompanied for home drop
                                  CommonWidgets.textDisplay(
                                    // state.labels?.locale.handoverSecurity ??
                                    //     state.labels?.defaultLocale
                                    //         .handoverSecurity ??
                                    Constants.accompaniedForHomeDrop,
                                    isMandatory: true,
                                    Styles.textStyleWhite14,
                                  ),
                                  TextFieldAddButton(
                                    title: state.model.accompaniedEmployee1
                                        ?.userInfo ??
                                        state.model.accompaniedEmployee1?.name,
                                    height: 70,
                                    isDisableColor: !isEditable,
                                    onTap: () {
                                      if (isEditable) {
                                        BaseOrganisationDialog().userDialog(
                                          context: context,
                                          users: state.employees,
                                          onTap: (BaseUser user) {
                                            BlocProvider.of<
                                                TransportMedicalDetailsCubit>(
                                                context)
                                                .updateDropdownValues(
                                              accompaniedEmployee1: user,
                                            );
                                          },
                                          roleName: ConstantUserRoles
                                              .atomStaticUser,
                                          locationId: state.model.location!.id!,
                                          isDbUser: false,
                                          functionToCall: (BaseUser user) {
                                            BlocProvider.of<
                                                TransportMedicalDetailsCubit>(
                                                context)
                                                .updateDropdownValues(
                                              accompaniedEmployee1: user,
                                            );
                                            // refresh the list
                                            BlocProvider.of<
                                                TransportMedicalDetailsCubit>(
                                                context)
                                                .refreshList();
                                          },
                                        );
                                      }
                                    },
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),
                                ],

                                /// Employee reached home safely
                                CommonWidgets.textDisplay(
                                  // state.labels?.locale.shiftBrfngAttnded ??
                                  //     state.labels?.defaultLocale
                                  //         .shiftBrfngAttnded ??
                                  Constants.employeeReachedHome,
                                  isMandatory: true,
                                  Styles.textStyleWhite14,
                                ),
                                RadioButtonsYesNo(
                                  status: state.model.status ?? 0,
                                  selectedValue:
                                  state.model.employeeReached ? 1 : 0,
                                  onChangedYes: !isEditable
                                      ? null
                                      : (val) {
                                    state.model.employeeReached = true;
                                    BlocProvider.of<
                                        TransportMedicalDetailsCubit>(
                                        context)
                                        .showFields(
                                      escortDeployed: true,
                                    );
                                  },
                                  onChangedNo: !isEditable
                                      ? null
                                      : (val) {
                                    state.model.employeeReached = false;
                                    BlocProvider.of<
                                        TransportMedicalDetailsCubit>(
                                        context)
                                        .showFields(
                                      escortDeployed: false,
                                    );
                                  },
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                if(state.model.employeeReached == true)...[

                                  /// Time of the employee reached home
                                  CommonWidgets.textDisplay(
                                    // state.labels?.locale.incidentDate ??
                                    //     state.labels?.defaultLocale.incidentDate ??
                                    Constants.timeEmployeeReachedHome,
                                    Styles.textStyleWhite16,
                                    isMandatory: true,
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),

                                  BaseDate().datePickerWidgetLoading(
                                    isDisabled: !isEditable,
                                    textController: employeeReachedDateTimeController,
                                    onlyDate: false,
                                    showFutureDate: false,
                                    context: context,
                                    onChange: (String value) {
                                      state.model.employeeReachedTime =
                                          Utils().formatTime(value);
                                      BlocProvider.of<
                                          TransportMedicalDetailsCubit>(
                                          context)
                                          .onModelValueChange(state.model);
                                      FocusScope.of(context)
                                          .requestFocus(
                                          incidentLocationFocusNode);
                                    },
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),
                                ]
                              ],

                              if (widget.isTransport) ...[

                                /// Actions taken by Corporate Security
                                CommonWidgets.textDisplay(
                                  // state.labels?.locale.incidentLocation ??
                                  //     state.labels?.defaultLocale
                                  //         .incidentLocation ??
                                    Constants.actionTaken,
                                    isMandatory: true,
                                    Styles.textStyleWhite16),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                FlutterInputField(
                                  textInputType: TextInputType.text,
                                  initialValue: state.model.actionsTaken,
                                  textFormKey: Keys.lsm1ContactNOKey,
                                  hintText: '',
                                  // focusNode: incidentLocationFocusNode,
                                  isEnable: isEditable,
                                  isDisableColor: !isEditable,
                                  onChange: (String value) {
                                    state.model.actionsTaken = value;
                                    context
                                        .read<TransportMedicalDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// Impact on Incident on Travellers
                                CommonWidgets.textDisplay(
                                  // state.labels?.locale.incidentLocation ??
                                  //     state.labels?.defaultLocale
                                  //         .incidentLocation ??
                                    Constants.impactOnTravellers,
                                    isMandatory: true,
                                    Styles.textStyleWhite16),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                FlutterInputField(
                                  textInputType: TextInputType.text,
                                  initialValue: state.model.incidentImpact,
                                  textFormKey: Keys.lsm1ContactNOKey,
                                  hintText: '',
                                  // focusNode: incidentLocationFocusNode,
                                  isEnable: isEditable,
                                  isDisableColor: !isEditable,
                                  onChange: (String value) {
                                    state.model.incidentImpact = value;
                                    context
                                        .read<TransportMedicalDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// Shift Login Date
                                CommonWidgets.textDisplay(
                                  // state.labels?.locale.incidentDate ??
                                  //     state.labels?.defaultLocale.incidentDate ??
                                  Constants.shiftLoginDate,
                                  Styles.textStyleWhite16,
                                  isMandatory: true,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),

                                BaseDate().datePickerWidgetLoading(
                                  isDisabled: !isEditable,
                                  textController: shiftLoginDateTimeController,
                                  onlyDate: false,
                                  showFutureDate: false,
                                  context: context,
                                  onChange: (String value) {
                                    log('---value-$value------');
                                    log(
                                        '---incidentDateTimeController------###-${incidentDateTimeController
                                            .text}------');
                                    state.model.shiftLoginDate =
                                        Utils().formatTime(value);
                                    log('---value11-${state.model
                                        .incidentDate}------');
                                    BlocProvider.of<
                                        TransportMedicalDetailsCubit>(
                                        context)
                                        .onModelValueChange(state.model);
                                    FocusScope.of(context).requestFocus(
                                        incidentLocationFocusNode);
                                  },
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// Shift Logout Date
                                CommonWidgets.textDisplay(
                                  // state.labels?.locale.incidentDate ??
                                  //     state.labels?.defaultLocale.incidentDate ??
                                  Constants.shiftLogoutDate,
                                  Styles.textStyleWhite16,
                                  isMandatory: true,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),

                                BaseDate().datePickerWidgetLoading(
                                  isDisabled: !isEditable,
                                  textController: shiftLogoutDateTimeController,
                                  onlyDate: false,
                                  // showFutureDate: true,
                                  // showPastDate: true,
                                  startDate: state.model.shiftLoginDate,
                                  context: context,
                                  onChange: (String value) {
                                    log('---value-$value------');
                                    log(
                                        '---incidentDateTimeController------###-${incidentDateTimeController
                                            .text}------');
                                    state.model.shiftLogoutDate =
                                        Utils().formatTime(value);
                                    log('---value11-${state.model
                                        .incidentDate}------');
                                    BlocProvider.of<
                                        TransportMedicalDetailsCubit>(
                                        context)
                                        .onModelValueChange(state.model);
                                    FocusScope.of(context).requestFocus(
                                        incidentLocationFocusNode);

                                    log(
                                        '---incidentDateTimeController----222--###-${incidentDateTimeController
                                            .text}------');
                                  },
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// Trip Id
                                CommonWidgets.textDisplay(
                                  // state.labels?.locale.incidentLocation ??
                                  //     state.labels?.defaultLocale
                                  //         .incidentLocation ??
                                    Constants.tripId,
                                    isMandatory: true,
                                    Styles.textStyleWhite16),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                FlutterInputField(
                                  textInputType: TextInputType.text,
                                  initialValue: state.model.tripId,
                                  textFormKey: Keys.lsm1ContactNOKey,
                                  hintText: '',
                                  // focusNode: incidentLocationFocusNode,
                                  isEnable: isEditable,
                                  isDisableColor: !isEditable,
                                  onChange: (String value) {
                                    state.model.tripId = value;
                                    context
                                        .read<TransportMedicalDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// Is Escort Guard Deployed
                                CommonWidgets.textDisplay(
                                  // state.labels?.locale.shiftBrfngAttnded ??
                                  //     state.labels?.defaultLocale
                                  //         .shiftBrfngAttnded ??
                                  Constants.isEscortGuardDeployed,
                                  isMandatory: true,
                                  Styles.textStyleWhite14,
                                ),
                                RadioButtonsYesNo(
                                  status: state.model.status ?? 0,
                                  selectedValue:
                                  state.model.escortDeployed ? 1 : 0,
                                  onChangedYes: !isEditable
                                      ? null
                                      : (val) {
                                    state.model.escortDeployed = true;
                                    BlocProvider.of<
                                        TransportMedicalDetailsCubit>(
                                        context)
                                        .showFields(
                                      escortDeployed: true,
                                    );
                                  },
                                  onChangedNo: !isEditable
                                      ? null
                                      : (val) {
                                    state.model.escortDeployed = false;
                                    BlocProvider.of<
                                        TransportMedicalDetailsCubit>(
                                        context)
                                        .showFields(
                                      escortDeployed: false,
                                    );
                                  },
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                if (state.model.escortDeployed == true) ...[

                                  /// Escort Guard
                                  CommonWidgets.textDisplay(
                                    // state.labels?.locale.handoverSecurity ??
                                    //     state.labels?.defaultLocale
                                    //         .handoverSecurity ??
                                    Constants.escortGuard,
                                    isMandatory: true,
                                    Styles.textStyleWhite14,
                                  ),
                                  TextFieldAddButton(
                                    title: state.model.escortGuard?.userInfo ??
                                        state.model.escortGuard?.name,
                                    height: 70,
                                    isDisableColor: !isEditable,
                                    onTap: () {
                                      if (isEditable) {
                                        BaseOrganisationDialog().userDialog(
                                          context: context,
                                          users: state.escortGuard,
                                          onTap: (BaseUser user) {
                                            BlocProvider.of<
                                                TransportMedicalDetailsCubit>(
                                                context)
                                                .updateDropdownValues(
                                              escortGuard: user,
                                            );
                                          },
                                          roleName: ConstantUserRoles
                                              .atomGuardingStaffUser,
                                          locationId: state.model.location!.id!,
                                          isDbUser: false,
                                          functionToCall: (BaseUser user) {
                                            BlocProvider.of<
                                                TransportMedicalDetailsCubit>(
                                                context)
                                                .updateDropdownValues(
                                              escortGuard: user,
                                            );
                                            // refresh the list
                                            BlocProvider.of<
                                                TransportMedicalDetailsCubit>(
                                                context)
                                                .refreshList();
                                          },
                                        );
                                      }
                                    },
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),
                                ],

                                ///Attachments
                                CommonWidgets.textDisplay(Constants.map,isMandatory: true,
                                    Styles.textStyleWhite16),
                                if (state.model.status == 0 ||
                                    state.model.status == null || state.model.status == 1) ...[
                                  BaseImageUpload().uploadWidget(
                                      context: context,
                                      isDisabled: state.model.status != null &&
                                          state.model.status != 0 && state.model.status != 1,
                                      loggedInUserDetails:
                                      state.loggedInUserDetails ?? User(),
                                      getFiles: uploadFiles,
                                      // onImageSelected: (ImageContent data) {
                                      //   List<ImageContent>? files = [];
                                      //   files.add(data);
                                      //   for (ImageContent image in uploadFiles) {
                                      //     files.add(image);
                                      //   }
                                      //   BlocProvider.of<TransportMedicalDetailsCubit>(
                                      //       context)
                                      //       .addMapAttachment(
                                      //     data: files,
                                      //     images: files,
                                      //   );
                                      // },
                                      onImageSelected: (ImageContent data) {
                                        List<ImageContent> files = [];
                                        files.add(data);
                                        for (ImageContent image in uploadFiles) {
                                          files.add(image);
                                        }
                                        context
                                            .read<
                                            TransportMedicalDetailsCubit>()
                                            .addMapAttachment(
                                          data: data, //  single item
                                          images: files, //  full list
                                        );
                                      }
                                  ),
                                ],

                                /// Attachments
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: BaseImageUpload().getAttachment(
                                    height: height,
                                    attachments: state.mapAttachments,
                                    files: uploadFiles,
                                    moduleCode: '',
                                    isDisabled: state.model.status != null &&
                                        state.model.status != 0 && state.model.status != 1? true : false,
                                    showDeleteIcon: state.model.status !=
                                        null && state.model.status != 0 && state.model.status != 1
                                        ? false
                                        : true,
                                  ),
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),
                              ],

                              /// Employee
                              Container(
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                      color: Colors.white, width: 0.8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12),
                                child: Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Employees',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        final updatedEmployees =
                                        List<User>.from(
                                          state.model.employees ?? [],
                                        )
                                          ..add(
                                            User(
                                              employeeId: '',
                                              name: '',
                                            ),
                                          );
                                        context
                                            .read<
                                            TransportMedicalDetailsCubit>()
                                            .updateEmployee(updatedEmployees);
                                      },
                                      child: const Icon(Icons.add,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ),

                              const SizedBox(height: 12),

                              ///  Employees List
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.model.employees?.length ?? 0,
                                itemBuilder: (context, index) {
                                  final emp = state.model.employees![index];

                                  return Padding(
                                    padding:
                                    const EdgeInsets.only(bottom: 16),
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.white
                                            .withValues(alpha: 0.05),
                                        borderRadius:
                                        BorderRadius.circular(8),
                                        border:
                                        Border.all(color: Colors.white24),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [

                                          ///  Top Row (Title + Remove)
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              const Text(
                                                'Employee',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  final updatedEmployees =
                                                  List<User>.from(
                                                    state.model.employees ??
                                                        [],
                                                  )
                                                    ..removeAt(index);

                                                  context
                                                      .read<
                                                      TransportMedicalDetailsCubit>()
                                                      .updateEmployee(
                                                      updatedEmployees);
                                                },
                                                child: const Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              ),
                                            ],
                                          ),

                                          const SizedBox(height: 10),

                                          ///  NAME (Dropdown - your logic)
                                          TextFieldAddButton(
                                            // title: emp.userInfo,
                                            title:
                                            emp.name,
                                            height: 70,
                                            isDisableColor: disableForm,
                                            onTap: () {
                                              BaseOrganisationDialog()
                                                  .userDialog(
                                                context: context,
                                                users: state.employees,
                                                roleName: ConstantUserRoles
                                                    .atomStaticUser,
                                                locationId:
                                                state.model.location!.id!,
                                                isDbUser: true,
                                                onTap: (BaseUser user) {
                                                  //  update the employee at the correct index
                                                  context
                                                      .read<TransportMedicalDetailsCubit>()
                                                      .updateEmployeeUser(index, user);

                                                  emp.employeeId = user.employeeId;
                                                },
                                                functionToCall: (BaseUser user) {
                                                  context
                                                      .read<TransportMedicalDetailsCubit>()
                                                      .updateEmployeeUser(index, user); //  same here
                                                },
                                              );
                                            },
                                          ),

                                          const SizedBox(height: 10),

                                          ///  Employee ID
                                          FlutterInputField(
                                            key: ValueKey(emp.employeeId ?? 'emp_$index'),
                                            initialValue:  emp.employeeId,
                                            // controller: employeeIdController,
                                            showBorder: true,
                                            isEnable: false,
                                            hintText: "Employee ID",
                                            onChange: (value) {
                                              context
                                                  .read<
                                                  TransportMedicalDetailsCubit>()
                                                  .updateEmployeeUser(
                                                  index, value);
                                            },
                                            textFormKey: '',
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),

                              /// View Email Notification List
                              CommonWidgets.textDisplay(
                                  'View Notifications',
                                  Styles.textStyleWhite14),

                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.02),

                              ///  TEMPLATE LIST
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(
                                      color: Colors.white, width: .7),
                                ),
                                child: Column(
                                  children: [

                                    /// ===== HEADER =====
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                      color: Colors.white.withValues(
                                          alpha: 0.1),
                                      child: Row(
                                        children: [
                                          const Expanded(
                                            child: Text(
                                              "Id",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                              icon: state.model.status != 2
                                                  ? const Icon(Icons.add,
                                                  color: Colors.white)
                                                  : const SizedBox(),
                                              tooltip: 'Fetch Template',

                                              // onPressed: () async {
                                              //   try {
                                              //     final cubit = context.read<
                                              //         TransportMedicalDetailsCubit>();
                                              //     int? savedId = cubit.state
                                              //         .model.id;
                                              //     if (widget.model?.id ==
                                              //         null) {
                                              //       //  WAIT for save to complete
                                              //       final isSuccess = await cubit
                                              //           .submitForm(
                                              //           isSaveOnly: true, silent: true);
                                              //
                                              //       if (!isSuccess) {
                                              //         debugPrint(
                                              //             "Save failed");
                                              //         return;
                                              //       }
                                              //
                                              //       //  Now ID is available in state
                                              //       final savedId = cubit
                                              //           .state.model.id;
                                              //
                                              //       if (savedId == null) {
                                              //         debugPrint(
                                              //             "ID is still null after save");
                                              //         return;
                                              //       }
                                              //     }
                                              //     cubit.clearAttachments();
                                              //
                                              //     final response = await cubit
                                              //         .getNotificationDetailsById(
                                              //       savedId
                                              //           .toString(), //  use updated ID
                                              //     );
                                              //
                                              //     final html = response
                                              //         .notification;
                                              //
                                              //     if (html == null || html
                                              //         .trim()
                                              //         .isEmpty) {
                                              //       debugPrint(
                                              //           "HTML is empty");
                                              //       return;
                                              //     }
                                              //
                                              //     openTemplatePreview(
                                              //       html: html,
                                              //       templateId: null,
                                              //     );
                                              //   } catch (e, s) {
                                              //     debugPrint(
                                              //         "Failed to load template: $e");
                                              //     debugPrintStack(
                                              //         stackTrace: s);
                                              //   }
                                              // }
                                            onPressed: () async {
                                              try {
                                                final cubit = context.read<TransportMedicalDetailsCubit>();

                                                // If record doesn't exist yet, save it silently first
                                                if (widget.model?.id == null) {
                                                  final isSuccess = await cubit.submitForm(
                                                    isSaveOnly: true,
                                                    silent: true,
                                                  );

                                                  if (!isSuccess) {
                                                    debugPrint("Save failed");
                                                    return;
                                                  }
                                                }

                                                //  Always read the ID from cubit AFTER the save completes
                                                final savedId = cubit.state.model.id;

                                                if (savedId == null) {
                                                  debugPrint("ID is still null after save");
                                                  return;
                                                }

                                                cubit.clearAttachments();

                                                final response = await cubit.getNotificationDetailsById(
                                                  savedId.toString(), //  now has the correct ID
                                                );

                                                final html = response.notification;

                                                if (html == null || html.trim().isEmpty) {
                                                  debugPrint("HTML is empty");
                                                  return;
                                                }

                                                openTemplatePreview(
                                                  html: html,
                                                  templateId: null,
                                                );
                                              } catch (e, s) {
                                                debugPrint("Failed to load template: $e");
                                                debugPrintStack(stackTrace: s);
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),


                                    /// ===== TEMPLATE LIST =====
                                    ...?state.emailTemplates?.map((item) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                color: Colors.white24),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                item["id"].toString(),
                                                style: Styles
                                                    .textStyleWhite14,
                                              ),
                                            ),
                                            isLoading
                                                ? const SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.white,
                                              ),
                                            )
                                                : IconButton(
                                              icon: const Icon(
                                                Icons.remove_red_eye,
                                                color: Colors.white,
                                              ),
                                              onPressed:
                                                  () async {
                                                final id =
                                                item["id"];
                                                if (id ==
                                                    null) {
                                                  return;
                                                }

                                                setState(
                                                        () {
                                                      isLoading =
                                                      true;
                                                    });

                                                try {
                                                  final cubit =
                                                  context.read<
                                                      TransportMedicalDetailsCubit>();

                                                  cubit
                                                      .clearAttachments();

                                                  final response =
                                                  await cubit
                                                      .getNotificationById(
                                                      id.toString());

                                                  debugPrint(
                                                      "API images: ${response
                                                          .images}");
                                                  debugPrint(
                                                      "API images length: ${response
                                                          .images?.length}");

                                                  cubit.addAttachment(
                                                      response.images);

                                                  final html =
                                                      response.notification;
                                                  if (html == null ||
                                                      html
                                                          .trim()
                                                          .isEmpty) {
                                                    debugPrint(
                                                        "HTML is empty");
                                                    return;
                                                  }

                                                  await Future.delayed(
                                                      const Duration(
                                                          milliseconds: 10));

                                                  if (!context
                                                      .mounted) {
                                                    return;
                                                  }

                                                  openTemplatePreview(
                                                    html:
                                                    html,
                                                    templateId:
                                                    id as int?,
                                                  );
                                                } catch (e, s) {
                                                  debugPrint(
                                                      "Failed to load template: $e");
                                                  debugPrintStack(
                                                      stackTrace: s);
                                                }
                                                finally {
                                                  if (mounted) {
                                                    setState(() {
                                                      isLoading = false;
                                                    });
                                                  }
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),

                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.02),

                              CommonWidgets.verticalSpacerWidget(height * 0.02),
                            ]),
                          ),
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.02),

                        /// SubmitButton
                        // if (state.model.status != 0) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            cancelButtonDisplay(),
                            if(state.model.status != 2)...[
                              submitButtonDisplay(),
                            ]
                          ],
                        ),
                        // ],
                        CommonWidgets.verticalSpacerWidget(height * 0.04),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  //
  // void openTemplatePreview({
  //   required String html,
  //   int? templateId,
  // }) {
  //   Navigator.push(
  //     context,
  //     PageRouteBuilder(                          //  replace MaterialPageRoute
  //       opaque: true,                            //  hides previous page completely
  //       pageBuilder: (_, __, ___) => BlocProvider.value(
  //         value: context.read<TransportMedicalDetailsCubit>(),
  //         child: TemplatePreviewPage(
  //           html: html,
  //           templateId: templateId,
  //           transportId: widget.model!.id.toString(),
  //           showSaveButtons: true,
  //           getFiles: getFiles,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  void openTemplatePreview({
    required String html,
    int? templateId,
  }) {
    // widget.model is null for new records — always read the ID from cubit state
    // which is guaranteed to have the ID after the silent save completes
    final savedId = context.read<TransportMedicalDetailsCubit>().state.model.id;

    if (savedId == null) {
      debugPrint("openTemplatePreview: savedId is null, cannot open preview");
      return;
    }

    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: true,
        pageBuilder: (_, __, ___) => BlocProvider.value(
          value: context.read<TransportMedicalDetailsCubit>(),
          child: TemplatePreviewPage(
            html: html,
            templateId: templateId,
            transportId: savedId.toString(), //  from cubit, never null
            showSaveButtons: true,
            getFiles: getFiles,
          ),
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

  Widget submitButtonDisplay() {
    return AppButton(
      width: 150,
      key: const Key(Keys.submitButton),
      buttonText: Constants.submit,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        FocusScope.of(context).unfocus();
        BlocProvider.of<TransportMedicalDetailsCubit>(context).submitForm(isSaveOnly: false, silent: false);
      },
    );
  }

  ///[getHtmlText] to get the html text from editor
  Future<String> getHtmlText() async {
    String? htmlText = await quillController.getText();
    debugPrint(htmlText);
    return htmlText;
  }

  void setHtmlText(String text) {
    quillController.setText(text); // just call it, don't await
  }

  // void insertNetworkImage(String url) {
  //   quillController.insertNetworkImage(url: url); // just call it
  // }

  // void insertHtmlText(String text) {
  //   quillController.insertHtml(html: text); // just call it
  // }

  void clearEditor() {
    quillController.clear(); // call directly
  }

  void enableEditor(bool enable) {
    quillController.enable(); // call directly
  }

}


class TemplatePreviewPage extends StatefulWidget {
  const TemplatePreviewPage({
    super.key,
    required this.html,
    required this.templateId,
    required this.showSaveButtons,
    required this.getFiles,
    required this.transportId,
  });

  final String html;
  final int? templateId;
  final bool showSaveButtons;
  final String transportId;
  final List<ImageContent> getFiles;
  @override
  State<TemplatePreviewPage> createState() => _TemplatePreviewPageState();
}

class _TemplatePreviewPageState extends State<TemplatePreviewPage> {
  final HtmlEditorController quillController = HtmlEditorController();
  List<ImageContent> localAttachments = []; //  local list
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    //  initialize from cubit state
    final state = context.read<TransportMedicalDetailsCubit>().state;
    localAttachments = List<ImageContent>.from(state.loadAttachments);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C3550),
        title: Text(
          widget.templateId == null
              ? "Create Email Template"
              : "Edit Email Template #${widget.templateId}",
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          if (widget.showSaveButtons)
            _isLoading
                ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
                :widget.templateId ==null ? IconButton(
              tooltip: "Submit",
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () async {
                final html = await quillController.getText();
                if (html.trim().isEmpty) return;

                setState(() => _isLoading = true);

                try {
                  await context
                      .read<TransportMedicalDetailsCubit>()
                      .submitTemplateAndRefresh(
                    html: html,
                    id: widget.templateId,
                  );

                  await context
                      .read<TransportMedicalDetailsCubit>()
                      .getNotificationDetailsById(widget.transportId);

                  if (context.mounted) Navigator.pop(context);
                } finally {
                  if (context.mounted) setState(() => _isLoading = false);
                }
              },
            ): SizedBox.fromSize(),
          IconButton(
            tooltip: "Close",
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () async {
              await context
                  .read<TransportMedicalDetailsCubit>()
                  .getNotificationDetailsById(widget.transportId);
              if (context.mounted) Navigator.pop(context);
            },
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          /// Background
          Positioned.fill(
            child: Image.asset('assets/images/bg2.png', fit: BoxFit.cover),
          ),

          /// Blur overlay
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
              child: Container(
                color: Colors.black.withValues(alpha: 0.15),
              ),
            ),
          ),

          /// Content
          BlocBuilder<TransportMedicalDetailsCubit, TransportMedicalDetailsState>(
            builder: (context, state) {
              //  sync local list when new attachment added via cubit
              // if (state.status == FormStatus.addAttachment) {
              //   WidgetsBinding.instance.addPostFrameCallback((_) {
              //     setState(() {
              //       localAttachments =
              //       List<ImageContent>.from(state.loadAttachments);
              //     });
              //   });
              // }

              return Column(
                children: [
                  /// HTML EDITOR
                  SizedBox(
                    height: height * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: HtmlEditor(
                        controller: quillController,
                        htmlToolbarOptions: const HtmlToolbarOptions(
                          toolbarPosition: ToolbarPosition.aboveEditor,
                          textStyle: Styles.textStyleBlack16,
                        ),
                        htmlEditorOptions: HtmlEditorOptions(
                          darkMode: false,
                          initialText: widget.html,
                          autoAdjustHeight: false,
                        ),
                        otherOptions: OtherOptions(height: height * 1.2),
                        callbacks: Callbacks(
                          onInit: () {
                            quillController.setText("""
<style>
body { background-color: transparent !important; color: white !important; }
* { color: white !important; }
</style>
${widget.html}
""");
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// UPLOAD
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonWidgets.textDisplay(
                          Constants.upload,
                          Styles.textStyleWhite16,
                        ),
                        _uploadWidget(context, state),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// ATTACHMENTS —  use localAttachments
                  // if (localAttachments.isNotEmpty)
                  //   Expanded(
                  //     child: Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 12),
                  //       child: Container(
                  //         width: width,
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(12),
                  //           border: Border.all(
                  //             color: Colors.white.withValues(alpha: 0.35),
                  //             width: 0.8,
                  //           ),
                  //           color: Colors.white.withValues(alpha: 0.03),
                  //         ),
                  //         child: ClipRRect(
                  //           borderRadius: BorderRadius.circular(12),
                  //           child: SingleChildScrollView(
                  //             padding: const EdgeInsets.all(8),
                  //             child: BaseImageUpload().getAttachment(
                  //               height: height,
                  //               attachments: localAttachments,
                  //               files: localAttachments,
                  //               moduleCode: '',
                  //               isDisabled: widget.templateId !=null,
                  //               showDeleteIcon: widget.templateId ==null,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  if ((state.loadAttachments ?? []).isNotEmpty)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
              width: width,
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
              color: Colors.white.withValues(alpha: 0.35),
              width: 0.8,
              ),
              color: Colors.white.withValues(alpha: 0.03),
              ),
              child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SingleChildScrollView(
              padding: const EdgeInsets.all(8),
                        child: BaseImageUpload().getAttachment(
                          height: height,
                          attachments: List<ImageContent>.from(state.loadAttachments ?? []),
                          files: List<ImageContent>.from(state.loadAttachments ?? []),
                          moduleCode: '',
                          isDisabled: widget.templateId != null,
                          showDeleteIcon: widget.templateId == null,
                        ),
              ),
              ),
              ),
                      ),
                    ),

                  SizedBox(height: height * 0.015),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _uploadWidget(BuildContext context, TransportMedicalDetailsState state) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFCACACA), width: 1.0),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(120, 50),
                backgroundColor: Colors.transparent,
              ),
              onPressed: widget.showSaveButtons ? () {
                showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return UploadAttachment(
                      onImageSelected: (ImageContent data) {
                        final updated = [data, ...localAttachments]; //  prepend
                        setState(() {
                          localAttachments = updated; //  instant UI update
                        });
                        context
                            .read<TransportMedicalDetailsCubit>()
                            .addAttachment(updated); //  sync cubit
                      },
                    );
                  },
                );
              } : null,
              icon: SvgPicture.asset(
                AppIcon.uploadIcon,
                colorFilter: const ColorFilter.mode(
                  AppColors.backgroundWhiteColor,
                  BlendMode.srcIn,
                ),
                width: 13,
                height: 13,
              ),
              label: const Text(
                Constants.clicktoupload,
                style: Styles.textStyleRegularNormalWhite12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}