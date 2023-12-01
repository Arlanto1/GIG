import 'package:db_atom/src/common_widgets/pop_button.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAlertImageDialog extends StatelessWidget {
  final Color? bgColor;
  final String? title;
  final String? image;
  final String? message;
  final String positiveBtnText;
  final String negativeBtnText;
  final Function? onPostivePressed;
  final Function? onNegativePressed;
  final double? circularBorderRadius;

  const CustomAlertImageDialog({
    super.key,
    this.title,
    this.image,
    this.message,
    this.circularBorderRadius = 20.0,
    this.bgColor = Colors.white,
    required this.positiveBtnText,
    required this.negativeBtnText,
    this.onPostivePressed,
    this.onNegativePressed,
  })  : assert(bgColor != null),
        assert(circularBorderRadius != null);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return AlertDialog(
      title: title != null
          ? Text(
              title ?? "",
              textAlign: TextAlign.center,
              style: Styles.textFontSet(18, AppColors.textgreyThemecolor,
                  FontWeight.normal, Constants.customFontMediumFamily),
            )
          : null,
      icon: SvgPicture.asset(
        image ?? "",
        colorFilter: const ColorFilter.mode(
          AppColors.navigationSkybluecolor,
          BlendMode.srcIn,
        ),
        width: 50,
        //key: const Key(Keys.userIcon),
      ),
      content: message != null
          ? Builder(builder: (context) {
              return Container(
                //height: 50,
                //width:  width - 50,
                child: Text(message ?? "",
                    textAlign: TextAlign.center,
                    style: Styles.textFontSet(16, Colors.grey,
                        FontWeight.normal, Constants.customFontMediumFamily)),
              );
            })
          : null,
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(circularBorderRadius ?? 0)),
      actions: <Widget>[
        // TextButton(
        //   child: Text(negativeBtnText,
        //       style: Styles.textFontSet(16, AppColors.navigationSkybluecolor, FontWeight.normal,
        //           Constants.customFontMediumFamily)),
        //   //  textColor: Theme.of(context).colorScheme.secondary,
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //     if (onNegativePressed != null) {
        //       onNegativePressed!();
        //     }
        //   },
        // ),
        // TextButton(
        //   child: Text(positiveBtnText,
        //       style: Styles.textFontSet(16, AppColors.navigationSkybluecolor, FontWeight.normal,
        //           Constants.customFontMediumFamily)),
        //   //  textColor: Theme.of(context).colorScheme.secondary,
        //   onPressed: () {
        //     if (onPostivePressed != null) {
        //       onPostivePressed!();
        //     }
        //   },
        // ),
        buttonViews(context, width),
      ],
    );
  }

  Widget buttonViews(BuildContext context, double width) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0, left: 10, right: 10),
      child: Container(
        color: AppColors.backgroundWhitecolor,
        child: Row(
          //mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            cancelButton(width, context),
            const SizedBox(
              width: 20,
            ),
            saveButton(width, context)
          ],
        ),
      ),
    );
  }

  Widget cancelButton(double width, BuildContext context) {
    return PopButton(
      width: width / 3.5,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.abort,
      buttonTextKey: Keys.cancelButtonText,
      foregroundColor: AppColors.textgreyThemecolor,
      textStyle: Styles.styleHeaderGreyText16,
      boarderColor: AppColors.textgreyThemecolor,
      onTap: () {
        //loginFormKey.currentState!.validate();
        FocusScope.of(context).unfocus();
        try {
          // final ValidLoginDetails validLoginDetails =
          //     ValidLoginDetails(userName: username, password: password);
          // widget.onValidLogin(validLoginDetails);
          //Navigator.pushNamed(context, homePageRoute);
          Navigator.of(context).pop();
        } catch (e) {
          // present userwith error message
        }
      },
    );
  }

  Widget saveButton(double width, BuildContext context) {
    return PopButton(
      width: width / 3,
      key: const Key(Keys.saveButton),
      buttonText: Constants.yes,
      buttonTextKey: Keys.saveButtonText,
      boarderColor: AppColors.navigationSkybluecolor,
      backgroundColor: AppColors.navigationSkybluecolor,
      foregroundColor: Colors.white,
      textStyle: Styles.textStyleSemiBold16White,
      onTap: () {
        //loginFormKey.currentState!.validate();
        FocusScope.of(context).unfocus();
        try {
          // final ValidLoginDetails validLoginDetails =
          //     ValidLoginDetails(userName: username, password: password);
          // widget.onValidLogin(validLoginDetails);
          //Navigator.pushNamed(context, homePageRoute);
        } catch (e) {
          // present userwith error message
        }
      },
    );
  }
}
