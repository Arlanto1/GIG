import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';

import 'add_poc_pop_up.dart';

class SLAViolationPenaltyDetailsView extends StatefulWidget {
  final SLAViolationPenaltyModel? model;
  final String title;
  final bool viaAttendance;
  final ExtraProperties? extraProperties;

  const SLAViolationPenaltyDetailsView({
    super.key,
    this.model,
    required this.title,
    required this.viaAttendance,
    this.extraProperties,
  });

  @override
  State<SLAViolationPenaltyDetailsView> createState() =>
      _SLAViolationViewState();
}

class _SLAViolationViewState extends State<SLAViolationPenaltyDetailsView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User? userDetails;
  TextEditingController statusController = TextEditingController();
  bool isReadOnly = false;

  get model => null;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SLAViolationPenaltyDetailsCubit>(context)
        .initializeValues();
    initializeDates();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return BlocConsumer<SLAViolationPenaltyDetailsCubit,
        SLAViolationPenaltyDetailsState>(
      listener: (context, state) {
        log('-state.status---${state.status}----');
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);
        if (state.status == FormStatus.popOnly &&
            state.status != FormStatus.navigateToNextScreen) {
          log('000${state.status == FormStatus.popOnly}');
          var dialog = CustomAlertDialog(
            title: 'SLA Violation Penalty',
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
            title: 'SLA Violation Penalty',
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
        if (state.status == FormStatus.success &&
            !widget.viaAttendance &&
            state.model.attdShiftInfoId == null) {
          log('200${state.status == FormStatus.success && !widget.viaAttendance && state.model.attdShiftInfoId == null}');
          var dialog = CustomAlertDialog(
            title: 'SLA Violation Penalty',
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popAndPushNamed(
                context,
                slaViolationPenaltyListRoute,
              );
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
                '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=${Constants.slaViolationPenaltyDetailsModuleCode}',
            showSaveButton: state.model.status != 2 &&
                    state.model.status != -1 &&
                    !isReadOnly &&
                    state.status != FormStatus.loading
                ? true
                : false,
            showSubmitButton: state.model.status != 2 &&
                    state.model.status != -1 &&
                    !isReadOnly &&
                    state.status != FormStatus.loading
                ? true
                : false,
            showDisLikeButton: false,
            showLikeButton: false,
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<SLAViolationPenaltyDetailsCubit>(context)
                  .submitForm(
                isSaveOnly: true,
                navigateToNextScreen: false,
              );
            },
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<SLAViolationPenaltyDetailsCubit>(context)
                  .submitForm(
                isSaveOnly: false,
                navigateToNextScreen: false,
              );
            },
          ),
          backgroundColor: Colors.transparent,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void initializeDates() {
    // TODO: Maybe we can remove this
  }

  getBodybuilder(SLAViolationPenaltyDetailsState state, height) {
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    return Stack(
      children: [
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
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                              Container(
                                alignment: Alignment.topLeft,
                                child: const Text(
                                  Constants.generalinformation,
                                  style: Styles.textStyleWhite16,
                                ),
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              // General Information Fields
                              ///Created By
                              CommonWidgets.horizontalTextHandling(
                                state.labels?.locale.entrySecurity ??
                                    state.labels?.defaultLocale.entrySecurity ??
                                    Constants.createdby,
                                '${state.model.entrySecurity?.firstName ?? ''} ${state.model.entrySecurity?.lastName ?? ''}',
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              ///Status
                              CommonWidgets.textDisplay(
                                state.labels?.locale.status ??
                                    state.labels?.defaultLocale.status ??
                                    Constants.status,
                                Styles.textStyleWhite16,
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
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
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              ///Date of Creation
                              CommonWidgets.textDisplay(
                                state.labels?.locale.inputDate ??
                                    state.labels?.defaultLocale.inputDate ??
                                    Constants.dateofcreation,
                                Styles.textStyleWhite16,
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              datecreateWidgetdisplay(
                                  state.model.inputDate ?? ''),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              ///Location
                              CommonWidgets.textDisplay(
                                state.labels?.locale.location ??
                                    state.labels?.defaultLocale.location ??
                                    Constants.location,
                                Styles.textStyleWhite16,
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              BaseLocationDropdown().locationWidgetDisplay(
                                  context: context,
                                  isEnabled: !widget.viaAttendance,
                                  locations: state.locations ?? Locations(),
                                  selectedLocationName:
                                      state.model.location?.name ?? '',
                                  onTap: (Organisation? location) {
                                    BlocProvider.of<
                                                SLAViolationPenaltyDetailsCubit>(
                                            context)
                                        .updateLocationDropdownValue(
                                            location: location);
                                  }),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              ///Sl no
                              CommonWidgets.horizontalTextHandling(
                                state.labels?.locale.slNo ??
                                    state.labels?.defaultLocale.slNo ??
                                    Constants.slno,
                                state.model.slNo ?? '',
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              ///Vendor
                              CommonWidgets.textDisplay(
                                state.labels?.locale.vendor ??
                                    state.labels?.defaultLocale.vendor ??
                                    Constants.vendor,
                                Styles.textStyleWhite16,
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              //
                              // BaseEntitiesSelection().entityDropDownSelection(
                              //   context: context,
                              //   selectedValues: state.model.vendor ?? [],
                              //   all: state.vendors,
                              //   enabled: !widget.viaAttendance &&
                              //       !isReadOnly &&
                              //       state.model.attdShiftInfoId == null,
                              //   onTap: (List<Organisation> selectedVendors) {
                              //     BlocProvider.of<
                              //                 SLAViolationPenaltyDetailsCubit>(
                              //             context)
                              //         .updateDropdownValues(
                              //             vendors: selectedVendors);
                              //     Navigator.of(context).pop();
                              //   },
                              //   addTitle: 'ADD Vendor',
                              //   createEntity: false,
                              //   orgName: 'ATOM_VENDORS',
                              //   functionToCall: () {
                              //     BlocProvider.of<
                              //                 SLAViolationPenaltyDetailsCubit>(
                              //             context)
                              //         .refreshList();
                              //   },
                              // ),

                              BaseEntitiesSelection().entityDropDownSelection(
                                context: context,
                                selectedValues: state.model.vendor ?? [],
                                all: state.vendors,
                                enabled: !widget.viaAttendance &&
                                    !isReadOnly &&
                                    state.model.attdShiftInfoId == null,
                                onTap: (List<Organisation> selectedVendors) {
                                  // ✅ Auto-populate POCs from selected vendors' keyname
                                  List<String> autoPocs = [];
                                  for (Organisation vendor in selectedVendors) {
                                    if (vendor.keyName != null && vendor.keyName!.isNotEmpty) {
                                      List<String> emails = vendor.keyName!
                                          .split(',')
                                          .map((e) => e.trim())
                                          .where((e) => e.isNotEmpty)
                                          .toList();
                                      autoPocs.addAll(emails);
                                    }
                                  }

                                  BlocProvider.of<SLAViolationPenaltyDetailsCubit>(context)
                                      .updateDropdownValues(
                                    vendors: selectedVendors,
                                    pocs: autoPocs, // ✅ pass auto-populated POCs
                                  );
                                  Navigator.of(context).pop();
                                },
                                addTitle: 'ADD Vendor',
                                createEntity: false,
                                orgName: 'ATOM_VENDORS',
                                functionToCall: () {
                                  BlocProvider.of<SLAViolationPenaltyDetailsCubit>(context)
                                      .refreshList();
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              ///Entity
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.entity ??
                                      state.labels?.defaultLocale.entity ??
                                      Constants.entity,
                                  Styles.textStyleWhite16,
                                  isMandatory: true),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),

                              BaseEntitiesSelection().entityDropDownSelection(
                                context: context,
                                selectedValues: state.model.entity ?? [],
                                all: state.listOfEntities ?? [],
                                enabled: !isReadOnly,
                                onTap: (List<Organisation> selectedEntities) {
                                  log('--selectedEntities----${selectedEntities.length}');
                                  BlocProvider.of<
                                              SLAViolationPenaltyDetailsCubit>(
                                          context)
                                      .updateDropdownValues(
                                          entities: selectedEntities);
                                  Navigator.of(context).pop();
                                },
                                orgName: 'ATOM_ENTITIES',
                                functionToCall: () {
                                  BlocProvider.of<
                                              SLAViolationPenaltyDetailsCubit>(
                                          context)
                                      .refreshList();
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              ///Type of Service
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.typeOfService ??
                                      state.labels?.defaultLocale
                                          .typeOfService ??
                                      Constants.typeOfService,
                                  Styles.textStyleWhite16,
                                  isMandatory: true),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),

                              BaseEntitiesSelection().entityDropDownSelection(
                                context: context,
                                selectedValues: state.model.typeOfService ?? [],
                                all: state.typeOfServices,
                                enabled: !isReadOnly,
                                onTap:
                                    (List<Organisation> selectedTypeOfVendors) {
                                  log('--selectedEntities----${selectedTypeOfVendors.length}');
                                  BlocProvider.of<
                                              SLAViolationPenaltyDetailsCubit>(
                                          context)
                                      .updateDropdownValues(
                                          typeOfServices:
                                              selectedTypeOfVendors);
                                  Navigator.of(context).pop();
                                },
                                addTitle: 'ADD Type of Service',
                                createEntity: false,
                                orgName: 'SLA_VIOLATION_TYPE_OF_SERVICE',
                                functionToCall: () {
                                  BlocProvider.of<
                                              SLAViolationPenaltyDetailsCubit>(
                                          context)
                                      .refreshList();
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// ASL
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.approver ??
                                      state.labels?.defaultLocale.approver ??
                                      Constants.aSL,
                                  Styles.textStyleWhite16,
                                  isMandatory: true),
                              TextFieldAddButton(
                                title: state.model.approver?.userInfo ??
                                    state.model.approver?.name,
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
                                                  SLAViolationPenaltyDetailsCubit>(
                                              context)
                                          .updateDropdownValues(user: user);
                                    },
                                    roleName: ConstantUserRoles
                                        .atomAssistantSecurityLead,
                                    locationId: state.model.location!.id!,
                                    functionToCall: (BaseUser user) {
                                      BlocProvider.of<
                                                  SLAViolationPenaltyDetailsCubit>(
                                              context)
                                          .updateDropdownValues(user: user);
                                      BlocProvider.of<
                                                  SLAViolationPenaltyDetailsCubit>(
                                              context)
                                          .refreshList();
                                    },
                                  );
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              ///Guarding Agency POC
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.poc ??
                                      state.labels?.defaultLocale.poc ??
                                      Constants.guardingAgencyPOC,
                                  Styles.textStyleWhite16,
                                  isMandatory: true),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                              GestureDetector(
                                onTap: () {
                                  log('--onTap------');
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext dialogContext) {
                                      return AddPOCPopUp(
                                        model: model,
                                        mainContext: context,
                                      );
                                    },
                                  );
                                },
                                child: Row(
                                  children: <Widget>[
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
                                      Constants.addGuardingAgencyPOC,
                                      style: TextStyle(
                                          color: AppColors.white,
                                          decoration: TextDecoration.underline,
                                          decorationColor: AppColors.white),
                                    ),
                                  ],
                                ),
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),
                              Column(
                                children: getPOC(state, height),
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Duty Post Name
                              CommonWidgets.textDisplay(
                                  // state.labels?.locale.postName ??
                                  //     state.labels?.defaultLocale.postName ??
                                  Constants.dutyPostName,
                                  isMandatory: true,
                                  Styles.textStyleWhite16),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              TextFieldAddButton(
                                title: state.model.dutyPostLocation?.name,
                                height: 70,
                                isDisableColor: isReadOnly ||
                                        !state.model.lock.isEmptyOrNull
                                    ? true
                                    : false,
                                onTap: () {
                                  if (isReadOnly ||
                                      state.model.lock.isEmptyOrNull) {
                                    BaseOrganisationDialog().departmentDialog(
                                      context: context,
                                      organisations: state.dutyPosts ?? [],
                                      onTap: (Organisation? org) {
                                        // state.model.dutyPostLocation?.name =
                                        //     org.name;

                                        BlocProvider.of<
                                                    SLAViolationPenaltyDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                                dutyPostName: org);
                                      },
                                    );
                                  }
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Violation Penalty section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Violation Penalty
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              Constants.violationPenalty,
                              style: Styles.textStyleWhite16,
                            ),
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),
                          GestureDetector(
                            onTap: () async {
                              NavigatorState nav = Navigator.of(context);
                              if (state.model.status == null ||
                                  state.model.status == 0 ||
                                  state.model.status == 1) {
                                bool isSaveSuccess = await BlocProvider.of<
                                            SLAViolationPenaltyDetailsCubit>(
                                        context)
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
                                  AppIcon.plusCircle,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.white,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  Constants.addViewViolation,
                                  style: TextStyle(
                                      color: AppColors.white,
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColors.white),
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
                    color: Colors.transparent,
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
      ],
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

  // Widget cancelButtonDisplay(SLAViolationPenaltyDetailsState state) {
  //   bool condition = state.model.id == null ||
  //       state.model.status == ConstantsIntValue.cancelledStatus ||
  //       state.model.status == 2 ||
  //       !state.model.lock.isEmptyOrNull;
  //   return AppButton(
  //     width: Constants.cancelButtonWidth,
  //     backgroundColor: Colors.white,
  //     key: const Key(Keys.cancelButton),
  //     buttonText: condition ? Constants.close : Constants.cancelRecord,
  //     buttonTextKey: Keys.cancelButton,
  //     onTap: () {
  //       if (condition) {
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

  // void updateRecordStatus(SLAViolationPenaltyDetailsState state) {
  //   if (state.model.id != null && widget.model?.status != null) {
  //     BlocProvider.of<SLAViolationPenaltyDetailsCubit>(context)
  //         .updateStatus(id: state.model.id.toString());
  //     Navigator.popAndPushNamed(
  //       context,
  //       slaViolationPenaltyListRoute,
  //     );
  //   } else {
  //     Navigator.pop(context);
  //   }
  // }

  Widget submitButtonDisplay() {
    return AppButton(
      width: 150,
      key: const Key(Keys.submitButton),
      buttonText: Constants.submit,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        FocusScope.of(context).unfocus();

        BlocProvider.of<SLAViolationPenaltyDetailsCubit>(context).submitForm();
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

  // List<Widget> getPOC(SLAViolationPenaltyDetailsState state, height) {
  //   List<Widget> widgets = [];
  //   log('-state.poc.length---${state.pocs?.length}---');
  //   for (String poc in state.pocs ?? []) {
  //     TextEditingController pocController = TextEditingController();
  //     pocController.text = poc;
  //     widgets.add(
  //       FlutterInputField(
  //         //showBorder: true,
  //         lineHeight: 1,
  //         textFieldController: pocController,
  //         textFormKey: Keys.equipmentNoKey,
  //         hintText: '',
  //         isEnable: true,
  //         isDisableColor: false,
  //         onChange: (String value) {
  //           widget.model?.poc = value;
  //           BlocProvider.of<SLAViolationPenaltyDetailsCubit>(context)
  //               .onModelValueChange(state.model);
  //         },
  //       ),
  //     );
  //     widgets.add(const SizedBox(height: 0));
  //     widgets.add(CommonWidgets.verticalSpacerWidget(height * 0.01));
  //   }
  //   return widgets;
  // }

  List<Widget> getPOC(SLAViolationPenaltyDetailsState state, double height) {
    List<Widget> widgets = [];
    log('-state.poc.length---${state.pocs?.length}---');
    for (int index = 0; index < (state.pocs?.length ?? 0); index++) {
      String poc = state.pocs![index]; // Access the POC at the current index
      TextEditingController pocController = TextEditingController();
      pocController.text = poc;
      // for (String poc in state.pocs ?? []) {
      //   TextEditingController pocController = TextEditingController();
      //   pocController.text = poc;
      widgets.add(
        Row(
          children: [
            Expanded(
              child: Text(
                poc,
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.start,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white,), // Cancel icon
              onPressed: () {
                // Remove the POC from the state
                state.pocs?.removeAt(index);
                // Trigger UI update
                BlocProvider.of<SLAViolationPenaltyDetailsCubit>(context)
                    .onCheckBoxChange(state.model);
              },
            ),
          ],
        ),
      );

      widgets.add(const SizedBox(height: 1));
      widgets.add(CommonWidgets.verticalSpacerWidget(height * 0.001));
    }
    if (widgets.isNotEmpty) {
      return [
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.white, width: 0.7)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widgets,
            ),
          ),
        ),
      ];
    } else {
      return []; // Or provide a default list based on your requirements
    }
  }

  Widget datecreateWidgetdisplay(String date) {
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
