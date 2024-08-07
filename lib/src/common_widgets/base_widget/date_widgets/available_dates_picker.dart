import 'dart:developer';

import 'package:db_atom/index.dart';

class LimitedDatePicker extends StatefulWidget {
  final List<String> availableDates;      /// Format: ["2024-08-01", "2024-08-05"]
  final bool isDisabled;
  final Function(String) onChange;
  final TextEditingController textController;

  const LimitedDatePicker({
    super.key,
    required this.availableDates,
    required this.onChange,
    required this.textController,
    required this.isDisabled,
  });

  @override
  LimitedDatePickerState createState() => LimitedDatePickerState();
}

class LimitedDatePickerState extends State<LimitedDatePicker> {
  String? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Date"),
          content: DropdownButton<String>(
            hint: const Text("Select a date"),
            value: selectedDate,
            items: widget.availableDates.map((String date) {
              return DropdownMenuItem<String>(
                value: date,
                child: Text(date),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  widget.textController.text = newValue;
                  selectedDate = newValue;
                });
                widget.onChange(newValue);
              }
              Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Cancel",
                style: TextStyle(color: AppColors.navigationSkyBlueColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    log('-widget.textController--${widget.textController.text}-----');
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Opacity(
          opacity: widget.isDisabled ? .5 : 1,
          child: InkWell(
            onTap: () {
              if (widget.isDisabled) {
                return;
              }
              _selectDate(context);
            },
            child: AbsorbPointer(
              absorbing: true,
              child: FlutterInputField(
                controller: widget.textController,
                textFormKey: Keys.availableDateKey,
                hintText: '',
                suffixIcon: Icons.calendar_month,
                isEnable: true,
                isDisableColor: widget.isDisabled,
                onChange: widget.onChange,
                validateTextField: (String? user) {},
                suffixWidget: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SvgPicture.asset(
                    AppIcon.calendaricon,
                    colorFilter: const ColorFilter.mode(
                      AppColors.textGreyThemeColor,
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
      ],
    );
  }
}
