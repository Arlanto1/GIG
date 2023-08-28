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
  Widget datePickerWidgetLoading({
    required TextEditingController textController,
    bool isDisabled = false,
    required Function(String) onChange,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () {
        if (!isDisabled) {
          BaseDate().datePickerDialog(
            textController: textController,
            onChange: onChange,
            context: context,
          );
        }
      },
      child: FlutterInputField(
        textFieldController: textController,
        textFormKey: textController == textController
            ? Keys.founddateTextController
            : Keys.handedoverdateTextController,
        hintText: '',
        isEnable: !isDisabled,
        isDisableColor: isDisabled,
        onChange: onChange,
        // Pass the onChange callback to FlutterInputField
        validateTextField: (String? user) {},
        suffixWidget: GestureDetector(
          onTap: () async {
            if (textController.text.isEmpty) {
              textController.text = await BaseDate().datePickerDialog(
                textController: textController,
                onChange: onChange,
                context: context,
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SvgPicture.asset(
              AppIcon.calendaricon,
              color: AppColors.textgreyThemecolor,
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
  }) async {
    DateTime? pickedDate = await showDateTimePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    String formattedDate = DateFormat(Constants.fulldateFormat)
        .format(pickedDate ?? DateTime.now());

    textController.text = formattedDate;
    onChange(formattedDate);
    return formattedDate;
  }
}
