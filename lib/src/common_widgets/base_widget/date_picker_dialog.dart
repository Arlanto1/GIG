import 'dart:developer';

import 'package:db_atom/index.dart';
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
    String? startDate,
    String? fromDate, // for giving date range
    String? toDate, // for giving date range
    required Function(String) onChange,
    required BuildContext context,
  }) {
    log('--datePickerWidgetLoading---');
    // Convert Date Time if String
    if (Utils().isTimestamp(textController.text)) {
      textController.text = Utils.timestampToDateConversion(
          int.tryParse(textController.text),
          onlyDate ? Constants.dateFormat : Constants.fulldateFormat);
    }

    return GestureDetector(
      onTap: () async {
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
              toDate: toDate);
        }
      },
      child: AbsorbPointer(
        absorbing: true,
        child: FlutterInputField(
          controller: textController,
          textFormKey: textController == textController
              ? Keys.founddateTextController
              : Keys.handedoverdateTextController,
          hintText: '',
          suffixIcon: Icons.calendar_month,
          isEnable: true,
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
                  AppColors.textgreyThemecolor,
                  BlendMode.srcIn,
                ),
                width: 20,
                key: const Key(Keys.userIcon),
              ),
            ),
          ),
        ),
      ),
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
  }) async {
    DateTime? pickedDate;

    DateTime currentTime = DateTime.now();

    DateTime minTime = showPastDate ? DateTime(1900) : currentTime;
    DateTime maxTime = showFutureDate ? DateTime(2101) : currentTime;
    log('-startDate---$startDate-');
    log('--minTime-1-$minTime--');

    if (!startDate.isEmptyOrNull) {
      log('-startDate-@@-${startDate.toString()}-is not empty-');
      if (startDate!.contains('-')) {
        minTime = DateTime.parse(startDate);
      } else {
        // Parse the startDate as an int and convert it to milliseconds
        int millisecondsSinceEpoch = startDate.toIntOrNull() ?? 0;
        log('-millisecondsSinceEpoch---${millisecondsSinceEpoch.toString()}-');

        // Check if the parsed value is valid
        if (millisecondsSinceEpoch > 0) {
          // Convert milliseconds since epoch to DateTime
          minTime = DateTime.fromMillisecondsSinceEpoch(
              millisecondsSinceEpoch * 1000);
          log('-minTime---${minTime.toString()}-');

          log('-startDate---currentTime--${currentTime.toString()}-----minTime${minTime.toString()}');

          // Ensure minTime is not before the current time
          minTime = minTime.isBefore(currentTime) ? currentTime : minTime;
        }
      }
    }

    log('-onlyDate---$onlyDate-');
    if (onlyDate && !fromDate.isEmptyOrNull && !toDate.isEmptyOrNull) {
      DatePicker.showDatePicker(
        context,
        showTitleActions: true,
        minTime: DateTime.parse(fromDate!),
        maxTime: DateTime.parse(toDate!),
        onChanged: (date) {
          pickedDate = date;
          log('change $date');
        },
        onConfirm: (date) {
          pickedDate = date;
          log('confirm $date');
          if (pickedDate != null) {
            return setDateTime(pickedDate!, onlyDate, textController, onChange);
          }
        },
        currentTime: currentTime,
        locale: LocaleType.en,
      );
    } else if (onlyDate) {
      DatePicker.showDatePicker(
        context,
        showTitleActions: true,
        minTime: minTime,
        maxTime: maxTime,
        onChanged: (date) {
          pickedDate = date;
          log('change $date');
        },
        onConfirm: (date) {
          pickedDate = date;
          log('confirm $date');
          if (pickedDate != null) {
            return setDateTime(pickedDate!, onlyDate, textController, onChange);
          }
        },
        currentTime: currentTime,
        locale: LocaleType.en,
      );
    } else {
      log('--else@@@@@@--');
      // Ensure minTime is set to the current time if showPastDate is false
      // minTime = minTime.isBefore(currentTime) ? currentTime : minTime;

      log('--minTime--else-$minTime--');
      log('--maxTime--else-$maxTime--');
      // Problem: minTime is not working properly for showDateTimePicker
      // it showing past date also when given startDate
      // I want to show minTime as some date in future based on startDate parameter
      // showDatePicker is working fine with same logic
      // Using package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart

      DatePicker.showDatePicker(
        context,
        showTitleActions: true,
        minTime: minTime,
        maxTime: maxTime,
        onChanged: (date) {
          pickedDate = date;
          log('change $date');
        },
        onConfirm: (date) {
          pickedDate = date;
          log('confirm $date');
          if (pickedDate != null) {
            showTimePicker(
                context, pickedDate!, onlyDate, textController, onChange);
            return setDateTime(pickedDate!, onlyDate, textController, onChange);
          }
        },
        currentTime: currentTime,
        locale: LocaleType.en,
      );

      // DatePicker.showDateTimePicker(
      //   context,
      //   showTitleActions: true,
      //   minTime: minTime,
      //   maxTime: maxTime,
      //   onChanged: (date) {
      //     pickedDate = date;
      //     log('change $date');
      //   },
      //   onConfirm: (date) {
      //     pickedDate = date;
      //     log('--pickedDate--confirm---$pickedDate--');
      //
      //     if (pickedDate != null) {
      //       return setDateTime(pickedDate!, onlyDate, textController, onChange);
      //     }
      //   },
      //   currentTime: currentTime,
      //   locale: LocaleType.en,
      // );
    }

    if (pickedDate != null) {
      return setDateTime(pickedDate!, onlyDate, textController, onChange);
    } else {
      // Handle the case where the user cancels the picker
      return ''; // You can modify the return value accordingly
    }
  }

  void showTimePicker(BuildContext context, DateTime pickedDate, onlyDate,
      textController, onChange) {
    DatePicker.showTimePicker(
      context,
      currentTime: pickedDate,
      showSecondsColumn: false,
      showTitleActions: true,
      onChanged: (time) {},
      onConfirm: (time) {
        log('--time--${time.toString()}--');
        // pickedDate.add(duration)

        setDateTime(time, onlyDate, textController, onChange);
      },
    );
  }

  String setDateTime(DateTime? pickedDate, bool onlyDate,
      TextEditingController textController, Function(String) onChange) {
    log('--pickedDate-sss-$pickedDate--');
    String formattedDate = DateFormat(
      onlyDate ? Constants.dateFormat : Constants.fulldateFormat,
    ).format(pickedDate!);

    textController.text = formattedDate;
    onChange(formattedDate);
    log('--formattedDate-sss-$formattedDate--');
    return formattedDate;
  }
}
