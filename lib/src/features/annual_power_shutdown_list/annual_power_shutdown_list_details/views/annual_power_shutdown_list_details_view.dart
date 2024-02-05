import 'dart:developer';

import 'package:db_atom/src/features/annual_power_shutdown_list/annual_power_shutdown_list_details/cubits/annual_power_shutdown_list_details_cubit.dart';
import 'package:db_atom/src/features/annual_power_shutdown_list/models/annual_power_shutdown_list_model.dart';

import '../../../../../index.dart';

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
  bool disableForm = false;

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

        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: Constants.annualPowerShutdownListDetails,
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
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
        if (state.status == FormStatus.error) {
          Validator().showToast(
            context,
            state.message ?? 'Invalid Information',
          );
        }
      },
      builder: (context, state) {
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
      eventStartDateController.text = Utils.timestamptoDateConversion(
          int.tryParse(state.model.eventStartDate ?? '0'),
          Constants.fulldateFormat);
    }
    if (state.model.eventEndDate != null) {
      eventEndDateController.text = Utils.timestamptoDateConversion(
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
                          child: Column(children: [
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
                                // state.labels?.locale.status ??
                                //     state.labels?.defaultLocale.status ??
                                Constants.status,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDropDown().getDropDown(
                                isDisabled: state.model.status != 0,
                                textController: statusController,
                                items: eventProtectionGiStatus,
                                initialValue: '${state.model.status ?? 0}',
                                onTap: () {
                                  if (state.model.id != null) {
                                    BaseDropDown().assetTypeDialog(
                                      context: context,
                                      dropDownValues: eventProtectionGiStatus
                                          .map((label) => label.key)
                                          .toList(),
                                      onTap: (String value) {
                                        Label? selectedLabel;
                                        selectedLabel =
                                            eventProtectionGiStatus.firstWhere(
                                          (label) => label.key == value,
                                          orElse: () =>
                                              const Label(key: '', value: ''),
                                        );
                                        BlocProvider.of<GeneralInfoCubit>(
                                                context)
                                            .updateDropdownValues(
                                                status: int.tryParse(
                                                    selectedLabel.value));
                                      },
                                    );
                                  }
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Location
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.location ??
                                //     state.labels?.defaultLocale.location ??
                                Constants.location,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            locationWidgetdislay(state),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Date of creation
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.inputDate ??
                                //     state.labels?.defaultLocale.inputDate ??
                                Constants.dateofcreation,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDate().creationDateDisplay(
                                state.model.inputDate ?? ''),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Sl No.
                            CommonWidgets.horizentaltextHandling(
                                // state.labels?.locale.slNo ??
                                //     state.labels?.defaultLocale.slNo ??
                                Constants.slno,
                                state.model.slNo ?? '',
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Entity
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.entity ??
                                //     state.labels?.defaultLocale.entity ??
                                Constants.entity,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

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
                                // state.labels?.locale.eventStartDate ??
                                //     state
                                //         .labels?.defaultLocale.eventStartDate ??
                                Constants.eventStartDate,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              textController: eventStartDateController,
                              onlyDate: false,
                              onChange: (String value) {
                                log('---value-$value------');
                                state.model.eventStartDate =
                                    Utils().formatTime(value);
                                log('---value11-${state.model.eventStartDate}------');
                                BlocProvider.of<
                                            AnnualPowerShutdownListDetailsCubit>(
                                        context)
                                    .onModelValueChange(state.model);
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Event End Date
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.eventEndDate ??
                                //     state.labels?.defaultLocale.eventEndDate ??
                                Constants.eventEndDate,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              textController: eventEndDateController,
                              //onlyDate: false,
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
                                // state.labels?.locale.srh1 ??
                                //     state.labels?.defaultLocale.srh1 ??
                                Constants.subRegionalHead1,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            TextfieldAddButton(
                              title: state.model.srh1?.name,
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
                                      subRegionalHead1: user,
                                    );
                                  },
                                );
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Sub Regional Head (SRH) 2
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.srh2 ??
                                //     state.labels?.defaultLocale.srh2 ??
                                Constants.subRegionalHead2,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            TextfieldAddButton(
                              title: state.model.srh2?.name,
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
                                      subRegionalHead2: user,
                                    );
                                  },
                                );
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Location Security  Manager 1
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.lsm1 ??
                                //     state.labels?.defaultLocale.lsm1 ??
                                Constants.locationSecurityManager1,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            TextfieldAddButton(
                              title: state.model.lsm1?.name,
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
                                      locationSecurityManager1: user,
                                    );
                                  },
                                );
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///LSM 1 Contact No
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.lsm1ContactNo ??
                                //     state.labels?.defaultLocale.lsm1ContactNo ??
                                Constants.lsm1ContactNo,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              textInputType: TextInputType.number,
                              initialValue: state.model.lsm1ContactNo,
                              textFormKey: Keys.lsm1ContactNOKey,
                              hintText: '',
                              isEnable: !disableForm,
                              isDisableColor: disableForm,
                              onChange: (String value) {
                                state.model.lsm1ContactNo = value;
                                context
                                    .read<AnnualPowerShutdownListDetailsCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Location Security  Manager 2
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.lsm2 ??
                                //     state.labels?.defaultLocale.lsm2 ??
                                Constants.locationSecurityManager2,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            TextfieldAddButton(
                              title: state.model.lsm2?.name,
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
                                      locationSecurityManager2: user,
                                    );
                                  },
                                );
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///LSM 2 Contact No
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.lsm2ContactNo ??
                                //     state.labels?.defaultLocale.lsm2ContactNo ??
                                Constants.lsm2ContactNo,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              // labelText: Constants.lsm2ContactNo,
                              textInputType: TextInputType.number,
                              initialValue: state.model.lsm2ContactNo,
                              textFormKey: Keys.lsm2ContactNOKey,
                              hintText: '',
                              isEnable: !disableForm,
                              isDisableColor: disableForm,
                              onChange: (String value) {
                                state.model.lsm2ContactNo = value;
                                context
                                    .read<AnnualPowerShutdownListDetailsCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Business POC
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.bu1 ??
                                //     state.labels?.defaultLocale.bu1 ??
                                Constants.businessPoc,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            TextfieldAddButton(
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
                                  },
                                );
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Business POC  Contact No
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.bu1ContactNo ??
                                //     state.labels?.defaultLocale.bu1ContactNo ??
                                Constants.businessPocContactNo,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              textInputType: TextInputType.number,
                              initialValue: state.model.bu1ContactNo,
                              textFormKey: Keys.bu1ContactNOKey,
                              hintText: '',
                              isEnable: !disableForm,
                              isDisableColor: disableForm,
                              onChange: (String value) {
                                state.model.bu1ContactNo = value;
                                context
                                    .read<AnnualPowerShutdownListDetailsCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Business POC Escalation
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.bu2 ??
                                //     state.labels?.defaultLocale.bu2 ??
                                Constants.businessPocEscalation,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            TextfieldAddButton(
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
                                  },
                                );
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Business POC Escalation Contact No
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.bu2ContactNo ??
                                //     state.labels?.defaultLocale.bu2ContactNo ??
                                Constants.businessPocEscalationContactNo,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              textInputType: TextInputType.number,
                              initialValue: state.model.bu2ContactNo,
                              textFormKey: Keys.bu2ContactNOKey,
                              hintText: '',
                              isEnable: !disableForm,
                              isDisableColor: disableForm,
                              onChange: (String value) {
                                state.model.bu2ContactNo = value;
                                context
                                    .read<AnnualPowerShutdownListDetailsCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Business POC Department
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.bu1Dept ??
                                //     state.labels?.defaultLocale.bu1Dept ??
                                Constants.businessPocDepartment,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            TextfieldAddButton(
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
                                    }
                                );
                              },
                            ),

                            ///Business POC Escalation Department
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.bu2Dept ??
                                //     state.labels?.defaultLocale.bu2Dept ??
                                Constants.businessPocEscalationDepartment,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            TextfieldAddButton(
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
                                    }
                                );
                              },
                            ),

                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///System Vendor 1 Email
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.systemVendor1 ??
                                //     state.labels?.defaultLocale
                                //      .systemVendor1 ??
                                Constants.systemVendor1Email,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              textInputType: TextInputType.text,
                              initialValue: state.model.systemVendor1,
                              textFormKey: Keys.systemVendor1EmailKey,
                              hintText: '',
                              isEnable: !disableForm,
                              isDisableColor: disableForm,
                              onChange: (String value) {
                                state.model.systemVendor1 = value;
                                context
                                    .read<AnnualPowerShutdownListDetailsCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Vendor 1 Contact No
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.systemVendor1ContactNo ??
                                //     state.labels?.defaultLocale
                                //     .systemVendor1ContactNo ??
                                Constants.vendor1ContactNO,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              textInputType: TextInputType.number,
                              initialValue: state.model.systemVendor1ContactNo,
                              textFormKey: Keys.vendor1Contact1Key,
                              hintText: '',
                              isEnable: !disableForm,
                              isDisableColor: disableForm,
                              onChange: (String value) {
                                state.model.systemVendor1ContactNo = value;
                                context
                                    .read<AnnualPowerShutdownListDetailsCubit>()
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
                                // state.labels?.locale.systemVendor2 ??
                                //     state.labels?.defaultLocale
                                //         .systemVendor2 ??
                                Constants.systemVendor2Email,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              textInputType: TextInputType.text,
                              initialValue: state.model.systemVendor2,
                              textFormKey: Keys.systemVendor2EmailKey,
                              hintText: '',
                              isEnable: !disableForm,
                              isDisableColor: disableForm,
                              onChange: (String value) {
                                state.model.systemVendor2 = value;
                                context
                                    .read<AnnualPowerShutdownListDetailsCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Vendor 2 Contact No
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.systemVendor2ContactNo ??
                                //     state.labels?.defaultLocale
                                //    .systemVendor2ContactNo ??
                                Constants.vendor2ContactNO,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              textInputType: TextInputType.number,
                              initialValue: state.model.systemVendor2ContactNo,
                              textFormKey: Keys.vendor2ContactKey,
                              hintText: '',
                              isEnable: !disableForm,
                              isDisableColor: disableForm,
                              onChange: (String value) {
                                state.model.systemVendor2ContactNo = value;
                                context
                                    .read<AnnualPowerShutdownListDetailsCubit>()
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
                                // state.labels?.locale.systemVendor3 ??
                                //     state.labels?.defaultLocale
                                //     .systemVendor3 ??
                                Constants.systemVendor3Email,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              textInputType: TextInputType.text,
                              initialValue: state.model.systemVendor3,
                              textFormKey: Keys.systemVendor2EmailKey,
                              hintText: '',
                              isEnable: !disableForm,
                              isDisableColor: disableForm,
                              onChange: (String value) {
                                state.model.systemVendor3 = value;
                                context
                                    .read<AnnualPowerShutdownListDetailsCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Vendor 3 Contact No
                            CommonWidgets.textDisplay(
                                //     state.labels?.locale.systemVendor3ContactNo ??
                                //         state.labels?.defaultLocale
                                //  .systemVendor3ContactNo ??
                                Constants.vendor3ContactNO,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              textInputType: TextInputType.number,
                              initialValue: state.model.systemVendor3ContactNo,
                              textFormKey: Keys.vendor3ContactKey,
                              hintText: '',
                              isEnable: !disableForm,
                              isDisableColor: disableForm,
                              onChange: (String value) {
                                state.model.systemVendor3ContactNo = value;
                                context
                                    .read<AnnualPowerShutdownListDetailsCubit>()
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
                                // state.labels?.locale.requesterDepartment ??
                                //     state.labels?.defaultLocale
                                //  .requesterDepartment ??
                                Constants.requesterDepartment,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            TextfieldAddButton(
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
                                            requesterDepartment: department);
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
                                    }
                                );
                              },
                            ),

                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Is Extra Security Deployment Required
                            Row(children: [
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.extraSecurityDeployed ??
                                //     state.labels?.defaultLocale
                                //      .extraSecurityDeployed ??
                                Constants.isExtraSecurityDeploymentRequired,
                                Styles.textStyleBlack14,
                              ),
                              Checkbox(
                                  activeColor: AppColors.navigationSkybluecolor,
                                  focusColor: AppColors.navigationSkybluecolor,
                                  value: state.model.extraSecurityDeployed,
                                  onChanged: (bool? value) {
                                    state.model.extraSecurityDeployed = value!;
                                    BlocProvider.of<
                                                AnnualPowerShutdownListDetailsCubit>(
                                            context)
                                        .onCheckBoxChange(state.model);
                                  })
                            ]),

                            if (state.model.extraSecurityDeployed) ...[
                              ///Vendor Id
                              CommonWidgets.textDisplay(
                                  // state.labels?.locale.vendorId ??
                                  //     state.labels?.defaultLocale.vendorId ??
                                  Constants.guardingVendorId,
                                  Styles.textStyleBlack14),
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
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              ///Guarding Agency POC
                              CommonWidgets.textDisplay(
                                  // state.labels?.locale.guardingVendorPoc ??
                                  //     state.labels?.defaultLocale
                                  //  .guardingVendorPoc ??
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
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              ///No. Of Security Officers
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.securityOfficerCount ??
                                //     state.labels?.defaultLocale
                                //.securityOfficerCount ??
                                Constants.numOfSecurityOfficers,
                                Styles.textStyleBlack14,
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
                                        int.parse(value);
                                  }
                                  context
                                      .read<
                                          AnnualPowerShutdownListDetailsCubit>()
                                      .onModelValueChange(state.model);
                                },
                                // validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              ///Total Duty Hours
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.securityOfficerCountHrs ??
                                //     state.labels?.defaultLocale
                                // .securityOfficerCountHrs ??
                                Constants.totalDutyHours,
                                Styles.textStyleBlack14,
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
                                        int.parse(value);
                                  }
                                  context
                                      .read<
                                          AnnualPowerShutdownListDetailsCubit>()
                                      .onModelValueChange(state.model);
                                },
                                // validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              ///No. Of Security Supervisors
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.securitySupervisorCount ??
                                //     state.labels?.defaultLocale
                                //.securitySupervisorCount ??
                                Constants.numOfSecuritySupervisor,
                                Styles.textStyleBlack14,
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
                                        int.parse(value);
                                  }
                                  context
                                      .read<
                                          AnnualPowerShutdownListDetailsCubit>()
                                      .onModelValueChange(state.model);
                                },
                                // validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              ///Total Duty Hours
                              CommonWidgets.textDisplay(
                                // state.labels?.locale
                                //     .securitySupervisorCountHrs ??
                                //     state.labels?.defaultLocale
                                //         .securitySupervisorCountHrs ??
                                Constants.totalDutyHours,
                                Styles.textStyleBlack14,
                              ),
                              FlutterInputField(
                                initialValue:
                                    '${state.model.securitySupervisorCountHrs ?? ''}',
                                textFormKey: Keys.noOfSecuritySupervisorsHrsKey,
                                isEnable: !disableForm,
                                isDisableColor: disableForm,
                                hintText: '',
                                onChange: (String? value) {
                                  if (value != null) {
                                    state.model.securitySupervisorCountHrs =
                                        int.parse(value);
                                  }
                                  context
                                      .read<
                                          AnnualPowerShutdownListDetailsCubit>()
                                      .onModelValueChange(state.model);
                                },
                                // validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              ///No. Of Security Guards
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.securityGuardCount ??
                                //     state.labels?.defaultLocale
                                //         .securityGuardCount ??
                                Constants.numOfSecurityGuards,
                                Styles.textStyleBlack14,
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
                                  }
                                  context
                                      .read<
                                          AnnualPowerShutdownListDetailsCubit>()
                                      .onModelValueChange(state.model);
                                },
                                // validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              ///Total Duty Hours
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.securityGuardCountHrs ??
                                //     state.labels?.defaultLocale
                                //         .securityGuardCountHrs ??
                                Constants.totalDutyHours,
                                Styles.textStyleBlack14,
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
                                        int.parse(value);
                                  }
                                  context
                                      .read<
                                          AnnualPowerShutdownListDetailsCubit>()
                                      .onModelValueChange(state.model);
                                },
                                // validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              ///No. Of Security Facilitators
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.securityFacilitatorCount ??
                                //     state.labels?.defaultLocale
                                //         .securityFacilitatorCount ??
                                Constants.numOfSecurityFacilitators,
                                Styles.textStyleBlack14,
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
                                        int.parse(value);
                                  }
                                  context
                                      .read<
                                          AnnualPowerShutdownListDetailsCubit>()
                                      .onModelValueChange(state.model);
                                },
                                // validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              ///Total Duty Hours
                              CommonWidgets.textDisplay(
                                // state.labels?.locale
                                //     .securityFacilitatorCountHrs ??
                                //     state.labels?.defaultLocale
                                //         .securityFacilitatorCountHrs ??
                                Constants.totalDutyHours,
                                Styles.textStyleBlack14,
                              ),
                              FlutterInputField(
                                initialValue:
                                    '${state.model.securityFacilitatorCountHrs ?? ''}',
                                textFormKey: Keys.noOfSecurityFacilitatorHrsKey,
                                isEnable: !disableForm,
                                isDisableColor: disableForm,
                                hintText: '',
                                onChange: (String? value) {
                                  if (value != null) {
                                    state.model.securityFacilitatorCountHrs =
                                        int.parse(value);
                                  }
                                  context
                                      .read<
                                          AnnualPowerShutdownListDetailsCubit>()
                                      .onModelValueChange(state.model);
                                },
                                // validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Proposed Vendors
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.proposedVendors ??
                                //     state.labels?.defaultLocale
                                //         .proposedVendors ??
                                Constants.proposedVendors,
                                Styles.textStyleBlack14,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),

                              BaseEntitiesSelection().entityDropDownSelection(
                                  context: context,
                                  selectedValues:
                                      state.model.proposedVendors ?? [],
                                  all: state.vendors,
                                  enabled: !disableForm,
                                  onTap: (List<Organisation> selectedEntities) {
                                    log('--selectedEntities----${selectedEntities.length}');
                                    BlocProvider.of<
                                                AnnualPowerShutdownListDetailsCubit>(
                                            context)
                                        .updateDropdownValues(
                                            vendors: selectedEntities);
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  }),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              ///Budget Costs
                              CommonWidgets.textDisplay(
                                  // state.labels?.locale.budget ??
                                  //     state.labels?.defaultLocale.budget ??
                                  Constants.budget,
                                  Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                textInputType: TextInputType.number,
                                initialValue: ((state
                                                .model.securityGuardCountHrs
                                                ?.toDouble() ??
                                            0.0) +
                                        (state.model.securitySupervisorCountHrs
                                                ?.toDouble() ??
                                            0.0) +
                                        (state.model.securityOfficerCountHrs
                                                ?.toDouble() ??
                                            0.0) +
                                        (state.model.securityFacilitatorCountHrs
                                                    ?.toDouble() ??
                                                0.0) /
                                            24)
                                    .toStringAsFixed(2),
                                textFormKey: Keys.budgetKey,
                                hintText: '',
                                isEnable: !disableForm,
                                isDisableColor: disableForm,
                                onChange: (double value) {
                                  state.model.budget = value;
                                  context
                                      .read<
                                          AnnualPowerShutdownListDetailsCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                            ],
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                          ]),
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
                                BlocProvider.of<GeneralInfoCubit>(context)
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
              onTap: (Organisation? list) async {
                log('list?.name-----${list?.name}');

                Organisation location = Organisation();
                location.id = list?.id;
                location.name = list?.name;
                state.model.location = location;

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
}
