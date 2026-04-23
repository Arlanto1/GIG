// // import 'dart:developer';
// //
// // import 'package:db_atom/index.dart';
// // import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
// // import 'package:intl/intl.dart';
// //
// // class BaseDate {
// //   /// Display Create Time
// //   Widget creationDateDisplay(String date) {
// //     return FlutterInputField(
// //       textFormKey: Keys.dateofcreationTextController,
// //       initialValue: date,
// //       hintText: '',
// //       isEnable: false,
// //       isDisableColor: true,
// //       onChange: (String value) {},
// //       validateTextField: (String? user) {},
// //     );
// //   }
// //
// //   Widget datePickerWidgetLoading({
// //     required TextEditingController textController,
// //     bool isDisabled = false,
// //     bool showPastDate = true,
// //     bool showFutureDate = true,
// //     bool onlyDate = false,
// //     bool notFlagDate = false,
// //     String? startDate,
// //     String? fromDate, // for giving date range
// //     String? toDate, // for giving date range
// //     required Function(String) onChange,
// //     required BuildContext context,
// //   }) {
// //     // Convert Date Time if String
// //     if (Utils().isTimestamp(textController.text)) {
// //       textController.text = Utils.timestampToDateConversion(
// //           int.tryParse(textController.text),
// //           onlyDate ? Constants.dateFormat : Constants.fulldateFormat);
// //     }
// //
// //     return GestureDetector(
// //       onTap: () async {
// //         log('-textController.text---!!!!!-${textController.text}----');
// //         if (!isDisabled) {
// //           textController.text = await BaseDate().datePickerDialog(
// //             textController: textController,
// //             startDate: startDate,
// //             showPastDate: showPastDate,
// //             showFutureDate: showFutureDate,
// //             onChange: onChange,
// //             context: context,
// //             onlyDate: onlyDate,
// //             fromDate: fromDate,
// //             toDate: toDate,
// //             notFlagDate: notFlagDate,
// //           );
// //
// //           log('-textController.text----${textController.text}----');
// //         }
// //         log('-textController.text---222-${textController.text}----');
// //       },
// //       child: Opacity(
// //         opacity: isDisabled ? .5 : 1,
// //         child: AbsorbPointer(
// //           absorbing: true,
// //           child: FlutterInputField(
// //             controller: textController,
// //             textFormKey: textController == textController
// //                 ? Keys.founddateTextController
// //                 : Keys.handedoverdateTextController,
// //             hintText: '',
// //             suffixIcon: Icons.calendar_month,
// //             isEnable: true,
// //             isDisableColor: isDisabled,
// //             onChange: onChange,
// //             // Pass the onChange callback to FlutterInputField
// //             validateTextField: (String? user) {},
// //             suffixWidget: GestureDetector(
// //               child: Padding(
// //                 padding: const EdgeInsets.all(20.0),
// //                 child: SvgPicture.asset(
// //                   AppIcon.calendaricon,
// //                   colorFilter: const ColorFilter.mode(
// //                     AppColors.white,
// //                     BlendMode.srcIn,
// //                   ),
// //                   width: 20,
// //                   key: const Key(Keys.userIcon),
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //
// //   Future<String> datePickerDialog({
// //     required TextEditingController textController,
// //     required Function(String) onChange,
// //     required BuildContext context,
// //     bool showPastDate = true,
// //     bool showFutureDate = true,
// //     bool onlyDate = false,
// //     String? startDate,
// //     String? fromDate, // for giving date range
// //     String? toDate, // for giving date range
// //     bool? notFlagDate = true, // for giving date range
// //   }) async {
// //     DateTime? pickedDate;
// //
// //     DateTime currentTime = DateTime.now();
// //
// //     DateTime minTime = showPastDate ? DateTime(1900) : currentTime;
// //     DateTime maxTime = showFutureDate ? DateTime(2101) : currentTime;
// //
// //     if (!startDate.isEmptyOrNull) {
// //       if (startDate!.contains('-')) {
// //         // it is formated date
// //         minTime = DateTime.parse(startDate);
// //       } else {
// //         // it is a timestamp
// //         // Parse the startDate as an int and convert it to milliseconds
// //         int millisecondsSinceEpoch = startDate.toIntOrNull() ?? 0;
// //
// //         // Check if the parsed value is valid
// //         if (millisecondsSinceEpoch > 0) {
// //           // Convert milliseconds since epoch to DateTime
// //           minTime = DateTime.fromMillisecondsSinceEpoch(
// //               millisecondsSinceEpoch * 1000);
// //
// //           // Ensure minTime is not before the current time
// //           minTime = minTime.isBefore(currentTime) ? currentTime : minTime;
// //         }
// //       }
// //     }
// //
// //     log('--fromDate----$fromDate----toDate----$toDate');
// //
// //     if (!fromDate.isEmptyOrNull && !toDate.isEmptyOrNull) {
// //       log('--if (!fromDate.isEmptyOrNull && !toDate.isEmptyOrNull)--');
// //       DatePicker.showDatePicker(
// //         context,
// //         showTitleActions: true,
// //         minTime: DateTime.parse(fromDate!),
// //         maxTime: DateTime.parse(toDate!),
// //         onChanged: (date) {
// //           FocusManager.instance.primaryFocus?.unfocus();
// //           pickedDate = date;
// //           log('change $date');
// //         },
// //         onCancel: () {
// //           FocusManager.instance.primaryFocus?.unfocus();
// //         },
// //         onConfirm: (date) {
// //           pickedDate = date;
// //           log('confirm $date');
// //           if (pickedDate != null) {
// //             if (!onlyDate) {
// //               showTimePicker(
// //                 context: context,
// //                 pickedDate: pickedDate!,
// //                 onlyDate: onlyDate,
// //                 textController: textController,
// //                 onChange: onChange,
// //               );
// //             }
// //             String dateTime =
// //                 setDateTime(pickedDate!, onlyDate, textController, onChange);
// //             log('--!!!!!----dateTime---$dateTime------');
// //             return dateTime;
// //             // return setDateTime(pickedDate!, onlyDate, textController, onChange);
// //           }
// //         },
// //         currentTime: currentTime,
// //         locale: LocaleType.en,
// //       );
// //     } else if (onlyDate) {
// //       log('--else if (onlyDate)--');
// //       DatePicker.showDatePicker(
// //         context,
// //         showTitleActions: true,
// //         minTime: minTime,
// //         maxTime: maxTime,
// //         onChanged: (date) {
// //           pickedDate = date;
// //           log('change $date');
// //         },
// //         onConfirm: (date) {
// //           pickedDate = date;
// //           log('confirm $date');
// //           if (pickedDate != null) {
// //             return setDateTime(pickedDate!, onlyDate, textController, onChange);
// //           }
// //         },
// //         currentTime: currentTime,
// //         locale: LocaleType.en,
// //       );
// //     } else if (!startDate.isEmptyOrNull || notFlagDate == true) {
// //       log('--else if (flagDate == true)--');
// //       DatePicker.showDatePicker(
// //         context,
// //         showTitleActions: true,
// //         minTime: minTime,
// //         maxTime: maxTime,
// //         onChanged: (date) {
// //           FocusManager.instance.primaryFocus?.unfocus();
// //           pickedDate = date;
// //           log('change $date');
// //         },
// //         onConfirm: (date) {
// //           // pickedDate = date;
// //           // log('confirm $date');
// //           // if (pickedDate != null) {
// //           //   return setDateTime(pickedDate!, onlyDate, textController, onChange);
// //           // }
// //
// //           pickedDate = date;
// //           log('confirm $date');
// //           if (pickedDate != null) {
// //             if (!onlyDate) {
// //               showTimePicker(
// //                 context: context,
// //                 pickedDate: pickedDate!,
// //                 onlyDate: onlyDate,
// //                 textController: textController,
// //                 onChange: onChange,
// //               );
// //             }
// //             String dateTime =
// //                 setDateTime(pickedDate!, onlyDate, textController, onChange);
// //             log('--!!!!!----dateTime---$dateTime------');
// //             return dateTime;
// //             // return setDateTime(pickedDate!, onlyDate, textController, onChange);
// //           }
// //         },
// //         currentTime: currentTime,
// //         locale: LocaleType.en,
// //       );
// //     } else {
// //       log('--else@@@@@@--');
// //
// //       DatePicker.showDateTimePicker(
// //         context,
// //         showTitleActions: true,
// //         minTime: minTime,
// //         maxTime: maxTime,
// //         onChanged: (date) {
// //           pickedDate = date;
// //           log('change $date');
// //         },
// //         onConfirm: (date) {
// //           pickedDate = date;
// //           log('pickedDate------ $date');
// //           if (pickedDate != null) {
// //             // showTimePicker(
// //             //   context: context,
// //             //   pickedDate: pickedDate!,
// //             //   onlyDate: onlyDate,
// //             //   textController: textController,
// //             //   onChange: onChange,
// //             // );
// //             String dateTime =
// //                 setDateTime(pickedDate!, onlyDate, textController, onChange);
// //             log('--@@@----dateTime---$dateTime------');
// //             return dateTime;
// //           }
// //         },
// //         currentTime: currentTime,
// //         locale: LocaleType.en,
// //       );
// //     }
// //     log('--before--pickedDate != null-----');
// //
// //     if (pickedDate != null) {
// //       log('--pickedDate != null-----');
// //
// //       // return setDateTime(pickedDate!, onlyDate, textController, onChange);
// //       String dateTime =
// //           setDateTime(pickedDate!, onlyDate, textController, onChange);
// //       log('--@@@---pickedDate != null-dateTime---$dateTime------');
// //       return dateTime;
// //     } else {
// //       log('--pickedDate != null---else--');
// //       // Handle the case where the user cancels the picker
// //       return ''; // You can modify the return value accordingly
// //     }
// //   }
// //
// //   void showTimePicker({
// //     required BuildContext context,
// //     required DateTime pickedDate,
// //     required bool onlyDate,
// //     required TextEditingController textController,
// //     onChange,
// //   }) {
// //     DatePicker.showTimePicker(
// //       context,
// //       currentTime: pickedDate,
// //       // showSecondsColumn: false,
// //       showTitleActions: true,
// //       onChanged: (time) {
// //         log('--onChanged-showTimePicker--$time-');
// //       },
// //       onConfirm: (time) {
// //         log('--time--${time.toString()}--');
// //
// //         String dateTime = setDateTime(time, onlyDate, textController, onChange);
// //         log('-11111-dateTime--$dateTime-');
// //         return dateTime;
// //       },
// //     );
// //   }
// //
// //   String setDateTime(
// //     DateTime? pickedDate,
// //     bool onlyDate,
// //     TextEditingController textController,
// //     Function(String) onChange,
// //   ) {
// //     log('--pickedDate-sss-$pickedDate--');
// //     String formattedDate = DateFormat(
// //       onlyDate ? Constants.dateFormat : Constants.fulldateFormat,
// //     ).format(pickedDate!);
// //
// //     textController.text = formattedDate;
// //     log('--textController.text-sss-${textController.text}--');
// //
// //     onChange(formattedDate);
// //     log('--formattedDate-sss-$formattedDate--');
// //     return formattedDate;
// //   }
// // }
//
import 'dart:developer';
import 'dart:ui';
import 'package:db_atom/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';

