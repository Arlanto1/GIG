import 'dart:io';

import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:flutter/material.dart';



//  String getGlobalString(String value,BuildContext context)
//   {
//     return AppLocalizations.of(context).translate(value);
//   }
void alertDisplay(BuildContext context, String text) {
  showDialog(
      builder: (context) =>  AlertDialog(
        title:  const Text(Constants.appname),
        content:  Text(text),
        actions: <Widget>[
         TextButton(
      style: TextButton.styleFrom(
      foregroundColor: AppColors.navigationSkybluecolor),
            child: const Text("Ok"),
            onPressed: () {
              // if(text=="Unauthorised Access."){
              //   navigateToLanding(context);
              //   // sharedPreferencesStore.logOut();
              //   // chargingStatusStore?.cancelSubcription();
              // }
              // else{
                Navigator.of(context).pop();
              //}

            },
          ),
        ],
      ), context: context,
      barrierDismissible: false);
}
void navigateToLanding(BuildContext context) {
  if (Platform.isAndroid) {
    // Navigator.of(context).pushNamedAndRemoveUntil(Constants.ROUTE_LOGIN,
    //         (route) {
    //       return false;
    //     });
  } else {
    // Navigator.of(context).pushAndRemoveUntil(
    //   SlideLeftRoute(
    //       page: LandingScreen(), routeName: Constants.ROUTE_LANDING),
    //       (route) {
    //     return false; // returning false will dismiss every route below the one you are pushing
    //   },
    // );
  }
}
enum ConfirmAction { CANCEL, ACCEPT }
 