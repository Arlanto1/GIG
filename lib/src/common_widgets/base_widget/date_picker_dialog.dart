import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../constants/app_icon.dart';
import '../../constants/constants.dart';
import '../../utils/app_themes/colors/app_color.dart';
import '../../utils/helpers/keys/keys.dart';
import '../date_time_picker.dart';
import '../new_search_textfield.dart';

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
    required Function(String) onChange,
    required BuildContext context,
  }) {
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
    if (onlyDate) {
      pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: showPastDate ? DateTime(1900) : DateTime.now(),
        lastDate: showFutureDate ? DateTime(2101) : DateTime.now(),
      );
    } else {
      pickedDate = await showDateTimePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: showPastDate ? DateTime(1900) : DateTime.now(),
        lastDate: showFutureDate ? DateTime(2101) : DateTime.now(),
      );
    }

    if (pickedDate != null) {
      String formattedDate = DateFormat(
        onlyDate ? Constants.dateFormat : Constants.fulldateFormat,
      ).format(pickedDate);

      textController.text = formattedDate;
      onChange(formattedDate);
      return formattedDate;
    } else {
      // Handle the case where the user cancels the picker
      return ''; // You can modify the return value accordingly
    }
  }
}
