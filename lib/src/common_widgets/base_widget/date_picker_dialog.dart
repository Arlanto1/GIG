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

  bool isTimestamp(String str) {
    try {
      DateTime.parse(str);
      return true;
    } catch (e) {
      return false;
    }
  }

  Widget datePickerWidgetLoading({
    required TextEditingController textController,
    bool isDisabled = false,
    bool showPastDate = true,
    bool showFutureDate = true,
    bool onlyDate = false,
    required Function(String) onChange,
    required BuildContext context,
  }) {

    log('-textController.text)---${textController.text}--');
    log('-isTimestamp(textController.text)---${isTimestamp(textController.text)}--');

    // Convert Date Time if String
    if (isTimestamp(textController.text)) {
      textController.text = Utils.timestamptoDateConversion(int.tryParse(textController.text),
          onlyDate ? Constants.dateFormat : Constants.fulldateFormat);
    }

    return GestureDetector(
      onTap: () async {
        if (!isDisabled) {
          textController.text = await BaseDate().datePickerDialog(
            textController: textController,
            showPastDate: showPastDate,
            showFutureDate: showFutureDate,
            onChange: onChange,
            context: context,
            onlyDate: onlyDate,
          );
          log('--textController.text-2--1--${textController.text}----');
        }
      },
      child: FlutterInputField(
        textFieldController: textController,
        textFormKey: textController == textController
            ? Keys.founddateTextController
            : Keys.handedoverdateTextController,
        hintText: '',
        suffixIcon: Icons.calendar_month,
        isEnable: false,
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
    );
  }

  Future<String> datePickerDialog({
    required TextEditingController textController,
    required Function(String) onChange,
    required BuildContext context,
    bool showPastDate = true,
    bool showFutureDate = true,
    bool onlyDate = false,
  }) async {
    DateTime? pickedDate;

    // log('--textController.text---${textController.text}--');
    DateTime initialTime = DateTime.now();
    // initialTime = textController.text.isNotEmpty
    //     ? DateTime.parse(Utils().formatTime( textController.text))
    //     : DateTime.now();

    // initialTime = DateTime(2024,2,2,15,42);

    // log('--initialTime---${initialTime.toString()}--');

    if (onlyDate) {
      DatePicker.showDatePicker(
        context,
        showTitleActions: true,
        minTime: showPastDate ? DateTime(1900) : DateTime.now(),
        maxTime: showFutureDate ? DateTime(2101) : DateTime.now(),
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
        currentTime: initialTime,
        locale: LocaleType.en,
      );
    } else {
      DatePicker.showDateTimePicker(
        context,
        showTitleActions: true,
        minTime: showPastDate ? DateTime(1900) : DateTime.now(),
        maxTime: showFutureDate ? DateTime(2101) : DateTime.now(),
        onChanged: (date) {
          pickedDate = date;
          log('change $date');
        },
        onConfirm: (date) {
          pickedDate = date;
          log('confirm $date');
          log('--pickedDate--confirm---$pickedDate--');

          if (pickedDate != null) {
            return setDateTime(pickedDate!, onlyDate, textController, onChange);
          }
        },
        currentTime: initialTime,
        locale: LocaleType.en,
      );
    }

    if (pickedDate != null) {
      return setDateTime(pickedDate!, onlyDate, textController, onChange);
    } else {
      // Handle the case where the user cancels the picker
      return ''; // You can modify the return value accordingly
    }
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

// String formatTime(String dateTimeString) {
//   // if the dateTimeString is already a Unix timestamp
//   if (dateTimeString.length == 10 &&
//       dateTimeString.contains(RegExp(r'^\d+$'))) {
//     return dateTimeString;
//   }
//
//   try {
//     final dateTime =
//         DateFormat('MM/dd/yyyy a hh:mm:ss').parse(dateTimeString);
//     final unixTimestamp = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
//     return unixTimestamp.toString();
//   } catch (_) {
//     // If the format does not match, handle the error or return a default value
//     throw FormatException('Unable to parse date-time: $dateTimeString');
//   }
// }
}
