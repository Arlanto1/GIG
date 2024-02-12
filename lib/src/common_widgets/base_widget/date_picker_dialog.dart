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
    // Convert Date Time if String
    if (isTimestamp(textController.text)) {
      textController.text = Utils.timestamptoDateConversion(
          int.tryParse(textController.text),
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

    DateTime currentTime = DateTime.now();

    log('-onlyDate---$onlyDate-');
    if (onlyDate) {
      DateTime minTime = showPastDate ? DateTime(1900) : currentTime;
      DateTime maxTime = showFutureDate ? DateTime(2101) : currentTime;
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
      // For DateTimePicker, adjust minTime and maxTime accordingly
      DateTime minTime = showPastDate ? DateTime(1900) : currentTime;
      DateTime maxTime = showFutureDate ? DateTime(2101) : currentTime;

      // Ensure minTime is set to the current time if showPastDate is false
      // minTime = minTime.isBefore(currentTime) ? currentTime : minTime;

      DatePicker.showDateTimePicker(
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
          log('--pickedDate--confirm---$pickedDate--');

          if (pickedDate != null) {
            return setDateTime(pickedDate!, onlyDate, textController, onChange);
          }
        },
        currentTime: currentTime,
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
}
