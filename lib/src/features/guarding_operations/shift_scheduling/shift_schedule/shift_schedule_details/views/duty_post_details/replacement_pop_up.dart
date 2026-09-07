// // // // // // import 'dart:developer';
// // // // // //
// // // // // // import 'package:db_atom/index.dart';
// // // // // // import 'package:db_atom/src/common_widgets/base_widget/date_widgets/available_dates_picker.dart';
// // // // // // import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/services/attendance_service.dart';
// // // // // // import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/services/shift_schedule_services.dart';
// // // // // // import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/shift_schedule_details/views/duty_post_details/cubits/duty_post_details_cubit.dart';
// // // // // //
// // // // // // class AddReplacementPopUp extends StatefulWidget {
// // // // // //   const AddReplacementPopUp({
// // // // // //     super.key,
// // // // // //     required this.mainContext,
// // // // // //     required this.model,
// // // // // //     required this.selectedGuards,
// // // // // //     this.dutyPostId,
// // // // // //     this.rankId,
// // // // // //     this.shiftId,
// // // // // //     required this.viaAttendance,
// // // // // //     required this.shiftModel,
// // // // // //   });
// // // // // //
// // // // // //   final bool viaAttendance;
// // // // // //   final BuildContext mainContext;
// // // // // //   final Replacement model;
// // // // // //   final Set<BaseUser> selectedGuards;
// // // // // //   final int? dutyPostId;
// // // // // //   final int? rankId;
// // // // // //   final int? shiftId;
// // // // // //   final ShiftModel? shiftModel;
// // // // // //
// // // // // //   @override
// // // // // //   State<AddReplacementPopUp> createState() => AddReplacementPopUpState();
// // // // // // }
// // // // // //
// // // // // // class AddReplacementPopUpState extends State<AddReplacementPopUp> {
// // // // // //   final _formKey = GlobalKey<FormState>();
// // // // // //   TextEditingController replacementForController = TextEditingController();
// // // // // //   TextEditingController replacementByController = TextEditingController();
// // // // // //   TextEditingController fromDateController = TextEditingController();
// // // // // //   TextEditingController toDateController = TextEditingController();
// // // // // //   TextEditingController reasonController = TextEditingController();
// // // // // //
// // // // // //   late List<Label> reasonList;
// // // // // //
// // // // // //   @override
// // // // // //   void initState() {
// // // // // //     super.initState();
// // // // // //     log('--widget.model------${widget.model}--');
// // // // // //
// // // // // //     replacementForController.text = widget.model.replacedFor?.name ?? '';
// // // // // //     replacementByController.text = widget.model.replacementBy?.name ?? '';
// // // // // //
// // // // // //     if (!widget.model.fromDate.isEmptyOrNull) {
// // // // // //       fromDateController.text = Utils.timestampToDateConversion(
// // // // // //           int.parse(widget.model.fromDate ?? '0'), Constants.dateFormat);
// // // // // //
// // // // // //       toDateController.text = Utils.timestampToDateConversion(
// // // // // //           int.parse(widget.model.toDate ?? '0'), Constants.dateFormat);
// // // // // //     }
// // // // // //     if (widget.model.id != null) {
// // // // // //       log('--widget.model?.replacementBy?.name------${widget.model.replacementBy?.name}--');
// // // // // //       if (widget.model.replacedFor != null) {
// // // // // //         setDateRange(widget.model.replacedFor!);
// // // // // //       }
// // // // // //     }
// // // // // //
// // // // // //     log('widget.model.status--${widget.model.status}----');
// // // // // //     if (widget.model.status != null) {
// // // // // //       Label matchingLabel = shiftScheduleReasonDropDownValues
// // // // // //           .firstWhere((label) => label.value == widget.model.status.toString());
// // // // // //
// // // // // //       reasonController.text = matchingLabel.key;
// // // // // //     }
// // // // // //     log('reasonController.text---${reasonController.text}----');
// // // // // //
// // // // // //     reasonList = widget.viaAttendance
// // // // // //         ? attendanceReasonDropDownValues
// // // // // //         : shiftScheduleReasonDropDownValues;
// // // // // //
// // // // // //     if (widget.viaAttendance) {
// // // // // //       fromDateController.text = Utils().getCurrentDate();
// // // // // //       widget.model.fromDate = Utils().formatTime(fromDateController.text);
// // // // // //     }
// // // // // //   }
// // // // // //
// // // // // //   @override
// // // // // //   void dispose() {
// // // // // //     replacementForController.dispose();
// // // // // //     replacementByController.dispose();
// // // // // //     fromDateController.dispose();
// // // // // //     toDateController.dispose();
// // // // // //     reasonController.dispose();
// // // // // //     super.dispose();
// // // // // //   }
// // // // // //
// // // // // //   Future<void> setDateRange(BaseUser user) async {
// // // // // //     dates = await ShiftScheduleServices().getNextAvailableReplacementDates(
// // // // // //       rankId: widget.rankId!,
// // // // // //       userId: user.id!,
// // // // // //       dutyPostId: widget.dutyPostId!,
// // // // // //       shiftId: widget.shiftId!,
// // // // // //     );
// // // // // //     setState(() {});
// // // // // //   }
// // // // // //
// // // // // //   NextAvailableDateRange? dates;
// // // // // //   bool reasonConditions = false;
// // // // // //   late List<BaseUser> replacementByUsers = [];
// // // // // //
// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     Label? selectedReason;
// // // // // //
// // // // // //     return AlertDialog(
// // // // // //       backgroundColor: Colors.transparent,
// // // // // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
// // // // // //       content: Builder(builder: (context) {
// // // // // //         // Get available height and width of the build area of this widget. Make a choice depending on the size.
// // // // // //         var height = MediaQuery.of(context).size.height;
// // // // // //         var width = MediaQuery.of(context).size.width;
// // // // // //         double divideBy = widget.viaAttendance ? 2.1 : 1.65;
// // // // // //         return SizedBox(
// // // // // //           height: height / divideBy,
// // // // // //           width: width,
// // // // // //           child: Stack(
// // // // // //             clipBehavior: Clip.none,
// // // // // //             children: <Widget>[
// // // // // //               Form(
// // // // // //                 key: _formKey,
// // // // // //                 child: SingleChildScrollView(
// // // // // //                   child: Column(
// // // // // //                     mainAxisSize: MainAxisSize.min,
// // // // // //                     children: <Widget>[
// // // // // //                       /// Replacement For
// // // // // //                       CommonWidgets.textDisplay(
// // // // // //                           // state.labels?.locale.guardRank ??
// // // // // //                           //    state.labels?.defaultLocale.guardRank ??
// // // // // //                           Constants.replacementFor,
// // // // // //                           isMandatory: true,
// // // // // //                           Styles.textStyleBlack14),
// // // // // //                       CommonWidgets.verticalSpacerWidget(height * 0.001),
// // // // // //                       TextFieldAddButton(
// // // // // //                         title: replacementForController.text,
// // // // // //                         height: 60,
// // // // // //                         isDisableColor: false,
// // // // // //                         onTap: () {
// // // // // //                           BaseOrganisationDialog().userDialog(
// // // // // //                             context: context,
// // // // // //                             users: widget.selectedGuards.toList(),
// // // // // //                             onTap: (BaseUser user) async {
// // // // // //                               // BlocProvider.of<ShiftScheduleDetailsCubit>(context)
// // // // // //                               //     .updateDropdownValuesReplacement(
// // // // // //                               //   replacementFor: user,
// // // // // //                               // );
// // // // // //                               replacementForController.text = user.name ?? '';
// // // // // //                               widget.model.replacedFor = user;
// // // // // //                               // BlocProvider.of<ShiftScheduleDetailsCubit>(
// // // // // //                               //         widget.mainContext)
// // // // // //                               //     .updateReplacement(widget.model);
// // // // // //
// // // // // //                               // TODO: Not to call is widget.viaAttendance is false
// // // // // //                               if (!widget.viaAttendance) {
// // // // // //                                 if (widget.rankId != null) {
// // // // // //                                   showLoadingDialog(context);
// // // // // //
// // // // // //                                   dates = await ShiftScheduleServices()
// // // // // //                                       .getNextAvailableReplacementDates(
// // // // // //                                     rankId: widget.rankId!,
// // // // // //                                     userId: user.id!,
// // // // // //                                     dutyPostId: widget.dutyPostId!,
// // // // // //                                     shiftId: widget.shiftId!,
// // // // // //                                   );
// // // // // //                                   dismissLoadingDialog(context);
// // // // // //                                 }
// // // // // //                               }
// // // // // //
// // // // // //                               // BlocProvider.of<DutyPostDetailsCubit>(
// // // // // //                               //         widget.mainContext)
// // // // // //                               //     .getNextAvailableReplacementDates(
// // // // // //                               //         userId: user.id!);
// // // // // //
// // // // // //                               setState(() {
// // // // // //                                 log('-setstate-');
// // // // // //                                 replacementForController.text = user.name ?? '';
// // // // // //                               });
// // // // // //                             },
// // // // // //                             locationId: 0,
// // // // // //                           );
// // // // // //                         },
// // // // // //                       ),
// // // // // //                       CommonWidgets.verticalSpacerWidget(height * 0.01),
// // // // // //
// // // // // //                       /// Reason
// // // // // //                       CommonWidgets.textDisplay(
// // // // // //                         Constants.reason,
// // // // // //                         Styles.textStyleBlack14,
// // // // // //                       ),
// // // // // //                       CommonWidgets.verticalSpacerWidget(height * 0.001),
// // // // // //                       BaseDropDown().getDropDown(
// // // // // //                         isDisabled: false,
// // // // // //                         textController: reasonController,
// // // // // //                         items: reasonList,
// // // // // //                         onTap: () {
// // // // // //                           if (!isReplacedForSelected.status) {
// // // // // //                             Validator().showToast(
// // // // // //                               context,
// // // // // //                               isReplacedForSelected.message,
// // // // // //                             );
// // // // // //                             return;
// // // // // //                           }
// // // // // //                           BaseDropDown().assetTypeDialog(
// // // // // //                             context: context,
// // // // // //                             dropDownValues:
// // // // // //                                 reasonList.map((label) => label.key).toList(),
// // // // // //                             onTap: (String value) {
// // // // // //                               selectedReason =
// // // // // //                                   shiftScheduleReasonDropDownValues.firstWhere(
// // // // // //                                 (label) => label.key == value,
// // // // // //                                 orElse: () => const Label(key: '', value: ''),
// // // // // //                               );
// // // // // //
// // // // // //                               if (widget.viaAttendance) {
// // // // // //                                 getReplacementByUserListForAttendance();
// // // // // //                               }
// // // // // //                               setState(() {
// // // // // //                                 reasonConditions = (selectedReason != null &&
// // // // // //                                     (selectedReason!.value == '1' ||
// // // // // //                                         selectedReason!.value == '2'));
// // // // // //                               });
// // // // // //                               log('--reasonConditions-$reasonConditions-');
// // // // // //
// // // // // //                               widget.model.status =
// // // // // //                                   int.tryParse(selectedReason!.value);
// // // // // //                               reasonController.text = selectedReason!.key;
// // // // // //                             },
// // // // // //                           );
// // // // // //                         },
// // // // // //                       ),
// // // // // //                       CommonWidgets.verticalSpacerWidget(height * 0.001),
// // // // // //
// // // // // //                       /// From Date - Shift Schedule
// // // // // //                       CommonWidgets.textDisplay(
// // // // // //                         // state.labels?.locale.dateOfBirth ??
// // // // // //                         //  state.labels?.defaultLocale.dateOfBirth ??
// // // // // //                         Constants.fromDate,
// // // // // //                         isMandatory: true,
// // // // // //                         Styles.textStyleBlack14,
// // // // // //                       ),
// // // // // //                       if (!widget.viaAttendance) ...[
// // // // // //                         LimitedDatePicker(
// // // // // //                           textController: fromDateController,
// // // // // //                           availableDates: dates?.availableDates ?? [],
// // // // // //                           isDisabled: false,
// // // // // //                           onChange: (String value) async {
// // // // // //                             widget.model.fromDate = Utils().formatTime(value);
// // // // // //                             if (reasonConditions) {
// // // // // //                               log('--iffffff-reasonConditions--');
// // // // // //                               toDateController.text = fromDateController.text;
// // // // // //                               await getReplacementByUserList();
// // // // // //
// // // // // //                               setState(() {
// // // // // //                                 widget.model.toDate = Utils().formatTime(value);
// // // // // //                                 toDateController.text = fromDateController.text;
// // // // // //                               });
// // // // // //                             }
// // // // // //                           },
// // // // // //                         ),
// // // // // //                       ] else ...[
// // // // // //                         /// From Date - Attendance
// // // // // //                         BaseDate().datePickerWidgetLoading(
// // // // // //                           textController: fromDateController,
// // // // // //                           isDisabled: true,
// // // // // //                           onlyDate: false,
// // // // // //                           showPastDate: false,
// // // // // //                           notFlagDate: true,
// // // // // //                           // startDate: '1727677800',
// // // // // //                           onChange: (String value) {
// // // // // //                             widget.model.fromDate = Utils().formatTime(value);
// // // // // //                           },
// // // // // //                           context: context,
// // // // // //                         )
// // // // // //                       ],
// // // // // //                       CommonWidgets.verticalSpacerWidget(height * 0.01),
// // // // // //
// // // // // //                       /// To Date
// // // // // //                       if (!widget.viaAttendance) ...[
// // // // // //                         CommonWidgets.textDisplay(
// // // // // //                           // state.labels?.locale.dateOfBirth ??
// // // // // //                           //   state.labels?.defaultLocale.dateOfBirth ??
// // // // // //                           Constants.toDate,
// // // // // //                           isMandatory: true,
// // // // // //                           Styles.textStyleBlack14,
// // // // // //                         ),
// // // // // //                         CommonWidgets.verticalSpacerWidget(height * 0.001),
// // // // // //                         LimitedDatePicker(
// // // // // //                           textController: toDateController,
// // // // // //                           availableDates: dates?.availableDates ?? [],
// // // // // //                           onChange: (String value) async {
// // // // // //                             widget.model.toDate = Utils().formatTime(value);
// // // // // //                             await getReplacementByUserList();
// // // // // //                           },
// // // // // //                           isDisabled: reasonConditions,
// // // // // //                         ),
// // // // // //                         CommonWidgets.verticalSpacerWidget(height * 0.01),
// // // // // //                       ],
// // // // // //
// // // // // //                       /// Replacement By
// // // // // //                       CommonWidgets.textDisplay(
// // // // // //                           // state.labels?.locale.guardRank ??
// // // // // //                           //    state.labels?.defaultLocale.guardRank ??
// // // // // //                           Constants.replacementBy,
// // // // // //                           isMandatory: true,
// // // // // //                           Styles.textStyleBlack14),
// // // // // //
// // // // // //                       CommonWidgets.verticalSpacerWidget(height * 0.01),
// // // // // //                       TextFieldAddButton(
// // // // // //                         title: replacementByController.text,
// // // // // //                         height: 60,
// // // // // //                         isDisableColor: false,
// // // // // //                         onTap: () {
// // // // // //                           BaseOrganisationDialog().userDialog(
// // // // // //                             context: context,
// // // // // //                             users: replacementByUsers,
// // // // // //                             onTap: (BaseUser user) {
// // // // // //                               replacementByController.text = user.name ?? '';
// // // // // //                               widget.model.replacementBy = user;
// // // // // //                               // BlocProvider.of<ShiftScheduleDetailsCubit>(
// // // // // //                               //         widget.mainContext)
// // // // // //                               //     .updateReplacement(widget.model);
// // // // // //
// // // // // //                               setState(() {
// // // // // //                                 replacementByController.text = user.name ?? '';
// // // // // //                               });
// // // // // //                             },
// // // // // //                             locationId: 0,
// // // // // //                           );
// // // // // //                         },
// // // // // //                       ),
// // // // // //
// // // // // //                       CommonWidgets.verticalSpacerWidget(height * 0.01),
// // // // // //                       CommonWidgets.verticalSpacerWidget(height * 0.01),
// // // // // //                       buttonViews(widget.mainContext, width),
// // // // // //                       CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // // // //                     ],
// // // // // //                   ),
// // // // // //                 ),
// // // // // //               ),
// // // // // //             ],
// // // // // //           ),
// // // // // //         );
// // // // // //       }),
// // // // // //     );
// // // // // //   }
// // // // // //
// // // // // //   Future<void> getReplacementByUserListForAttendance() async {
// // // // // //     if (fromDateController.text.isEmptyOrNull) {
// // // // // //       return;
// // // // // //     }
// // // // // //     replacementByUsers = await AttendanceServices().getAttAvailableGuardsByDate(
// // // // // //       dutyPostId: widget.shiftModel!.attendanceShiftId!,
// // // // // //       rankId: widget.rankId!,
// // // // // //       shiftId: widget.shiftId!,
// // // // // //       fromDate: Utils().convertToDateFormat(fromDateController.text),
// // // // // //     );
// // // // // //
// // // // // //     replacementByController.clear();
// // // // // //   }
// // // // // //
// // // // // //   Future<void> getReplacementByUserList() async {
// // // // // //     if (fromDateController.text.isEmptyOrNull ||
// // // // // //         toDateController.text.isEmptyOrNull) {
// // // // // //       return;
// // // // // //     }
// // // // // //
// // // // // //     if (!areValidDates.status) {
// // // // // //       Validator().showToast(
// // // // // //         context,
// // // // // //         areValidDates.message,
// // // // // //       );
// // // // // //       return;
// // // // // //     }
// // // // // //     replacementByUsers = await ShiftScheduleServices().getAvailableGuardsByDate(
// // // // // //       dutyPostId: widget.dutyPostId!,
// // // // // //       rankId: widget.rankId!,
// // // // // //       shiftId: widget.shiftId!,
// // // // // //       fromDate: fromDateController.text,
// // // // // //       toDate: toDateController.text,
// // // // // //     );
// // // // // //
// // // // // //     replacementByController.clear();
// // // // // //   }
// // // // // //
// // // // // //   Widget buttonViews(BuildContext context, double width) {
// // // // // //     return Row(
// // // // // //       //mainAxisSize: MainAxisSize.min,
// // // // // //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // // // // //       children: <Widget>[cancelButton(width), saveButton(width)],
// // // // // //     );
// // // // // //   }
// // // // // //
// // // // // //   Widget cancelButton(double width) {
// // // // // //     return PopButton(
// // // // // //       width: width / 3.5,
// // // // // //       key: const Key(Keys.cancelButton),
// // // // // //       buttonText: Constants.cancel,
// // // // // //       buttonTextKey: Keys.cancelButtonText,
// // // // // //       foregroundColor: AppColors.textGreyThemeColor,
// // // // // //       textStyle: Styles.styleHeaderGreyText16,
// // // // // //       boarderColor: AppColors.textGreyThemeColor,
// // // // // //       onTap: () {
// // // // // //         FocusScope.of(context).unfocus();
// // // // // //         Navigator.of(context).pop();
// // // // // //       },
// // // // // //     );
// // // // // //   }
// // // // // //
// // // // // //   Widget saveButton(double width) {
// // // // // //     return AppButton(
// // // // // //       width: width / 3.5,
// // // // // //       key: const Key(Keys.saveButton),
// // // // // //       buttonText: Constants.save,
// // // // // //       buttonTextKey: Keys.saveButtonText,
// // // // // //       backgroundColor: AppColors.navigationSkyBlueColor,
// // // // // //       onTap: () {
// // // // // //         if (!isFormValid.status) {
// // // // // //           Validator().showToast(
// // // // // //             context,
// // // // // //             isFormValid.message,
// // // // // //           );
// // // // // //           return;
// // // // // //         }
// // // // // //
// // // // // //         /// Assigning temporary Id in order to update is properly
// // // // // //         if (widget.model.id == null && widget.model.tempId.isEmptyOrNull) {
// // // // // //           widget.model.tempId = Utils.createCryptoRandomString();
// // // // // //         }
// // // // // //         log('--Add/Update Replacement--- ${(widget.model.id)}--${widget.model.toString()}-');
// // // // // //         log('-widget.model.tempId---${widget.model.tempId}----');
// // // // // //         // widget.model?.dutyPostLocationName = dutyPostLocationNameController.text;
// // // // // //
// // // // // //         if (widget.viaAttendance) {
// // // // // //           BlocProvider.of<AttendanceShiftsCubit>(widget.mainContext)
// // // // // //               .updateReplacement(context, widget.model,false,false,true);
// // // // // //         } else {
// // // // // //           BlocProvider.of<DutyPostDetailsCubit>(widget.mainContext)
// // // // // //               .updateReplacement(context, widget.model);
// // // // // //         }
// // // // // //         // widget.refreshFunction; // this function is not being called
// // // // // //
// // // // // //         // Navigator.pop(context);
// // // // // //       },
// // // // // //     );
// // // // // //   }
// // // // // //
// // // // // //   ErrorResponse get isReplacedForSelected {
// // // // // //     if (replacementForController.text.isEmptyOrNull) {
// // // // // //       return const ErrorResponse(
// // // // // //           status: false, message: 'Please enter Replacement For');
// // // // // //     }
// // // // // //
// // // // // //     return const ErrorResponse(status: true, message: 'Form is Valid');
// // // // // //   }
// // // // // //
// // // // // //   ErrorResponse get areValidDates {
// // // // // //     final fromDate = DateTime.tryParse(fromDateController.text);
// // // // // //     final toDate = DateTime.tryParse(toDateController.text);
// // // // // //
// // // // // //     log('--fromDate-$fromDate-');
// // // // // //
// // // // // //     if (fromDate != null && toDate != null) {
// // // // // //       if (fromDate.isAfter(toDate)) {
// // // // // //         // Show an error dialog or handle the error as needed
// // // // // //         return const ErrorResponse(
// // // // // //             status: false,
// // // // // //             message: 'From Date cannot be later than the To Date');
// // // // // //       }
// // // // // //     }
// // // // // //     return const ErrorResponse(status: true, message: 'Form is Valid');
// // // // // //   }
// // // // // //
// // // // // //   ErrorResponse get isFormValid {
// // // // // //     if (replacementForController.text.isEmptyOrNull) {
// // // // // //       return const ErrorResponse(
// // // // // //           status: false, message: 'Please enter Replacement For');
// // // // // //     }
// // // // // //
// // // // // //     if (reasonController.text.isEmptyOrNull) {
// // // // // //       return const ErrorResponse(status: false, message: 'Please enter Reason');
// // // // // //     }
// // // // // //     if (fromDateController.text.isEmptyOrNull) {
// // // // // //       return const ErrorResponse(
// // // // // //           status: false, message: 'Please enter From Date');
// // // // // //     }
// // // // // //     if (!widget.viaAttendance) {
// // // // // //       if (toDateController.text.isEmptyOrNull) {
// // // // // //         return const ErrorResponse(
// // // // // //             status: false, message: 'Please enter To Date');
// // // // // //       }
// // // // // //     }
// // // // // //
// // // // // //     final fromDate = DateTime.tryParse(fromDateController.text);
// // // // // //     final toDate = DateTime.tryParse(toDateController.text);
// // // // // //
// // // // // //     log('--fromDate-$fromDate-');
// // // // // //
// // // // // //     if (fromDate != null && toDate != null) {
// // // // // //       if (fromDate.isAfter(toDate)) {
// // // // // //         // Show an error dialog or handle the error as needed
// // // // // //         return const ErrorResponse(
// // // // // //             status: false,
// // // // // //             message: 'From Date cannot be later than the To Date');
// // // // // //       }
// // // // // //     }
// // // // // //
// // // // // //     if (replacementByController.text.isEmptyOrNull) {
// // // // // //       return const ErrorResponse(
// // // // // //           status: false, message: 'Please enter Replacement By');
// // // // // //     }
// // // // // //
// // // // // //     return const ErrorResponse(status: true, message: 'Form is Valid');
// // // // // //   }
// // // // // // }
// // // // // import 'dart:developer';
// // // // // import 'dart:ui';
// // // // //
// // // // // import 'package:db_atom/index.dart';
// // // // // import 'package:db_atom/src/common_widgets/base_widget/date_widgets/available_dates_picker.dart';
// // // // // import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/services/attendance_service.dart';
// // // // // import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/services/shift_schedule_services.dart';
// // // // // import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/shift_schedule_details/views/duty_post_details/cubits/duty_post_details_cubit.dart';
// // // // //
// // // // // class AddReplacementPopUp extends StatefulWidget {
// // // // //   const AddReplacementPopUp({
// // // // //     super.key,
// // // // //     required this.mainContext,
// // // // //     required this.model,
// // // // //     required this.selectedGuards,
// // // // //     this.dutyPostId,
// // // // //     this.rankId,
// // // // //     this.shiftId,
// // // // //     this.attendanceId,
// // // // //     required this.viaAttendance,
// // // // //     required this.shiftModel,
// // // // //     this.attendanceModel,
// // // // //   });
// // // // //
// // // // //   final bool viaAttendance;
// // // // //   final BuildContext mainContext;
// // // // //   final Replacement model;
// // // // //   final Set<BaseUser> selectedGuards;
// // // // //   final int? dutyPostId;
// // // // //   final int? rankId;
// // // // //   final int? shiftId;
// // // // //   final int? attendanceId;
// // // // //   final ShiftModel? shiftModel;
// // // // //   final AttendanceModel? attendanceModel;
// // // // //
// // // // //   @override
// // // // //   State<AddReplacementPopUp> createState() => AddReplacementPopUpState();
// // // // // }
// // // // //
// // // // // class AddReplacementPopUpState extends State<AddReplacementPopUp> {
// // // // //   final _formKey = GlobalKey<FormState>();
// // // // //   TextEditingController replacementForController = TextEditingController();
// // // // //   TextEditingController replacementByController = TextEditingController();
// // // // //   TextEditingController fromDateController = TextEditingController();
// // // // //   TextEditingController toDateController = TextEditingController();
// // // // //   TextEditingController reasonController = TextEditingController();
// // // // //   TextEditingController replacementTypeController = TextEditingController();
// // // // //
// // // // //   late List<Label> reasonList;
// // // // //   late List<Label> replacementTypeList;
// // // // //
// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     log('--widget.model------${widget.model}--');
// // // // //
// // // // //     replacementForController.text = widget.model.replacedFor?.name ?? '';
// // // // //     replacementByController.text = widget.model.replacementBy?.name ?? '';
// // // // //     if (widget.model.replacementType != null) {
// // // // //       final matchingType = replacementTypeDropDownValues.firstWhere(
// // // // //             (label) => label.value == widget.model.replacementType.toString(),
// // // // //         orElse: () => const Label(key: '', value: ''),
// // // // //       );
// // // // //
// // // // //       replacementTypeController.text = matchingType.key;
// // // // //     }
// // // // //     replacementTypeList = replacementTypeDropDownValues;
// // // // //
// // // // //
// // // // //     if (!widget.model.fromDate.isEmptyOrNull) {
// // // // //       fromDateController.text = Utils.timestampToDateConversion(
// // // // //           int.parse(widget.model.fromDate ?? '0'), Constants.dateFormat);
// // // // //
// // // // //       toDateController.text = Utils.timestampToDateConversion(
// // // // //           int.parse(widget.model.toDate ?? '0'), Constants.dateFormat);
// // // // //     }
// // // // //     if (widget.model.id != null) {
// // // // //       log('--widget.model?.replacementBy?.name------${widget.model.replacementBy?.name}--');
// // // // //       if (widget.model.replacedFor != null) {
// // // // //         setDateRange(widget.model.replacedFor!);
// // // // //       }
// // // // //     }
// // // // //
// // // // //     log('widget.model.status--${widget.model.status}----');
// // // // //     if (widget.model.status != null) {
// // // // //       Label matchingLabel = shiftScheduleReasonDropDownValues
// // // // //           .firstWhere((label) => label.value == widget.model.status.toString());
// // // // //
// // // // //       reasonController.text = matchingLabel.key;
// // // // //     }
// // // // //     log('reasonController.text---${reasonController.text}----');
// // // // //
// // // // //     reasonList = widget.viaAttendance
// // // // //         ? attendanceReasonDropDownValues
// // // // //         : shiftScheduleReasonDropDownValues;
// // // // //
// // // // //     if (widget.viaAttendance) {
// // // // //       fromDateController.text = Utils().getCurrentDate();
// // // // //       widget.model.fromDate = Utils().formatTime(fromDateController.text);
// // // // //     }
// // // // //   }
// // // // //
// // // // //   @override
// // // // //   void dispose() {
// // // // //     replacementForController.dispose();
// // // // //     replacementByController.dispose();
// // // // //     fromDateController.dispose();
// // // // //     toDateController.dispose();
// // // // //     reasonController.dispose();
// // // // //     replacementTypeController.dispose();
// // // // //     super.dispose();
// // // // //   }
// // // // //
// // // // //   Future<void> setDateRange(BaseUser user) async {
// // // // //     dates = await ShiftScheduleServices().getNextAvailableReplacementDates(
// // // // //       rankId: widget.rankId!,
// // // // //       userId: user.id!,
// // // // //       dutyPostId: widget.dutyPostId!,
// // // // //       shiftId: widget.shiftId!,
// // // // //     );
// // // // //     setState(() {});
// // // // //   }
// // // // //
// // // // //   NextAvailableDateRange? dates;
// // // // //   bool reasonConditions = false;
// // // // //   late List<BaseUser> replacementByUsers = [];
// // // // //
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     Label? selectedReason;
// // // // //
// // // // //     // BackdropFilter here blurs everything behind this dialog (the
// // // // //     // underlying duty-post screen), since this widget sits in the
// // // // //     // dialog route's Overlay entry above the whole app.
// // // // //     return BackdropFilter(
// // // // //       filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
// // // // //       child: Dialog(
// // // // //         backgroundColor: Colors.transparent,
// // // // //         insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
// // // // //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
// // // // //         child: ClipRRect(
// // // // //           borderRadius: BorderRadius.circular(20),
// // // // //           child: BackdropFilter(
// // // // //             // Extra inner blur so the glass card reads as a distinct
// // // // //             // surface, matching the frosted style used elsewhere in the app.
// // // // //             filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
// // // // //             child: Container(
// // // // //               decoration: BoxDecoration(
// // // // //                 color: const Color(0xFF1B2333).withValues(alpha: 0.15),
// // // // //                 borderRadius: BorderRadius.circular(20),
// // // // //                 border: Border.all(
// // // // //                   color: Colors.white.withValues(alpha: 0.25),
// // // // //                   width: 1,
// // // // //                 ),
// // // // //               ),
// // // // //               padding: const EdgeInsets.symmetric(
// // // // //                   horizontal: 20.0, vertical: 20.0),
// // // // //               child: Builder(builder: (context) {
// // // // //                 // Get available height and width of the build area of this widget.
// // // // //                 var height = MediaQuery.of(context).size.height;
// // // // //                 var width = MediaQuery.of(context).size.width;
// // // // //                 double divideBy = widget.viaAttendance ? 2.6 : 2.0;
// // // // //                 return SizedBox(
// // // // //                   height: height / divideBy,
// // // // //                   width: width,
// // // // //                   child: Stack(
// // // // //                     clipBehavior: Clip.none,
// // // // //                     children: <Widget>[
// // // // //                       Form(
// // // // //                         key: _formKey,
// // // // //                         child: SingleChildScrollView(
// // // // //                           child: Column(
// // // // //                             mainAxisSize: MainAxisSize.min,
// // // // //                             children: <Widget>[
// // // // //                               CommonWidgets.verticalSpacerWidget(
// // // // //                                   height * 0.01),
// // // // //                               /// Replacement For
// // // // //                               CommonWidgets.textDisplay(
// // // // //                                   Constants.replacementFor,
// // // // //                                   isMandatory: true,
// // // // //                                   Styles.textStyleWhite14),
// // // // //                               CommonWidgets.verticalSpacerWidget(
// // // // //                                   height * 0.001),
// // // // //                               TextFieldAddButton(
// // // // //                                 title: replacementForController.text,
// // // // //                                 height: 60,
// // // // //                                 isDisableColor: false,
// // // // //                                 onTap: () {
// // // // //                                   BaseOrganisationDialog().userDialog(
// // // // //                                     context: context,
// // // // //                                     users: widget.selectedGuards.toList(),
// // // // //                                     onTap: (BaseUser user) async {
// // // // //                                       replacementForController.text =
// // // // //                                           user.name ?? '';
// // // // //                                       widget.model.replacedFor = user;
// // // // //
// // // // //                                       // TODO: Not to call is widget.viaAttendance is false
// // // // //                                       if (!widget.viaAttendance) {
// // // // //                                         if (widget.rankId != null) {
// // // // //                                           showLoadingDialog(context);
// // // // //
// // // // //                                           dates = await ShiftScheduleServices()
// // // // //                                               .getNextAvailableReplacementDates(
// // // // //                                             rankId: widget.rankId!,
// // // // //                                             userId: user.id!,
// // // // //                                             dutyPostId: widget.dutyPostId!,
// // // // //                                             shiftId: widget.shiftId!,
// // // // //                                           );
// // // // //                                           dismissLoadingDialog(context);
// // // // //                                         }
// // // // //                                       }
// // // // //                                       if(widget.viaAttendance){
// // // // //                                         if (widget.rankId != null) {
// // // // //                                           showLoadingDialog(context);
// // // // //
// // // // //                                           dates = await AttendanceServices()
// // // // //                                               .getNextAvailableReplacementDates(
// // // // //                                             rankId: widget.rankId!,
// // // // //                                             userId: user.id!,
// // // // //                                             dutyPostId: widget.dutyPostId!,
// // // // //                                             shiftId: widget.shiftId!, attendanceId: widget.attendanceId!,
// // // // //                                           );
// // // // //                                           dismissLoadingDialog(context);
// // // // //                                         }
// // // // //                                       }
// // // // //
// // // // //                                       setState(() {
// // // // //                                         log('-setstate-');
// // // // //                                         replacementForController.text =
// // // // //                                             user.name ?? '';
// // // // //                                       });
// // // // //                                     },
// // // // //                                     locationId: 0,
// // // // //                                   );
// // // // //                                 },
// // // // //                               ),
// // // // //                               CommonWidgets.verticalSpacerWidget(
// // // // //                                   height * 0.01),
// // // // //
// // // // //                               /// Reason
// // // // //                               CommonWidgets.textDisplay(
// // // // //                                 Constants.reason,
// // // // //                                 Styles.textStyleWhite14,
// // // // //                               ),
// // // // //                               CommonWidgets.verticalSpacerWidget(
// // // // //                                   height * 0.001),
// // // // //                               BaseDropDown().getDropDown(
// // // // //                                 isDisabled: false,
// // // // //                                 textController: reasonController,
// // // // //                                 items: reasonList,
// // // // //                                 onTap: () {
// // // // //                                   if (!isReplacedForSelected.status) {
// // // // //                                     Validator().showToast(
// // // // //                                       context,
// // // // //                                       isReplacedForSelected.message,
// // // // //                                     );
// // // // //                                     return;
// // // // //                                   }
// // // // //                                   BaseDropDown().assetTypeDialog(
// // // // //                                     context: context,
// // // // //                                     dropDownValues: reasonList
// // // // //                                         .map((label) => label.key)
// // // // //                                         .toList(),
// // // // //                                     onTap: (String value) {
// // // // //                                       selectedReason =
// // // // //                                           shiftScheduleReasonDropDownValues
// // // // //                                               .firstWhere(
// // // // //                                                 (label) => label.key == value,
// // // // //                                             orElse: () =>
// // // // //                                             const Label(key: '', value: ''),
// // // // //                                           );
// // // // //
// // // // //                                       if (widget.viaAttendance) {
// // // // //                                         getReplacementByUserListForAttendance();
// // // // //                                       }
// // // // //                                       setState(() {
// // // // //                                         reasonConditions =
// // // // //                                         (selectedReason != null &&
// // // // //                                             (selectedReason!.value ==
// // // // //                                                 '1'));
// // // // //                                       });
// // // // //                                       log('--reasonConditions-$reasonConditions-');
// // // // //
// // // // //                                       widget.model.status =
// // // // //                                           int.tryParse(selectedReason!.value);
// // // // //                                       reasonController.text =
// // // // //                                           selectedReason!.key;
// // // // //                                     },
// // // // //                                   );
// // // // //                                 },
// // // // //                               ),
// // // // //                               CommonWidgets.verticalSpacerWidget(
// // // // //                                   height * 0.01),
// // // // //
// // // // //                               /// From Date - Shift Schedule
// // // // //                               CommonWidgets.textDisplay(
// // // // //                                 Constants.fromDate,
// // // // //                                 isMandatory: true,
// // // // //                                 Styles.textStyleWhite14,
// // // // //                               ),
// // // // //                               // if (!widget.viaAttendance) ...[
// // // // //                                 LimitedDatePicker(
// // // // //                                   textController: fromDateController,
// // // // //                                   availableDates: dates?.availableDates ?? [],
// // // // //                                   isDisabled: false,
// // // // //                                   onChange: (String value) async {
// // // // //                                     widget.model.fromDate =
// // // // //                                         Utils().formatTime(value);
// // // // //                                     if (reasonConditions) {
// // // // //                                       log('--iffffff-reasonConditions--');
// // // // //                                       toDateController.text =
// // // // //                                           fromDateController.text;
// // // // //                                       await getReplacementByUserList();
// // // // //
// // // // //                                       setState(() {
// // // // //                                         widget.model.toDate =
// // // // //                                             Utils().formatTime(value);
// // // // //                                         toDateController.text =
// // // // //                                             fromDateController.text;
// // // // //                                       });
// // // // //                                     }
// // // // //                                   },
// // // // //                                 ),
// // // // //                               // ] else ...[
// // // // //                               //   /// From Date - Attendance
// // // // //                               //   BaseDate().datePickerWidgetLoading(
// // // // //                               //     textController: fromDateController,
// // // // //                               //     isDisabled: true,
// // // // //                               //     onlyDate: false,
// // // // //                               //     showPastDate: false,
// // // // //                               //     notFlagDate: true,
// // // // //                               //     onChange: (String value) {
// // // // //                               //       widget.model.fromDate =
// // // // //                               //           Utils().formatTime(value);
// // // // //                               //     },
// // // // //                               //     context: context,
// // // // //                               //   )
// // // // //                               // ],
// // // // //                               CommonWidgets.verticalSpacerWidget(
// // // // //                                   height * 0.01),
// // // // //
// // // // //                               /// To Date
// // // // //                               // if (!widget.viaAttendance) ...[
// // // // //                                 CommonWidgets.textDisplay(
// // // // //                                   Constants.toDate,
// // // // //                                   isMandatory: true,
// // // // //                                   Styles.textStyleWhite14,
// // // // //                                 ),
// // // // //                                 CommonWidgets.verticalSpacerWidget(
// // // // //                                     height * 0.001),
// // // // //                                 LimitedDatePicker(
// // // // //                                   textController: toDateController,
// // // // //                                   availableDates: dates?.availableDates ?? [],
// // // // //                                   onChange: (String value) async {
// // // // //                                     widget.model.toDate =
// // // // //                                         Utils().formatTime(value);
// // // // //                                     await getReplacementByUserList();
// // // // //                                   },
// // // // //                                   isDisabled: false,
// // // // //                                 ),
// // // // //                                 CommonWidgets.verticalSpacerWidget(
// // // // //                                     height * 0.01),
// // // // //                               // ],
// // // // //
// // // // //                               /// Replacement By
// // // // //                               CommonWidgets.textDisplay(
// // // // //                                   Constants.replacementBy,
// // // // //                                   isMandatory: true,
// // // // //                                   Styles.textStyleWhite14),
// // // // //
// // // // //                               // CommonWidgets.verticalSpacerWidget(
// // // // //                               //     height * 0.01),
// // // // //                               TextFieldAddButton(
// // // // //                                 title: replacementByController.text,
// // // // //                                 height: 60,
// // // // //                                 isDisableColor: false,
// // // // //                                 onTap: () {
// // // // //                                   BaseOrganisationDialog().userDialog(
// // // // //                                     context: context,
// // // // //                                     users: replacementByUsers,
// // // // //                                     onTap: (BaseUser user) {
// // // // //                                       replacementByController.text =
// // // // //                                           user.name ?? '';
// // // // //                                       widget.model.replacementBy = user;
// // // // //
// // // // //                                       setState(() {
// // // // //                                         replacementByController.text =
// // // // //                                             user.name ?? '';
// // // // //                                       });
// // // // //                                     },
// // // // //                                     locationId: 0,
// // // // //                                   );
// // // // //                                 },
// // // // //                               ),
// // // // //
// // // // //                               CommonWidgets.verticalSpacerWidget(
// // // // //                                   height * 0.02),
// // // // //
// // // // //                               /// Replacement Type
// // // // //                               CommonWidgets.textDisplay(
// // // // //                                 Constants.replacementType,
// // // // //                                 Styles.textStyleWhite14,
// // // // //                               ),
// // // // //                               CommonWidgets.verticalSpacerWidget(
// // // // //                                   height * 0.001),
// // // // //
// // // // //                               BaseDropDown().getDropDown(
// // // // //                                 isDisabled: false,
// // // // //                                 textController: replacementTypeController,
// // // // //                                 items: replacementTypeList,
// // // // //                                 onTap: () {
// // // // //                                   BaseDropDown().assetTypeDialog(
// // // // //                                     context: context,
// // // // //                                     dropDownValues: replacementTypeList
// // // // //                                         .map((label) => label.key)
// // // // //                                         .toList(),
// // // // //                                     onTap: (String value) {
// // // // //                                       final selectedType = replacementTypeDropDownValues.firstWhere(
// // // // //                                             (label) => label.key == value,
// // // // //                                         orElse: () => const Label(key: '', value: ''),
// // // // //                                       );
// // // // //
// // // // //                                       setState(() {
// // // // //                                         replacementTypeController.text = selectedType.key;
// // // // //
// // // // //                                         // IMPORTANT: store the selected value in the model.
// // // // //                                         widget.model.replacementType =
// // // // //                                             int.tryParse(selectedType.value);
// // // // //                                       });
// // // // //                                     },
// // // // //                                   );
// // // // //                                 },
// // // // //                               ),
// // // // //
// // // // //                               CommonWidgets.verticalSpacerWidget(
// // // // //                                   height * 0.01),
// // // // //
// // // // //                               buttonViews(widget.mainContext, width),
// // // // //                               CommonWidgets.verticalSpacerWidget(
// // // // //                                   height * 0.02),
// // // // //                             ],
// // // // //                           ),
// // // // //                         ),
// // // // //                       ),
// // // // //                     ],
// // // // //                   ),
// // // // //                 );
// // // // //               }),
// // // // //             ),
// // // // //           ),
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // //
// // // // //   Future<void> getReplacementByUserListForAttendance() async {
// // // // //     if (fromDateController.text.isEmptyOrNull) {
// // // // //       return;
// // // // //     }
// // // // //     replacementByUsers = await AttendanceServices().getAttAvailableGuardsByDate(
// // // // //       dutyPostId: widget.shiftModel!.attendanceShiftId!,
// // // // //       rankId: widget.rankId!,
// // // // //       shiftId: widget.shiftId!,
// // // // //       fromDate: Utils().convertToDateFormat(fromDateController.text),
// // // // //     );
// // // // //
// // // // //     replacementByController.clear();
// // // // //   }
// // // // //
// // // // //   Future<void> getReplacementByUserList() async {
// // // // //     if (fromDateController.text.isEmptyOrNull ||
// // // // //         toDateController.text.isEmptyOrNull) {
// // // // //       return;
// // // // //     }
// // // // //
// // // // //     if (!areValidDates.status) {
// // // // //       Validator().showToast(
// // // // //         context,
// // // // //         areValidDates.message,
// // // // //       );
// // // // //       return;
// // // // //     }
// // // // //     replacementByUsers = await ShiftScheduleServices().getAvailableGuardsByDate(
// // // // //       dutyPostId: widget.dutyPostId!,
// // // // //       rankId: widget.rankId!,
// // // // //       shiftId: widget.shiftId!,
// // // // //       fromDate: fromDateController.text,
// // // // //       toDate: toDateController.text,
// // // // //     );
// // // // //
// // // // //     replacementByController.clear();
// // // // //   }
// // // // //
// // // // //   Widget buttonViews(BuildContext context, double width) {
// // // // //     return Row(
// // // // //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // // // //       children: <Widget>[cancelButton(width), saveButton(width)],
// // // // //     );
// // // // //   }
// // // // //
// // // // //   Widget cancelButton(double width) {
// // // // //     return PopButton(
// // // // //       width: width / 3.5,
// // // // //       key: const Key(Keys.cancelButton),
// // // // //       buttonText: Constants.cancel,
// // // // //       buttonTextKey: Keys.cancelButtonText,
// // // // //       foregroundColor: AppColors.white,
// // // // //       textStyle: Styles.styleHeaderGreyText16,
// // // // //       boarderColor: AppColors.white,
// // // // //       onTap: () {
// // // // //         FocusScope.of(context).unfocus();
// // // // //         Navigator.of(context).pop();
// // // // //       },
// // // // //     );
// // // // //   }
// // // // //
// // // // //   Widget saveButton(double width) {
// // // // //     return AppButton(
// // // // //       width: width / 3.5,
// // // // //       key: const Key(Keys.saveButton),
// // // // //       buttonText: Constants.save,
// // // // //       buttonTextKey: Keys.saveButtonText,
// // // // //       backgroundColor: AppColors.navigationSkyBlueColor,
// // // // //       onTap: () {
// // // // //         if (!isFormValid.status) {
// // // // //           Validator().showToast(
// // // // //             context,
// // // // //             isFormValid.message,
// // // // //           );
// // // // //           return;
// // // // //         }
// // // // //
// // // // //         /// Assigning temporary Id in order to update is properly
// // // // //         if (widget.model.id == null && widget.model.tempId.isEmptyOrNull) {
// // // // //           widget.model.tempId = Utils.createCryptoRandomString();
// // // // //         }
// // // // //         log('--Add/Update Replacement--- ${(widget.model.id)}--${widget.model.toString()}-');
// // // // //         log('-widget.model.tempId---${widget.model.tempId}----');
// // // // //
// // // // //         if (widget.viaAttendance) {
// // // // //           BlocProvider.of<AttendanceShiftsCubit>(widget.mainContext)
// // // // //               .updateReplacement(context, widget.model, false, false, true);
// // // // //         } else {
// // // // //           BlocProvider.of<DutyPostDetailsCubit>(widget.mainContext)
// // // // //               .updateReplacement(context, widget.model);
// // // // //         }
// // // // //       },
// // // // //     );
// // // // //   }
// // // // //
// // // // //   ErrorResponse get isReplacedForSelected {
// // // // //     if (replacementForController.text.isEmptyOrNull) {
// // // // //       return const ErrorResponse(
// // // // //           status: false, message: 'Please enter Replacement For');
// // // // //     }
// // // // //
// // // // //     return const ErrorResponse(status: true, message: 'Form is Valid');
// // // // //   }
// // // // //
// // // // //   ErrorResponse get areValidDates {
// // // // //     final fromDate = DateTime.tryParse(fromDateController.text);
// // // // //     final toDate = DateTime.tryParse(toDateController.text);
// // // // //
// // // // //     log('--fromDate-$fromDate-');
// // // // //
// // // // //     if (fromDate != null && toDate != null) {
// // // // //       if (fromDate.isAfter(toDate)) {
// // // // //         return const ErrorResponse(
// // // // //             status: false,
// // // // //             message: 'From Date cannot be later than the To Date');
// // // // //       }
// // // // //     }
// // // // //     return const ErrorResponse(status: true, message: 'Form is Valid');
// // // // //   }
// // // // //
// // // // //   ErrorResponse get isFormValid {
// // // // //     if (replacementForController.text.isEmptyOrNull) {
// // // // //       return const ErrorResponse(
// // // // //           status: false, message: 'Please enter Replacement For');
// // // // //     }
// // // // //
// // // // //     if (reasonController.text.isEmptyOrNull) {
// // // // //       return const ErrorResponse(status: false, message: 'Please enter Reason');
// // // // //     }
// // // // //     if (fromDateController.text.isEmptyOrNull) {
// // // // //       return const ErrorResponse(
// // // // //           status: false, message: 'Please enter From Date');
// // // // //     }
// // // // //     if (!widget.viaAttendance) {
// // // // //       if (toDateController.text.isEmptyOrNull) {
// // // // //         return const ErrorResponse(
// // // // //             status: false, message: 'Please enter To Date');
// // // // //       }
// // // // //     }
// // // // //
// // // // //     final fromDate = DateTime.tryParse(fromDateController.text);
// // // // //     final toDate = DateTime.tryParse(toDateController.text);
// // // // //
// // // // //     log('--fromDate-$fromDate-');
// // // // //
// // // // //     if (fromDate != null && toDate != null) {
// // // // //       if (fromDate.isAfter(toDate)) {
// // // // //         return const ErrorResponse(
// // // // //             status: false,
// // // // //             message: 'From Date cannot be later than the To Date');
// // // // //       }
// // // // //     }
// // // // //
// // // // //     if (replacementByController.text.isEmptyOrNull) {
// // // // //       return const ErrorResponse(
// // // // //           status: false, message: 'Please enter Replacement By');
// // // // //     }
// // // // //
// // // // //     return const ErrorResponse(status: true, message: 'Form is Valid');
// // // // //   }
// // // // // }
// // // //
// // // // import 'dart:developer';
// // // // import 'dart:ui';
// // // //
// // // // import 'package:db_atom/index.dart';
// // // // import 'package:db_atom/src/common_widgets/base_widget/date_widgets/available_dates_picker.dart';
// // // // import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/services/attendance_service.dart';
// // // // import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/services/shift_schedule_services.dart';
// // // // import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/shift_schedule_details/views/duty_post_details/cubits/duty_post_details_cubit.dart';
// // // //
// // // // class AddReplacementPopUp extends StatefulWidget {
// // // //   const AddReplacementPopUp({
// // // //     super.key,
// // // //     required this.mainContext,
// // // //     required this.model,
// // // //     required this.selectedGuards,
// // // //     this.dutyPostId,
// // // //     this.rankId,
// // // //     this.shiftId,
// // // //     this.attendanceId,
// // // //     required this.viaAttendance,
// // // //     required this.shiftModel,
// // // //     this.attendanceModel,
// // // //   });
// // // //
// // // //   final bool viaAttendance;
// // // //   final BuildContext mainContext;
// // // //   final Replacement model;
// // // //   final Set<BaseUser> selectedGuards;
// // // //   final int? dutyPostId;
// // // //   final int? rankId;
// // // //   final int? shiftId;
// // // //   final int? attendanceId;
// // // //   final ShiftModel? shiftModel;
// // // //   final AttendanceModel? attendanceModel;
// // // //
// // // //   @override
// // // //   State<AddReplacementPopUp> createState() => AddReplacementPopUpState();
// // // // }
// // // //
// // // // class AddReplacementPopUpState extends State<AddReplacementPopUp> {
// // // //   final _formKey = GlobalKey<FormState>();
// // // //   TextEditingController replacementForController = TextEditingController();
// // // //   TextEditingController replacementByController = TextEditingController();
// // // //   TextEditingController fromDateController = TextEditingController();
// // // //   TextEditingController toDateController = TextEditingController();
// // // //   TextEditingController reasonController = TextEditingController();
// // // //   TextEditingController replacementTypeController = TextEditingController();
// // // //
// // // //   late List<Label> reasonList;
// // // //   late List<Label> replacementTypeList;
// // // //
// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     log('--widget.model------${widget.model}--');
// // // //
// // // //     replacementForController.text = widget.model.replacedFor?.name ?? '';
// // // //     replacementByController.text = widget.model.replacementBy?.name ?? '';
// // // //     if (widget.model.replacementType != null) {
// // // //       final matchingType = replacementTypeDropDownValues.firstWhere(
// // // //             (label) => label.value == widget.model.replacementType.toString(),
// // // //         orElse: () => const Label(key: '', value: ''),
// // // //       );
// // // //
// // // //       replacementTypeController.text = matchingType.key;
// // // //     }
// // // //     replacementTypeList = replacementTypeDropDownValues;
// // // //
// // // //     if (!widget.model.fromDate.isEmptyOrNull) {
// // // //       fromDateController.text = Utils.timestampToDateConversion(
// // // //           int.parse(widget.model.fromDate ?? '0'), Constants.dateFormat);
// // // //
// // // //       toDateController.text = Utils.timestampToDateConversion(
// // // //           int.parse(widget.model.toDate ?? '0'), Constants.dateFormat);
// // // //     }
// // // //     if (widget.model.id != null) {
// // // //       log('--widget.model?.replacementBy?.name------${widget.model.replacementBy?.name}--');
// // // //       if (widget.model.replacedFor != null) {
// // // //         setDateRange(widget.model.replacedFor!);
// // // //       }
// // // //     }
// // // //
// // // //     log('widget.model.status--${widget.model.status}----');
// // // //     if (widget.model.status != null) {
// // // //       Label matchingLabel = shiftScheduleReasonDropDownValues
// // // //           .firstWhere((label) => label.value == widget.model.status.toString());
// // // //
// // // //       reasonController.text = matchingLabel.key;
// // // //     }
// // // //     log('reasonController.text---${reasonController.text}----');
// // // //
// // // //     reasonList = widget.viaAttendance
// // // //         ? attendanceReasonDropDownValues
// // // //         : shiftScheduleReasonDropDownValues;
// // // //
// // // //     if (widget.viaAttendance) {
// // // //       fromDateController.text = Utils().getCurrentDate();
// // // //       widget.model.fromDate = Utils().formatTime(fromDateController.text);
// // // //     }
// // // //   }
// // // //
// // // //   @override
// // // //   void dispose() {
// // // //     replacementForController.dispose();
// // // //     replacementByController.dispose();
// // // //     fromDateController.dispose();
// // // //     toDateController.dispose();
// // // //     reasonController.dispose();
// // // //     replacementTypeController.dispose();
// // // //     super.dispose();
// // // //   }
// // // //
// // // //   Future<void> setDateRange(BaseUser user) async {
// // // //     dates = await ShiftScheduleServices().getNextAvailableReplacementDates(
// // // //       rankId: widget.rankId!,
// // // //       userId: user.id!,
// // // //       dutyPostId: widget.dutyPostId!,
// // // //       shiftId: widget.shiftId!,
// // // //     );
// // // //     setState(() {});
// // // //   }
// // // //
// // // //   NextAvailableDateRange? dates;
// // // //   bool reasonConditions = false;
// // // //   late List<BaseUser> replacementByUsers = [];
// // // //
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     Label? selectedReason;
// // // //
// // // //     // BackdropFilter here blurs everything behind this dialog (the
// // // //     // underlying duty-post screen), since this widget sits in the
// // // //     // dialog route's Overlay entry above the whole app.
// // // //     return BackdropFilter(
// // // //       filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
// // // //       child: Dialog(
// // // //         backgroundColor: Colors.transparent,
// // // //         insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
// // // //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
// // // //         child: ClipRRect(
// // // //           borderRadius: BorderRadius.circular(20),
// // // //           child: BackdropFilter(
// // // //             // Extra inner blur so the glass card reads as a distinct
// // // //             // surface, matching the frosted style used elsewhere in the app.
// // // //             filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
// // // //             child: Container(
// // // //               decoration: BoxDecoration(
// // // //                 color: const Color(0xFF1B2333).withValues(alpha: 0.15),
// // // //                 borderRadius: BorderRadius.circular(20),
// // // //                 border: Border.all(
// // // //                   color: Colors.white.withValues(alpha: 0.25),
// // // //                   width: 1,
// // // //                 ),
// // // //               ),
// // // //               padding: const EdgeInsets.symmetric(
// // // //                   horizontal: 20.0, vertical: 20.0),
// // // //               child: Builder(builder: (context) {
// // // //                 // Get available height and width of the build area of this widget.
// // // //                 var height = MediaQuery.of(context).size.height;
// // // //                 var width = MediaQuery.of(context).size.width;
// // // //                 double divideBy = widget.viaAttendance ? 2.6 : 2.0;
// // // //                 return SizedBox(
// // // //                   height: height / divideBy,
// // // //                   width: width,
// // // //                   child: Stack(
// // // //                     clipBehavior: Clip.none,
// // // //                     children: <Widget>[
// // // //                       Form(
// // // //                         key: _formKey,
// // // //                         child: SingleChildScrollView(
// // // //                           child: Column(
// // // //                             mainAxisSize: MainAxisSize.min,
// // // //                             children: <Widget>[
// // // //                               CommonWidgets.verticalSpacerWidget(
// // // //                                   height * 0.01),
// // // //                               /// Replacement For
// // // //                               CommonWidgets.textDisplay(
// // // //                                   Constants.replacementFor,
// // // //                                   isMandatory: true,
// // // //                                   Styles.textStyleWhite14),
// // // //                               CommonWidgets.verticalSpacerWidget(
// // // //                                   height * 0.001),
// // // //                               TextFieldAddButton(
// // // //                                 title: replacementForController.text,
// // // //                                 height: 60,
// // // //                                 isDisableColor: false,
// // // //                                 onTap: () {
// // // //                                   BaseOrganisationDialog().userDialog(
// // // //                                     context: context,
// // // //                                     users: widget.selectedGuards.toList(),
// // // //                                     onTap: (BaseUser user) async {
// // // //                                       replacementForController.text =
// // // //                                           user.name ?? '';
// // // //                                       widget.model.replacedFor = user;
// // // //
// // // //                                       // TODO: Not to call is widget.viaAttendance is false
// // // //                                       if (!widget.viaAttendance) {
// // // //                                         if (widget.rankId != null) {
// // // //                                           showLoadingDialog(context);
// // // //
// // // //                                           dates = await ShiftScheduleServices()
// // // //                                               .getNextAvailableReplacementDates(
// // // //                                             rankId: widget.rankId!,
// // // //                                             userId: user.id!,
// // // //                                             dutyPostId: widget.dutyPostId!,
// // // //                                             shiftId: widget.shiftId!,
// // // //                                           );
// // // //                                           dismissLoadingDialog(context);
// // // //                                         }
// // // //                                       }
// // // //
// // // //
// // // //                                       if (widget.viaAttendance) {
// // // //                                         if (widget.rankId != null &&
// // // //                                             widget.dutyPostId != null &&
// // // //                                             widget.shiftId != null &&
// // // //                                             widget.attendanceId != null) {
// // // //                                           showLoadingDialog(context);
// // // //
// // // //                                           dates = await AttendanceServices()
// // // //                                               .getNextAvailableReplacementDates(
// // // //                                             rankId: widget.rankId!,
// // // //                                             userId: user.id!,
// // // //                                             dutyPostId: widget.dutyPostId!,
// // // //                                             shiftId: widget.shiftId!,
// // // //                                             attendanceId: widget.attendanceId!,
// // // //                                           );
// // // //                                           dismissLoadingDialog(context);
// // // //                                         } else {
// // // //                                           log('--Skipping getNextAvailableReplacementDates: '
// // // //                                               'rankId=${widget.rankId}, '
// // // //                                               'dutyPostId=${widget.dutyPostId}, '
// // // //                                               'shiftId=${widget.shiftId}, '
// // // //                                               'attendanceId=${widget.attendanceId}--');
// // // //                                         }
// // // //                                       }
// // // //
// // // //                                       setState(() {
// // // //                                         log('-setstate-');
// // // //                                         replacementForController.text =
// // // //                                             user.name ?? '';
// // // //                                       });
// // // //                                     },
// // // //                                     locationId: 0,
// // // //                                   );
// // // //                                 },
// // // //                               ),
// // // //                               CommonWidgets.verticalSpacerWidget(
// // // //                                   height * 0.01),
// // // //
// // // //                               /// Reason
// // // //                               CommonWidgets.textDisplay(
// // // //                                 Constants.reason,
// // // //                                 Styles.textStyleWhite14,
// // // //                               ),
// // // //                               CommonWidgets.verticalSpacerWidget(
// // // //                                   height * 0.001),
// // // //                               BaseDropDown().getDropDown(
// // // //                                 isDisabled: false,
// // // //                                 textController: reasonController,
// // // //                                 items: reasonList,
// // // //                                 onTap: () {
// // // //                                   if (!isReplacedForSelected.status) {
// // // //                                     Validator().showToast(
// // // //                                       context,
// // // //                                       isReplacedForSelected.message,
// // // //                                     );
// // // //                                     return;
// // // //                                   }
// // // //                                   BaseDropDown().assetTypeDialog(
// // // //                                     context: context,
// // // //                                     dropDownValues: reasonList
// // // //                                         .map((label) => label.key)
// // // //                                         .toList(),
// // // //                                     onTap: (String value) {
// // // //                                       selectedReason =
// // // //                                           shiftScheduleReasonDropDownValues
// // // //                                               .firstWhere(
// // // //                                                 (label) => label.key == value,
// // // //                                             orElse: () =>
// // // //                                             const Label(key: '', value: ''),
// // // //                                           );
// // // //
// // // //                                       if (widget.viaAttendance) {
// // // //                                         getReplacementByUserListForAttendance();
// // // //                                       }
// // // //                                       setState(() {
// // // //                                         reasonConditions =
// // // //                                         (selectedReason != null &&
// // // //                                             (selectedReason!.value ==
// // // //                                                 '1'));
// // // //                                       });
// // // //                                       log('--reasonConditions-$reasonConditions-');
// // // //
// // // //                                       widget.model.status =
// // // //                                           int.tryParse(selectedReason!.value);
// // // //                                       reasonController.text =
// // // //                                           selectedReason!.key;
// // // //                                     },
// // // //                                   );
// // // //                                 },
// // // //                               ),
// // // //                               CommonWidgets.verticalSpacerWidget(
// // // //                                   height * 0.01),
// // // //
// // // //                               /// From Date - Shift Schedule
// // // //                               CommonWidgets.textDisplay(
// // // //                                 Constants.fromDate,
// // // //                                 isMandatory: true,
// // // //                                 Styles.textStyleWhite14,
// // // //                               ),
// // // //                               LimitedDatePicker(
// // // //                                 textController: fromDateController,
// // // //                                 availableDates: dates?.availableDates ?? [],
// // // //                                 isDisabled: false,
// // // //                                 onChange: (String value) async {
// // // //                                   widget.model.fromDate =
// // // //                                       Utils().formatTime(value);
// // // //                                   if (reasonConditions) {
// // // //                                     log('--iffffff-reasonConditions--');
// // // //                                     toDateController.text =
// // // //                                         fromDateController.text;
// // // //                                     await getReplacementByUserList();
// // // //
// // // //                                     setState(() {
// // // //                                       widget.model.toDate =
// // // //                                           Utils().formatTime(value);
// // // //                                       toDateController.text =
// // // //                                           fromDateController.text;
// // // //                                     });
// // // //                                   }
// // // //                                 },
// // // //                               ),
// // // //                               CommonWidgets.verticalSpacerWidget(
// // // //                                   height * 0.01),
// // // //
// // // //                               /// To Date
// // // //                               CommonWidgets.textDisplay(
// // // //                                 Constants.toDate,
// // // //                                 isMandatory: true,
// // // //                                 Styles.textStyleWhite14,
// // // //                               ),
// // // //                               CommonWidgets.verticalSpacerWidget(
// // // //                                   height * 0.001),
// // // //                               LimitedDatePicker(
// // // //                                 textController: toDateController,
// // // //                                 availableDates: dates?.availableDates ?? [],
// // // //                                 onChange: (String value) async {
// // // //                                   widget.model.toDate =
// // // //                                       Utils().formatTime(value);
// // // //                                   await getReplacementByUserList();
// // // //                                 },
// // // //                                 isDisabled: false,
// // // //                               ),
// // // //                               CommonWidgets.verticalSpacerWidget(
// // // //                                   height * 0.01),
// // // //
// // // //                               /// Replacement By
// // // //                               CommonWidgets.textDisplay(
// // // //                                   Constants.replacementBy,
// // // //                                   isMandatory: true,
// // // //                                   Styles.textStyleWhite14),
// // // //
// // // //                               TextFieldAddButton(
// // // //                                 title: replacementByController.text,
// // // //                                 height: 60,
// // // //                                 isDisableColor: false,
// // // //                                 onTap: () {
// // // //                                   BaseOrganisationDialog().userDialog(
// // // //                                     context: context,
// // // //                                     users: replacementByUsers,
// // // //                                     onTap: (BaseUser user) {
// // // //                                       replacementByController.text =
// // // //                                           user.name ?? '';
// // // //                                       widget.model.replacementBy = user;
// // // //
// // // //                                       setState(() {
// // // //                                         replacementByController.text =
// // // //                                             user.name ?? '';
// // // //                                       });
// // // //                                     },
// // // //                                     locationId: 0,
// // // //                                   );
// // // //                                 },
// // // //                               ),
// // // //
// // // //                               CommonWidgets.verticalSpacerWidget(
// // // //                                   height * 0.02),
// // // //
// // // //                               /// Replacement Type
// // // //                               CommonWidgets.textDisplay(
// // // //                                 Constants.replacementType,
// // // //                                 Styles.textStyleWhite14,
// // // //                               ),
// // // //                               CommonWidgets.verticalSpacerWidget(
// // // //                                   height * 0.001),
// // // //
// // // //                               BaseDropDown().getDropDown(
// // // //                                 isDisabled: false,
// // // //                                 textController: replacementTypeController,
// // // //                                 items: replacementTypeList,
// // // //                                 onTap: () {
// // // //                                   BaseDropDown().assetTypeDialog(
// // // //                                     context: context,
// // // //                                     dropDownValues: replacementTypeList
// // // //                                         .map((label) => label.key)
// // // //                                         .toList(),
// // // //                                     onTap: (String value) {
// // // //                                       final selectedType = replacementTypeDropDownValues.firstWhere(
// // // //                                             (label) => label.key == value,
// // // //                                         orElse: () => const Label(key: '', value: ''),
// // // //                                       );
// // // //
// // // //                                       setState(() {
// // // //                                         replacementTypeController.text = selectedType.key;
// // // //
// // // //                                         // IMPORTANT: store the selected value in the model.
// // // //                                         widget.model.replacementType =
// // // //                                             int.tryParse(selectedType.value);
// // // //                                       });
// // // //                                     },
// // // //                                   );
// // // //                                 },
// // // //                               ),
// // // //
// // // //                               CommonWidgets.verticalSpacerWidget(
// // // //                                   height * 0.01),
// // // //
// // // //                               buttonViews(widget.mainContext, width),
// // // //                               CommonWidgets.verticalSpacerWidget(
// // // //                                   height * 0.02),
// // // //                             ],
// // // //                           ),
// // // //                         ),
// // // //                       ),
// // // //                     ],
// // // //                   ),
// // // //                 );
// // // //               }),
// // // //             ),
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   Future<void> getReplacementByUserListForAttendance() async {
// // // //     if (fromDateController.text.isEmptyOrNull) {
// // // //       return;
// // // //     }
// // // //     replacementByUsers = await AttendanceServices().getAttAvailableGuardsByDate(
// // // //       dutyPostId: widget.shiftModel!.attendanceShiftId!,
// // // //       rankId: widget.rankId!,
// // // //       shiftId: widget.shiftId!,
// // // //       fromDate: Utils().convertToDateFormat(fromDateController.text),
// // // //     );
// // // //
// // // //     replacementByController.clear();
// // // //   }
// // // //
// // // //   Future<void> getReplacementByUserList() async {
// // // //     if (fromDateController.text.isEmptyOrNull ||
// // // //         toDateController.text.isEmptyOrNull) {
// // // //       return;
// // // //     }
// // // //
// // // //     if (!areValidDates.status) {
// // // //       Validator().showToast(
// // // //         context,
// // // //         areValidDates.message,
// // // //       );
// // // //       return;
// // // //     }
// // // //     replacementByUsers = await ShiftScheduleServices().getAvailableGuardsByDate(
// // // //       dutyPostId: widget.dutyPostId!,
// // // //       rankId: widget.rankId!,
// // // //       shiftId: widget.shiftId!,
// // // //       fromDate: fromDateController.text,
// // // //       toDate: toDateController.text,
// // // //     );
// // // //
// // // //     replacementByController.clear();
// // // //   }
// // // //
// // // //   Widget buttonViews(BuildContext context, double width) {
// // // //     return Row(
// // // //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // // //       children: <Widget>[cancelButton(width), saveButton(width)],
// // // //     );
// // // //   }
// // // //
// // // //   Widget cancelButton(double width) {
// // // //     return PopButton(
// // // //       width: width / 3.5,
// // // //       key: const Key(Keys.cancelButton),
// // // //       buttonText: Constants.cancel,
// // // //       buttonTextKey: Keys.cancelButtonText,
// // // //       foregroundColor: AppColors.white,
// // // //       textStyle: Styles.styleHeaderGreyText16,
// // // //       boarderColor: AppColors.white,
// // // //       onTap: () {
// // // //         FocusScope.of(context).unfocus();
// // // //         Navigator.of(context).pop();
// // // //       },
// // // //     );
// // // //   }
// // // //
// // // //   Widget saveButton(double width) {
// // // //     return AppButton(
// // // //       width: width / 3.5,
// // // //       key: const Key(Keys.saveButton),
// // // //       buttonText: Constants.save,
// // // //       buttonTextKey: Keys.saveButtonText,
// // // //       backgroundColor: AppColors.navigationSkyBlueColor,
// // // //       onTap: () {
// // // //         if (!isFormValid.status) {
// // // //           Validator().showToast(
// // // //             context,
// // // //             isFormValid.message,
// // // //           );
// // // //           return;
// // // //         }
// // // //
// // // //         /// Assigning temporary Id in order to update is properly
// // // //         if (widget.model.id == null && widget.model.tempId.isEmptyOrNull) {
// // // //           widget.model.tempId = Utils.createCryptoRandomString();
// // // //         }
// // // //         log('--Add/Update Replacement--- ${(widget.model.id)}--${widget.model.toString()}-');
// // // //         log('-widget.model.tempId---${widget.model.tempId}----');
// // // //
// // // //         if (widget.viaAttendance) {
// // // //           BlocProvider.of<AttendanceShiftsCubit>(widget.mainContext)
// // // //               .updateReplacement(context, widget.model, false, false, true);
// // // //         } else {
// // // //           BlocProvider.of<DutyPostDetailsCubit>(widget.mainContext)
// // // //               .updateReplacement(context, widget.model);
// // // //         }
// // // //       },
// // // //     );
// // // //   }
// // // //
// // // //   ErrorResponse get isReplacedForSelected {
// // // //     if (replacementForController.text.isEmptyOrNull) {
// // // //       return const ErrorResponse(
// // // //           status: false, message: 'Please enter Replacement For');
// // // //     }
// // // //
// // // //     return const ErrorResponse(status: true, message: 'Form is Valid');
// // // //   }
// // // //
// // // //   ErrorResponse get areValidDates {
// // // //     final fromDate = DateTime.tryParse(fromDateController.text);
// // // //     final toDate = DateTime.tryParse(toDateController.text);
// // // //
// // // //     log('--fromDate-$fromDate-');
// // // //
// // // //     if (fromDate != null && toDate != null) {
// // // //       if (fromDate.isAfter(toDate)) {
// // // //         return const ErrorResponse(
// // // //             status: false,
// // // //             message: 'From Date cannot be later than the To Date');
// // // //       }
// // // //     }
// // // //     return const ErrorResponse(status: true, message: 'Form is Valid');
// // // //   }
// // // //
// // // //   ErrorResponse get isFormValid {
// // // //     if (replacementForController.text.isEmptyOrNull) {
// // // //       return const ErrorResponse(
// // // //           status: false, message: 'Please enter Replacement For');
// // // //     }
// // // //
// // // //     if (reasonController.text.isEmptyOrNull) {
// // // //       return const ErrorResponse(status: false, message: 'Please enter Reason');
// // // //     }
// // // //     if (fromDateController.text.isEmptyOrNull) {
// // // //       return const ErrorResponse(
// // // //           status: false, message: 'Please enter From Date');
// // // //     }
// // // //     if (!widget.viaAttendance) {
// // // //       if (toDateController.text.isEmptyOrNull) {
// // // //         return const ErrorResponse(
// // // //             status: false, message: 'Please enter To Date');
// // // //       }
// // // //     }
// // // //
// // // //     final fromDate = DateTime.tryParse(fromDateController.text);
// // // //     final toDate = DateTime.tryParse(toDateController.text);
// // // //
// // // //     log('--fromDate-$fromDate-');
// // // //
// // // //     if (fromDate != null && toDate != null) {
// // // //       if (fromDate.isAfter(toDate)) {
// // // //         return const ErrorResponse(
// // // //             status: false,
// // // //             message: 'From Date cannot be later than the To Date');
// // // //       }
// // // //     }
// // // //
// // // //     if (replacementByController.text.isEmptyOrNull) {
// // // //       return const ErrorResponse(
// // // //           status: false, message: 'Please enter Replacement By');
// // // //     }
// // // //
// // // //     return const ErrorResponse(status: true, message: 'Form is Valid');
// // // //   }
// // // // }
// // //
// // // import 'dart:developer';
// // // import 'dart:ui';
// // //
// // // import 'package:db_atom/index.dart';
// // // import 'package:db_atom/src/common_widgets/base_widget/date_widgets/available_dates_picker.dart';
// // // import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/services/attendance_service.dart';
// // // import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/services/shift_schedule_services.dart';
// // // import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/shift_schedule_details/views/duty_post_details/cubits/duty_post_details_cubit.dart';
// // //
// // // class AddReplacementPopUp extends StatefulWidget {
// // //   const AddReplacementPopUp({
// // //     super.key,
// // //     required this.mainContext,
// // //     required this.model,
// // //     required this.selectedGuards,
// // //     this.dutyPostId,
// // //     this.rankId,
// // //     this.shiftId,
// // //     this.attendanceId,
// // //     required this.viaAttendance,
// // //     required this.shiftModel,
// // //     this.attendanceModel,
// // //   });
// // //
// // //   final bool viaAttendance;
// // //   final BuildContext mainContext;
// // //   final Replacement model;
// // //   final Set<BaseUser> selectedGuards;
// // //   final int? dutyPostId;
// // //   final int? rankId;
// // //   final int? shiftId;
// // //   final int? attendanceId;
// // //   final ShiftModel? shiftModel;
// // //   final AttendanceModel? attendanceModel;
// // //
// // //   @override
// // //   State<AddReplacementPopUp> createState() => AddReplacementPopUpState();
// // // }
// // //
// // // class AddReplacementPopUpState extends State<AddReplacementPopUp> {
// // //   final _formKey = GlobalKey<FormState>();
// // //   TextEditingController replacementForController = TextEditingController();
// // //   TextEditingController replacementByController = TextEditingController();
// // //   TextEditingController fromDateController = TextEditingController();
// // //   TextEditingController toDateController = TextEditingController();
// // //   TextEditingController reasonController = TextEditingController();
// // //   TextEditingController replacementTypeController = TextEditingController();
// // //
// // //   late List<Label> reasonList;
// // //   late List<Label> replacementTypeList;
// // //
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     log('--widget.model------${widget.model}--');
// // //
// // //     replacementForController.text = widget.model.replacedFor?.name ?? '';
// // //     replacementByController.text = widget.model.replacementBy?.name ?? '';
// // //     if (widget.model.replacementType != null) {
// // //       final matchingType = replacementTypeDropDownValues.firstWhere(
// // //             (label) => label.value == widget.model.replacementType.toString(),
// // //         orElse: () => const Label(key: '', value: ''),
// // //       );
// // //
// // //       replacementTypeController.text = matchingType.key;
// // //     }
// // //     replacementTypeList = replacementTypeDropDownValues;
// // //
// // //     if (!widget.model.fromDate.isEmptyOrNull) {
// // //       fromDateController.text = Utils.timestampToDateConversion(
// // //           int.parse(widget.model.fromDate ?? '0'), Constants.dateFormat);
// // //
// // //       toDateController.text = Utils.timestampToDateConversion(
// // //           int.parse(widget.model.toDate ?? '0'), Constants.dateFormat);
// // //     }
// // //     if (widget.model.id != null) {
// // //       log('--widget.model?.replacementBy?.name------${widget.model.replacementBy?.name}--');
// // //       if (widget.model.replacedFor != null) {
// // //         setDateRange(widget.model.replacedFor!);
// // //       }
// // //     }
// // //
// // //     log('widget.model.status--${widget.model.status}----');
// // //     if (widget.model.status != null) {
// // //       Label matchingLabel = shiftScheduleReasonDropDownValues
// // //           .firstWhere((label) => label.value == widget.model.status.toString());
// // //
// // //       reasonController.text = matchingLabel.key;
// // //     }
// // //     log('reasonController.text---${reasonController.text}----');
// // //
// // //     reasonList = widget.viaAttendance
// // //         ? attendanceReasonDropDownValues
// // //         : shiftScheduleReasonDropDownValues;
// // //
// // //     if (widget.viaAttendance) {
// // //       fromDateController.text = Utils().getCurrentDate();
// // //       widget.model.fromDate = Utils().formatTime(fromDateController.text);
// // //     }
// // //   }
// // //
// // //   @override
// // //   void dispose() {
// // //     replacementForController.dispose();
// // //     replacementByController.dispose();
// // //     fromDateController.dispose();
// // //     toDateController.dispose();
// // //     reasonController.dispose();
// // //     replacementTypeController.dispose();
// // //     super.dispose();
// // //   }
// // //
// // //   Future<void> setDateRange(BaseUser user) async {
// // //     dates = await ShiftScheduleServices().getNextAvailableReplacementDates(
// // //       rankId: widget.rankId!,
// // //       userId: user.id!,
// // //       dutyPostId: widget.dutyPostId!,
// // //       shiftId: widget.shiftId!,
// // //     );
// // //     setState(() {});
// // //   }
// // //
// // //   NextAvailableDateRange? dates;
// // //   bool reasonConditions = false;
// // //   late List<BaseUser> replacementByUsers = [];
// // //
// // //   // Separate selectable-date lists for the From and To pickers.
// // //   // The attendance API returns a min/max *range* (fromDateMin/fromDateMax,
// // //   // toDateMin/toDateMax) rather than a flat list of pickable dates, so we
// // //   // expand each range into a list ourselves before handing it to
// // //   // LimitedDatePicker (which only understands a List<String>).
// // //   List<String> fromDateOptions = [];
// // //   List<String> toDateOptions = [];
// // //
// // //   /// Expands an inclusive [minDate, maxDate] range (format: yyyy-MM-dd)
// // //   /// into a list of individual date strings in the same format.
// // //   /// Returns an empty list if either bound is missing/unparseable.
// // //   List<String> _generateDateRange(String? minDate, String? maxDate) {
// // //     if (minDate.isEmptyOrNull || maxDate.isEmptyOrNull) return [];
// // //
// // //     final min = DateTime.tryParse(minDate!);
// // //     final max = DateTime.tryParse(maxDate!);
// // //     if (min == null || max == null) return [];
// // //
// // //     final List<String> result = [];
// // //     for (DateTime d = min;
// // //     !d.isAfter(max);
// // //     d = d.add(const Duration(days: 1))) {
// // //       result.add(d.toIso8601String().split('T').first);
// // //     }
// // //     return result;
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     Label? selectedReason;
// // //
// // //     // BackdropFilter here blurs everything behind this dialog (the
// // //     // underlying duty-post screen), since this widget sits in the
// // //     // dialog route's Overlay entry above the whole app.
// // //     return BackdropFilter(
// // //       filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
// // //       child: Dialog(
// // //         backgroundColor: Colors.transparent,
// // //         insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
// // //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
// // //         child: ClipRRect(
// // //           borderRadius: BorderRadius.circular(20),
// // //           child: BackdropFilter(
// // //             // Extra inner blur so the glass card reads as a distinct
// // //             // surface, matching the frosted style used elsewhere in the app.
// // //             filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
// // //             child: Container(
// // //               decoration: BoxDecoration(
// // //                 color: const Color(0xFF1B2333).withValues(alpha: 0.15),
// // //                 borderRadius: BorderRadius.circular(20),
// // //                 border: Border.all(
// // //                   color: Colors.white.withValues(alpha: 0.25),
// // //                   width: 1,
// // //                 ),
// // //               ),
// // //               padding: const EdgeInsets.symmetric(
// // //                   horizontal: 20.0, vertical: 20.0),
// // //               child: Builder(builder: (context) {
// // //                 // Get available height and width of the build area of this widget.
// // //                 var height = MediaQuery.of(context).size.height;
// // //                 var width = MediaQuery.of(context).size.width;
// // //                 double divideBy = widget.viaAttendance ? 2.6 : 2.0;
// // //                 return SizedBox(
// // //                   height: height / divideBy,
// // //                   width: width,
// // //                   child: Stack(
// // //                     clipBehavior: Clip.none,
// // //                     children: <Widget>[
// // //                       Form(
// // //                         key: _formKey,
// // //                         child: SingleChildScrollView(
// // //                           child: Column(
// // //                             mainAxisSize: MainAxisSize.min,
// // //                             children: <Widget>[
// // //                               CommonWidgets.verticalSpacerWidget(
// // //                                   height * 0.01),
// // //                               /// Replacement For
// // //                               CommonWidgets.textDisplay(
// // //                                   Constants.replacementFor,
// // //                                   isMandatory: true,
// // //                                   Styles.textStyleWhite14),
// // //                               CommonWidgets.verticalSpacerWidget(
// // //                                   height * 0.001),
// // //                               TextFieldAddButton(
// // //                                 title: replacementForController.text,
// // //                                 height: 60,
// // //                                 isDisableColor: false,
// // //                                 onTap: () {
// // //                                   BaseOrganisationDialog().userDialog(
// // //                                     context: context,
// // //                                     users: widget.selectedGuards.toList(),
// // //                                     onTap: (BaseUser user) async {
// // //                                       replacementForController.text =
// // //                                           user.name ?? '';
// // //                                       widget.model.replacedFor = user;
// // //
// // //                                       // TODO: Not to call is widget.viaAttendance is false
// // //                                       if (!widget.viaAttendance) {
// // //                                         if (widget.rankId != null) {
// // //                                           showLoadingDialog(context);
// // //
// // //                                           dates = await ShiftScheduleServices()
// // //                                               .getNextAvailableReplacementDates(
// // //                                             rankId: widget.rankId!,
// // //                                             userId: user.id!,
// // //                                             dutyPostId: widget.dutyPostId!,
// // //                                             shiftId: widget.shiftId!,
// // //                                           );
// // //                                           dismissLoadingDialog(context);
// // //                                         }
// // //                                       }
// // //
// // //                                       // FIX: widget.attendanceId can legitimately
// // //                                       // be null if the caller forgot to pass it
// // //                                       // (that was the actual bug — see
// // //                                       // AttendanceShiftsView.buildReplacementColumn).
// // //                                       // Guard here too so a missing id never
// // //                                       // crashes the UI with a null-check error;
// // //                                       // instead we just skip the date lookup and
// // //                                       // let the from/to date pickers fall back to
// // //                                       // an unrestricted range.
// // //                                       if (widget.viaAttendance) {
// // //                                         if (widget.rankId != null &&
// // //                                             widget.dutyPostId != null &&
// // //                                             widget.shiftId != null &&
// // //                                             widget.attendanceId != null) {
// // //                                           showLoadingDialog(context);
// // //
// // //                                           dates = await AttendanceServices()
// // //                                               .getNextAvailableReplacementDates(
// // //                                             rankId: widget.rankId!,
// // //                                             userId: user.id!,
// // //                                             dutyPostId: widget.dutyPostId!,
// // //                                             shiftId: widget.shiftId!,
// // //                                             attendanceId: widget.attendanceId!,
// // //                                           );
// // //                                           dismissLoadingDialog(context);
// // //
// // //                                           // Expand the API's min/max range
// // //                                           // (fromDateMin/fromDateMax,
// // //                                           // toDateMin/toDateMax) into pickable
// // //                                           // date lists, and default the
// // //                                           // From/To fields to the earliest
// // //                                           // allowed date in each range so
// // //                                           // the pickers show a value straight
// // //                                           // away instead of staying blank.
// // //                                           fromDateOptions = _generateDateRange(
// // //                                             dates?.fromDateMin,
// // //                                             dates?.fromDateMax,
// // //                                           );
// // //                                           toDateOptions = _generateDateRange(
// // //                                             dates?.toDateMin,
// // //                                             dates?.toDateMax,
// // //                                           );
// // //
// // //                                           if (fromDateOptions.isNotEmpty) {
// // //                                             fromDateController.text =
// // //                                                 fromDateOptions.first;
// // //                                             widget.model.fromDate = Utils()
// // //                                                 .formatTime(
// // //                                                 fromDateController.text);
// // //                                           }
// // //                                           if (toDateOptions.isNotEmpty) {
// // //                                             toDateController.text =
// // //                                                 toDateOptions.first;
// // //                                             widget.model.toDate = Utils()
// // //                                                 .formatTime(
// // //                                                 toDateController.text);
// // //                                           }
// // //                                         } else {
// // //                                           log('--Skipping getNextAvailableReplacementDates: '
// // //                                               'rankId=${widget.rankId}, '
// // //                                               'dutyPostId=${widget.dutyPostId}, '
// // //                                               'shiftId=${widget.shiftId}, '
// // //                                               'attendanceId=${widget.attendanceId}--');
// // //                                         }
// // //                                       }
// // //
// // //                                       setState(() {
// // //                                         log('-setstate-');
// // //                                         replacementForController.text =
// // //                                             user.name ?? '';
// // //                                       });
// // //                                     },
// // //                                     locationId: 0,
// // //                                   );
// // //                                 },
// // //                               ),
// // //                               CommonWidgets.verticalSpacerWidget(
// // //                                   height * 0.01),
// // //
// // //                               /// Reason
// // //                               CommonWidgets.textDisplay(
// // //                                 Constants.reason,
// // //                                 Styles.textStyleWhite14,
// // //                               ),
// // //                               CommonWidgets.verticalSpacerWidget(
// // //                                   height * 0.001),
// // //                               BaseDropDown().getDropDown(
// // //                                 isDisabled: false,
// // //                                 textController: reasonController,
// // //                                 items: reasonList,
// // //                                 onTap: () {
// // //                                   if (!isReplacedForSelected.status) {
// // //                                     Validator().showToast(
// // //                                       context,
// // //                                       isReplacedForSelected.message,
// // //                                     );
// // //                                     return;
// // //                                   }
// // //                                   BaseDropDown().assetTypeDialog(
// // //                                     context: context,
// // //                                     dropDownValues: reasonList
// // //                                         .map((label) => label.key)
// // //                                         .toList(),
// // //                                     onTap: (String value) {
// // //                                       selectedReason =
// // //                                           shiftScheduleReasonDropDownValues
// // //                                               .firstWhere(
// // //                                                 (label) => label.key == value,
// // //                                             orElse: () =>
// // //                                             const Label(key: '', value: ''),
// // //                                           );
// // //
// // //                                       if (widget.viaAttendance) {
// // //                                         getReplacementByUserListForAttendance();
// // //                                       }
// // //                                       setState(() {
// // //                                         reasonConditions =
// // //                                         (selectedReason != null &&
// // //                                             (selectedReason!.value ==
// // //                                                 '1'));
// // //                                       });
// // //                                       log('--reasonConditions-$reasonConditions-');
// // //
// // //                                       widget.model.status =
// // //                                           int.tryParse(selectedReason!.value);
// // //                                       reasonController.text =
// // //                                           selectedReason!.key;
// // //                                     },
// // //                                   );
// // //                                 },
// // //                               ),
// // //                               CommonWidgets.verticalSpacerWidget(
// // //                                   height * 0.01),
// // //
// // //                               /// From Date - Shift Schedule
// // //                               CommonWidgets.textDisplay(
// // //                                 Constants.fromDate,
// // //                                 isMandatory: true,
// // //                                 Styles.textStyleWhite14,
// // //                               ),
// // //                               LimitedDatePicker(
// // //                                 textController: fromDateController,
// // //                                 availableDates: widget.viaAttendance
// // //                                     ? fromDateOptions
// // //                                     : (dates?.availableDates ?? []),
// // //                                 isDisabled: false,
// // //                                 onChange: (String value) async {
// // //                                   widget.model.fromDate =
// // //                                       Utils().formatTime(value);
// // //                                   if (reasonConditions) {
// // //                                     log('--iffffff-reasonConditions--');
// // //                                     toDateController.text =
// // //                                         fromDateController.text;
// // //                                     await getReplacementByUserList();
// // //
// // //                                     setState(() {
// // //                                       widget.model.toDate =
// // //                                           Utils().formatTime(value);
// // //                                       toDateController.text =
// // //                                           fromDateController.text;
// // //                                     });
// // //                                   }
// // //                                 },
// // //                               ),
// // //                               CommonWidgets.verticalSpacerWidget(
// // //                                   height * 0.01),
// // //
// // //                               /// To Date
// // //                               CommonWidgets.textDisplay(
// // //                                 Constants.toDate,
// // //                                 isMandatory: true,
// // //                                 Styles.textStyleWhite14,
// // //                               ),
// // //                               CommonWidgets.verticalSpacerWidget(
// // //                                   height * 0.001),
// // //                               LimitedDatePicker(
// // //                                 textController: toDateController,
// // //                                 availableDates: widget.viaAttendance
// // //                                     ? toDateOptions
// // //                                     : (dates?.availableDates ?? []),
// // //                                 onChange: (String value) async {
// // //                                   widget.model.toDate =
// // //                                       Utils().formatTime(value);
// // //                                   await getReplacementByUserList();
// // //                                 },
// // //                                 isDisabled: false,
// // //                               ),
// // //                               CommonWidgets.verticalSpacerWidget(
// // //                                   height * 0.01),
// // //
// // //                               /// Replacement By
// // //                               CommonWidgets.textDisplay(
// // //                                   Constants.replacementBy,
// // //                                   isMandatory: true,
// // //                                   Styles.textStyleWhite14),
// // //
// // //                               TextFieldAddButton(
// // //                                 title: replacementByController.text,
// // //                                 height: 60,
// // //                                 isDisableColor: false,
// // //                                 onTap: () {
// // //                                   BaseOrganisationDialog().userDialog(
// // //                                     context: context,
// // //                                     users: replacementByUsers,
// // //                                     onTap: (BaseUser user) {
// // //                                       replacementByController.text =
// // //                                           user.name ?? '';
// // //                                       widget.model.replacementBy = user;
// // //
// // //                                       setState(() {
// // //                                         replacementByController.text =
// // //                                             user.name ?? '';
// // //                                       });
// // //                                     },
// // //                                     locationId: 0,
// // //                                   );
// // //                                 },
// // //                               ),
// // //
// // //                               CommonWidgets.verticalSpacerWidget(
// // //                                   height * 0.02),
// // //
// // //                               /// Replacement Type
// // //                               CommonWidgets.textDisplay(
// // //                                 Constants.replacementType,
// // //                                 Styles.textStyleWhite14,
// // //                               ),
// // //                               CommonWidgets.verticalSpacerWidget(
// // //                                   height * 0.001),
// // //
// // //                               BaseDropDown().getDropDown(
// // //                                 isDisabled: false,
// // //                                 textController: replacementTypeController,
// // //                                 items: replacementTypeList,
// // //                                 onTap: () {
// // //                                   BaseDropDown().assetTypeDialog(
// // //                                     context: context,
// // //                                     dropDownValues: replacementTypeList
// // //                                         .map((label) => label.key)
// // //                                         .toList(),
// // //                                     onTap: (String value) {
// // //                                       final selectedType = replacementTypeDropDownValues.firstWhere(
// // //                                             (label) => label.key == value,
// // //                                         orElse: () => const Label(key: '', value: ''),
// // //                                       );
// // //
// // //                                       setState(() {
// // //                                         replacementTypeController.text = selectedType.key;
// // //
// // //                                         // IMPORTANT: store the selected value in the model.
// // //                                         widget.model.replacementType =
// // //                                             int.tryParse(selectedType.value);
// // //                                       });
// // //                                     },
// // //                                   );
// // //                                 },
// // //                               ),
// // //
// // //                               CommonWidgets.verticalSpacerWidget(
// // //                                   height * 0.01),
// // //
// // //                               buttonViews(widget.mainContext, width),
// // //                               CommonWidgets.verticalSpacerWidget(
// // //                                   height * 0.02),
// // //                             ],
// // //                           ),
// // //                         ),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 );
// // //               }),
// // //             ),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // //
// // //   Future<void> getReplacementByUserListForAttendance() async {
// // //     if (fromDateController.text.isEmptyOrNull) {
// // //       return;
// // //     }
// // //     replacementByUsers = await AttendanceServices().getAttAvailableGuardsByDate(
// // //       dutyPostId: widget.shiftModel!.attendanceShiftId!,
// // //       rankId: widget.rankId!,
// // //       shiftId: widget.shiftId!,
// // //       fromDate: Utils().convertToDateFormat(fromDateController.text),
// // //     );
// // //
// // //     replacementByController.clear();
// // //   }
// // //
// // //   Future<void> getReplacementByUserList() async {
// // //     if (fromDateController.text.isEmptyOrNull ||
// // //         toDateController.text.isEmptyOrNull) {
// // //       return;
// // //     }
// // //
// // //     if (!areValidDates.status) {
// // //       Validator().showToast(
// // //         context,
// // //         areValidDates.message,
// // //       );
// // //       return;
// // //     }
// // //     replacementByUsers = await ShiftScheduleServices().getAvailableGuardsByDate(
// // //       dutyPostId: widget.dutyPostId!,
// // //       rankId: widget.rankId!,
// // //       shiftId: widget.shiftId!,
// // //       fromDate: fromDateController.text,
// // //       toDate: toDateController.text,
// // //     );
// // //
// // //     replacementByController.clear();
// // //   }
// // //
// // //   Widget buttonViews(BuildContext context, double width) {
// // //     return Row(
// // //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // //       children: <Widget>[cancelButton(width), saveButton(width)],
// // //     );
// // //   }
// // //
// // //   Widget cancelButton(double width) {
// // //     return PopButton(
// // //       width: width / 3.5,
// // //       key: const Key(Keys.cancelButton),
// // //       buttonText: Constants.cancel,
// // //       buttonTextKey: Keys.cancelButtonText,
// // //       foregroundColor: AppColors.white,
// // //       textStyle: Styles.styleHeaderGreyText16,
// // //       boarderColor: AppColors.white,
// // //       onTap: () {
// // //         FocusScope.of(context).unfocus();
// // //         Navigator.of(context).pop();
// // //       },
// // //     );
// // //   }
// // //
// // //   Widget saveButton(double width) {
// // //     return AppButton(
// // //       width: width / 3.5,
// // //       key: const Key(Keys.saveButton),
// // //       buttonText: Constants.save,
// // //       buttonTextKey: Keys.saveButtonText,
// // //       backgroundColor: AppColors.navigationSkyBlueColor,
// // //       onTap: () {
// // //         if (!isFormValid.status) {
// // //           Validator().showToast(
// // //             context,
// // //             isFormValid.message,
// // //           );
// // //           return;
// // //         }
// // //
// // //         /// Assigning temporary Id in order to update is properly
// // //         if (widget.model.id == null && widget.model.tempId.isEmptyOrNull) {
// // //           widget.model.tempId = Utils.createCryptoRandomString();
// // //         }
// // //         log('--Add/Update Replacement--- ${(widget.model.id)}--${widget.model.toString()}-');
// // //         log('-widget.model.tempId---${widget.model.tempId}----');
// // //
// // //         if (widget.viaAttendance) {
// // //           BlocProvider.of<AttendanceShiftsCubit>(widget.mainContext)
// // //               .updateReplacement(context, widget.model, false, false, true);
// // //         } else {
// // //           BlocProvider.of<DutyPostDetailsCubit>(widget.mainContext)
// // //               .updateReplacement(context, widget.model);
// // //         }
// // //       },
// // //     );
// // //   }
// // //
// // //   ErrorResponse get isReplacedForSelected {
// // //     if (replacementForController.text.isEmptyOrNull) {
// // //       return const ErrorResponse(
// // //           status: false, message: 'Please enter Replacement For');
// // //     }
// // //
// // //     return const ErrorResponse(status: true, message: 'Form is Valid');
// // //   }
// // //
// // //   ErrorResponse get areValidDates {
// // //     final fromDate = DateTime.tryParse(fromDateController.text);
// // //     final toDate = DateTime.tryParse(toDateController.text);
// // //
// // //     log('--fromDate-$fromDate-');
// // //
// // //     if (fromDate != null && toDate != null) {
// // //       if (fromDate.isAfter(toDate)) {
// // //         return const ErrorResponse(
// // //             status: false,
// // //             message: 'From Date cannot be later than the To Date');
// // //       }
// // //     }
// // //     return const ErrorResponse(status: true, message: 'Form is Valid');
// // //   }
// // //
// // //   ErrorResponse get isFormValid {
// // //     if (replacementForController.text.isEmptyOrNull) {
// // //       return const ErrorResponse(
// // //           status: false, message: 'Please enter Replacement For');
// // //     }
// // //
// // //     if (reasonController.text.isEmptyOrNull) {
// // //       return const ErrorResponse(status: false, message: 'Please enter Reason');
// // //     }
// // //     if (fromDateController.text.isEmptyOrNull) {
// // //       return const ErrorResponse(
// // //           status: false, message: 'Please enter From Date');
// // //     }
// // //     if (!widget.viaAttendance) {
// // //       if (toDateController.text.isEmptyOrNull) {
// // //         return const ErrorResponse(
// // //             status: false, message: 'Please enter To Date');
// // //       }
// // //     }
// // //
// // //     final fromDate = DateTime.tryParse(fromDateController.text);
// // //     final toDate = DateTime.tryParse(toDateController.text);
// // //
// // //     log('--fromDate-$fromDate-');
// // //
// // //     if (fromDate != null && toDate != null) {
// // //       if (fromDate.isAfter(toDate)) {
// // //         return const ErrorResponse(
// // //             status: false,
// // //             message: 'From Date cannot be later than the To Date');
// // //       }
// // //     }
// // //
// // //     if (replacementByController.text.isEmptyOrNull) {
// // //       return const ErrorResponse(
// // //           status: false, message: 'Please enter Replacement By');
// // //     }
// // //
// // //     return const ErrorResponse(status: true, message: 'Form is Valid');
// // //   }
// // // }
// //
// // import 'dart:developer';
// // import 'dart:ui';
// //
// // import 'package:db_atom/index.dart';
// // import 'package:db_atom/src/common_widgets/base_widget/date_widgets/available_dates_picker.dart';
// // import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/services/attendance_service.dart';
// // import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/services/shift_schedule_services.dart';
// // import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/shift_schedule_details/views/duty_post_details/cubits/duty_post_details_cubit.dart';
// // import 'package:intl/intl.dart';
// //
// // class AddReplacementPopUp extends StatefulWidget {
// //   const AddReplacementPopUp({
// //     super.key,
// //     required this.mainContext,
// //     required this.model,
// //     required this.selectedGuards,
// //     this.dutyPostId,
// //     this.rankId,
// //     this.shiftId,
// //     this.attendanceId,
// //     required this.viaAttendance,
// //     required this.shiftModel,
// //     this.attendanceModel,
// //   });
// //
// //   final bool viaAttendance;
// //   final BuildContext mainContext;
// //   final Replacement model;
// //   final Set<BaseUser> selectedGuards;
// //   final int? dutyPostId;
// //   final int? rankId;
// //   final int? shiftId;
// //   final int? attendanceId;
// //   final ShiftModel? shiftModel;
// //   final AttendanceModel? attendanceModel;
// //
// //   @override
// //   State<AddReplacementPopUp> createState() => AddReplacementPopUpState();
// // }
// //
// // class AddReplacementPopUpState extends State<AddReplacementPopUp> {
// //   final _formKey = GlobalKey<FormState>();
// //   TextEditingController replacementForController = TextEditingController();
// //   TextEditingController replacementByController = TextEditingController();
// //   TextEditingController fromDateController = TextEditingController();
// //   TextEditingController toDateController = TextEditingController();
// //   TextEditingController reasonController = TextEditingController();
// //   TextEditingController replacementTypeController = TextEditingController();
// //
// //   late List<Label> reasonList;
// //   late List<Label> replacementTypeList;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     log('--widget.model------${widget.model}--');
// //
// //     replacementForController.text = widget.model.replacedFor?.name ?? '';
// //     replacementByController.text = widget.model.replacementBy?.name ?? '';
// //     if (widget.model.replacementType != null) {
// //       final matchingType = replacementTypeDropDownValues.firstWhere(
// //             (label) => label.value == widget.model.replacementType.toString(),
// //         orElse: () => const Label(key: '', value: ''),
// //       );
// //
// //       replacementTypeController.text = matchingType.key;
// //     }
// //     replacementTypeList = replacementTypeDropDownValues;
// //
// //     if (!widget.model.fromDate.isEmptyOrNull) {
// //       fromDateController.text = Utils.timestampToDateConversion(
// //           int.parse(widget.model.fromDate ?? '0'), Constants.dateFormat);
// //
// //       toDateController.text = Utils.timestampToDateConversion(
// //           int.parse(widget.model.toDate ?? '0'), Constants.dateFormat);
// //     }
// //     if (widget.model.id != null) {
// //       log('--widget.model?.replacementBy?.name------${widget.model.replacementBy?.name}--');
// //       if (widget.model.replacedFor != null) {
// //         setDateRange(widget.model.replacedFor!);
// //       }
// //     }
// //
// //     log('widget.model.status--${widget.model.status}----');
// //     if (widget.model.status != null) {
// //       Label matchingLabel = shiftScheduleReasonDropDownValues
// //           .firstWhere((label) => label.value == widget.model.status.toString());
// //
// //       reasonController.text = matchingLabel.key;
// //     }
// //     log('reasonController.text---${reasonController.text}----');
// //
// //     reasonList = widget.viaAttendance
// //         ? attendanceReasonDropDownValues
// //         : shiftScheduleReasonDropDownValues;
// //
// //     if (widget.viaAttendance) {
// //       fromDateController.text = Utils().getCurrentDate();
// //       widget.model.fromDate = Utils().formatTime(fromDateController.text);
// //     }
// //   }
// //
// //   @override
// //   void dispose() {
// //     replacementForController.dispose();
// //     replacementByController.dispose();
// //     fromDateController.dispose();
// //     toDateController.dispose();
// //     reasonController.dispose();
// //     replacementTypeController.dispose();
// //     super.dispose();
// //   }
// //
// //   Future<void> setDateRange(BaseUser user) async {
// //     dates = await ShiftScheduleServices().getNextAvailableReplacementDates(
// //       rankId: widget.rankId!,
// //       userId: user.id!,
// //       dutyPostId: widget.dutyPostId!,
// //       shiftId: widget.shiftId!,
// //     );
// //     setState(() {});
// //   }
// //
// //   NextAvailableDateRange? dates;
// //   bool reasonConditions = false;
// //   late List<BaseUser> replacementByUsers = [];
// //
// //   // Separate selectable-date lists for the From and To pickers.
// //   // The attendance API returns a min/max *range* (fromDateMin/fromDateMax,
// //   // toDateMin/toDateMax) rather than a flat list of pickable dates, so we
// //   // expand each range into a list ourselves before handing it to
// //   // LimitedDatePicker (which only understands a List<String>).
// //   List<String> fromDateOptions = [];
// //   List<String> toDateOptions = [];
// //
// //   /// Expands an inclusive [minDate, maxDate] range into a list of individual
// //   /// date strings formatted as dd/MM/yyyy — the format used everywhere else
// //   /// in this screen (fromDateController/toDateController, Utils().formatTime,
// //   /// Utils().convertToDateFormat, and the getAvailableGuardsByDate API call).
// //   ///
// //   /// [minDate]/[maxDate] themselves come from the API as yyyy-MM-dd
// //   /// (e.g. "2026-09-06"), so we parse them with DateTime.tryParse (which
// //   /// understands ISO dates) and then re-format the output to dd/MM/yyyy.
// //   ///
// //   /// NOTE: this was previously outputting yyyy-MM-dd directly (via
// //   /// toIso8601String()), which matched the API's *input* format but not the
// //   /// app's display/query format — that mismatch is what caused
// //   /// `FormatException: Trying to read / from 2026-09-06 at 5` in
// //   /// Utils.convertToDateFormat, and the 400 from getAvailableGuardsByDate
// //   /// (which received fromDate=2026-09-06 instead of fromDate=06/09/2026).
// //   List<String> _generateDateRange(String? minDate, String? maxDate) {
// //     if (minDate.isEmptyOrNull || maxDate.isEmptyOrNull) return [];
// //
// //     final min = DateTime.tryParse(minDate!);
// //     final max = DateTime.tryParse(maxDate!);
// //     if (min == null || max == null) return [];
// //
// //     final formatter = DateFormat('dd/MM/yyyy');
// //     final List<String> result = [];
// //     for (DateTime d = min;
// //     !d.isAfter(max);
// //     d = d.add(const Duration(days: 1))) {
// //       result.add(formatter.format(d));
// //     }
// //     return result;
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     Label? selectedReason;
// //
// //     // BackdropFilter here blurs everything behind this dialog (the
// //     // underlying duty-post screen), since this widget sits in the
// //     // dialog route's Overlay entry above the whole app.
// //     return BackdropFilter(
// //       filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
// //       child: Dialog(
// //         backgroundColor: Colors.transparent,
// //         insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
// //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
// //         child: ClipRRect(
// //           borderRadius: BorderRadius.circular(20),
// //           child: BackdropFilter(
// //             // Extra inner blur so the glass card reads as a distinct
// //             // surface, matching the frosted style used elsewhere in the app.
// //             filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
// //             child: Container(
// //               decoration: BoxDecoration(
// //                 color: const Color(0xFF1B2333).withValues(alpha: 0.15),
// //                 borderRadius: BorderRadius.circular(20),
// //                 border: Border.all(
// //                   color: Colors.white.withValues(alpha: 0.25),
// //                   width: 1,
// //                 ),
// //               ),
// //               padding: const EdgeInsets.symmetric(
// //                   horizontal: 20.0, vertical: 20.0),
// //               child: Builder(builder: (context) {
// //                 // Get available height and width of the build area of this widget.
// //                 var height = MediaQuery.of(context).size.height;
// //                 var width = MediaQuery.of(context).size.width;
// //                 double divideBy = widget.viaAttendance ? 2.6 : 2.0;
// //                 return SizedBox(
// //                   height: height / divideBy,
// //                   width: width,
// //                   child: Stack(
// //                     clipBehavior: Clip.none,
// //                     children: <Widget>[
// //                       Form(
// //                         key: _formKey,
// //                         child: SingleChildScrollView(
// //                           child: Column(
// //                             mainAxisSize: MainAxisSize.min,
// //                             children: <Widget>[
// //                               CommonWidgets.verticalSpacerWidget(
// //                                   height * 0.01),
// //                               /// Replacement For
// //                               CommonWidgets.textDisplay(
// //                                   Constants.replacementFor,
// //                                   isMandatory: true,
// //                                   Styles.textStyleWhite14),
// //                               CommonWidgets.verticalSpacerWidget(
// //                                   height * 0.001),
// //                               TextFieldAddButton(
// //                                 title: replacementForController.text,
// //                                 height: 60,
// //                                 isDisableColor: false,
// //                                 onTap: () {
// //                                   BaseOrganisationDialog().userDialog(
// //                                     context: context,
// //                                     users: widget.selectedGuards.toList(),
// //                                     onTap: (BaseUser user) async {
// //                                       replacementForController.text =
// //                                           user.name ?? '';
// //                                       widget.model.replacedFor = user;
// //
// //                                       // TODO: Not to call is widget.viaAttendance is false
// //                                       if (!widget.viaAttendance) {
// //                                         if (widget.rankId != null) {
// //                                           showLoadingDialog(context);
// //
// //                                           dates = await ShiftScheduleServices()
// //                                               .getNextAvailableReplacementDates(
// //                                             rankId: widget.rankId!,
// //                                             userId: user.id!,
// //                                             dutyPostId: widget.dutyPostId!,
// //                                             shiftId: widget.shiftId!,
// //                                           );
// //                                           dismissLoadingDialog(context);
// //                                         }
// //                                       }
// //
// //                                       // FIX: widget.attendanceId can legitimately
// //                                       // be null if the caller forgot to pass it
// //                                       // (that was the actual bug — see
// //                                       // AttendanceShiftsView.buildReplacementColumn).
// //                                       // Guard here too so a missing id never
// //                                       // crashes the UI with a null-check error;
// //                                       // instead we just skip the date lookup and
// //                                       // let the from/to date pickers fall back to
// //                                       // an unrestricted range.
// //                                       if (widget.viaAttendance) {
// //                                         if (widget.rankId != null &&
// //                                             widget.dutyPostId != null &&
// //                                             widget.shiftId != null &&
// //                                             widget.attendanceId != null) {
// //                                           showLoadingDialog(context);
// //
// //                                           dates = await AttendanceServices()
// //                                               .getNextAvailableReplacementDates(
// //                                             rankId: widget.rankId!,
// //                                             userId: user.id!,
// //                                             dutyPostId: widget.dutyPostId!,
// //                                             shiftId: widget.shiftId!,
// //                                             attendanceId: widget.attendanceId!,
// //                                           );
// //                                           dismissLoadingDialog(context);
// //
// //                                           // Expand the API's min/max range
// //                                           // (fromDateMin/fromDateMax,
// //                                           // toDateMin/toDateMax) into pickable
// //                                           // date lists, and default the
// //                                           // From/To fields to the earliest
// //                                           // allowed date in each range so
// //                                           // the pickers show a value straight
// //                                           // away instead of staying blank.
// //                                           fromDateOptions = _generateDateRange(
// //                                             dates?.fromDateMin,
// //                                             dates?.fromDateMax,
// //                                           );
// //                                           toDateOptions = _generateDateRange(
// //                                             dates?.toDateMin,
// //                                             dates?.toDateMax,
// //                                           );
// //
// //                                           if (fromDateOptions.isNotEmpty) {
// //                                             fromDateController.text =
// //                                                 fromDateOptions.first;
// //                                             widget.model.fromDate = Utils()
// //                                                 .formatTime(
// //                                                 fromDateController.text);
// //                                           }
// //                                           if (toDateOptions.isNotEmpty) {
// //                                             toDateController.text =
// //                                                 toDateOptions.first;
// //                                             widget.model.toDate = Utils()
// //                                                 .formatTime(
// //                                                 toDateController.text);
// //                                           }
// //                                         } else {
// //                                           log('--Skipping getNextAvailableReplacementDates: '
// //                                               'rankId=${widget.rankId}, '
// //                                               'dutyPostId=${widget.dutyPostId}, '
// //                                               'shiftId=${widget.shiftId}, '
// //                                               'attendanceId=${widget.attendanceId}--');
// //                                         }
// //                                       }
// //
// //                                       setState(() {
// //                                         log('-setstate-');
// //                                         replacementForController.text =
// //                                             user.name ?? '';
// //                                       });
// //                                     },
// //                                     locationId: 0,
// //                                   );
// //                                 },
// //                               ),
// //                               CommonWidgets.verticalSpacerWidget(
// //                                   height * 0.01),
// //
// //                               /// Reason
// //                               CommonWidgets.textDisplay(
// //                                 Constants.reason,
// //                                 Styles.textStyleWhite14,
// //                               ),
// //                               CommonWidgets.verticalSpacerWidget(
// //                                   height * 0.001),
// //                               BaseDropDown().getDropDown(
// //                                 isDisabled: false,
// //                                 textController: reasonController,
// //                                 items: reasonList,
// //                                 onTap: () {
// //                                   if (!isReplacedForSelected.status) {
// //                                     Validator().showToast(
// //                                       context,
// //                                       isReplacedForSelected.message,
// //                                     );
// //                                     return;
// //                                   }
// //                                   BaseDropDown().assetTypeDialog(
// //                                     context: context,
// //                                     dropDownValues: reasonList
// //                                         .map((label) => label.key)
// //                                         .toList(),
// //                                     onTap: (String value) {
// //                                       selectedReason =
// //                                           shiftScheduleReasonDropDownValues
// //                                               .firstWhere(
// //                                                 (label) => label.key == value,
// //                                             orElse: () =>
// //                                             const Label(key: '', value: ''),
// //                                           );
// //
// //                                       if (widget.viaAttendance) {
// //                                         getReplacementByUserListForAttendance();
// //                                       }
// //                                       setState(() {
// //                                         reasonConditions =
// //                                         (selectedReason != null &&
// //                                             (selectedReason!.value ==
// //                                                 '1'));
// //                                       });
// //                                       log('--reasonConditions-$reasonConditions-');
// //
// //                                       widget.model.status =
// //                                           int.tryParse(selectedReason!.value);
// //                                       reasonController.text =
// //                                           selectedReason!.key;
// //                                     },
// //                                   );
// //                                 },
// //                               ),
// //                               CommonWidgets.verticalSpacerWidget(
// //                                   height * 0.01),
// //
// //                               /// From Date - Shift Schedule
// //                               CommonWidgets.textDisplay(
// //                                 Constants.fromDate,
// //                                 isMandatory: true,
// //                                 Styles.textStyleWhite14,
// //                               ),
// //                               LimitedDatePicker(
// //                                 textController: fromDateController,
// //                                 availableDates: widget.viaAttendance
// //                                     ? fromDateOptions
// //                                     : (dates?.availableDates ?? []),
// //                                 isDisabled: false,
// //                                 onChange: (String value) async {
// //                                   widget.model.fromDate =
// //                                       Utils().formatTime(value);
// //                                   if (reasonConditions) {
// //                                     log('--iffffff-reasonConditions--');
// //                                     toDateController.text =
// //                                         fromDateController.text;
// //                                     await _refreshReplacementByUsers();
// //
// //                                     setState(() {
// //                                       widget.model.toDate =
// //                                           Utils().formatTime(value);
// //                                       toDateController.text =
// //                                           fromDateController.text;
// //                                     });
// //                                   }
// //                                 },
// //                               ),
// //                               CommonWidgets.verticalSpacerWidget(
// //                                   height * 0.01),
// //
// //                               /// To Date
// //                               CommonWidgets.textDisplay(
// //                                 Constants.toDate,
// //                                 isMandatory: true,
// //                                 Styles.textStyleWhite14,
// //                               ),
// //                               CommonWidgets.verticalSpacerWidget(
// //                                   height * 0.001),
// //                               LimitedDatePicker(
// //                                 textController: toDateController,
// //                                 availableDates: widget.viaAttendance
// //                                     ? toDateOptions
// //                                     : (dates?.availableDates ?? []),
// //                                 onChange: (String value) async {
// //                                   widget.model.toDate =
// //                                       Utils().formatTime(value);
// //                                   await _refreshReplacementByUsers();
// //                                 },
// //                                 isDisabled: false,
// //                               ),
// //                               CommonWidgets.verticalSpacerWidget(
// //                                   height * 0.01),
// //
// //                               /// Replacement By
// //                               CommonWidgets.textDisplay(
// //                                   Constants.replacementBy,
// //                                   isMandatory: true,
// //                                   Styles.textStyleWhite14),
// //
// //                               TextFieldAddButton(
// //                                 title: replacementByController.text,
// //                                 height: 60,
// //                                 isDisableColor: false,
// //                                 onTap: () {
// //                                   BaseOrganisationDialog().userDialog(
// //                                     context: context,
// //                                     users: replacementByUsers,
// //                                     onTap: (BaseUser user) {
// //                                       replacementByController.text =
// //                                           user.name ?? '';
// //                                       widget.model.replacementBy = user;
// //
// //                                       setState(() {
// //                                         replacementByController.text =
// //                                             user.name ?? '';
// //                                       });
// //                                     },
// //                                     locationId: 0,
// //                                   );
// //                                 },
// //                               ),
// //
// //                               CommonWidgets.verticalSpacerWidget(
// //                                   height * 0.02),
// //
// //                               /// Replacement Type
// //                               CommonWidgets.textDisplay(
// //                                 Constants.replacementType,
// //                                 Styles.textStyleWhite14,
// //                               ),
// //                               CommonWidgets.verticalSpacerWidget(
// //                                   height * 0.001),
// //
// //                               BaseDropDown().getDropDown(
// //                                 isDisabled: false,
// //                                 textController: replacementTypeController,
// //                                 items: replacementTypeList,
// //                                 onTap: () {
// //                                   BaseDropDown().assetTypeDialog(
// //                                     context: context,
// //                                     dropDownValues: replacementTypeList
// //                                         .map((label) => label.key)
// //                                         .toList(),
// //                                     onTap: (String value) {
// //                                       final selectedType = replacementTypeDropDownValues.firstWhere(
// //                                             (label) => label.key == value,
// //                                         orElse: () => const Label(key: '', value: ''),
// //                                       );
// //
// //                                       setState(() {
// //                                         replacementTypeController.text = selectedType.key;
// //
// //                                         // IMPORTANT: store the selected value in the model.
// //                                         widget.model.replacementType =
// //                                             int.tryParse(selectedType.value);
// //                                       });
// //                                     },
// //                                   );
// //                                 },
// //                               ),
// //
// //                               CommonWidgets.verticalSpacerWidget(
// //                                   height * 0.01),
// //
// //                               buttonViews(widget.mainContext, width),
// //                               CommonWidgets.verticalSpacerWidget(
// //                                   height * 0.02),
// //                             ],
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 );
// //               }),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Future<void> getReplacementByUserListForAttendance() async {
// //     if (fromDateController.text.isEmptyOrNull) {
// //       return;
// //     }
// //     replacementByUsers = await AttendanceServices().getAttAvailableGuardsByDate(
// //       dutyPostId: widget.shiftModel!.attendanceShiftId!,
// //       rankId: widget.rankId!,
// //       shiftId: widget.shiftId!,
// //       fromDate: Utils().convertToDateFormat(fromDateController.text),
// //     );
// //
// //     replacementByController.clear();
// //   }
// //
// //   Future<void> getReplacementByUserList() async {
// //     if (fromDateController.text.isEmptyOrNull ||
// //         toDateController.text.isEmptyOrNull) {
// //       return;
// //     }
// //
// //     if (!areValidDates.status) {
// //       Validator().showToast(
// //         context,
// //         areValidDates.message,
// //       );
// //       return;
// //     }
// //     replacementByUsers = await ShiftScheduleServices().getAvailableGuardsByDate(
// //       dutyPostId: widget.dutyPostId!,
// //       rankId: widget.rankId!,
// //       shiftId: widget.shiftId!,
// //       fromDate: fromDateController.text,
// //       toDate: toDateController.text,
// //     );
// //
// //     replacementByController.clear();
// //   }
// //
// //   /// Routes to the correct "replacement by" lookup depending on where this
// //   /// dialog is opened from. The From/To date pickers previously always
// //   /// called getReplacementByUserList() (the duty-post/ShiftScheduleServices
// //   /// variant) even when viaAttendance was true, which sent a duty-post
// //   /// style request to an endpoint that didn't expect it and returned a
// //   /// 400 with a plain-text "Invalid Id:563" body instead of JSON.
// //   Future<void> _refreshReplacementByUsers() async {
// //     if (widget.viaAttendance) {
// //       await getReplacementByUserListForAttendance();
// //     } else {
// //       await getReplacementByUserList();
// //     }
// //   }
// //
// //   Widget buttonViews(BuildContext context, double width) {
// //     return Row(
// //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //       children: <Widget>[cancelButton(width), saveButton(width)],
// //     );
// //   }
// //
// //   Widget cancelButton(double width) {
// //     return PopButton(
// //       width: width / 3.5,
// //       key: const Key(Keys.cancelButton),
// //       buttonText: Constants.cancel,
// //       buttonTextKey: Keys.cancelButtonText,
// //       foregroundColor: AppColors.white,
// //       textStyle: Styles.styleHeaderGreyText16,
// //       boarderColor: AppColors.white,
// //       onTap: () {
// //         FocusScope.of(context).unfocus();
// //         Navigator.of(context).pop();
// //       },
// //     );
// //   }
// //
// //   Widget saveButton(double width) {
// //     return AppButton(
// //       width: width / 3.5,
// //       key: const Key(Keys.saveButton),
// //       buttonText: Constants.save,
// //       buttonTextKey: Keys.saveButtonText,
// //       backgroundColor: AppColors.navigationSkyBlueColor,
// //       onTap: () {
// //         if (!isFormValid.status) {
// //           Validator().showToast(
// //             context,
// //             isFormValid.message,
// //           );
// //           return;
// //         }
// //
// //         /// Assigning temporary Id in order to update is properly
// //         if (widget.model.id == null && widget.model.tempId.isEmptyOrNull) {
// //           widget.model.tempId = Utils.createCryptoRandomString();
// //         }
// //         log('--Add/Update Replacement--- ${(widget.model.id)}--${widget.model.toString()}-');
// //         log('-widget.model.tempId---${widget.model.tempId}----');
// //
// //         if (widget.viaAttendance) {
// //           BlocProvider.of<AttendanceShiftsCubit>(widget.mainContext)
// //               .updateReplacement(context, widget.model, false, false, true);
// //         } else {
// //           BlocProvider.of<DutyPostDetailsCubit>(widget.mainContext)
// //               .updateReplacement(context, widget.model);
// //         }
// //       },
// //     );
// //   }
// //
// //   ErrorResponse get isReplacedForSelected {
// //     if (replacementForController.text.isEmptyOrNull) {
// //       return const ErrorResponse(
// //           status: false, message: 'Please enter Replacement For');
// //     }
// //
// //     return const ErrorResponse(status: true, message: 'Form is Valid');
// //   }
// //
// //   ErrorResponse get areValidDates {
// //     final fromDate = DateTime.tryParse(fromDateController.text);
// //     final toDate = DateTime.tryParse(toDateController.text);
// //
// //     log('--fromDate-$fromDate-');
// //
// //     if (fromDate != null && toDate != null) {
// //       if (fromDate.isAfter(toDate)) {
// //         return const ErrorResponse(
// //             status: false,
// //             message: 'From Date cannot be later than the To Date');
// //       }
// //     }
// //     return const ErrorResponse(status: true, message: 'Form is Valid');
// //   }
// //
// //   ErrorResponse get isFormValid {
// //     if (replacementForController.text.isEmptyOrNull) {
// //       return const ErrorResponse(
// //           status: false, message: 'Please enter Replacement For');
// //     }
// //
// //     if (reasonController.text.isEmptyOrNull) {
// //       return const ErrorResponse(status: false, message: 'Please enter Reason');
// //     }
// //     if (fromDateController.text.isEmptyOrNull) {
// //       return const ErrorResponse(
// //           status: false, message: 'Please enter From Date');
// //     }
// //     if (!widget.viaAttendance) {
// //       if (toDateController.text.isEmptyOrNull) {
// //         return const ErrorResponse(
// //             status: false, message: 'Please enter To Date');
// //       }
// //     }
// //
// //     final fromDate = DateTime.tryParse(fromDateController.text);
// //     final toDate = DateTime.tryParse(toDateController.text);
// //
// //     log('--fromDate-$fromDate-');
// //
// //     if (fromDate != null && toDate != null) {
// //       if (fromDate.isAfter(toDate)) {
// //         return const ErrorResponse(
// //             status: false,
// //             message: 'From Date cannot be later than the To Date');
// //       }
// //     }
// //
// //     if (replacementByController.text.isEmptyOrNull) {
// //       return const ErrorResponse(
// //           status: false, message: 'Please enter Replacement By');
// //     }
// //
// //     return const ErrorResponse(status: true, message: 'Form is Valid');
// //   }
// // }
//
// import 'dart:developer';
// import 'dart:ui';
//
// import 'package:db_atom/index.dart';
// import 'package:db_atom/src/common_widgets/base_widget/date_widgets/available_dates_picker.dart';
// import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/services/attendance_service.dart';
// import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/services/shift_schedule_services.dart';
// import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/shift_schedule_details/views/duty_post_details/cubits/duty_post_details_cubit.dart';
// import 'package:intl/intl.dart';
//
// class AddReplacementPopUp extends StatefulWidget {
//   const AddReplacementPopUp({
//     super.key,
//     required this.mainContext,
//     required this.model,
//     required this.selectedGuards,
//     this.dutyPostId,
//     this.rankId,
//     this.shiftId,
//     this.attendanceId,
//     required this.viaAttendance,
//     required this.shiftModel,
//     this.attendanceModel,
//   });
//
//   final bool viaAttendance;
//   final BuildContext mainContext;
//   final Replacement model;
//   final Set<BaseUser> selectedGuards;
//   final int? dutyPostId;
//   final int? rankId;
//   final int? shiftId;
//   final int? attendanceId;
//   final ShiftModel? shiftModel;
//   final AttendanceModel? attendanceModel;
//
//   @override
//   State<AddReplacementPopUp> createState() => AddReplacementPopUpState();
// }
//
// class AddReplacementPopUpState extends State<AddReplacementPopUp> {
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController replacementForController = TextEditingController();
//   TextEditingController replacementByController = TextEditingController();
//   TextEditingController fromDateController = TextEditingController();
//   TextEditingController toDateController = TextEditingController();
//   TextEditingController reasonController = TextEditingController();
//   TextEditingController replacementTypeController = TextEditingController();
//
//   late List<Label> reasonList;
//   late List<Label> replacementTypeList;
//
//   @override
//   void initState() {
//     super.initState();
//     log('--widget.model------${widget.model}--');
//
//     replacementForController.text = widget.model.replacedFor?.name ?? '';
//     replacementByController.text = widget.model.replacementBy?.name ?? '';
//     if (widget.model.replacementType != null) {
//       final matchingType = replacementTypeDropDownValues.firstWhere(
//             (label) => label.value == widget.model.replacementType.toString(),
//         orElse: () => const Label(key: '', value: ''),
//       );
//
//       replacementTypeController.text = matchingType.key;
//     }
//     replacementTypeList = replacementTypeDropDownValues;
//
//     if (!widget.model.fromDate.isEmptyOrNull) {
//       fromDateController.text = Utils.timestampToDateConversion(
//           int.parse(widget.model.fromDate ?? '0'), Constants.dateFormat);
//
//       toDateController.text = Utils.timestampToDateConversion(
//           int.parse(widget.model.toDate ?? '0'), Constants.dateFormat);
//     }
//     if (widget.model.id != null) {
//       log('--widget.model?.replacementBy?.name------${widget.model.replacementBy?.name}--');
//       if (widget.model.replacedFor != null) {
//         setDateRange(widget.model.replacedFor!);
//       }
//     }
//
//     log('widget.model.status--${widget.model.status}----');
//     if (widget.model.status != null) {
//       Label matchingLabel = shiftScheduleReasonDropDownValues
//           .firstWhere((label) => label.value == widget.model.status.toString());
//
//       reasonController.text = matchingLabel.key;
//     }
//     log('reasonController.text---${reasonController.text}----');
//
//     reasonList = widget.viaAttendance
//         ? attendanceReasonDropDownValues
//         : shiftScheduleReasonDropDownValues;
//
//     if (widget.viaAttendance) {
//       fromDateController.text = Utils().getCurrentDate();
//       widget.model.fromDate = Utils().formatTime(fromDateController.text);
//     }
//   }
//
//   @override
//   void dispose() {
//     replacementForController.dispose();
//     replacementByController.dispose();
//     fromDateController.dispose();
//     toDateController.dispose();
//     reasonController.dispose();
//     replacementTypeController.dispose();
//     super.dispose();
//   }
//
//   Future<void> setDateRange(BaseUser user) async {
//     dates = await ShiftScheduleServices().getNextAvailableReplacementDates(
//       rankId: widget.rankId!,
//       userId: user.id!,
//       dutyPostId: widget.dutyPostId!,
//       shiftId: widget.shiftId!,
//     );
//     setState(() {});
//   }
//
//   NextAvailableDateRange? dates;
//   bool reasonConditions = false;
//   late List<BaseUser> replacementByUsers = [];
//
//   // Separate selectable-date lists for the From and To pickers.
//   // The attendance API returns a min/max *range* (fromDateMin/fromDateMax,
//   // toDateMin/toDateMax) rather than a flat list of pickable dates, so we
//   // expand each range into a list ourselves before handing it to
//   // LimitedDatePicker (which only understands a List<String>).
//   List<String> fromDateOptions = [];
//   List<String> toDateOptions = [];
//
//   /// Expands an inclusive [minDate, maxDate] range into a list of individual
//   /// date strings formatted as "dd/MM/yyyy" — the plain date format shown in
//   /// fromDateController/toDateController and expected by
//   /// getReplacementByUserListForAttendance's own parser.
//   ///
//   /// [minDate]/[maxDate] themselves come from the API as yyyy-MM-dd
//   /// (e.g. "2026-09-06"), so we parse them with DateTime.tryParse (which
//   /// understands ISO dates) and then re-format the output.
//   ///
//   /// Kept deliberately date-only (no time component): the date fields in
//   /// this screen only ever display/pick a date, and
//   /// getReplacementByUserListForAttendance() parses this exact string with
//   /// DateFormat('dd/MM/yyyy') — adding a time component here would break
//   /// that parse instead of fixing it.
//   List<String> _generateDateRange(String? minDate, String? maxDate) {
//     if (minDate.isEmptyOrNull || maxDate.isEmptyOrNull) return [];
//
//     final min = DateTime.tryParse(minDate!);
//     final max = DateTime.tryParse(maxDate!);
//     if (min == null || max == null) return [];
//
//     final formatter = DateFormat('dd/MM/yyyy');
//     final List<String> result = [];
//     for (DateTime d = min;
//     !d.isAfter(max);
//     d = d.add(const Duration(days: 1))) {
//       result.add(formatter.format(d));
//     }
//     return result;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Label? selectedReason;
//
//     // BackdropFilter here blurs everything behind this dialog (the
//     // underlying duty-post screen), since this widget sits in the
//     // dialog route's Overlay entry above the whole app.
//     return BackdropFilter(
//       filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//       child: Dialog(
//         backgroundColor: Colors.transparent,
//         insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(20),
//           child: BackdropFilter(
//             // Extra inner blur so the glass card reads as a distinct
//             // surface, matching the frosted style used elsewhere in the app.
//             filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: const Color(0xFF1B2333).withValues(alpha: 0.15),
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(
//                   color: Colors.white.withValues(alpha: 0.25),
//                   width: 1,
//                 ),
//               ),
//               padding: const EdgeInsets.symmetric(
//                   horizontal: 20.0, vertical: 20.0),
//               child: Builder(builder: (context) {
//                 // Get available height and width of the build area of this widget.
//                 var height = MediaQuery.of(context).size.height;
//                 var width = MediaQuery.of(context).size.width;
//                 double divideBy = widget.viaAttendance ? 2.6 : 2.0;
//                 return SizedBox(
//                   height: height / divideBy,
//                   width: width,
//                   child: Stack(
//                     clipBehavior: Clip.none,
//                     children: <Widget>[
//                       Form(
//                         key: _formKey,
//                         child: SingleChildScrollView(
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: <Widget>[
//                               CommonWidgets.verticalSpacerWidget(
//                                   height * 0.01),
//                               /// Replacement For
//                               CommonWidgets.textDisplay(
//                                   Constants.replacementFor,
//                                   isMandatory: true,
//                                   Styles.textStyleWhite14),
//                               CommonWidgets.verticalSpacerWidget(
//                                   height * 0.001),
//                               TextFieldAddButton(
//                                 title: replacementForController.text,
//                                 height: 60,
//                                 isDisableColor: false,
//                                 onTap: () {
//                                   BaseOrganisationDialog().userDialog(
//                                     context: context,
//                                     users: widget.selectedGuards.toList(),
//                                     onTap: (BaseUser user) async {
//                                       replacementForController.text =
//                                           user.name ?? '';
//                                       widget.model.replacedFor = user;
//
//                                       // TODO: Not to call is widget.viaAttendance is false
//                                       if (!widget.viaAttendance) {
//                                         if (widget.rankId != null) {
//                                           showLoadingDialog(context);
//
//                                           dates = await ShiftScheduleServices()
//                                               .getNextAvailableReplacementDates(
//                                             rankId: widget.rankId!,
//                                             userId: user.id!,
//                                             dutyPostId: widget.dutyPostId!,
//                                             shiftId: widget.shiftId!,
//                                           );
//                                           dismissLoadingDialog(context);
//                                         }
//                                       }
//
//
//                                       if (widget.viaAttendance) {
//                                         if (widget.rankId != null &&
//                                             widget.dutyPostId != null &&
//                                             widget.shiftId != null &&
//                                             widget.attendanceId != null) {
//                                           showLoadingDialog(context);
//
//                                           dates = await AttendanceServices()
//                                               .getNextAvailableReplacementDates(
//                                             rankId: widget.rankId!,
//                                             userId: user.id!,
//                                             dutyPostId: widget.dutyPostId!,
//                                             shiftId: widget.shiftId!,
//                                             attendanceId: widget.attendanceId!,
//                                           );
//                                           dismissLoadingDialog(context);
//
//
//                                           fromDateOptions = _generateDateRange(
//                                             dates?.fromDateMin,
//                                             dates?.fromDateMax,
//                                           );
//                                           toDateOptions = _generateDateRange(
//                                             dates?.toDateMin,
//                                             dates?.toDateMax,
//                                           );
//
//                                           if (fromDateOptions.isNotEmpty) {
//                                             fromDateController.text =
//                                                 fromDateOptions.first;
//                                             widget.model.fromDate = Utils()
//                                                 .formatTime(
//                                                 fromDateController.text);
//                                           }
//                                           if (toDateOptions.isNotEmpty) {
//                                             toDateController.text =
//                                                 toDateOptions.first;
//                                             widget.model.toDate = Utils()
//                                                 .formatTime(
//                                                 toDateController.text);
//                                           }
//                                         } else {
//                                           log('--Skipping getNextAvailableReplacementDates: '
//                                               'rankId=${widget.rankId}, '
//                                               'dutyPostId=${widget.dutyPostId}, '
//                                               'shiftId=${widget.shiftId}, '
//                                               'attendanceId=${widget.attendanceId}--');
//                                         }
//                                       }
//
//                                       setState(() {
//                                         log('-setstate-');
//                                         replacementForController.text =
//                                             user.name ?? '';
//                                       });
//                                     },
//                                     locationId: 0,
//                                   );
//                                 },
//                               ),
//                               CommonWidgets.verticalSpacerWidget(
//                                   height * 0.01),
//
//                               /// Reason
//                               CommonWidgets.textDisplay(
//                                 Constants.reason,
//                                 Styles.textStyleWhite14,
//                               ),
//                               CommonWidgets.verticalSpacerWidget(
//                                   height * 0.001),
//                               BaseDropDown().getDropDown(
//                                 isDisabled: false,
//                                 textController: reasonController,
//                                 items: reasonList,
//                                 onTap: () {
//                                   if (!isReplacedForSelected.status) {
//                                     Validator().showToast(
//                                       context,
//                                       isReplacedForSelected.message,
//                                     );
//                                     return;
//                                   }
//                                   BaseDropDown().assetTypeDialog(
//                                     context: context,
//                                     dropDownValues: reasonList
//                                         .map((label) => label.key)
//                                         .toList(),
//                                     onTap: (String value) {
//                                       selectedReason =
//                                           shiftScheduleReasonDropDownValues
//                                               .firstWhere(
//                                                 (label) => label.key == value,
//                                             orElse: () =>
//                                             const Label(key: '', value: ''),
//                                           );
//
//                                       if (widget.viaAttendance) {
//                                         getReplacementByUserListForAttendance();
//                                       }
//                                       setState(() {
//                                         reasonConditions =
//                                         (selectedReason != null &&
//                                             (selectedReason!.value ==
//                                                 '1'));
//                                       });
//                                       log('--reasonConditions-$reasonConditions-');
//
//                                       widget.model.status =
//                                           int.tryParse(selectedReason!.value);
//                                       reasonController.text =
//                                           selectedReason!.key;
//                                     },
//                                   );
//                                 },
//                               ),
//                               CommonWidgets.verticalSpacerWidget(
//                                   height * 0.01),
//
//                               /// From Date - Shift Schedule
//                               CommonWidgets.textDisplay(
//                                 Constants.fromDate,
//                                 isMandatory: true,
//                                 Styles.textStyleWhite14,
//                               ),
//                               LimitedDatePicker(
//                                 textController: fromDateController,
//                                 availableDates: widget.viaAttendance
//                                     ? fromDateOptions
//                                     : (dates?.availableDates ?? []),
//                                 isDisabled: false,
//                                 onChange: (String value) async {
//                                   widget.model.fromDate =
//                                       Utils().formatTime(value);
//                                   if (reasonConditions) {
//                                     log('--iffffff-reasonConditions--');
//                                     toDateController.text =
//                                         fromDateController.text;
//                                     await _refreshReplacementByUsers();
//
//                                     setState(() {
//                                       widget.model.toDate =
//                                           Utils().formatTime(value);
//                                       toDateController.text =
//                                           fromDateController.text;
//                                     });
//                                   }
//                                 },
//                               ),
//                               CommonWidgets.verticalSpacerWidget(
//                                   height * 0.01),
//
//                               /// To Date
//                               CommonWidgets.textDisplay(
//                                 Constants.toDate,
//                                 isMandatory: true,
//                                 Styles.textStyleWhite14,
//                               ),
//                               CommonWidgets.verticalSpacerWidget(
//                                   height * 0.001),
//                               LimitedDatePicker(
//                                 textController: toDateController,
//                                 availableDates: widget.viaAttendance
//                                     ? toDateOptions
//                                     : (dates?.availableDates ?? []),
//                                 onChange: (String value) async {
//                                   widget.model.toDate =
//                                       Utils().formatTime(value);
//                                   await _refreshReplacementByUsers();
//                                 },
//                                 isDisabled: false,
//                               ),
//                               CommonWidgets.verticalSpacerWidget(
//                                   height * 0.01),
//
//                               /// Replacement By
//                               CommonWidgets.textDisplay(
//                                   Constants.replacementBy,
//                                   isMandatory: true,
//                                   Styles.textStyleWhite14),
//
//                               TextFieldAddButton(
//                                 title: replacementByController.text,
//                                 height: 60,
//                                 isDisableColor: false,
//                                 onTap: () {
//                                   BaseOrganisationDialog().userDialog(
//                                     context: context,
//                                     users: replacementByUsers,
//                                     onTap: (BaseUser user) {
//                                       replacementByController.text =
//                                           user.name ?? '';
//                                       widget.model.replacementBy = user;
//
//                                       setState(() {
//                                         replacementByController.text =
//                                             user.name ?? '';
//                                       });
//                                     },
//                                     locationId: 0,
//                                   );
//                                 },
//                               ),
//
//                               CommonWidgets.verticalSpacerWidget(
//                                   height * 0.02),
//
//                               /// Replacement Type
//                               CommonWidgets.textDisplay(
//                                 Constants.replacementType,
//                                 Styles.textStyleWhite14,
//                               ),
//                               CommonWidgets.verticalSpacerWidget(
//                                   height * 0.001),
//
//                               BaseDropDown().getDropDown(
//                                 isDisabled: false,
//                                 textController: replacementTypeController,
//                                 items: replacementTypeList,
//                                 onTap: () {
//                                   BaseDropDown().assetTypeDialog(
//                                     context: context,
//                                     dropDownValues: replacementTypeList
//                                         .map((label) => label.key)
//                                         .toList(),
//                                     onTap: (String value) {
//                                       final selectedType = replacementTypeDropDownValues.firstWhere(
//                                             (label) => label.key == value,
//                                         orElse: () => const Label(key: '', value: ''),
//                                       );
//
//                                       setState(() {
//                                         replacementTypeController.text = selectedType.key;
//
//                                         // IMPORTANT: store the selected value in the model.
//                                         widget.model.replacementType =
//                                             int.tryParse(selectedType.value);
//                                       });
//                                     },
//                                   );
//                                 },
//                               ),
//
//                               CommonWidgets.verticalSpacerWidget(
//                                   height * 0.01),
//
//                               buttonViews(widget.mainContext, width),
//                               CommonWidgets.verticalSpacerWidget(
//                                   height * 0.02),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> getReplacementByUserListForAttendance() async {
//     if (fromDateController.text.isEmptyOrNull) {
//       return;
//     }
//
//     // FIX: Utils().convertToDateFormat() expects a datetime string (its
//     // usual input, from Utils().getCurrentDate(), looks like
//     // "06/09/2026 14:19:51" — date + time). Now that fromDateController
//     // holds a plain "dd/MM/yyyy" date (no time), that function's parser
//     // runs past the end of the string looking for the next literal and
//     // throws `FormatException: Trying to read / from 06/09/2026 at 11`.
//     //
//     // Rather than guess at that function's internal pattern, parse the
//     // dd/MM/yyyy value ourselves and format it directly to yyyy-MM-dd for
//     // the API call (matching the format the attendance endpoints use
//     // elsewhere, e.g. the fromDateMin/fromDateMax values in the
//     // getNextAvailableReplacementDates response).
//     DateTime? parsedFromDate;
//     try {
//       parsedFromDate =
//           DateFormat('dd/MM/yyyy').parseStrict(fromDateController.text.trim());
//     } catch (e) {
//       log('--Unable to parse fromDate "${fromDateController.text}" as dd/MM/yyyy: $e--');
//     }
//
//     if (parsedFromDate == null) {
//       return;
//     }
//
//     final apiFromDate = DateFormat('yyyy-MM-dd').format(parsedFromDate);
//
//     replacementByUsers = await AttendanceServices().getAttAvailableGuardsByDate(
//       dutyPostId: widget.shiftModel!.attendanceShiftId!,
//       rankId: widget.rankId!,
//       shiftId: widget.shiftId!,
//       fromDate: apiFromDate,
//     );
//
//     replacementByController.clear();
//   }
//
//   Future<void> getReplacementByUserList() async {
//     if (fromDateController.text.isEmptyOrNull ||
//         toDateController.text.isEmptyOrNull) {
//       return;
//     }
//
//     if (!areValidDates.status) {
//       Validator().showToast(
//         context,
//         areValidDates.message,
//       );
//       return;
//     }
//     replacementByUsers = await ShiftScheduleServices().getAvailableGuardsByDate(
//       dutyPostId: widget.dutyPostId!,
//       rankId: widget.rankId!,
//       shiftId: widget.shiftId!,
//       fromDate: fromDateController.text,
//       toDate: toDateController.text,
//     );
//
//     replacementByController.clear();
//   }
//
//   /// Routes to the correct "replacement by" lookup depending on where this
//   /// dialog is opened from. The From/To date pickers previously always
//   /// called getReplacementByUserList() (the duty-post/ShiftScheduleServices
//   /// variant) even when viaAttendance was true, which sent a duty-post
//   /// style request to an endpoint that didn't expect it and returned a
//   /// 400 with a plain-text "Invalid Id:563" body instead of JSON.
//   Future<void> _refreshReplacementByUsers() async {
//     if (widget.viaAttendance) {
//       await getReplacementByUserListForAttendance();
//     } else {
//       await getReplacementByUserList();
//     }
//   }
//
//   Widget buttonViews(BuildContext context, double width) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: <Widget>[cancelButton(width), saveButton(width)],
//     );
//   }
//
//   Widget cancelButton(double width) {
//     return PopButton(
//       width: width / 3.5,
//       key: const Key(Keys.cancelButton),
//       buttonText: Constants.cancel,
//       buttonTextKey: Keys.cancelButtonText,
//       foregroundColor: AppColors.white,
//       textStyle: Styles.styleHeaderGreyText16,
//       boarderColor: AppColors.white,
//       onTap: () {
//         FocusScope.of(context).unfocus();
//         Navigator.of(context).pop();
//       },
//     );
//   }
//
//   Widget saveButton(double width) {
//     return AppButton(
//       width: width / 3.5,
//       key: const Key(Keys.saveButton),
//       buttonText: Constants.save,
//       buttonTextKey: Keys.saveButtonText,
//       backgroundColor: AppColors.navigationSkyBlueColor,
//       onTap: () {
//         if (!isFormValid.status) {
//           Validator().showToast(
//             context,
//             isFormValid.message,
//           );
//           return;
//         }
//
//         /// Assigning temporary Id in order to update is properly
//         if (widget.model.id == null && widget.model.tempId.isEmptyOrNull) {
//           widget.model.tempId = Utils.createCryptoRandomString();
//         }
//         log('--Add/Update Replacement--- ${(widget.model.id)}--${widget.model.toString()}-');
//         log('-widget.model.tempId---${widget.model.tempId}----');
//
//         if (widget.viaAttendance) {
//           BlocProvider.of<AttendanceShiftsCubit>(widget.mainContext)
//               .updateReplacement(context, widget.model, false, false, true);
//         } else {
//           BlocProvider.of<DutyPostDetailsCubit>(widget.mainContext)
//               .updateReplacement(context, widget.model);
//         }
//       },
//     );
//   }
//
//   ErrorResponse get isReplacedForSelected {
//     if (replacementForController.text.isEmptyOrNull) {
//       return const ErrorResponse(
//           status: false, message: 'Please enter Replacement For');
//     }
//
//     return const ErrorResponse(status: true, message: 'Form is Valid');
//   }
//
//   ErrorResponse get areValidDates {
//     final fromDate = DateTime.tryParse(fromDateController.text);
//     final toDate = DateTime.tryParse(toDateController.text);
//
//     log('--fromDate-$fromDate-');
//
//     if (fromDate != null && toDate != null) {
//       if (fromDate.isAfter(toDate)) {
//         return const ErrorResponse(
//             status: false,
//             message: 'From Date cannot be later than the To Date');
//       }
//     }
//     return const ErrorResponse(status: true, message: 'Form is Valid');
//   }
//
//   ErrorResponse get isFormValid {
//     if (replacementForController.text.isEmptyOrNull) {
//       return const ErrorResponse(
//           status: false, message: 'Please enter Replacement For');
//     }
//
//     if (reasonController.text.isEmptyOrNull) {
//       return const ErrorResponse(status: false, message: 'Please enter Reason');
//     }
//     if (fromDateController.text.isEmptyOrNull) {
//       return const ErrorResponse(
//           status: false, message: 'Please enter From Date');
//     }
//     if (!widget.viaAttendance) {
//       if (toDateController.text.isEmptyOrNull) {
//         return const ErrorResponse(
//             status: false, message: 'Please enter To Date');
//       }
//     }
//
//     final fromDate = DateTime.tryParse(fromDateController.text);
//     final toDate = DateTime.tryParse(toDateController.text);
//
//     log('--fromDate-$fromDate-');
//
//     if (fromDate != null && toDate != null) {
//       if (fromDate.isAfter(toDate)) {
//         return const ErrorResponse(
//             status: false,
//             message: 'From Date cannot be later than the To Date');
//       }
//     }
//
//     if (replacementByController.text.isEmptyOrNull) {
//       return const ErrorResponse(
//           status: false, message: 'Please enter Replacement By');
//     }
//
//     return const ErrorResponse(status: true, message: 'Form is Valid');
//   }
// }

import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/common_widgets/base_widget/date_widgets/available_dates_picker.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/services/attendance_service.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/services/shift_schedule_services.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/shift_schedule_details/views/duty_post_details/cubits/duty_post_details_cubit.dart';
import 'package:intl/intl.dart';

class AddReplacementPopUp extends StatefulWidget {
  const AddReplacementPopUp({
    super.key,
    required this.mainContext,
    required this.model,
    required this.selectedGuards,
    this.dutyPostId,
    this.rankId,
    this.shiftId,
    this.attendanceId,
    required this.viaAttendance,
    required this.shiftModel,
    this.attendanceModel,
  });

  final bool viaAttendance;
  final BuildContext mainContext;
  final Replacement model;
  final Set<BaseUser> selectedGuards;
  final int? dutyPostId;
  final int? rankId;
  final int? shiftId;
  final int? attendanceId;
  final ShiftModel? shiftModel;
  final AttendanceModel? attendanceModel;

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
  TextEditingController replacementTypeController = TextEditingController();

  late List<Label> reasonList;
  late List<Label> replacementTypeList;

  @override
  void initState() {
    super.initState();
    log('--widget.model------${widget.model}--');

    replacementForController.text = widget.model.replacedFor?.name ?? '';
    replacementByController.text = widget.model.replacementBy?.name ?? '';
    if (widget.model.replacementType != null) {
      final matchingType = replacementTypeDropDownValues.firstWhere(
            (label) => label.value == widget.model.replacementType.toString(),
        orElse: () => const Label(key: '', value: ''),
      );

      replacementTypeController.text = matchingType.key;
    }
    replacementTypeList = replacementTypeDropDownValues;

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
    replacementTypeController.dispose();
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

  // Separate selectable-date lists for the From and To pickers.
  // The attendance API returns a min/max *range* (fromDateMin/fromDateMax,
  // toDateMin/toDateMax) rather than a flat list of pickable dates, so we
  // expand each range into a list ourselves before handing it to
  // LimitedDatePicker (which only understands a List<String>).
  List<String> fromDateOptions = [];
  List<String> toDateOptions = [];

  /// Expands an inclusive [minDate, maxDate] range into a list of individual
  /// date strings formatted as "dd/MM/yyyy" — the plain date format shown in
  /// fromDateController/toDateController and expected by
  /// getReplacementByUserListForAttendance's own parser.
  ///
  /// [minDate]/[maxDate] themselves come from the API as yyyy-MM-dd
  /// (e.g. "2026-09-06"), so we parse them with DateTime.tryParse (which
  /// understands ISO dates) and then re-format the output.
  ///
  /// Kept deliberately date-only (no time component): the date fields in
  /// this screen only ever display/pick a date, and
  /// getReplacementByUserListForAttendance() parses this exact string with
  /// DateFormat('dd/MM/yyyy') — adding a time component here would break
  /// that parse instead of fixing it.
  List<String> _generateDateRange(String? minDate, String? maxDate) {
    if (minDate.isEmptyOrNull || maxDate.isEmptyOrNull) return [];

    final min = DateTime.tryParse(minDate!);
    final max = DateTime.tryParse(maxDate!);
    if (min == null || max == null) return [];

    final formatter = DateFormat('dd/MM/yyyy');
    final List<String> result = [];
    for (DateTime d = min;
    !d.isAfter(max);
    d = d.add(const Duration(days: 1))) {
      result.add(formatter.format(d));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    Label? selectedReason;

    // BackdropFilter here blurs everything behind this dialog (the
    // underlying duty-post screen), since this widget sits in the
    // dialog route's Overlay entry above the whole app.
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            // Extra inner blur so the glass card reads as a distinct
            // surface, matching the frosted style used elsewhere in the app.
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1B2333).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.25),
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 20.0),
              child: Builder(builder: (context) {
                // Get available height and width of the build area of this widget.
                var height = MediaQuery.of(context).size.height;
                var width = MediaQuery.of(context).size.width;
                double divideBy = widget.viaAttendance ? 2.6 : 2.0;
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
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.01),
                              /// Replacement For
                              CommonWidgets.textDisplay(
                                  Constants.replacementFor,
                                  isMandatory: true,
                                  Styles.textStyleWhite14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              TextFieldAddButton(
                                title: replacementForController.text,
                                height: 60,
                                isDisableColor: false,
                                onTap: () {
                                  BaseOrganisationDialog().userDialog(
                                    context: context,
                                    users: widget.selectedGuards.toList(),
                                    onTap: (BaseUser user) async {
                                      replacementForController.text =
                                          user.name ?? '';
                                      widget.model.replacedFor = user;

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

                                      // FIX: widget.attendanceId can legitimately
                                      // be null if the caller forgot to pass it
                                      // (that was the actual bug — see
                                      // AttendanceShiftsView.buildReplacementColumn).
                                      // Guard here too so a missing id never
                                      // crashes the UI with a null-check error;
                                      // instead we just skip the date lookup and
                                      // let the from/to date pickers fall back to
                                      // an unrestricted range.
                                      if (widget.viaAttendance) {
                                        if (widget.rankId != null &&
                                            widget.dutyPostId != null &&
                                            widget.shiftId != null &&
                                            widget.attendanceId != null) {
                                          showLoadingDialog(context);

                                          dates = await AttendanceServices()
                                              .getNextAvailableReplacementDates(
                                            rankId: widget.rankId!,
                                            userId: user.id!,
                                            dutyPostId: widget.dutyPostId!,
                                            shiftId: widget.shiftId!,
                                            attendanceId: widget.attendanceId!,
                                          );
                                          dismissLoadingDialog(context);

                                          // Expand the API's min/max range
                                          // (fromDateMin/fromDateMax,
                                          // toDateMin/toDateMax) into pickable
                                          // date lists, and default the
                                          // From/To fields to the earliest
                                          // allowed date in each range so
                                          // the pickers show a value straight
                                          // away instead of staying blank.
                                          fromDateOptions = _generateDateRange(
                                            dates?.fromDateMin,
                                            dates?.fromDateMax,
                                          );
                                          toDateOptions = _generateDateRange(
                                            dates?.toDateMin,
                                            dates?.toDateMax,
                                          );

                                          if (fromDateOptions.isNotEmpty) {
                                            fromDateController.text =
                                                fromDateOptions.first;
                                            widget.model.fromDate = Utils()
                                                .formatTime(
                                                fromDateController.text);
                                          }
                                          if (toDateOptions.isNotEmpty) {
                                            toDateController.text =
                                                toDateOptions.first;
                                            widget.model.toDate = Utils()
                                                .formatTime(
                                                toDateController.text);
                                          }
                                        } else {
                                          log('--Skipping getNextAvailableReplacementDates: '
                                              'rankId=${widget.rankId}, '
                                              'dutyPostId=${widget.dutyPostId}, '
                                              'shiftId=${widget.shiftId}, '
                                              'attendanceId=${widget.attendanceId}--');
                                        }
                                      }

                                      setState(() {
                                        log('-setstate-');
                                        replacementForController.text =
                                            user.name ?? '';
                                      });
                                    },
                                    locationId: 0,
                                  );
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.01),

                              /// Reason
                              CommonWidgets.textDisplay(
                                Constants.reason,
                                Styles.textStyleWhite14,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
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
                                    dropDownValues: reasonList
                                        .map((label) => label.key)
                                        .toList(),
                                    onTap: (String value) {
                                      selectedReason =
                                          shiftScheduleReasonDropDownValues
                                              .firstWhere(
                                                (label) => label.key == value,
                                            orElse: () =>
                                            const Label(key: '', value: ''),
                                          );

                                      if (widget.viaAttendance) {
                                        getReplacementByUserListForAttendance();
                                      }
                                      setState(() {
                                        reasonConditions =
                                        (selectedReason != null &&
                                            (selectedReason!.value ==
                                                '1'));
                                      });
                                      log('--reasonConditions-$reasonConditions-');

                                      widget.model.status =
                                          int.tryParse(selectedReason!.value);
                                      reasonController.text =
                                          selectedReason!.key;
                                    },
                                  );
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.01),

                              /// From Date - Shift Schedule
                              CommonWidgets.textDisplay(
                                Constants.fromDate,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              LimitedDatePicker(
                                textController: fromDateController,
                                availableDates: widget.viaAttendance
                                    ? fromDateOptions
                                    : (dates?.availableDates ?? []),
                                isDisabled: false,
                                onChange: (String value) async {
                                  widget.model.fromDate =
                                      Utils().formatTime(value);
                                  if (reasonConditions) {
                                    log('--iffffff-reasonConditions--');
                                    toDateController.text =
                                        fromDateController.text;
                                    await _refreshReplacementByUsers();

                                    setState(() {
                                      widget.model.toDate =
                                          Utils().formatTime(value);
                                      toDateController.text =
                                          fromDateController.text;
                                    });
                                  }
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.01),

                              /// To Date
                              CommonWidgets.textDisplay(
                                Constants.toDate,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              LimitedDatePicker(
                                textController: toDateController,
                                availableDates: widget.viaAttendance
                                    ? toDateOptions
                                    : (dates?.availableDates ?? []),
                                onChange: (String value) async {
                                  widget.model.toDate =
                                      Utils().formatTime(value);
                                  await _refreshReplacementByUsers();
                                },
                                isDisabled: false,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.01),

                              /// Replacement By
                              CommonWidgets.textDisplay(
                                  Constants.replacementBy,
                                  isMandatory: true,
                                  Styles.textStyleWhite14),

                              TextFieldAddButton(
                                title: replacementByController.text,
                                height: 60,
                                isDisableColor: false,
                                onTap: () {
                                  BaseOrganisationDialog().userDialog(
                                    context: context,
                                    users: replacementByUsers,
                                    onTap: (BaseUser user) {
                                      replacementByController.text =
                                          user.name ?? '';
                                      widget.model.replacementBy = user;

                                      setState(() {
                                        replacementByController.text =
                                            user.name ?? '';
                                      });
                                    },
                                    locationId: 0,
                                  );
                                },
                              ),

                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.02),

                              /// Replacement Type
                              CommonWidgets.textDisplay(
                                Constants.replacementType,
                                Styles.textStyleWhite14,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),

                              BaseDropDown().getDropDown(
                                isDisabled: false,
                                textController: replacementTypeController,
                                items: replacementTypeList,
                                onTap: () {
                                  BaseDropDown().assetTypeDialog(
                                    context: context,
                                    dropDownValues: replacementTypeList
                                        .map((label) => label.key)
                                        .toList(),
                                    onTap: (String value) {
                                      final selectedType = replacementTypeDropDownValues.firstWhere(
                                            (label) => label.key == value,
                                        orElse: () => const Label(key: '', value: ''),
                                      );

                                      setState(() {
                                        replacementTypeController.text = selectedType.key;

                                        // IMPORTANT: store the selected value in the model.
                                        widget.model.replacementType =
                                            int.tryParse(selectedType.value);
                                      });
                                    },
                                  );
                                },
                              ),

                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.01),

                              buttonViews(widget.mainContext, width),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.02),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getReplacementByUserListForAttendance() async {
    if (fromDateController.text.isEmptyOrNull ||
        toDateController.text.isEmptyOrNull) {
      return;
    }

    // FIX: Utils().convertToDateFormat() expects a datetime string (its
    // usual input, from Utils().getCurrentDate(), looks like
    // "06/09/2026 14:19:51" — date + time). Now that fromDateController /
    // toDateController hold plain "dd/MM/yyyy" dates (no time), that
    // function's parser runs past the end of the string looking for the
    // next literal and throws
    // `FormatException: Trying to read / from 06/09/2026 at 11`.
    //
    // Rather than guess at that function's internal pattern, parse the
    // dd/MM/yyyy values ourselves and format them directly to yyyy-MM-dd
    // for the API call (matching the format the attendance endpoints use
    // elsewhere, e.g. the fromDateMin/fromDateMax values in the
    // getNextAvailableReplacementDates response).
    DateTime? parsedFromDate;
    DateTime? parsedToDate;
    try {
      parsedFromDate =
          DateFormat('dd/MM/yyyy').parseStrict(fromDateController.text.trim());
      parsedToDate =
          DateFormat('dd/MM/yyyy').parseStrict(toDateController.text.trim());
    } catch (e) {
      log('--Unable to parse from/to date as dd/MM/yyyy: '
          'from="${fromDateController.text}", '
          'to="${toDateController.text}": $e--');
    }

    if (parsedFromDate == null || parsedToDate == null) {
      return;
    }

    final apiDateFormat = DateFormat('yyyy-MM-dd');
    final apiFromDate = apiDateFormat.format(parsedFromDate);
    final apiToDate = apiDateFormat.format(parsedToDate);

    replacementByUsers = await AttendanceServices().getAttAvailableGuardsByDate(
      dutyPostId: widget.shiftModel!.attendanceShiftId!,
      rankId: widget.rankId!,
      shiftId: widget.shiftId!,
      fromDate: apiFromDate,
      toDate: apiToDate,
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

  /// Routes to the correct "replacement by" lookup depending on where this
  /// dialog is opened from. The From/To date pickers previously always
  /// called getReplacementByUserList() (the duty-post/ShiftScheduleServices
  /// variant) even when viaAttendance was true, which sent a duty-post
  /// style request to an endpoint that didn't expect it and returned a
  /// 400 with a plain-text "Invalid Id:563" body instead of JSON.
  Future<void> _refreshReplacementByUsers() async {
    if (widget.viaAttendance) {
      await getReplacementByUserListForAttendance();
    } else {
      await getReplacementByUserList();
    }
  }

  Widget buttonViews(BuildContext context, double width) {
    return Row(
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
      foregroundColor: AppColors.white,
      textStyle: Styles.styleHeaderGreyText16,
      boarderColor: AppColors.white,
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

        if (widget.viaAttendance) {
          BlocProvider.of<AttendanceShiftsCubit>(widget.mainContext)
              .updateReplacement(context, widget.model, false, false, true);
        } else {
          BlocProvider.of<DutyPostDetailsCubit>(widget.mainContext)
              .updateReplacement(context, widget.model);
        }
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
        return const ErrorResponse(
            status: false,
            message: 'From Date cannot be later than the To Date');
      }
    }

    if (replacementByController.text.isEmptyOrNull) {
      return const ErrorResponse(
          status: false, message: 'Please enter Replacement By');
    }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }
}