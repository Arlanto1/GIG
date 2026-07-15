import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/annual_power_shutdown_list/annual_power_shutdown_list_details/cubits/annual_power_shutdown_list_details_cubit.dart';
import 'package:get/get_navigation/src/root/parse_route.dart';

class AnnualPowerShutdownListDetailsView extends StatefulWidget {
  final AnnualPowerShutdownListModel? model;
  final ExtraProperties? extraProperties;

  const AnnualPowerShutdownListDetailsView({
    this.model,
    super.key,
    this.extraProperties,
  });

  @override
  State<AnnualPowerShutdownListDetailsView> createState() =>
      _AnnualPowerShutdownListDetailsViewState();
}

class _AnnualPowerShutdownListDetailsViewState
    extends State<AnnualPowerShutdownListDetailsView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController eventStartDateController = TextEditingController();
  TextEditingController eventEndDateController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController budgetController = TextEditingController();
  TextEditingController securityGuardCountHrsController =
      TextEditingController();
  TextEditingController securitySupervisorCountHrsController =
      TextEditingController();
  TextEditingController securityOfficerCountHrsController =
      TextEditingController();
  TextEditingController securityFacilitatorCountHrsController =
      TextEditingController();
  TextEditingController poNumberController = TextEditingController();

  bool disableForm = false;
  bool serviceEngFields = false;

  final FocusNode lSM1ContactNoFocusNode = FocusNode();
  final FocusNode lSM2ContactNoFocusNode = FocusNode();
  final FocusNode pocContactNoFocusNode = FocusNode();
  final FocusNode pocEscalationContactNoFocusNode = FocusNode();
  final FocusNode vendor1EmailFocusNode = FocusNode();

  BudgetCostModel budgetCostModel = BudgetCostModel();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AnnualPowerShutdownListDetailsCubit>(context)
        .initializeValues();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return BlocConsumer<AnnualPowerShutdownListDetailsCubit,
        AnnualPowerShutdownListDetailsState>(
      listener: (context, state) {
        log('-state.status---${state.status}----');
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);

        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: Constants.annualPowerShutdownListDetails,
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              // Navigator.pop(context);
              Navigator.popAndPushNamed(
                context,
                annualPowerShutdownListRoute,
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
      },
      builder: (context, state) {
        budgetController.text =
            state.model.budget != null ? state.model.budget.toString() : '';
        poNumberController.text =
        state.model.poNumber != null ? state.model.poNumber.toString() : '';

        if (state.model.status == 30 || !state.model.lock.isEmptyOrNull) {
          disableForm = true;
        }
        if (state.model.status == -1 || !state.model.lock.isEmptyOrNull) {
          disableForm = true;
        }

        // if (widget.extraProperties != null &&
        //     !widget.extraProperties!.hasWritePermission!) {
        //   disableForm = true;
        // }
        if (state.model.status == null) {
          disableForm = false;
        }
        state.model.status ??= 0;
        if (state.model.status! > 0) {
          disableForm = true;
        }

        /// Because this form is Read mode only
        disableForm = true;

        serviceEngFields = state.model.status != 0 &&
            state.model.status != 1 &&
            state.model.status != 2 &&
            state.model.status != 3 &&
            state.model.status != 4 &&
            state.model.status != 5 &&
            state.model.status != 6 &&
            state.model.status != 7 &&
            state.model.status != 8 &&
            state.model.status != 9 &&
            state.model.status != 10 &&
            state.model.status != 11;
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: Constants.generalInformation,
            showPopUp: false,
            showSaveButton: disableForm ? false : true,
            showSubmitButton: disableForm ? false : true,
            showDisLikeButton: false,
            showLikeButton: false,
            pdfAPIName:
                '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=${Constants.annualPowerShutDownModuleCode}',
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<AnnualPowerShutdownListDetailsCubit>(context)
                  .submitForm(isSaveOnly: true);
            },
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<AnnualPowerShutdownListDetailsCubit>(context)
                  .submitForm(isSaveOnly: false);
            },
            popAndReplace: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: AppColors.newColor,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void initializeDates(AnnualPowerShutdownListDetailsState state) {
    log('--sdd--${state.model.eventStartDate}-------');
    log('--sdd-eventEndDate-${state.model.eventEndDate}-------');
    if (state.model.eventStartDate != null) {
      eventStartDateController.text = Utils.timestampToDateConversion(
          int.tryParse(state.model.eventStartDate ?? '0'),
          Constants.fulldateFormat);
    }
    if (state.model.eventEndDate != null) {
      eventEndDateController.text = Utils.timestampToDateConversion(
          int.tryParse(state.model.eventEndDate ?? '0'),
          Constants.fulldateFormat);
    }
  }

  Widget getBodybuilder(AnnualPowerShutdownListDetailsState state, height) {
    initializeDates(state);
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    // return Container(
    //   color: Colors.transparent,
    //   child: SingleChildScrollView(
    //     child: Column(
    //       children: [
    //         // Container(
    //         //   height: height * 0.01,
    //         //   color: AppColors.newColor3,
    //         // ),
    //         Container(
    //           decoration: ShapeDecoration(
    //               color: AppColors.newColor3,
    //               shape: const RoundedRectangleBorder(
    //                 borderRadius:
    //                     BorderRadius.vertical
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
                          absorbing: disableForm,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
                            child: Column(
                              children: [
                                if (!state.model.lock.isEmptyOrNull) ...[
                                  RecordLockedWidget(
                                      text: '${state.model.lock}'),
                                ],
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: const Text(
                                    Constants.generalinformation,
                                    style: Styles.textStyleRegularNormalWhite18,
                                  ),
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Status
                                CommonWidgets.textDisplay(
                                    state.labels?.locale.status ??
                                        state.labels?.defaultLocale.status ??
                                        Constants.status,
                                    Styles.textStyleWhite16,
                                    isMandatory: true),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                BaseDropDown().getDropDown(
                                    isDisabled: true,
                                    textController: statusController,
                                    items: eventProtectionGiStatus,
                                    initialValue: '${state.model.status ?? 0}',
                                    onTap: () {}),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Created By
                                CommonWidgets.horizontalTextHandling(
                                    state.labels?.locale.entrySecurity ??
                                        state.labels?.defaultLocale
                                            .entrySecurity ??
                                        Constants.createdby,
                                    isMandatory: true,
                                    '${state.model.createdBy?.firstName ?? ''} ${state.model.createdBy?.lastName ?? ''}'),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Location
                                CommonWidgets.textDisplay(
                                    state.labels?.locale.location ??
                                        state.labels?.defaultLocale.location ??
                                        Constants.location,
                                    Styles.textStyleWhite16,
                                    isMandatory: true),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                locationWidgetDisplay(state),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

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
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Sl No.
                                CommonWidgets.horizontalTextHandling(
                                    state.labels?.locale.slNo ??
                                        state.labels?.defaultLocale.slNo ??
                                        Constants.slno,
                                    state.model.slNo ?? '',
                                    isMandatory: true),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// Entity
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
                                    selectedValues: state.model.entities ?? [],
                                    all: state.listOfEntities ?? [],
                                    enabled: !disableForm,
                                    onTap:
                                        (List<Organisation> selectedEntities) {
                                      log('--selectedEntities----${selectedEntities.length}');
                                      BlocProvider.of<
                                                  AnnualPowerShutdownListDetailsCubit>(
                                              context)
                                          .updateDropdownValues(
                                              entities: selectedEntities);
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                    }),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// Event Start Date
                                CommonWidgets.textDisplay(
                                    state.labels?.locale.eventStartDate ??
                                        state.labels?.defaultLocale
                                            .eventStartDate ??
                                        Constants.eventStartDate,
                                    Styles.textStyleWhite16,
                                    isMandatory: true),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),

                                BaseDate().datePickerWidgetLoading(
                                  textController: eventStartDateController,
                                  onlyDate: false,
                                  showPastDate: false,
                                  isDisabled: disableForm,
                                  onChange: (String value) {
                                    log('---value-$value------');
                                    state.model.eventStartDate =
                                        Utils().formatTime(value);
                                    log('---Utils().formatTime(value)-${Utils().formatTime(value)}------');
                                    log('---value11-${state.model.eventStartDate}------');
                                    BlocProvider.of<
                                                AnnualPowerShutdownListDetailsCubit>(
                                            context)
                                        .onCheckBoxChange(state.model);
                                  },
                                  context: context,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// Event End Date
                                CommonWidgets.textDisplay(
                                    state.labels?.locale.eventEndDate ??
                                        state.labels?.defaultLocale
                                            .eventEndDate ??
                                        Constants.eventEndDate,
                                    Styles.textStyleWhite16,
                                    isMandatory: true),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),

                                BaseDate().datePickerWidgetLoading(
                                  textController: eventEndDateController,
                                  //onlyDate: false,
                                  isDisabled: disableForm,
                                  showPastDate: false,
                                  startDate: state.model.eventStartDate,
                                  onChange: (String value) {
                                    state.model.eventEndDate =
                                        Utils().formatTime(value);
                                    BlocProvider.of<
                                                AnnualPowerShutdownListDetailsCubit>(
                                            context)
                                        .onModelValueChange(state.model);
                                    log('---value22-${state.model.eventEndDate}------');
                                  },
                                  context: context,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// Sub Regional Head (SRH) 1
                                CommonWidgets.textDisplay(
                                    state.labels?.locale.srh1 ??
                                        state.labels?.defaultLocale.srh1 ??
                                        Constants.subRegionalHead1,
                                    Styles.textStyleWhite16,
                                    isMandatory: true),
                                TextFieldAddButton(
                                  title: state.model.srh1?.userInfo ??
                                      state.model.srh1?.name,
                                  height: 60,
                                  isDisableColor: disableForm,
                                  onTap: () {
                                    BaseOrganisationDialog().userDialog(
                                      context: context,
                                      users: state.srh,
                                      isDbUser: true,
                                      onTap: (BaseUser user) {
                                        BlocProvider.of<
                                                    AnnualPowerShutdownListDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                          subRegionalHead1: user,
                                        );
                                      },
                                      roleName: ConstantUserRoles
                                          .atomSubRegionalHeadUser,
                                      locationId: state.model.location!.id!,
                                      functionToCall: (BaseUser user) {
                                        BlocProvider.of<
                                                    AnnualPowerShutdownListDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                          subRegionalHead1: user,
                                        );
                                        // refresh the list
                                        BlocProvider.of<
                                                    AnnualPowerShutdownListDetailsCubit>(
                                                context)
                                            .refreshList();
                                      },
                                    );
                                  },
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// Sub Regional Head (SRH) 2
                                CommonWidgets.textDisplay(
                                    state.labels?.locale.srh2 ??
                                        state.labels?.defaultLocale.srh2 ??
                                        Constants.subRegionalHead2,
                                    Styles.textStyleWhite16,
                                    isMandatory: true),
                                TextFieldAddButton(
                                  title: state.model.srh2?.userInfo ??
                                      state.model.srh2?.name,
                                  height: 60,
                                  isDisableColor: disableForm,
                                  onTap: () {
                                    BaseOrganisationDialog().userDialog(
                                      context: context,
                                      users: state.srh,
                                      isDbUser: true,
                                      onTap: (BaseUser user) {
                                        BlocProvider.of<
                                                    AnnualPowerShutdownListDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                          subRegionalHead2: user,
                                        );
                                      },
                                      roleName: ConstantUserRoles
                                          .atomSubRegionalHeadUser,
                                      locationId: state.model.location!.id!,
                                      functionToCall: (BaseUser user) {
                                        BlocProvider.of<
                                                    AnnualPowerShutdownListDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                          subRegionalHead2: user,
                                        );
                                        // refresh the list
                                        BlocProvider.of<
                                                    AnnualPowerShutdownListDetailsCubit>(
                                                context)
                                            .refreshList();
                                      },
                                    );
                                  },
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// Location Security  Manager 1
                                CommonWidgets.textDisplay(
                                    state.labels?.locale.lsm1 ??
                                        state.labels?.defaultLocale.lsm1 ??
                                        Constants.locationSecurityManager1,
                                    Styles.textStyleWhite16,
                                    isMandatory: true),
                                TextFieldAddButton(
                                  title: state.model.lsm1?.userInfo ??
                                      state.model.lsm1?.name,
                                  height: 70,
                                  isDisableColor: true,
                                  onTap: () {
                                    BaseOrganisationDialog().userDialog(
                                      context: context,
                                      users: state.lsm,
                                      isDbUser: true,
                                      onTap: (BaseUser user) {
                                        BlocProvider.of<
                                                    AnnualPowerShutdownListDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                          locationSecurityManager1: user,
                                        );
                                        FocusScope.of(context).requestFocus(
                                            lSM1ContactNoFocusNode);
                                      },
                                      roleName: ConstantUserRoles
                                          .atomSeniorSecurityManagerUser,
                                      locationId: state.model.location!.id!,
                                      functionToCall: (BaseUser user) {
                                        BlocProvider.of<
                                                    AnnualPowerShutdownListDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                          locationSecurityManager1: user,
                                        );
                                        FocusScope.of(context).requestFocus(
                                            lSM1ContactNoFocusNode);
                                        // refresh the list
                                        BlocProvider.of<
                                                    AnnualPowerShutdownListDetailsCubit>(
                                                context)
                                            .refreshList();
                                      },
                                    );
                                  },
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                ///LSM 1 Contact No
                                CommonWidgets.textDisplay(
                                    state.labels?.locale.lsm1ContactNo ??
                                        state.labels?.defaultLocale
                                            .lsm1ContactNo ??
                                        Constants.lsm1ContactNo,
                                    Styles.textStyleWhite16,
                                    isMandatory: true),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                FlutterInputField(
                                  textInputType: TextInputType.number,
                                  initialValue: state.model.lsm1ContactNo,
                                  textFormKey: Keys.lsm1ContactNOKey,
                                  hintText: '',
                                  focusNode: lSM1ContactNoFocusNode,
                                  characterLimit:
                                      Constants.characterLimitContactNo,
                                  isEnable: !disableForm,
                                  isDisableColor: true,
                                  onChange: (String value) {
                                    state.model.lsm1ContactNo = value;
                                    context
                                        .read<
                                            AnnualPowerShutdownListDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// Location Security  Manager 2
                                CommonWidgets.textDisplay(
                                    state.labels?.locale.lsm2 ??
                                        state.labels?.defaultLocale.lsm2 ??
                                        Constants.locationSecurityManager2,
                                    Styles.textStyleWhite16,
                                    isMandatory: true),
                                TextFieldAddButton(
                                  title: state.model.lsm2?.userInfo ??
                                      state.model.lsm2?.name,
                                  height: 70,
                                  isDisableColor: disableForm,
                                  onTap: () {
                                    BaseOrganisationDialog().userDialog(
                                      context: context,
                                      users: state.lsm,
                                      isDbUser: true,
                                      onTap: (BaseUser user) {
                                        BlocProvider.of<
                                                    AnnualPowerShutdownListDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                          locationSecurityManager2: user,
                                        );
                                        FocusScope.of(context).requestFocus(
                                            lSM2ContactNoFocusNode);
                                      },
                                      roleName: ConstantUserRoles
                                          .atomSeniorSecurityManagerUser,
                                      locationId: state.model.location!.id!,
                                      functionToCall: (BaseUser user) {
                                        BlocProvider.of<
                                                    AnnualPowerShutdownListDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                          locationSecurityManager2: user,
                                        );
                                        FocusScope.of(context).requestFocus(
                                            lSM2ContactNoFocusNode);
                                        // refresh the list
                                        BlocProvider.of<
                                                    AnnualPowerShutdownListDetailsCubit>(
                                                context)
                                            .refreshList();
                                      },
                                    );
                                  },
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                ///LSM 2 Contact No
                                CommonWidgets.textDisplay(
                                    state.labels?.locale.lsm2ContactNo ??
                                        state.labels?.defaultLocale
                                            .lsm2ContactNo ??
                                        Constants.lsm2ContactNo,
                                    Styles.textStyleWhite16,
                                    isMandatory: true),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                FlutterInputField(
                                  // labelText: Constants.lsm2ContactNo,
                                  textInputType: TextInputType.number,
                                  characterLimit:
                                      Constants.characterLimitContactNo,
                                  initialValue: state.model.lsm2ContactNo,
                                  textFormKey: Keys.lsm2ContactNOKey,
                                  hintText: '',
                                  focusNode: lSM2ContactNoFocusNode,
                                  isEnable: !disableForm,
                                  isDisableColor: disableForm,
                                  onChange: (String value) {
                                    state.model.lsm2ContactNo = value;
                                    context
                                        .read<
                                            AnnualPowerShutdownListDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                ///Business POC
                                CommonWidgets.textDisplay(
                                    state.labels?.locale.bu1 ??
                                        state.labels?.defaultLocale.bu1 ??
                                        Constants.businessPoc,
                                    Styles.textStyleWhite16,
                                    isMandatory: true),
                                TextFieldAddButton(
                                  title: state.model.bu1?.userInfo ??
                                      state.model.bu1?.name,
                                  height: 70,
                                  isDisableColor: disableForm,
                                  onTap: () {
                                    BaseOrganisationDialog().userDialog(
                                      context: context,
                                      users: state.emailUsers!,
                                      isDbUser: true,
                                      onTap: (BaseUser user) {
                                        BlocProvider.of<
                                                    AnnualPowerShutdownListDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                          bu1: user,
                                        );
                                        FocusScope.of(context).requestFocus(
                                            pocContactNoFocusNode);
                                      },
                                      roleName:
                                          ConstantUserRoles.atomStaticUser,
                                      locationId: state.model.location!.id!,
                                      functionToCall: (BaseUser user) {
                                        BlocProvider.of<
                                                    AnnualPowerShutdownListDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                          bu1: user,
                                        );
                                        FocusScope.of(context).requestFocus(
                                            pocContactNoFocusNode);
                                        // refresh the list
                                        BlocProvider.of<
                                                    AnnualPowerShutdownListDetailsCubit>(
                                                context)
                                            .refreshList();
                                      },
                                    );
                                  },
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                ///Business POC  Contact No
                                CommonWidgets.textDisplay(
                                    state.labels?.locale.bu1ContactNo ??
                                        state.labels?.defaultLocale
                                            .bu1ContactNo ??
                                        Constants.businessPocContactNo,
                                    Styles.textStyleWhite16,
                                    isMandatory: true),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                FlutterInputField(
                                  textInputType: TextInputType.number,
                                  initialValue: state.model.bu1ContactNo,
                                  textFormKey: Keys.bu1ContactNOKey,
                                  hintText: '',
                                  focusNode: pocContactNoFocusNode,
                                  characterLimit:
                                      Constants.characterLimitContactNo,
                                  isEnable: !disableForm,
                                  isDisableColor: disableForm,
                                  onChange: (String value) {
                                    state.model.bu1ContactNo = value;
                                    context
                                        .read<
                                            AnnualPowerShutdownListDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                ///Business POC Escalation
                                CommonWidgets.textDisplay(
                                    state.labels?.locale.bu2 ??
                                        state.labels?.defaultLocale.bu2 ??
                                        Constants.businessPocEscalation,
                                    Styles.textStyleWhite16,
                                    isMandatory: true),
                                TextFieldAddButton(
                                  title: state.model.bu2?.userInfo ??
                                      state.model.bu2?.name,
                                  height: 70,
                                  isDisableColor: disableForm,
                                  onTap: () {
                                    BaseOrganisationDialog().userDialog(
                                      context: context,
                                      users: state.emailUsers!,
                                      isDbUser: true,
                                      onTap: (BaseUser user) {
                                        BlocProvider.of<
                                                    AnnualPowerShutdownListDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                          bu2: user,
                                        );
                                        FocusScope.of(context).requestFocus(
                                            pocEscalationContactNoFocusNode);
                                      },
                                      roleName:
                                          ConstantUserRoles.atomStaticUser,
                                      locationId: state.model.location!.id!,
                                      functionToCall: (BaseUser user) {
                                        BlocProvider.of<
                                                    AnnualPowerShutdownListDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                          bu2: user,
                                        );
                                        FocusScope.of(context).requestFocus(
                                            pocEscalationContactNoFocusNode);
                                        // refresh the list
                                        BlocProvider.of<
                                                    AnnualPowerShutdownListDetailsCubit>(
                                                context)
                                            .refreshList();
                                      },
                                    );
                                  },
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                ///Business POC Escalation Contact No
                                CommonWidgets.textDisplay(
                                    state.labels?.locale.bu2ContactNo ??
                                        state.labels?.defaultLocale
                                            .bu2ContactNo ??
                                        Constants
                                            .businessPocEscalationContactNo,
                                    Styles.textStyleWhite16,
                                    isMandatory: true),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                FlutterInputField(
                                  textInputType: TextInputType.number,
                                  initialValue: state.model.bu2ContactNo,
                                  textFormKey: Keys.bu2ContactNOKey,
                                  hintText: '',
                                  focusNode: pocEscalationContactNoFocusNode,
                                  characterLimit:
                                      Constants.characterLimitContactNo,
                                  isEnable: !disableForm,
                                  isDisableColor: disableForm,
                                  onChange: (String value) {
                                    state.model.bu2ContactNo = value;
                                    context
                                        .read<
                                            AnnualPowerShutdownListDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                ///Business POC Department
                                CommonWidgets.textDisplay(
                                    state.labels?.locale.bu1Dept ??
                                        state.labels?.defaultLocale.bu1Dept ??
                                        Constants.businessPocDepartment,
                                    Styles.textStyleWhite16,
                                    isMandatory: true),
                                TextFieldAddButton(
                                  title: state.model.bu1Dept?.name,
                                  height: 70,
                                  isDisableColor: disableForm,
                                  onTap: () {
                                    BaseOrganisationDialog().departmentDialog(
                                        context: context,
                                        organisations: state.departments,
                                        onTap: (Organisation department) {
                                          BlocProvider.of<
                                                      AnnualPowerShutdownListDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                                  bu1Dept: department);
                                        },
                                        orgName: 'EMPLOYEE_DEPARTMENTS',
                                        createEntity: false,
                                        title: 'Add Department',
                                        functionToCall: () {
                                          // refresh the list
                                          BlocProvider.of<
                                                      AnnualPowerShutdownListDetailsCubit>(
                                                  context)
                                              .refreshList();
                                        });
                                  },
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// Business POC Escalation Department
                                CommonWidgets.textDisplay(
                                    state.labels?.locale.bu2Dept ??
                                        state.labels?.defaultLocale.bu2Dept ??
                                        Constants
                                            .businessPocEscalationDepartment,
                                    Styles.textStyleWhite16,
                                    isMandatory: true),
                                TextFieldAddButton(
                                  title: state.model.bu2Dept?.name,
                                  height: 70,
                                  isDisableColor: disableForm,
                                  onTap: () {
                                    BaseOrganisationDialog().departmentDialog(
                                        context: context,
                                        organisations: state.departments,
                                        onTap: (Organisation department) {
                                          BlocProvider.of<
                                                      AnnualPowerShutdownListDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                                  bu2Dept: department);
                                          FocusScope.of(context).requestFocus(
                                              vendor1EmailFocusNode);
                                        },
                                        orgName: 'EMPLOYEE_DEPARTMENTS',
                                        createEntity: false,
                                        title: 'Add Department',
                                        functionToCall: () {
                                          // refresh the list
                                          BlocProvider.of<
                                                      AnnualPowerShutdownListDetailsCubit>(
                                                  context)
                                              .refreshList();
                                        });
                                  },
                                ),

                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// System Vendor 1 Email
                                CommonWidgets.textDisplay(
                                    state.labels?.locale.systemVendor1 ??
                                        state.labels?.defaultLocale
                                            .systemVendor1 ??
                                        Constants.systemVendor1Email,
                                    Styles.textStyleWhite16,
                                    isMandatory: true),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                FlutterInputField(
                                  textInputType: TextInputType.text,
                                  initialValue: state.model.systemVendor1,
                                  textFormKey: Keys.systemVendor1EmailKey,
                                  textCapitalization: false,
                                  hintText: '',
                                  focusNode: vendor1EmailFocusNode,
                                  isEnable: !disableForm,
                                  isDisableColor: disableForm,
                                  onChange: (String value) {
                                    state.model.systemVendor1 = value;
                                    context
                                        .read<
                                            AnnualPowerShutdownListDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// Vendor 1 Contact No
                                CommonWidgets.textDisplay(
                                    state.labels?.locale
                                            .systemVendor1ContactNo ??
                                        state.labels?.defaultLocale
                                            .systemVendor1ContactNo ??
                                        Constants.vendor1ContactNO,
                                    Styles.textStyleWhite16,
                                    isMandatory: true),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                FlutterInputField(
                                  textInputType: TextInputType.number,
                                  initialValue:
                                      state.model.systemVendor1ContactNo,
                                  textFormKey: Keys.vendor1Contact1Key,
                                  hintText: '',
                                  characterLimit:
                                      Constants.characterLimitContactNo,
                                  isEnable: !disableForm,
                                  isDisableColor: disableForm,
                                  onChange: (String value) {
                                    state.model.systemVendor1ContactNo = value;
                                    context
                                        .read<
                                            AnnualPowerShutdownListDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                if (serviceEngFields == true) ...[
                                  /// Primary Service Engineer Name
                                  CommonWidgets.textDisplay(
                                      // state.labels?.locale.systemVendor1ContactNo ??
                                      //     state.labels?.defaultLocale
                                      //         .systemVendor1ContactNo ??
                                      Constants.primaryServiceEngineerName,
                                      Styles.textStyleWhite16,
                                      isMandatory: true),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    textInputType: TextInputType.text,
                                    initialValue: state.model.vendor1Primary,
                                    textFormKey: Keys.vendor1Contact1Key,
                                    hintText: '',
                                    characterLimit:
                                        Constants.characterLimitContactNo,
                                    isEnable: !disableForm,
                                    isDisableColor: disableForm,
                                    onChange: (String value) {
                                      state.model.vendor1Primary = value;
                                      context
                                          .read<
                                              AnnualPowerShutdownListDetailsCubit>()
                                          .onModelValueChange(state.model);
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),

                                  /// Primary Service Engineer Contact
                                  CommonWidgets.textDisplay(
                                      // state.labels?.locale.systemVendor1ContactNo ??
                                      //     state.labels?.defaultLocale
                                      //         .systemVendor1ContactNo ??
                                      Constants.primaryServiceEngineerContact,
                                      Styles.textStyleWhite16,
                                      isMandatory: true),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    textInputType: TextInputType.number,
                                    initialValue:
                                        state.model.vendor1PrimaryContact,
                                    textFormKey: Keys.vendor1Contact1Key,
                                    hintText: '',
                                    characterLimit:
                                        Constants.characterLimitContactNo,
                                    isEnable: !disableForm,
                                    isDisableColor: disableForm,
                                    onChange: (String value) {
                                      state.model.systemVendor1ContactNo =
                                          value;
                                      context
                                          .read<
                                              AnnualPowerShutdownListDetailsCubit>()
                                          .onModelValueChange(state.model);
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),

                                  /// Secondary Service Engineer name
                                  CommonWidgets.textDisplay(
                                      // state.labels?.locale.systemVendor1ContactNo ??
                                      //     state.labels?.defaultLocale
                                      //         .systemVendor1ContactNo ??
                                      Constants.secondaryServiceEngineerName,
                                      Styles.textStyleWhite16,
                                      isMandatory: true),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    textInputType: TextInputType.number,
                                    initialValue: state.model.vendor1Secondary,
                                    textFormKey: Keys.vendor1Contact1Key,
                                    hintText: '',
                                    characterLimit:
                                        Constants.characterLimitContactNo,
                                    isEnable: !disableForm,
                                    isDisableColor: disableForm,
                                    onChange: (String value) {
                                      state.model.vendor1Secondary = value;
                                      context
                                          .read<
                                              AnnualPowerShutdownListDetailsCubit>()
                                          .onModelValueChange(state.model);
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),

                                  /// Secondary Service Engineer Contact
                                  CommonWidgets.textDisplay(
                                      // state.labels?.locale.systemVendor1ContactNo ??
                                      //     state.labels?.defaultLocale
                                      //         .systemVendor1ContactNo ??
                                      Constants.secondaryServiceEngineerContact,
                                      Styles.textStyleWhite16,
                                      isMandatory: true),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    textInputType: TextInputType.number,
                                    initialValue:
                                        state.model.vendor1SecondaryContact,
                                    textFormKey: Keys.vendor1Contact1Key,
                                    hintText: '',
                                    characterLimit:
                                        Constants.characterLimitContactNo,
                                    isEnable: !disableForm,
                                    isDisableColor: disableForm,
                                    onChange: (String value) {
                                      state.model.vendor1SecondaryContact =
                                          value;
                                      context
                                          .read<
                                              AnnualPowerShutdownListDetailsCubit>()
                                          .onModelValueChange(state.model);
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),
                                ],

                                ///System Vendor 2 Email
                                CommonWidgets.textDisplay(
                                    state.labels?.locale.systemVendor2 ??
                                        state.labels?.defaultLocale
                                            .systemVendor2 ??
                                        Constants.systemVendor2Email,
                                    Styles.textStyleWhite16,
                                    isMandatory: true),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                FlutterInputField(
                                  textInputType: TextInputType.text,
                                  initialValue: state.model.systemVendor2,
                                  textFormKey: Keys.systemVendor2EmailKey,
                                  textCapitalization: false,
                                  hintText: '',
                                  isEnable: !disableForm,
                                  isDisableColor: disableForm,
                                  onChange: (String value) {
                                    state.model.systemVendor2 = value;
                                    context
                                        .read<
                                            AnnualPowerShutdownListDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                ///Vendor 2 Contact No
                                CommonWidgets.textDisplay(
                                    state.labels?.locale
                                            .systemVendor2ContactNo ??
                                        state.labels?.defaultLocale
                                            .systemVendor2ContactNo ??
                                        Constants.vendor2ContactNO,
                                    Styles.textStyleWhite16,
                                    isMandatory: true),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                FlutterInputField(
                                  textInputType: TextInputType.number,
                                  initialValue:
                                      state.model.systemVendor2ContactNo,
                                  textFormKey: Keys.vendor2ContactKey,
                                  characterLimit:
                                      Constants.characterLimitContactNo,
                                  hintText: '',
                                  isEnable: !disableForm,
                                  isDisableColor: disableForm,
                                  onChange: (String value) {
                                    state.model.systemVendor2ContactNo = value;
                                    context
                                        .read<
                                            AnnualPowerShutdownListDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                if (serviceEngFields == true) ...[
                                  /// Primary Service Engineer Name
                                  CommonWidgets.textDisplay(
                                      // state.labels?.locale.systemVendor1ContactNo ??
                                      //     state.labels?.defaultLocale
                                      //         .systemVendor1ContactNo ??
                                      Constants.primaryServiceEngineerName,
                                      Styles.textStyleWhite16,
                                      isMandatory: true),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    textInputType: TextInputType.text,
                                    initialValue: state.model.vendor2Primary,
                                    textFormKey: Keys.vendor1Contact1Key,
                                    hintText: '',
                                    characterLimit:
                                        Constants.characterLimitContactNo,
                                    isEnable: !disableForm,
                                    isDisableColor: disableForm,
                                    onChange: (String value) {
                                      state.model.vendor2Primary = value;
                                      context
                                          .read<
                                              AnnualPowerShutdownListDetailsCubit>()
                                          .onModelValueChange(state.model);
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),

                                  /// Primary Service Engineer Contact
                                  CommonWidgets.textDisplay(
                                      // state.labels?.locale.systemVendor1ContactNo ??
                                      //     state.labels?.defaultLocale
                                      //         .systemVendor1ContactNo ??
                                      Constants.primaryServiceEngineerContact,
                                      Styles.textStyleWhite16,
                                      isMandatory: true),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    textInputType: TextInputType.number,
                                    initialValue:
                                        state.model.vendor2PrimaryContact,
                                    textFormKey: Keys.vendor1Contact1Key,
                                    hintText: '',
                                    characterLimit:
                                        Constants.characterLimitContactNo,
                                    isEnable: !disableForm,
                                    isDisableColor: disableForm,
                                    onChange: (String value) {
                                      state.model.vendor2PrimaryContact = value;
                                      context
                                          .read<
                                              AnnualPowerShutdownListDetailsCubit>()
                                          .onModelValueChange(state.model);
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),

                                  /// Secondary Service Engineer name
                                  CommonWidgets.textDisplay(
                                      // state.labels?.locale.systemVendor1ContactNo ??
                                      //     state.labels?.defaultLocale
                                      //         .systemVendor1ContactNo ??
                                      Constants.secondaryServiceEngineerName,
                                      Styles.textStyleWhite16,
                                      isMandatory: true),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    textInputType: TextInputType.number,
                                    initialValue: state.model.vendor2Secondary,
                                    textFormKey: Keys.vendor1Contact1Key,
                                    hintText: '',
                                    characterLimit:
                                        Constants.characterLimitContactNo,
                                    isEnable: !disableForm,
                                    isDisableColor: disableForm,
                                    onChange: (String value) {
                                      state.model.vendor2Secondary = value;
                                      context
                                          .read<
                                              AnnualPowerShutdownListDetailsCubit>()
                                          .onModelValueChange(state.model);
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),

                                  /// Secondary Service Engineer Contact
                                  CommonWidgets.textDisplay(
                                      // state.labels?.locale.systemVendor1ContactNo ??
                                      //     state.labels?.defaultLocale
                                      //         .systemVendor1ContactNo ??
                                      Constants.secondaryServiceEngineerContact,
                                      Styles.textStyleWhite16,
                                      isMandatory: true),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    textInputType: TextInputType.number,
                                    initialValue:
                                        state.model.vendor2SecondaryContact,
                                    textFormKey: Keys.vendor1Contact1Key,
                                    hintText: '',
                                    characterLimit:
                                        Constants.characterLimitContactNo,
                                    isEnable: !disableForm,
                                    isDisableColor: disableForm,
                                    onChange: (String value) {
                                      state.model.vendor2SecondaryContact =
                                          value;
                                      context
                                          .read<
                                              AnnualPowerShutdownListDetailsCubit>()
                                          .onModelValueChange(state.model);
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),
                                ],

                                ///System Vendor 3 Email
                                CommonWidgets.textDisplay(
                                    state.labels?.locale.systemVendor3 ??
                                        state.labels?.defaultLocale
                                            .systemVendor3 ??
                                        Constants.systemVendor3Email,
                                    Styles.textStyleWhite16),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                FlutterInputField(
                                  textInputType: TextInputType.text,
                                  initialValue: state.model.systemVendor3,
                                  textFormKey: Keys.systemVendor2EmailKey,
                                  textCapitalization: false,
                                  hintText: '',
                                  isEnable: !disableForm,
                                  isDisableColor: disableForm,
                                  onChange: (String value) {
                                    state.model.systemVendor3 = value;
                                    context
                                        .read<
                                            AnnualPowerShutdownListDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                ///Vendor 3 Contact No
                                CommonWidgets.textDisplay(
                                    state.labels?.locale
                                            .systemVendor3ContactNo ??
                                        state.labels?.defaultLocale
                                            .systemVendor3ContactNo ??
                                        Constants.vendor3ContactNO,
                                    Styles.textStyleWhite16),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                FlutterInputField(
                                  textInputType: TextInputType.number,
                                  initialValue:
                                      state.model.systemVendor3ContactNo,
                                  textFormKey: Keys.vendor3ContactKey,
                                  hintText: '',
                                  characterLimit:
                                      Constants.characterLimitContactNo,
                                  isEnable: !disableForm,
                                  isDisableColor: disableForm,
                                  onChange: (String value) {
                                    state.model.systemVendor3ContactNo = value;
                                    context
                                        .read<
                                            AnnualPowerShutdownListDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                if (serviceEngFields == true) ...[
                                  /// Primary Service Engineer Name
                                  CommonWidgets.textDisplay(
                                      // state.labels?.locale.systemVendor1ContactNo ??
                                      //     state.labels?.defaultLocale
                                      //         .systemVendor1ContactNo ??
                                      Constants.primaryServiceEngineerName,
                                      Styles.textStyleWhite16,
                                      isMandatory: true),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    textInputType: TextInputType.text,
                                    initialValue: state.model.vendor3Primary,
                                    textFormKey: Keys.vendor1Contact1Key,
                                    hintText: '',
                                    characterLimit:
                                        Constants.characterLimitContactNo,
                                    isEnable: !disableForm,
                                    isDisableColor: disableForm,
                                    onChange: (String value) {
                                      state.model.vendor3Primary = value;
                                      context
                                          .read<
                                              AnnualPowerShutdownListDetailsCubit>()
                                          .onModelValueChange(state.model);
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),

                                  /// Primary Service Engineer Contact
                                  CommonWidgets.textDisplay(
                                      // state.labels?.locale.systemVendor1ContactNo ??
                                      //     state.labels?.defaultLocale
                                      //         .systemVendor1ContactNo ??
                                      Constants.primaryServiceEngineerContact,
                                      Styles.textStyleWhite16,
                                      isMandatory: true),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    textInputType: TextInputType.number,
                                    initialValue:
                                        state.model.vendor3PrimaryContact,
                                    textFormKey: Keys.vendor1Contact1Key,
                                    hintText: '',
                                    characterLimit:
                                        Constants.characterLimitContactNo,
                                    isEnable: !disableForm,
                                    isDisableColor: disableForm,
                                    onChange: (String value) {
                                      state.model.vendor3PrimaryContact = value;
                                      context
                                          .read<
                                              AnnualPowerShutdownListDetailsCubit>()
                                          .onModelValueChange(state.model);
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),

                                  /// Secondary Service Engineer name
                                  CommonWidgets.textDisplay(
                                      // state.labels?.locale.systemVendor1ContactNo ??
                                      //     state.labels?.defaultLocale
                                      //         .systemVendor1ContactNo ??
                                      Constants.secondaryServiceEngineerName,
                                      Styles.textStyleWhite16,
                                      isMandatory: true),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    textInputType: TextInputType.number,
                                    initialValue: state.model.vendor3Secondary,
                                    textFormKey: Keys.vendor1Contact1Key,
                                    hintText: '',
                                    characterLimit:
                                        Constants.characterLimitContactNo,
                                    isEnable: !disableForm,
                                    isDisableColor: disableForm,
                                    onChange: (String value) {
                                      state.model.vendor3Secondary = value;
                                      context
                                          .read<
                                              AnnualPowerShutdownListDetailsCubit>()
                                          .onModelValueChange(state.model);
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),

                                  /// Secondary Service Engineer Contact
                                  CommonWidgets.textDisplay(
                                      // state.labels?.locale.systemVendor1ContactNo ??
                                      //     state.labels?.defaultLocale
                                      //         .systemVendor1ContactNo ??
                                      Constants.secondaryServiceEngineerContact,
                                      Styles.textStyleWhite16,
                                      isMandatory: true),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    textInputType: TextInputType.number,
                                    initialValue:
                                        state.model.vendor3SecondaryContact,
                                    textFormKey: Keys.vendor1Contact1Key,
                                    hintText: '',
                                    characterLimit:
                                        Constants.characterLimitContactNo,
                                    isEnable: !disableForm,
                                    isDisableColor: disableForm,
                                    onChange: (String value) {
                                      state.model.vendor3SecondaryContact =
                                          value;
                                      context
                                          .read<
                                              AnnualPowerShutdownListDetailsCubit>()
                                          .onModelValueChange(state.model);
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),
                                ],

                                ///Requester Department
                                CommonWidgets.textDisplay(
                                    state.labels?.locale.requesterDepartment ??
                                        state.labels?.defaultLocale
                                            .requesterDepartment ??
                                        Constants.requesterDepartment,
                                    Styles.textStyleWhite16,
                                    isMandatory: true),
                                TextFieldAddButton(
                                  title: state.model.requesterDepartment?.name,
                                  height: 70,
                                  isDisableColor: disableForm,
                                  onTap: () {
                                    BaseOrganisationDialog().departmentDialog(
                                        context: context,
                                        organisations: state.departments,
                                        onTap: (Organisation department) {
                                          BlocProvider.of<
                                                      AnnualPowerShutdownListDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                                  requesterDepartment:
                                                      department);
                                        },
                                        orgName: 'EMPLOYEE_DEPARTMENTS',
                                        createEntity: false,
                                        title: 'Add Department',
                                        functionToCall: () {
                                          // refresh the list
                                          BlocProvider.of<
                                                      AnnualPowerShutdownListDetailsCubit>(
                                                  context)
                                              .refreshList();
                                        });
                                  },
                                ),

                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                ///Event Protection Officer
                                CommonWidgets.textDisplay(
                                    state.labels?.locale.epOfficers ??
                                        state
                                            .labels?.defaultLocale.epOfficers ??
                                        Constants.eventProtectionOfficers,
                                    Styles.textStyleWhite16,
                                    isMandatory: true),
                                //if (!disableForm) ...[
                                Opacity(
                                  opacity: disableForm ? 1 : 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ...state.model.epOfficers
                                              ?.asMap()
                                              .entries
                                              .map((entry) {
                                            final index = entry.key;
                                            final officer = entry.value;
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    const SizedBox(width: 10),
                                                    BasicWidgetFunctions()
                                                        .getStringText(
                                                      strings: [officer],
                                                    ),
                                                  ],
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    // Remove the officer from the list
                                                    state.model.epOfficers
                                                        ?.removeAt(index);
                                                    // Trigger UI update
                                                    BlocProvider.of<
                                                                AnnualPowerShutdownListDetailsCubit>(
                                                            context)
                                                        .onCheckBoxChange(
                                                            state.model);
                                                  },
                                                  child: Row(
                                                    children: <Widget>[
                                                      const SizedBox(width: 10),
                                                      SvgPicture.asset(
                                                        AppIcon.close,
                                                        // Add your close icon asset here
                                                        // color: Colors
                                                        //     .black, // Set color as per your design
                                                      ),
                                                      const SizedBox(width: 14),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          }).toList() ??
                                          [],
                                      GestureDetector(
                                        onTap: () {
                                          BaseOrganisationDialog().userDialog(
                                            context: context,
                                            enabled: !disableForm,
                                            isDbUser: true,
                                            users: state.emailUsers!,
                                            onTap: (BaseUser user) {
                                              state.model.epOfficers ??= [];

                                              if (state.model.epOfficers!
                                                  .contains(user.email!)) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        'Officer already added! Please add another officer.'),
                                                  ),
                                                );
                                                return;
                                              }

                                              state.model.epOfficers
                                                  ?.add(user.email ?? '');
                                              log('--eventProtectionGi--22-${state.model.epOfficers}-');
                                              BlocProvider.of<
                                                          AnnualPowerShutdownListDetailsCubit>(
                                                      context)
                                                  .onCheckBoxChange(
                                                      state.model);
                                            },
                                            locationId:
                                                state.model.location!.id!,
                                          );
                                        },
                                        child: Opacity(
                                          opacity: disableForm ? 0.5 : 1,
                                          child: Row(
                                            children: <Widget>[
                                              const SizedBox(width: 14),
                                              SvgPicture.asset(
                                                AppIcon.plusCircle,
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                  AppColors.white,
                                                  BlendMode.srcIn,
                                                ),
                                                // color:
                                                //     AppColors.navigationSkyBlueColor,
                                              ),
                                              const SizedBox(width: 10),
                                              const Text(
                                                'Add Officer',
                                                style: TextStyle(
                                                    color: AppColors.white,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    decorationColor:
                                                        Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //],

                                ///Is Extra Security Deployment Required
                                Row(children: [
                                  CommonWidgets.textDisplay(
                                    state.labels?.locale.extraSecurityDeployed ??
                                        state.labels?.defaultLocale
                                            .extraSecurityDeployed ??
                                        Constants
                                            .isExtraSecurityDeploymentRequired,
                                    Styles.textStyleWhite16,
                                  ),
                                  Opacity(
                                    opacity: disableForm ? 0.5 : 1,
                                    child: Checkbox(
                                        activeColor: const Color(0xFF071130),
                                        focusColor: const Color(0xFF071130),
                                        value:
                                            state.model.extraSecurityDeployed,
                                        onChanged: (bool? value) {
                                          state.model.extraSecurityDeployed =
                                              value!;
                                          BlocProvider.of<
                                                      AnnualPowerShutdownListDetailsCubit>(
                                                  context)
                                              .onCheckBoxChange(state.model);
                                        }),
                                  )
                                ]),

                                if (state.model.extraSecurityDeployed) ...[
                                  ///Vendor Id
                                  CommonWidgets.textDisplay(
                                      state.labels?.locale.vendorId ??
                                          state
                                              .labels?.defaultLocale.vendorId ??
                                          Constants.guardingVendorId,
                                      Styles.textStyleWhite16,
                                      isMandatory: true),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    textInputType: TextInputType.number,
                                    initialValue: state.model.vendorId,
                                    textFormKey: Keys.vendorIdKey,
                                    hintText: '',
                                    isEnable: !disableForm,
                                    isDisableColor: disableForm,
                                    onChange: (String value) {
                                      state.model.vendorId = value;
                                      context
                                          .read<
                                              AnnualPowerShutdownListDetailsCubit>()
                                          .onModelValueChange(state.model);
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),

                                  /// Proposed Vendors
                                  CommonWidgets.textDisplay(
                                    state.labels?.locale.proposedVendors ??
                                        state.labels?.defaultLocale
                                            .proposedVendors ??
                                        Constants.proposedVendors,
                                    Styles.textStyleWhite16,
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),

                                  TextFieldAddButton(
                                    title:
                                    '${!state.model.proposedVendors.isEmptyOrNull ? state.model.proposedVendors?.first.name : ''}',
                                    height: 60,
                                    isDisableColor: disableForm,
                                    onTap: () {
                                      BaseOrganisationDialog().userDialog(
                                        context: context,
                                        entities: state.vendors,
                                        onTap: (Organisation org) {
                                          budgetCostModel.vendorId = org.id;
                                          BlocProvider.of<
                                              AnnualPowerShutdownListDetailsCubit>(
                                              context)
                                              .updateDropdownValues(
                                              vendor: org);

                                          getBudgetCost(budgetCostModel, state);
                                        },
                                        locationId: state.model.location!.id!,
                                      );
                                    },
                                  ),

                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),

                                  ///Guarding Agency POC
                                  CommonWidgets.textDisplay(
                                      state.labels?.locale.guardingVendorPoc ??
                                          state.labels?.defaultLocale
                                              .guardingVendorPoc ??
                                          Constants.guardingAgencyPOC,
                                      Styles.textStyleWhite16,
                                      isMandatory: true),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    textInputType: TextInputType.text,
                                    initialValue: state.model.guardingVendorPoc,
                                    textFormKey: Keys.vendorAgencyPOCKey,
                                    hintText: '',
                                    textCapitalization: false,
                                    isEnable: !disableForm,
                                    isDisableColor: disableForm,
                                    onChange: (String value) {
                                      state.model.guardingVendorPoc = value;
                                      context
                                          .read<
                                              AnnualPowerShutdownListDetailsCubit>()
                                          .onModelValueChange(state.model);
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),


                                  /// Event Protection Guards Info

                                  CommonWidgets.verticalSpacerWidget(height * 0.01),
                                  eventProtectionGuardsInfoTable(state),
                                  CommonWidgets.verticalSpacerWidget(height * 0.02),

                                  /// Guarding Cost (in INR)
                                  CommonWidgets.textDisplay(
                                      state.labels?.locale.budget ??
                                          state.labels?.defaultLocale.budget ??
                                          Constants.budget,
                                      Styles.textStyleWhite16),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    textInputType: TextInputType.number,
                                    controller: budgetController,
                                    // initialValue:
                                    //     '${state.model.budget ?? 022}',
                                    textFormKey: Keys.budgetKey,
                                    hintText: '',
                                    isEnable: false,
                                    isDisableColor: disableForm,
                                    onChange: (double value) {
                                      // state.model.budget = value;
                                      // context
                                      //     .read<
                                      //         AnnualPowerShutdownListDetailsCubit>()
                                      //     .onModelValueChange(state.model);
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                ],
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),


                                /// PO Number
                                CommonWidgets.textDisplay(
                                    // state.labels?.locale.budget ??
                                    //     state.labels?.defaultLocale.epPostApprovalRequested ??
                                        Constants.poNumber,
                                    Styles.textStyleWhite16),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                FlutterInputField(
                                  textInputType: TextInputType.number,
                                  controller: poNumberController,
                                  // initialValue:
                                  //     '${state.model.budget ?? 022}',
                                  textFormKey: Keys.budgetKey,
                                  hintText: '',
                                  isEnable: false,
                                  isDisableColor: disableForm,
                                  onChange: (double value) {
                                    // state.model.budget = value;
                                    // context
                                    //     .read<
                                    //         AnnualPowerShutdownListDetailsCubit>()
                                    //     .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),

                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),
                              ],
                            ),
                          ),
                        ),

                        /// SubmitButton
                        if (state.model.status == 0) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              cancelButtonDisplay(),
                              if (!disableForm) ...[
                                submitButtonDisplay(onTap: () {
                                  FocusScope.of(context).unfocus();
                                  BlocProvider.of<
                                              AnnualPowerShutdownListDetailsCubit>(
                                          context)
                                      .submitForm(isSaveOnly: false);
                                })
                              ],
                            ],
                          ),
                        ],
                        if (state.model.status != 0) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              cancelButtonDisplay(),
                            ],
                          ),
                        ],
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


  Widget eventProtectionGuardsInfoTable(
      AnnualPowerShutdownListDetailsState state) {
    state.model.eventProtectionGuardsInfos ??= [EventProtectionGuardsInfos()];
    final infos = state.model.eventProtectionGuardsInfos!;

    return Opacity(
      opacity: disableForm ? 1 : 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header row
          Row(
            children: [
              Expanded(
                  flex: 3,
                  child: CommonWidgets.textDisplay(
                      Constants.staffCategory, Styles.textStyleWhite16)),
              const SizedBox(width: 8),
              Expanded(
                  flex: 2,
                  child: CommonWidgets.textDisplay(
                      Constants.numberOfStaff, Styles.textStyleWhite16)),
              const SizedBox(width: 8),
              Expanded(
                  flex: 2,
                  child: CommonWidgets.textDisplay(
                      Constants.dutyHours, Styles.textStyleWhite16)),
              const SizedBox(width: 8),
              Expanded(
                  flex: 3,
                  child: CommonWidgets.textDisplay(
                      Constants.budget, Styles.textStyleWhite16)),
              const SizedBox(width: 8), // reserve space to align with "x" column below
            ],
          ),
          // CommonWidgets.verticalSpacerWidget(height * 0.01),

          /// One row per entry
          ...infos.asMap().entries.map((entry) {
            final index = entry.key;
            final info = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: GestureDetector(
                      onTap: disableForm
                          ? null
                          : () => _showStaffCategoryPicker(context, info, state),
                      child: AbsorbPointer(
                        child: FlutterInputField(
                          key: ValueKey('staffCategory_$index'),
                          textInputType: TextInputType.text,
                          initialValue: guardRankDropDownValues
                              .firstWhereOrNull((l) => l.value == '${info.staffCategory}')
                              ?.key ??
                              '',
                          textFormKey: '${Keys.staffCategoryKey}_$index',
                          hintText: Constants.staffCategory,
                          isEnable: !disableForm,
                          isDisableColor: disableForm,
                          onChange: (String value) {},
                          validateTextField: (String? value) {},
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: FlutterInputField(
                      key: ValueKey('staffCount_$index'),
                      textInputType: TextInputType.number,
                      initialValue: info.staffCategoryCount != null
                          ? '${info.staffCategoryCount}'
                          : '',
                      textFormKey: '${Keys.staffCategoryCountKey}_$index',
                      hintText: '',
                      isEnable: !disableForm,
                      isDisableColor: disableForm,
                      onChange: (String value) {
                        info.staffCategoryCount = int.tryParse(value);
                        context
                            .read<AnnualPowerShutdownListDetailsCubit>()
                            .onModelValueChange(state.model);
                      },
                      validateTextField: (String? value) {},
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: FlutterInputField(
                      key: ValueKey('dutyHours_$index'),
                      textInputType: TextInputType.number,
                      initialValue:
                      info.totalDutyHours != null ? '${info.totalDutyHours}' : '',
                      textFormKey: '${Keys.totalDutyHoursKey}_$index',
                      hintText: '',
                      isEnable: !disableForm,
                      isDisableColor: disableForm,
                      onChange: (String value) {
                        info.totalDutyHours = int.tryParse(value);
                        context
                            .read<AnnualPowerShutdownListDetailsCubit>()
                            .onModelValueChange(state.model);
                      },
                      validateTextField: (String? value) {},
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 3,
                    child: FlutterInputField(
                      key: ValueKey('totalCost_$index'),
                      textInputType: TextInputType.number,
                      initialValue: info.totalCost != null ? '${info.totalCost}' : '',
                      textFormKey: '${Keys.totalCostKey}_$index',
                      hintText: '',
                      isEnable: false, // computed/read-only, like the budget field
                      isDisableColor: disableForm,
                      onChange: (String value) {},
                      validateTextField: (String? value) {},
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: disableForm
                        ? null
                        : () {
                      if (infos.length > 1) {
                        infos.removeAt(index);
                      } else {
                        infos[0] = EventProtectionGuardsInfos();
                      }
                      BlocProvider.of<AnnualPowerShutdownListDetailsCubit>(
                          context)
                          .onCheckBoxChange(state.model);
                    },
                    child: SizedBox.fromSize()
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  void _showStaffCategoryPicker(
      BuildContext context,
      EventProtectionGuardsInfos info,
      AnnualPowerShutdownListDetailsState state) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: guardRankDropDownValues.map((label) {
              final bool isSelected =
                  '${info.staffCategory}' == label.value;
              return ListTile(
                title: Text(
                  label.key,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight:
                    isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                tileColor: isSelected ? const Color(0xFF5C6BC0) : null,
                onTap: () {
                  info.staffCategory = int.tryParse(label.value);
                  Navigator.pop(sheetContext);
                  BlocProvider.of<AnnualPowerShutdownListDetailsCubit>(context)
                      .onModelValueChange(state.model);
                },
              );
            }).toList(),
          ),
        );
      },
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

  // Widget cancelButtonDisplay(AnnualPowerShutdownListDetailsState state) {
  //   bool condition = state.model.id == null ||
  //       state.model.status == ConstantsIntValue.cancelledStatus ||
  //       state.model.status == 30 ||
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

  // void updateRecordStatus(AnnualPowerShutdownListDetailsState state) {
  //   if (state.model.id != null) {
  //     BlocProvider.of<AnnualPowerShutdownListDetailsCubit>(context)
  //         .updateStatus(id: state.model.id.toString());
  //     Navigator.popAndPushNamed(context, annualPowerShutdownListRoute);
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

  Widget locationWidgetDisplay(AnnualPowerShutdownListDetailsState state) {
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
              onTap: (Organisation? location) async {
                state.model.location = location;
                budgetCostModel.locationId = location?.id;

                BlocProvider.of<AnnualPowerShutdownListDetailsCubit>(context)
                    .updateLocationDropdownValue(location: location);
              },
            );
          },
        );
        // }
      },
      child: SelectedTileValueWidget(name: state.model.location?.name ?? ''),
    );
  }

  void getBudgetCost(BudgetCostModel budgetCostModel,
      AnnualPowerShutdownListDetailsState state) {
    log('---getBudgetCost---');
    budgetCostModel.locationId = state.model.location?.id;
    if (budgetCostModel.vendorId == null ||
        budgetCostModel.soCount == null ||
        budgetCostModel.soHours == null ||
        budgetCostModel.ssCount == null ||
        budgetCostModel.ssHours == null ||
        budgetCostModel.sgCount == null ||
        budgetCostModel.sgHours == null ||
        budgetCostModel.sfCount == null ||
        budgetCostModel.sfHours == null ||
        budgetCostModel.locationId == null) {
      log('---return---');
      return;
    }
    // Call API
    BlocProvider.of<AnnualPowerShutdownListDetailsCubit>(context)
        .getEpGuardBudgetCost(budgetCostModel);
  }
}
