import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final Color? bgColor;
  final String? title;
  final String? message;
  final String? positiveBtnText;
  final String? negativeBtnText;
  final void Function()? onPositivePressed;
  final Function? onNegativePressed;
  final double? circularBorderRadius;

  const CustomAlertDialog({
    super.key,
    this.title,
    this.message,
    this.circularBorderRadius = 20.0,
    this.bgColor = Colors.white,
    this.positiveBtnText,
    this.negativeBtnText,
    this.onPositivePressed,
    this.onNegativePressed,
  })  : assert(bgColor != null),
        assert(circularBorderRadius != null);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null
          ? Text(
              title ?? "",
              style: Styles.textFontSet(18, AppColors.navigationSkybluecolor,
                  FontWeight.normal, Constants.customFontMediumFamily),
            )
          : null,
      content: message != null
          ? Text(message ?? "",
              style: Styles.textFontSet(16, Colors.black, FontWeight.normal,
                  Constants.customFontMediumFamily))
          : null,
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(circularBorderRadius ?? 0)),
      actions: <Widget>[
        negativeBtnText != null
            ? TextButton(
                child: Text(negativeBtnText ?? '',
                    style: Styles.textFontSet(
                        16,
                        AppColors.navigationSkybluecolor,
                        FontWeight.normal,
                        Constants.customFontMediumFamily)),
                //  textColor: Theme.of(context).colorScheme.secondary,
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onNegativePressed != null) {
                    onNegativePressed!();
                  }
                },
              )
            : Container(),
        positiveBtnText != null
            ? TextButton(
                onPressed: onPositivePressed,
                child: Text(positiveBtnText ?? '',
                    style: Styles.textFontSet(
                        16,
                        AppColors.navigationSkybluecolor,
                        FontWeight.normal,
                        Constants.customFontMediumFamily)),
              )
            : Container(),
      ],
    );
  }
}
