import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:flutter/material.dart';

class RadioButtonsYesNo extends StatelessWidget {
  const RadioButtonsYesNo({
    super.key,
    required this.status,
    required this.selectedValue,
    required this.onChangedYes,
    required this.onChangedNo,
  });

  final int status;
  final int? selectedValue;
  final Function(int?)? onChangedYes;
  final Function(int?)? onChangedNo;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: status == 6||status == -1||status == 10
              ? AppColors.disabletextfieldBackground
              : AppColors.navigationSkybluecolor,
          focusColor: AppColors.navigationSkybluecolor,
          value: 1,
          groupValue: selectedValue,
          onChanged: onChangedYes,
        ),
        const Text(Constants.yes),
        Radio(
          activeColor: status == 6||status == -1||status == 10
              ? AppColors.disabletextfieldBackground
              : AppColors.navigationSkybluecolor,
          focusColor: AppColors.navigationSkybluecolor,
          value: 0,
          groupValue: selectedValue,
          onChanged: onChangedNo,
        ),
        const Text(Constants.no),
      ],
    );
  }
}
