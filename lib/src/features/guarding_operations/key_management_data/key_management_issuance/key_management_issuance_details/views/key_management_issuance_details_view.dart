import 'dart:convert';
import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_issuance/key_management_issuance_details/cubits/key_management_issuance_details_cubits.dart';
import 'package:intl/intl.dart';

class KeyManagementIssuanceDetailsView extends StatefulWidget {
  final KeyManagementIssuanceModel? model;
  final KeyIssuanceProcessRecord? keyIssuanceProcessModel;
  final String title;
  final bool isMasterKey;
  final ExtraProperties? extraProperties;

  const KeyManagementIssuanceDetailsView({
    super.key,
    this.model,
    this.keyIssuanceProcessModel,
    required this.title,
    this.isMasterKey = false,
    this.extraProperties,
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
  SignatureController receiverSignatureController = SignatureController();
  SignatureController securitySignatureController = SignatureController();

  bool isReadOnly = false;
  bool showSaveSubmitButton = false;
  bool isEnabled = false;
  bool isNotReturnableStatus = false;

  final FocusNode employeeIdFocusNode = FocusNode();

  get model => null;
  String? initialisedFromDate;
  String? initialisedToDate;
  String? initialisedStartDate;

  @override
  void initState() {
    super.initState();
    receiverSignatureController = SignatureController(
        penStrokeWidth: 2,
        penColor: Colors.black,
        exportBackgroundColor: Colors.white);

    securitySignatureController = SignatureController(
        penStrokeWidth: 2,
        penColor: Colors.black,
        exportBackgroundColor: Colors.white);
    BlocProvider.of<KeyManagementIssuanceDetailsCubit>(context)
        .initializeValues();
    // initializeDates(state);
  }

  @override
  void dispose() {
    super.dispose();
    receiverSignatureController.dispose();
    securitySignatureController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    double height = size.height;
    return BlocConsumer<KeyManagementIssuanceDetailsCubit,
        KeyManagementIssuanceDetailsState>(
      listener: (context, state) {
        log('-state.status---${state.status}----');
        log('-HandOverDuration---${state.model.keyHandingOverDuration}----');
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);
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
      },
      builder: (context, state) {
        if (state.model.status == -1 ||
            state.model.status == 3 ||
            state.model.status == 4 ||
            state.model.status == 7 ||
            state.model.status == 8) {
          isReadOnly = true;
        }

        // if (widget.extraProperties != null &&
        //     !widget.extraProperties!.hasWritePermission!) {
        //   isReadOnly = true;
        // }
        if (state.model.status == null) {
          isReadOnly = false;
        }
        if (widget.model == null) {
          isReadOnly = false;
        }
        if (state.model.status == 0 || state.model.lock.isEmptyOrNull) {
          isReadOnly = false;
        }
        if (state.model.status == 1 || state.model.lock.isEmptyOrNull) {
          isReadOnly = false;
        }
        if (state.model.status == 2 || state.model.lock.isEmptyOrNull) {
          isReadOnly = false;
        }

        isNotReturnableStatus = state.model.status ==
            ConstantsIntValue.issuanceNotReturnedStatus ||
            state.model.status ==
                ConstantsIntValue.issuanceLostNotReturnedStatus ||
            state.model.status ==
                ConstantsIntValue.issuanceClosedLostNotReturnedStatus ||
            state.model.status ==
                ConstantsIntValue.issuanceLostDamagedNotReturnedStatus ||
            state.model.status ==
                ConstantsIntValue.issuanceClosedLostDamagedNotReturnedStatus ||
            state.model.status ==
                ConstantsIntValue.issuanceDamagedNotReturnedStatus;

        if (isNotReturnableStatus == true || state.model.lock.isEmptyOrNull) {
          isReadOnly = false;
        }

        showSaveSubmitButton = (state.model.status == 0 ||
            state.model.status == 1 ||
            state.model.status == 2 ||
            isNotReturnableStatus ||
            state.model.status == null) &&
            !isReadOnly &&
            state.model.lock.isEmptyOrNull;

        isEnabled = (state.model.status == 0 || state.model.status == null) &&
            state.model.lock.isEmptyOrNull;

        if (!state.model.lock.isEmptyOrNull) {
          isReadOnly = true;
          isEnabled = false;
        }
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.title,
            showPopUp: false,
            showSaveButton: false,
            showDisLikeButton: false,
            showLikeButton: false,
            pdfAPIName:
            '${CommonApis.exportDetailPagePDF}${state.model
                .id}&moduleCode=${Constants.keyManagementIssuanceModule}',
            // onTapSave: () {
            //   FocusScope.of(context).unfocus();
            //   BlocProvider.of<KeyManagementIssuanceDetailsCubit>(context)
            //       .submitForm(
            //     isSaveOnly: true,
            //     navigateToNextScreen: false,
            // receiverSignatureController: receiverSignatureController,
            // securitySignatureController: securitySignatureController,
            //   );
            // },
            showSubmitButton: showSaveSubmitButton ? true : false,
            onTapSubmit: () {
              BlocProvider.of<KeyManagementIssuanceDetailsCubit>(context)
                  .submitForm(
                isSaveOnly: false,
                navigateToNextScreen: false,
                receiverSignatureController: receiverSignatureController,
                securitySignatureController: securitySignatureController,
              );
            },
          ),
          backgroundColor: AppColors.backgroundWhiteColor,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  bool isDateSelectedByUser = false;

  // void initializeDates(KeyManagementIssuanceDetailsState state) {
  //   DateTime dateTime;
  //   DateFormat dateFormat = DateFormat("dd/MM/yyyy HH:mm:ss");
  //   DateTime keyHandOverDateTime =
  //       dateFormat.parse(state.model.keyHandOverDate.toString());
  //   int keyHandOverTimestamp = keyHandOverDateTime.millisecondsSinceEpoch;
  //   initialisedFromDate =
  //       DateTime.fromMillisecondsSinceEpoch(keyHandOverTimestamp).toString();
  //   // Logging the results
  //   log('initialisedFromDate--- $initialisedFromDate');
  //   log('keyHandOverTimestamp--- $keyHandOverTimestamp');
  //
  //   if (state.model.keyHandOverDue.isEmptyOrNull) {
  //     if (!isDateSelectedByUser) {
  //       log('state.model.keyHandOverDue----${state.model.keyHandOverDue}');
  //       if (state.model.keyHandingOverDuration == 1 && !isDateSelectedByUser) {
  //         dateTime = DateTime.fromMillisecondsSinceEpoch(
  //             DateTime.now().millisecondsSinceEpoch + 24 * 3600 * 1000);
  //         keyReturnDueDateController.text = Utils.timestampToDateConversion(
  //             dateTime.millisecondsSinceEpoch, Constants.fulldateFormat);
  //       } else if (state.model.keyHandingOverDuration == 2 &&
  //           !isDateSelectedByUser) {
  //         if (DateTime.now().month < 6) {
  //           // Set to June 30th of the current year
  //           dateTime = DateTime(DateTime.now().year, 6, 30);
  //         } else {
  //           // Set to December 31st of the current year
  //           dateTime = DateTime(DateTime.now().year, 12, 31);
  //         }
  //         keyReturnDueDateController.text = Utils.timestampToDateConversion(
  //             dateTime.millisecondsSinceEpoch, Constants.fulldateFormat);
  //       } else if (state.model.keyHandingOverDuration == 1 &&
  //           !isDateSelectedByUser) {
  //         dateTime = DateTime.fromMillisecondsSinceEpoch(
  //             DateTime.now().millisecondsSinceEpoch + 24 * 3600 * 1000);
  //         keyReturnDueDateController.text = Utils.timestampToDateConversion(
  //             dateTime.millisecondsSinceEpoch, Constants.fulldateFormat);
  //       } else {
  //         dateTime = DateTime.fromMillisecondsSinceEpoch(
  //             DateTime.now().millisecondsSinceEpoch + 24 * 3600 * 1000);
  //         keyReturnDueDateController.text = Utils.timestampToDateConversion(
  //             dateTime.millisecondsSinceEpoch, Constants.fulldateFormat);
  //       }
  //       //
  //       // state.model.keyHandOverDue =
  //       //     Utils().formatTime(keyReturnDueDateController.text);
  //     }
  //   } else if (state.model.keyHandingOverDuration == 1 &&
  //       !isDateSelectedByUser) {
  //     dateTime = DateTime.fromMillisecondsSinceEpoch(
  //         DateTime.now().millisecondsSinceEpoch + 24 * 3600 * 1000);
  //     keyReturnDueDateController.text = Utils.timestampToDateConversion(
  //         dateTime.millisecondsSinceEpoch, Constants.fulldateFormat);
  //   } else {
  //     keyReturnDueDateController.text = Utils.timestampToDateConversion(
  //         int.tryParse(state.model.keyHandOverDue ?? '0'),
  //         Constants.fulldateFormat);
  //   }
  //
  //   if (state.model.keyReturnDateTime != null) {
  //     keyReturnDateAndTimeController.text = Utils.timestampToDateConversion(
  //         int.tryParse(state.model.keyReturnDateTime ?? '0'),
  //         Constants.fulldateFormat);
  //   }
  // }
  void initializeDates(KeyManagementIssuanceDetailsState state) {
    DateTime dateTime;

    String keyHandOverDateString = state.model.keyHandOverDate.toString();

// Check if the input is a timestamp (numeric) or a formatted date string
    if (RegExp(r'^\d+$').hasMatch(keyHandOverDateString)) {
      int keyHandOverTimestamp = int.parse(keyHandOverDateString);
      DateTime keyHandOverDateTime =
      DateTime.fromMillisecondsSinceEpoch(keyHandOverTimestamp * 1000);

      DateFormat dateFormat = DateFormat("dd/MM/yyyy HH:mm:ss");
      initialisedFromDate = dateFormat.format(keyHandOverDateTime);
    } else {
      DateFormat dateFormat = DateFormat("dd/MM/yyyy HH:mm:ss");
      DateTime keyHandOverDateTime = dateFormat.parse(keyHandOverDateString);

      int keyHandOverTimestamp = keyHandOverDateTime.millisecondsSinceEpoch;
      initialisedFromDate =
          keyHandOverDateTime.toString(); // Or format to a string if needed
      // Logging the results
      log('initialisedFromDate--- $initialisedFromDate');
      log('keyHandOverTimestamp--- $keyHandOverTimestamp');
    }

    if (state.model.keyHandOverDue.isEmptyOrNull) {
      if (!isDateSelectedByUser) {
        log('state.model.keyHandOverDue----${state.model.keyHandOverDue}');
        if (state.model.keyHandingOverDuration == 1 && !isDateSelectedByUser) {
          dateTime = DateTime.fromMillisecondsSinceEpoch(
              DateTime
                  .now()
                  .millisecondsSinceEpoch + 24 * 3600 * 1000);
          keyReturnDueDateController.text = Utils.timestampToDateConversion(
              dateTime.millisecondsSinceEpoch, Constants.fulldateFormat);
        } else if (state.model.keyHandingOverDuration == 2 &&
            !isDateSelectedByUser) {
          if (DateTime
              .now()
              .month < 6) {
            // Set to June 30th of the current year
            dateTime = DateTime(DateTime
                .now()
                .year, 6, 30);
          } else {
            // Set to December 31st of the current year
            dateTime = DateTime(DateTime
                .now()
                .year, 12, 31);
          }
          keyReturnDueDateController.text = Utils.timestampToDateConversion(
              dateTime.millisecondsSinceEpoch, Constants.fulldateFormat);
        } else if (state.model.keyHandingOverDuration == 1 &&
            !isDateSelectedByUser) {
          dateTime = DateTime.fromMillisecondsSinceEpoch(
              DateTime
                  .now()
                  .millisecondsSinceEpoch + 24 * 3600 * 1000);
          keyReturnDueDateController.text = Utils.timestampToDateConversion(
              dateTime.millisecondsSinceEpoch, Constants.fulldateFormat);
        } else {
          dateTime = DateTime.fromMillisecondsSinceEpoch(
              DateTime
                  .now()
                  .millisecondsSinceEpoch + 24 * 3600 * 1000);
          keyReturnDueDateController.text = Utils.timestampToDateConversion(
              dateTime.millisecondsSinceEpoch, Constants.fulldateFormat);
        }
        //
        // state.model.keyHandOverDue =
        //     Utils().formatTime(keyReturnDueDateController.text);
      }
    } else if (state.model.keyHandingOverDuration == 1 &&
        !isDateSelectedByUser) {
      dateTime = DateTime.fromMillisecondsSinceEpoch(
          DateTime
              .now()
              .millisecondsSinceEpoch + 24 * 3600 * 1000);
      keyReturnDueDateController.text = Utils.timestampToDateConversion(
          dateTime.millisecondsSinceEpoch, Constants.fulldateFormat);
    } else {
      keyReturnDueDateController.text = Utils.timestampToDateConversion(
          int.tryParse(state.model.keyHandOverDue ?? '0'),
          Constants.fulldateFormat);
    }
    //
    // if (state.model.keyReturnDateTime != null) {
    //   keyReturnDateAndTimeController.text = Utils.timestampToDateConversion(
    //       int.tryParse(state.model.keyReturnDateTime ?? '0'),
    //       Constants.fulldateFormat);
    // }
  }

  getBodybuilder(KeyManagementIssuanceDetailsState state, height) {
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }
    initializeDates(state);

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
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Column(
                  children: [
                    AbsorbPointer(
                      absorbing: isReadOnly ? true : false,
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
                            Column(
                              children: [
                                if (!state.model.lock.isEmptyOrNull) ...[
                                  RecordLockedWidget(
                                      text: '${state.model.lock}'),
                                ],
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    Constants.generalinformation,
                                    style: Styles.styleHeaderGreyText16,
                                  ),
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Created By
                                CommonWidgets.verticalTextHandling(
                                    state.labels?.locale.createdBy ??
                                        state.labels?.defaultLocale.createdBy ??
                                        Constants.createdby,
                                    isMandatory: true,
                                    '${state.model.createdBy?.firstName ??
                                        ''} ${state.model.createdBy?.lastName ??
                                        ''}'),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Status
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.status ??
                                      state.labels?.defaultLocale.status ??
                                      Constants.status,
                                  Styles.textStyleBlack14,
                                  isMandatory: true,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
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
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Date of creation
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.createdDate ??
                                      state.labels?.defaultLocale.createdDate ??
                                      Constants.createDate,
                                  Styles.textStyleBlack14,
                                  isMandatory: true,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                datecreateWidgetdisplay(
                                    state.model.createdDate ?? ''),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Location
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.location ??
                                      state.labels?.defaultLocale.location ??
                                      Constants.location,
                                  Styles.textStyleBlack14,
                                  isMandatory: true,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                locationWidgetdislay(state),

                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Sl No.
                                CommonWidgets.horizentaltextHandling(
                                  state.labels?.locale.slNo ??
                                      state.labels?.defaultLocale.slNo ??
                                      Constants.slno,
                                  state.model.slNo ?? '',
                                  isMandatory: true,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                if (state.model.status != null &&
                                    state.model.status != 0) ...[

                                  /// Handed Over Date
                                  CommonWidgets.textDisplay(
                                    state.labels?.locale.handedOverDate ??
                                        state.labels?.defaultLocale
                                            .handedOverDate ??
                                        Constants.handedOverDate,
                                    isMandatory: true,
                                    Styles.textStyleBlack14,
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  datecreateWidgetdisplay(
                                      state.model.keyHandOverDate ?? ''),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),
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
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),

                                BaseEntitiesSelection().entityDropDownSelection(
                                  context: context,
                                  selectedValues: state.model.entities ?? [],
                                  all: state.listOfEntities ?? [],
                                  enabled: isEnabled,
                                  onTap: (List<Organisation> selectedEntities) {
                                    log(
                                        '--selectedEntities----${selectedEntities
                                            .length}');
                                    BlocProvider.of<
                                        KeyManagementIssuanceDetailsCubit>(
                                        context)
                                        .updateDropdownValues(
                                        entities: selectedEntities);
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
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
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

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
                                  isDisableColor: !isEnabled,
                                  onTap: () {
                                    if (isEnabled) {
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
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Key Handing Over Duration
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.keyHandingOverDuration ??
                                      state.labels?.defaultLocale
                                          .keyHandingOverDuration ??
                                      Constants.keyHandingOverDuration,
                                  isMandatory: true,
                                  Styles.textStyleBlack14,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                BaseDropDown().getDropDown(
                                  isDisabled: !isEnabled,
                                  textController:
                                  keyHandlingOverDurationController,
                                  items: keyHandingOverDurationValues,
                                  initialValue:
                                  '${state.model.keyHandingOverDuration ?? 1}',
                                  onTap: () {
                                    if (isEnabled) {
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
                                                    (label) =>
                                                label.key == value,
                                                orElse: () =>
                                                const Label(key: '', value: ''),
                                              );

                                          int newDuration = int.tryParse(
                                              selectedLabel.value) ??
                                              1;

                                          // Update the duration in the state
                                          BlocProvider.of<
                                              KeyManagementIssuanceDetailsCubit>(
                                              context)
                                              .updateDropdownValues(
                                              keyHandingOverDuration:
                                              newDuration);

                                          // Reset the isDateSelectedByUser flag and reinitialize dates
                                          isDateSelectedByUser = false;
                                          state.model.keyHandingOverDuration =
                                              newDuration;
                                          initializeDates(state);

                                          log('Key Duration----${state.model
                                              .keyHandingOverDuration}');
                                        },
                                      );
                                    }
                                  },
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Key Return Due Date
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.keyHandOverDue ??
                                      state.labels?.defaultLocale
                                          .keyHandOverDue ??
                                      Constants.keyReturnDueDate,
                                  isMandatory: true,
                                  Styles.textStyleBlack14,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),

                                BaseDate().datePickerWidgetLoading(
                                  textController: keyReturnDueDateController,
                                  isDisabled:
                                  state.model.keyHandingOverDuration == 2 &&
                                      (state.model.status == null ||
                                          state.model.status ==
                                              ConstantsIntValue
                                                  .issuanceDraftStatus)
                                      ? false
                                      : true,
                                  onlyDate: false,
                                  showPastDate: false,
                                  onChange: (String value) {
                                    isDateSelectedByUser = true;
                                    keyReturnDueDateController.text = value;
                                    log(
                                        'keyReturnDueDateControllerValue --- $value');
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
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Employee Type
                                CommonWidgets.textDisplay(
                                    state.labels?.locale.employeeType ??
                                        state.labels?.defaultLocale
                                            .employeeType ??
                                        Constants.employeeType,
                                    isMandatory: true,
                                    Styles.textStyleBlack14),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                BaseDropDown().getDropDown(
                                    isDisabled: !isEnabled,
                                    textController: employeeTypeController,
                                    items: employeeTypeDropDownValues,
                                    initialValue:
                                    state.model.employeeType.toString(),
                                    onTap: () {
                                      if (isEnabled) {
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
                                                        (label) =>
                                                    label.key == value,
                                                    orElse: () =>
                                                    const Label(
                                                        key: '', value: ''),
                                                  );
                                              BlocProvider.of<
                                                  KeyManagementIssuanceDetailsCubit>(
                                                  context)
                                                  .updateDropdownValues(
                                                  employeeType:
                                                  int.tryParse(
                                                      selectedLabel
                                                          .value));
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                  employeeIdFocusNode);
                                            });
                                      }
                                    }),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Employee Id
                                CommonWidgets.textDisplay(
                                    state.labels?.locale.employeeID ??
                                        state
                                            .labels?.defaultLocale.employeeID ??
                                        Constants.employeeid,
                                    isMandatory: true,
                                    Styles.textStyleBlack14),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                FlutterInputField(
                                  textInputType: TextInputType.number,
                                  initialValue: state.model.employeeID,
                                  textFormKey: Keys.contactNoKey,
                                  hintText: '',
                                  focusNode: employeeIdFocusNode,
                                  isEnable: isEnabled,
                                  isDisableColor: !isEnabled,
                                  onChange: (String value) {
                                    state.model.employeeID = value;
                                    context
                                        .read<
                                        KeyManagementIssuanceDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                                if (employeeTypeController.text !=
                                    'CWR T2') ...[

                                  /// Handed Over To
                                  CommonWidgets.textDisplay(
                                      state.labels?.locale.handedOverTo ??
                                          state.labels?.defaultLocale
                                              .handedOverTo ??
                                          Constants.handedOverTo,
                                      Styles.textStyleBlack14,
                                      isMandatory: true),
                                  TextFieldAddButton(
                                    title: state.model.handedOverTo?.userInfo ??
                                        state.model.handedOverTo?.name,
                                    height: 60,
                                    isDisableColor: !isEnabled,
                                    onTap: () {
                                      if (isEnabled) {
                                        BaseOrganisationDialog().userDialog(
                                          context: context,
                                          users: state.emailUsers!,
                                          isDbUser: true,
                                          onTap: (BaseUser user) {
                                            BlocProvider.of<
                                                KeyManagementIssuanceDetailsCubit>(
                                                context)
                                                .updateDropdownValues(
                                              handedOverTo: user,
                                            );
                                          },
                                          roleName:
                                          ConstantUserRoles.atomStaticUser,
                                          locationId: state.model.location!.id!,
                                          functionToCall: (BaseUser user) {
                                            BlocProvider.of<
                                                KeyManagementIssuanceDetailsCubit>(
                                                context)
                                                .updateDropdownValues(
                                              handedOverTo: user,
                                            );
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
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),
                                ],
                                if (employeeTypeController.text ==
                                    'CWR T2') ...[

                                  /// Handed Over To
                                  CommonWidgets.textDisplay(
                                      state.labels?.locale.handedOverTo ??
                                          state.labels?.defaultLocale
                                              .handedOverTo ??
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
                                    isEnable: isEnabled,
                                    isDisableColor: !isEnabled,
                                    onChange: (String value) {
                                      state.model.handedOverToCwrT2 = value;
                                      context
                                          .read<
                                          KeyManagementIssuanceDetailsCubit>()
                                          .onModelValueChange(state.model);
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),

                                  /// DB Sponser CWRT2
                                  CommonWidgets.textDisplay(
                                      state.labels?.locale.dbSponsorCwrT2 ??
                                          state.labels?.defaultLocale
                                              .dbSponsorCwrT2 ??
                                          Constants.dbSponsorOfCWRT2,
                                      Styles.textStyleBlack14,
                                      isMandatory: true),
                                  TextFieldAddButton(
                                    title:
                                    state.model.dbSponsorCwrT2?.userInfo ??
                                        state.model.dbSponsorCwrT2?.name,
                                    height: 60,
                                    isDisableColor: !isEnabled,
                                    onTap: () {
                                      if (isEnabled) {
                                        BaseOrganisationDialog().userDialog(
                                          context: context,
                                          enabled: isEnabled,
                                          users: state.emailUsers!,
                                          isDbUser: true,
                                          onTap: (BaseUser user) {
                                            BlocProvider.of<
                                                KeyManagementIssuanceDetailsCubit>(
                                                context)
                                                .updateDropdownValues(
                                              dbSponsorCwrT2: user,
                                            );
                                          },
                                          roleName:
                                          ConstantUserRoles.atomStaticUser,
                                          locationId: state.model.location!.id!,
                                          functionToCall: (BaseUser user) {
                                            BlocProvider.of<
                                                KeyManagementIssuanceDetailsCubit>(
                                                context)
                                                .updateDropdownValues(
                                              dbSponsorCwrT2: user,
                                            );
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
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),
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
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),

                                  /// Returned
                                  CommonWidgets.horizentaltextHandling(
                                      state.labels?.locale.returned ??
                                          state
                                              .labels?.defaultLocale.returned ??
                                          Constants.returned,
                                      '${state.model.totalReturned ?? 0}'),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),

                                  /// Not Returned
                                  CommonWidgets.horizentaltextHandling(
                                      state.labels?.locale.notReturned ??
                                          state.labels?.defaultLocale
                                              .notReturned ??
                                          Constants.notReturned,
                                      '${state.model.totalNotReturned ?? 0}'),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),

                                  /// Lost
                                  CommonWidgets.horizentaltextHandling(
                                      state.labels?.locale.lost ??
                                          state.labels?.defaultLocale.lost ??
                                          Constants.lost,
                                      '${state.model.totalLost ?? 0}'),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),

                                  /// Damaged
                                  CommonWidgets.horizentaltextHandling(
                                      state.labels?.locale.damaged ??
                                          state.labels?.defaultLocale.damaged ??
                                          Constants.damaged,
                                      '${state.model.totalDamage ?? 0}'),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),

                                  /// Security Signature
                                  buildSignature(
                                      controller: securitySignatureController,
                                      label: state.labels?.locale.securitySign ??
                                          state.labels?.defaultLocale
                                              .securitySign ??
                                          Constants.securitySignature,
                                      spaceHeight: height,
                                      state: state,
                                      isMandatory: false),

                                  /// Receiver Sign/Acceptance
                                  buildSignature(
                                      controller: receiverSignatureController,
                                      label: state.labels?.locale
                                          .receiverSignAcceptance ??
                                          state.labels?.defaultLocale
                                              .receiverSignAcceptance ??
                                          Constants.receiverSignature,
                                      spaceHeight: height,
                                      state: state,
                                      isMandatory: false),

                                  /// Key Return Date And Time
                                  // Text('${state.model.keyReturnDateTime}'),
                                  // if (state
                                  //     .model.keyReturnDateTime.isEmptyOrNull) ...[
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
                                  datecreateWidgetdisplay(
                                      state.model.keyReturnDateTime ?? ''),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),
// ],
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
                                    isEnable: (state.model.status == 1 ||
                                        state.model.status == 2 ||
                                        isNotReturnableStatus) &&
                                        state.model.lock.isEmptyOrNull
                                        ? true
                                        : false,
                                    isDisableColor: state.model.status != 1 &&
                                        state.model.status != 2 &&
                                        !isNotReturnableStatus &&
                                        !state.model.lock.isEmptyOrNull
                                        ? false
                                        : true,
                                    onChange: (String value) {
                                      state.model.returnedByName = value;
                                      context
                                          .read<
                                          KeyManagementIssuanceDetailsCubit>()
                                          .onModelValueChange(state.model);
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),
                                ],

                                /// Key Issuance Process
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    Constants.keyIssuanceProcess,
                                    style: Styles.styleHeaderGreyText16,
                                  ),
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        NavigatorState nav = Navigator.of(context);

                        log('----1---');
                        bool isSaveSuccess = await BlocProvider.of<
                            KeyManagementIssuanceDetailsCubit>(
                          context,
                        ).submitForm(
                          isSaveOnly: true,
                          navigateToNextScreen: true,
                          receiverSignatureController:
                          receiverSignatureController,
                          securitySignatureController:
                          securitySignatureController,
                        );
                        log('----2---');
                        if (!isSaveSuccess) {
                          return;
                        }
                        log('----3---');

                        // Now, this code will execute only after the completion of submitForm
                        nav.pushNamed(
                          keyManagementIssuanceProcessRecordsRoute,
                          arguments: {
                            ConstantsArgument.title:
                            Constants.keyIssuanceProcess,
                            // ConstantsArgument.id: state.model.id,
                            ConstantsArgument.parentId: state.model.id,
                            ConstantsArgument.parentStatus: state.model.status,
                            ConstantsArgument.locationId:
                            state.model.location?.id,
                            ConstantsArgument.isMasterKey: widget.isMasterKey,
                            ConstantsArgument.isLocked: state.model.lock,
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
                            // color: AppColors.navigationSkyBlueColor,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Add/View Key Issuance Process(S)',
                            style: TextStyle(
                              color: AppColors.navigationSkyBlueColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CommonWidgets.verticalSpacerWidget(height * 0.02),
                    if(state.model.id != null) ...[

                      /// Modified Date
                      CommonWidgets.textDisplay(
                        // state.labels?.locale.date ??
                        //     state.labels?.defaultLocale.date ??
                        Constants.modifiedOn,
                        Styles.textStyleBlack14,
                        isMandatory: true,
                      ),
                      CommonWidgets.verticalSpacerWidget(
                          height * 0.001),
                      datecreateWidgetdisplay(
                          state.model.modifiedDate ?? ''),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// Modified By
                      CommonWidgets.horizentaltextHandling(
                        // state.labels?.locale.entrySecurity ??
                        //     state.labels?.defaultLocale.entrySecurity ??
                          Constants.modifiedBy,
                          isMandatory: true,
                          state.model.modifiedBy ?? ''),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                    ],
                  ],
                ),
              ),
            ),


            // if(state.model.id != null) ...[
            //
            //   /// Modified Date
            //   CommonWidgets.textDisplay(
            //     // state.labels?.locale.date ??
            //     //     state.labels?.defaultLocale.date ??
            //     Constants.modifiedOn,
            //     Styles.textStyleBlack14,
            //     isMandatory: true,
            //   ),
            //   CommonWidgets.verticalSpacerWidget(
            //       height * 0.001),
            //   datecreateWidgetdisplay(
            //       state.model.modifiedDate ?? ''),
            //   CommonWidgets.verticalSpacerWidget(height * 0.01),
            //
            //   /// Modified By
            //   CommonWidgets.horizentaltextHandling(
            //     // state.labels?.locale.entrySecurity ??
            //     //     state.labels?.defaultLocale.entrySecurity ??
            //       Constants.modifiedBy,
            //       isMandatory: true,
            //       state.model.modifiedBy ?? ''),
            //   CommonWidgets.verticalSpacerWidget(height * 0.01),
            // ],

            /// SubmitButton
            Container(
              padding: const EdgeInsets.all(5.0),
              decoration: const ShapeDecoration(
                color: AppColors.backgroundWhiteColor,
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
                    cancelButtonDisplay(),
                    if ((state.model.status == 0 ||
                        state.model.status == 1 ||
                        state.model.status == 2 ||
                        state.model.status == null ||
                        isNotReturnableStatus) &&
                        !isReadOnly &&
                        state.model.lock.isEmptyOrNull
                        ? true
                        : false) ...[submitButtonDisplay()],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AbsorbPointer buildSignature({
    required SignatureController controller,
    required String label,
    required double spaceHeight,
    required KeyManagementIssuanceDetailsState state,
    required bool isMandatory,
  }) {
    bool isEditable = false;
    bool isSigned = false;
    bool isReceiver = label.equalsIgnoreCase(Constants.receiverSignature);
    if (isReceiver) {
      isSigned = state.model.receiverSign != null &&
          !state.model.receiverSign!.imageContent.isEmptyOrNull;
      isEditable = state.isReceiverSignEditable;
    } else {
      isSigned = state.model.securitySign != null &&
          !state.model.securitySign!.imageContent.isEmptyOrNull;
      isEditable = state.isSecuritySignatureSignEditable;
    }

    log('---------');
    return AbsorbPointer(
      absorbing: !state.model.lock.isEmptyOrNull &&
          state.model.status != ConstantsIntValue.issuanceDraftStatus,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CommonWidgets.textDisplay(
                    label,
                    Styles.textStyleBlack14,
                  ),
                  if (isMandatory) ...[
                    const Text(
                      ' *',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ],
              ),
              Row(
                children: [
                  state.model.status == null ||
                      state.model.status ==
                          ConstantsIntValue.issuanceDraftStatus
                      ? IconButton(
                    onPressed: () {
                      controller.clear();
                      if (isReceiver) {
                        BlocProvider.of<
                            KeyManagementIssuanceDetailsCubit>(
                            context)
                            .makeSignEditable(receiverSign: true);
                      } else {
                        BlocProvider.of<
                            KeyManagementIssuanceDetailsCubit>(
                            context)
                            .makeSignEditable(
                            securitySignatureSignEditable: true);
                      }
                    },
                    iconSize: 20,
                    color: Colors.grey,
                    icon: const Icon(Icons.refresh),
                  )
                      : SizedBox.fromSize(),
                ],
              ),
            ],
          ),
          CommonWidgets.verticalSpacerWidget(spaceHeight * 0.001),
          ClipRect(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
                border: Border.all(
                  color: AppColors.geryLightBackground,
                  width: 1, // Border width
                ),
              ),
              height: 100,
              width: double.infinity,
              child: (!isEditable && isSigned)
                  ? Image.memory(
                Uint8List.fromList(
                  base64Decode(
                    isReceiver
                        ? state.model.receiverSign!.imageContent ?? ''
                        : state.model.securitySign!.imageContent ?? '',
                  ),
                ),
                fit: BoxFit.none,
              )
                  : Signature(
                controller: controller,
                backgroundColor: Colors.white,
              ),
            ),
          ),
          CommonWidgets.verticalSpacerWidget(spaceHeight * 0.01),
        ],
      ),
    );
  }

  String getStatusString(int status) {
    switch (status) {
      case -1:
        return 'Cancelled';
      case 0:
        return 'Draft';
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

  Widget cancelButtonDisplay() {
    return AppButton(
      width: Constants.cancelButtonWidth,
      backgroundColor: Colors.white,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.close,
      buttonTextKey: Keys.cancelButton,
      onTap: () {
        Navigator.pop(context);
        Navigator.popAndPushNamed(
          context,
          keyManagementIssuanceListRoute,
        );
        CommonServices().unlock();
      },
    );
  }

  // Widget cancelButtonDisplay(KeyManagementIssuanceDetailsState state) {
  //   return AppButton(
  //     width: Constants.cancelButtonWidth,
  //     backgroundColor: Colors.white,
  //     key: const Key(Keys.cancelButton),
  //     buttonText: state.model.id == null || !state.model.lock.isEmptyOrNull
  //         ? Constants.close
  //         : Constants.cancelRecord,
  //     buttonTextKey: Keys.cancelButton,
  //     onTap: () {
  //       if (state.model.id == null) {
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
        BlocProvider.of<KeyManagementIssuanceDetailsCubit>(context).submitForm(
          isSaveOnly: false,
          receiverSignatureController: receiverSignatureController,
          securitySignatureController: securitySignatureController,
        );
      },
    );
  }

  Widget locationWidgetdislay(KeyManagementIssuanceDetailsState state) {
    return GestureDetector(
      onTap: () {
        if ((state.model.status == 0 || state.model.status == null) &&
            state.model.lock.isEmptyOrNull) {
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
                      .updateLocationDropdownValue(location: location);
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
