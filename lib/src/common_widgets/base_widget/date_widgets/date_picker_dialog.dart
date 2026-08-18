// import 'dart:developer';
// import 'dart:ui';
// import 'package:db_atom/index.dart';
// import 'package:flutter/cupertino.dart';
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
//             isEnable: !isDisabled,
//             isDisableColor: isDisabled,
//             onChange: onChange,
//             // Pass the onChange callback to FlutterInputField
//             validateTextField: (String? user) {},
//             suffixWidget: GestureDetector(
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: SvgPicture.asset(
//                   AppIcon.calendarIcon,
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
//   Future<DateTime?> showGlassWheelDatePicker({
//     required BuildContext context,
//     required DateTime initialDateTime,
//     required DateTime minDate,
//     required DateTime maxDate,
//     required bool onlyDate,
//   }) async {
//     // DateTime selected = initialDateTime;
//     DateTime clampedInitial = initialDateTime;
//     if (clampedInitial.isBefore(minDate)) clampedInitial = minDate;
//     if (clampedInitial.isAfter(maxDate)) clampedInitial = maxDate;
//
//     DateTime selected = clampedInitial;
//     return showModalBottomSheet<DateTime?>(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       barrierColor: Colors.transparent,
//       builder: (context) {
//         // Controllers for time wheels
//         int hour = selected.hour % 12 == 0 ? 12 : selected.hour % 12;
//         int minute = selected.minute;
//         bool isPM = selected.hour >= 12;
//
//         return Padding(
//           padding:
//               EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//           child: ClipRRect(
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
//             child: BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
//               child: Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//                 decoration:
//                 BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       Colors.white.withValues(alpha: 0.09),
//                       Colors.transparent,
//                       Colors.white.withValues(alpha: 0.09),
//                       // Color(0xFF6474C6).withOpacity(0.14)
//                     ],
//                     stops: const [0.02, 0.35, 1],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                   ),
//                   borderRadius: BorderRadius.circular(27),
//                   border: Border.all(
//                     color: Colors.white
//                         .withValues(alpha: 0.6),
//                     width: 0.7,
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.white
//                           .withValues(alpha: 0.0),
//                       blurRadius: 12,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     // HEADER
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         TextButton(
//                           onPressed: () => Navigator.pop(context, null),
//                           child: Text(
//                             "Cancel",
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.white.withValues(alpha: 0.85)),
//                           ),
//                         ),
//                         Text(
//                           onlyDate ? "Select Date" : "Select Date & Time",
//                           style: TextStyle(
//                             color: Colors.white.withValues(alpha: 0.95),
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         TextButton(
//                           onPressed: () => Navigator.pop(context, selected),
//                           child: Text(
//                             "Done",
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.white.withValues(alpha: 0.85)),
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     // const SizedBox(height: 1),
//
//                     ///       CALENDAR
//                     Theme(
//                       data: Theme.of(context).copyWith(
//                         colorScheme: const ColorScheme.dark(
//                           primary: Colors.white, // selected date
//                           onSurface: Colors.white, // active days
//                         ).copyWith(
//                           onSurface: Colors.white, // active days
//                         ),
//
//                         textTheme: TextTheme(
//                           bodyLarge: TextStyle(
//                               fontSize: 20,
//                               color: Colors.white.withValues(alpha: 0.95)),
//                           bodyMedium: TextStyle(
//                               fontSize: 10,
//                               color: Colors.white.withValues(alpha: 0.75)),
//                           titleMedium: TextStyle(
//                             fontSize: 10,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.white.withValues(alpha: 0.98),
//                           ),
//                         ),
//                       ),
//                       child: CalendarDatePicker(
//                         initialDate: clampedInitial,
//                         firstDate: minDate,
//                         lastDate: maxDate,
//                         onDateChanged: (d) {
//                           selected = DateTime(
//                             d.year,
//                             d.month,
//                             d.day,
//                             selected.hour,
//                             selected.minute,
//                           );
//                         },
//                       ),
//                     ),
//
//                     ///      TIME PICKER (if enabled)
//                     if (!onlyDate)
//                       Column(
//                         children: [
//                           // const SizedBox(height: 10),
//                           // ---- TITLE ----
//                           Text(
//                             "Select Time",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white.withValues(alpha: 0.95),
//                             ),
//                           ),
//
//                           const SizedBox(height: 10),
//                           SizedBox(
//                             height: 60,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 // HOUR WHEEL
//                                 Expanded(
//                                   child: CupertinoPicker(
//                                     itemExtent: 38,
//                                     scrollController:
//                                         FixedExtentScrollController(
//                                             initialItem: hour - 1),
//                                     onSelectedItemChanged: (value) {
//                                       hour = value + 1;
//                                       int newHour =
//                                           isPM ? (hour % 12) + 12 : hour % 12;
//                                       selected = DateTime(
//                                         selected.year,
//                                         selected.month,
//                                         selected.day,
//                                         newHour,
//                                         selected.minute,
//                                       );
//                                     },
//                                     children: List.generate(
//                                       12,
//                                       (i) => Center(
//                                         child: Text(
//                                           "${i + 1}".padLeft(2, '0'),
//                                           style: TextStyle(
//                                               fontSize: 20,
//                                               color: Colors.white
//                                                   .withValues(alpha: 0.95)),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//
//                                 // MINUTE WHEEL
//                                 Expanded(
//                                   child: CupertinoPicker(
//                                     itemExtent: 38,
//                                     scrollController:
//                                         FixedExtentScrollController(
//                                             initialItem: minute),
//                                     onSelectedItemChanged: (value) {
//                                       minute = value;
//                                       selected = DateTime(
//                                         selected.year,
//                                         selected.month,
//                                         selected.day,
//                                         selected.hour,
//                                         minute,
//                                       );
//                                     },
//                                     children: List.generate(
//                                       60,
//                                       (i) => Center(
//                                         child: Text(
//                                           i.toString().padLeft(2, '0'),
//                                           style: TextStyle(
//                                               fontSize: 20,
//                                               color: Colors.white
//                                                   .withValues(alpha: 0.95)),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//
//                                 // AM / PM
//                                 Expanded(
//                                   child: CupertinoPicker(
//                                     itemExtent: 38,
//                                     scrollController:
//                                         FixedExtentScrollController(
//                                             initialItem: isPM ? 1 : 0),
//                                     onSelectedItemChanged: (value) {
//                                       isPM = value == 1;
//                                       int h = hour % 12;
//                                       int newHour = isPM ? h + 12 : h;
//                                       selected = DateTime(
//                                         selected.year,
//                                         selected.month,
//                                         selected.day,
//                                         newHour,
//                                         selected.minute,
//                                       );
//                                     },
//                                     children: const [
//                                       Center(
//                                           child: Text("AM",
//                                               style: TextStyle(
//                                                   color: Colors.white))),
//                                       Center(
//                                           child: Text("PM",
//                                               style: TextStyle(
//                                                   color: Colors.white))),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Future<String> datePickerDialog({
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
//   }) async {
//     DateTime? pickedDate;
//
//     DateTime currentTime = DateTime.now();
//
//     DateTime minTime = showPastDate ? DateTime(1900) : currentTime;
//     DateTime maxTime = showFutureDate ? DateTime(2101) : currentTime;
//
//     // handle startDate being formatted date or timestamp
//     if (!startDate.isEmptyOrNull) {
//       if (startDate!.contains('-')) {
//         // it is formatted date
//         try {
//           minTime = DateTime.parse(startDate);
//         } catch (e) {
//           log('startDate parse error: $e');
//         }
//       } else {
//         int millisecondsSinceEpoch = startDate.toIntOrNull() ?? 0;
//         if (millisecondsSinceEpoch > 0) {
//           minTime = DateTime.fromMillisecondsSinceEpoch(
//               millisecondsSinceEpoch * 1000);
//           minTime = minTime.isBefore(currentTime) ? currentTime : minTime;
//         }
//       }
//     }
//
//     log('--fromDate----$fromDate----toDate----$toDate');
//
//     // Determine an initial date for the picker:
//     DateTime initialPickerDate = currentTime;
//
//     // If controller has a date string, try to parse it to set initial value
//     if (textController.text.isNotEmpty) {
//       DateTime? parsed;
//       // try ISO parse first
//       parsed = DateTime.tryParse(textController.text);
//       if (parsed == null) {
//         // try known formats
//         try {
//           parsed = DateFormat(Constants.fulldateFormat)
//               .parseLoose(textController.text);
//         } catch (_) {
//           try {
//             parsed = DateFormat(Constants.dateFormat)
//                 .parseLoose(textController.text);
//           } catch (_) {
//             parsed = null;
//           }
//         }
//       }
//       if (parsed != null) {
//         initialPickerDate = parsed;
//       }
//     }
//
// // also handle fromDate-only (no toDate) case
//     if (fromDate != null && fromDate.trim().isNotEmpty) {
//       DateTime? rangeMinDate;
//       try {
//         rangeMinDate = DateTime.parse(fromDate);
//       } catch (e) {
//         // try as timestamp
//         int? ts = int.tryParse(fromDate);
//         if (ts != null) {
//           rangeMinDate = DateTime.fromMillisecondsSinceEpoch(ts * 1000);
//         }
//         log('fromDate parse error: $e, value: $fromDate');
//       }
//
//       if (rangeMinDate != null) {
//         if (initialPickerDate.isBefore(rangeMinDate)) {
//           initialPickerDate = rangeMinDate;
//         }
//         minTime = rangeMinDate; //  This is the key line — sets minimum selectable date
//       }
//     }
//     // from-to range present
//     if (fromDate != null && fromDate.trim().isNotEmpty && !toDate.isEmptyOrNull) {
//       // from-to range present - WITH SAFE PARSING
//       DateTime? rangeMinDate, rangeMaxDate;
//       if (fromDate.trim().isNotEmpty) {
//         try {
//           rangeMinDate = DateTime.parse(fromDate);
//           log('End picker fromDate parsed: $rangeMinDate');
//         } catch (e) {
//           log('fromDate parse error: $e, value: $fromDate');
//         }
//       }
//       if (!toDate.isEmptyOrNull) {
//         try {
//           rangeMaxDate = DateTime.parse(toDate!);
//         } catch (e) {
//           log('toDate parse error: $e');
//         }
//       }
//
//       if (rangeMinDate != null) {
//         if (initialPickerDate.isBefore(rangeMinDate)) initialPickerDate = rangeMinDate;
//       }
//       if (rangeMaxDate != null && initialPickerDate.isAfter(rangeMaxDate)) {
//         initialPickerDate = rangeMaxDate;
//       }
//
//       pickedDate = await showGlassWheelDatePicker(
//         context: context,
//         initialDateTime: initialPickerDate,
//         minDate: rangeMinDate ?? minTime,
//         maxDate: rangeMaxDate ?? maxTime,
//         onlyDate: onlyDate,
//       );
//
//     }
//
//     else if (onlyDate) {
//       // only date (without time)
//       pickedDate = await showGlassWheelDatePicker(
//         context: context,
//         initialDateTime: initialPickerDate,
//         minDate: minTime,
//         maxDate: maxTime,
//         onlyDate: onlyDate,
//       );
//     } else if (!startDate.isEmptyOrNull || notFlagDate == true) {
//       // startDate set or flag true
//       pickedDate = await showGlassWheelDatePicker(
//         context: context,
//         initialDateTime: initialPickerDate,
//         minDate: minTime,
//         maxDate: maxTime,
//         onlyDate: onlyDate,
//       );
//     } else {
//       // fallback: date & time wheel
//       pickedDate = await showGlassWheelDatePicker(
//         context: context,
//         initialDateTime: initialPickerDate,
//         minDate: minTime,
//         maxDate: maxTime,
//         onlyDate: onlyDate,
//       );
//     }
//
//     log('--before--pickedDate != null-----');
//
//     if (pickedDate != null) {
//       log('--pickedDate != null-----');
//
//       String dateTime =
//           setDateTime(pickedDate, onlyDate, textController, onChange);
//       log('--@@@---pickedDate != null-dateTime---$dateTime------');
//       return dateTime;
//     } else {
//       log('--pickedDate != null---else--');
//       // Handle the case where the user cancels the picker
//       return ''; // unchanged behavior
//     }
//   }
//
//   void showTimePicker({
//     required BuildContext context,
//     required DateTime pickedDate,
//     required bool onlyDate,
//     required TextEditingController textController,
//     onChange,
//   }) {
//     DatePicker.showTimePicker(
//       context,
//       currentTime: pickedDate,
//       // showSecondsColumn: false,
//       showTitleActions: true,
//       onChanged: (time) {
//         log('--onChanged-showTimePicker--$time-');
//       },
//       onConfirm: (time) {
//         log('--time--${time.toString()}--');
//
//         String dateTime = setDateTime(time, onlyDate, textController, onChange);
//         log('-11111-dateTime--$dateTime-');
//         return dateTime;
//       },
//     );
//   }
//
//   String setDateTime(
//     DateTime? pickedDate,
//     bool onlyDate,
//     TextEditingController textController,
//     Function(String) onChange,
//   ) {
//     log('--pickedDate-sss-$pickedDate--');
//     String formattedDate = DateFormat(
//       onlyDate ? Constants.dateFormat : Constants.fulldateFormat,
//     ).format(pickedDate!);
//
//     textController.text = formattedDate;
//     log('--textController.text-sss-${textController.text}--');
//
//     onChange(formattedDate);
//     log('--formattedDate-sss-$formattedDate--');
//     return formattedDate;
//   }
// }

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

  /// Strips the time component so date-only comparisons match what
  /// CalendarDatePicker's assertion actually checks (it compares dates,
  /// not full DateTimes).
  DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

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
                  AppIcon.calendarIcon,
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

  Future<DateTime?> showGlassWheelDatePicker({
    required BuildContext context,
    required DateTime initialDateTime,
    required DateTime minDate,
    required DateTime maxDate,
    required bool onlyDate,
  }) async {
    // ── SAFETY NET ──────────────────────────────────────────────────────
    // CalendarDatePicker throws a hard assertion if lastDate is before
    // firstDate. Upstream callers (or bad/stale data from the API, e.g. an
    // endDate earlier than startDate) can hand us a maxDate that's before
    // minDate. Rather than trust every caller to have already validated
    // this, clamp it here so the picker can never crash — worst case the
    // user just gets a 1-day selectable window instead of a crash.
    DateTime effectiveMinDate = minDate;
    DateTime effectiveMaxDate = maxDate;
    if (_dateOnly(effectiveMaxDate).isBefore(_dateOnly(effectiveMinDate))) {
      log('WARNING: maxDate ($maxDate) is before minDate ($minDate) — clamping maxDate');
      effectiveMaxDate = effectiveMinDate.add(const Duration(days: 1));
    }

    // DateTime selected = initialDateTime;
    DateTime clampedInitial = initialDateTime;
    if (clampedInitial.isBefore(effectiveMinDate)) clampedInitial = effectiveMinDate;
    if (clampedInitial.isAfter(effectiveMaxDate)) clampedInitial = effectiveMaxDate;

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
                    stops: const [0.02, 0.35, 1],
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
                        firstDate: effectiveMinDate,
                        lastDate: effectiveMaxDate,
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

// also handle fromDate-only (no toDate) case
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
        minTime = rangeMinDate; //  This is the key line — sets minimum selectable date
      }
    }
    // from-to range present
    if (fromDate != null && fromDate.trim().isNotEmpty && !toDate.isEmptyOrNull) {
      // from-to range present - WITH SAFE PARSING
      DateTime? rangeMinDate, rangeMaxDate;
      if (fromDate.trim().isNotEmpty) {
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

      // ── GUARD ──────────────────────────────────────────────────────
      // The API can return an endDate earlier than startDate (bad/stale
      // data). If we pass that straight through, CalendarDatePicker's
      // firstDate/lastDate assertion crashes the whole screen. Clamp
      // rangeMaxDate so it's never before rangeMinDate.
      if (rangeMinDate != null &&
          rangeMaxDate != null &&
          _dateOnly(rangeMaxDate).isBefore(_dateOnly(rangeMinDate))) {
        log('WARNING: toDate ($rangeMaxDate) is before fromDate ($rangeMinDate) — clamping toDate');
        rangeMaxDate = rangeMinDate.add(const Duration(days: 1));
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