class BaseDate {
  /// Display Create Time
  Widget creationDateDisplay(String date) {
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

  Widget datePickerWidgetLoading({
    required TextEditingController textController,
    bool isDisabled = false,
    bool showPastDate = true,
    bool showFutureDate = true,
    bool onlyDate = false,
    bool notFlagDate = false,
    String? startDate,
    String? fromDate, // for giving date range
    String? toDate, // for giving date range
    required Function(String) onChange,
    required BuildContext context,
  }) {
    // Convert Date Time if String
    if (Utils().isTimestamp(textController.text)) {
      textController.text = Utils.timestampToDateConversion(
          int.tryParse(textController.text),
          onlyDate ? Constants.dateFormat : Constants.fulldateFormat);
    }

    return GestureDetector(
      onTap: () async {
        log('-textController.text---!!!!!-${textController.text}----');
        if (!isDisabled) {
          textController.text = await BaseDate().datePickerDialog(
            textController: textController,
            startDate: startDate,
            showPastDate: showPastDate,
            showFutureDate: showFutureDate,
            onChange: onChange,
            context: context,
            onlyDate: onlyDate,
            fromDate: fromDate,
            toDate: toDate,
            notFlagDate: notFlagDate,
          );

          log('-textController.text----${textController.text}----');
        }
        log('-textController.text---222-${textController.text}----');
      },
      child: Opacity(
        opacity: isDisabled ? .5 : 1,
        child: AbsorbPointer(
          absorbing: true,
          child: FlutterInputField(
            controller: textController,
            textFormKey: textController == textController
                ? Keys.founddateTextController
                : Keys.handedoverdateTextController,
            hintText: '',
            suffixIcon: Icons.calendar_month,
            isEnable: !isDisabled,
            isDisableColor: isDisabled,
            onChange: onChange,
            // Pass the onChange callback to FlutterInputField
            validateTextField: (String? user) {},
            suffixWidget: GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SvgPicture.asset(
                  AppIcon.calendaricon,
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                  width: 20,
                  key: const Key(Keys.userIcon),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// ----------------------------
  /// Glass Apple-style Wheel Picker
  /// ----------------------------
  // Future<DateTime?> showGlassWheelDatePicker({
  //   required BuildContext context,
  //   required DateTime initialDateTime,
  //   required DateTime minDate,
  //   required DateTime maxDate,
  //   required bool onlyDate,
  // }) async {
  //   DateTime selected = initialDateTime;
  //
  //   return showModalBottomSheet<DateTime?>(
  //     context: context,
  //     isScrollControlled: true,
  //     backgroundColor: Colors.transparent,
  //     barrierColor: Colors.transparent,
  //
  //     builder: (context) {
  //       return Padding(
  //         padding: EdgeInsets.only(
  //           bottom: MediaQuery.of(context).viewInsets.bottom,
  //         ),
  //
  //         child: ClipRRect(
  //           borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
  //           child: BackdropFilter(
  //             filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
  //
  //             child: Container(
  //               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
  //               decoration: BoxDecoration(
  //                 color: Colors.white.withOpacity(0.08),
  //                 border: Border(
  //                   top: BorderSide(
  //                     color: Colors.white.withOpacity(0.25),
  //                     width: 0.8,
  //                   ),
  //                 ),
  //               ),
  //
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   // ---- HEADER ----
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       TextButton(
  //                         onPressed: () => Navigator.pop(context, null),
  //                         child: Text(
  //                           "Cancel",
  //                           style: TextStyle(
  //                             color: Colors.white.withOpacity(0.85),
  //                           ),
  //                         ),
  //                       ),
  //                       Text(
  //                         onlyDate ? "Select Date" : "Select Date & Time",
  //                         style: TextStyle(
  //                           color: Colors.white.withOpacity(0.95),
  //                           fontSize: 16,
  //                           fontWeight: FontWeight.w600,
  //                         ),
  //                       ),
  //                       TextButton(
  //                         onPressed: () => Navigator.pop(context, selected),
  //                         child: Text(
  //                           "Done",
  //                           style: TextStyle(
  //                             color: Colors.white.withOpacity(0.85),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //
  //                   const SizedBox(height: 10),
  //
  //                   // ---- CALENDAR UI ----
  //                   // CalendarDatePicker(
  //                   //   initialDate: initialDateTime,
  //                   //   firstDate: minDate,
  //                   //   lastDate: maxDate,
  //                   //   onDateChanged: (d) {
  //                   //     selected = d;
  //                   //   },
  //                   // ),
  //
  //                   const SizedBox(height: 20),
  //
  //                   // ---- TIME PICKER (only if needed) ----
  //                   if (!onlyDate)
  //                     Theme(
  //                       data: Theme.of(context).copyWith(
  //                         colorScheme: ColorScheme.dark(
  //                           primary: Colors.white,              // selected date
  //                           onSurface: Colors.white.withOpacity(0.85), // active dates
  //                           onBackground: Colors.white.withOpacity(0.40), // disabled dates
  //                         ),
  //                         textTheme: TextTheme(
  //                           bodyLarge: TextStyle(
  //                             fontSize: 18,
  //                             color: Colors.white.withOpacity(0.90), // active date text
  //                           ),
  //                           bodyMedium: TextStyle(
  //                             fontSize: 16,
  //                             color: Colors.white.withOpacity(0.60), // disabled date text
  //                           ),
  //                           titleMedium: TextStyle(
  //                             fontSize: 18,
  //                             fontWeight: FontWeight.w600,
  //                             color: Colors.white.withOpacity(0.95), // month title
  //                           ),
  //                         ),
  //                       ),
  //                       // child: CalendarDatePicker(
  //                       //   initialDate: initialDateTime,
  //                       //   firstDate: minDate,
  //                       //   lastDate: maxDate,
  //                       //   onDateChanged: (d) {
  //                       //     selected = d;
  //                       //   },
  //                       // ),
  //                       child: CalendarDatePicker(
  //                         initialDate: initialDateTime,
  //                         firstDate: minDate,
  //                         lastDate: maxDate,
  //                         onDateChanged: (d) {
  //                           selected = d;
  //                         },
  //                       ),
  //                     ),
  //
  //
  //                   const SizedBox(height: 10),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Future<DateTime?> showGlassWheelDatePicker({
    required BuildContext context,
    required DateTime initialDateTime,
    required DateTime minDate,
    required DateTime maxDate,
    required bool onlyDate,
  }) async {
    // DateTime selected = initialDateTime;
    DateTime clampedInitial = initialDateTime;
    if (clampedInitial.isBefore(minDate)) clampedInitial = minDate;
    if (clampedInitial.isAfter(maxDate)) clampedInitial = maxDate;

    DateTime selected = clampedInitial;
    return showModalBottomSheet<DateTime?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (context) {
        // Controllers for time wheels
        int hour = selected.hour % 12 == 0 ? 12 : selected.hour % 12;
        int minute = selected.minute;
        bool isPM = selected.hour >= 12;

        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration:
                BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withValues(alpha: 0.09),
                      Colors.transparent,
                      Colors.white.withValues(alpha: 0.09),
                      // Color(0xFF6474C6).withOpacity(0.14)
                    ],
                    stops: [0.02, 0.35, 1],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(27),
                  border: Border.all(
                    color: Colors.white
                        .withValues(alpha: 0.6),
                    width: 0.7,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white
                          .withValues(alpha: 0.0),
                      blurRadius: 12,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // HEADER
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, null),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withValues(alpha: 0.85)),
                          ),
                        ),
                        Text(
                          onlyDate ? "Select Date" : "Select Date & Time",
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.95),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, selected),
                          child: Text(
                            "Done",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withValues(alpha: 0.85)),
                          ),
                        ),
                      ],
                    ),

                    // const SizedBox(height: 1),

                    ///       CALENDAR
                    Theme(
                      data: Theme.of(context).copyWith(
                        // colorScheme: ColorScheme.dark(
                        //   primary: Colors.white, // selected date
                        //   onSurface: Colors.white, // active days
                        //   onBackground:
                        //       Colors.white.withValues(alpha: 0.35), // disabled days
                        // ),
                        colorScheme: const ColorScheme.dark(
                          primary: Colors.white, // selected date
                          onSurface: Colors.white, // active days
                        ).copyWith(
                          onSurface: Colors.white, // active days
                        ),

                        textTheme: TextTheme(
                          bodyLarge: TextStyle(
                              fontSize: 20,
                              color: Colors.white.withValues(alpha: 0.95)),
                          bodyMedium: TextStyle(
                              fontSize: 10,
                              color: Colors.white.withValues(alpha: 0.75)),
                          titleMedium: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white.withValues(alpha: 0.98),
                          ),
                        ),
                      ),
                      child: CalendarDatePicker(
                        initialDate: clampedInitial,
                        firstDate: minDate,
                        lastDate: maxDate,
                        onDateChanged: (d) {
                          selected = DateTime(
                            d.year,
                            d.month,
                            d.day,
                            selected.hour,
                            selected.minute,
                          );
                        },
                      ),
                    ),

                    ///      TIME PICKER (if enabled)
                    if (!onlyDate)
                      Column(
                        children: [
                          // const SizedBox(height: 10),
                          // ---- TITLE ----
                          Text(
                            "Select Time",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withValues(alpha: 0.95),
                            ),
                          ),

                          const SizedBox(height: 10),
                          SizedBox(
                            height: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // HOUR WHEEL
                                Expanded(
                                  child: CupertinoPicker(
                                    itemExtent: 38,
                                    scrollController:
                                        FixedExtentScrollController(
                                            initialItem: hour - 1),
                                    onSelectedItemChanged: (value) {
                                      hour = value + 1;
                                      int newHour =
                                          isPM ? (hour % 12) + 12 : hour % 12;
                                      selected = DateTime(
                                        selected.year,
                                        selected.month,
                                        selected.day,
                                        newHour,
                                        selected.minute,
                                      );
                                    },
                                    children: List.generate(
                                      12,
                                      (i) => Center(
                                        child: Text(
                                          "${i + 1}".padLeft(2, '0'),
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white
                                                  .withValues(alpha: 0.95)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // MINUTE WHEEL
                                Expanded(
                                  child: CupertinoPicker(
                                    itemExtent: 38,
                                    scrollController:
                                        FixedExtentScrollController(
                                            initialItem: minute),
                                    onSelectedItemChanged: (value) {
                                      minute = value;
                                      selected = DateTime(
                                        selected.year,
                                        selected.month,
                                        selected.day,
                                        selected.hour,
                                        minute,
                                      );
                                    },
                                    children: List.generate(
                                      60,
                                      (i) => Center(
                                        child: Text(
                                          i.toString().padLeft(2, '0'),
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white
                                                  .withValues(alpha: 0.95)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // AM / PM
                                Expanded(
                                  child: CupertinoPicker(
                                    itemExtent: 38,
                                    scrollController:
                                        FixedExtentScrollController(
                                            initialItem: isPM ? 1 : 0),
                                    onSelectedItemChanged: (value) {
                                      isPM = value == 1;
                                      int h = hour % 12;
                                      int newHour = isPM ? h + 12 : h;
                                      selected = DateTime(
                                        selected.year,
                                        selected.month,
                                        selected.day,
                                        newHour,
                                        selected.minute,
                                      );
                                    },
                                    children: const [
                                      Center(
                                          child: Text("AM",
                                              style: TextStyle(
                                                  color: Colors.white))),
                                      Center(
                                          child: Text("PM",
                                              style: TextStyle(
                                                  color: Colors.white))),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<String> datePickerDialog({
    required TextEditingController textController,
    required Function(String) onChange,
    required BuildContext context,
    bool showPastDate = true,
    bool showFutureDate = true,
    bool onlyDate = false,
    String? startDate,
    String? fromDate, // for giving date range
    String? toDate, // for giving date range
    bool? notFlagDate = true, // for giving date range
  }) async {
    DateTime? pickedDate;

    DateTime currentTime = DateTime.now();

    DateTime minTime = showPastDate ? DateTime(1900) : currentTime;
    DateTime maxTime = showFutureDate ? DateTime(2101) : currentTime;

    // handle startDate being formatted date or timestamp
    if (!startDate.isEmptyOrNull) {
      if (startDate!.contains('-')) {
        // it is formatted date
        try {
          minTime = DateTime.parse(startDate);
        } catch (e) {
          log('startDate parse error: $e');
        }
      } else {
        int millisecondsSinceEpoch = startDate.toIntOrNull() ?? 0;
        if (millisecondsSinceEpoch > 0) {
          minTime = DateTime.fromMillisecondsSinceEpoch(
              millisecondsSinceEpoch * 1000);
          minTime = minTime.isBefore(currentTime) ? currentTime : minTime;
        }
      }
    }

    log('--fromDate----$fromDate----toDate----$toDate');

    // Determine an initial date for the picker:
    DateTime initialPickerDate = currentTime;

    // If controller has a date string, try to parse it to set initial value
    if (textController.text.isNotEmpty) {
      DateTime? parsed;
      // try ISO parse first
      parsed = DateTime.tryParse(textController.text);
      if (parsed == null) {
        // try known formats
        try {
          parsed = DateFormat(Constants.fulldateFormat)
              .parseLoose(textController.text);
        } catch (_) {
          try {
            parsed = DateFormat(Constants.dateFormat)
                .parseLoose(textController.text);
          } catch (_) {
            parsed = null;
          }
        }
      }
      if (parsed != null) {
        initialPickerDate = parsed;
      }
    }

// After ✅ — also handle fromDate-only (no toDate) case
    if (fromDate != null && fromDate.trim().isNotEmpty) {
      DateTime? rangeMinDate;
      try {
        rangeMinDate = DateTime.parse(fromDate);
      } catch (e) {
        // try as timestamp
        int? ts = int.tryParse(fromDate);
        if (ts != null) {
          rangeMinDate = DateTime.fromMillisecondsSinceEpoch(ts * 1000);
        }
        log('fromDate parse error: $e, value: $fromDate');
      }

      if (rangeMinDate != null) {
        if (initialPickerDate.isBefore(rangeMinDate)) {
          initialPickerDate = rangeMinDate;
        }
        minTime = rangeMinDate; // ✅ This is the key line — sets minimum selectable date
      }
    }
    // from-to range present
    if (fromDate != null && fromDate.trim().isNotEmpty && !toDate.isEmptyOrNull) {
      // from-to range present - WITH SAFE PARSING
      DateTime? rangeMinDate, rangeMaxDate;
      if (fromDate != null && fromDate.trim().isNotEmpty) {
        try {
          rangeMinDate = DateTime.parse(fromDate);
          log('End picker fromDate parsed: $rangeMinDate');
        } catch (e) {
          log('fromDate parse error: $e, value: $fromDate');
        }
      }
      if (!toDate.isEmptyOrNull) {
        try {
          rangeMaxDate = DateTime.parse(toDate!);
        } catch (e) {
          log('toDate parse error: $e');
        }
      }

      if (rangeMinDate != null) {
        if (initialPickerDate.isBefore(rangeMinDate)) initialPickerDate = rangeMinDate;
      }
      if (rangeMaxDate != null && initialPickerDate.isAfter(rangeMaxDate)) {
        initialPickerDate = rangeMaxDate;
      }

      pickedDate = await showGlassWheelDatePicker(
        context: context,
        initialDateTime: initialPickerDate,
        minDate: rangeMinDate ?? minTime,
        maxDate: rangeMaxDate ?? maxTime,
        onlyDate: onlyDate,
      );

    }

    else if (onlyDate) {
      // only date (without time)
      pickedDate = await showGlassWheelDatePicker(
        context: context,
        initialDateTime: initialPickerDate,
        minDate: minTime,
        maxDate: maxTime,
        onlyDate: onlyDate,
      );
    } else if (!startDate.isEmptyOrNull || notFlagDate == true) {
      // startDate set or flag true
      pickedDate = await showGlassWheelDatePicker(
        context: context,
        initialDateTime: initialPickerDate,
        minDate: minTime,
        maxDate: maxTime,
        onlyDate: onlyDate,
      );
    } else {
      // fallback: date & time wheel
      pickedDate = await showGlassWheelDatePicker(
        context: context,
        initialDateTime: initialPickerDate,
        minDate: minTime,
        maxDate: maxTime,
        onlyDate: onlyDate,
      );
    }

    log('--before--pickedDate != null-----');

    if (pickedDate != null) {
      log('--pickedDate != null-----');

      String dateTime =
          setDateTime(pickedDate, onlyDate, textController, onChange);
      log('--@@@---pickedDate != null-dateTime---$dateTime------');
      return dateTime;
    } else {
      log('--pickedDate != null---else--');
      // Handle the case where the user cancels the picker
      return ''; // unchanged behavior
    }
  }

  void showTimePicker({
    required BuildContext context,
    required DateTime pickedDate,
    required bool onlyDate,
    required TextEditingController textController,
    onChange,
  }) {
    DatePicker.showTimePicker(
      context,
      currentTime: pickedDate,
      // showSecondsColumn: false,
      showTitleActions: true,
      onChanged: (time) {
        log('--onChanged-showTimePicker--$time-');
      },
      onConfirm: (time) {
        log('--time--${time.toString()}--');

        String dateTime = setDateTime(time, onlyDate, textController, onChange);
        log('-11111-dateTime--$dateTime-');
        return dateTime;
      },
    );
  }

  String setDateTime(
    DateTime? pickedDate,
    bool onlyDate,
    TextEditingController textController,
    Function(String) onChange,
  ) {
    log('--pickedDate-sss-$pickedDate--');
    String formattedDate = DateFormat(
      onlyDate ? Constants.dateFormat : Constants.fulldateFormat,
    ).format(pickedDate!);

    textController.text = formattedDate;
    log('--textController.text-sss-${textController.text}--');

    onChange(formattedDate);
    log('--formattedDate-sss-$formattedDate--');
    return formattedDate;
  }
}

// import 'dart:developer';
// import 'dart:ui';
//
// import 'package:db_atom/index.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
// import 'package:intl/intl.dart';
//
// class BaseDate {
//   /// Display Create Time
//   Widget creationDateDisplay(String date) {
//     return FlutterInputField(
//       textFormKey: Keys.dateofcreationTextController,
//       initialValue: date,
//       hintText: '',
//       isEnable: false,
//       isDisableColor: true,
//       onChange: (String value) {},
//       validateTextField: (String? user) {},
//     );
//   }
//
//   Widget datePickerWidgetLoading({
//     required TextEditingController textController,
//     bool isDisabled = false,
//     bool showPastDate = true,
//     bool showFutureDate = true,
//     bool onlyDate = false,
//     bool notFlagDate = false,
//     String? startDate,
//     String? fromDate, // for giving date range
//     String? toDate, // for giving date range
//     required Function(String) onChange,
//     required BuildContext context,
//   }) {
//     // Convert Date Time if String
//     if (Utils().isTimestamp(textController.text)) {
//       textController.text = Utils.timestampToDateConversion(
//           int.tryParse(textController.text),
//           onlyDate ? Constants.dateFormat : Constants.fulldateFormat);
//     }
//
//     return GestureDetector(
//       onTap: () async {
//         log('-textController.text---!!!!!-${textController.text}----');
//         if (!isDisabled) {
//           textController.text = await BaseDate().datePickerDialog(
//             textController: textController,
//             startDate: startDate,
//             showPastDate: showPastDate,
//             showFutureDate: showFutureDate,
//             onChange: onChange,
//             context: context,
//             onlyDate: onlyDate,
//             fromDate: fromDate,
//             toDate: toDate,
//             notFlagDate: notFlagDate,
//           );
//
//           log('-textController.text----${textController.text}----');
//         }
//         log('-textController.text---222-${textController.text}----');
//       },
//       child: Opacity(
//         opacity: isDisabled ? .5 : 1,
//         child: AbsorbPointer(
//           absorbing: true,
//           child: FlutterInputField(
//             controller: textController,
//             textFormKey: textController == textController
//                 ? Keys.founddateTextController
//                 : Keys.handedoverdateTextController,
//             hintText: '',
//             suffixIcon: Icons.calendar_month,
//             isEnable: true,
//             isDisableColor: isDisabled,
//             onChange: onChange,
//             // Pass the onChange callback to FlutterInputField
//             validateTextField: (String? user) {},
//             suffixWidget: GestureDetector(
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: SvgPicture.asset(
//                   AppIcon.calendaricon,
//                   colorFilter: const ColorFilter.mode(
//                     AppColors.white,
//                     BlendMode.srcIn,
//                   ),
//                   width: 20,
//                   key: const Key(Keys.userIcon),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // ----------------------------
//   // Helper: Build Month Grid Data
//   // ----------------------------
//   List<DateTime> _generateMonthDays(int year, int month) {
//     final first = DateTime(year, month, 1);
//     final firstWeekday = first.weekday % 7; // convert to 0=Sun..6=Sat
//     final daysInMonth = DateUtils.getDaysInMonth(year, month);
//     final List<DateTime> result = [];
//
//     // prepend previous month's tail
//     if (firstWeekday > 0) {
//       final prevMonthLastDay = first.subtract(const Duration(days: 1));
//       final prevDaysInMonth = prevMonthLastDay.day;
//       for (int i = firstWeekday - 1; i >= 0; i--) {
//         result.add(DateTime(year, month - 1, prevDaysInMonth - i));
//       }
//     }
//
//     // current month days
//     for (int d = 1; d <= daysInMonth; d++) {
//       result.add(DateTime(year, month, d));
//     }
//
//     // append following month's head to fill last week
//     while (result.length % 7 != 0) {
//       final last = result.isNotEmpty ? result.last : first;
//       result.add(last.add(const Duration(days: 1)));
//     }
//
//     return result;
//   }
//
//   // ----------------------------
//   // Show Glass Calendar + Time Dialog
//   // ----------------------------
//   Future<DateTime?> _showGlassCalendarTimeDialog({
//     required BuildContext context,
//     required DateTime initialDate,
//     required DateTime minDate,
//     required DateTime maxDate,
//     required bool onlyDate,
//   }) async {
//     DateTime selectedDate = initialDate;
//     int selectedHour = initialDate.hour % 12 == 0 ? 12 : initialDate.hour % 12;
//     int selectedMinute = initialDate.minute;
//     bool isAm = initialDate.hour < 12;
//
//     return await showGeneralDialog<DateTime?>(
//         context: context,
//         barrierDismissible: true,
//         barrierLabel: 'glass_calendar_time',
//         transitionDuration: const Duration(milliseconds: 260),
//         pageBuilder: (_, __, ___) => const SizedBox.shrink(),
//         transitionBuilder: (context, anim, secAnim, child) {
//           return FadeTransition(
//             opacity: CurvedAnimation(parent: anim, curve: Curves.easeOut),
//             child: ScaleTransition(
//               scale: Tween<double>(begin: 0.96, end: 1.0)
//                   .animate(
//                   CurvedAnimation(parent: anim, curve: Curves.easeOutBack)),
//               child: Center(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                   child: StatefulBuilder(
//                     builder: (context, setState) {
//                       // Clamp selectedDate within min/max
//                       if (selectedDate.isBefore(minDate))
//                         selectedDate = minDate;
//                       if (selectedDate.isAfter(maxDate)) selectedDate = maxDate;
//
//                       final year = selectedDate.year;
//                       final month = selectedDate.month;
//                       final days = _generateMonthDays(year, month);
//
//                       final monthLabel = DateFormat.yMMMM().format(
//                           DateTime(year, month));
//
//                       Widget _dayCell(DateTime d) {
//                         final isFromPrevOrNextMonth = d.month != month;
//                         final disabled = d.isBefore(minDate) || d.isAfter(
//                             maxDate);
//                         final isSelected = d.year == selectedDate.year &&
//                             d.month == selectedDate.month &&
//                             d.day == selectedDate.day;
//
//                         Color bgColor;
//                         Color textColor;
//
//                         if (isSelected) {
//                           bgColor = Colors.transparent.withOpacity(0.95);
//                           textColor = Colors.white;
//                         } else if (isFromPrevOrNextMonth) {
//                           bgColor = Colors.transparent;
//                           textColor = Colors.white.withOpacity(0.35);
//                         } else {
//                           bgColor = Colors.transparent;
//                           textColor =
//                           disabled ? Colors.white.withOpacity(0.25) : Colors
//                               .white.withOpacity(0.95);
//                         }
//
//                         return GestureDetector(
//                           onTap: disabled
//                               ? null
//                               : () {
//                             setState(() {
//                               selectedDate = DateTime(
//                                   d.year, d.month, d.day, selectedDate.hour,
//                                   selectedDate.minute);
//                             });
//                           },
//                           child: Container(
//                             margin: const EdgeInsets.all(6),
//                             decoration: BoxDecoration(
//                               color: bgColor,
//                               shape: BoxShape.circle,
//                             ),
//                             alignment: Alignment.center,
//                             child: Text(
//                               '${d.day}',
//                               style: TextStyle(
//                                 color: textColor,
//                                 fontWeight: isSelected
//                                     ? FontWeight.w700
//                                     : FontWeight.w500,
//                                 fontSize: 19,
//                               ),
//                             ),
//                           ),
//                         );
//                       }
//
//                       // Time wheels (hours/minutes/am-pm)
//                       Widget _timeWheels() {
//                         return SizedBox(
//                           height: 120,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               // Hour wheel
//                               Expanded(
//                                 child: CupertinoPicker(
//                                   scrollController: FixedExtentScrollController(
//                                       initialItem: selectedHour - 1),
//                                   itemExtent: 32,
//                                   onSelectedItemChanged: (i) {
//                                     setState(() {
//                                       selectedHour = i + 1;
//                                     });
//                                   },
//                                   children: List.generate(12, (i) {
//                                     final h = i + 1;
//                                     return Center(child: Text(
//                                         h.toString().padLeft(2, '0')));
//                                   }),
//                                 ),
//                               ),
//                               // Separator
//                               SizedBox(
//                                 width: 8,
//                                 child: Center(child: Text(':', style: TextStyle(
//                                     color: Colors.white.withOpacity(0.85)))),
//                               ),
//                               // Minute wheel
//                               Expanded(
//                                 child: CupertinoPicker(
//                                   scrollController: FixedExtentScrollController(
//                                       initialItem: selectedMinute),
//                                   itemExtent: 32,
//                                   onSelectedItemChanged: (i) {
//                                     setState(() {
//                                       selectedMinute = i;
//                                     });
//                                   },
//                                   children: List.generate(60, (i) {
//                                     return Center(child: Text(
//                                         i.toString().padLeft(2, '0')));
//                                   }),
//                                 ),
//                               ),
//                               // AM/PM
//                               SizedBox(
//                                 width: 70,
//                                 child: CupertinoPicker(
//                                   scrollController: FixedExtentScrollController(
//                                       initialItem: isAm ? 0 : 1),
//                                   itemExtent: 32,
//                                   onSelectedItemChanged: (i) {
//                                     setState(() {
//                                       isAm = i == 0;
//                                     });
//                                   },
//                                   children: const [
//                                     Center(child: Text('AM')),
//                                     Center(child: Text('PM')),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       }
//
//                       return ClipRRect(
//                         borderRadius: BorderRadius.circular(18),
//                         child: BackdropFilter(
//                           filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//                           child: Container(
//                             width: double.infinity,
//                             constraints: const BoxConstraints(maxWidth: 520),
//                             decoration: BoxDecoration(
//                               color: Colors.white.withOpacity(0.06),
//                               borderRadius: BorderRadius.circular(18),
//                               border: Border.all(
//                                 // Neon outline
//                                 color: Colors.white.withOpacity(0.28),
//                                 width: 1.4,
//                               ),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: AppColors.newColor3.withOpacity(0.15),
//                                   blurRadius: 24,
//                                   offset: const Offset(0, 12),
//                                 )
//                               ],
//                             ),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 // Header: Month + Controls
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 12, vertical: 10),
//                                   child: Row(
//                                     children: [
//                                       IconButton(
//                                         onPressed: () {
//                                           // prev month
//                                           setState(() {
//                                             final prev = DateTime(
//                                                 selectedDate.year,
//                                                 selectedDate.month - 1, 1);
//                                             selectedDate = DateTime(
//                                                 prev.year, prev.month,
//                                                 selectedDate.day).isBefore(
//                                                 minDate)
//                                                 ? DateTime(
//                                                 minDate.year, minDate.month,
//                                                 minDate.day)
//                                                 : DateTime(
//                                                 prev.year, prev.month,
//                                                 selectedDate.day);
//                                           });
//                                         },
//                                         icon: Icon(Icons.chevron_left,
//                                             color: Colors.white.withOpacity(
//                                                 0.9)),
//                                       ),
//                                       Expanded(
//                                         child: Center(
//                                           child: Text(
//                                             monthLabel,
//                                             style: TextStyle(
//                                               color: Colors.white.withOpacity(
//                                                   0.95),
//                                               fontWeight: FontWeight.w600,
//                                               fontSize: 15,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       IconButton(
//                                         onPressed: () {
//                                           // next month
//                                           setState(() {
//                                             final next = DateTime(
//                                                 selectedDate.year,
//                                                 selectedDate.month + 1, 1);
//                                             selectedDate = DateTime(
//                                                 next.year, next.month,
//                                                 selectedDate.day).isAfter(
//                                                 maxDate)
//                                                 ? DateTime(
//                                                 maxDate.year, maxDate.month,
//                                                 maxDate.day)
//                                                 : DateTime(
//                                                 next.year, next.month,
//                                                 selectedDate.day);
//                                           });
//                                         },
//                                         icon: Icon(Icons.chevron_right,
//                                             color: Colors.white.withOpacity(
//                                                 0.9)),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//
//                                 // Weekday labels
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 8.0, vertical: 4),
//                                   child: Row(
//                                     children: List.generate(7, (i) {
//                                       const labels = [
//                                         'Sun',
//                                         'Mon',
//                                         'Tue',
//                                         'Wed',
//                                         'Thu',
//                                         'Fri',
//                                         'Sat'
//                                       ];
//                                       return Expanded(
//                                         child: Center(
//                                           child: Text(
//                                             labels[i],
//                                             style: TextStyle(
//                                                 color: Colors.white.withOpacity(
//                                                     0.55), fontSize: 12),
//                                           ),
//                                         ),
//                                       );
//                                     }),
//                                   ),
//                                 ),
//
//                                 // Calendar grid
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 6.0, vertical: 8),
//                                   child: SizedBox(
//                                     height: 280,
//                                     child: GridView.builder(
//                                       physics: const NeverScrollableScrollPhysics(),
//                                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                                         crossAxisCount: 7,
//                                         childAspectRatio: 1.0,
//                                       ),
//                                       itemCount: days.length,
//                                       itemBuilder: (context, idx) {
//                                         final d = days[idx];
//                                         return _dayCell(d);
//                                       },
//                                     ),
//                                   ),
//                                 ),
//
//                                 // Time wheels when required
//                                 if (!onlyDate)
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 12.0, vertical: 6),
//                                     child: Column(
//                                       children: [
//                                         Divider(color: Colors.white.withOpacity(
//                                             0.06)),
//                                         _timeWheels(),
//                                       ],
//                                     ),
//                                   ),
//
//                                 // Buttons row
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 12.0, vertical: 10),
//                                   child: Row(
//                                     children: [
//                                       Expanded(
//                                         child: OutlinedButton(
//                                           style: OutlinedButton.styleFrom(
//                                             side: BorderSide(
//                                                 color: Colors.white.withOpacity(
//                                                     0.06)),
//                                             backgroundColor: Colors.transparent,
//                                             foregroundColor: Colors.white,
//                                           ),
//                                           onPressed: () {
//                                             Navigator.of(context).pop(
//                                                 null); // cancel
//                                           },
//                                           child: Text('Cancel',
//                                               style: TextStyle(
//                                                   color: Colors.white
//                                                       .withOpacity(0.9))),
//                                         ),
//                                       ),
//                                       const SizedBox(width: 12),
//                                       Expanded(
//                                         child: ElevatedButton(
//                                           style: ElevatedButton.styleFrom(
//                                             backgroundColor: AppColors.newColor,
//                                             shape: RoundedRectangleBorder(
//                                                 borderRadius: BorderRadius
//                                                     .circular(8)),
//                                           ),
//                                           onPressed: () {
//                                             // Compose final DateTime
//                                             int hour24 = isAm ? (selectedHour %
//                                                 12) : ((selectedHour % 12) +
//                                                 12);
//                                             DateTime finalDate = DateTime(
//                                                 selectedDate.year,
//                                                 selectedDate.month,
//                                                 selectedDate.day,
//                                                 onlyDate ? 0 : hour24,
//                                                 onlyDate ? 0 : selectedMinute);
//                                             // clamp
//                                             if (finalDate.isBefore(minDate))
//                                               finalDate = minDate;
//                                             if (finalDate.isAfter(maxDate))
//                                               finalDate = maxDate;
//                                             Navigator.of(context).pop(
//                                                 finalDate);
//                                           },
//                                           child: const Padding(
//                                             padding: EdgeInsets.symmetric(
//                                                 vertical: 12.0),
//                                             child: Text('OK', style: TextStyle(
//                                                 fontWeight: FontWeight.w700)),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           );
//         } );
//         }
//
//         Future<String> datePickerDialog({
//     required TextEditingController textController,
//     required Function(String) onChange,
//     required BuildContext context,
//     bool showPastDate = true,
//     bool showFutureDate = true,
//     bool onlyDate = false,
//     String? startDate,
//     String? fromDate, // for giving date range
//     String? toDate, // for giving date range
//     bool? notFlagDate = true, // for giving date range
//     }) async {
//       DateTime? pickedDate;
//
//       DateTime currentTime = DateTime.now();
//
//       DateTime minTime = showPastDate ? DateTime(1900) : currentTime;
//       DateTime maxTime = showFutureDate ? DateTime(2101) : currentTime;
//
//       if (!startDate.isEmptyOrNull) {
//         if (startDate!.contains('-')) {
//           // it is formatted date
//           try {
//             minTime = DateTime.parse(startDate);
//           } catch (e) {
//             log('startDate parse error: $e');
//           }
//         } else {
//           int millisecondsSinceEpoch = startDate.toIntOrNull() ?? 0;
//           if (millisecondsSinceEpoch > 0) {
//             minTime = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch * 1000);
//             minTime = minTime.isBefore(currentTime) ? currentTime : minTime;
//           }
//         }
//       }
//
//       log('--fromDate----$fromDate----toDate----$toDate');
//
//       // Determine initial date based on controller or current
//       DateTime initialPickerDate = currentTime;
//       if (textController.text.isNotEmpty) {
//         DateTime? parsed;
//         parsed = DateTime.tryParse(textController.text);
//         if (parsed == null) {
//           try {
//             parsed = DateFormat(Constants.fulldateFormat).parseLoose(textController.text);
//           } catch (_) {
//             try {
//               parsed = DateFormat(Constants.dateFormat).parseLoose(textController.text);
//             } catch (_) {
//               parsed = null;
//             }
//           }
//         }
//         if (parsed != null) initialPickerDate = parsed;
//       }
//
//       // Handle from-to range
//       if (!fromDate.isEmptyOrNull && !toDate.isEmptyOrNull) {
//         DateTime from = DateTime.parse(fromDate!);
//         DateTime to = DateTime.parse(toDate!);
//         // clamp initial
//         if (initialPickerDate.isBefore(from)) initialPickerDate = from;
//         if (initialPickerDate.isAfter(to)) initialPickerDate = to;
//
//         pickedDate = await _showGlassCalendarTimeDialog(
//           context: context,
//           initialDate: initialPickerDate,
//           minDate: from,
//           maxDate: to,
//           onlyDate: onlyDate,
//         );
//       } else {
//         pickedDate = await _showGlassCalendarTimeDialog(
//           context: context,
//           initialDate: initialPickerDate,
//           minDate: minTime,
//           maxDate: maxTime,
//           onlyDate: onlyDate,
//         );
//       }
//
//       log('--before--pickedDate != null-----');
//
//       if (pickedDate != null) {
//         log('--pickedDate != null-----');
//
//         String dateTime = setDateTime(pickedDate, onlyDate, textController, onChange);
//         log('--@@@---pickedDate != null-dateTime---$dateTime------');
//         return dateTime;
//       } else {
//         log('--pickedDate != null---else--');
//         // Handle the case where the user cancels the picker
//         return ''; // unchanged behavior
//       }
//     }
//
//     void showTimePicker({
//       required BuildContext context,
//       required DateTime pickedDate,
//       required bool onlyDate,
//       required TextEditingController textController,
//       onChange,
//     }) {
//       // Keep original fallback time picker intact
//       DatePicker.showTimePicker(
//         context,
//         currentTime: pickedDate,
//         showTitleActions: true,
//         onChanged: (time) {
//           log('--onChanged-showTimePicker--$time-');
//         },
//         onConfirm: (time) {
//           log('--time--${time.toString()}--');
//           String dateTime = setDateTime(time, onlyDate, textController, onChange);
//           log('-11111-dateTime--$dateTime-');
//           return dateTime;
//         },
//       );
//     }
//
//     String setDateTime(
//         DateTime? pickedDate,
//         bool onlyDate,
//         TextEditingController textController,
//         Function(String) onChange,
//         ) {
//       log('--pickedDate-sss-$pickedDate--');
//       String formattedDate = DateFormat(
//         onlyDate ? Constants.dateFormat : Constants.fulldateFormat,
//       ).format(pickedDate!);
//
//       textController.text = formattedDate;
//       log('--textController.text-sss-${textController.text}--');
//
//       onChange(formattedDate);
//       log('--formattedDate-sss-$formattedDate--');
//       return formattedDate;
//     }
//   }
