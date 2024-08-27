import 'dart:developer';

import 'package:db_atom/index.dart';

import '../cubits/attendance_details_cubit.dart';

class AttendanceDetailsView extends StatefulWidget {
  final AttendanceModel? model;
  final ExtraProperties? extraProperties;

  const AttendanceDetailsView({
    super.key,
    this.model,
    this.extraProperties,
  });

  @override
  State<AttendanceDetailsView> createState() => _AttendanceDetailsViewState();
}

class _AttendanceDetailsViewState extends State<AttendanceDetailsView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User? userDetails;
  TextEditingController genderController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController dutyTypeController = TextEditingController();
  TextEditingController attendanceTypeController = TextEditingController();

  bool isDisabled = true;
  bool isReadOnly = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AttendanceDetailsCubit>(context).initializeValues();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return BlocConsumer<AttendanceDetailsCubit, AttendanceDetailsState>(
      listener: (context, state) {
        log('-state.status---${state.status}----');
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);

        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: 'Duty Post Master',
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popAndPushNamed(
                context,
                attendanceListRoute,
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
          log('Navigating to Next Screen');
          Navigator.pushNamed(
            context,
            attendanceShiftsRoute,
            arguments: {
              ConstantsArgument.parentId: state.parentId,
              ConstantsArgument.selectedDutyPostNameId:
                  state.selectedDutyPostNameId,
              ConstantsArgument.location: state.model.location,
              ConstantsArgument.locationRegion: state.model.locationRegion,
              ConstantsArgument.vendor: state.model.vendor,
              ConstantsArgument.selectedDutyPostModel:
                  state.selectedDutyPostModel,
              ConstantsArgument.isReadOnly: isReadOnly,
              ConstantsArgument.isEligibleToEdit: state.model.isEligibleToEdit

            },
          );
        }
      },
      builder: (context, state) {
        if (widget.model == null) {
          isReadOnly = false;
        }
        if (state.model.status == null) {
          isReadOnly = false;
        }

        // if (state.model.status == 0) {
        //   isReadOnly = true;
        // }
        // if (widget.extraProperties != null &&
        //     !widget.extraProperties!.hasWritePermission!) {
        //   isReadOnly = true;
        // }
        if (state.model.status == ConstantsIntValue.cancelledStatus) {
          isReadOnly = true;
        }
        if (!state.model.lock.isEmptyOrNull) {
          isReadOnly = true;
        }

        log('isEligible -----  ${!state.model.isEligibleToEdit}');
        if (!state.model.isEligibleToEdit) {
          isReadOnly = true;
        }
        initializeDates();
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: Constants.attendanceDetails,
            showPopUp: false,
            showSubmitButton: !isReadOnly,
            showSaveButton: !isReadOnly,
            showDisLikeButton: false,
            showLikeButton: false,
            pdfAPIName:
                '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=${Constants.attendanceModuleCode}',
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<AttendanceDetailsCubit>(context)
                  .submitForm(isSaveOnly: true);
            },
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<AttendanceDetailsCubit>(context)
                  .submitForm(isSaveOnly: false);
            },
          ),
          backgroundColor: AppColors.backgroundWhiteColor,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void initializeDates() {}

  getBodybuilder(AttendanceDetailsState state, height) {
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
                    AbsorbPointer(
                      absorbing: isReadOnly,
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
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDropDown().getDropDown(
                              isDisabled: state.model.status != 3,
                              textController: statusController,
                              items: attendanceStatusDropDownValues,
                              initialValue: '${state.model.status ?? 0}',
                              onTap: () {
                                if (widget.model != null) {
                                  BaseDropDown().assetTypeDialog(
                                    context: context,
                                    dropDownValues:
                                        attendanceStatusDropDownValues
                                            .map((label) => label.key)
                                            .toList(),
                                    onTap: (String value) {
                                      Label? selectedLabel;
                                      selectedLabel =
                                          attendanceStatusDropDownValues
                                              .firstWhere(
                                        (label) => label.key == value,
                                        orElse: () =>
                                            const Label(key: '', value: ''),
                                      );
                                      BlocProvider.of<AttendanceDetailsCubit>(
                                              context)
                                          .updateDropdownValues(
                                              status: int.tryParse(
                                                  selectedLabel.value));
                                    },
                                  );
                                }
                              },
                            ),

                            /// Created By
                            CommonWidgets.horizentaltextHandling(
                                state.labels?.locale.entrySecurity ??
                                    state.labels?.defaultLocale.entrySecurity ??
                                    Constants.createdby,
                                isMandatory: true,
                                state.model.entrySecurityName ?? ''),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Date of creation
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.inputDate ??
                                //     state.labels?.defaultLocale.inputDate ??
                                Constants.date,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDate().creationDateDisplay(
                                state.model.inputDate ?? ''),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Location
                            CommonWidgets.textDisplay(
                                //state.labels?.locale.location ??
                                //  state.labels?.defaultLocale.location ??
                                Constants.location,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            AbsorbPointer(
                                absorbing: true,
                                child: BaseLocationDropdown()
                                    .locationWidgetDisplay(
                                        context: context,
                                        locations:
                                            state.locations ?? Locations(),
                                        selectedLocationName:
                                            state.model.location?.name ?? '',
                                        onTap: (Organisation? location) {
                                          BlocProvider.of<
                                                      AttendanceDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                                  location: location);
                                        })),
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
                              state.labels?.locale.vendor ??
                                  state.labels?.defaultLocale.vendor ??
                                  Constants.vendor,
                              isMandatory: true,
                              Styles.textStyleBlack14,
                            ),
                            TextFieldAddButton(
                              title: state.model.vendor?.name,
                              height: 60,
                              isDisableColor: true,
                              onTap: () {
                                if (state.model.status == null) {
                                  BaseOrganisationDialog().departmentDialog(
                                    context: context,
                                    organisations: state.vendors,
                                    onTap: (Organisation department) {
                                      BlocProvider.of<AttendanceDetailsCubit>(
                                              context)
                                          .updateDropdownValues(
                                              vendor: department);
                                    },
                                  );
                                }
                              },
                            ),

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
                                isDisabled: state.model.status != null,
                                textController: dutyTypeController,
                                items: shiftDutyTypeDropDownValues,
                                initialValue: state.model.dutyType.toString(),
                                onTap: () {
                                  if (state.model.status == null) {
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
                                                      AttendanceDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                                  dutyType: int.tryParse(
                                                      selectedLabel.value));
                                        });
                                  }
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Attendance Type
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.guardRank ??
                                //    state.labels?.defaultLocale.guardRank ??
                                Constants.attendanceType,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDropDown().getDropDown(
                                isDisabled: state.model.status != null,
                                textController: attendanceTypeController,
                                items: attendanceTypeDropDownValues,
                                initialValue:
                                    state.model.attendanceType.toString(),
                                onTap: () {
                                  if (state.model.status == 0) {
                                    BaseDropDown().assetTypeDialog(
                                        context: context,
                                        dropDownValues:
                                            attendanceTypeDropDownValues
                                                .map((label) => label.key)
                                                .toList(),
                                        onTap: (String value) {
                                          Label? selectedLabel;
                                          selectedLabel =
                                              attendanceTypeDropDownValues
                                                  .firstWhere(
                                            (label) => label.key == value,
                                            orElse: () =>
                                                const Label(key: '', value: ''),
                                          );
                                          BlocProvider.of<
                                                      AttendanceDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                                  attendanceType: int.tryParse(
                                                      selectedLabel.value));
                                        });
                                  }
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                          ],
                        ),
                      ),
                    ),

                    /// List of Duty Posts
                    DutyPostListWidget(
                      dutyPosts: state.dutyPosts ?? [],
                      onTap: (int? thisVariableIsOfNoUseDoNotDeleteThis,
                          int? dutyPostNameId, DutyPostModel dutyPostModel) {
                        BlocProvider.of<AttendanceDetailsCubit>(context)
                            .navigateToNextScreen(
                          dutyPostNameId: dutyPostNameId!,
                          dutyPostModel: dutyPostModel,
                        );
                      },
                    ),
                    CommonWidgets.verticalSpacerWidget(height * 0.02),

                    /// SubmitButton
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        cancelButtonDisplay(),
                        if (!isReadOnly) ...[submitButtonDisplay()],
                      ],
                    ),

                    CommonWidgets.verticalSpacerWidget(height * 0.04),
                  ],
                ),
              ),
            ),
            //  )
          ],
        ),
      ),
    );
  }

  String getStatusString(int status) {
    switch (status) {
      case 0:
        return 'Draft';
      case 1:
        return 'Active';
      case 2:
        return 'InActive';
      case -1:
        return 'Cancelled';
      default:
        return 'Unknown Status';
    }
  }

  List<Widget> getDutyPostLocationName(
      List<String> list, double height, DutyPostNameMasterDetailsState state) {
    List<Widget> widgets = [];
    for (String dutyPostLocationName in list) {
      TextEditingController dutyPostLocationNameController =
          TextEditingController();
      dutyPostLocationNameController.text = dutyPostLocationName;
      widgets.add(Row(
        children: [
          Text(
            dutyPostLocationName,
            textAlign: TextAlign.start,
          ),
          GestureDetector(
            onTap: () {
              // Implement the logic to delete the corresponding record
              // For example, you can show a confirmation dialog and delete the record if confirmed
              deleteDutyPostLocationName(dutyPostLocationName, state);
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: BaseIcons().closeIcon(),
            ), //
          ),
        ],
      ));
      widgets.add(const SizedBox(height: 2));
      widgets.add(CommonWidgets.verticalSpacerWidget(height * 0.01));
    }
    if (widgets.isNotEmpty) {
      return [
        Container(
          decoration: BoxDecoration(
            color: AppColors.lightGreyBackground,
            borderRadius: BorderRadius.circular(5),
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

  void deleteDutyPostLocationName(
      String locationName, DutyPostNameMasterDetailsState state) {
    setState(() {
      // Assuming your state has a list of duty post location names
      // Update the state to remove the specified location name
      state.model.dpName?.remove(locationName);
    });
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

  // Widget cancelButtonDisplay(AttendanceDetailsState state) {
  //   bool condition =state.model.id == null ||
  //       !state.model.lock.isEmptyOrNull ||
  //       state.model.status == ConstantsIntValue.cancelledStatus;
  //   return AppButton(
  //     width: Constants.cancelButtonWidth,
  //     backgroundColor: Colors.white,
  //     key: const Key(Keys.cancelButton),
  //     buttonText: condition
  //         ? Constants.close
  //         : Constants.cancelRecord,
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

  // void updateRecordStatus(AttendanceDetailsState state) {
  //   if (state.model.id != null) {
  //     BlocProvider.of<AttendanceDetailsCubit>(context)
  //         .updateStatus(id: state.model.id.toString());
  //     Navigator.popAndPushNamed(
  //       context,
  //       attendanceListRoute,
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
        BlocProvider.of<AttendanceDetailsCubit>(context)
            .submitForm(isSaveOnly: false);
      },
    );
  }
}
