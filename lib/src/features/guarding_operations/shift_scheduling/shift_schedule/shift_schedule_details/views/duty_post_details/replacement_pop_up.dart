import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/common_widgets/base_widget/date_widgets/available_dates_picker.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/services/attendance_service.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/services/shift_schedule_services.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/shift_schedule_details/views/duty_post_details/cubits/duty_post_details_cubit.dart';

class AddReplacementPopUp extends StatefulWidget {
  const AddReplacementPopUp({
    super.key,
    required this.mainContext,
    required this.model,
    required this.selectedGuards,
    this.dutyPostId,
    this.rankId,
    this.shiftId,
    required this.viaAttendance,
    required this.shiftModel,
  });

  final bool viaAttendance;
  final BuildContext mainContext;
  final Replacement model;
  final Set<BaseUser> selectedGuards;
  final int? dutyPostId;
  final int? rankId;
  final int? shiftId;
  final ShiftModel? shiftModel;

  @override
  State<AddReplacementPopUp> createState() => AddReplacementPopUpState();
}

class AddReplacementPopUpState extends State<AddReplacementPopUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController replacementForController = TextEditingController();
  TextEditingController replacementByController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController reasonController = TextEditingController();

  late List<Label> reasonList;

  @override
  void initState() {
    super.initState();
    log('--widget.model------${widget.model}--');

    replacementForController.text = widget.model.replacedFor?.name ?? '';
    replacementByController.text = widget.model.replacementBy?.name ?? '';

    if (!widget.model.fromDate.isEmptyOrNull) {
      fromDateController.text = Utils.timestampToDateConversion(
          int.parse(widget.model.fromDate ?? '0'), Constants.dateFormat);

      toDateController.text = Utils.timestampToDateConversion(
          int.parse(widget.model.toDate ?? '0'), Constants.dateFormat);
    }
    if (widget.model.id != null) {
      log('--widget.model?.replacementBy?.name------${widget.model.replacementBy?.name}--');
      if (widget.model.replacedFor != null) {
        setDateRange(widget.model.replacedFor!);
      }
    }

    log('widget.model.status--${widget.model.status}----');
    if (widget.model.status != null) {
      Label matchingLabel = shiftScheduleReasonDropDownValues
          .firstWhere((label) => label.value == widget.model.status.toString());

      reasonController.text = matchingLabel.key;
    }
    log('reasonController.text---${reasonController.text}----');

    reasonList = widget.viaAttendance
        ? attendanceReasonDropDownValues
        : shiftScheduleReasonDropDownValues;

    if (widget.viaAttendance) {
      fromDateController.text = Utils().getCurrentDate();
      widget.model.fromDate = Utils().formatTime(fromDateController.text);
    }
  }

  @override
  void dispose() {
    replacementForController.dispose();
    replacementByController.dispose();
    fromDateController.dispose();
    toDateController.dispose();
    reasonController.dispose();
    super.dispose();
  }

  Future<void> setDateRange(BaseUser user) async {
    dates = await ShiftScheduleServices().getNextAvailableReplacementDates(
      rankId: widget.rankId!,
      userId: user.id!,
      dutyPostId: widget.dutyPostId!,
      shiftId: widget.shiftId!,
    );
    setState(() {});
  }

  NextAvailableDateRange? dates;
  bool reasonConditions = false;
  late List<BaseUser> replacementByUsers = [];

  @override
  Widget build(BuildContext context) {
    Label? selectedReason;

    return AlertDialog(
      backgroundColor: AppColors.backgroundWhiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Builder(builder: (context) {
        // Get available height and width of the build area of this widget. Make a choice depending on the size.
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        double divideBy = widget.viaAttendance ? 2.1 : 1.65;
        return SizedBox(
          height: height / divideBy,
          width: width,
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      /// Replacement For
                      CommonWidgets.textDisplay(
                          // state.labels?.locale.guardRank ??
                          //    state.labels?.defaultLocale.guardRank ??
                          Constants.replacementFor,
                          isMandatory: true,
                          Styles.textStyleBlack14),
                      CommonWidgets.verticalSpacerWidget(height * 0.001),
                      TextFieldAddButton(
                        title: replacementForController.text,
                        height: 60,
                        isDisableColor: false,
                        onTap: () {
                          BaseOrganisationDialog().userDialog(
                            context: context,
                            users: widget.selectedGuards.toList(),
                            onTap: (BaseUser user) async {
                              // BlocProvider.of<ShiftScheduleDetailsCubit>(context)
                              //     .updateDropdownValuesReplacement(
                              //   replacementFor: user,
                              // );
                              replacementForController.text = user.name ?? '';
                              widget.model.replacedFor = user;
                              // BlocProvider.of<ShiftScheduleDetailsCubit>(
                              //         widget.mainContext)
                              //     .updateReplacement(widget.model);

                              // TODO: Not to call is widget.viaAttendance is false
                              if (!widget.viaAttendance) {
                                if (widget.rankId != null) {
                                  showLoadingDialog(context);

                                  dates = await ShiftScheduleServices()
                                      .getNextAvailableReplacementDates(
                                    rankId: widget.rankId!,
                                    userId: user.id!,
                                    dutyPostId: widget.dutyPostId!,
                                    shiftId: widget.shiftId!,
                                  );
                                  dismissLoadingDialog(context);
                                }
                              }

                              // BlocProvider.of<DutyPostDetailsCubit>(
                              //         widget.mainContext)
                              //     .getNextAvailableReplacementDates(
                              //         userId: user.id!);

                              setState(() {
                                log('-setstate-');
                                replacementForController.text = user.name ?? '';
                              });
                            },
                            locationId: 0,
                          );
                        },
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// Reason
                      CommonWidgets.textDisplay(
                        Constants.reason,
                        Styles.textStyleBlack14,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.001),
                      BaseDropDown().getDropDown(
                        isDisabled: false,
                        textController: reasonController,
                        items: reasonList,
                        onTap: () {
                          if (!isReplacedForSelected.status) {
                            Validator().showToast(
                              context,
                              isReplacedForSelected.message,
                            );
                            return;
                          }
                          BaseDropDown().assetTypeDialog(
                            context: context,
                            dropDownValues:
                                reasonList.map((label) => label.key).toList(),
                            onTap: (String value) {
                              selectedReason =
                                  shiftScheduleReasonDropDownValues.firstWhere(
                                (label) => label.key == value,
                                orElse: () => const Label(key: '', value: ''),
                              );

                              if (widget.viaAttendance) {
                                getReplacementByUserListForAttendance();
                              }
                              setState(() {
                                reasonConditions = (selectedReason != null &&
                                    (selectedReason!.value == '1' ||
                                        selectedReason!.value == '2'));
                              });
                              log('--reasonConditions-$reasonConditions-');

                              widget.model.status =
                                  int.tryParse(selectedReason!.value);
                              reasonController.text = selectedReason!.key;
                            },
                          );
                        },
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.001),

                      /// From Date - Shift Schedule
                      CommonWidgets.textDisplay(
                        // state.labels?.locale.dateOfBirth ??
                        //  state.labels?.defaultLocale.dateOfBirth ??
                        Constants.fromDate,
                        isMandatory: true,
                        Styles.textStyleBlack14,
                      ),
                      if (!widget.viaAttendance) ...[
                        LimitedDatePicker(
                          textController: fromDateController,
                          availableDates: dates?.availableDates ?? [],
                          isDisabled: false,
                          onChange: (String value) async {
                            widget.model.fromDate = Utils().formatTime(value);
                            if (reasonConditions) {
                              log('--iffffff-reasonConditions--');
                              toDateController.text = fromDateController.text;
                              await getReplacementByUserList();

                              setState(() {
                                widget.model.toDate = Utils().formatTime(value);
                                toDateController.text = fromDateController.text;
                              });
                            }
                          },
                        ),
                      ] else ...[
                        /// From Date - Attendance
                        BaseDate().datePickerWidgetLoading(
                          textController: fromDateController,
                          isDisabled: true,
                          onlyDate: false,
                          showPastDate: false,
                          notFlagDate: true,
                          // startDate: '1727677800',
                          onChange: (String value) {
                            widget.model.fromDate = Utils().formatTime(value);
                          },
                          context: context,
                        )
                      ],
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// To Date
                      if (!widget.viaAttendance) ...[
                        CommonWidgets.textDisplay(
                          // state.labels?.locale.dateOfBirth ??
                          //   state.labels?.defaultLocale.dateOfBirth ??
                          Constants.toDate,
                          isMandatory: true,
                          Styles.textStyleBlack14,
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.001),
                        LimitedDatePicker(
                          textController: toDateController,
                          availableDates: dates?.availableDates ?? [],
                          onChange: (String value) async {
                            widget.model.toDate = Utils().formatTime(value);
                            await getReplacementByUserList();
                          },
                          isDisabled: reasonConditions,
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.01),
                      ],

                      /// Replacement By
                      CommonWidgets.textDisplay(
                          // state.labels?.locale.guardRank ??
                          //    state.labels?.defaultLocale.guardRank ??
                          Constants.replacementBy,
                          isMandatory: false,
                          Styles.textStyleBlack14),

                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      TextFieldAddButton(
                        title: replacementByController.text,
                        height: 60,
                        isDisableColor: false,
                        onTap: () {
                          BaseOrganisationDialog().userDialog(
                            context: context,
                            users: replacementByUsers,
                            onTap: (BaseUser user) {
                              replacementByController.text = user.name ?? '';
                              widget.model.replacementBy = user;
                              // BlocProvider.of<ShiftScheduleDetailsCubit>(
                              //         widget.mainContext)
                              //     .updateReplacement(widget.model);

                              setState(() {
                                replacementByController.text = user.name ?? '';
                              });
                            },
                            locationId: 0,
                          );
                        },
                      ),

                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      buttonViews(widget.mainContext, width),
                      CommonWidgets.verticalSpacerWidget(height * 0.02),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Future<void> getReplacementByUserListForAttendance() async {
    if (fromDateController.text.isEmptyOrNull) {
      return;
    }
    replacementByUsers = await AttendanceServices().getAttAvailableGuardsByDate(
      dutyPostId: widget.shiftModel!.attendanceShiftId!,
      rankId: widget.rankId!,
      shiftId: widget.shiftId!,
      fromDate: Utils().convertToDateFormat(fromDateController.text),
    );

    replacementByController.clear();
  }

  Future<void> getReplacementByUserList() async {
    if (fromDateController.text.isEmptyOrNull ||
        toDateController.text.isEmptyOrNull) {
      return;
    }

    if (!areValidDates.status) {
      Validator().showToast(
        context,
        areValidDates.message,
      );
      return;
    }
    replacementByUsers = await ShiftScheduleServices().getAvailableGuardsByDate(
      dutyPostId: widget.dutyPostId!,
      rankId: widget.rankId!,
      shiftId: widget.shiftId!,
      fromDate: fromDateController.text,
      toDate: toDateController.text,
    );

    replacementByController.clear();
  }

  Widget buttonViews(BuildContext context, double width) {
    return Row(
      //mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[cancelButton(width), saveButton(width)],
    );
  }

  Widget cancelButton(double width) {
    return PopButton(
      width: width / 3.5,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.cancel,
      buttonTextKey: Keys.cancelButtonText,
      foregroundColor: AppColors.textGreyThemeColor,
      textStyle: Styles.styleHeaderGreyText16,
      boarderColor: AppColors.textGreyThemeColor,
      onTap: () {
        FocusScope.of(context).unfocus();
        Navigator.of(context).pop();
      },
    );
  }

  Widget saveButton(double width) {
    return AppButton(
      width: width / 3.5,
      key: const Key(Keys.saveButton),
      buttonText: Constants.save,
      buttonTextKey: Keys.saveButtonText,
      backgroundColor: AppColors.navigationSkyBlueColor,
      onTap: () {
        if (!isFormValid.status) {
          Validator().showToast(
            context,
            isFormValid.message,
          );
          return;
        }

        /// Assigning temporary Id in order to update is properly
        if (widget.model.id == null && widget.model.tempId.isEmptyOrNull) {
          widget.model.tempId = Utils.createCryptoRandomString();
        }
        log('--Add/Update Replacement--- ${(widget.model.id)}--${widget.model.toString()}-');
        log('-widget.model.tempId---${widget.model.tempId}----');
        // widget.model?.dutyPostLocationName = dutyPostLocationNameController.text;

        if (widget.viaAttendance) {
          BlocProvider.of<AttendanceShiftsCubit>(widget.mainContext)
              .updateReplacement(context, widget.model);
        } else {
          BlocProvider.of<DutyPostDetailsCubit>(widget.mainContext)
              .updateReplacement(context, widget.model);
        }
        // widget.refreshFunction; // this function is not being called

        // Navigator.pop(context);
      },
    );
  }

  ErrorResponse get isReplacedForSelected {
    if (replacementForController.text.isEmptyOrNull) {
      return const ErrorResponse(
          status: false, message: 'Please enter Replacement For');
    }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  ErrorResponse get areValidDates {
    final fromDate = DateTime.tryParse(fromDateController.text);
    final toDate = DateTime.tryParse(toDateController.text);

    log('--fromDate-$fromDate-');

    if (fromDate != null && toDate != null) {
      if (fromDate.isAfter(toDate)) {
        // Show an error dialog or handle the error as needed
        return const ErrorResponse(
            status: false,
            message: 'From Date cannot be later than the To Date');
      }
    }
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  ErrorResponse get isFormValid {
    if (replacementForController.text.isEmptyOrNull) {
      return const ErrorResponse(
          status: false, message: 'Please enter Replacement For');
    }

    if (reasonController.text.isEmptyOrNull) {
      return const ErrorResponse(status: false, message: 'Please enter Reason');
    }
    if (fromDateController.text.isEmptyOrNull) {
      return const ErrorResponse(
          status: false, message: 'Please enter From Date');
    }
    if (!widget.viaAttendance) {
      if (toDateController.text.isEmptyOrNull) {
        return const ErrorResponse(
            status: false, message: 'Please enter To Date');
      }
    }

    final fromDate = DateTime.tryParse(fromDateController.text);
    final toDate = DateTime.tryParse(toDateController.text);

    log('--fromDate-$fromDate-');

    if (fromDate != null && toDate != null) {
      if (fromDate.isAfter(toDate)) {
        // Show an error dialog or handle the error as needed
        return const ErrorResponse(
            status: false,
            message: 'From Date cannot be later than the To Date');
      }
    }

    // if (replacementByController.text.isEmptyOrNull) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Replacement By');
    // }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }
}
