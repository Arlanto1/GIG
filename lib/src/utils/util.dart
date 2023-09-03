import 'dart:convert';
import 'dart:math';

import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/utils/customalert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'app_themes/styles/app_styles.dart';

class Utils {
  static final Random _random = Random.secure();

  static String createCryptoRandomString([int length = 32]) {
    var values = List<int>.generate(length, (i) => _random.nextInt(256));

    return base64Url.encode(values);
  }

  static String timestamptoDateConversion(int? timestamp, String format) {
    // int timestampcon = int.parse(timestamp ?? '') ?? 0;
    // var dt = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000 ?? 0);
    //var dt = DateTime.fromMillisecondsSinceEpoch(timestamp ?? 0 * 1000);
    int length = timestamp.toString().length; // 7
    final DateTime dt;
    if (length > 10) {
      dt = DateTime.fromMillisecondsSinceEpoch((timestamp ?? 0));
      print(dt);
    } else {
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

  static int datetoTimestampConversion(String? date, String format) {
    // final df = new DateFormat(Constants.fulldateFormat);
    //df.format(new DateTime.fromMillisecondsSinceEpoch(myvalue*1000)));
    // DateTime dt = HttpDate.parse(date ?? '');
    DateTime? dt;
    if ((date ?? '').isEmpty) {
      dt = DateTime.tryParse(date ?? '');
    } else {
      dt = DateFormat(format).parse(date ?? '');
    }

    // Timestamp myTimeStamp = Timestamp.fromDate(dt);
    // print(myTimeStamp.seconds);
    //  print(myTimeStamp.nanoseconds);
    //   print(myTimeStamp.nanoseconds);
    double timestamp = (dt?.millisecondsSinceEpoch ?? 0) / 1000;

    //print(dt); // 2020-01-02 03:04:05.000
    // int timestamp = dt.second;
    //  print(dt);
    return timestamp.toInt(); //myTimeStamp.seconds;
  }

  static dynamicAlert(
      BuildContext context, String messgae, String title, String error) {
    var dialog = CustomAlertDialog(
      title: title,
      message: messgae,
      positiveBtnText: Constants.ok,
      onPostivePressed: () {
        if (error.isEmpty) {
          Navigator.pop(context);
        }
        Navigator.pop(context);
      },
    );
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => dialog);
  }

  static String idGenerator() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString();
  }

  String formatUnixTimestamp(String timestampString) {
    try {
      // Parse the Unix timestamp as an int
      int unixTimestamp = int.parse(timestampString);

      // Convert the Unix timestamp to a DateTime object
      DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);

      // Format the DateTime object as a string
      String formattedDate =
          DateFormat('dd/MM/yyyy a HH:mm:ss').format(dateTime);

      return formattedDate;
    } catch (e) {
      // Handle any parsing or formatting errors here
      print('Error formatting Unix timestamp: $e');
      return 'Invalid Date';
    }
  }

  String formatTime(String dateTimeString) {
    // if the dateTimeString is already unixTimestamp
    if (dateTimeString.length == 10 &&
        dateTimeString.contains(RegExp(r'^\d+$'))) {
      return dateTimeString;
    }
    final List<String> dateFormats = [
      'dd/MM/yyyy a hh:mm:ss',
      'yyyy-MM-ddTHH:mm:ss',
      'dd/MM/yyyy',
    ];

    for (final format in dateFormats) {
      try {
        final dateTime = DateFormat(format).parse(dateTimeString);
        final unixTimestamp = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
        return unixTimestamp.toString();
      } catch (_) {
        continue;
      }
    }

    // If none of the formats match, you can handle the error or return a default value
    throw FormatException('Unable to parse date-time: $dateTimeString');
  }

  Row buildStatusRow(int status) {
    String statusText;

    switch (status) {
      case 0:
        statusText = 'Draft';
        break;
      case 1:
        statusText = 'Submitted';
        break;
      case 2:
        statusText = 'Approved';
        break;
      case 3:
        statusText = 'Rejected';
        break;
      case 4:
        statusText = 'Outward Pending';
        break;
      case 5:
        statusText = 'Inward Pending';
        break;
      case 6:
        statusText = 'Closed/Finalized';
        break;
      default:
        statusText = ''; // Handle the default case if needed
    }
    return Row(
      children: [
        textHandling('Status: ', statusText),
      ],
    );
  }

  Row buildMasterDataStatusRow(int Status) {
    String statusText;

    switch (Status) {
      case 1:
        statusText = 'Active';
        break;
      case 2:
        statusText = 'InActive';
        break;
      case 3:
        statusText = 'Leave';
        break;
      case 4:
        statusText = 'WeekOff';
        break;
      default:
        statusText = ''; // Handle the default case if needed
    }
    return Row(
      children: [
        textHandling('Status: ', statusText),
      ],
    );
  }

  Row buildDutyTypeRow(int dutyType) {
    String dutyTypeText;

    switch (dutyType) {
      case 1:
        dutyTypeText = 'Building';
        break;
      case 2:
        dutyTypeText = 'Escort';
        break;
      case 3:
        dutyTypeText = 'Facility';
        break;
      case 4:
        dutyTypeText = 'Building & Escort';
        break;
      default:
        dutyTypeText = ''; // Handle the default case if needed
    }

    return Row(
      children: [
        textHandling('DutyType: ', dutyTypeText),
      ],
    );
  }

  Row buildGuardrank(int guardRank) {
    String guardRankText;

    switch (guardRank) {
      case 1:
        guardRankText = 'Security Guard';
        break;
      case 2:
        guardRankText = 'Security Officer';
        break;
      case 3:
        guardRankText = 'Security Supervisor';
        break;
      case 4:
        guardRankText = 'Security Facilitator';
        break;
      case 5:
        guardRankText = 'Gun Man';
        break;
      case 6:
        guardRankText = 'Lady Security Guard';
        break;
      default:
        guardRankText = ''; // Handle the default case if needed
    }

    return Row(
      children: [
        textHandling('GuardRank: ', guardRankText),
      ],
    );
  }

  Row buildMaritalStatus(int maritalStatus) {
    String maritalStatusText;

    switch (maritalStatus) {
      case 1:
        maritalStatusText = 'Single';
        break;
      case 2:
        maritalStatusText = 'Married';
        break;
      default:
        maritalStatusText = ''; // Handle the default case if needed
    }
    return Row(
      children: [
        textHandling('MaritalStatus: ', maritalStatusText),
      ],
    );
  }

  Row buildGender(int gender) {
    String genderText;

    switch (gender) {
      case 1:
        genderText = 'Male';
        break;
      case 2:
        genderText = 'Female';
        break;
      case 3:
        genderText = 'TransGender';
        break;
      default:
        genderText = ''; // Handle the default case if needed
    }
    return Row(
      children: [
        textHandling('Gender: ', genderText),
      ],
    );
  }

  Widget textHandling(String title, String desc) {
    return Expanded(
      child: RichText(
        text: TextSpan(
          style: Styles.textStyleRegularNormalGrey14,
          children: <TextSpan>[
            TextSpan(text: title),
            TextSpan(
              text: desc,
              style: Styles.textStyleBoldGrey14,
            ),
          ],
        ),
      ),
    );
  }

  String removeDecimalAndValuesAfterIt(dynamic value) {
    if (value == null) {
      return '';
    }

    if (value is num || value is double) {
      return value.toStringAsFixed(0);
    } else if (value is String) {
      final double parsedValue = double.tryParse(value) ?? 0.0;
      return parsedValue.toStringAsFixed(0);
    } else {
      throw ArgumentError('Unsupported type: ${value.runtimeType}');
    }
  }
}
