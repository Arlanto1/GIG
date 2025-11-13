import 'dart:ui';

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
    this.bgColor = Colors.transparent,
    this.positiveBtnText,
    this.negativeBtnText,
    this.onPositivePressed,
    this.onNegativePressed,
  })  : assert(bgColor != null),
        assert(circularBorderRadius != null);

  // @override
  // Widget build(BuildContext context) {
  //   return AlertDialog(
  //     title: title != null
  //         ? Text(
  //             title ?? "",
  //             style: Styles.textFontSet(18, AppColors.navigationSkyBlueColor,
  //                 FontWeight.normal, Constants.customFontMediumFamily),
  //           )
  //         : null,
  //     content: message != null
  //         ? Text(message ?? "",
  //             style: Styles.textFontSet(16, Colors.black, FontWeight.normal,
  //                 Constants.customFontMediumFamily))
  //         : null,
  //     backgroundColor: AppColors.lavender,
  //     shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(circularBorderRadius ?? 0)),
  //     actions: <Widget>[
  //       negativeBtnText != null
  //           ? TextButton(
  //               child: Text(negativeBtnText ?? '',
  //                   style: Styles.textFontSet(
  //                       16,
  //                       AppColors.navigationSkyBlueColor,
  //                       FontWeight.normal,
  //                       Constants.customFontMediumFamily)),
  //               //  textColor: Theme.of(context).colorScheme.secondary,
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //                 if (onNegativePressed != null) {
  //                   onNegativePressed!();
  //                 }
  //               },
  //             )
  //           : Container(),
  //       positiveBtnText != null
  //           ? TextButton(
  //               onPressed: onPositivePressed,
  //               child: Text(positiveBtnText ?? '',
  //                   style: Styles.textFontSet(
  //                       16,
  //                       AppColors.navigationSkyBlueColor,
  //                       FontWeight.normal,
  //                       Constants.customFontMediumFamily)),
  //             )
  //           : Container(),
  //     ],
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent, // Ensure background is see-through for glass effect
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(circularBorderRadius ?? 20.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(circularBorderRadius ?? 20.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20), // Glass blur effect
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(circularBorderRadius ?? 20.0),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.lavender.withValues(alpha: 0.55),
                  AppColors.lavender.withValues(alpha: 0.25),
                ],
              ),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.25),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.2),
                  blurRadius: 20,
                  spreadRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (title != null)
                  Text(
                    title!,
                    style: Styles.textFontSet(18, AppColors.white,
                        FontWeight.w900, Constants.customFontMediumFamily),
                  ),
                if (title != null) const SizedBox(height: 8),
                if (message != null)
                  Text(
                    message!,
                    style: Styles.textFontSet(16, Colors.black, FontWeight.w900,
                        Constants.customFontBoldFamily),
                  ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (negativeBtnText != null)
                      TextButton(
                        child: Text(
                          negativeBtnText!,
                          style: Styles.textFontSet(
                            16,
                            AppColors.white,
                            FontWeight.normal,
                            Constants.customFontMediumFamily,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          if (onNegativePressed != null) {
                            onNegativePressed!();
                          }
                        },
                      ),
                    if (positiveBtnText != null)
                      TextButton(
                        onPressed: onPositivePressed,
                        child: Text(
                          positiveBtnText!,
                          style: Styles.textFontSet(
                            16,
                            AppColors.white,
                            FontWeight.normal,
                            Constants.customFontMediumFamily,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
