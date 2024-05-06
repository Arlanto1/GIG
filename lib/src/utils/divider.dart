import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:flutter/material.dart';

class Dividers {
  static verticalDivider() {
    return const VerticalDivider(
      color: AppColors.divideLineGreyColor,
      //color of divider
      width: 10,
      //width space of divider
      thickness: 3,
      //thickness of divier line
      indent: 10,
      //Spacing at the top of divider.
      endIndent: 10, //Spacing at the bottom of divider.
    );
  }

  static horizentalDivider() {
    return const Divider(
      color: AppColors.divideLineGreyColor,
      //color of divider
      height: 5,
      //height spacing of divider
      thickness: 1,
      //thickness of divier line
      indent: 25,
      //spacing at the start of divider
      endIndent: 25, //spacing at the end of divider
    );
  }
}
