import 'dart:convert';
import 'dart:math';

import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/utils/customalert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  static final Random _random = Random.secure();

  static String createCryptoRandomString([int length = 32]) {
    var values = List<int>.generate(length, (i) => _random.nextInt(256));

    return base64Url.encode(values);
  }
   static String timestamptoDateConversion(int? timestamp , String format) {
    var dt = DateTime.fromMillisecondsSinceEpoch(timestamp ?? 0);
    // 12 Hour format:
    //var d12 = DateFormat('MM/dd/yyyy, hh:mm a').format(dt); // 12/31/2000, 10:00 PM

    // 24 Hour format:
    //var d24 = DateFormat('dd/MM/yyyy, HH:mm').format(dt); // 31/12/2000, 22:00
    //var date = DateFormat('yyyy-MM-dd').format(dt);
     var date = DateFormat(format).format(dt);
    
    return date;
  }
  static dynamicAlert(BuildContext context, String messgae, String title, String error) {
    var dialog = CustomAlertDialog(
      title: title,
      message: messgae,
      positiveBtnText: Constants.ok,
      onPostivePressed: () {
        if (error.isEmpty)
        {
           Navigator.pop(context);
        }
        Navigator.pop(context);
        
      },
    );
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }
}