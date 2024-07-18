import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/occurrence/occurrences_details/general_info/views/add_power_failure_dates_pop_up.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User? userDetails;
  List<ImageContent>? getFiles;
  List<ImageContent>? getAttachments;
  TextEditingController statusController = TextEditingController();
  bool disableForm = true;
  bool showPowerFailureDates = false;
  bool isReadOnly = false;

  get guardingMasterData => null;

  get model => null;

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
              Navigator.popAndPushNamed(
                context,
                occurrenceRoute,
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
        if (state.model.status == ConstantsIntValue.submitted) {
          isReadOnly = state.isReadOnly ?? true;
        }
        if (widget.extraProperties != null &&
            !widget.extraProperties!.hasWritePermission!) {
          isReadOnly = true;
        }
        showSaveSubmitButtons = (state.model.status == 0 ||
                state.model.status == null ||
                !isReadOnly) &&
            state.model.lock.isEmptyOrNull;
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            //title: widget.title,
            showPopUp: false,
            showSaveButton: showSaveSubmitButtons,
            showSubmitButton: showSaveSubmitButtons,
            showDisLikeButton: false,
            showLikeButton: false,
            pdfAPIName:
                '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=${Constants.occurrenceModule}',
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<OccurrenceGeneralInfoCubit>(context)
                  .submitForm(isSaveOnly: true);
            },
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<OccurrenceGeneralInfoCubit>(context)
                  .submitForm(isSaveOnly: false);
            },
            title: widget.title,
          ),
          backgroundColor: AppColors.backgroundWhiteColor,
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

    return Container(
      color: AppColors.navigationSkyBlueColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 0.01,
              color: AppColors.navigationSkyBlueColor,
            ),
            Container(
              decoration: const ShapeDecoration(
                  color: AppColors.backgroundWhiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.0)),
                  )),
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
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
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
                                          orElse: () =>
                                              const Label(key: '', value: ''),
                                        );

                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
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

                              /// Shift Handover By
                              CommonWidgets.horizentaltextHandling(
                                  state.labels?.locale.entrySecurity ??
                                      state.labels?.defaultLocale
                                          .entrySecurity ??
                                      Constants.shiftHandoverBy,
                                  isMandatory: true,
                                  '${state.model.entrySecurity?.firstName ?? ''} ${state.model.entrySecurity?.lastName ?? ''}'),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Shift Taken Over by
                              CommonWidgets.textDisplay(
                                state.labels?.locale.handoverSecurity ??
                                    state.labels?.defaultLocale
                                        .handoverSecurity ??
                                    Constants.shiftTakenOverBy,
                                isMandatory: true,
                                Styles.textStyleBlack14,
                              ),
                              TextFieldAddButton(
                                  title:
                                      state.model.handoverSecurity?.userInfo ??
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
                                                  shiftTakenOverBy: user);
                                        },
                                        roleName: ConstantUserRoles
                                            .atomGuardingStaffUser,
                                        functionToCall: () {
                                          // refresh the list
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .refreshList();
                                        },
                                      );
                                    }
                                  }),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Location
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.location ??
                                      state.labels?.defaultLocale.location ??
                                      Constants.location,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              locationWidgetdislay(
                                  selectedLocation:
                                      state.model.location?.name ?? '',
                                  enabled: state.model.id == null ||
                                      (state.model.location?.name ?? '')
                                          .isEmpty,
                                  locations: state.locations,
                                  onTap: (Organisation? location) async {
                                    log('location?.name-----${location?.name}');

                                    state.model.location = location;

                                    BlocProvider.of<OccurrenceGeneralInfoCubit>(
                                            context)
                                        .updateDropdownValues(
                                            location: location);
                                  }),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Date of creation
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.inputDate ??
                                      state.labels?.defaultLocale.inputDate ??
                                      Constants.dateofcreation,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              BaseDate().creationDateDisplay(
                                  state.model.inputDate ?? ''),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Sl No.
                              CommonWidgets.horizentaltextHandling(
                                  state.labels?.locale.slNo ??
                                      state.labels?.defaultLocale.slNo ??
                                      Constants.slno,
                                  isMandatory: true,
                                  state.model.slNo ?? ''),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              ///Shift Briefing Attended
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.shiftBrfngAttnded ??
                                      state.labels?.defaultLocale
                                          .shiftBrfngAttnded ??
                                      Constants.shiftBriefingAttended,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
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
                                                  shiftBrfngAttnded: true);
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
                                                  shiftBrfngAttnded: false);
                                        }),

                              /// Premises Round Taken
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.premisesRoundTkn ??
                                      state.labels?.defaultLocale
                                          .premisesRoundTkn ??
                                      Constants.premisesRoundTaken,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              RadioButtonsYesNo(
                                  status: state.model.status ?? 0,
                                  selectedValue:
                                      state.model.premisesRoundTkn ? 1 : 0,
                                  onChangedYes: !showSaveSubmitButtons
                                      ? null
                                      : (val) {
                                          state.model.premisesRoundTkn = true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  premisesRoundTkn: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: !showSaveSubmitButtons
                                      ? null
                                      : (val) {
                                          state.model.premisesRoundTkn = false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  premisesRoundTkn: false);
                                        }),

                              if (state.model.premisesRoundTkn == true) ...[
                                /// Premises Round Taken Comments
                                FlutterInputField(
                                  lineHeight: 6,
                                  initialValue:
                                      state.model.premisesRoundTknComments,
                                  textFormKey: Keys.premisesRoundTknCommentsKey,
                                  hintText: Constants.informationhere,
                                  showBorder: true,
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
                                    height * 0.01),
                              ],

                              ///Medical Emergency
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.medicalEmrgncy ??
                                      state.labels?.defaultLocale
                                          .medicalEmrgncy ??
                                      Constants.medicalEmergency,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              RadioButtonsYesNo(
                                  status: state.model.status ?? 0,
                                  selectedValue:
                                      state.model.medicalEmrgncy ? 1 : 0,
                                  onChangedYes: !showSaveSubmitButtons
                                      ? null
                                      : (val) {
                                          state.model.medicalEmrgncy = true;
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
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  medicalEmrgncy: false);
                                        }),
                              if (state.model.medicalEmrgncy == true) ...[
                                /// Medical Emergency Comments
                                FlutterInputField(
                                  lineHeight: 6,
                                  initialValue:
                                      state.model.medicalEmrgncyComments,
                                  showBorder: true,
                                  textFormKey: Keys.emergencyCommentsKey,
                                  hintText: Constants.informationhere,
                                  isEnable: showSaveSubmitButtons,
                                  isDisableColor: !showSaveSubmitButtons,
                                  onChange: (String value) {
                                    state.model.medicalEmrgncyComments = value;
                                    context
                                        .read<OccurrenceGeneralInfoCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                              ],

                              ///Material Movement
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.materialMovement ??
                                      state.labels?.defaultLocale
                                          .materialMovement ??
                                      Constants.materialMovement,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
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
                                              .showFields(
                                                  materialMovement: true);
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
                                                  materialMovement: false);
                                        }),

                              /// LEO Visit
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.leoVisit ??
                                      state.labels?.defaultLocale.leoVisit ??
                                      Constants.lEOVisit,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
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
                                        }),

                              /// Social Engineering Incidents
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.socialEnggIncdnt ??
                                      state.labels?.defaultLocale
                                          .socialEnggIncdnt ??
                                      Constants.socialEngineeringIncidents,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              RadioButtonsYesNo(
                                  status: state.model.status ?? 0,
                                  selectedValue:
                                      state.model.socialEnggIncdnt ? 1 : 0,
                                  onChangedYes: !showSaveSubmitButtons
                                      ? null
                                      : (val) {
                                          state.model.socialEnggIncdnt = true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  socialEnggIncdnt: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: !showSaveSubmitButtons
                                      ? null
                                      : (val) {
                                          state.model.socialEnggIncdnt = false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  socialEnggIncdnt: false);
                                        }),

                              if (state.model.socialEnggIncdnt == true) ...[
                                /// Medical Emergency Comments
                                FlutterInputField(
                                  lineHeight: 6,
                                  initialValue:
                                      state.model.socialEnggIncdntComments,
                                  showBorder: true,
                                  textFormKey: Keys.socialEnggIncdntCommentsKey,
                                  hintText: Constants.informationhere,
                                  isEnable: showSaveSubmitButtons,
                                  isDisableColor: !showSaveSubmitButtons,
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
                                    height * 0.01),
                              ],

                              /// Found Article Transaction
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.foundArticleTrnsctn ??
                                      state.labels?.defaultLocale
                                          .foundArticleTrnsctn ??
                                      Constants.foundArticleTransaction,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              RadioButtonsYesNo(
                                  status: state.model.status ?? 0,
                                  selectedValue:
                                      state.model.foundArticleTrnsctn ? 1 : 0,
                                  onChangedYes: !showSaveSubmitButtons
                                      ? null
                                      : (val) {
                                          state.model.foundArticleTrnsctn =
                                              true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  foundArticleTrnsctn: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: !showSaveSubmitButtons
                                      ? null
                                      : (val) {
                                          state.model.foundArticleTrnsctn =
                                              false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  foundArticleTrnsctn: false);
                                        }),

                              /// Process Breach Incident
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.processBreachIncdnt ??
                                      state.labels?.defaultLocale
                                          .processBreachIncdnt ??
                                      Constants.processBreachIncident,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
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
                                                processBreachIncdnt: true);
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
                                                processBreachIncdnt: false);
                                        // .onModelValueChange(state.guardingMasterData
                                        //  );
                                      },
                              ),
                            ],
                          ),

                          if (state.model.processBreachIncdnt == true) ...[
                            CommonWidgets.textDisplay(
                                Constants.incidentItemList,
                                Styles.textStyleBlack14),
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
                                        color: AppColors.navigationSkyBlueColor,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    // if (state.model.incidentItems != null &&
                                    //     !state.model.incidentItems!.where(
                                    //         (element) =>
                                    //             element.incidentType ==
                                    //             1).isEmptyOrNull) ...[
                                    CommonWidgets.horizontalSpacerWidget(
                                        height * 0.01),
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
                              /// Any Infrastructural Issue
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.infraIssue ??
                                      state.labels?.defaultLocale.infraIssue ??
                                      Constants.anyInfrastructuralIssue,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              RadioButtonsYesNo(
                                  status: state.model.status ?? 0,
                                  selectedValue: state.model.infraIssue ? 1 : 0,
                                  onChangedYes: !showSaveSubmitButtons
                                      ? null
                                      : (val) {
                                          state.model.infraIssue = true;
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
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(infraIssue: false);
                                        }),

                              if (state.model.infraIssue == true) ...[
                                /// Any Infrastructural Issue Comments
                                FlutterInputField(
                                  lineHeight: 6,
                                  initialValue: state.model.infraIssueComments,
                                  textFormKey: Keys.infraIssueCommentsKey,
                                  showBorder: true,
                                  hintText: Constants.informationhere,
                                  isEnable: showSaveSubmitButtons,
                                  isDisableColor: !showSaveSubmitButtons,
                                  onChange: (String value) {
                                    state.model.infraIssueComments = value;
                                    context
                                        .read<OccurrenceGeneralInfoCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                              ],

                              /// Any Suspicious Activity
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.suspiciousActivity ??
                                      state.labels?.defaultLocale
                                          .suspiciousActivity ??
                                      Constants.anySuspiciousActivity,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
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
                                                suspiciousActivity: true);
                                      },
                                onChangedNo: !showSaveSubmitButtons
                                    ? null
                                    : (val) {
                                        state.model.suspiciousActivity = false;
                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
                                                context)
                                            .showFields(
                                                suspiciousActivity: false);
                                      },
                              ),
                            ],
                          ),

                          if (state.model.suspiciousActivity == true) ...[
                            CommonWidgets.textDisplay(
                                Constants.incidentItemList,
                                Styles.textStyleBlack14),
                            GestureDetector(
                              onTap: () => navigateToCreateIncident(
                                state: state,
                                occType: 2,
                                isSSTIncident: false,
                              ),
                              child: Row(
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
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      'Add Incident Item List',
                                      style: TextStyle(
                                        color: AppColors.navigationSkyBlueColor,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    // if (state.model.incidentItems != null &&
                                    //     state.model.incidentItems!
                                    //         .isNotEmpty) ...[
                                    CommonWidgets.horizontalSpacerWidget(
                                        height * 0.01),
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

                          Column(
                            children: [
                              /// Fire Alarm Emergency Occurred
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.fireAlarmEmrgncy ??
                                      state.labels?.defaultLocale
                                          .fireAlarmEmrgncy ??
                                      Constants.fireAlarmEmergencyOccurred,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              RadioButtonsYesNo(
                                  status: state.model.status ?? 0,
                                  selectedValue:
                                      state.model.fireAlarmEmrgncy ? 1 : 0,
                                  onChangedYes: !showSaveSubmitButtons
                                      ? null
                                      : (val) {
                                          state.model.fireAlarmEmrgncy = true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  fireAlarmEmrgncy: true);
                                        },
                                  onChangedNo: !showSaveSubmitButtons
                                      ? null
                                      : (val) {
                                          state.model.fireAlarmEmrgncy = false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  fireAlarmEmrgncy: false);
                                        }),

                              if (state.model.fireAlarmEmrgncy == true) ...[
                                /// fire Alarm Emrgncy comments
                                FlutterInputField(
                                  lineHeight: 6,
                                  initialValue:
                                      state.model.fireAlarmEmrgncyComments,
                                  showBorder: true,
                                  textFormKey: Keys.fireAlarmEmrgncyCommentsKey,
                                  hintText: Constants.informationhere,
                                  isEnable: showSaveSubmitButtons,
                                  isDisableColor: !showSaveSubmitButtons,
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
                                    height * 0.01),
                              ],

                              /// Landlord Issue
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.landlordIssue ??
                                      state.labels?.defaultLocale
                                          .landlordIssue ??
                                      Constants.landlordIssue,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              RadioButtonsYesNo(
                                  status: state.model.status ?? 0,
                                  selectedValue:
                                      state.model.landlordIssue ? 1 : 0,
                                  onChangedYes: !showSaveSubmitButtons
                                      ? null
                                      : (val) {
                                          state.model.landlordIssue = true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(landlordIssue: true);
                                        },
                                  onChangedNo: !showSaveSubmitButtons
                                      ? null
                                      : (val) {
                                          state.model.landlordIssue = false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(landlordIssue: false);
                                        }),

                              if (state.model.landlordIssue == true) ...[
                                /// fire Alarm Emrgncy comments
                                FlutterInputField(
                                  lineHeight: 6,
                                  initialValue:
                                      state.model.landlordIssueComments,
                                  showBorder: true,
                                  textFormKey: Keys.landlordIssueCommentsKey,
                                  hintText: Constants.informationhere,
                                  isEnable: showSaveSubmitButtons,
                                  isDisableColor: !showSaveSubmitButtons,
                                  onChange: (String value) {
                                    state.model.landlordIssueComments = value;
                                    context
                                        .read<OccurrenceGeneralInfoCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                              ],

                              ///Security System Failure Incidents
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.secSysFailureIncdnt ??
                                      state.labels?.defaultLocale
                                          .secSysFailureIncdnt ??
                                      Constants.securitySystemFailureIncidents,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
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
                                                secSysFailureIncdnt: true);
                                      },
                                onChangedNo: !showSaveSubmitButtons
                                    ? null
                                    : (val) {
                                        state.model.secSysFailureIncdnt = false;
                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
                                                context)
                                            .showFields(
                                                secSysFailureIncdnt: false);
                                      },
                              ),
                            ],
                          ),
                          if (state.model.secSysFailureIncdnt == true) ...[
                            CommonWidgets.textDisplay(
                                Constants.securitySystemSLAList,
                                Styles.textStyleBlack14),
                            GestureDetector(
                              onTap: () {
                                if (isReadOnly) {
                                  return;
                                }
                                openSecuritySystemSLATypePopUp(
                                    state: state, showListing: false);
                              },
                              child: Row(
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
                                      'Add Security System SLA List',
                                      style: TextStyle(
                                        color: AppColors.navigationSkyBlueColor,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                  if (state.model.secSysFailureIncident !=
                                      null) ...[
                                    CommonWidgets.horizontalSpacerWidget(
                                        height * 0.01),
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

                          ///Any System Alarm Received
                          CommonWidgets.textDisplay(
                              state.labels?.locale.sysAlarmRcvd ??
                                  state.labels?.defaultLocale.sysAlarmRcvd ??
                                  Constants.anySystemAlarmReceived,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          RadioButtonsYesNo(
                              status: state.model.status ?? 0,
                              selectedValue: state.model.sysAlarmRcvd ? 1 : 0,
                              onChangedYes: !showSaveSubmitButtons
                                  ? null
                                  : (val) {
                                      state.model.sysAlarmRcvd = true;
                                      BlocProvider.of<
                                                  OccurrenceGeneralInfoCubit>(
                                              context)
                                          .showFields(sysAlarmRcvd: true);
                                    },
                              onChangedNo: !showSaveSubmitButtons
                                  ? null
                                  : (val) {
                                      state.model.sysAlarmRcvd = false;
                                      BlocProvider.of<
                                                  OccurrenceGeneralInfoCubit>(
                                              context)
                                          .showFields(sysAlarmRcvd: false);
                                    }),

                          if (state.model.sysAlarmRcvd == true) ...[
                            /// Any system alarm received Comments
                            FlutterInputField(
                              lineHeight: 6,
                              initialValue: state.model.sysAlarmRcvdComments,
                              textFormKey: Keys.sysAlarmRcvdCommentsKey,
                              showBorder: true,
                              hintText: Constants.informationhere,
                              isEnable: showSaveSubmitButtons,
                              isDisableColor: !showSaveSubmitButtons,
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

                          ///Transport Incident
                          CommonWidgets.textDisplay(
                              state.labels?.locale.transportIncdnt ??
                                  state.labels?.defaultLocale.transportIncdnt ??
                                  Constants.transportIncident,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          RadioButtonsYesNo(
                            status: state.model.status ?? 0,
                            selectedValue: state.model.transportIncdnt ? 1 : 0,
                            onChangedYes: !showSaveSubmitButtons
                                ? null
                                : (val) {
                                    state.model.transportIncdnt = true;
                                    BlocProvider.of<OccurrenceGeneralInfoCubit>(
                                            context)
                                        .showFields(transportIncdnt: true);
                                  },
                            onChangedNo: !showSaveSubmitButtons
                                ? null
                                : (val) {
                                    state.model.transportIncdnt = false;
                                    BlocProvider.of<OccurrenceGeneralInfoCubit>(
                                            context)
                                        .showFields(transportIncdnt: false);
                                  },
                          ),

                          if (state.model.transportIncdnt == true) ...[
                            /// Transport incident  Comments
                            FlutterInputField(
                              lineHeight: 6,
                              initialValue: state.model.transportIncdntComments,
                              textFormKey: Keys.transportIncdntCommentsKey,
                              hintText: Constants.informationhere,
                              showBorder: true,
                              isEnable: showSaveSubmitButtons,
                              isDisableColor: !showSaveSubmitButtons,
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

                          /// Any Event
                          CommonWidgets.textDisplay(
                              state.labels?.locale.anyEvent ??
                                  state.labels?.defaultLocale.anyEvent ??
                                  Constants.anyEvent,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          RadioButtonsYesNo(
                            status: state.model.status ?? 0,
                            selectedValue: state.model.anyEvent ? 1 : 0,
                            onChangedYes: !showSaveSubmitButtons
                                ? null
                                : (val) {
                                    state.model.anyEvent = true;
                                    BlocProvider.of<OccurrenceGeneralInfoCubit>(
                                            context)
                                        .showFields(anyEvent: true);
                                    //.onModelValueChange(state.guardingMasterData
                                    //);
                                  },
                            onChangedNo: !showSaveSubmitButtons
                                ? null
                                : (val) {
                                    state.model.anyEvent = false;
                                    BlocProvider.of<OccurrenceGeneralInfoCubit>(
                                            context)
                                        .showFields(anyEvent: false);
                                  },
                          ),

                          if (state.model.anyEvent == true) ...[
                            /// Notifi SCRI
                            CommonWidgets.textDisplay(
                                state.labels?.locale.notifyScri ??
                                    state.labels?.defaultLocale.notifyScri ??
                                    Constants.notifySCRI,
                                Styles.textStyleBlack14),
                            FlutterInputField(
                              lineHeight: 6,
                              initialValue: state.model.notifyScri,
                              textFormKey: Keys.notifyScriKey,
                              hintText: Constants.informationhere,
                              isEnable: showSaveSubmitButtons,
                              showBorder: true,
                              isDisableColor: !showSaveSubmitButtons,
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

                          /// Power Failure
                          CommonWidgets.textDisplay(
                              state.labels?.locale.powerFailure ??
                                  state.labels?.defaultLocale.powerFailure ??
                                  Constants.powerFailure,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          RadioButtonsYesNo(
                              status: state.model.status ?? 0,
                              selectedValue: state.model.powerFailure ? 1 : 0,
                              onChangedYes: !showSaveSubmitButtons ||
                                      (state.model.id == null &&
                                          state.isOnGoingPowerFailure!)
                                  ? null
                                  : (val) {
                                      state.model.powerFailure = true;
                                      BlocProvider.of<
                                                  OccurrenceGeneralInfoCubit>(
                                              context)
                                          .showFields(powerFailure: true);
                                    },
                              onChangedNo: !showSaveSubmitButtons ||
                                      (state.model.id == null &&
                                          state.isOnGoingPowerFailure!)
                                  ? null
                                  : (val) {
                                      state.model.powerFailure = false;
                                      BlocProvider.of<
                                                  OccurrenceGeneralInfoCubit>(
                                              context)
                                          .showFields(powerFailure: false);
                                    }),

                          if (state.model.powerFailure == true) ...[
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.csrParticipationDates ??
                                //     state.labels?.defaultLocale
                                //         .csrParticipationDates ??
                                Constants.powerFailuresDate,
                                Styles.textStyleBlack14),
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
                                        state.model.powerFailures
                                            ?.add(powerFailure);

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
                                        ? AppColors.navigationSkyBlueColor
                                        : AppColors.boldGreyBackground,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    Constants.addPowerFailuresDates,
                                    style: TextStyle(
                                      color: showSaveSubmitButtons
                                          ? AppColors.navigationSkyBlueColor
                                          : AppColors.boldGreyBackground,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          CommonWidgets.verticalSpacerWidget(height * 0.01),
                          AbsorbPointer(
                            absorbing: isReadOnly,
                            child: Column(
                              children: getPowerFailures(state, height),
                            ),
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// DG Working
                          CommonWidgets.textDisplay(
                              state.labels?.locale.dgWrking ??
                                  state.labels?.defaultLocale.dgWrking ??
                                  Constants.dgWrking,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          RadioButtonsYesNo(
                              status: state.model.status ?? 0,
                              selectedValue: state.model.dgWrking ? 1 : 0,
                              onChangedYes: !showSaveSubmitButtons
                                  ? null
                                  : (val) {
                                      state.model.dgWrking = true;
                                      BlocProvider.of<
                                                  OccurrenceGeneralInfoCubit>(
                                              context)
                                          .showFields(dgWrking: true);
                                      //.onModelValueChange(state.guardingMasterData
                                      //);
                                    },
                              onChangedNo: !showSaveSubmitButtons
                                  ? null
                                  : (val) {
                                      state.model.dgWrking = false;
                                      BlocProvider.of<
                                                  OccurrenceGeneralInfoCubit>(
                                              context)
                                          .showFields(dgWrking: false);
                                    }),

                          ///ATM Vendor Visit
                          CommonWidgets.textDisplay(
                              state.labels?.locale.atmVendorVisit ??
                                  state.labels?.defaultLocale.atmVendorVisit ??
                                  Constants.aTMVendorVisit,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          RadioButtonsYesNo(
                              status: state.model.status ?? 0,
                              selectedValue: state.model.atmVendorVisit ? 1 : 0,
                              onChangedYes: !showSaveSubmitButtons
                                  ? null
                                  : (val) {
                                      state.model.atmVendorVisit = true;
                                      BlocProvider.of<
                                                  OccurrenceGeneralInfoCubit>(
                                              context)
                                          .showFields(atmVendorVisit: true);
                                      //.onModelValueChange(state.guardingMasterData
                                      //);
                                    },
                              onChangedNo: !showSaveSubmitButtons
                                  ? null
                                  : (val) {
                                      state.model.atmVendorVisit = false;
                                      BlocProvider.of<
                                                  OccurrenceGeneralInfoCubit>(
                                              context)
                                          .showFields(atmVendorVisit: false);
                                    }),

                          ///CWM Visit
                          CommonWidgets.textDisplay(
                              state.labels?.locale.cwmVisit ??
                                  state.labels?.defaultLocale.cwmVisit ??
                                  Constants.cWMVisit,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          RadioButtonsYesNo(
                              status: state.model.status ?? 0,
                              selectedValue: state.model.cwmVisit ? 1 : 0,
                              onChangedYes: !showSaveSubmitButtons
                                  ? null
                                  : (val) {
                                      state.model.cwmVisit = true;
                                      BlocProvider.of<
                                                  OccurrenceGeneralInfoCubit>(
                                              context)
                                          .showFields(cwmVisit: true);
                                      //.onModelValueChange(state.guardingMasterData
                                      //);
                                    },
                              onChangedNo: !showSaveSubmitButtons
                                  ? null
                                  : (val) {
                                      state.model.cwmVisit = false;
                                      BlocProvider.of<
                                                  OccurrenceGeneralInfoCubit>(
                                              context)
                                          .showFields(cwmVisit: false);
                                    }),

                          /// Follow up actions for next shift
                          CommonWidgets.textDisplay(
                              state.labels?.locale.followedUp ??
                                  state.labels?.defaultLocale.followedUp ??
                                  Constants.followUp,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          FlutterInputField(
                            lineHeight: 6,
                            initialValue: state.model.comments,
                            textFormKey: Keys.commentsKey,
                            hintText: Constants.informationhere,
                            showBorder: true,
                            isEnable: showSaveSubmitButtons,
                            isDisableColor: !showSaveSubmitButtons,
                            onChange: (String value) {
                              state.model.comments = value;
                              context
                                  .read<OccurrenceGeneralInfoCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Followed Up
                          CommonWidgets.textDisplay(
                              state.labels?.locale.followedUp ??
                                  state.labels?.defaultLocale.followedUp ??
                                  Constants.followedUp,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          RadioButtonsYesNo(
                              status: state.model.status ?? 0,
                              selectedValue: state.model.followedUp ? 1 : 0,
                              onChangedYes: !showSaveSubmitButtons
                                  ? null
                                  : (val) {
                                      state.model.followedUp = true;
                                      BlocProvider.of<
                                                  OccurrenceGeneralInfoCubit>(
                                              context)
                                          .showFields(followedUp: true);
                                      //.onModelValueChange(state.guardingMasterData
                                      //);
                                    },
                              onChangedNo: !showSaveSubmitButtons
                                  ? null
                                  : (val) {
                                      state.model.followedUp = false;
                                      BlocProvider.of<
                                                  OccurrenceGeneralInfoCubit>(
                                              context)
                                          .showFields(followedUp: false);
                                    }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// SubmitButton
            if (state.model.status != 4) ...[
              Container(
                padding: const EdgeInsets.all(15.0),
                decoration: const ShapeDecoration(
                  color: AppColors.backgroundWhiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(00.0)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    cancelButtonDisplay(state),
                    if (showSaveSubmitButtons) ...[submitButtonDisplay()]
                  ],
                ),
              ),
            ],
            CommonWidgets.verticalSpacerWidget(height * 0.04),
          ],
        ),
      ),
    );
  }

  openSecuritySystemSLATypePopUp({
    required OccurrenceGeneralInfoState state,
    required bool showListing,
  }) {
    BaseDropDown().assetTypeDialog(
      context: context,
      dropDownValues: sstIncidentType.map((label) => label.key).toList(),
      pop: false,
      onTap: (String value) {
        Label? selectedLabel;
        selectedLabel = sstIncidentType.firstWhere(
          (label) => label.key == value,
          orElse: () => const Label(key: '', value: ''),
        );

        log('--state.model.id----${state.model.id}---');
        if (showListing) {
          // Navigate to Listing Page
          Navigator.pushNamed(context, sstIncidentListRoute, arguments: {
            "isInternal":
                selectedLabel.value.equalsIgnoreCase('0') ? true : false,
            "occId": state.model.id.toString(), // TODO: Need to check
          });
          return;
        }

        // Call navigateToCreateIncident here
        navigateToCreateIncident(
          state: state,
          occType: 1,
          isSSTIncident: true,
          isInternal: selectedLabel.value == '0' ? true : false,
        );
      },
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

  Widget cancelButtonDisplay(OccurrenceGeneralInfoState state) {
    bool condition = state.model.id == null ||
        state.model.status == ConstantsIntValue.cancelledStatus ||
        state.model.status == 1 ||
        !state.model.lock.isEmptyOrNull;
    return AppButton(
      width: Constants.cancelButtonWidth,
      backgroundColor: Colors.white,
      key: const Key(Keys.cancelButton),
      buttonText: condition ? Constants.close : Constants.cancelRecord,
      buttonTextKey: Keys.cancelButton,
      onTap: () {
        if (condition) {
          Navigator.pop(context);
          return;
        }
        var dialog = CustomAlertDialog(
            title: Constants.cancelRecord,
            message: Constants.cancelRecordWarningMessage,
            onPositivePressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              updateRecordStatus(state);
            },
            positiveBtnText: Constants.yes,
            negativeBtnText: Constants.no);
        showDialog(context: context, builder: (BuildContext context) => dialog);
      },
    );
  }

  void updateRecordStatus(OccurrenceGeneralInfoState state) {
    if (state.model.id != null) {
      BlocProvider.of<OccurrenceGeneralInfoCubit>(context)
          .updateStatus(id: state.model.id.toString());
      Navigator.popAndPushNamed(
        context,
        occurrenceRoute,
      );
    } else {
      Navigator.pop(context);
    }
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
    bool isSaveSuccess =
        await BlocProvider.of<OccurrenceGeneralInfoCubit>(context).submitForm(
      isSaveOnly: true,
      navigateToNextScreen: true,
    );

    log('--state.status---navigateToCreateIncident----${state.status}-----');
    // For checking validations
    if (!isSaveSuccess) {
      return;
    }
    log('--state.model.id-----occId-------${state.model.id}-----');
    var map = {
      'occId': state.model.id.toString(),
      'occType': occType,
    };
    if (isInternal ?? false) {
      map.putIfAbsent('isInternal', () => isInternal ?? false);
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
                  arguments: {
                    'occId': occId,
                    'occType': occType,
                  },
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
        BlocProvider.of<OccurrenceGeneralInfoCubit>(context)
            .submitForm(isSaveOnly: false);
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

  List<Widget> getPowerFailures(OccurrenceGeneralInfoState state, height) {
    List<Widget> widgets = [];

    log('-view-model.powerFailures--${state.model.powerFailures?.length}-');
    for (PowerFailureModel powerFailure in state.model.powerFailures ?? []) {
      TextEditingController startDateController = TextEditingController();
      TextEditingController endDateController = TextEditingController();
      startDateController.text = powerFailure.powerFailureStartDate ?? '';
      endDateController.text = powerFailure.powerFailureEndDate ?? '';
      widgets.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Start Date'),
                          BaseDate().datePickerWidgetLoading(
                            textController: startDateController,
                            isDisabled: state.model.id == null &&
                                state.isOnGoingPowerFailure!,
                            onlyDate: false,
                            showFutureDate: false,
                            onChange: (String value) {
                              powerFailure.powerFailureStartDate =
                                  Utils.dateToTimestampConversion(
                                          value, Constants.fulldateFormat)
                                      .toString();
                            },
                            context: context,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('End Date'),
                          BaseDate().datePickerWidgetLoading(
                            textController: endDateController,
                            onlyDate: false,
                            onChange: (String value) {
                              powerFailure.powerFailureEndDate =
                                  Utils.dateToTimestampConversion(
                                          value, Constants.fulldateFormat)
                                      .toString();
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
                    if(state.isOnGoingPowerFailure??false) {
                      return;
                    }
                    BlocProvider.of<OccurrenceGeneralInfoCubit>(context)
                        .deletePowerFailure(powerFailure);
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 30,
                  ),
                  color: AppColors.geryLightBackground,
                )
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
