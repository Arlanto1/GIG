import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_issuance/key_management_issuance_details/cubits/key_management_issuance_details_cubits.dart';

class KeyManagementIssuanceDetailsView extends StatefulWidget {
  final KeyManagementIssuanceModel? model;
  final String title;

  const KeyManagementIssuanceDetailsView({
    super.key,
    this.model,
    required this.title,
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
  bool isReadOnly = false;

  get model => null;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<KeyManagementIssuanceDetailsCubit>(context)
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
    return BlocConsumer<KeyManagementIssuanceDetailsCubit,
        KeyManagementIssuanceDetailsState>(
      listener: (context, state) {
        log('-state.status---${state.status}----');
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
        // if (state.model.status == 6 || !state.model.lock.isEmptyOrNull) {
        //   isReadOnly = true;
        // }
        if (state.model.status == null) {
          isReadOnly = false;
        }

        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.title,
            showPopUp: false,
            showSaveButton: state.model.status != 6 &&
                    state.model.status != 1 &&
                    !isReadOnly
                ? true
                : false,
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<KeyManagementIssuanceDetailsCubit>(context)
                  .submitForm(
                isSaveOnly: true,
                navigateToNextScreen: false,
              );
            },
            showSubmitButton: state.model.status != 6 &&
                    state.model.status != 1 &&
                    !isReadOnly
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

  void initializeDates() {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
        DateTime.now().millisecondsSinceEpoch + 24 * 3600 * 1000);

    keyReturnDueDateController.text = Utils.timestamptoDateConversion(
        dateTime.millisecondsSinceEpoch, Constants.fulldateFormat);
  }

  getBodybuilder(KeyManagementIssuanceDetailsState state, height) {
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
                                state.labels?.locale.entrySecurity ??
                                    state.labels?.defaultLocale.entrySecurity ??
                                    Constants.createdby,
                                '${state.loggedInUserDetails?.firstName ?? ''} ${state.loggedInUserDetails?.lastName ?? ''}'),
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
                              state.labels?.locale.inputDate ??
                                  state.labels?.defaultLocale.inputDate ??
                                  Constants.dateofcreation,
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

                            /// Handed Over Date
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.pvcExpiryDate ??
                              //   state.labels?.defaultLocale.pvcExpiryDate ??
                              Constants.handedOverDate,
                              isMandatory: true,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            datecreateWidgetdisplay(
                                state.model.keyHandOverDate ?? ''),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

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
                                              KeyManagementIssuanceDetailsCubit>(
                                          context)
                                      .updateDropdownValues(
                                          entities: selectedEntities);
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Department
                            CommonWidgets.textDisplay(
                              //state.labels?.locale.vendor ??
                              //    state.labels?.defaultLocale
                              //      .vendor ??
                              Constants.department,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            widget.model?.status == 6
                                ? FlutterInputField(
                                    initialValue: "${state.model.department}",
                                    textFormKey: Keys.receiverDepartmentKey,
                                    hintText: '',
                                    isEnable: state.model.status != 6,
                                    isDisableColor: state.model.status == 6,
                                    onChange: (Organisation value) {
                                      state.model.department = value;
                                      context
                                          .read<
                                              KeyManagementIssuanceDetailsCubit>()
                                          .onModelValueChange(state.model);
                                    },
                                    validateTextField: (String? user) {},
                                  )
                                : TextfieldAddButton(
                                    title: state.model.department?.name,
                                    height: 70,
                                    isDisableColor:
                                        state.model.status != 6 ? false : true,
                                    onTap: () {
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
                                      );
                                      // leodepartmentsDialog(state);
                                      // }
                                    },
                                  ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Key Handing Over Duration
                            CommonWidgets.textDisplay(
                                //state.labels?.locale.maritalStatus ??
                                //   state.labels?.defaultLocale.maritalStatus ??
                                Constants.keyHandingOverDuration,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDropDown().getDropDown(
                                isDisabled: state.model.status != 6,
                                textController:
                                    keyHandlingOverDurationController,
                                items: keyHandingOverDuration,
                                initialValue: state.model.keyHandingOverDuration
                                    .toString(),
                                onTap: () {
                                  //  if (isDisabled) {
                                  BaseDropDown().assetTypeDialog(
                                      context: context,
                                      dropDownValues: keyHandingOverDuration
                                          .map((label) => label.key)
                                          .toList(),
                                      onTap: (String value) {
                                        Label? selectedLabel;
                                        selectedLabel =
                                            keyHandingOverDuration.firstWhere(
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
                                  //}
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Key Return Due Date
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.pvcExpiryDate ??
                              //   state.labels?.defaultLocale.pvcExpiryDate ??
                              Constants.keyReturnDueDate,
                              isMandatory: true,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              textController: keyReturnDueDateController,
                              isDisabled: true,
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
                                //state.labels?.locale.maritalStatus ??
                                //   state.labels?.defaultLocale.maritalStatus ??
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
                                  //  if (isDisabled) {
                                  BaseDropDown().assetTypeDialog(
                                      context: context,
                                      dropDownValues: employeeTypeDropDownValues
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
                                      });
                                  //}
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Employee Id
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.contactNo ??
                                //  state.labels?.defaultLocale.contactNo ??
                                Constants.employeeid,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.text,
                              initialValue: state.model.employeeID,
                              textFormKey: Keys.contactNoKey,
                              hintText: '',
                              isEnable: widget.model == null
                                  ? true
                                  : (widget.model != null &&
                                          (widget.model?.employeeID == null))
                                      ? false
                                      : true,
                              isDisableColor: false,
                              onChange: (String value) {
                                state.model.employeeID = value;
                                context
                                    .read<KeyManagementIssuanceDetailsCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Handed Over To
                            CommonWidgets.textDisplay(
                                //state.labels?.locale.approver ??
                                //  state.labels?.defaultLocale.approver ??
                                Constants.handedOverTo,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            TextfieldAddButton(
                              title: state.model.handedOverTo?.name,
                              height: 60,
                              isDisableColor: isReadOnly,
                              onTap: () {
                                BaseOrganisationDialog().userDialog(
                                  context: context,
                                  enabled: !isReadOnly,
                                  users: state.users!,
                                  onTap: (BaseUser user) {
                                    BlocProvider.of<
                                                KeyManagementIssuanceDetailsCubit>(
                                            context)
                                        .updateDropdownValues(
                                      user: user,
                                    );
                                  },
                                );
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            if (employeeTypeController.text == 'CWR T2') ...[
                              CommonWidgets.textDisplay(
                                  //state.labels?.locale.approver ??
                                  //  state.labels?.defaultLocale.approver ??
                                  Constants.dbSponsorOfCWRT2,
                                  Styles.textStyleBlack14,
                                  isMandatory: true),
                              TextfieldAddButton(
                                title: state.model.dbSponsorCwrT2?.name,
                                height: 60,
                                isDisableColor: isReadOnly,
                                onTap: () {
                                  BaseOrganisationDialog().userDialog(
                                    context: context,
                                    enabled: !isReadOnly,
                                    users: state.users!,
                                    onTap: (BaseUser user) {
                                      BlocProvider.of<
                                                  KeyManagementIssuanceDetailsCubit>(
                                              context)
                                          .updateDropdownValues(
                                        user: user,
                                      );
                                    },
                                  );
                                },
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
                                log('--isSaveSuccess---$isSaveSuccess--');

                                if (!isSaveSuccess) {
                                  return;
                                }

                                log('--state.model.id---${state.model.id}--');

                                // Now, this code will execute only after the completion of submitForm
                                nav.pushNamed(
                                  keyManagementIssuanceProcessRecordsRoute,
                                  arguments: {
                                    ConstantsArgument.title:
                                        Constants.keyIssuanceProcess,
                                    ConstantsArgument.parentId: state.model.id,
                                    ConstantsArgument.parentStatus: state.model.status,
                                    ConstantsArgument.locationId:
                                        state.model.location?.id,
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

                      /// SubmitButton
                      if ((state.model.status == 6 || state.model.status == 1)
                          ? false
                          : true) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            cancelButtonDisplay(),
                            submitButtonDisplay()
                          ],
                        ),
                      ],
                      CommonWidgets.verticalSpacerWidget(height * 0.04),
                    ],
                  ),
                ),
              ),
            ),
            if (state.model.status == 6 || state.model.status == 1) ...[
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
                    cancelButtonDisplay(),
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
        return 'Loss Damage Reported';
      case 4:
        return 'Closed';
      default:
        return '';
    }
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
