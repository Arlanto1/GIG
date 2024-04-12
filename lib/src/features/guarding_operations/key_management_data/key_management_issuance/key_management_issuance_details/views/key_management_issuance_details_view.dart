import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_issuance/key_management_issuance_details/cubits/key_management_issuance_details_cubits.dart';

class KeyManagementIssuanceDetailsView extends StatefulWidget {
  final KeyManagementIssuanceModel? model;
  final KeyIssuanceProcessRecord? keyIssuanceProcessModel;
  final String title;
  final bool isMasterKey;

  const KeyManagementIssuanceDetailsView({
    super.key,
    this.model,
    this.keyIssuanceProcessModel,
    required this.title,
    this.isMasterKey = false,
  });

  @override
  State<KeyManagementIssuanceDetailsView> createState() =>
      _SLAViolationViewState();
}

class _SLAViolationViewState extends State<KeyManagementIssuanceDetailsView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController returnableTextController = TextEditingController();
  User? userDetails;
  TextEditingController keyHandedOverDateController = TextEditingController();
  TextEditingController keyReturnDueDateController = TextEditingController();
  TextEditingController employeeTypeController = TextEditingController();
  TextEditingController keyHandlingOverDurationController =
      TextEditingController();
  TextEditingController guardingAgencyPOCController = TextEditingController();
  TextEditingController keyReturnDateAndTimeController =
      TextEditingController();

  bool isReadOnly = false;
  final FocusNode employeeIdFocusNode = FocusNode();

  get model => null;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<KeyManagementIssuanceDetailsCubit>(context)
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
    return BlocConsumer<KeyManagementIssuanceDetailsCubit,
        KeyManagementIssuanceDetailsState>(
      listener: (context, state) {
        log('-state.status---${state.status}----');
        log('-HandOverDuration---${state.model.keyHandingOverDuration}----');
        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: 'Key Management Issuance',
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popAndPushNamed(
                context,
                keyManagementIssuanceListRoute,
              );
            },
          );
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => dialog);
        }
        if (state.status == FormStatus.error) {
          Validator().showToast(
            context,
            state.message ?? 'Invalid Information',
          );
        }
      },
      builder: (context, state) {
        if (state.model.status == -1 ||
            state.model.status == 2 ||
            state.model.status == 3 ||
            state.model.status == 4 ||
            state.model.status == 5 ||
            state.model.status == 6 ||
            state.model.status == 7 ||
            state.model.status == 8 ||
            state.model.status == 9 ||
            state.model.status == 10 ||
            state.model.status == 11) {
          isReadOnly = true;
        }
        if (state.model.status == null || state.model.status == 0) {
          isReadOnly = false;
        }
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.title,
            showPopUp: false,
            showSaveButton: state.model.status == 0 ||
                    state.model.status == 1 ||
                    state.model.status == null
                ? true
                : false,
            showDisLikeButton: false,
            showLikeButton: false,
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<KeyManagementIssuanceDetailsCubit>(context)
                  .submitForm(
                isSaveOnly: true,
                navigateToNextScreen: false,
              );
            },
            showSubmitButton: state.model.status == 0 ||
                    state.model.status == 1 ||
                    state.model.status == null
                ? true
                : false,
            onTapSubmit: () {
              BlocProvider.of<KeyManagementIssuanceDetailsCubit>(context)
                  .submitForm(
                isSaveOnly: false,
                navigateToNextScreen: false,
              );
            },
          ),
          backgroundColor: AppColors.backgroundWhitecolor,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void initializeDates(KeyManagementIssuanceDetailsState state) {
    DateTime dateTime;

    if (state.model.keyHandingOverDuration == 2 && DateTime.now().month < 6) {
      // Set to July 1st of the current year
      dateTime = DateTime(DateTime.now().year, 6, 30);
      keyReturnDueDateController.text = Utils.timestampToDateConversion(
          dateTime.millisecondsSinceEpoch, Constants.fulldateFormat);
    } else if (state.model.keyHandingOverDuration == 2 &&
        DateTime.now().month > 6) {
      // Set to December 31st of the current year
      dateTime = DateTime(DateTime.now().year, 12, 31);
      keyReturnDueDateController.text = Utils.timestampToDateConversion(
          dateTime.millisecondsSinceEpoch, Constants.fulldateFormat);
    } else {
      dateTime = DateTime.fromMillisecondsSinceEpoch(
          DateTime.now().millisecondsSinceEpoch + 24 * 3600 * 1000);
      keyReturnDueDateController.text = Utils.timestampToDateConversion(
          dateTime.millisecondsSinceEpoch, Constants.fulldateFormat);
    }

    state.model.keyHandOverDue =
        Utils().formatTime(keyReturnDueDateController.text);

    if (state.model.keyReturnDateTime != null) {
      keyReturnDateAndTimeController.text = Utils.timestampToDateConversion(
          int.tryParse(state.model.keyReturnDateTime ?? '0'),
          Constants.fulldateFormat);
    }
  }

  getBodybuilder(KeyManagementIssuanceDetailsState state, height) {
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }
    initializeDates(state);

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
                ),
              ),
              child: AbsorbPointer(
                absorbing: isReadOnly,
                child: Form(
                  key: _formKey,
                  autovalidateMode: isReadOnly
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
                          children: [
                            // if (!state.model.lock.isEmptyOrNull) ...[
                            //   RecordLockedWidget(text: '${state.model.lock}'),
                            // ],
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                Constants.generalinformation,
                                style: Styles.styleHeaderGreyText16,
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Created By
                            CommonWidgets.verticalTextHandling(
                                state.labels?.locale.createdBy ??
                                    state.labels?.defaultLocale.createdBy ??
                                    Constants.createdby,
                                isMandatory: true,
                                '${state.model.createdBy?.firstName ?? ''} ${state.model.createdBy?.lastName ?? ''}'),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Status
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
                              initialValue:
                                  getStatusString(state.model.status ?? 0),
                              onChange: (String value) {},
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Date of creation
                            CommonWidgets.textDisplay(
                              state.labels?.locale.createdDate ??
                                  state.labels?.defaultLocale.createdDate ??
                                  Constants.createDate,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            datecreateWidgetdisplay(
                                state.model.createdDate ?? ''),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Location
                            CommonWidgets.textDisplay(
                              state.labels?.locale.location ??
                                  state.labels?.defaultLocale.location ??
                                  Constants.location,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            locationWidgetdislay(state),

                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Sl No.
                            CommonWidgets.horizentaltextHandling(
                              state.labels?.locale.slNo ??
                                  state.labels?.defaultLocale.slNo ??
                                  Constants.slno,
                              state.model.slNo ?? '',
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            if (state.model.status != null &&
                                state.model.status != 0) ...[
                              /// Handed Over Date
                              CommonWidgets.textDisplay(
                                state.labels?.locale.handedOverDate ??
                                    state
                                        .labels?.defaultLocale.handedOverDate ??
                                    Constants.handedOverDate,
                                isMandatory: true,
                                Styles.textStyleBlack14,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              datecreateWidgetdisplay(
                                  state.model.keyHandOverDate ?? ''),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                            ],
                            // BaseDate().datePickerWidgetLoading(
                            //   textController: keyHandedOverDateController,
                            //   isDisabled: true,
                            //   onChange: (String value) {
                            //       state.model.keyHandOverDate =
                            //           Utils().formatTime(value);
                            //       BlocProvider.of<KeyManagementIssuanceDetailsCubit>(
                            //           context)
                            //           .onModelValueChange(state.model);
                            //   },
                            //   context: context,
                            // ),
                            // CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Entity
                            CommonWidgets.textDisplay(
                                state.labels?.locale.entities ??
                                    state.labels?.defaultLocale.entities ??
                                    Constants.entity,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseEntitiesSelection().entityDropDownSelection(
                              context: context,
                              selectedValues: state.model.entities ?? [],
                              all: state.listOfEntities ?? [],
                              enabled: state.model.status == 0 ||
                                  state.model.status == null,
                              onTap: (List<Organisation> selectedEntities) {
                                log('--selectedEntities----${selectedEntities.length}');
                                BlocProvider.of<
                                            KeyManagementIssuanceDetailsCubit>(
                                        context)
                                    .updateDropdownValues(
                                        entities: selectedEntities);
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              orgName: 'ATOM_ENTITIES',
                              functionToCall: () {
                                // refresh the list
                                BlocProvider.of<
                                            KeyManagementIssuanceDetailsCubit>(
                                        context)
                                    .refreshList();
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Department
                            CommonWidgets.textDisplay(
                              state.labels?.locale.department ??
                                  state.labels?.defaultLocale.department ??
                                  Constants.department,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            TextFieldAddButton(
                              title: state.model.department?.name,
                              height: 70,
                              isDisableColor: state.model.status == null ||
                                      state.model.status == 0
                                  ? false
                                  : true,
                              onTap: () {
                                if (state.model.status == 0 ||
                                    state.model.status == null) {
                                  // if (widget.materialMovement != null) {
                                  BaseOrganisationDialog().departmentDialog(
                                      context: context,
                                      organisations: state.departments,
                                      onTap: (Organisation department) {
                                        state.model.department?.name =
                                            department.name;

                                        BlocProvider.of<
                                                    KeyManagementIssuanceDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                                department: department);
                                      },
                                      orgName: 'EMPLOYEE_DEPARTMENTS',
                                      createEntity: false,
                                      title: 'Add Department',
                                      functionToCall: () {
                                        // refresh the list
                                        BlocProvider.of<
                                                    KeyManagementIssuanceDetailsCubit>(
                                                context)
                                            .refreshList();
                                      });
                                }
                                // leodepartmentsDialog(state);
                                // }
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Key Handing Over Duration
                            CommonWidgets.textDisplay(
                                state.labels?.locale.keyHandingOverDuration ??
                                    state.labels?.defaultLocale
                                        .keyHandingOverDuration ??
                                    Constants.keyHandingOverDuration,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDropDown().getDropDown(
                                isDisabled: state.model.status != 0 ||
                                        state.model.status != null
                                    ? true
                                    : false,
                                textController:
                                    keyHandlingOverDurationController,
                                items: keyHandingOverDurationValues,
                                initialValue:
                                    '${state.model.keyHandingOverDuration ?? 1}',
                                onTap: () {
                                  if (state.model.status == 0 ||
                                      state.model.status == null) {
                                    BaseDropDown().assetTypeDialog(
                                        context: context,
                                        dropDownValues:
                                            keyHandingOverDurationValues
                                                .map((label) => label.key)
                                                .toList(),
                                        onTap: (String value) {
                                          Label? selectedLabel;
                                          selectedLabel =
                                              keyHandingOverDurationValues
                                                  .firstWhere(
                                            (label) => label.key == value,
                                            orElse: () =>
                                                const Label(key: '', value: ''),
                                          );
                                          BlocProvider.of<
                                                      KeyManagementIssuanceDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                                  keyHandingOverDuration:
                                                      int.tryParse(
                                                          selectedLabel.value));
                                        });
                                  }
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Key Return Due Date
                            CommonWidgets.textDisplay(
                              state.labels?.locale.keyHandOverDue ??
                                  state.labels?.defaultLocale.keyHandOverDue ??
                                  Constants.keyReturnDueDate,
                              isMandatory: true,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              textController: keyReturnDueDateController,
                              isDisabled:
                                  state.model.keyHandingOverDuration == 2
                                      ? false
                                      : true,
                              onlyDate: false,
                              onChange: (String value) {
                                state.model.keyHandOverDue =
                                    Utils().formatTime(value);

                                BlocProvider.of<
                                            KeyManagementIssuanceDetailsCubit>(
                                        context)
                                    .onModelValueChange(state.model);
                                //},
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Employee Type
                            CommonWidgets.textDisplay(
                                state.labels?.locale.employeeType ??
                                    state.labels?.defaultLocale.employeeType ??
                                    Constants.employeeType,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDropDown().getDropDown(
                                isDisabled: state.model.status != 6,
                                textController: employeeTypeController,
                                items: employeeTypeDropDownValues,
                                initialValue:
                                    state.model.employeeType.toString(),
                                onTap: () {
                                  if (state.model.status == 0 ||
                                      state.model.status == null) {
                                    BaseDropDown().assetTypeDialog(
                                        context: context,
                                        dropDownValues:
                                            employeeTypeDropDownValues
                                                .map((label) => label.key)
                                                .toList(),
                                        onTap: (String value) {
                                          Label? selectedLabel;
                                          selectedLabel =
                                              employeeTypeDropDownValues
                                                  .firstWhere(
                                            (label) => label.key == value,
                                            orElse: () =>
                                                const Label(key: '', value: ''),
                                          );
                                          BlocProvider.of<
                                                      KeyManagementIssuanceDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                                  employeeType: int.tryParse(
                                                      selectedLabel.value));
                                          FocusScope.of(context).requestFocus(
                                              employeeIdFocusNode);
                                        });
                                  }
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Employee Id
                            CommonWidgets.textDisplay(
                                state.labels?.locale.employeeID ??
                                    state.labels?.defaultLocale.employeeID ??
                                    Constants.employeeid,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              textInputType: TextInputType.text,
                              initialValue: state.model.employeeID,
                              textFormKey: Keys.contactNoKey,
                              hintText: '',
                              focusNode: employeeIdFocusNode,
                              isEnable: state.model.status == 0 ||
                                      state.model.status == null
                                  ? true
                                  : false,
                              isDisableColor: state.model.status != 0 ||
                                      state.model.status != null
                                  ? true
                                  : false,
                              onChange: (String value) {
                                state.model.employeeID = value;
                                context
                                    .read<KeyManagementIssuanceDetailsCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                            if (employeeTypeController.text != 'CWR T2') ...[
                              /// Handed Over To
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.handedOverTo ??
                                      state
                                          .labels?.defaultLocale.handedOverTo ??
                                      Constants.handedOverTo,
                                  Styles.textStyleBlack14,
                                  isMandatory: true),
                              TextFieldAddButton(
                                title: state.model.handedOverTo?.name,
                                height: 60,
                                isDisableColor: state.model.status == null ||
                                        state.model.status == 0
                                    ? false
                                    : true,
                                onTap: () {
                                  if (!isReadOnly && state.model.status != 1) {
                                    BaseOrganisationDialog().userDialog(
                                      context: context,
                                      users: state.emailUsers!,
                                      onTap: (BaseUser user) {
                                        BlocProvider.of<
                                                    KeyManagementIssuanceDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                          handedOverTo: user,
                                        );
                                      },
                                      roleName: 'ATOM_STATIC_USER',
                                      functionToCall: () {
                                        // refresh the list
                                        BlocProvider.of<
                                                    KeyManagementIssuanceDetailsCubit>(
                                                context)
                                            .refreshList();
                                      },
                                    );
                                  }
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                            ],
                            if (employeeTypeController.text == 'CWR T2') ...[
                              /// Handed Over To
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.handedOverTo ??
                                      state
                                          .labels?.defaultLocale.handedOverTo ??
                                      Constants.handedOverTo,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                textInputType: TextInputType.text,
                                initialValue: state.model.handedOverToCwrT2,
                                textFormKey: Keys.contactNoKey,
                                hintText: '',
                                // focusNode: employeeIdFocusNode,
                                isEnable: state.model.status == 0 ||
                                        state.model.status == null
                                    ? true
                                    : false,
                                isDisableColor: state.model.status != 0 ||
                                        state.model.status != null
                                    ? true
                                    : false,
                                onChange: (String value) {
                                  state.model.handedOverToCwrT2 = value;
                                  context
                                      .read<KeyManagementIssuanceDetailsCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              ///DB Sponser CWRT2
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.dbSponsorCwrT2 ??
                                      state.labels?.defaultLocale
                                          .dbSponsorCwrT2 ??
                                      Constants.dbSponsorOfCWRT2,
                                  Styles.textStyleBlack14,
                                  isMandatory: true),
                              TextFieldAddButton(
                                title: state.model.dbSponsorCwrT2?.name,
                                height: 60,
                                isDisableColor: state.model.status != 0 &&
                                        state.model.status != null
                                    ? true
                                    : false,
                                onTap: () {
                                  if (state.model.status == 0 ||
                                      state.model.status == null) {
                                    BaseOrganisationDialog().userDialog(
                                      context: context,
                                      enabled: state.model.status == 0 ||
                                          state.model.status == null,
                                      users: state.emailUsers!,
                                      onTap: (BaseUser user) {
                                        BlocProvider.of<
                                                    KeyManagementIssuanceDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                          dbSponsorCwrT2: user,
                                        );
                                      },
                                      roleName: 'ATOM_STATIC_USER',
                                      functionToCall: () {
                                        // refresh the list
                                        BlocProvider.of<
                                                    KeyManagementIssuanceDetailsCubit>(
                                                context)
                                            .refreshList();
                                      },
                                    );
                                  }
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                            ],
                            if (state.model.status != 0 &&
                                state.model.status != null) ...[
                              /// Total Allocated
                              CommonWidgets.horizentaltextHandling(
                                  state.labels?.locale.totalAllocated ??
                                      state.labels?.defaultLocale
                                          .totalAllocated ??
                                      Constants.totalAllocated,
                                  '${state.model.totalAllocated}'),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Returned
                              CommonWidgets.horizentaltextHandling(
                                  state.labels?.locale.returned ??
                                      state.labels?.defaultLocale.returned ??
                                      Constants.returned,
                                  '${state.model.totalReturned ?? 0}'),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Not Returned
                              CommonWidgets.horizentaltextHandling(
                                  state.labels?.locale.notReturned ??
                                      state.labels?.defaultLocale.notReturned ??
                                      Constants.notReturned,
                                  '${state.model.totalNotReturned ?? 0}'),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Lost
                              CommonWidgets.horizentaltextHandling(
                                  state.labels?.locale.lost ??
                                      state.labels?.defaultLocale.lost ??
                                      Constants.lost,
                                  '${state.model.totalLost ?? 0}'),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Damaged
                              CommonWidgets.horizentaltextHandling(
                                  state.labels?.locale.damaged ??
                                      state.labels?.defaultLocale.damaged ??
                                      Constants.damaged,
                                  '${state.model.totalDamage ?? 0}'),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Key Return Date And Time
                              CommonWidgets.textDisplay(
                                state.labels?.locale.keyReturnDateTime ??
                                    state.labels?.defaultLocale
                                        .keyReturnDateTime ??
                                    Constants.keyReturnDateAndTime,
                                isMandatory: true,
                                Styles.textStyleBlack14,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),

                              BaseDate().datePickerWidgetLoading(
                                textController: keyReturnDateAndTimeController,
                                isDisabled: state.model.status != 1,
                                onlyDate: false,
                                showPastDate: false,
                                onChange: (String value) {
                                  state.model.keyReturnDateTime =
                                      Utils().formatTime(value);

                                  BlocProvider.of<
                                              KeyManagementIssuanceDetailsCubit>(
                                          context)
                                      .onModelValueChange(state.model);
                                  //},
                                },
                                context: context,
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Returned By Name
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.returnedByName ??
                                      state.labels?.defaultLocale
                                          .returnedByName ??
                                      Constants.returnedByName,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                textInputType: TextInputType.text,
                                initialValue: state.model.returnedByName,
                                textFormKey: Keys.contactNoKey,
                                hintText: '',
                                // focusNode: employeeIdFocusNode,
                                isEnable:
                                    state.model.status == 1 ? true : false,
                                isDisableColor:
                                    state.model.status != 1 ? false : true,
                                onChange: (String value) {
                                  state.model.returnedByName = value;
                                  context
                                      .read<KeyManagementIssuanceDetailsCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                            ],

                            /// Key Issuance Process
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                Constants.keyIssuanceProcess,
                                style: Styles.styleHeaderGreyText16,
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            GestureDetector(
                              onTap: () async {
                                NavigatorState nav = Navigator.of(context);

                                bool isSaveSuccess = await BlocProvider.of<
                                    KeyManagementIssuanceDetailsCubit>(
                                  context,
                                ).submitForm(
                                  isSaveOnly: true,
                                  navigateToNextScreen: true,
                                );
                                if (!isSaveSuccess) {
                                  return;
                                }

                                // Now, this code will execute only after the completion of submitForm
                                nav.pushNamed(
                                  keyManagementIssuanceProcessRecordsRoute,
                                  arguments: {
                                    ConstantsArgument.title:
                                        Constants.keyIssuanceProcess,
                                    ConstantsArgument.parentId: state.model.id,
                                    ConstantsArgument.parentStatus:
                                        state.model.status,
                                    ConstantsArgument.locationId:
                                        state.model.location?.id,
                                    ConstantsArgument.isMasterKey:
                                        widget.isMasterKey,
                                  },
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SvgPicture.asset(
                                    AppIcon.pluscircle,
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    'Add/View Key Issuance Process(S)',
                                    style: TextStyle(
                                      color: AppColors.navigationSkybluecolor,
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
                      CommonWidgets.verticalSpacerWidget(height * 0.02),
                    ],
                  ),
                ),
              ),
            ),

            /// SubmitButton
            if ((state.model.status == 0 || state.model.status == 1)
                ? true
                : false) ...[
              Container(
                padding: const EdgeInsets.all(5.0),
                decoration: const ShapeDecoration(
                  color: AppColors.backgroundWhitecolor,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(00.0)),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      cancelButtonDisplay(state),
                      submitButtonDisplay()
                    ],
                  ),
                ),
              ),
            ],
            if (state.model.status != 0 &&
                state.model.status != 1 &&
                state.model.status == 11) ...[
              Container(
                padding: const EdgeInsets.all(5.0),
                decoration: const ShapeDecoration(
                  color: AppColors.backgroundWhitecolor,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(00.0)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    cancelButtonDisplay(state),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String getStatusString(int status) {
    switch (status) {
      case -1:
        return 'Cancelled';
      case 0:
        return 'Created';
      case 1:
        return 'Handed Over';
      case 2:
        return 'Not Returned';
      case 3:
        return 'Closed/Damaged';
      case 4:
        return 'Closed/Lost';
      case 5:
        return 'Lost/Not Returned';
      case 6:
        return 'Closed/Lost/Not Returned';
      case 7:
        return 'Closed/Lost/Damaged';
      case 8:
        return 'Lost/Damaged';
      case 9:
        return 'Lost/Damaged/Not Returned';
      case 10:
        return 'Closed/Lost/Damaged/Not Returned';
      case 11:
        return 'Damaged/Not Returned';
      case 12:
        return 'Closed';
      default:
        return '';
    }
  }

  Widget cancelButtonDisplay(KeyManagementIssuanceDetailsState state) {
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

  void updateRecordStatus(KeyManagementIssuanceDetailsState state) {
    if (state.model.id != null) {
      BlocProvider.of<KeyManagementIssuanceDetailsCubit>(context)
          .updateStatus(id: state.model.id.toString());
      Navigator.pop(context);
      Navigator.popAndPushNamed(
        context,
        keyManagementIssuanceListRoute,
      );
    } else {
      Navigator.pop(context);
    }
  }

  Widget submitButtonDisplay() {
    return AppButton(
      width: 150,
      key: const Key(Keys.submitButton),
      buttonText: Constants.submit,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        FocusScope.of(context).unfocus();

        BlocProvider.of<KeyManagementIssuanceDetailsCubit>(context)
            .submitForm();
      },
    );
  }

  Widget locationWidgetdislay(KeyManagementIssuanceDetailsState state) {
    return GestureDetector(
      onTap: () {
        if (state.model.status == 0 || state.model.status == null) {
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              return CustomExpansionListTexts(
                locationList: state.locations,
                onTap: (Organisation? list) async {
                  Organisation location = Organisation();
                  location.id = list?.id;
                  location.name = list?.name;
                  state.model.location = location;

                  BlocProvider.of<KeyManagementIssuanceDetailsCubit>(context)
                      .updateDropdownValues(location: location);
                },
              );
            },
          );
        }
      },
      child: SelectedTileValueWidget(name: state.model.location?.name ?? ''),
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
