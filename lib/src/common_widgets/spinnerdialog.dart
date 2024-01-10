import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:flutter/material.dart';

// Show the spinner
Future<void> showLoadingDialog(BuildContext context) async {
  // if (!isSpinnerLoading) {
  //   spinnerContext = context;
  //   isSpinnerLoading = true;
  return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: const SimpleDialog(
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                children: <Widget>[
                  Center(
                    child:
                        // Column(children: const <Widget>[
                        CircularProgressIndicator(
                            color: AppColors.navigationSkybluecolor),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    //   Text(
                    //     'Please Wait....',
                    //     style: TextStyle(color: Colors.white),
                    //   )
                    // ]),
                  )
                ]));
      });
  // }
}

// Hide the spinner

Future<void> dismissLoadingDialog(BuildContext context) async {
  // if (isSpinnerLoading) {
  //   isSpinnerLoading = false;

  Navigator.of(context).pop();
  //}
}
