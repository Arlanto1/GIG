import 'dart:developer';

import 'package:db_atom/src/routing/router.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:flutter/material.dart';

class Validator {
  static bool emailValidation(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static bool passwordValidation(String? password) {
    return password!.length > 4;
  }

  static logoutAction(BuildContext context) {
    log('-will logout now----');
    SharedPrefs.setUserId('');
    SharedPrefs.setEmail('');
    SharedPrefs.setToken('');
    SharedPrefs.setUsername('');
    SharedPrefs.setSessionToken('');
    SharedPrefs.setLoggedIn(false);
    SharedPrefs.setFoundId(100);
    SharedPrefs.clearSharedPreferences();
    Navigator.of(context)
        .pushNamedAndRemoveUntil(loginScreenRoute, (route) => false);
  }

  static bool isValidEmail(String? value) {
    if (value == null) {
      return false;
    }
    const Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final regex = RegExp(pattern as String);
    return (!regex.hasMatch(value)) ? false : true;
  }

  static bool isValidPassword(String? password) {
    return password != null && password.trim().isNotEmpty;
  }

  static bool isValidUserName(String? userName) {
    return userName != null && userName.trim().isNotEmpty;
  }

//   String formatTimestamp(Timestamp timestamp) {
//   DateTime dateTime = timestamp.toDate();
//   String formattedTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
//   return formattedTime;
// }

  void showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    int seconds = message.length > 35 ? 8 : 5;
    scaffold.showSnackBar(
      SnackBar(
        duration: Duration(seconds: seconds),
        backgroundColor: Colors.red,
        content: Text(message),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: scaffold.hideCurrentSnackBar,
          textColor: AppColors.navigationSkybluecolor,
        ),
      ),
    );
  }
}
