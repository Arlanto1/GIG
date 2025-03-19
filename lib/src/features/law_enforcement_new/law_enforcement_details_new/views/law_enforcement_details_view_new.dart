import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/law_enforcement_new/models/law_enforcement_model_new.dart';

import '../cubits/law_enforcement_details_cubit_new.dart';

class LawEnforcementDetailsView extends StatefulWidget {
  final LawEnforcementModelNew? model;
  final String title;
  final bool viaAttendance;
  final ExtraProperties? extraProperties;

  const LawEnforcementDetailsView({
    super.key,
    this.model,
    required this.title,
    required this.viaAttendance,
    this.extraProperties,
  });

  @override
  State<LawEnforcementDetailsView> createState() =>
      _LawEnforcementDetailsViewState();
}

class _LawEnforcementDetailsViewState extends State<LawEnforcementDetailsView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User? userDetails;
  TextEditingController statusController = TextEditingController();
  TextEditingController timeOfVisitController = TextEditingController();
  TextEditingController dbOfficialWantToMeetController = TextEditingController();




  bool isReadOnly = false;

  get model => null;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<LawEnforcementDetailsCubit>(context)
        .initializeValues();
    // initializeDates(state);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return BlocConsumer<LawEnforcementDetailsCubit,
        LawEnforcementDetailsState>(
      listener: (context, state) {
        log('-state.status---${state.status}----');
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);
        if (state.status == FormStatus.popOnly && state.status != FormStatus.navigateToNextScreen) {
          log('000${state.status == FormStatus.popOnly }');
          var dialog = CustomAlertDialog(
            title: 'Law Enforcement',
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              Navigator.pop(context);
              // Navigator.pop(context);
              // return;
            },
          );
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => dialog);

        }
        if (state.status == FormStatus.success && state.model.id != null) {
          log('100${state.status == FormStatus.success && widget.viaAttendance}');
          var dialog = CustomAlertDialog(
            title: 'Law Enforcement',
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              return;
            },
          );
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => dialog);
        }
      },
      builder: (context, state) {
        dbOfficialWantToMeetController.text = state.model.dbOfficialEmail??'';

        if (state.model.status == 2 || !state.model.lock.isEmptyOrNull) {
          isReadOnly = true;
        }
        if (state.model.status == -1 || !state.model.lock.isEmptyOrNull) {
          isReadOnly = true;
        }
        if (state.model.status == null) {
          isReadOnly = false;
        }
        // if (widget.extraProperties != null &&
        //     !widget.extraProperties!.hasWritePermission!) {
        //   isReadOnly = true;
        // }

        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.title,
            showPopUp: false,
            pdfAPIName:
            '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=${Constants.leoModuleCode}',
            showSaveButton: state.model.status != 2 &&
                state.model.status != -1 &&
                !isReadOnly && state.status != FormStatus.loading
                ? true
                : false,
            showSubmitButton: state.model.status != 2 &&
                state.model.status != -1 &&
                !isReadOnly && state.status != FormStatus.loading
                ? true
                : false,
            showDisLikeButton: false,
            showLikeButton: false,
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<LawEnforcementDetailsCubit>(context)
                  .submitForm(
                isSaveOnly: true,
                navigateToNextScreen: false,
              );
            },
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<LawEnforcementDetailsCubit>(context)
                  .submitForm(
                isSaveOnly: false,
                navigateToNextScreen: false,
              );
            },
          ),
          backgroundColor: AppColors.backgroundWhiteColor,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void initializeDates(LawEnforcementDetailsState state) {
    timeOfVisitController.text =
    state.model.timeOfVisit != null ? Utils.timestampToDateConversion(
        int.tryParse(state.model.timeOfVisit ?? '') ??
            DateTime
                .now()
                .millisecondsSinceEpoch, // Use current timestamp if null
        Constants.dateFormat) : '';  }

  getBodybuilder(LawEnforcementDetailsState state, height) {
    initializeDates(state);
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }

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
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  AbsorbPointer(
                    absorbing: isReadOnly,
                    child: Form(
                      key: _formKey,
                      autovalidateMode: isReadOnly
                          ? AutovalidateMode.disabled
                          : AutovalidateMode.onUserInteraction,
                      child: Padding(
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

                            // General Information Fields
                            ///Created By
                            CommonWidgets.verticalTextHandling(
                              state.labels?.locale.entrySecurity ??
                                  state.labels?.defaultLocale.entrySecurity ??
                                  Constants.createdby,
                              '${state.model.entrySecurity?.firstName ?? ''} ${state.model.entrySecurity?.lastName ?? ''}',
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Status
                            CommonWidgets.textDisplay(
                              state.labels?.locale.status ??
                                  state.labels?.defaultLocale.status ??
                                  Constants.status,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              isEnable: false,
                              isDisableColor: true,
                              textFormKey: Keys.statusTextController,
                              hintText: '',
                              initialValue: Utils().buildSLAViolationStatus(
                                  state.model.status ?? 0,
                                  returnTextOnly: true),
                              onChange: (String value) {},
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Date of Creation
                            CommonWidgets.textDisplay(
                              state.labels?.locale.inputDate ??
                                  state.labels?.defaultLocale.inputDate ??
                                  Constants.dateofcreation,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            dateCreateWidgetDisplay(
                                state.model.inputDate ?? ''),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Location
                            CommonWidgets.textDisplay(
                              state.labels?.locale.location ??
                                  state.labels?.defaultLocale.location ??
                                  Constants.location,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseLocationDropdown().locationWidgetDisplay(
                                context: context,
                                isEnabled: !widget.viaAttendance,
                                locations: state.locations ?? Locations(),
                                selectedLocationName:
                                state.model.location?.name ?? '',
                                onTap: (Organisation? location) {
                                  BlocProvider.of<
                                      LawEnforcementDetailsCubit>(
                                      context)
                                      .updateLocationDropdownValue(
                                      location: location);
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Sl no
                            CommonWidgets.horizentaltextHandling(
                              state.labels?.locale.slNo ??
                                  state.labels?.defaultLocale.slNo ??
                                  Constants.slno,
                              state.model.slNo ?? '',
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Vendor
                            CommonWidgets.textDisplay(
                              state.labels?.locale.vendor ??
                                  state.labels?.defaultLocale.vendor ??
                                  Constants.vendor,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            // BaseEntitiesSelection().entityDropDownSelection(
                            //   context: context,
                            //   // selectedValues: state.model.vendor ?? [],
                            //   all: state.vendors,
                            //   enabled: !widget.viaAttendance && !isReadOnly && state.model.attdShiftInfoId ==null,
                            //   onTap: (List<Organisation> selectedVendors) {
                            //     BlocProvider.of<
                            //         SLAViolationPenaltyDetailsCubit>(
                            //         context)
                            //         .updateDropdownValues(
                            //         vendors: selectedVendors);
                            //     Navigator.of(context).pop();
                            //   },
                            //   addTitle: 'ADD Vendor',
                            //   createEntity: false,
                            //   orgName: 'ATOM_VENDORS',
                            //   functionToCall: () {
                            //     BlocProvider.of<
                            //         SLAViolationPenaltyDetailsCubit>(
                            //         context)
                            //         .refreshList();
                            //   },
                            // ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Entity
                            CommonWidgets.textDisplay(
                                state.labels?.locale.entity ??
                                    state.labels?.defaultLocale.entity ??
                                    Constants.entity,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseEntitiesSelection().entityDropDownSelection(
                              context: context,
                              selectedValues: state.model.entities ?? [],
                              all: state.listOfEntities ?? [],
                              enabled: !isReadOnly,
                              onTap: (List<Organisation> selectedEntities) {
                                log('--selectedEntities----${selectedEntities.length}');
                                BlocProvider.of<
                                    LawEnforcementDetailsCubit>(
                                    context)
                                    .updateDropdownValues(
                                    entities: selectedEntities);
                                Navigator.of(context).pop();
                              },
                              orgName: 'ATOM_ENTITIES',
                              functionToCall: () {
                                BlocProvider.of<
                                    LawEnforcementDetailsCubit>(
                                    context)
                                    .refreshList();
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Actual Time of Visit
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.keyHandOverDue ??
                              //     state.labels?.defaultLocale
                              // .keyHandOverDue ??
                              Constants.actualtimeofvisit,
                              isMandatory: true,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              textController: timeOfVisitController,
                              isDisabled: state.model.status !=null && state.model.status !=0,
                              onlyDate: true,
                              showPastDate: true,
                              showFutureDate: false,
                              // fromDate: initialisedStartDate,
                              // toDate: initialisedToDate,
                              onChange: (String value) {
                                // isDateSelectedByUser = true;
                                timeOfVisitController.text = value;
                                state.model.timeOfVisit =
                                    Utils().formatTime(value);
                                // state.model.startTime =
                                //     Utils().formatTime(value);
                                BlocProvider.of<
                                    LawEnforcementDetailsCubit>(
                                    context)
                                    .onModelValueChange(state.model);
                                //},
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.01),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Official ID Card Verified?
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.premisesRoundTkn ??
                              //     state.labels?.defaultLocale
                              //         .premisesRoundTkn ??
                                Constants.officialsidcardverified,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            RadioButtonsYesNo(
                                status: state.model.status ?? 0,
                                selectedValue:
                                state.model.officialCardVerified? 1 : 0,
                                onChangedYes: state.model.status == 0
                                    ? null
                                    : (val) {
                                  state.model.officialCardVerified = true;
                                  BlocProvider.of<
                                      LawEnforcementDetailsCubit>(
                                      context);
                                  //.onModelValueChange(state.guardingMasterData
                                  //);
                                },
                                onChangedNo: state.model.status == 0
                                    ? null
                                    : (val) {
                                  state.model.officialCardVerified = false;
                                  BlocProvider.of<
                                      LawEnforcementDetailsCubit>(
                                      context);
                                }),

                            /// Purpose of visit
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.typeOfService ??
                                //     state.labels?.defaultLocale.typeOfService ??
                                    Constants.purposeOfVisit,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            // BaseEntitiesSelection().entityDropDownSelection(
                            //   context: context,
                            //   selectedValues: state.model.typeOfService ?? [],
                            //   all: state.typeOfServices,
                            //   enabled: !isReadOnly,
                            //   onTap:
                            //       (List<Organisation> selectedTypeOfVendors) {
                            //     log('--selectedEntities----${selectedTypeOfVendors.length}');
                            //     BlocProvider.of<
                            //         SLAViolationPenaltyDetailsCubit>(
                            //         context)
                            //         .updateDropdownValues(
                            //         typeOfServices: selectedTypeOfVendors);
                            //     Navigator.of(context).pop();
                            //   },
                            //   addTitle: 'ADD Type of Service',
                            //   createEntity: false,
                            //   orgName: 'SLA_VIOLATION_TYPE_OF_SERVICE',
                            //   functionToCall: () {
                            //     BlocProvider.of<
                            //         SLAViolationPenaltyDetailsCubit>(
                            //         context)
                            //         .refreshList();
                            //   },
                            // ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),


                            /// Document if any to confirm purpose
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.premisesRoundTkn ??
                              //     state.labels?.defaultLocale
                              //         .premisesRoundTkn ??
                                Constants.documentifanytoconfirmpurpose,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            RadioButtonsYesNo(
                                status: state.model.status ?? 0,
                                selectedValue:
                                state.model.documentVerified? 1 : 0,
                                onChangedYes: state.model.status == 0
                                    ? null
                                    : (val) {
                                  state.model.documentVerified = true;
                                  BlocProvider.of<
                                      LawEnforcementDetailsCubit>(
                                      context);
                                  //.onModelValueChange(state.guardingMasterData
                                  //);
                                },
                                onChangedNo: state.model.status == 0
                                    ? null
                                    : (val) {
                                  state.model.documentVerified = false;
                                  BlocProvider.of<
                                      LawEnforcementDetailsCubit>(
                                      context);
                                }),

                            /// In case of Police, was official in uniform?
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.premisesRoundTkn ??
                                //     state.labels?.defaultLocale
                                //         .premisesRoundTkn ??
                                    Constants.incaseofpolicewasofficialinuniform,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            RadioButtonsYesNo(
                                status: state.model.status ?? 0,
                                selectedValue:
                                state.model.visitorInUniform? 1 : 0,
                                onChangedYes: state.model.status == 0
                                    ? null
                                    : (val) {
                                  state.model.visitorInUniform = true;
                                  BlocProvider.of<
                                      LawEnforcementDetailsCubit>(
                                      context);
                                  //.onModelValueChange(state.guardingMasterData
                                  //);
                                },
                                onChangedNo: state.model.status == 0
                                    ? null
                                    : (val) {
                                  state.model.visitorInUniform = false;
                                  BlocProvider.of<
                                      LawEnforcementDetailsCubit>(
                                      context);
                                }),


                            /// DB official want to meet
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.name ??
                              //     state.labels?.defaultLocale
                              //         .name ??
                                Constants.dbofficialwanttomeet,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.001),
                            FlutterInputField(
                              controller: dbOfficialWantToMeetController,
                              textInputType: TextInputType.text,
                              textFormKey: Keys.contactNoKey,
                              hintText: '',
                              // focusNode: employeeIdFocusNode,
                              isEnable: (state.model.status == null || state.model.status ==0)? true : false,
                              isDisableColor: true,
                              onChange: (String value) {
                                state.model.dbOfficialEmail = value;
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.01),


                            /// Db Official email ID Accompanied LEO Official
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.approver ??
                                //     state.labels?.defaultLocale.approver ??
                                    Constants.dbofficialemailidaccompaniedleoofficial,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            TextFieldAddButton(
                              // title: state.model.dbOfficialAccompaniedEmail?.userInfo ??
                              //     state.model.approver?.name,
                              height: 70,
                              isDisableColor: isReadOnly,
                              onTap: () {
                                BaseOrganisationDialog().userDialog(
                                  context: context,
                                  enabled: !isReadOnly,
                                  users: state.emailUsers,
                                  isDbUser: true,
                                  onTap: (BaseUser user) {
                                    BlocProvider.of<
                                        LawEnforcementDetailsCubit>(
                                        context)
                                        .updateDropdownValues(user: user);
                                  },
                                  roleName: ConstantUserRoles.atomAssistantSecurityLead,
                                  locationId: state.model.location!.id!,
                                  functionToCall: (BaseUser user) {
                                    BlocProvider.of<
                                        LawEnforcementDetailsCubit>(
                                        context)
                                        .updateDropdownValues(user: user);
                                    BlocProvider.of<
                                        LawEnforcementDetailsCubit>(
                                        context)
                                        .refreshList();
                                  },
                                );


                              },
                            ),

                              /// Additional Information
                              FlutterInputField(
                                lineHeight: 6,
                                characterLimit:
                                Constants.characterLimitDescTextFormField,
                                initialValue:
                                state.model.additionalInformation,
                                textFormKey: Keys.premisesRoundTknCommentsKey,
                                hintText: Constants.informationhere,
                                showBorder: true,
                                textInputAction: TextInputAction.newline,
                                textInputType:
                                TextInputType.multiline,
                                // isEnable: showSaveSubmitButtons,
                                // isDisableColor: !showSaveSubmitButtons,
                                onChange: (String value) {
                                  state.model.additionalInformation =
                                      value;
                                  context
                                      .read<LawEnforcementDetailsCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.01),

                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Visiting Officials Details section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Visiting Officials Details
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            Constants.visitingOfficialDetails,
                            style: Styles.styleHeaderGreyText16,
                          ),
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.01),
                        GestureDetector(
                          onTap: () async {
                            NavigatorState nav = Navigator.of(context);
                            if(state.model.status == null || state.model.status == 0 || state.model.status ==1) {
                              bool isSaveSuccess = await BlocProvider.of<
                                  LawEnforcementDetailsCubit>(context)
                                  .submitForm(
                                isSaveOnly: true,
                                navigateToNextScreen: true,
                              );

                              if (!isSaveSuccess) {
                                return;
                              }
                            }
                            log('--state.model.id---${state.model.id}--');
                            List<Organisation> violationDescriptions =
                            await CommonServices().getOrganisations(
                                name: Constants.slaViolation);
                            nav.pushNamed(
                              slaViolationPenaltyRecordsRoute,
                              arguments: {
                                ConstantsArgument.title:
                                Constants.violationPenalty,
                                ConstantsArgument.id: state.model.id,
                                ConstantsArgument.violationDescription:
                                Constants.slaViolation,
                                ConstantsArgument.violationDescriptions:
                                violationDescriptions,
                                ConstantsArgument.parentStatus:
                                state.model.status,
                                ConstantsArgument.isLocked:
                                !state.model.lock.isEmptyOrNull,
                              },
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SvgPicture.asset(
                                AppIcon.pluscircle,
                                colorFilter: const ColorFilter.mode(
                                  AppColors.navigationSkyBlueColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                Constants.addViewViolation,
                                style: TextStyle(
                                  color: AppColors.navigationSkyBlueColor,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.02),
                      ],
                    ),
                  ),

                  /// SubmitButton
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if ((state.model.status != 2 &&
                          state.model.status != -1 &&
                          !isReadOnly)) ...[
                        cancelButtonDisplay(),
                        submitButtonDisplay()
                      ],
                    ],
                  ),
                  CommonWidgets.verticalSpacerWidget(height * 0.04),
                ],
              ),
            ),
            if (state.model.status == 2 ||
                state.model.status == ConstantsIntValue.cancelledStatus ||
                isReadOnly) ...[
              Container(
                padding: const EdgeInsets.all(5.0),
                decoration: const ShapeDecoration(
                  color: AppColors.backgroundWhiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(0.0)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    cancelButtonDisplay(),
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

        BlocProvider.of<LawEnforcementDetailsCubit>(context).submitForm();
      },
    );
  }

  Widget submitButton({
    required Function onTap,
    String? label = Constants.submit,
  }) {
    return AppButton(
      width: 150,
      buttonText: label,
      buttonTextKey: Keys.submitButton,
      onTap: onTap,
    );
  }

  Widget dateCreateWidgetDisplay(String date) {
    return FlutterInputField(
      textFormKey: Keys.dateofcreationTextController,
      initialValue: date,
      hintText: '',
      isEnable: false,
      isDisableColor: true,
      onChange: (String value) {},
      validateTextField: (String? user) {},
    );
  }
}
