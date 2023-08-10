import 'dart:io';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:flutter/material.dart';


Future<bool> networkChecking(BuildContext context) async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
      return true;
    }
  } on SocketException catch (_) {
    print('not connected');
    showDialog(
        builder: (context) => new AlertDialog(
          title: new Text("Evoke"),
          content: new Text("No network connection"),
          actions: <Widget>[
          TextButton(
      style: TextButton.styleFrom(
      primary: AppColors.navigationSkybluecolor),
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ), context: context);
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