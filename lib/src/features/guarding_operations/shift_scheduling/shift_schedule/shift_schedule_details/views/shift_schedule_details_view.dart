import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/shift_schedule_details/views/duty_post_details_view.dart';

class ShiftScheduleDetailsView extends StatefulWidget {
  // final String title;

  const ShiftScheduleDetailsView({
    super.key,
    // required this.title,
  });

  @override
  State<ShiftScheduleDetailsView> createState() =>
      _ShiftScheduleDetailsViewState();
}

class _ShiftScheduleDetailsViewState extends State<ShiftScheduleDetailsView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User? userDetails;
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController rankController = TextEditingController();

  bool isDisabled = true;
  bool isReadOnly = false;

  get guardingMasterData => null;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ShiftScheduleDetailsCubit>(context).initializeValues();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return BlocConsumer<ShiftScheduleDetailsCubit, ShiftScheduleDetailsState>(
      listener: (context, state) {
        log('-state.status---${state.status}----');
        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: 'Message',
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popAndPushNamed(
                context,
                shiftScheduleListRoute,
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
        if (state.status == FormStatus.navigateToNextScreen) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider<ShiftScheduleDetailsCubit>(
                create: (_) => ShiftScheduleDetailsCubit(
                  mainDutyPostModel:
                      state.selectedDutyPostModel ?? DutyPostModel(),
                  id: state.model.id.toString(),
                ),
                child: DutyPostDetailsView(
                  model: state.selectedDutyPostModel ?? DutyPostModel(),
                ),
              ),
            ),
          );
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
          isReadOnly = true;
        }
        if (state.model.status == null) {
          isReadOnly = false;
        }

        initializeDates(state);
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: Constants.shiftSchedule,
            // title: widget.title,
            showPopUp: false,
            showSaveButton: state.model.status != 5 ? true : false,
            showSubmitButton: state.model.status != 5 ? true : false,
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<ShiftScheduleDetailsCubit>(context)
                  .submitForm(isSaveOnly: true);
            },
            onTapSubmit: (){
              FocusScope.of(context).unfocus();
              BlocProvider.of<ShiftScheduleDetailsCubit>(context)
                  .submitForm(isSaveOnly: false);
            }
          ),
          backgroundColor: AppColors.backgroundWhitecolor,
          body: getBodybuilder(state, height),
        );
      },
    );
  }

  void initializeDates(ShiftScheduleDetailsState state) {
    if (state.model.fromDate != null) {
      fromDateController.text = Utils.timestamptoDateConversion(
          int.parse(state.model.fromDate ?? '0'), Constants.dateFormat);
    }

    if (state.model.toDate != null) {
      toDateController.text = Utils.timestamptoDateConversion(
          int.parse(state.model.toDate ?? '0'), Constants.dateFormat);
    }
  }

  getBodybuilder(ShiftScheduleDetailsState state, height) {
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
                autovalidateMode: state.model.status == 4
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
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          BaseDropDown().getDropDown(
                            isDisabled: true,
                            textController: statusController,
                            items: shiftScheduleStatusDropDownValues,
                            initialValue: '${state.model.status ?? 0}',
                            onTap: () {
                              if (state.model.id != null) {
                                BaseDropDown().assetTypeDialog(
                                  context: context,
                                  dropDownValues: shiftScheduleStatusDropDownValues
                                      .map((label) => label.key)
                                      .toList(),
                                  onTap: (String value) {
                                    Label? selectedLabel;
                                    selectedLabel =
                                        shiftScheduleStatusDropDownValues.firstWhere(
                                      (label) => label.key == value,
                                      orElse: () =>
                                          const Label(key: '', value: ''),
                                    );
                                    BlocProvider.of<ShiftScheduleDetailsCubit>(
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

                          /// Created By
                          CommonWidgets.horizentaltextHandling(
                              state.labels?.locale.entrySecurity ??
                                  state.labels?.defaultLocale.entrySecurity ??
                                  Constants.createdby,
                              isMandatory: true,
                              '${state.loggedInUserDetails?.firstName ?? ''} ${state.loggedInUserDetails?.lastName ?? ''}'),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Date of creation
                          CommonWidgets.textDisplay(
                              state.labels?.locale.inputDate ??
                                  state.labels?.defaultLocale.inputDate ??
                                  Constants.dateofcreation,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          BaseDate()
                              .creationDateDisplay(state.model.inputDate ?? ''),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Location
                          CommonWidgets.textDisplay(
                              //state.labels?.locale.location ??
                              //  state.labels?.defaultLocale.location ??
                              Constants.location,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          BaseLocationDropdown().locationWidgetDisplay(
                              context: context,
                              locations: state.locations ?? Locations(),
                              selectedLocationName:
                                  state.model.location?.name ?? '',
                              onTap: (Organisation? location) {
                                BlocProvider.of<ShiftScheduleDetailsCubit>(
                                        context)
                                    .updateDropdownValues(location: location);
                              }),
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

                          /// Vendor
                          CommonWidgets.textDisplay(
                            // state.labels?.locale.vendor ??
                            //   state.labels?.defaultLocale.vendor ??
                            Constants.vendor,
                            isMandatory: true,
                            Styles.textStyleBlack14,
                          ),
                          TextfieldAddButton(
                            title: state.model.vendor?.name,
                            height: 60,
                            isDisableColor: false,
                            onTap: () {
                              BaseOrganisationDialog().departmentDialog(
                                context: context,
                                organisations: state.vendors,
                                onTap: (Organisation department) {
                                  BlocProvider.of<ShiftScheduleDetailsCubit>(
                                          context)
                                      .updateDropdownValues(vendor: department);
                                },
                                  orgName: 'ATOM_VENDORS',
                                  createEntity: false,
                                  title: 'Add Vendors',
                                  functionToCall: () {
                                    // refresh the list
                                    BlocProvider.of<
                                        ShiftScheduleDetailsCubit>(
                                        context)
                                        .refreshList();
                                  }
                              );
                            },
                          ),

                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Duty Type
                          CommonWidgets.textDisplay(
                              // state.labels?.locale.guardRank ??
                              //    state.labels?.defaultLocale.guardRank ??
                              Constants.dutyType,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          BaseDropDown().getDropDown(
                              isDisabled: state.model.status != 6,
                              textController: rankController,
                              items: shiftDutyTypeDropDownValues,
                              initialValue: state.model.dutyType.toString(),
                              onTap: () {
                                if (isDisabled) {
                                  BaseDropDown().assetTypeDialog(
                                      context: context,
                                      dropDownValues:
                                          shiftDutyTypeDropDownValues
                                              .map((label) => label.key)
                                              .toList(),
                                      onTap: (String value) {
                                        Label? selectedLabel;
                                        selectedLabel =
                                            shiftDutyTypeDropDownValues
                                                .firstWhere(
                                          (label) => label.key == value,
                                          orElse: () =>
                                              const Label(key: '', value: ''),
                                        );
                                        BlocProvider.of<
                                                    ShiftScheduleDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                                dutyType: int.tryParse(
                                                    selectedLabel.value));
                                      });
                                }
                              }),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// From Date
                          CommonWidgets.textDisplay(
                            // state.labels?.locale.dateOfBirth ??
                            //  state.labels?.defaultLocale.dateOfBirth ??
                            Constants.fromDate,
                            isMandatory: true,
                            Styles.textStyleBlack14,
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),

                          BaseDate().datePickerWidgetLoading(
                            textController: fromDateController,
                            onlyDate: false,
                            showPastDate: false,
                            onChange: (String value) {
                              state.model.fromDate = Utils().formatTime(value);
                              BlocProvider.of<ShiftScheduleDetailsCubit>(
                                      context)
                                  .onModelValueChange(state.model);
                            },
                            context: context,
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// To Date
                          CommonWidgets.textDisplay(
                            // state.labels?.locale.dateOfBirth ??
                            //   state.labels?.defaultLocale.dateOfBirth ??
                            Constants.toDate,
                            isMandatory: true,
                            Styles.textStyleBlack14,
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),

                          BaseDate().datePickerWidgetLoading(
                            textController: toDateController,
                            onlyDate: false,
                            showPastDate: false,
                            onChange: (String value) {
                              state.model.toDate = Utils().formatTime(value);
                              BlocProvider.of<ShiftScheduleDetailsCubit>(
                                      context)
                                  .onModelValueChange(state.model);
                            },
                            context: context,
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// List of Duty Posts
                          DutyPostListWidget(
                            dutyPosts: state.dutyPosts ?? [],
                            onTap: (id) {
                              BlocProvider.of<ShiftScheduleDetailsCubit>(
                                      context)
                                  .getDutyPostById(id);
                            },
                          ),

                          CommonWidgets.verticalSpacerWidget(height * 0.02),

                          /// SubmitButton
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              cancelButtonDisplay(state),
                              submitButtonDisplay()
                            ],
                          ),

                          CommonWidgets.verticalSpacerWidget(height * 0.04),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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

  Widget cancelButtonDisplay(ShiftScheduleDetailsState state) {
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
  void updateRecordStatus(ShiftScheduleDetailsState state) {
    if (state.model.id != null) {
      BlocProvider.of<ShiftScheduleDetailsCubit>(context)
          .updateStatus(id: state.model.id.toString());
      Navigator.popAndPushNamed(context, shiftScheduleListRoute,);
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
        BlocProvider.of<ShiftScheduleDetailsCubit>(context)
            .submitForm(isSaveOnly: false);
      },
    );
  }
}
