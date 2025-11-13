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
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                  width: 25,
                  key: const Key(Keys.userIcon),
                ),
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
    bool? notFlagDate = true, // for giving date range
  }) async {
    DateTime? pickedDate;

    DateTime currentTime = DateTime.now();

    DateTime minTime = showPastDate ? DateTime(1900) : currentTime;
    DateTime maxTime = showFutureDate ? DateTime(2101) : currentTime;

    if (!startDate.isEmptyOrNull) {
      if (startDate!.contains('-')) {
        // it is formated date
        minTime = DateTime.parse(startDate);
      } else {
        // it is a timestamp
        // Parse the startDate as an int and convert it to milliseconds
        int millisecondsSinceEpoch = startDate.toIntOrNull() ?? 0;

        // Check if the parsed value is valid
        if (millisecondsSinceEpoch > 0) {
          // Convert milliseconds since epoch to DateTime
          minTime = DateTime.fromMillisecondsSinceEpoch(
              millisecondsSinceEpoch * 1000);

          // Ensure minTime is not before the current time
          minTime = minTime.isBefore(currentTime) ? currentTime : minTime;
        }
      }
    }

    log('--fromDate----$fromDate----toDate----$toDate');

    if (!fromDate.isEmptyOrNull && !toDate.isEmptyOrNull) {
      log('--if (!fromDate.isEmptyOrNull && !toDate.isEmptyOrNull)--');
      DatePicker.showDatePicker(
        context,
        showTitleActions: true,
        minTime: DateTime.parse(fromDate!),
        maxTime: DateTime.parse(toDate!),
        onChanged: (date) {
          FocusManager.instance.primaryFocus?.unfocus();
          pickedDate = date;
          log('change $date');
        },
        onCancel: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onConfirm: (date) {
          pickedDate = date;
          log('confirm $date');
          if (pickedDate != null) {
            if (!onlyDate) {
              showTimePicker(
                context: context,
                pickedDate: pickedDate!,
                onlyDate: onlyDate,
                textController: textController,
                onChange: onChange,
              );
            }
            String dateTime =
                setDateTime(pickedDate!, onlyDate, textController, onChange);
            log('--!!!!!----dateTime---$dateTime------');
            return dateTime;
            // return setDateTime(pickedDate!, onlyDate, textController, onChange);
          }
        },
        currentTime: currentTime,
        locale: LocaleType.en,
      );
    } else if (onlyDate) {
      log('--else if (onlyDate)--');
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
    } else if (!startDate.isEmptyOrNull || notFlagDate == true) {
      log('--else if (flagDate == true)--');
      DatePicker.showDatePicker(
        context,
        showTitleActions: true,
        minTime: minTime,
        maxTime: maxTime,
        onChanged: (date) {
          FocusManager.instance.primaryFocus?.unfocus();
          pickedDate = date;
          log('change $date');
        },
        onConfirm: (date) {
          // pickedDate = date;
          // log('confirm $date');
          // if (pickedDate != null) {
          //   return setDateTime(pickedDate!, onlyDate, textController, onChange);
          // }

          pickedDate = date;
          log('confirm $date');
          if (pickedDate != null) {
            if (!onlyDate) {
              showTimePicker(
                context: context,
                pickedDate: pickedDate!,
                onlyDate: onlyDate,
                textController: textController,
                onChange: onChange,
              );
            }
            String dateTime =
                setDateTime(pickedDate!, onlyDate, textController, onChange);
            log('--!!!!!----dateTime---$dateTime------');
            return dateTime;
            // return setDateTime(pickedDate!, onlyDate, textController, onChange);
          }
        },
        currentTime: currentTime,
        locale: LocaleType.en,
      );
    } else {
      log('--else@@@@@@--');

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
          log('pickedDate------ $date');
          if (pickedDate != null) {
            // showTimePicker(
            //   context: context,
            //   pickedDate: pickedDate!,
            //   onlyDate: onlyDate,
            //   textController: textController,
            //   onChange: onChange,
            // );
            String dateTime =
                setDateTime(pickedDate!, onlyDate, textController, onChange);
            log('--@@@----dateTime---$dateTime------');
            return dateTime;
          }
        },
        currentTime: currentTime,
        locale: LocaleType.en,
      );
    }
    log('--before--pickedDate != null-----');

    if (pickedDate != null) {
      log('--pickedDate != null-----');

      // return setDateTime(pickedDate!, onlyDate, textController, onChange);
      String dateTime =
          setDateTime(pickedDate!, onlyDate, textController, onChange);
      log('--@@@---pickedDate != null-dateTime---$dateTime------');
      return dateTime;
    } else {
      log('--pickedDate != null---else--');
      // Handle the case where the user cancels the picker
      return ''; // You can modify the return value accordingly
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
