import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:flutter/material.dart';

class Styles {
  static TextStyle styleHeaderGreyText16 = const TextStyle(
    fontSize: 16,
    fontFamily: Constants.customFontMediumFamily,
    fontWeight: FontWeight.w600,
    color: AppColors.textgreyThemecolor,
  );
  static TextStyle styleHeaderGreyText30 = const TextStyle(
    fontSize: 30,
    fontFamily: Constants.customFontSemiBoldFamily,
    fontWeight: FontWeight.w600,
    color: AppColors.textgreyThemecolor,
  );

  static const TextStyle textStyleBlack16 = TextStyle(
    fontSize: 16,
    fontFamily: Constants.customFontSemiBoldFamily,
    fontWeight: FontWeight.w600,
    color: AppColors.textgreyThemecolor,
  );
  static const TextStyle textStyleBlack14 = TextStyle(
    fontSize: 14,
    fontFamily: Constants.customFontSemiBoldFamily,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  static const TextStyle textStyleDarkGrey16 = TextStyle(
    fontSize: 15,
    fontFamily: Constants.customFontSemiBoldFamily,
    fontWeight: FontWeight.w600,
    color: AppColors.textgreyThemecolor,
  );

  static const TextStyle textStyleRegularGrey14 = TextStyle(
    fontSize: 14,
    fontFamily: Constants.customFontRegularFamily,
    fontWeight: FontWeight.w400,
    color: AppColors.textgreyThemecolor,
  );

  static const TextStyle textStyleRegularGrey13 = TextStyle(
    fontSize: 13,
    fontFamily: Constants.customFontRegularFamily,
    fontWeight: FontWeight.w400,
    color: AppColors.textgreyThemecolor,
  );

  static const TextStyle textStyleRegularGrey16 = TextStyle(
    fontSize: 16,
    fontFamily: Constants.customFontRegularFamily,
    fontWeight: FontWeight.w400,
    color: AppColors.textgreyThemecolor,
  );
  static const TextStyle textStyleBoldGreydark14 = TextStyle(
    fontSize: 14,
    fontFamily: Constants.customFontRegularFamily,
    fontWeight: FontWeight.w600,
    color: AppColors.boldgreyBackground,
  );

  static const TextStyle textStyleRegularNormalGrey14 = TextStyle(
    fontSize: 14,
    fontFamily: Constants.customFontRegularFamily,
    fontWeight: FontWeight.w200,
    color: AppColors.textgreyThemecolor,
  );

  static const TextStyle textStyleRegularNormalWhite18 = TextStyle(
    fontSize: 18,
    fontFamily: Constants.customFontRegularFamily,
    fontWeight: FontWeight.w200,
    color: AppColors.backgroundWhitecolor,
  );
  static const TextStyle textStyleRegularNormalWhite12 = TextStyle(
    fontSize: 12,
    fontFamily: Constants.customFontRegularFamily,
    fontWeight: FontWeight.w500,
    color: AppColors.backgroundWhitecolor,
  );
  static const TextStyle textStyleSemiBoldGrey14 = TextStyle(
    fontSize: 14,
    fontFamily: Constants.customFontRegularFamily,
    fontWeight: FontWeight.w400,
    color: AppColors.textgreyThemecolor,
  );
  static const TextStyle textStyleBoldGrey14 = TextStyle(
    fontSize: 14,
    fontFamily: Constants.customFontRegularFamily,
    fontWeight: FontWeight.w600,
    color: AppColors.textgreyThemecolor,
  );
  static const TextStyle textStyleSemiBoldheighGrey14 = TextStyle(
    fontSize: 14,
    fontFamily: Constants.customFontRegularFamily,
    fontWeight: FontWeight.w600,
    color: AppColors.textgreyThemecolor,
  );
  static const TextStyle textStyleSemiBold16Black = TextStyle(
    fontSize: 16,
    fontFamily: Constants.customFontSemiBoldFamily,
    fontWeight: FontWeight.w600,
    color: Colors.black54,
  );
  static const TextStyle textStyleSemiBold16White = TextStyle(
    fontSize: 16,
    fontFamily: Constants.customFontSemiBoldFamily,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle textStyleAppBar = const TextStyle(
    fontSize: 18,
    fontFamily: Constants.customFontMediumFamily,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static const TextStyle textStyleNavigator16 = TextStyle(
    fontSize: 16,
    fontFamily: Constants.customFontSemiBoldFamily,
    fontWeight: FontWeight.w600,
    color: AppColors.navigationSkybluecolor,
  );

  // static TextStyle styleHeaderGreyText12 = const TextStyle(
  //   fontSize: 12,
  //   fontFamily: Constants.customFontMediumFamily,
  //   fontWeight: FontWeight.w100,
  //   color: AppColors.textgreyThemecolor,
  // );
  // static TextStyle styleHeaderGreyText18 = const TextStyle(
  //   fontSize: 18,
  //   fontFamily: Constants.customFontMediumFamily,
  //   fontWeight: FontWeight.w200,
  //   color: AppColors.textgreyThemecolor,
  // );
  // static TextStyle styleHeaderGreyText24 = const TextStyle(
  //   fontSize: 24,
  //   fontFamily: Constants.customFontMediumFamily,
  //   fontWeight: FontWeight.w300,
  //   color: AppColors.textgreyThemecolor,
  // );
  // static TextStyle styleHeaderGreyText36 = const TextStyle(
  //   fontSize: 36,
  //   fontFamily: Constants.customFontMediumFamily,
  //   fontWeight: FontWeight.w400,
  //   color: AppColors.textgreyThemecolor,
  // );
  // static TextStyle styleHeaderGreyText48 = const TextStyle(
  //   fontSize: 48,
  //   fontFamily: Constants.customFontMediumFamily,
  //   fontWeight: FontWeight.w500,
  //   color: AppColors.textgreyThemecolor,
  // );
  // static TextStyle styleHeaderGreyText60 = const TextStyle(
  //   fontSize: 60,
  //   fontFamily: Constants.customFontMediumFamily,
  //   fontWeight: FontWeight.w600,
  //   color: AppColors.textgreyThemecolor,
  // );
  // static TextStyle styleHeaderGreyText72 = const TextStyle(
  //   fontSize: 72,
  //   fontFamily: Constants.customFontMediumFamily,
  //   fontWeight: FontWeight.w700,
  //   color: AppColors.textgreyThemecolor,
  // );

  static textFontSet(
      double fontsize, Color color, FontWeight? fontWeight, String fontfamily) {
    return TextStyle(
        fontFamily: fontfamily,
        fontSize: fontsize,
        fontWeight: fontWeight,
        color: color);
  }
}
