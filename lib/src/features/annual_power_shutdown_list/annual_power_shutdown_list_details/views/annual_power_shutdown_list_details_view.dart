import 'dart:developer';

import 'package:db_atom/src/features/annual_power_shutdown_list/annual_power_shutdown_list_details/cubits/annual_power_shutdown_list_details_cubit.dart';

import '../../../../../index.dart';
import '../../../../common_widgets/base_widget/basic_widget_functions.dart';

class AnnualPowerShutdownListDetailsView extends StatefulWidget {
  final AnnualPowerShutdownListModel? model;

  const AnnualPowerShutdownListDetailsView({
    this.model,
    super.key,
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

  bool disableForm = false;

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

        if (state.model.status == 6 || !state.model.lock.isEmptyOrNull) {
          disableForm = true;
        }

        if (state.model.status == null) {
          disableForm = false;
        }
        state.model.status ??= 0;
        if (state.model.status! > 0) {
          disableForm = true;
        }
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: Constants.annualPowerShutdownListDetails,
            showPopUp: false,
            showSaveButton: disableForm ? false : true,
            showSubmitButton: disableForm ? false : true,
            showDisLikeButton: false,
            showLikeButton: false,
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
          ),
          backgroundColor: AppColors.backgroundWhitecolor,
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

  getBodybuilder(AnnualPowerShutdownListDetailsState state, height) {
    initializeDates(state);
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
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              BaseDropDown().getDropDown(
                                  isDisabled: true,
                                  textController: statusController,
                                  items: eventProtectionGiStatus,
                                  initialValue: '${state.model.status ?? 0}',
                                  onTap: () {
                                  }),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Created By
                              CommonWidgets.horizentaltextHandling(
                                  state.labels?.locale.entrySecurity ??
                                      state.labels?.defaultLocale
                                          .entrySecurity ??
                                      Constants.createdby,
                                  isMandatory: true,
                                  '${state.model.createdBy?.firstName ?? ''} ${state.model.createdBy?.lastName ?? ''}'),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Location
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.location ??
                                      state.labels?.defaultLocale.location ??
                                      Constants.location,
                                  Styles.textStyleBlack14,
                                  isMandatory: true),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              locationWidgetdislay(state),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Date of creation
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.inputDate ??
                                      state.labels?.defaultLocale.inputDate ??
                                      Constants.dateofcreation,
                                  Styles.textStyleBlack14,
                                  isMandatory: true),
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
                                  state.model.slNo ?? '',
                                  isMandatory: true),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Entity
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.entity ??
                                      state.labels?.defaultLocale.entity ??
                                      Constants.entity,
                                  Styles.textStyleBlack14,
                                  isMandatory: true),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),

                              BaseEntitiesSelection().entityDropDownSelection(
                                  context: context,
                                  selectedValues: state.model.entities ?? [],
                                  all: state.listOfEntities ?? [],
                                  enabled: !disableForm,
                                  onTap: (List<Organisation> selectedEntities) {
                                    log('--selectedEntities----${selectedEntities.length}');
                                    BlocProvider.of<
                                                AnnualPowerShutdownListDetailsCubit>(
                                            context)
                                        .updateDropdownValues(
                                            entities: selectedEntities);
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  }),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Event Start Date
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.eventStartDate ??
                                      state.labels?.defaultLocale
                                          .eventStartDate ??
                                      Constants.eventStartDate,
                                  Styles.textStyleBlack14,
                                  isMandatory: true),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),

                              BaseDate().datePickerWidgetLoading(
                                textController: eventStartDateController,
                                onlyDate: false,
                                showPastDate: false,
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
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Event End Date
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.eventEndDate ??
                                      state
                                          .labels?.defaultLocale.eventEndDate ??
                                      Constants.eventEndDate,
                                  Styles.textStyleBlack14,
                                  isMandatory: true),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),

                              BaseDate().datePickerWidgetLoading(
                                textController: eventEndDateController,
                                //onlyDate: false,
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
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Sub Regional Head (SRH) 1
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.srh1 ??
                                      state.labels?.defaultLocale.srh1 ??
                                      Constants.subRegionalHead1,
                                  Styles.textStyleBlack14,
                                  isMandatory: true),
                              TextFieldAddButton(
                                title: state.model.srh1?.name,
                                height: 60,
                                isDisableColor: disableForm,
                                onTap: () {
                                  BaseOrganisationDialog().userDialog(
                                    context: context,
                                    users: state.srh,
                                    onTap: (BaseUser user) {
                                      BlocProvider.of<
                                                  AnnualPowerShutdownListDetailsCubit>(
                                              context)
                                          .updateDropdownValues(
                                        subRegionalHead1: user,
                                      );
                                    },
                                    roleName: 'ATOM_Sub_Regional_Head',
                                    functionToCall: () {
                                      // refresh the list
                                      BlocProvider.of<
                                                  AnnualPowerShutdownListDetailsCubit>(
                                              context)
                                          .refreshList();
                                    },
                                  );
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Sub Regional Head (SRH) 2
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.srh2 ??
                                      state.labels?.defaultLocale.srh2 ??
                                      Constants.subRegionalHead2,
                                  Styles.textStyleBlack14,
                                  isMandatory: true),
                              TextFieldAddButton(
                                title: state.model.srh2?.name,
                                height: 60,
                                isDisableColor: disableForm,
                                onTap: () {
                                  BaseOrganisationDialog().userDialog(
                                    context: context,
                                    users: state.srh,
                                    onTap: (BaseUser user) {
                                      BlocProvider.of<
                                                  AnnualPowerShutdownListDetailsCubit>(
                                              context)
                                          .updateDropdownValues(
                                        subRegionalHead2: user,
                                      );
                                    },
                                    roleName: 'ATOM_Sub_Regional_Head',
                                    functionToCall: () {
                                      // refresh the list
                                      BlocProvider.of<
                                                  AnnualPowerShutdownListDetailsCubit>(
                                              context)
                                          .refreshList();
                                    },
                                  );
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Location Security  Manager 1
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.lsm1 ??
                                      state.labels?.defaultLocale.lsm1 ??
                                      Constants.locationSecurityManager1,
                                  Styles.textStyleBlack14,
                                  isMandatory: true),
                              TextFieldAddButton(
                                title: state.model.lsm1?.name,
                                height: 60,
                                isDisableColor: disableForm,
                                onTap: () {
                                  BaseOrganisationDialog().userDialog(
                                    context: context,
                                    users: state.lsm,
                                    onTap: (BaseUser user) {
                                      BlocProvider.of<
                                                  AnnualPowerShutdownListDetailsCubit>(
                                              context)
                                          .updateDropdownValues(
                                        locationSecurityManager1: user,
                                      );
                                      FocusScope.of(context)
                                          .requestFocus(lSM1ContactNoFocusNode);
                                    },
                                    roleName: 'ATOM_Senior_Security_Manager',
                                    functionToCall: () {
                                      // refresh the list
                                      BlocProvider.of<
                                                  AnnualPowerShutdownListDetailsCubit>(
                                              context)
                                          .refreshList();
                                    },
                                  );
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              ///LSM 1 Contact No
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.lsm1ContactNo ??
                                      state.labels?.defaultLocale
                                          .lsm1ContactNo ??
                                      Constants.lsm1ContactNo,
                                  Styles.textStyleBlack14,
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
                                isDisableColor: disableForm,
                                onChange: (String value) {
                                  state.model.lsm1ContactNo = value;
                                  context
                                      .read<
                                          AnnualPowerShutdownListDetailsCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Location Security  Manager 2
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.lsm2 ??
                                      state.labels?.defaultLocale.lsm2 ??
                                      Constants.locationSecurityManager2,
                                  Styles.textStyleBlack14,
                                  isMandatory: true),
                              TextFieldAddButton(
                                title: state.model.lsm2?.name,
                                height: 60,
                                isDisableColor: disableForm,
                                onTap: () {
                                  BaseOrganisationDialog().userDialog(
                                    context: context,
                                    users: state.lsm,
                                    onTap: (BaseUser user) {
                                      BlocProvider.of<
                                                  AnnualPowerShutdownListDetailsCubit>(
                                              context)
                                          .updateDropdownValues(
                                        locationSecurityManager2: user,
                                      );
                                      FocusScope.of(context)
                                          .requestFocus(lSM2ContactNoFocusNode);
                                    },
                                    roleName: 'ATOM_Senior_Security_Manager',
                                    functionToCall: () {
                                      // refresh the list
                                      BlocProvider.of<
                                                  AnnualPowerShutdownListDetailsCubit>(
                                              context)
                                          .refreshList();
                                    },
                                  );
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              ///LSM 2 Contact No
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.lsm2ContactNo ??
                                      state.labels?.defaultLocale
                                          .lsm2ContactNo ??
                                      Constants.lsm2ContactNo,
                                  Styles.textStyleBlack14,
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
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              ///Business POC
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.bu1 ??
                                      state.labels?.defaultLocale.bu1 ??
                                      Constants.businessPoc,
                                  Styles.textStyleBlack14,
                                  isMandatory: true),
                              TextFieldAddButton(
                                title: state.model.bu1?.name,
                                height: 60,
                                isDisableColor: disableForm,
                                onTap: () {
                                  BaseOrganisationDialog().userDialog(
                                    context: context,
                                    users: state.emailUsers!,
                                    onTap: (BaseUser user) {
                                      BlocProvider.of<
                                                  AnnualPowerShutdownListDetailsCubit>(
                                              context)
                                          .updateDropdownValues(
                                        bu1: user,
                                      );
                                      FocusScope.of(context)
                                          .requestFocus(pocContactNoFocusNode);
                                    },
                                    roleName: 'ATOM_STATIC_USER',
                                    functionToCall: () {
                                      // refresh the list
                                      BlocProvider.of<
                                                  AnnualPowerShutdownListDetailsCubit>(
                                              context)
                                          .refreshList();
                                    },
                                  );
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              ///Business POC  Contact No
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.bu1ContactNo ??
                                      state
                                          .labels?.defaultLocale.bu1ContactNo ??
                                      Constants.businessPocContactNo,
                                  Styles.textStyleBlack14,
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
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              ///Business POC Escalation
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.bu2 ??
                                      state.labels?.defaultLocale.bu2 ??
                                      Constants.businessPocEscalation,
                                  Styles.textStyleBlack14,
                                  isMandatory: true),
                              TextFieldAddButton(
                                title: state.model.bu2?.name,
                                height: 60,
                                isDisableColor: disableForm,
                                onTap: () {
                                  BaseOrganisationDialog().userDialog(
                                    context: context,
                                    users: state.emailUsers!,
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
                                    roleName: 'ATOM_STATIC_USER',
                                    functionToCall: () {
                                      // refresh the list
                                      BlocProvider.of<
                                                  AnnualPowerShutdownListDetailsCubit>(
                                              context)
                                          .refreshList();
                                    },
                                  );
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              ///Business POC Escalation Contact No
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.bu2ContactNo ??
                                      state
                                          .labels?.defaultLocale.bu2ContactNo ??
                                      Constants.businessPocEscalationContactNo,
                                  Styles.textStyleBlack14,
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
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              ///Business POC Department
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.bu1Dept ??
                                      state.labels?.defaultLocale.bu1Dept ??
                                      Constants.businessPocDepartment,
                                  Styles.textStyleBlack14,
                                  isMandatory: true),
                              TextFieldAddButton(
                                title: state.model.bu1Dept?.name,
                                height: 60,
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

                              /// Business POC Escalation Department
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.bu2Dept ??
                                      state.labels?.defaultLocale.bu2Dept ??
                                      Constants.businessPocEscalationDepartment,
                                  Styles.textStyleBlack14,
                                  isMandatory: true),
                              TextFieldAddButton(
                                title: state.model.bu2Dept?.name,
                                height: 60,
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

                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// System Vendor 1 Email
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.systemVendor1 ??
                                      state.labels?.defaultLocale
                                          .systemVendor1 ??
                                      Constants.systemVendor1Email,
                                  Styles.textStyleBlack14,
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
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Vendor 1 Contact No
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.systemVendor1ContactNo ??
                                      state.labels?.defaultLocale
                                          .systemVendor1ContactNo ??
                                      Constants.vendor1ContactNO,
                                  Styles.textStyleBlack14,
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
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                              //
                              // ///Primary Service Engineer Name
                              // CommonWidgets.horizentaltextHandling(
                              //     Constants.primaryServiceEngineerName,
                              //     state.model.vendor1Primary ?? ''),
                              // CommonWidgets.verticalSpacerWidget(height * 0.01),
                              //
                              // ///Primary Service Engineer Contact
                              // CommonWidgets.horizentaltextHandling(
                              //     Constants.primaryServiceEngineerContact,
                              //     state.model.vendor1PrimaryContact ?? ''),
                              // CommonWidgets.verticalSpacerWidget(height * 0.01),
                              //
                              // ///Secondary Service Engineer Name
                              // CommonWidgets.horizentaltextHandling(
                              //     Constants.secondaryServiceEngineerName,
                              //     state.model.vendor1Secondary ?? ''),
                              // CommonWidgets.verticalSpacerWidget(height * 0.01),
                              //
                              // ///Secondary Service Engineer Contact
                              // CommonWidgets.horizentaltextHandling(
                              //     Constants.secondaryServiceEngineerContact,
                              //     state.model.vendor1SecondaryContact ?? ''),
                              // CommonWidgets.verticalSpacerWidget(height * 0.01),

                              ///System Vendor 2 Email
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.systemVendor2 ??
                                      state.labels?.defaultLocale
                                          .systemVendor2 ??
                                      Constants.systemVendor2Email,
                                  Styles.textStyleBlack14,
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
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              ///Vendor 2 Contact No
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.systemVendor2ContactNo ??
                                      state.labels?.defaultLocale
                                          .systemVendor2ContactNo ??
                                      Constants.vendor2ContactNO,
                                  Styles.textStyleBlack14,
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
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              // ///Primary Service Engineer Contact
                              // CommonWidgets.horizentaltextHandling(
                              //     Constants.primaryServiceEngineerContact,
                              //     state.model.vendor2PrimaryContact ?? ''),
                              // CommonWidgets.verticalSpacerWidget(height * 0.01),
                              //
                              // ///Primary Service Engineer Contact
                              // CommonWidgets.horizentaltextHandling(
                              //     Constants.primaryServiceEngineerContact,
                              //     state.model.vendor2PrimaryContact ?? ''),
                              // CommonWidgets.verticalSpacerWidget(height * 0.01),
                              //
                              // ///Secondary Service Engineer Name
                              // CommonWidgets.horizentaltextHandling(
                              //     Constants.secondaryServiceEngineerName,
                              //     state.model.vendor2Secondary ?? ''),
                              // CommonWidgets.verticalSpacerWidget(height * 0.01),
                              //
                              // ///Secondary Service Engineer Contact
                              // CommonWidgets.horizentaltextHandling(
                              //     Constants.secondaryServiceEngineerContact,
                              //     state.model.vendor2SecondaryContact ?? ''),
                              // CommonWidgets.verticalSpacerWidget(height * 0.01),

                              ///System Vendor 3 Email
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.systemVendor3 ??
                                      state.labels?.defaultLocale
                                          .systemVendor3 ??
                                      Constants.systemVendor3Email,
                                  Styles.textStyleBlack14),
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
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              ///Vendor 3 Contact No
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.systemVendor3ContactNo ??
                                      state.labels?.defaultLocale
                                          .systemVendor3ContactNo ??
                                      Constants.vendor3ContactNO,
                                  Styles.textStyleBlack14),
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
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              // ///Primary Service Engineer Contact
                              // CommonWidgets.horizentaltextHandling(
                              //     Constants.primaryServiceEngineerContact,
                              //     state.model.vendor3PrimaryContact ?? ''),
                              // CommonWidgets.verticalSpacerWidget(height * 0.01),
                              //
                              // ///Primary Service Engineer Contact
                              // CommonWidgets.horizentaltextHandling(
                              //     Constants.primaryServiceEngineerContact,
                              //     state.model.vendor3PrimaryContact ?? ''),
                              // CommonWidgets.verticalSpacerWidget(height * 0.01),
                              //
                              // ///Secondary Service Engineer Name
                              // CommonWidgets.horizentaltextHandling(
                              //     Constants.secondaryServiceEngineerName,
                              //     state.model.vendor3Secondary ?? ''),
                              // CommonWidgets.verticalSpacerWidget(height * 0.01),
                              //
                              // ///Secondary Service Engineer Contact
                              // CommonWidgets.horizentaltextHandling(
                              //     Constants.secondaryServiceEngineerContact,
                              //     state.model.vendor3SecondaryContact ?? ''),
                              // CommonWidgets.verticalSpacerWidget(height * 0.01),

                              ///Requester Department
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.requesterDepartment ??
                                      state.labels?.defaultLocale
                                          .requesterDepartment ??
                                      Constants.requesterDepartment,
                                  Styles.textStyleBlack14,
                                  isMandatory: true),
                              TextFieldAddButton(
                                title: state.model.requesterDepartment?.name,
                                height: 60,
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

                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              ///Event Protection Officer
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.epOfficers ??
                                      state.labels?.defaultLocale.epOfficers ??
                                      Constants.eventProtectionOfficers,
                                  Styles.textStyleBlack14,
                                  isMandatory: true),
                              //if (!disableForm) ...[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ...state.model.epOfficers
                                          ?.asMap()
                                          .entries
                                          .map((entry) {
                                        final index = entry.key;
                                        final officer = entry.value;
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                                    color: Colors
                                                        .black, // Set color as per your design
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
                                              .onCheckBoxChange(state.model);
                                        },
                                      );
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        const SizedBox(width: 14),
                                        SvgPicture.asset(
                                          AppIcon.pluscircle,
                                        ),
                                        const SizedBox(width: 10),
                                        const Text(
                                          'Add Officer',
                                          style: TextStyle(
                                            color: AppColors
                                                .navigationSkybluecolor,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              //],

                              // CommonWidgets.verticalSpacerWidget(height * 0.01),
                              // /// Event Protection Officer
                              // CommonWidgets.textDisplay(
                              //   Constants.eventProtectionOfficers,
                              //   Styles.textStyleBlack14,
                              //   isMandatory: true,
                              // ),
                              // if (!disableForm) ...[
                              //   Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       ...state.model.epOfficers
                              //               ?.asMap()
                              //               .entries
                              //               .map((entry) {
                              //             final index = entry.key;
                              //             final officer = entry.value;
                              //             return Row(
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment.spaceBetween,
                              //               children: <Widget>[
                              //                 Row(
                              //                   children: <Widget>[
                              //                     const SizedBox(width: 10),
                              //                     BasicWidgetFunctions()
                              //                         .getStringText(
                              //                       strings: [officer],
                              //                     ),
                              //                   ],
                              //                 ),
                              //                 GestureDetector(
                              //                   onTap: () {
                              //                     // Remove the officer from the list
                              //                     state.model.epOfficers
                              //                         ?.removeAt(index);
                              //                     // Trigger UI update
                              //                     BlocProvider.of<
                              //                                 AnnualPowerShutdownListDetailsCubit>(
                              //                             context)
                              //                         .onCheckBoxChange(
                              //                             state.model);
                              //                   },
                              //                   child: const Row(
                              //                     children: <Widget>[
                              //                       SizedBox(width: 10),
                              //                       Icon(Icons.close),
                              //                       SizedBox(width: 14),
                              //                     ],
                              //                   ),
                              //                 ),
                              //               ],
                              //             );
                              //           }).toList() ??
                              //           [],
                              //       GestureDetector(
                              //         onTap: () {
                              //           BaseOrganisationDialog().userDialog(
                              //             context: context,
                              //             enabled: !disableForm,
                              //             users: state.emailUsers!,
                              //             onTap: (BaseUser user) {
                              //               state.model.epOfficers ??= [];
                              //
                              //               if (state.model.epOfficers!
                              //                   .contains(user.email!)) {
                              //                 ScaffoldMessenger.of(context)
                              //                     .showSnackBar(
                              //                   const SnackBar(
                              //                     content: Text(
                              //                         'Officer already added! Please add another officer.'),
                              //                   ),
                              //                 );
                              //                 return;
                              //               }
                              //
                              //               state.model.epOfficers
                              //                   ?.add(user.email ?? '');
                              //               log('--eventProtectionGi--22-${state.model.epOfficers}-');
                              //
                              //               BlocProvider.of<
                              //                           AnnualPowerShutdownListDetailsCubit>(
                              //                       context)
                              //                   .onCheckBoxChange(state.model);
                              //             },
                              //           );
                              //         },
                              //         child: Row(
                              //           children: <Widget>[
                              //             const SizedBox(width: 14),
                              //             SvgPicture.asset(
                              //               AppIcon.pluscircle,
                              //             ),
                              //             const SizedBox(width: 10),
                              //             const Text(
                              //               'Add Officer',
                              //               style: TextStyle(
                              //                 color: AppColors
                              //                     .navigationSkybluecolor,
                              //                 decoration:
                              //                     TextDecoration.underline,
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ],
                              //
                              // CommonWidgets.verticalSpacerWidget(height * 0.01),

                              ///Is Extra Security Deployment Required
                              Row(children: [
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.extraSecurityDeployed ??
                                      state.labels?.defaultLocale
                                          .extraSecurityDeployed ??
                                      Constants
                                          .isExtraSecurityDeploymentRequired,
                                  Styles.textStyleBlack14,
                                ),
                                Checkbox(
                                    activeColor:
                                        AppColors.navigationSkybluecolor,
                                    focusColor:
                                        AppColors.navigationSkybluecolor,
                                    value: state.model.extraSecurityDeployed,
                                    onChanged: (bool? value) {
                                      state.model.extraSecurityDeployed =
                                          value!;
                                      BlocProvider.of<
                                                  AnnualPowerShutdownListDetailsCubit>(
                                              context)
                                          .onCheckBoxChange(state.model);
                                    })
                              ]),

                              if (state.model.extraSecurityDeployed) ...[
                                ///Vendor Id
                                CommonWidgets.textDisplay(
                                    state.labels?.locale.vendorId ??
                                        state.labels?.defaultLocale.vendorId ??
                                        Constants.guardingVendorId,
                                    Styles.textStyleBlack14,
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

                                ///Guarding Agency POC
                                CommonWidgets.textDisplay(
                                    state.labels?.locale.guardingVendorPoc ??
                                        state.labels?.defaultLocale
                                            .guardingVendorPoc ??
                                        Constants.guardingAgencyPOC,
                                    Styles.textStyleBlack14,
                                    isMandatory: true),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                FlutterInputField(
                                  textInputType: TextInputType.text,
                                  initialValue: state.model.guardingVendorPoc,
                                  textFormKey: Keys.vendorAgencyPOCKey,
                                  hintText: '',
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

                                /// No. Of Security Officers
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.securityOfficerCount ??
                                      state.labels?.defaultLocale
                                          .securityOfficerCount ??
                                      Constants.numOfSecurityOfficers,
                                  Styles.textStyleBlack14,
                                  isMandatory: true,
                                ),
                                FlutterInputField(
                                  initialValue:
                                      '${state.model.securityOfficerCount ?? ''}',
                                  textFormKey: Keys.noOfSecurityOfficersKey,
                                  isEnable: !disableForm,
                                  isDisableColor: disableForm,
                                  hintText: '',
                                  onChange: (String? value) {
                                    if (value != null) {
                                      state.model.securityOfficerCount =
                                          int.tryParse(value);
                                      budgetCostModel.soCount =
                                          int.tryParse(value);
                                      getBudgetCost(budgetCostModel, state);
                                    }
                                    context
                                        .read<
                                            AnnualPowerShutdownListDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  // validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Total Duty Hours
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.securityOfficerCountHrs ??
                                      state.labels?.defaultLocale
                                          .securityOfficerCountHrs ??
                                      Constants.totalDutyHours,
                                  Styles.textStyleBlack14,
                                  isMandatory: true,
                                ),
                                FlutterInputField(
                                  initialValue:
                                      '${state.model.securityOfficerCountHrs ?? ''}',
                                  textFormKey: Keys.noOfSecurityOfficersHrsKey,
                                  isEnable: !disableForm,
                                  isDisableColor: disableForm,
                                  hintText: '',
                                  onChange: (String? value) {
                                    if (value != null) {
                                      state.model.securityOfficerCountHrs =
                                          int.tryParse(value);
                                      budgetCostModel.soHours =
                                          int.tryParse(value);
                                      getBudgetCost(budgetCostModel, state);
                                    }
                                    context
                                        .read<
                                            AnnualPowerShutdownListDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  // validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// No. Of Security Supervisors
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.securitySupervisorCount ??
                                      state.labels?.defaultLocale
                                          .securitySupervisorCount ??
                                      Constants.numOfSecuritySupervisor,
                                  Styles.textStyleBlack14,
                                  isMandatory: true,
                                ),
                                FlutterInputField(
                                  initialValue:
                                      '${state.model.securitySupervisorCount ?? ''}',
                                  textFormKey: Keys.noOfSecuritySupervisorsKey,
                                  isEnable: !disableForm,
                                  isDisableColor: disableForm,
                                  hintText: '',
                                  onChange: (String? value) {
                                    if (value != null) {
                                      state.model.securitySupervisorCount =
                                          int.tryParse(value);
                                      budgetCostModel.ssCount =
                                          int.tryParse(value);
                                      getBudgetCost(budgetCostModel, state);
                                    }
                                    context
                                        .read<
                                            AnnualPowerShutdownListDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  // validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                ///Total Duty Hours
                                CommonWidgets.textDisplay(
                                  state.labels?.locale
                                          .securitySupervisorCountHrs ??
                                      state.labels?.defaultLocale
                                          .securitySupervisorCountHrs ??
                                      Constants.totalDutyHours,
                                  Styles.textStyleBlack14,
                                  isMandatory: true,
                                ),
                                FlutterInputField(
                                  initialValue:
                                      '${state.model.securitySupervisorCountHrs ?? ''}',
                                  textFormKey:
                                      Keys.noOfSecuritySupervisorsHrsKey,
                                  isEnable: !disableForm,
                                  isDisableColor: disableForm,
                                  hintText: '',
                                  onChange: (String? value) {
                                    if (value != null) {
                                      state.model.securitySupervisorCountHrs =
                                          int.tryParse(value);
                                      budgetCostModel.ssHours =
                                          int.tryParse(value);
                                      getBudgetCost(budgetCostModel, state);
                                    }
                                    context
                                        .read<
                                            AnnualPowerShutdownListDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  // validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// No. Of Security Guards
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.securityGuardCount ??
                                      state.labels?.defaultLocale
                                          .securityGuardCount ??
                                      Constants.numOfSecurityGuards,
                                  Styles.textStyleBlack14,
                                  isMandatory: true,
                                ),
                                FlutterInputField(
                                    initialValue:
                                        '${state.model.securityGuardCount ?? ''}',
                                    textFormKey: Keys.noOfSecurityGuardsKey,
                                    isEnable: !disableForm,
                                    isDisableColor: disableForm,
                                    hintText: '',
                                    onChange: (String? value) {
                                      if (value != null) {
                                        state.model.securityGuardCount =
                                            int.parse(value);
                                        budgetCostModel.sgCount =
                                            int.tryParse(value);
                                        getBudgetCost(budgetCostModel, state);
                                        context
                                            .read<
                                                AnnualPowerShutdownListDetailsCubit>()
                                            .onModelValueChange(state.model);
                                      }
                                    }
                                    // validateTextField: (String? user) {},
                                    ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Total Duty Hours
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.securityGuardCountHrs ??
                                      state.labels?.defaultLocale
                                          .securityGuardCountHrs ??
                                      Constants.totalDutyHours,
                                  Styles.textStyleBlack14,
                                  isMandatory: true,
                                ),
                                FlutterInputField(
                                  initialValue:
                                      '${state.model.securityGuardCountHrs ?? ''}',
                                  textFormKey: Keys.noOfSecurityGuardsHrsKey,
                                  isEnable: !disableForm,
                                  isDisableColor: disableForm,
                                  hintText: '',
                                  onChange: (String? value) {
                                    if (value != null) {
                                      state.model.securityGuardCountHrs =
                                          int.tryParse(value);
                                      budgetCostModel.sgHours =
                                          int.tryParse(value);
                                      getBudgetCost(budgetCostModel, state);
                                    }
                                    context
                                        .read<
                                            AnnualPowerShutdownListDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  // validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// No. Of Security Facilitators
                                CommonWidgets.textDisplay(
                                  state.labels?.locale
                                          .securityFacilitatorCount ??
                                      state.labels?.defaultLocale
                                          .securityFacilitatorCount ??
                                      Constants.numOfSecurityFacilitators,
                                  Styles.textStyleBlack14,
                                  isMandatory: true,
                                ),
                                FlutterInputField(
                                  initialValue:
                                      '${state.model.securityFacilitatorCount ?? ''}',
                                  textFormKey: Keys.noOfSecurityGuardsKey,
                                  isEnable: !disableForm,
                                  isDisableColor: disableForm,
                                  hintText: '',
                                  onChange: (String? value) {
                                    if (value != null) {
                                      state.model.securityFacilitatorCount =
                                          int.tryParse(value);
                                      budgetCostModel.sfCount =
                                          int.tryParse(value);
                                      getBudgetCost(budgetCostModel, state);
                                    }
                                    context
                                        .read<
                                            AnnualPowerShutdownListDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  // validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Total Duty Hours
                                CommonWidgets.textDisplay(
                                  state.labels?.locale
                                          .securityFacilitatorCountHrs ??
                                      state.labels?.defaultLocale
                                          .securityFacilitatorCountHrs ??
                                      Constants.totalDutyHours,
                                  Styles.textStyleBlack14,
                                  isMandatory: true,
                                ),
                                FlutterInputField(
                                  initialValue:
                                      '${state.model.securityFacilitatorCountHrs ?? ''}',
                                  textFormKey:
                                      Keys.noOfSecurityFacilitatorHrsKey,
                                  isEnable: !disableForm,
                                  isDisableColor: disableForm,
                                  hintText: '',
                                  onChange: (String? value) {
                                    if (value != null) {
                                      state.model.securityFacilitatorCountHrs =
                                          int.tryParse(value);
                                      budgetCostModel.sfHours =
                                          int.tryParse(value);
                                      getBudgetCost(budgetCostModel, state);
                                    }
                                    context
                                        .read<
                                            AnnualPowerShutdownListDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  // validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Proposed Vendors
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.proposedVendors ??
                                      state.labels?.defaultLocale
                                          .proposedVendors ??
                                      Constants.proposedVendors,
                                  Styles.textStyleBlack14,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),

                                TextFieldAddButton(
                                  title:
                                      '${!state.model.proposedVendors.isEmptyOrNull ? state.model.proposedVendors?.first.name : ''}',
                                  height: 60,
                                  isDisableColor: false,
                                  onTap: () {
                                    BaseOrganisationDialog().userDialog(
                                      context: context,
                                      entities: state.vendors,
                                      onTap: (Organisation org) {
                                        budgetCostModel.vendorId = org.id;
                                        BlocProvider.of<
                                                    AnnualPowerShutdownListDetailsCubit>(
                                                context)
                                            .updateDropdownValues(vendor: org);

                                        getBudgetCost(budgetCostModel, state);
                                      },
                                    );
                                  },
                                ),

                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Budget Costs
                                CommonWidgets.textDisplay(
                                    state.labels?.locale.budget ??
                                        state.labels?.defaultLocale.budget ??
                                        Constants.budget,
                                    Styles.textStyleBlack14),
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
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                            ],
                          ),
                        ),
                      ),

                      /// SubmitButton
                      if (state.model.status == 0) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            cancelButtonDisplay(state),
                            //if (!disableForm) ...[
                            submitButtonDisplay(onTap: () {
                              FocusScope.of(context).unfocus();
                              BlocProvider.of<
                                          AnnualPowerShutdownListDetailsCubit>(
                                      context)
                                  .submitForm(isSaveOnly: false);
                            })
                            // ],
                          ],
                        ),
                      ],
                      if (state.model.status != 0) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            cancelButtonDisplay(state),
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
    );
  }

  Widget cancelButtonDisplay(AnnualPowerShutdownListDetailsState state) {
    return AppButton(
      // Customize the button properties as needed
      width: 150,
      backgroundColor: Colors.white,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.cancel,
      buttonTextKey: Keys.cancelButton,
      onTap: () {
        updateRecordStatus(state);
      },
    );
  }

  void updateRecordStatus(AnnualPowerShutdownListDetailsState state) {
    if (state.model.id != null) {
      BlocProvider.of<AnnualPowerShutdownListDetailsCubit>(context)
          .updateStatus(id: state.model.id.toString());
      Navigator.popAndPushNamed(context, annualPowerShutdownListRoute);
    } else {
      Navigator.pop(context);
    }
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

  Widget locationWidgetdislay(AnnualPowerShutdownListDetailsState state) {
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
