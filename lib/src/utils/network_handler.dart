import 'dart:developer';
import 'dart:io';

import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:flutter/material.dart';

Future<bool> networkChecking(BuildContext context) async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      log('connected');
      return true;
    }
  } on SocketException catch (_) {
    log('not connected');
    showDialog(
        builder: (context) => AlertDialog(
              title: const Text("Evoke"),
              content: const Text("No network connection"),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: AppColors.navigationSkyBlueColor),
                  child: const Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
        context: context);
    return false;
  }
  return false;
}

Future<bool> withoutAlertnetworkChecking(BuildContext context) async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    return false;
  }
  return false;
}
