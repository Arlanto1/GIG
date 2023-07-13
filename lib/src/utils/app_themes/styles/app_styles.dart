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
    color: AppColors.textgreyThemecolor,
  );

  static const TextStyle textStyleRegularGrey14 = TextStyle(
    fontSize: 14,
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
  static const TextStyle textStyleSemiBold16White = TextStyle(
    fontSize: 16,
    fontFamily: Constants.customFontSemiBoldFamily,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle textStyleAppBar = const TextStyle(
    fontSize: 18,
    fontFamily: Constants.customFontMediumFamily,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );

  static textFontSet(double fontsize, Color color, FontWeight? fontWeight, String fontfamily) {
    return TextStyle(
        fontFamily: fontfamily, fontSize: fontsize, fontWeight: fontWeight, color: color);
  }
}
