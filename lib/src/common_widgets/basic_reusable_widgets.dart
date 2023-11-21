import 'package:db_atom/src/common_widgets/screen_size_config.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/constants/ui_geometry_constants.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

export 'package:flutter_svg/svg.dart';

class CommonWidgets {
  static Widget svgAsset(String assetName,
      {Color color = AppColors.navigationSkybluecolor,
      double width = 24.0,
      double height = 24.0}) {
    return SvgPicture.asset(
      assetName,
      colorFilter:  ColorFilter.mode(
        color,
        BlendMode.srcIn,
      ),      width: width,
      height: height,
    );
  }

  static Widget emptyContainer() {
    return Container();
  }

  static Widget emptySizedBox() {
    return const SizedBox();
  }

  static Widget verticalSpacerWidget(double? value) {
    return SizedBox(
      height: value,
    );
  }

  static Widget horizontalSpacerWidget(double value) {
    return SizedBox(
      width: value,
    );
  }

  static Widget fixedVerticalSpacerWidget() {
    return SizedBox(
      height: ScreenSizeConfig.screenHeight! * 0.02,
    );
  }

  static Widget fixedHorizontalSpacerWidget() {
    return SizedBox(
      width: ScreenSizeConfig.screenWidth! * 0.02,
    );
  }

  static Widget commonTextWidget(String text,
      {Key? key,
      Color color = AppColors.black,
      double fontSize = 14.0,
      FontWeight fontWeight = FontWeight.w500}) {
    return Text(
      text,
      key: key,
      style: TextStyle(
        fontFamily: Constants.customFontRegularFamily,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }

  static Widget indentedDivider(Color color) {
    return Divider(
      endIndent: 24.0,
      indent: 24.0,
      color: color,
    );
  }

  static Widget commonCard(Widget child,
      {Color borderColor = AppColors.cardBorder}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: circularBorderRadius8,
        side: BorderSide(
          color: borderColor,
          width: 1.0,
        ),
      ),
      child: child,
    );
  }

  static Widget textDisplay(
    String name,
    TextStyle? style, {
    bool? isMandatory = false,
  }) {
    return Container(
      alignment: Alignment.topLeft,
      child: Row(
        children: [
          Text(
            name,
            style: style,
          ),
          if (isMandatory ?? false) ...[
            const Text(
              ' *',
              style: TextStyle(color: Colors.red),
            ),
          ],
        ],
      ),
    );
  }

  static Widget horizentaltextHandling(String title, String desc,{
    bool? isMandatory = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: Row(
            children: [
              Text(
                title,
                style: Styles.textStyleBlack14,
              ),
              if (isMandatory ?? false) ...[
                const Text(
                  ' *',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
              alignment: Alignment.topLeft,
              child: Text(
                desc,
                style: Styles.textStyleBoldGreydark14,
              )),
        ),
      ],
    );
  }

  static Widget verticalTextHandling(String title, String desc) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            title,
            style: Styles.textStyleBlack14,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
            alignment: Alignment.topLeft,
            child: Text(
              desc,
              style: Styles.textStyleBoldGreydark14,
            )),
      ],
    );
  }
}
