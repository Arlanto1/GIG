import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/occurrence/occurrences_details/general_info/views/add_power_failure_dates_pop_up.dart';
import 'package:intl/intl.dart';

import '../../../../opsTeamSituationUpdate/services/opsSituationUpdateService.dart';

class OccurrenceDetails extends StatefulWidget {
  final String title;
  final ExtraProperties? extraProperties;

  const OccurrenceDetails({
    super.key,
    required this.title,
    this.extraProperties,
  });

  @override
  State<OccurrenceDetails> createState() => _OccurrenceDetailsState();
}

class _OccurrenceDetailsState extends State<OccurrenceDetails> {
  final OpsSituationUpdateServices lsmService = OpsSituationUpdateServices();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User? userDetails;
  List<ImageContent>? getFiles;
  List<ImageContent>? getAttachments;
  TextEditingController statusController = TextEditingController();
  TextEditingController workShiftController = TextEditingController();
  bool disableForm = true;
  bool showPowerFailureDates = false;
  bool isReadOnly = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<OccurrenceGeneralInfoCubit>(context).initializeValues();
    // BlocProvider.of<OccurrenceGeneralInfoCubit>(context).isFormReadable();
  }

  bool showSaveSubmitButtons = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return BlocConsumer<OccurrenceGeneralInfoCubit, OccurrenceGeneralInfoState>(
      listener: (context, state) {
        log('State Status: ${state.status}');
        // log('-deploymentOrderSubmitted---${state.guardingMasterData.deploymentOrderSubmitted}----');
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);

        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: 'Occurrence',
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popAndPushNamed(context, shiftOccurrenceRoute);
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
        initializeDates();

        if (state.model.status == null && state.model.lock.isEmptyOrNull) {
          isReadOnly = false;
        }
        if (state.model.status == 0 && state.model.lock.isEmptyOrNull) {
          isReadOnly = false;
        }
        if (state.model.status == -1) {
          isReadOnly = true;
        }
        if (state.model.status == 1) {
          isReadOnly = true;
        }
        // if (state.model.status == ConstantsIntValue.submitted) {
        //   isReadOnly = state.isReadOnly ?? true;
        // }
        if (!state.model.lock.isEmptyOrNull) {
          isReadOnly = true;
        }
        // if (widget.extraProperties != null &&
        //     !widget.extraProperties!.hasWritePermission!) {
        //   isReadOnly = true;
        // }
        showSaveSubmitButtons = (state.model.status == 0 ||
                state.model.status == null ||
                !isReadOnly) &&
            state.model.lock.isEmptyOrNull;
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            //title: widget.title,
            showPopUp: false,
            showSaveButton:
                showSaveSubmitButtons && state.status != FormStatus.loading,
            showSubmitButton:
                showSaveSubmitButtons && state.status != FormStatus.loading,
            showDisLikeButton: false,
            showLikeButton: false,
            pdfAPIName:
                '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=${Constants.occurrenceModule}',
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<OccurrenceGeneralInfoCubit>(
                context,
              ).submitForm(isSaveOnly: true);
            },
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<OccurrenceGeneralInfoCubit>(
                context,
              ).submitForm(isSaveOnly: false);
            },
            title: widget.title,
          ),
          backgroundColor: AppColors.newColor,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void initializeDates() {
    // dateOfBirthController.text = Utils.timestamptoDateConversion(
    //     int.tryParse(state.model.dateOfBirth ?? '0'),
    //     Constants.dateFormat);
    //
    // dateOfJoiningController.text = Utils.timestamptoDateConversion(
    //     int.parse(state.model.dateOfJoining ?? '0'),
    //     Constants.dateFormat);
  }

  getBodybuilder(OccurrenceGeneralInfoState state, height) {
    //returnableTextController.text =
    // state.materialMovement.returnable! ? 'Returnable' : 'Non Returnable';
    if (state.model.status != null && state.model.status! > 0) {
      disableForm = true;
    }
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    // if (state.status == FormStatus.addAttachment ||
    //     state.status == FormStatus.initial) {
    //   // log('---getAttachments----builder----${getAttachments?.length}-----');
    //   // getFiles = state.loadAttachments ?? [];
    //   // log('---guardAttachments----builder----${state.guardAttachments?.length}-----');
    // }

    return Stack(children: [
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

      // color: AppColors.newColor3,
      // color: AppColors.navigationSkyBlueColor,
      SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.transparent,
              // decoration: const ShapeDecoration(
              //     color: AppColors.backgroundWhiteColor,
              //     shape: RoundedRectangleBorder(
              //       borderRadius:
              //           BorderRadius.vertical(top: Radius.circular(20.0)),
              //     )),
              child: Form(
                key: _formKey,
                autovalidateMode: state.model.status == 1
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              if (!state.model.lock.isEmptyOrNull) ...[
                                RecordLockedWidget(text: '${state.model.lock}'),
                              ],
                              CommonWidgets.verticalSpacerWidget(height * 0.02),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  Constants.generalinformation,
                                  style: Styles.styleHeaderWhiteText16,
                                ),
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Status
                              CommonWidgets.textDisplay(
                                state.labels?.locale.status ??
                                    state.labels?.defaultLocale.status ??
                                    Constants.status,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                height * 0.001,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                height * 0.001,
                              ),
                              BaseDropDown().getDropDown(
                                isDisabled: true,
                                textController: statusController,
                                items: occurrenceStatusDropDownValues,
                                initialValue: '${state.model.status ??= 0}',
                                onTap: () {
                                  if (!disableForm) {
                                    BaseDropDown().assetTypeDialog(
                                      context: context,
                                      dropDownValues:
                                          occurrenceStatusDropDownValues
                                              .map((label) => label.key)
                                              .toList(),
                                      onTap: (String value) {
                                        Label? selectedLabel;
                                        selectedLabel =
                                            occurrenceStatusDropDownValues
                                                .firstWhere(
                                          (label) => label.key == value,
                                          orElse: () => const Label(
                                            key: '',
                                            value: '',
                                          ),
                                        );

                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
                                                context)
                                            .updateDropdownValues(
                                          status: int.tryParse(
                                            selectedLabel.value,
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Shift Handover By
                              CommonWidgets.horizontalTextHandling(
                                state.labels?.locale.entrySecurity ??
                                    state.labels?.defaultLocale.entrySecurity ??
                                    Constants.shiftHandoverBy,
                                isMandatory: true,
                                '${state.model.entrySecurity?.firstName ?? ''} ${state.model.entrySecurity?.lastName ?? ''}',
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Shift Taken Over by
                              CommonWidgets.textDisplay(
                                state.labels?.locale.handoverSecurity ??
                                    state.labels?.defaultLocale
                                        .handoverSecurity ??
                                    Constants.shiftTakenOverBy,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              TextFieldAddButton(
                                title: state.model.handoverSecurity?.userInfo ??
                                    state.model.handoverSecurity?.name,
                                height: 70,
                                isDisableColor: !showSaveSubmitButtons,
                                onTap: () {
                                  if (showSaveSubmitButtons) {
                                    BaseOrganisationDialog().userDialog(
                                      context: context,
                                      users: state.shiftTakenOverBy,
                                      onTap: (BaseUser user) {
                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
                                                context)
                                            .updateDropdownValues(
                                          shiftTakenOverBy: user,
                                        );
                                      },
                                      roleName: ConstantUserRoles
                                          .atomGuardingStaffUser,
                                      locationId: state.model.location!.id!,
                                      isDbUser: false,
                                      functionToCall: (BaseUser user) {
                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
                                                context)
                                            .updateDropdownValues(
                                          shiftTakenOverBy: user,
                                        );
                                        // refresh the list
                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
                                                context)
                                            .refreshList();
                                      },
                                    );
                                  }
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Location
                              CommonWidgets.textDisplay(
                                state.labels?.locale.location ??
                                    state.labels?.defaultLocale.location ??
                                    Constants.location,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                height * 0.001,
                              ),
                              BaseLocationDropdown().locationWidgetDisplay(
                                selectedLocationName:
                                    state.model.location?.name ?? '',
                                isEnabled: !isReadOnly,
                                context: context,
                                locations: state.locations!,
                                onTap: (Organisation? location) async {
                                  log('location?.name-----${location?.name}');

                                  state.model.location = location;

                                  BlocProvider.of<OccurrenceGeneralInfoCubit>(
                                    context,
                                  ).updateLocationDropdownValue(
                                    location: location,
                                  );
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),



                              /// Location Type
                              CommonWidgets.textDisplay(
                                Constants.locationType,
                                Styles.textStyleWhite16,
                                isMandatory: true,
                              ),
                              TextFieldAddButton(
                                title: state.model.locationType?.name,
                                height: 75,
                                isDisableColor: isReadOnly,
                                onTap: () {
                                  if (!isReadOnly) {
                                    BaseOrganisationDialog().departmentDialog(
                                      context: context,
                                      organisations: state.getLocationType.getLocationType ?? [],
                                      onTap: (Organisation locationType) {
                                        BlocProvider.of<OccurrenceGeneralInfoCubit>(context)
                                            .updateDropdownValues(locationType: locationType);
                                      },
                                      leftImage: false,
                                      createEntity: false,
                                      functionToCall: () {
                                        BlocProvider.of<OccurrenceGeneralInfoCubit>(context).refreshList();
                                      },
                                    );
                                  }
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.03),

                              /// Date of creation
                              CommonWidgets.textDisplay(
                                state.labels?.locale.inputDate ??
                                    state.labels?.defaultLocale.inputDate ??
                                    Constants.dateofcreation,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                height * 0.001,
                              ),
                              BaseDate().creationDateDisplay(
                                state.model.inputDate ?? '',
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Sl No.
                              CommonWidgets.horizontalTextHandling(
                                state.labels?.locale.slNo ??
                                    state.labels?.defaultLocale.slNo ??
                                    Constants.slno,
                                isMandatory: true,
                                state.model.slNo ?? '',
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),


                              /// Ipad Serial No.
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.postName ??
                                //     state.labels?.defaultLocale.postName ??
                                  Constants.ipadSerialNo,
                                  isMandatory: true,
                                  Styles.textStyleWhite16),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              TextFieldAddButton(
                                title: state.model.ipadSerialNo?.name,
                                height: 70,
                                isDisableColor: isReadOnly,
                                onTap: () {
                                  if (!isReadOnly) {
                                    BaseOrganisationDialog().departmentDialog(
                                      context: context,
                                      organisations: state.ipadSerialNum ?? [],
                                      onTap: (Organisation? org) {
                                        state.model.ipadSerialNo?.name =
                                            org?.name;
                                        BlocProvider.of<
                                            OccurrenceGeneralInfoCubit>(
                                            context)
                                            .updateDropdownValues(
                                            ipadSerialNum : org);
                                      },
                                    );
                                  }
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// DutyPost Location Name
                              CommonWidgets.textDisplay(
                                  // state.labels?.locale.postName ??
                                  //     state.labels?.defaultLocale.postName ??
                                  Constants.dutyPostLocationNames,
                                  isMandatory: true,
                                  Styles.textStyleWhite16),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              TextFieldAddButton(
                                title: state.model.dutyPostLocation?.name,
                                height: 70,
                                isDisableColor: isReadOnly,
                                onTap: () {
                                  if (!isReadOnly) {
                                    BaseOrganisationDialog().departmentDialog(
                                      context: context,
                                      organisations: state.dutyPosts ?? [],
                                      onTap: (Organisation? org) {
                                        state.model.dutyPostLocation?.name =
                                            org?.name;
                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
                                                context)
                                            .updateDropdownValues(
                                                dutyPostName: org);
                                      },
                                    );
                                  }
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Work Shifts
                              CommonWidgets.textDisplay(
                                  // state.labels?.locale.staffCategory ??
                                  //     state.labels?.defaultLocale.staffCategory ??
                                  Constants.workShift,
                                  //isMandatory: true,
                                  Styles.textStyleWhite14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),

                              BaseDropDown().getDropDown(
                                  isDisabled: !showSaveSubmitButtons,
                                  textController: workShiftController,
                                  initialValue:
                                  state.model.shifts.toString(),
                                  items: workShift,
                                  onTap: () {
                                    if (showSaveSubmitButtons) {
                                      BaseDropDown().assetTypeDialog(
                                        context: context,
                                        dropDownValues: workShift
                                            .map((label) => label.key)
                                            .toList(),
                                        onTap: (String value) {
                                          Label? selectedLabel;
                                          selectedLabel = workShift.firstWhere(
                                            (label) => label.key == value,
                                            orElse: () =>
                                                const Label(key: '', value: ''),
                                          );
                                          workShiftController.text =
                                              selectedLabel.key;
                                          state.model.shifts =
                                              int.tryParse(selectedLabel.value);
                                        },
                                      );
                                    }
                                  }),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              ///Shift Briefing Attended
                              CommonWidgets.textDisplay(
                                state.labels?.locale.shiftBrfngAttnded ??
                                    state.labels?.defaultLocale
                                        .shiftBrfngAttnded ??
                                    Constants.shiftBriefingAttended,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              RadioButtonsYesNo(
                                status: state.model.status ?? 0,
                                selectedValue:
                                    state.model.shiftBrfngAttnded ? 1 : 0,
                                onChangedYes: !showSaveSubmitButtons
                                    ? null
                                    : (val) {
                                        state.model.shiftBrfngAttnded = true;
                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
                                                context)
                                            .showFields(
                                          shiftBrfngAttnded: true,
                                        );
                                        //.onModelValueChange(state.guardingMasterData
                                        //);
                                      },
                                onChangedNo: !showSaveSubmitButtons
                                    ? null
                                    : (val) {
                                        state.model.shiftBrfngAttnded = false;
                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
                                                context)
                                            .showFields(
                                          shiftBrfngAttnded: false,
                                        );
                                      },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Premises Round Taken
                              CommonWidgets.textDisplay(
                                state.labels?.locale.premisesRoundTkn ??
                                    state.labels?.defaultLocale
                                        .premisesRoundTkn ??
                                    Constants.premisesRoundTaken,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              RadioButtonsYesNo(
                                status: state.model.status ?? 0,
                                selectedValue:
                                    state.model.premisesRoundTkn ? 1 : 0,
                                onChangedYes: !showSaveSubmitButtons
                                    ? null
                                    : (val) {
                                        state.model.premisesRoundTkn = true;
                                        state.model.premisesRoundTknComments =
                                            null;
                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
                                                context)
                                            .showFields(premisesRoundTkn: true);
                                        //.onModelValueChange(state.guardingMasterData
                                        //);
                                      },
                                onChangedNo: !showSaveSubmitButtons
                                    ? null
                                    : (val) {
                                        state.model.premisesRoundTkn = false;
                                        state.model.premisesRoundTknComments =
                                            null;
                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
                                                context)
                                            .showFields(
                                          premisesRoundTkn: false,
                                        );
                                      },
                              ),

                              if (state.model.premisesRoundTkn == true) ...[
                                /// Premises Round Taken Comments
                                FlutterInputField(
                                  lineHeight: 6,
                                  characterLimit:
                                      Constants.characterLimitDescTextFormField,
                                  initialValue:
                                      state.model.premisesRoundTknComments,
                                  textFormKey: Keys.premisesRoundTknCommentsKey,
                                  hintText: Constants.informationhere,
                                  showBorder: true,
                                  textInputAction: TextInputAction.newline,
                                  textInputType: TextInputType.multiline,
                                  isEnable: showSaveSubmitButtons,
                                  isDisableColor: !showSaveSubmitButtons,
                                  onChange: (String value) {
                                    state.model.premisesRoundTknComments =
                                        value;
                                    context
                                        .read<OccurrenceGeneralInfoCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                  height * 0.01,
                                ),
                              ],
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              ///Medical Emergency
                              CommonWidgets.textDisplay(
                                state.labels?.locale.medicalEmrgncy ??
                                    state
                                        .labels?.defaultLocale.medicalEmrgncy ??
                                    Constants.medicalEmergency,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              RadioButtonsYesNo(
                                status: state.model.status ?? 0,
                                selectedValue:
                                    state.model.medicalEmrgncy ? 1 : 0,
                                onChangedYes: !showSaveSubmitButtons
                                    ? null
                                    : (val) {
                                        state.model.medicalEmrgncy = true;
                                        state.model.medicalEmrgncyComments =
                                            null;
                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
                                                context)
                                            .showFields(medicalEmrgncy: true);
                                        //.onModelValueChange(state.guardingMasterData
                                        //);
                                      },
                                onChangedNo: !showSaveSubmitButtons
                                    ? null
                                    : (val) {
                                        state.model.medicalEmrgncy = false;
                                        state.model.medicalEmrgncyComments =
                                            null;
                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
                                                context)
                                            .showFields(medicalEmrgncy: false);
                                      },
                              ),
                              if (state.model.medicalEmrgncy == true) ...[
                                /// Medical Emergency Comments
                                FlutterInputField(
                                  lineHeight: 6,
                                  characterLimit:
                                      Constants.characterLimitDescTextFormField,
                                  initialValue:
                                      state.model.medicalEmrgncyComments,
                                  showBorder: true,
                                  textFormKey: Keys.emergencyCommentsKey,
                                  hintText: Constants.informationhere,
                                  isEnable: showSaveSubmitButtons,
                                  isDisableColor: !showSaveSubmitButtons,
                                  textInputAction: TextInputAction.newline,
                                  textInputType: TextInputType.multiline,
                                  onChange: (String value) {
                                    state.model.medicalEmrgncyComments = value;
                                    context
                                        .read<OccurrenceGeneralInfoCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                  height * 0.01,
                                ),
                              ],
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              ///Material Movement
                              CommonWidgets.textDisplay(
                                state.labels?.locale.materialMovement ??
                                    state.labels?.defaultLocale
                                        .materialMovement ??
                                    Constants.materialMovement,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              RadioButtonsYesNo(
                                status: state.model.status ?? 0,
                                selectedValue:
                                    state.model.materialMovement ? 1 : 0,
                                onChangedYes: !showSaveSubmitButtons
                                    ? null
                                    : (val) {
                                        state.model.materialMovement = true;
                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
                                                context)
                                            .showFields(materialMovement: true);
                                        //.onModelValueChange(state.guardingMasterData
                                        //);
                                      },
                                onChangedNo: !showSaveSubmitButtons
                                    ? null
                                    : (val) {
                                        state.model.materialMovement = false;
                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
                                                context)
                                            .showFields(
                                          materialMovement: false,
                                        );
                                      },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// LEO Visit
                              CommonWidgets.textDisplay(
                                state.labels?.locale.leoVisit ??
                                    state.labels?.defaultLocale.leoVisit ??
                                    Constants.lEOVisit,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              RadioButtonsYesNo(
                                status: state.model.status ?? 0,
                                selectedValue: state.model.leoVisit ? 1 : 0,
                                onChangedYes: !showSaveSubmitButtons
                                    ? null
                                    : (val) {
                                        state.model.leoVisit = true;
                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
                                                context)
                                            .showFields(leoVisit: true);
                                        //.onModelValueChange(state.guardingMasterData
                                        //);
                                      },
                                onChangedNo: !showSaveSubmitButtons
                                    ? null
                                    : (val) {
                                        state.model.leoVisit = false;
                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
                                                context)
                                            .showFields(leoVisit: false);
                                      },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Social Engineering Incidents
                              CommonWidgets.textDisplay(
                                state.labels?.locale.socialEnggIncdnt ??
                                    state.labels?.defaultLocale
                                        .socialEnggIncdnt ??
                                    Constants.socialEngineeringIncidents,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              RadioButtonsYesNo(
                                status: state.model.status ?? 0,
                                selectedValue:
                                    state.model.socialEnggIncdnt ? 1 : 0,
                                onChangedYes: !showSaveSubmitButtons
                                    ? null
                                    : (val) {
                                        state.model.socialEnggIncdnt = true;
                                        state.model.socialEnggIncdntComments =
                                            null;
                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
                                                context)
                                            .showFields(socialEnggIncdnt: true);
                                        //.onModelValueChange(state.guardingMasterData
                                        //);
                                      },
                                onChangedNo: !showSaveSubmitButtons
                                    ? null
                                    : (val) {
                                        state.model.socialEnggIncdnt = false;
                                        state.model.socialEnggIncdntComments =
                                            null;
                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
                                                context)
                                            .showFields(
                                          socialEnggIncdnt: false,
                                        );
                                      },
                              ),

                              if (state.model.socialEnggIncdnt == true) ...[
                                /// Medical Emergency Comments
                                FlutterInputField(
                                  lineHeight: 6,
                                  characterLimit:
                                      Constants.characterLimitDescTextFormField,
                                  initialValue:
                                      state.model.socialEnggIncdntComments,
                                  showBorder: true,
                                  textFormKey: Keys.socialEnggIncdntCommentsKey,
                                  hintText: Constants.informationhere,
                                  isEnable: showSaveSubmitButtons,
                                  isDisableColor: !showSaveSubmitButtons,
                                  textInputAction: TextInputAction.newline,
                                  textInputType: TextInputType.multiline,
                                  onChange: (String value) {
                                    state.model.socialEnggIncdntComments =
                                        value;
                                    context
                                        .read<OccurrenceGeneralInfoCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                  height * 0.01,
                                ),
                              ],
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Found Article Transaction
                              CommonWidgets.textDisplay(
                                state.labels?.locale.foundArticleTrnsctn ??
                                    state.labels?.defaultLocale
                                        .foundArticleTrnsctn ??
                                    Constants.foundArticleTransaction,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              RadioButtonsYesNo(
                                status: state.model.status ?? 0,
                                selectedValue:
                                    state.model.foundArticleTrnsctn ? 1 : 0,
                                onChangedYes: !showSaveSubmitButtons
                                    ? null
                                    : (val) {
                                        state.model.foundArticleTrnsctn = true;
                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
                                                context)
                                            .showFields(
                                          foundArticleTrnsctn: true,
                                        );
                                        //.onModelValueChange(state.guardingMasterData
                                        //);
                                      },
                                onChangedNo: !showSaveSubmitButtons
                                    ? null
                                    : (val) {
                                        state.model.foundArticleTrnsctn = false;
                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
                                                context)
                                            .showFields(
                                          foundArticleTrnsctn: false,
                                        );
                                      },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Process Breach Incident
                              CommonWidgets.textDisplay(
                                state.labels?.locale.processBreachIncdnt ??
                                    state.labels?.defaultLocale
                                        .processBreachIncdnt ??
                                    Constants.processBreachIncident,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              RadioButtonsYesNo(
                                status: state.model.status ?? 0,
                                selectedValue:
                                    state.model.processBreachIncdnt ? 1 : 0,
                                onChangedYes: !showSaveSubmitButtons
                                    ? null
                                    : (val) {
                                        state.model.processBreachIncdnt = true;
                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
                                                context)
                                            .showFields(
                                          processBreachIncdnt: true,
                                        );
                                        //.onModelValueChange(state.guardingMasterData
                                        //);
                                      },
                                onChangedNo: !showSaveSubmitButtons
                                    ? null
                                    : (val) {
                                        state.model.processBreachIncdnt = false;
                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
                                                context)
                                            .showFields(
                                          processBreachIncdnt: false,
                                        );
                                        // .onModelValueChange(state.guardingMasterData
                                        //  );
                                      },
                              ),
                            ],
                          ),

                          if (state.model.processBreachIncdnt == true) ...[
                            CommonWidgets.textDisplay(
                              Constants.incidentItemList,
                              Styles.textStyleWhite14,
                            ),
                            GestureDetector(
                              onTap: () => navigateToCreateIncident(
                                state: state,
                                occType: 1,
                                isSSTIncident: false,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  if (state.model.status !=
                                          ConstantsIntValue.submitted &&
                                      !isReadOnly) ...[
                                    const SizedBox(width: 14),
                                    SvgPicture.asset(
                                      AppIcon.plusCircle,
                                      colorFilter: const ColorFilter.mode(
                                        AppColors.white,
                                        BlendMode.srcIn,
                                      ),
                                      // color: AppColors.navigationSkyBlueColor,
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      'Add Incident Item List',
                                      style: TextStyle(
                                        color: AppColors.white,
                                        decoration: TextDecoration.underline,
                                        decorationColor: AppColors.white,
                                      ),
                                    ),
                                    // if (state.model.incidentItems != null &&
                                    //     !state.model.incidentItems!.where(
                                    //         (element) =>
                                    //             element.incidentType ==
                                    //             1).isEmptyOrNull) ...[
                                    CommonWidgets.horizontalSpacerWidget(
                                      height * 0.01,
                                    ),
                                  ],
                                  showButtonDisplay(
                                    occId: state.model.id.toString(),
                                    occType: 1,
                                    state: state,
                                  ),
                                  // ],
                                ],
                              ),
                            ),
                          ],

                          Column(
                            children: [
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Any Infrastructural Issue
                              CommonWidgets.textDisplay(
                                state.labels?.locale.infraIssue ??
                                    state.labels?.defaultLocale.infraIssue ??
                                    Constants.anyInfrastructuralIssue,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              RadioButtonsYesNo(
                                status: state.model.status ?? 0,
                                selectedValue: state.model.infraIssue ? 1 : 0,
                                onChangedYes: !showSaveSubmitButtons
                                    ? null
                                    : (val) {
                                        state.model.infraIssue = true;
                                        state.model.infraIssueComments = null;
                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
                                                context)
                                            .showFields(infraIssue: true);
                                        //.onModelValueChange(state.guardingMasterData
                                        //);
                                      },
                                onChangedNo: !showSaveSubmitButtons
                                    ? null
                                    : (val) {
                                        state.model.infraIssue = false;
                                        state.model.infraIssueComments = null;
                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
                                                context)
                                            .showFields(infraIssue: false);
                                      },
                              ),

                              if (state.model.infraIssue == true) ...[
                                /// Any Infrastructural Issue Comments
                                FlutterInputField(
                                  lineHeight: 6,
                                  characterLimit:
                                      Constants.characterLimitDescTextFormField,
                                  initialValue: state.model.infraIssueComments,
                                  textFormKey: Keys.infraIssueCommentsKey,
                                  showBorder: true,
                                  hintText: Constants.informationhere,
                                  isEnable: showSaveSubmitButtons,
                                  isDisableColor: !showSaveSubmitButtons,
                                  textInputAction: TextInputAction.newline,
                                  textInputType: TextInputType.multiline,
                                  onChange: (String value) {
                                    state.model.infraIssueComments = value;
                                    context
                                        .read<OccurrenceGeneralInfoCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                  height * 0.01,
                                ),
                              ],
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Any Suspicious Activity
                              CommonWidgets.textDisplay(
                                state.labels?.locale.suspiciousActivity ??
                                    state.labels?.defaultLocale
                                        .suspiciousActivity ??
                                    Constants.anySuspiciousActivity,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              RadioButtonsYesNo(
                                status: state.model.status ?? 0,
                                selectedValue:
                                    state.model.suspiciousActivity ? 1 : 0,
                                onChangedYes: !showSaveSubmitButtons
                                    ? null
                                    : (val) {
                                        state.model.suspiciousActivity = true;
                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
                                                context)
                                            .showFields(
                                          suspiciousActivity: true,
                                        );
                                      },
                                onChangedNo: !showSaveSubmitButtons
                                    ? null
                                    : (val) {
                                        state.model.suspiciousActivity = false;
                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
                                                context)
                                            .showFields(
                                          suspiciousActivity: false,
                                        );
                                      },
                              ),
                            ],
                          ),

                          if (state.model.suspiciousActivity == true) ...[
                            CommonWidgets.textDisplay(
                              Constants.incidentItemList,
                              Styles.textStyleWhite14,
                            ),
                            GestureDetector(
                              onTap: () => navigateToCreateIncident(
                                state: state,
                                occType: 2,
                                isSSTIncident: false,
                              ),
                              child: Row(
                                children: <Widget>[
                                  if (state.model.status !=
                                          ConstantsIntValue.submitted &&
                                      !isReadOnly) ...[
                                    const SizedBox(width: 14),
                                    SvgPicture.asset(
                                      AppIcon.plusCircle,
                                      colorFilter: const ColorFilter.mode(
                                        AppColors.white,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      'Add Incident Item List',
                                      style: TextStyle(
                                        color: AppColors.white,
                                        decoration: TextDecoration.underline,
                                        decorationColor: AppColors.white,
                                      ),
                                    ),
                                    // if (state.model.incidentItems != null &&
                                    //     state.model.incidentItems!
                                    //         .isNotEmpty) ...[
                                    CommonWidgets.horizontalSpacerWidget(
                                      height * 0.01,
                                    ),
                                  ],
                                  showButtonDisplay(
                                    occId: state.model.id.toString(),
                                    occType: 2,
                                    state: state,
                                  ),
                                  // ],
                                ],
                              ),
                            ),
                          ],
                          CommonWidgets.verticalSpacerWidget(height * 0.02),
                          Column(
                            children: [
                              /// Fire Alarm Emergency Occurred
                              CommonWidgets.textDisplay(
                                state.labels?.locale.fireAlarmEmrgncy ??
                                    state.labels?.defaultLocale
                                        .fireAlarmEmrgncy ??
                                    Constants.fireAlarmEmergencyOccurred,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              RadioButtonsYesNo(
                                status: state.model.status ?? 0,
                                selectedValue:
                                    state.model.fireAlarmEmrgncy ? 1 : 0,
                                onChangedYes: !showSaveSubmitButtons
                                    ? null
                                    : (val) {
                                        state.model.fireAlarmEmrgncy = true;
                                        state.model.fireAlarmEmrgncyComments =
                                            null;
                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
                                                context)
                                            .showFields(fireAlarmEmrgncy: true);
                                      },
                                onChangedNo: !showSaveSubmitButtons
                                    ? null
                                    : (val) {
                                        state.model.fireAlarmEmrgncy = false;
                                        state.model.fireAlarmEmrgncyComments =
                                            null;
                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
                                                context)
                                            .showFields(
                                          fireAlarmEmrgncy: false,
                                        );
                                      },
                              ),

                              if (state.model.fireAlarmEmrgncy == true) ...[
                                /// fire Alarm Emrgncy comments
                                FlutterInputField(
                                  lineHeight: 6,
                                  characterLimit:
                                      Constants.characterLimitDescTextFormField,
                                  initialValue:
                                      state.model.fireAlarmEmrgncyComments,
                                  showBorder: true,
                                  textFormKey: Keys.fireAlarmEmrgncyCommentsKey,
                                  hintText: Constants.informationhere,
                                  isEnable: showSaveSubmitButtons,
                                  isDisableColor: !showSaveSubmitButtons,
                                  textInputAction: TextInputAction.newline,
                                  textInputType: TextInputType.multiline,
                                  onChange: (String value) {
                                    state.model.fireAlarmEmrgncyComments =
                                        value;
                                    context
                                        .read<OccurrenceGeneralInfoCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                  height * 0.01,
                                ),
                              ],
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Landlord Issue
                              CommonWidgets.textDisplay(
                                state.labels?.locale.landlordIssue ??
                                    state.labels?.defaultLocale.landlordIssue ??
                                    Constants.landlordIssue,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              RadioButtonsYesNo(
                                status: state.model.status ?? 0,
                                selectedValue:
                                    state.model.landlordIssue ? 1 : 0,
                                onChangedYes: !showSaveSubmitButtons
                                    ? null
                                    : (val) {
                                        state.model.landlordIssue = true;
                                        state.model.landlordIssueComments =
                                            null;
                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
                                                context)
                                            .showFields(landlordIssue: true);
                                      },
                                onChangedNo: !showSaveSubmitButtons
                                    ? null
                                    : (val) {
                                        state.model.landlordIssue = false;
                                        state.model.landlordIssueComments =
                                            null;
                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
                                                context)
                                            .showFields(landlordIssue: false);
                                      },
                              ),

                              if (state.model.landlordIssue == true) ...[
                                /// fire Alarm Emrgncy comments
                                FlutterInputField(
                                  lineHeight: 6,
                                  characterLimit:
                                      Constants.characterLimitDescTextFormField,
                                  initialValue:
                                      state.model.landlordIssueComments,
                                  showBorder: true,
                                  textFormKey: Keys.landlordIssueCommentsKey,
                                  hintText: Constants.informationhere,
                                  isEnable: showSaveSubmitButtons,
                                  isDisableColor: !showSaveSubmitButtons,
                                  textInputAction: TextInputAction.newline,
                                  textInputType: TextInputType.multiline,
                                  onChange: (String value) {
                                    state.model.landlordIssueComments = value;
                                    context
                                        .read<OccurrenceGeneralInfoCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                  height * 0.01,
                                ),
                              ],
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              ///Security System Failure Incidents
                              CommonWidgets.textDisplay(
                                state.labels?.locale.secSysFailureIncdnt ??
                                    state.labels?.defaultLocale
                                        .secSysFailureIncdnt ??
                                    Constants.securitySystemFailureIncidents,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              RadioButtonsYesNo(
                                status: state.model.status ?? 0,
                                selectedValue:
                                    state.model.secSysFailureIncdnt ? 1 : 0,
                                onChangedYes: !showSaveSubmitButtons
                                    ? null
                                    : (val) {
                                        state.model.secSysFailureIncdnt = true;
                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
                                                context)
                                            .showFields(
                                          secSysFailureIncdnt: true,
                                        );
                                      },
                                onChangedNo: !showSaveSubmitButtons
                                    ? null
                                    : (val) {
                                        state.model.secSysFailureIncdnt = false;
                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
                                                context)
                                            .showFields(
                                          secSysFailureIncdnt: false,
                                        );
                                      },
                              ),
                            ],
                          ),
                          if (state.model.secSysFailureIncdnt == true) ...[
                            CommonWidgets.textDisplay(
                              Constants.securitySystemSLAList,
                              Styles.textStyleWhite14,
                            ),
                            GestureDetector(
                              // onTap: () {
                              //   if (isReadOnly) {
                              //     return;
                              //   }
                              //   openSecuritySystemSLATypePopUp(
                              //       state: state, showListing: false);
                              // },
                              onTap: () => navigateToCreateIncident(
                                state: state,
                                occType: 1,
                                isSSTIncident: true,
                              ),
                              child: Row(
                                children: <Widget>[
                                  if (state.model.status !=
                                          ConstantsIntValue.submitted &&
                                      !isReadOnly) ...[
                                    const SizedBox(width: 14),
                                    SvgPicture.asset(
                                      AppIcon.plusCircle,
                                      colorFilter: const ColorFilter.mode(
                                        AppColors.white,
                                        BlendMode.srcIn,
                                      ),
                                      // color: AppColors.navigationSkyBlueColor,
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      'Add Security System SLA List',
                                      style: TextStyle(
                                        color: AppColors.white,
                                        decoration: TextDecoration.underline,
                                        decorationColor: AppColors.white,
                                      ),
                                    ),
                                  ],
                                  if (state.model.secSysFailureIncident !=
                                      null) ...[
                                    CommonWidgets.horizontalSpacerWidget(
                                      height * 0.01,
                                    ),
                                    showButtonDisplay(
                                      occId: state.model.id.toString(),
                                      occType: 2,
                                      state: state,
                                      isSSTIncident: true,
                                      showPopUp: true,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                          CommonWidgets.verticalSpacerWidget(height * 0.02),

                          ///Any System Alarm Received
                          CommonWidgets.textDisplay(
                            state.labels?.locale.sysAlarmRcvd ??
                                state.labels?.defaultLocale.sysAlarmRcvd ??
                                Constants.anySystemAlarmReceived,
                            isMandatory: true,
                            Styles.textStyleWhite14,
                          ),
                          RadioButtonsYesNo(
                            status: state.model.status ?? 0,
                            selectedValue: state.model.sysAlarmRcvd ? 1 : 0,
                            onChangedYes: !showSaveSubmitButtons
                                ? null
                                : (val) {
                                    state.model.sysAlarmRcvd = true;
                                    state.model.sysAlarmRcvdComments = null;
                                    BlocProvider.of<OccurrenceGeneralInfoCubit>(
                                      context,
                                    ).showFields(sysAlarmRcvd: true);
                                  },
                            onChangedNo: !showSaveSubmitButtons
                                ? null
                                : (val) {
                                    state.model.sysAlarmRcvd = false;
                                    state.model.sysAlarmRcvdComments = null;
                                    BlocProvider.of<OccurrenceGeneralInfoCubit>(
                                      context,
                                    ).showFields(sysAlarmRcvd: false);
                                  },
                          ),

                          if (state.model.sysAlarmRcvd == true) ...[
                            /// Any system alarm received Comments
                            FlutterInputField(
                              lineHeight: 6,
                              characterLimit:
                                  Constants.characterLimitDescTextFormField,
                              initialValue: state.model.sysAlarmRcvdComments,
                              textFormKey: Keys.sysAlarmRcvdCommentsKey,
                              showBorder: true,
                              hintText: Constants.informationhere,
                              isEnable: showSaveSubmitButtons,
                              isDisableColor: !showSaveSubmitButtons,
                              textInputAction: TextInputAction.newline,
                              textInputType: TextInputType.multiline,
                              onChange: (String value) {
                                state.model.sysAlarmRcvdComments = value;
                                context
                                    .read<OccurrenceGeneralInfoCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                          ],
                          CommonWidgets.verticalSpacerWidget(height * 0.02),

                          ///Transport Incident
                          CommonWidgets.textDisplay(
                            state.labels?.locale.transportIncdnt ??
                                state.labels?.defaultLocale.transportIncdnt ??
                                Constants.transportIncident,
                            isMandatory: true,
                            Styles.textStyleWhite14,
                          ),
                          RadioButtonsYesNo(
                            status: state.model.status ?? 0,
                            selectedValue: state.model.transportIncdnt ? 1 : 0,
                            onChangedYes: !showSaveSubmitButtons
                                ? null
                                : (val) {
                                    state.model.transportIncdnt = true;
                                    state.model.transportIncdntComments = null;
                                    BlocProvider.of<OccurrenceGeneralInfoCubit>(
                                      context,
                                    ).showFields(transportIncdnt: true);
                                  },
                            onChangedNo: !showSaveSubmitButtons
                                ? null
                                : (val) {
                                    state.model.transportIncdnt = false;
                                    state.model.transportIncdntComments = null;
                                    BlocProvider.of<OccurrenceGeneralInfoCubit>(
                                      context,
                                    ).showFields(transportIncdnt: false);
                                  },
                          ),

                          if (state.model.transportIncdnt == true) ...[
                            /// Transport incident  Comments
                            FlutterInputField(
                              lineHeight: 6,
                              characterLimit:
                                  Constants.characterLimitDescTextFormField,
                              initialValue: state.model.transportIncdntComments,
                              textFormKey: Keys.transportIncdntCommentsKey,
                              hintText: Constants.informationhere,
                              showBorder: true,
                              isEnable: showSaveSubmitButtons,
                              isDisableColor: !showSaveSubmitButtons,
                              textInputAction: TextInputAction.newline,
                              textInputType: TextInputType.multiline,
                              onChange: (String value) {
                                state.model.transportIncdntComments = value;
                                context
                                    .read<OccurrenceGeneralInfoCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                          ],
                          CommonWidgets.verticalSpacerWidget(height * 0.02),


                          ///Monsoon
                          CommonWidgets.textDisplay(
                            // state.labels?.locale.transportIncdnt ??
                            //     state.labels?.defaultLocale.transportIncdnt ??
                            Constants.monsoon,
                            isMandatory: true,
                            Styles.textStyleWhite14,
                          ),
                          RadioButtonsYesNo(
                            status: state.model.status ?? 0,
                            selectedValue:
                            state.model.monsoon ? 1 : 0,
                            onChangedYes: (val) {
                            },
                            onChangedNo: (val) {
                            },
                            // onChangedYes: !showSaveSubmitButtons
                            //     ? null
                            //     : (val) {
                            //   state.model.monsoon = true;
                            //   BlocProvider.of<
                            //       OccurrenceGeneralInfoCubit>(
                            //       context)
                            //       .showFields(monsoon: true);
                            //   //.onModelValueChange(state.guardingMasterData
                            //   //);
                            // },
                            // onChangedNo: !showSaveSubmitButtons
                            //     ? null
                            //     : (val) {
                            //   state.model.monsoon = false;
                            //   BlocProvider.of<
                            //       OccurrenceGeneralInfoCubit>(
                            //       context)
                            //       .showFields(
                            //     monsoon: false,
                            //   );
                            // },
                          ),


                          // if(state.model.monsoon == true)...[
                          //   /// 🔹 TEMPLATE LIST
                          //   Container(
                          //     decoration: BoxDecoration(
                          //       borderRadius:
                          //       BorderRadius.circular(7),
                          //       border: Border.all(
                          //           color: Colors.white,
                          //           width: .7),
                          //     ),
                          //     child: Column(
                          //       children: [
                          //         Container(
                          //           padding: const EdgeInsets
                          //               .symmetric(
                          //               horizontal: 16,
                          //               vertical: 12),
                          //           color: Colors.white
                          //               .withValues(alpha: 0.1),
                          //           child: const Row(
                          //             children: [
                          //               Expanded(
                          //                 child: Text("Id",
                          //                     style: TextStyle(
                          //                         color: Colors
                          //                             .white,
                          //                         fontWeight:
                          //                         FontWeight
                          //                             .bold)),
                          //               ),
                          //               Expanded(
                          //                 child: Text("Location",
                          //                     style: TextStyle(
                          //                         color: Colors
                          //                             .white,
                          //                         fontWeight:
                          //                         FontWeight
                          //                             .bold)),
                          //               ),
                          //               Text(
                          //                   "Edit",
                          //                   style: TextStyle(
                          //                       color: Colors
                          //                           .white,
                          //                       fontWeight:
                          //                       FontWeight
                          //                           .bold)),
                          //             ],
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ],

                          if (state.model.monsoon == true) ...[
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(color: Colors.white, width: .7),
                              ),
                              child: Column(
                                children: [
                                  /// HEADER
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                    color: Colors.white.withValues(alpha: 0.1),
                                    child: const Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Id",
                                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "Location",
                                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(
                                          "Edit",
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),

                                  /// RECORDS
                                  ...?state.model.lsmUpdateList?.map((item) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          /// ID
                                          Expanded(
                                            child: Text(
                                              '${item.id}',
                                              style: const TextStyle(color: Colors.white),
                                            ),
                                          ),

                                          /// LOCATION NAME
                                          Expanded(
                                            child: Text(
                                              item.location!.name!,
                                              style: const TextStyle(color: Colors.white),
                                            ),
                                          ),

                                          /// EDIT BUTTON
                                          InkWell(
                                            onTap: () async {
                                              try {
                                                final lsmData = await lsmService.getLSMById('${item.id}'); // pass the correct id
                                                if (!context.mounted) return;
                                                Navigator.pushNamed(
                                                  context,
                                                  opsSituationUpdateDetailsRoute,
                                                  arguments: {
                                                    ConstantsArgument.title: 'Optional Team Situational Update',
                                                    ConstantsArgument.model: lsmData,
                                                  },
                                                );
                                              } catch (e) {
                                                debugPrint('Error fetching LSM: $e');
                                                // optionally show snackbar / dialog
                                              }
                                            },
                                            child: const Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                          ),

                                        ],
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ],

                          CommonWidgets.verticalSpacerWidget(height * 0.02),

                          ///Is privacy Screen Present on the Teller Computer Screen
                          CommonWidgets.textDisplay(
                            // state.labels?.locale.transportIncdnt ??
                            //     state.labels?.defaultLocale.transportIncdnt ??
                            Constants.isPrivacyScreenPresent,
                            isMandatory: true,
                            Styles.textStyleWhite14,
                          ),
                          RadioButtonsYesNo(
                            status: state.model.status ?? 0,
                            selectedValue: state.model.privacyScreenPresent ? 1 : 0,
                            onChangedYes: !showSaveSubmitButtons
                                ? null
                                : (val) {
                                    state.model.privacyScreenPresent = true;
                                    state.model.privacyScreenComments = null;
                                    BlocProvider.of<OccurrenceGeneralInfoCubit>(
                                      context,
                                    ).showFields(isPrivacyScreen: true);
                                  },
                            onChangedNo: !showSaveSubmitButtons
                                ? null
                                : (val) {
                                    state.model.privacyScreenPresent = false;
                                    state.model.privacyScreenComments = null;
                                    BlocProvider.of<OccurrenceGeneralInfoCubit>(
                                      context,
                                    ).showFields(isPrivacyScreen: false);
                                  },
                          ),

                          if (state.model.privacyScreenPresent == false) ...[
                            /// Reason
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.transportIncdnt ??
                              //     state.labels?.defaultLocale.transportIncdnt ??
                              Constants.reason,
                              isMandatory: true,
                              Styles.textStyleWhite14,
                            ),
                            FlutterInputField(
                              lineHeight: 6,
                              characterLimit:
                                  Constants.characterLimitDescTextFormField,
                              initialValue: state.model.privacyScreenComments,
                              textFormKey: Keys.transportIncdntCommentsKey,
                              hintText: Constants.informationhere,
                              showBorder: true,
                              isEnable: showSaveSubmitButtons,
                              isDisableColor: !showSaveSubmitButtons,
                              textInputAction: TextInputAction.newline,
                              textInputType: TextInputType.multiline,
                              onChange: (String value) {
                                state.model.privacyScreenComments = value;
                                context
                                    .read<OccurrenceGeneralInfoCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                          ],
                          CommonWidgets.verticalSpacerWidget(height * 0.02),

                          /// Any Event
                          CommonWidgets.textDisplay(
                            state.labels?.locale.anyEvent ??
                                state.labels?.defaultLocale.anyEvent ??
                                Constants.anyEvent,
                            isMandatory: true,
                            Styles.textStyleWhite14,
                          ),
                          RadioButtonsYesNo(
                            status: state.model.status ?? 0,
                            selectedValue: state.model.anyEvent ? 1 : 0,
                            onChangedYes: !showSaveSubmitButtons
                                ? null
                                : (val) {
                                    state.model.anyEvent = true;
                                    state.model.notifyScri = null;
                                    BlocProvider.of<OccurrenceGeneralInfoCubit>(
                                      context,
                                    ).showFields(anyEvent: true);
                                    //.onModelValueChange(state.guardingMasterData
                                    //);
                                  },
                            onChangedNo: !showSaveSubmitButtons
                                ? null
                                : (val) {
                                    state.model.anyEvent = false;
                                    state.model.notifyScri = null;
                                    BlocProvider.of<OccurrenceGeneralInfoCubit>(
                                      context,
                                    ).showFields(anyEvent: false);
                                  },
                          ),

                          if (state.model.anyEvent == true) ...[
                            /// Notifi SCRI
                            CommonWidgets.textDisplay(
                              state.labels?.locale.notifyScri ??
                                  state.labels?.defaultLocale.notifyScri ??
                                  Constants.notifySCRI,
                              Styles.textStyleWhite14,
                            ),
                            FlutterInputField(
                              lineHeight: 6,
                              characterLimit:
                                  Constants.characterLimitDescTextFormField,
                              initialValue: state.model.notifyScri,
                              textFormKey: Keys.notifyScriKey,
                              hintText: Constants.informationhere,
                              isEnable: showSaveSubmitButtons,
                              showBorder: true,
                              isDisableColor: !showSaveSubmitButtons,
                              textInputAction: TextInputAction.newline,
                              textInputType: TextInputType.multiline,
                              onChange: (String value) {
                                state.model.notifyScri = value;
                                context
                                    .read<OccurrenceGeneralInfoCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                          ],
                          CommonWidgets.verticalSpacerWidget(height * 0.02),

                          /// Power Failure
                          CommonWidgets.textDisplay(
                            state.labels?.locale.powerFailure ??
                                state.labels?.defaultLocale.powerFailure ??
                                Constants.powerFailure,
                            isMandatory: true,
                            Styles.textStyleWhite14,
                          ),
                          RadioButtonsYesNo(
                            status: state.model.status ?? 0,
                            selectedValue: state.model.powerFailure ? 1 : 0,
                            onChangedYes: !showSaveSubmitButtons ||
                                    (state.model.id == null &&
                                        state.isOnGoingPowerFailure!)
                                ? null
                                : (val) {
                                    state.model.powerFailure = true;
                                    BlocProvider.of<OccurrenceGeneralInfoCubit>(
                                      context,
                                    ).showFields(powerFailure: true);
                                  },
                            onChangedNo: !showSaveSubmitButtons ||
                                    (state.model.id == null &&
                                        state.isOnGoingPowerFailure!)
                                ? null
                                : (val) {
                                    state.model.powerFailure = false;
                                    BlocProvider.of<OccurrenceGeneralInfoCubit>(
                                      context,
                                    ).showFields(powerFailure: false);
                                  },
                          ),

                          if (state.model.powerFailure == true) ...[
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.csrParticipationDates ??
                              //     state.labels?.defaultLocale
                              //         .csrParticipationDates ??
                              Constants.powerFailuresDate,
                              Styles.textStyleWhite14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                            GestureDetector(
                              onTap: () {
                                if (!showSaveSubmitButtons) {
                                  return;
                                }

                                log('--state.model.powerFailures----');

                                if (!state.model.powerFailures.isEmptyOrNull &&
                                    state.model.powerFailures!.last
                                        .powerFailureEndDate.isEmptyOrNull) {
                                  // Display error message
                                  Validator().showToast(
                                    context,
                                    'Power failure is ongoing not possible to create new entry, unless the existing dates are updated.',
                                  );
                                  return;
                                }

                                showDialog(
                                  context: context,
                                  builder: (BuildContext dialogContext) {
                                    return AddDatePopUp(
                                      mainContext: context,
                                      onSubmit:
                                          (PowerFailureModel powerFailure) {
                                        // log('----powerFailure----${powerFailure.powerFailureStartDate}----');
                                        if (state.model.powerFailures
                                            .isEmptyOrNull) {
                                          state.model.powerFailures = [];
                                        }
                                        state.model.powerFailures?.add(
                                          powerFailure,
                                        );

                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
                                                context)
                                            .onCheckBoxChange(state.model);
                                      },
                                    );
                                  },
                                );
                              },
                              child: Row(
                                children: <Widget>[
                                  const SizedBox(width: 14),
                                  Icon(
                                    Icons.add_circle_outline_rounded,
                                    color: showSaveSubmitButtons
                                        ? AppColors.white
                                        : AppColors.white,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    Constants.addPowerFailuresDates,
                                    style: TextStyle(
                                      color: showSaveSubmitButtons
                                          ? AppColors.white
                                          : AppColors.white,
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),
                          AbsorbPointer(
                            absorbing: isReadOnly,
                            child: Column(
                              children: getPowerFailures(state, height),
                            ),
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.02),
                          ],
                          /// DG Working
                          // CommonWidgets.textDisplay(
                          //   state.labels?.locale.dgWrking ??
                          //       state.labels?.defaultLocale.dgWrking ??
                          //       Constants.dgWrking,
                          //   isMandatory: true,
                          //   Styles.textStyleWhite14,
                          // ),
                          // RadioButtonsYesNo(
                          //   status: state.model.status ?? 0,
                          //   selectedValue: state.model.dgWrking ? 1 : 0,
                          //   onChangedYes: !showSaveSubmitButtons
                          //       ? null
                          //       : (val) {
                          //           state.model.dgWrking = true;
                          //           BlocProvider.of<OccurrenceGeneralInfoCubit>(
                          //             context,
                          //           ).showFields(dgWrking: true);
                          //           //.onModelValueChange(state.guardingMasterData
                          //           //);
                          //         },
                          //   onChangedNo: !showSaveSubmitButtons
                          //       ? null
                          //       : (val) {
                          //           state.model.dgWrking = false;
                          //           BlocProvider.of<OccurrenceGeneralInfoCubit>(
                          //             context,
                          //           ).showFields(dgWrking: false);
                          //         },
                          // ),
                          // CommonWidgets.verticalSpacerWidget(height * 0.02),

                          ///ATM Vendor Visit
                          CommonWidgets.textDisplay(
                            state.labels?.locale.atmVendorVisit ??
                                state.labels?.defaultLocale.atmVendorVisit ??
                                Constants.aTMVendorVisit,
                            isMandatory: true,
                            Styles.textStyleWhite14,
                          ),
                          RadioButtonsYesNo(
                            status: state.model.status ?? 0,
                            selectedValue: state.model.atmVendorVisit ? 1 : 0,
                            onChangedYes: !showSaveSubmitButtons
                                ? null
                                : (val) {
                                    state.model.atmVendorVisit = true;
                                    BlocProvider.of<OccurrenceGeneralInfoCubit>(
                                      context,
                                    ).showFields(atmVendorVisit: true);
                                    //.onModelValueChange(state.guardingMasterData
                                    //);
                                  },
                            onChangedNo: !showSaveSubmitButtons
                                ? null
                                : (val) {
                                    state.model.atmVendorVisit = false;
                                    BlocProvider.of<OccurrenceGeneralInfoCubit>(
                                      context,
                                    ).showFields(atmVendorVisit: false);
                                  },
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.02),

                          ///CWM Visit
                          CommonWidgets.textDisplay(
                            state.labels?.locale.cwmVisit ??
                                state.labels?.defaultLocale.cwmVisit ??
                                Constants.cWMVisit,
                            isMandatory: true,
                            Styles.textStyleWhite14,
                          ),
                          RadioButtonsYesNo(
                            status: state.model.status ?? 0,
                            selectedValue: state.model.cwmVisit ? 1 : 0,
                            onChangedYes: !showSaveSubmitButtons
                                ? null
                                : (val) {
                                    state.model.cwmVisit = true;
                                    BlocProvider.of<OccurrenceGeneralInfoCubit>(
                                      context,
                                    ).showFields(cwmVisit: true);
                                    //.onModelValueChange(state.guardingMasterData
                                    //);
                                  },
                            onChangedNo: !showSaveSubmitButtons
                                ? null
                                : (val) {
                                    state.model.cwmVisit = false;
                                    BlocProvider.of<OccurrenceGeneralInfoCubit>(
                                      context,
                                    ).showFields(cwmVisit: false);
                                  },
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.02),

                          /// Follow up actions for next shift
                          CommonWidgets.textDisplay(
                            state.labels?.locale.followedUp ??
                                state.labels?.defaultLocale.followedUp ??
                                Constants.followUp,
                            isMandatory: true,
                            Styles.textStyleWhite14,
                          ),
                          FlutterInputField(
                            lineHeight: 6,
                            characterLimit:
                                Constants.characterLimitDescTextFormField,
                            initialValue: state.model.comments,
                            textFormKey: Keys.commentsKey,
                            hintText: Constants.informationhere,
                            showBorder: true,
                            isEnable: showSaveSubmitButtons,
                            isDisableColor: !showSaveSubmitButtons,
                            textInputAction: TextInputAction.newline,
                            textInputType: TextInputType.multiline,
                            onChange: (String value) {
                              state.model.comments = value;
                              context
                                  .read<OccurrenceGeneralInfoCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.02),

                          ///Followed Up
                          CommonWidgets.textDisplay(
                            state.labels?.locale.followedUp ??
                                state.labels?.defaultLocale.followedUp ??
                                Constants.followedUp,
                            isMandatory: true,
                            Styles.textStyleWhite14,
                          ),
                          RadioButtonsYesNo(
                            status: state.model.status ?? 0,
                            selectedValue: state.model.followedUp ? 1 : 0,
                            onChangedYes: !showSaveSubmitButtons
                                ? null
                                : (val) {
                                    state.model.followedUp = true;
                                    BlocProvider.of<OccurrenceGeneralInfoCubit>(
                                      context,
                                    ).showFields(followedUp: true);
                                    //.onModelValueChange(state.guardingMasterData
                                    //);
                                  },
                            onChangedNo: !showSaveSubmitButtons
                                ? null
                                : (val) {
                                    state.model.followedUp = false;
                                    BlocProvider.of<OccurrenceGeneralInfoCubit>(
                                      context,
                                    ).showFields(followedUp: false);
                                  },
                          ),

                          if (state.model.id != null) ...[
                            /// Modified Date
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.date ??
                              //     state.labels?.defaultLocale.date ??
                              Constants.modifiedOn,
                              Styles.textStyleWhite14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            datecreateWidgetdisplay(
                              state.model.modifiedDate ?? '',
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Modified By
                            CommonWidgets.horizontalTextHandling(
                              // state.labels?.locale.entrySecurity ??
                              //     state.labels?.defaultLocale.entrySecurity ??
                              Constants.modifiedBy,
                              isMandatory: true,
                              state.model.modifiedBy ?? '',
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// SubmitButton
            // if (state.model.status != 4) ...[
            //   Container(
            //     padding: const EdgeInsets.all(15.0),
            //     decoration: ShapeDecoration(
            //       color: AppColors.newColor3,
            //       shape: const RoundedRectangleBorder(
            //         borderRadius: BorderRadius.vertical(
            //           top: Radius.circular(00.0),
            //         ),
            //       ),
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         cancelButtonDisplay(),
            //         if (showSaveSubmitButtons) ...[submitButtonDisplay()],
            //       ],
            //     ),
            //   ),
            // ],
            if (state.model.status != 4) ...[
              ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.0), // 👈 allows bg to show
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        cancelButtonDisplay(),
                        if (showSaveSubmitButtons) ...[
                          submitButtonDisplay(),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ],

            CommonWidgets.verticalSpacerWidget(height * 0.04),
          ],
        ),
      ),
    ]);
  }

  // TODO: can be removed
  // openSecuritySystemSLATypePopUp({
  //   required OccurrenceGeneralInfoState state,
  //   required bool showListing,
  // }) {
  //   BaseDropDown().assetTypeDialog(
  //     context: context,
  //     dropDownValues: sstIncidentType.map((label) => label.key).toList(),
  //     pop: false,
  //     onTap: (String value) {
  //       Label? selectedLabel;
  //       selectedLabel = sstIncidentType.firstWhere(
  //         (label) => label.key == value,
  //         orElse: () => const Label(key: '', value: ''),
  //       );
  //
  //       log('--state.model.id----${state.model.id}---');
  //       if (showListing) {
  //         // Navigate to Listing Page
  //         Navigator.pushNamed(context, sstIncidentListRoute, arguments: {
  //           "isInternal":
  //               selectedLabel.value.equalsIgnoreCase('0') ? true : false,
  //           "occId": state.model.id.toString(), // TODO: Need to check
  //         });
  //         return;
  //       }
  //
  //       // Call navigateToCreateIncident here
  //       navigateToCreateIncident(
  //         state: state,
  //         occType: 1,
  //         isSSTIncident: true,
  //         isInternal: true,
  //       );
  //     },
  //   );
  // }

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

  Future<void> navigateToCreateIncident({
    required OccurrenceGeneralInfoState state,
    required int occType,
    required bool isSSTIncident,
    bool? isInternal,
  }) async {
    log('---navigateToCreateIncident--@@@-');
    if (isReadOnly) {
      return;
    }
    NavigatorState nav = Navigator.of(context);
    bool isSaveSuccess = await BlocProvider.of<OccurrenceGeneralInfoCubit>(
      context,
    ).submitForm(isSaveOnly: true, navigateToNextScreen: true);

    log('--state.status---navigateToCreateIncident----${state.status}-----');
    // For checking validations
    if (!isSaveSuccess) {
      return;
    }
    log('--state.model.id-----occId-------${state.model.id}-----');
    var map = {'occId': state.model.id.toString(), 'occType': occType};
    if (isInternal ?? true) {
      map.putIfAbsent('isInternal', () => isInternal ?? true);
    }
    log('---navigateToCreateIncident--isSSTIncident---$isSSTIncident-');
    map.putIfAbsent(ConstantsArgument.location, () => state.model.location!);

    nav.pushNamed(
      isSSTIncident ? sstIncidentDetailsRoute : incidentManagementDetailsRoute,
      arguments: map,
    );
    // Navigator.pushNamed(
    //   context,
    //   isSSTIncident ? sstIncidentDetailsRoute : incidentManagementDetailsRoute,
    //   arguments: map,
    // );
  }

  Widget showButtonDisplay({
    required String occId,
    required int occType,
    bool? isSSTIncident,
    bool? showPopUp,
    required OccurrenceGeneralInfoState state,
  }) {
    log('--occId-ogi--$occId--');
    return AbsorbPointer(
      absorbing: false,
      // child: PopButton(
      //   height: 50,
      //   width: 130,
      //   backgroundColor: Colors.white,
      //   key: const Key(Keys.showButton),
      //   buttonText: Constants.showList,
      //   buttonTextKey: Keys.showButton,
      //   onTap: () => {
      //     showPopUp ?? false
      //         ? Navigator.pushNamed(context, sstIncidentListRoute, arguments: {
      //             "isInternal": true,
      //             "occId": state.model.id.toString(),
      //           })
      //         : Navigator.pushNamed(
      //             context,
      //             incidentManagementsRoute,
      //             arguments: {
      //               'occId': occId,
      //               'occType': occType,
      //             },
      //           ),
      //   },
      // ),
      child: PopButton(
        width: 100,
        key: const Key(Keys.saveButton),
        buttonText: Constants.showList,
        boarderColor: AppColors.white,
        backgroundColor: const Color(0xFF071130),
        foregroundColor: Colors.white,
        textStyle: Styles.textStyleSemiBold16White,
        onTap: () => {
          showPopUp ?? false
              ? Navigator.pushNamed(
                  context,
                  sstIncidentListRoute,
                  arguments: {
                    "isInternal": true,
                    "occId": state.model.id.toString(),
                  },
                )
              : Navigator.pushNamed(
                  context,
                  incidentManagementsRoute,
                  arguments: {'occId': occId, 'occType': occType},
                ),
        },
      ),
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
        BlocProvider.of<OccurrenceGeneralInfoCubit>(
          context,
        ).submitForm(isSaveOnly: false);
      },
    );
  }

  Widget locationWidgetdislay({
    required bool enabled,
    Locations? locations,
    required String selectedLocation,
    Function? onTap,
  }) {
    return GestureDetector(
      onTap: () {
        if (enabled) {
          selectLocation(locations: locations, onTap: onTap);
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
        return CustomExpansionListTexts(locationList: locations, onTap: onTap);
      },
    );
  }

  List<Widget> getPowerFailures(OccurrenceGeneralInfoState state, height) {
    List<Widget> widgets = [];

    log('-view-model.powerFailures--${state.model.powerFailures?.length}-');
    for (PowerFailureModel powerFailure in state.model.powerFailures ?? []) {
      TextEditingController startDateController = TextEditingController();
      TextEditingController endDateController = TextEditingController();
      startDateController.text = powerFailure.powerFailureStartDate ?? '';
      endDateController.text = powerFailure.powerFailureEndDate ?? '';

      String? selectedStartDate;
      String? afterTwoDays;
      log(
        '--powerFailure.powerFailureStartDate-${powerFailure.powerFailureStartDate}--',
      );

      selectedStartDate = powerFailure.powerFailureStartDate;
      DateTime fromDate = DateTime.now();

      if (!selectedStartDate.isEmptyOrNull) {
        RegExp spaceOrSpecialCharRegExp = RegExp(r'[ \\\W]');
        // Check if the string contains spaces or special characters
        String timestamp = Utils().formatTime(selectedStartDate ?? '');
        int timestampInt = int.parse(
          spaceOrSpecialCharRegExp.hasMatch(selectedStartDate ?? '')
              ? timestamp
              : selectedStartDate ?? '',
        );
        fromDate = DateTime.fromMillisecondsSinceEpoch(timestampInt * 1000);
        DateTime newDateTime = fromDate.add(const Duration(days: 1));
        afterTwoDays = newDateTime.toString();
      }
      widgets.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  children: [
                    /// Start Date
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Start Date',style: Styles.textStyleWhite14,),
                          BaseDate().datePickerWidgetLoading(
                            textController: startDateController,
                            isDisabled: state.model.id == null &&
                                state.isOnGoingPowerFailure!,
                            onlyDate: false,
                            notFlagDate: true,
                            showFutureDate: false,
                            onChange: (String value) {
                              powerFailure.powerFailureStartDate =
                                  Utils.dateToTimestampConversion(
                                value,
                                Constants.fulldateFormat,
                              ).toString();
                              startDateController.text = value;
                              selectedStartDate = DateFormat(
                                'dd/MM/yyyy HH:mm:ss',
                              ).parse(value).toString();
                              DateTime parsedDate = DateFormat(
                                'dd/MM/yyyy HH:mm:ss',
                              ).parse(value);

                              // Add two days to the parsed date
                              DateTime newDate = parsedDate.add(
                                const Duration(days: 1),
                              );

                              // Format the new date back into the desired string format
                              afterTwoDays = newDate.toString();

                              setState(() {});
                            },
                            context: context,
                          ),
                        ],
                      ),
                    ),

                    /// End Date
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('End Date', style: Styles.textStyleWhite14),
                          BaseDate().datePickerWidgetLoading(
                            textController: endDateController,
                            onlyDate: false,
                            notFlagDate: true,
                            // startDate: selectedStartDate,
                            fromDate: fromDate.toString(),
                            toDate:
                                afterTwoDays.isEmptyOrNull ? '' : afterTwoDays,
                            showFutureDate: false,
                            // fromDate: powerFailure.powerFailureStartDate,
                            //toDate = startDate.add(Duration(days: 2));
                            showPastDate: false,
                            // startDate: startDateController.text,
                            onChange: (String value) {
                              powerFailure.powerFailureEndDate =
                                  Utils.dateToTimestampConversion(
                                value,
                                Constants.fulldateFormat,
                              ).toString();
                              // BlocProvider.of<GuardingMasterDataDetailsCubit>(context)
                              //     .onModelValueChange(state.model);
                            },
                            context: context,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    if (state.isOnGoingPowerFailure ?? false) {
                      return;
                    }
                    BlocProvider.of<OccurrenceGeneralInfoCubit>(
                      context,
                    ).deletePowerFailure(powerFailure);
                  },
                  icon: const Icon(Icons.close, size: 30),
                  color: AppColors.geryLightBackground,
                ),
              ],
            ),
          ],
        ),
      );
      widgets.add(CommonWidgets.verticalSpacerWidget(height * 0.01));
    }
    return widgets;
  }
}
