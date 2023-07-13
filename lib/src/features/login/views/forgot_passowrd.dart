// Created by Ramesh
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  // final Function onUserNameForgotten;
  // final Function onPasswordForgotten;
  final Function onForgottenPassword;

  const ForgotPassword({Key? key, required this.onForgottenPassword}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: Constants.forgotpassowrd,
        // style: Styles.textStyleBlack16,
        style: const TextStyle(
          color: AppColors.textgreyThemecolor,
          fontSize: 16,
          fontFamily: Constants.customFontRegularFamily,
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.w600,
        ),
        recognizer: TapGestureRecognizer()..onTap = () => onForgottenPassword(),
        // children: <TextSpan>[
        //   TextSpan(
        //     text: 'Username',
        //     style: const TextStyle(
        //       color: AppColors.navigationSkybluecolor,
        //       fontSize: 16,
        //       fontFamily: 'Poppins-SemiBold',
        //       decoration: TextDecoration.underline,
        //       fontWeight: FontWeight.w400,
        //     ),
        //     recognizer: TapGestureRecognizer()..onTap = () => onUserNameForgotten(),
        //   ),
        //   const TextSpan(
        //     text: ' or ',
        //     style: Styles.textStyleBlack16,
        //   ),
        //   TextSpan(
        //     text: 'password ',
        //     style: const TextStyle(
        //       color: AppColors.navigationSkybluecolor,
        //       fontSize: 16,
        //       fontFamily: 'Poppins-SemiBold',
        //       decoration: TextDecoration.underline,
        //     ),
        //     recognizer: TapGestureRecognizer()..onTap = () => onPasswordForgotten(),
        //   ),
        // const TextSpan(
        //   text: '?',
        //   style: Styles.textStyleBlack16,
        // ),
        // ],
      ),
    );
  }
}
