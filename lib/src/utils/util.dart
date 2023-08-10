import 'dart:convert';
import 'dart:io';
import 'dart:math';

// import 'package:cloud_firestore/cloud_firestore.dart';
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
    // int timestampcon = int.parse(timestamp ?? '') ?? 0;
   // var dt = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000 ?? 0);
    //var dt = DateTime.fromMillisecondsSinceEpoch(timestamp ?? 0 * 1000);
    int length = timestamp.toString().length; // 7
    final DateTime dt;
    if (length > 10)
    {
      dt = DateTime.fromMillisecondsSinceEpoch((timestamp ?? 0));
  print(dt);
    }
    else
    {
      dt = DateTime.fromMillisecondsSinceEpoch((timestamp ?? 0) * 1000);
  print(dt);

    }
     
    // 12 Hour format:
    //var d12 = DateFormat('MM/dd/yyyy, hh:mm a').format(dt); // 12/31/2000, 10:00 PM

    // 24 Hour format:
    //var d24 = DateFormat('dd/MM/yyyy, HH:mm').format(dt); // 31/12/2000, 22:00
    //var date = DateFormat('yyyy-MM-dd').format(dt);
     var date = DateFormat(format).format(dt);
    
    return date;
  }

  static int datetoTimestampConversion(String? date , String format) {
  // final df = new DateFormat(Constants.fulldateFormat);
   //df.format(new DateTime.fromMillisecondsSinceEpoch(myvalue*1000)));
     // DateTime dt = HttpDate.parse(date ?? '');
     DateTime? dt;
     if ((date ?? '').isEmpty)
     {
       dt = DateTime.tryParse(date ?? '');

     }
     else
     {
      dt = DateFormat(format).parse(date ?? '');
     }
       
      // Timestamp myTimeStamp = Timestamp.fromDate(dt);
      // print(myTimeStamp.seconds);
      //  print(myTimeStamp.nanoseconds);
      //   print(myTimeStamp.nanoseconds);
      double timestamp = (dt?.millisecondsSinceEpoch  ?? 0)/ 1000;

  //print(dt); // 2020-01-02 03:04:05.000
      // int timestamp = dt.second;
      //  print(dt);
    return timestamp.toInt();//myTimeStamp.seconds;
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
    showDialog(context: context,barrierDismissible: false, builder: (BuildContext context) => dialog);
  }
  static String idGenerator() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString();
  }
  
}