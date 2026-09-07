import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:db_atom/index.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class Utils {
  static final math.Random _random = math.Random.secure();

  String? getKeyFromValue({
    required int value,
    required List<Label> dropdownValues,
  }) {
    // Convert int value to string to match with Label value
    String valueString = value.toString();

    // Find the Label with the matching value
    final label = dropdownValues.firstWhere(
        (label) => label.value == valueString,
        orElse: () => const Label(key: '', value: ''));

    // Return the key, or null if not found
    return label.key.isNotEmpty ? label.key : null;
  }

  final List<String> imageExtensions = [
    'jpeg',
    'jpg',
    'png',
    'gif',
    'bmp',
    'webp',
    'tiff',
    'tif',
    'svg'
  ];

  bool isImageFile(String fileName) {
    String? extension = getFileExtension(fileName);
    return imageExtensions.contains(extension.toLowerCase());
  }

  String getFileNameWithoutExtension(String fileName) {
    int dotIndex = fileName.lastIndexOf('.');
    if (dotIndex == -1) return fileName; // No extension found
    return fileName.substring(0, dotIndex);
  }

  String getFileExtension(String fileName) {
    int dotIndex = fileName.lastIndexOf('.');
    if (dotIndex == -1) return ''; // No extension found
    return fileName.substring(dotIndex);
  }

  Color getRandomColor() {
    math.Random random = math.Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1.0,
    );
  }

  static String createCryptoRandomString([int length = 32]) {
    var values = List<int>.generate(length, (i) => _random.nextInt(256));

    return base64Url.encode(values);
  }

  bool isTimestamp(String str) {
    try {
      DateTime.parse(str);
      return true;
    } catch (e) {
      return false;
    }
  }

  static String timestampToDateConversion(int? timestamp, String format) {
    // int timestampcon = int.parse(timestamp ?? '') ?? 0;
    // var dt = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000 ?? 0);
    //var dt = DateTime.fromMillisecondsSinceEpoch(timestamp ?? 0 * 1000);

    if (timestamp == null || timestamp == 0) {
      timestamp = DateTime.now().millisecondsSinceEpoch;
    }

    int length = timestamp.toString().length; // 7
    final DateTime dt;
    if (length > 10) {
      dt = DateTime.fromMillisecondsSinceEpoch((timestamp));
    } else {
      dt = DateTime.fromMillisecondsSinceEpoch((timestamp) * 1000);
    }

    // 12 Hour format:
    //var d12 = DateFormat('MM/dd/yyyy, hh:mm a').format(dt); // 12/31/2000, 10:00 PM

    // 24 Hour format:
    //var d24 = DateFormat('dd/MM/yyyy, HH:mm').format(dt); // 31/12/2000, 22:00
    //var date = DateFormat('yyyy-MM-dd').format(dt);
    var date = DateFormat(format).format(dt);

    return date;
  }

  static int dateToTimestampConversion(String? date, String format) {
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
    double timestamp = (dt?.millisecondsSinceEpoch ?? 0) / 1000;

    return timestamp.toInt(); //myTimeStamp.seconds;
  }

  static dynamicAlert(
    BuildContext context,
    String message,
    String title,
    String error,
  ) {
    var dialog = CustomAlertDialog(
      title: title,
      message: message,
      negativeBtnText: Constants.ok,
      //positiveBtnText is
      onPositivePressed: () {
        if (error.isNotEmpty) {
          Navigator.pop(context);
        } else {
          Navigator.pop(context);
          Navigator.pop(context, true);
        }
      },
      onNegativePressed: () {
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

  static showAlertMessage(String message, BuildContext context) {
    var dialog = CustomAlertDialog(
      title: Constants.appName,
      message: message,
      onPositivePressed: () {
        //ValidatorlogoutAction(context);
        Navigator.of(context).pop();
      },
      positiveBtnText: Constants.ok,
      //negativeBtnText: Constants.no
    );
    showDialog(context: context, builder: (BuildContext context) => dialog);
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
      log('Error formatting Unix timestamp: $e');
      return 'Invalid Date';
    }
  }

  String formatTime(String dateTimeString) {
    log('Formatting Date: $dateTimeString');

    // Check if the input string is a Unix timestamp
    if (dateTimeString.length == 10 &&
        dateTimeString.contains(RegExp(r'^\d+$'))) {
      // Convert Unix timestamp to DateTime
      final dateTime =
          DateTime.fromMillisecondsSinceEpoch(int.parse(dateTimeString) * 1000);
      return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
    }

    final List<String> dateFormats = [
      'dd/MM/yyyy a hh:mm:ss',
      'dd/MM/yyyy HH:mm:ss',
      'dd/MM/yyyy hh:mm:ss a',
      'yyyy-MM-ddTHH:mm:ss',
      'dd/MM/yyyy',
      'yyyy-MM-dd HH:mm:ss.SSS',
      'yyyy-MM-dd',
    ];

    // Try parsing the input string using each format
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

  String convertToDateFormat(String dateString) {
    // input : dd/MM/yyyy HH:mm:ss
    // Define the input format
    final DateFormat inputFormat = DateFormat('dd/MM/yyyy HH:mm:ss');

    // Define the output format
    final DateFormat outputFormat = DateFormat('yyyy-MM-dd');

    // Parse the input date string to a DateTime object
    final DateTime dateTime = inputFormat.parse(dateString);

    // Format the DateTime object to the desired output format
    return outputFormat.format(dateTime);
  }


  Widget buildFoundStatusRow(int status) {
    String statusText;
    Color bgColor;
    Color textColor;
    Color borderColor;

    switch (status) {
      case 0:
        statusText = 'Found';
        bgColor =  const Color(0xFF33B249); // light green
        borderColor = const Color(0xFF1E5C1E); //green; // dark green border
        textColor =  Colors.white; // dark green text
        break;
      case 1:
        statusText = 'Under Security Custody';
        bgColor = const Color(0xFF6B0B98);// light blue
        borderColor = const Color(0xFF40075A); // medium blue
        textColor =  Colors.white; // dark blue
        bgColor =const Color(0xFFBFA5C4);
        break;
      case 2:
        statusText = 'Handed Over / Claimed';
        bgColor =const Color(0xFF42A5F5);
        borderColor =const Color(0xFF42A5F5);
        textColor = Colors.white;
        break;
      case 3:
        statusText = 'Article Ready for Disposal';
        bgColor = const Color(0xFFF0F4C3);      // Light Lime
        borderColor = const Color(0xFF9E9D24);  // Lime Border
        textColor = const Color(0xFF827717);
        textColor = Colors.white;
        break;
      case 4:
        statusText = 'Article Disposed';
       bgColor = const Color(0xFFFFF9C4);      // Light Yellow
        borderColor = const Color(0xFFFBC02D);  // Yellow Border
        textColor = const Color(0xFFF57F17);
        textColor = Colors.black;
        break;
      case -1:
        statusText = 'Cancelled';
        bgColor = const Color(0xFFFFCDD2); // light red
        borderColor = const Color(0xFFE53935); // red border
        textColor = const Color(0xFFB71C1C); // dark red
        break;
      default:
        statusText = '';
        bgColor = const Color(0xFFE0E0E0);
        borderColor = const Color(0xFF9E9E9E);
        textColor = const Color(0xFF424242);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Status:',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: bgColor.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: borderColor, width: 0.1),
          ),
          child: Text(
            statusText,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }


  dynamic buildLeoStatusRow(int status, {bool? returnTextOnly}) {
    String statusText;
    Color bgColor;
    Color textColor;
    Color borderColor;

    switch (status) {
      case 0:
        statusText = 'Draft';
        bgColor = const Color(0xFF4DD0E1);
        borderColor = const Color(0xFFF57C00);  // Dark Orange
        textColor = Colors.black; // Text Blue
        break;

      case 1:
        statusText = 'Submitted';
        bgColor = const Color(0xFFBBDEFB);      // Light Blue
        borderColor = const Color(0xFF1976D2);  // Dark Blue
        textColor = const Color(0xFF0D47A1);    // Text Orange
        break;

      case 2:
        statusText = 'Verification Under Process';
        bgColor = const Color(0xFFD1C4E9);      // Light Purple
        borderColor = const Color(0xFF512DA8);  // Dark Purple
        textColor = const Color(0xFF311B92);    // Text Purple
        break;

      case 3:
        statusText = 'Distributed';
        bgColor = const Color(0xFFC8E6C9);      // Light Green
        borderColor = const Color(0xFF388E3C);  // Dark Green
        textColor = const Color(0xFF1B5E20);    // Text Green
        break;

      case -1:
        statusText = 'Cancelled';
        bgColor = const Color(0xFFFFCDD2);      // Light Red
        borderColor = const Color(0xFFD32F2F);  // Dark Red
        textColor = const Color(0xFFB71C1C);    // Text Red
        break;

      default:
        statusText = '';
        bgColor = const Color(0xFFE0E0E0);
        borderColor = const Color(0xFF9E9E9E);
        textColor = const Color(0xFF424242);
    }
    if (returnTextOnly ?? false) {
      return statusText;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Status:',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: bgColor.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: borderColor, width: 0.1),
          ),
          child: Text(
            statusText,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildMaterialMovementStatusRow(int status) {
    String statusText;
    Color bgColor;
    Color textColor;
    Color borderColor;

    switch (status) {
      case 0:
        statusText = 'Draft';
        bgColor = const Color(0xFFBBDEFB);      // Light Blue
        borderColor = const Color(0xFF1976D2);  // Blue Border
        textColor = const Color(0xFF0D47A1);    // Dark Blue Text
        break;

      case 1:
        statusText = 'Business User Review';
        bgColor = const Color(0xFFFFF9C4);      // Light Yellow
        borderColor = const Color(0xFFFBC02D);  // Yellow Border
        textColor = const Color(0xFFF57F17);    // Yellow Text
        break;

      case 2:
        statusText = 'Submitted';
        bgColor = const Color(0xFFE1BEE7);      // Light Purple
        borderColor = const Color(0xFF8E24AA);  // Purple Border
        textColor = const Color(0xFF4A148C);    // Purple Text
        break;

      case 3:
        statusText = 'Security Review';
        bgColor = const Color(0xFFC5CAE9);      // Light Indigo
        borderColor = const Color(0xFF3F51B5);  // Indigo Border
        textColor = const Color(0xFF1A237E);    // Indigo Text
        break;

      case 4:
        statusText = 'Approval from Approver is awaited';
        bgColor = const Color(0xFFFFE0B2);      // Light Orange
        borderColor = const Color(0xFFF57C00);  // Orange Border
        textColor = const Color(0xFFE65100);    // Orange Text
        break;

      case 5:
        statusText = 'Security Rejected';
        bgColor = const Color(0xFFFFCDD2);      // Light Red
        borderColor = const Color(0xFFD32F2F);  // Red Border
        textColor = const Color(0xFFB71C1C);    // Red Text
        break;

      case 6:
        statusText = 'Outward Pending';
        bgColor = const Color(0xFFB2EBF2);      // Light Cyan
        borderColor = const Color(0xFF0097A7);  // Cyan Border
        textColor = const Color(0xFF006064);    // Cyan Text
        break;

      case 7:
        statusText = 'Rejected';
        bgColor = const Color(0xFFFFCDD2);      // Light Red
        borderColor = const Color(0xFFE53935);  // Red Border
        textColor = const Color(0xFFB71C1C);    // Red Text
        break;

      case 8:
        statusText = 'Return Pending';
        bgColor = const Color(0xFFF0F4C3);      // Light Lime
        borderColor = const Color(0xFF9E9D24);  // Lime Border
        textColor = const Color(0xFF827717);    // Lime Text
        break;

      case 9:
        statusText = 'Inward Pending';
        bgColor = const Color(0xFFD7CCC8);      // Light Brown
        borderColor = const Color(0xFF6D4C41);  // Brown Border
        textColor = const Color(0xFF4E342E);    // Green Text
        break;

      case 10:
        statusText = 'Closed/Finalized';
        bgColor = const Color(0xFFC8E6C9);      // Light Green
        borderColor = const Color(0xFF388E3C);  // Green Border
        textColor = const Color(0xFF1B5E20);// Brown Text
        break;

      case 11:
        statusText = 'Material Return Pending';
        bgColor = const Color(0xFFE0F7FA);
        borderColor = const Color(0xFF00ACC1);
        textColor = const Color(0xFF006064);
        break;
      case 12:
        statusText = 'Material Return Overdue';
        bgColor = const Color(0xFFD7CCC8);      // Light Brown
        borderColor = const Color(0xFF6D4C91);  // Brown Border
        textColor = const Color(0xFF4E349E);  // Brown Text
        break;
      case -1:
        statusText = 'Cancelled';
        bgColor = const Color(0xFFFFCDD2);      // Light Red
        borderColor = const Color(0xFFD32F2F);  // Red Border
        textColor = const Color(0xFFB71C1C);    // Dark Red
        break;

      default:
        statusText = '';
        bgColor = const Color(0xFFE0E0E0);
        borderColor = const Color(0xFF9E9E9E);
        textColor = const Color(0xFF424242);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Status:',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: bgColor.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: borderColor, width: 0.1),
          ),
          child: Text(
            statusText,
            maxLines: 1,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }


  dynamic buildMasterDataStatusRow(int status, {bool? returnTextOnly}) {
    String statusText;
    Color bgColor;
    Color textColor;
    Color borderColor;

    switch (status) {
      case 1:
        statusText = 'Active';
        bgColor = const Color(0xFFBBDEFB);      // Light Blue
        borderColor = const Color(0xFF1976D2);  // Dark Blue
        textColor = const Color(0xFF0D47A1);    // Text Orange
        break;

      case 2:
        statusText = 'InActive';
        bgColor = const Color(0xFFD1C4E9);      // Light Purple
        borderColor = const Color(0xFF512DA8);  // Dark Purple
        textColor = const Color(0xFF311B92);    // Text Purple
        break;

      case 3:
        statusText = 'Leave';
        bgColor = const Color(0xFFC8E6C9);      // Light Green
        borderColor = const Color(0xFF388E3C);  // Dark Green
        textColor = const Color(0xFF1B5E20);    // Text Green
        break;

      case 4:
        statusText = 'WeekOff';
        bgColor = const Color(0xFFFFF9C4);      // Light Yellow
        borderColor = const Color(0xFFFBC02D);  // Yellow Border
        textColor = const Color(0xFFF57F17);   // Text Green
        break;

      case 5:
        statusText = 'Offboarded';
        bgColor = const Color(0xFFE0F7FA);
        borderColor = const Color(0xFF00ACC1);
        textColor = const Color(0xFF006064);   // Text Green
        break;

      case -1:
        statusText = 'Cancelled';
        bgColor = const Color(0xFFFFCDD2);      // Light Red
        borderColor = const Color(0xFFD32F2F);  // Dark Red
        textColor = const Color(0xFFB71C1C);    // Text Red
        break;

      default:
        statusText = '';
        bgColor = const Color(0xFFE0E0E0);
        borderColor = const Color(0xFF9E9E9E);
        textColor = const Color(0xFF424242);
    }
    if (returnTextOnly ?? false) {
      return statusText;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Status:',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: bgColor.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: borderColor, width: 0.1),
          ),
          child: Text(
            statusText,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }


  // Widget buildMasterDataStatusRow(int status) {
  //   String statusText;
  //
  //   switch (status) {
  //     case 1:
  //       statusText = 'Active';
  //       break;
  //     case 2:
  //       statusText = 'InActive';
  //       break;
  //     case 3:
  //       statusText = 'Leave';
  //       break;
  //     case 4:
  //       statusText = 'WeekOff';
  //       break;
  //     case 5:
  //       statusText = 'Offboarded';
  //       break;
  //     case -1:
  //       statusText = 'Cancelled';
  //       break;
  //     default:
  //       statusText = ''; // Handle the default case if needed
  //   }
  //   return IntrinsicWidth(
  //     child: Row(
  //       children: [
  //         textHandling('Status : ', statusText),
  //       ],
  //     ),
  //   );
  // }

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
        textHandling('DutyType : ', dutyTypeText),
      ],
    );
  }

  Row buildAttendanceDutyTypeRow(int dutyType) {
    String dutyTypeText;

    switch (dutyType) {
      case 1:
        dutyTypeText = 'Transport';
        break;
      case 2:
        dutyTypeText = 'Building';
        break;
      case 3:
        dutyTypeText = 'Building and Transport';
        break;
      default:
        dutyTypeText = ''; // Handle the default case if needed
    }

    return Row(
      children: [
        textHandling('DutyType : ', dutyTypeText),
      ],
    );
  }

  Widget buildAttendanceStatusRow(int status) {
    String statusText;
    Color bgColor;
    Color textColor;
    Color borderColor;

    switch (status) {
      case 0:
        statusText = 'Draft';
        bgColor = const Color(0xFFBBDEFB);      // Light Blue
        borderColor = const Color(0xFF1976D2);  // Blue Border
        textColor = const Color(0xFF0D47A1);    // Dark Blue Text
        break;

      case 1:
        statusText = 'Active';
        bgColor = const Color(0xFFA5D6A7);      // Light Green
        borderColor = const Color(0xFF43A047);  // Green Border
        textColor = const Color(0xFF1B5E20);     // Yellow Text
        break;

      case 2:
        statusText = 'Closed';
        bgColor = const Color(0xFFFFF9C4);      // Light Yellow
        borderColor = const Color(0xFFFBC02D);  // Yellow Border
        textColor = const Color(0xFFF57F17);    // Yellow Text
        break;

      case -1:
        statusText = 'Cancelled';
        bgColor = const Color(0xFFFFCDD2);      // Light Red
        borderColor = const Color(0xFFD32F2F);  // Red Border
        textColor = const Color(0xFFB71C1C);    // Dark Red
        break;

      default:
        statusText = 'Unknown';
        bgColor = const Color(0xFFE0E0E0);
        borderColor = const Color(0xFF9E9E9E);
        textColor = const Color(0xFF424242);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Status:',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: bgColor.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: borderColor, width: 0.1),
          ),
          child: Text(
            statusText,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }


  dynamic buildAttendanceShiftStatusRow(
      {required int status, bool? returnTextOnly}) {
    String statusText;

    switch (status) {
      case 0:
        statusText = 'Draft';
        break;
      case 1:
        statusText = 'Active';
        break;
      case 2:
        statusText = 'Attendance Submitted';
        break;
      case 3:
        statusText = 'Closed';
        break;
      case -1:
        statusText = 'Cancelled';
        break;
      default:
        statusText = ''; // Handle the default case if needed
    }
    if (returnTextOnly ?? false) {
      return statusText;
    }
    return Row(
      children: [
        textHandling('Status : ', statusText),
      ],
    );
  }

  dynamic buildGuardRank({required int guardRank, bool? returnTextOnly}) {
    String guardRankText;

    switch (guardRank) {
      case 0:
        guardRankText = 'Guarding Agency';
        break;
      case 1:
        guardRankText = 'Security Guard';
        break;
      case 2:
        guardRankText = 'Security Lady';
        break;
      case 3:
        guardRankText = 'Security Supervisor';
        break;
      case 4:
        guardRankText = 'Security Officer';
        break;
      case 5:
        guardRankText = 'Security Facilitator';
        break;
      case 6:
        guardRankText = 'NA';
        break;
      default:
        guardRankText = ''; // Handle the default case if needed
    }


    if (returnTextOnly ?? false) {
      return guardRankText;
    }

    return IntrinsicWidth(
      child: Row(
        children: [
          textHandling('GuardRank : ', guardRankText),
        ],
      ),
    );
  }


  dynamic buildWorkShift({required int workShift, bool? returnTextOnly}) {
    String workShiftText;

    switch (workShift) {
      case 0:
        workShiftText = 'A Shift (7AM-3PM)';
        break;
      case 1:
        workShiftText = 'B Shift (3PM-11PM)';
        break;
      case 2:
        workShiftText = 'C Shift (11PM-7AM)';
        break;
      case 3:
        workShiftText = 'G Shift (9AM-6PM)';
        break;
      default:
        workShiftText = ''; // Handle the default case if needed
    }


    if (returnTextOnly ?? false) {
      return workShiftText;
    }

    return IntrinsicWidth(
      child: Row(
        children: [
          textHandling('Work Shift : ', workShiftText),
        ],
      ),
    );
  }


  Widget dutyGuardRank({required int dutyGuardRank}) {
    String guardRankText;

    switch (dutyGuardRank) {
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
    return IntrinsicWidth(
      child: Row(
        children: [
          textHandling('Rank : ', guardRankText),
        ],
      ),
    );
  }
  Widget buildMaritalStatus(int maritalStatus) {
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
    return IntrinsicWidth(
      child: Row(
        children: [
          textHandling('MaritalStatus : ', maritalStatusText),
        ],
      ),
    );
  }

  Widget buildKeyType(int keyType) {
    String keyTypeText;

    switch (keyType) {
      case 1:
        keyTypeText = 'Normal';
        break;
      case 2:
        keyTypeText = 'Master';
        break;
      default:
        keyTypeText = ''; // Handle the default case if needed
    }
    return IntrinsicWidth(
      child: Row(
        children: [
          textHandling('Key Type : ', keyTypeText),
        ],
      ),
    );
  }

  Widget buildType(int type) {
    String typeText;

    switch (type) {
      case 0:
        typeText = 'Has Lock Change';
        break;
      case 1:
        typeText = 'Has Key Lost';
        break;
      case 2:
        typeText = 'Key Damage';
        break;
      case 3:
        typeText = 'Key Destruction';
        break;
      default:
        typeText = ''; // Handle the default case if needed
    }
    return IntrinsicWidth(
      child: Row(
        children: [
          textHandling('Type : ', typeText),
        ],
      ),
    );
  }

  Widget buildGender(int gender) {
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
    return IntrinsicWidth(
      child: Row(
        children: [
          textHandling('Gender : ', genderText),
        ],
      ),
    );
  }

  Widget buildAssetType(int assetType) {
    String assetTypeText;

    switch (assetType) {
      case 0:
        assetTypeText = 'Personal';
        break;
      case 1:
        assetTypeText = 'Company';
        break;
      default:
        assetTypeText = ''; // Handle the default case if needed
    }
    return IntrinsicWidth(
      child: Row(
        children: [
          textHandling('Asset Type : ', assetTypeText),
        ],
      ),
    );
  }

  Widget buildEventProtectionStatusRow(int status) {
    String statusText;
    Color bgColor;
    Color textColor;
    Color borderColor;

    switch (status) {
      case 0:
        statusText = 'Draft';
        bgColor =  Colors.orange.shade200;
        borderColor = const Color(0xFF9E9E9E);
        textColor = Colors.black87;
        break;

      case 1:
        statusText = 'Business User Review';
        bgColor = const Color(0xFF90CAF9);
        borderColor = const Color(0xFF42A5F5);
        textColor = Colors.white;
        break;

      case 2:
        statusText = 'LSM Review';
        bgColor = const Color(0xFFFFF59D);
        borderColor = const Color(0xFFFDD835);
        textColor = Colors.black87;
        break;

      case 3:
        statusText = 'LSM Approved';
        bgColor = const Color(0xFF4CAF50);
        borderColor = const Color(0xFF2E7D32);
        textColor = Colors.white;
        break;

      case 4:
        statusText = 'LSM Rejected';
        bgColor = const Color(0xFFFFCDD2);
        borderColor = const Color(0xFFD32F2F);
        textColor = const Color(0xFFB71C1C);
        break;

      case 5:
        statusText = 'Vendor Review';
        bgColor = const Color(0xFFB39DDB);
        borderColor = const Color(0xFF673AB7);
        textColor = Colors.white;
        break;

      case 6:
        statusText = 'Vendor Approved';
        bgColor = const Color(0xFF26A69A);
        borderColor = const Color(0xFF004D40);
        textColor = Colors.white;
        break;

      case 7:
        statusText = 'Vendor Rejected';
        bgColor = const Color(0xFFFFAB91);
        borderColor = const Color(0xFFD84315);
        textColor = Colors.white;
        break;

      case 8:
        statusText = 'Business User POC Review';
        bgColor = const Color(0xFFA5D6A7);
        borderColor = const Color(0xFF388E3C);
        textColor = Colors.white;
        break;

      case 9:
        statusText = 'Business User POC Approved';
        bgColor = const Color(0xFF2E7D32);
        borderColor = const Color(0xFF1B5E20);
        textColor = Colors.white;
        break;

      case 10:
        statusText = 'Business User POC Rejected';
        bgColor = const Color(0xFFFFCDD2);
        borderColor = const Color(0xFFD32F2F);
        textColor = Colors.white;
        break;

      case 11:
        statusText = 'Security Vendor Review';
        bgColor = const Color(0xFF80CBC4);
        borderColor = const Color(0xFF00897B);
        textColor = Colors.white;
        break;

      case 12:
        statusText = 'Security Vendor Submitted';
        bgColor = const Color(0xFF4DD0E1);
        borderColor = const Color(0xFF006064);
        textColor = Colors.white;
        break;

      case 13:
        statusText = 'EP Pre Review';
        bgColor = const Color(0xFFFFE082);
        borderColor = const Color(0xFFF9A825);
        textColor = Colors.black87;
        break;

      case 14:
        statusText = 'EP Pre Approved';
        bgColor = const Color(0xFF43A047);
        borderColor = const Color(0xFF2E7D32);
        textColor = Colors.white;
        break;

      case 15:
        statusText = 'EP Pre Rejected';
        bgColor = const Color(0xFFFFCDD2);
        borderColor = const Color(0xFFD32F2F);
        textColor = Colors.white;
        break;

      case 16:
        statusText = 'SRH Review';
        bgColor = const Color(0xFFCE93D8);
        borderColor = const Color(0xFF8E24AA);
        textColor = Colors.white;
        break;

      case 17:
        statusText = 'SRH Approved';
        bgColor = const Color(0xFF66BB6A);
        borderColor = const Color(0xFF2E7D32);
        textColor = Colors.white;
        break;

      case 18:
        statusText = 'SRH Rejected';
        bgColor = const Color(0xFFFFAB91);
        borderColor = const Color(0xFFD84315);
        textColor = Colors.white;
        break;

      case 19:
        statusText = 'EP PO Required';
        bgColor = const Color(0xFFFFF59D);
        borderColor = const Color(0xFFFBC02D);
        textColor = Colors.black87;
        break;

      case 20:
        statusText = 'PO Updated';
        bgColor = const Color(0xFF81D4FA);
        borderColor = const Color(0xFF0288D1);
        textColor = Colors.white;
        break;

      case 21:
        statusText = 'Event Started';
        bgColor = const Color(0xFF42A5F5);
        borderColor = const Color(0xFF1E88E5);
        textColor = Colors.white;
        break;

      case 22:
        statusText = 'During Event';
        bgColor = const Color(0xFF5C6BC0);
        borderColor = const Color(0xFF283593);
        textColor = Colors.white;
        break;

      case 23:
        statusText = 'Event Concluded';
        bgColor = const Color(0xFF8D6E63);
        borderColor = const Color(0xFF4E342E);
        textColor = Colors.white;
        break;

      case 24:
        statusText = 'EP Post Review';
        bgColor = const Color(0xFFFFE082);
        borderColor = const Color(0xFFF9A825);
        textColor = Colors.black87;
        break;

      case 25:
        statusText = 'EP Post Approved';
        bgColor = const Color(0xFF43A047);
        borderColor = const Color(0xFF1B5E20);
        textColor = Colors.white;
        break;

      case 26:
        statusText = 'EP Post Rejected';
        bgColor = const Color(0xFFFFCDD2);
        borderColor = const Color(0xFFD32F2F);
        textColor = Colors.white;
        break;

      case 27:
        statusText = 'Invoice Requested';
        bgColor = const Color(0xFFFFCC80);
        borderColor = const Color(0xFFEF6C00);
        textColor = Colors.black;
        break;

      case 28:
        statusText = 'Invoice Raised';
        bgColor = const Color(0xFFA1887F);
        borderColor = const Color(0xFF5D4037);
        textColor = Colors.white;
        break;

      case 29:
        statusText = 'Invoice Submitted';
        bgColor = const Color(0xFF4DB6AC);
        borderColor = const Color(0xFF004D40);
        textColor = Colors.white;
        break;

      case 30:
        statusText = 'Closed';
        bgColor = const Color(0xFF78909C);
        borderColor = const Color(0xFF455A64);
        textColor = Colors.white;
        break;

      case -1:
        statusText = 'Cancelled';
        bgColor = const Color(0xFFFFCDD2);
        borderColor = const Color(0xFFE53935);
        textColor = const Color(0xFFB71C1C);
        break;

      default:
        statusText = '';
        bgColor = const Color(0xFFE0E0E0);
        borderColor = const Color(0xFF9E9E9E);
        textColor = const Color(0xFF424242);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Status:',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: bgColor.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: borderColor, width: 0.1),
          ),
          child: Text(
            statusText,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }



  Widget buildCSRProtectionStatusRow(int status) {
    String statusText;
    Color bgColor;
    Color textColor;
    Color borderColor;

    switch (status) {
      case 0:
        statusText = 'Draft';
        bgColor =  Colors.orange.shade200;
        borderColor = const Color(0xFF9E9E9E);
        textColor = Colors.black87;
        break;

      case 1:
        statusText = 'Business User Review';
        bgColor = const Color(0xFF90CAF9);
        borderColor = const Color(0xFF42A5F5);
        textColor = Colors.white;
        break;

      case 2:
        statusText = 'LSM Review';
        bgColor = const Color(0xFFFFF59D);
        borderColor = const Color(0xFFFDD835);
        textColor = Colors.black87;
        break;

      case 3:
        statusText = 'LSM Approved';
        bgColor = const Color(0xFF4CAF50);
        borderColor = const Color(0xFF2E7D32);
        textColor = Colors.white;
        break;

      case 4:
        statusText = 'LSM Rejected';
        bgColor = const Color(0xFFFFCDD2);
        borderColor = const Color(0xFFD32F2F);
        textColor = const Color(0xFFB71C1C);
        break;

      case 5:
        statusText = 'Vendor Review';
        bgColor = const Color(0xFFB39DDB);
        borderColor = const Color(0xFF673AB7);
        textColor = Colors.white;
        break;

      case 6:
        statusText = 'Vendor Approved';
        bgColor = const Color(0xFF26A69A);
        borderColor = const Color(0xFF004D40);
        textColor = Colors.white;
        break;

      case 7:
        statusText = 'Vendor Rejected';
        bgColor = const Color(0xFFFFAB91);
        borderColor = const Color(0xFFD84315);
        textColor = Colors.white;
        break;

      case 8:
        statusText = 'Business User POC Review';
        bgColor = const Color(0xFFA5D6A7);
        borderColor = const Color(0xFF388E3C);
        textColor = Colors.white;
        break;

      case 9:
        statusText = 'Business User POC Approved';
        bgColor = const Color(0xFF2E7D32);
        borderColor = const Color(0xFF1B5E20);
        textColor = Colors.white;
        break;

      case 10:
        statusText = 'Business User POC Rejected';
        bgColor = const Color(0xFFFFCDD2);
        borderColor = const Color(0xFFD32F2F);
        textColor = Colors.white;
        break;

      case 11:
        statusText = 'Security Vendor Review';
        bgColor = const Color(0xFF80CBC4);
        borderColor = const Color(0xFF00897B);
        textColor = Colors.white;
        break;

      case 12:
        statusText = 'Security Vendor Submitted';
        bgColor = const Color(0xFF4DD0E1);
        borderColor = const Color(0xFF006064);
        textColor = Colors.white;
        break;

      case 13:
        statusText = 'EP Pre Review';
        bgColor = const Color(0xFFFFE082);
        borderColor = const Color(0xFFF9A825);
        textColor = Colors.black87;
        break;

      case 14:
        statusText = 'Before event start';
        bgColor = const Color(0xFF43A047);
        borderColor = const Color(0xFF2E7D32);
        textColor = Colors.white;
        break;

      case 15:
        statusText = 'EP Pre Rejected';
        bgColor = const Color(0xFFFFCDD2);
        borderColor = const Color(0xFFD32F2F);
        textColor = Colors.white;
        break;

      case 16:
        statusText = 'SRH Review';
        bgColor = const Color(0xFFCE93D8);
        borderColor = const Color(0xFF8E24AA);
        textColor = Colors.white;
        break;

      case 17:
        statusText = 'SRH Approved';
        bgColor = const Color(0xFF66BB6A);
        borderColor = const Color(0xFF2E7D32);
        textColor = Colors.white;
        break;

      case 18:
        statusText = 'SRH Rejected';
        bgColor = const Color(0xFFFFAB91);
        borderColor = const Color(0xFFD84315);
        textColor = Colors.white;
        break;

      case 19:
        statusText = 'EP PO Required';
        bgColor = const Color(0xFFFFF59D);
        borderColor = const Color(0xFFFBC02D);
        textColor = Colors.black87;
        break;

      case 20:
        statusText = 'PO Updated';
        bgColor = const Color(0xFF81D4FA);
        borderColor = const Color(0xFF0288D1);
        textColor = Colors.white;
        break;

      case 21:
        statusText = 'Event Started';
        bgColor = const Color(0xFF42A5F5);
        borderColor = const Color(0xFF1E88E5);
        textColor = Colors.white;
        break;

      case 22:
        statusText = 'Event Ongoing';
        bgColor = const Color(0xFF5C6BC0);
        borderColor = const Color(0xFF283593);
        textColor = Colors.white;
        break;

      case 23:
        statusText = 'Event Concluded';
        bgColor = const Color(0xFF8D6E63);
        borderColor = const Color(0xFF4E342E);
        textColor = Colors.white;
        break;

      case 24:
        statusText = 'EP Post Review';
        bgColor = const Color(0xFFFFE082);
        borderColor = const Color(0xFFF9A825);
        textColor = Colors.black87;
        break;

      case 25:
        statusText = 'EP Post Approved';
        bgColor = const Color(0xFF43A047);
        borderColor = const Color(0xFF1B5E20);
        textColor = Colors.white;
        break;

      case 26:
        statusText = 'EP Post Rejected';
        bgColor = const Color(0xFFFFCDD2);
        borderColor = const Color(0xFFD32F2F);
        textColor = Colors.white;
        break;

      case 27:
        statusText = 'Invoice Requested';
        bgColor = const Color(0xFFFFCC80);
        borderColor = const Color(0xFFEF6C00);
        textColor = Colors.black;
        break;

      case 28:
        statusText = 'Invoice Raised';
        bgColor = const Color(0xFFA1887F);
        borderColor = const Color(0xFF5D4037);
        textColor = Colors.white;
        break;

      case 29:
        statusText = 'Invoice Submitted';
        bgColor = const Color(0xFF4DB6AC);
        borderColor = const Color(0xFF004D40);
        textColor = Colors.white;
        break;

      case 30:
        statusText = 'Closed';
        bgColor = const Color(0xFF78909C);
        borderColor = const Color(0xFF455A64);
        textColor = Colors.white;
        break;

      case -1:
        statusText = 'Cancelled';
        bgColor = const Color(0xFFFFCDD2);
        borderColor = const Color(0xFFE53935);
        textColor = const Color(0xFFB71C1C);
        break;

      default:
        statusText = '';
        bgColor = const Color(0xFFE0E0E0);
        borderColor = const Color(0xFF9E9E9E);
        textColor = const Color(0xFF424242);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Status:',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: bgColor.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: borderColor, width: 0.1),
          ),
          child: Text(
            statusText,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }


  // Widget buildPassManagementStatusRow(int status) {
  //   String statusText = buildPassManagementStatus(status);
  //   return IntrinsicWidth(
  //     child: Row(
  //       children: [
  //         textHandling('Status: ', statusText),
  //       ],
  //     ),
  //   );
  // }

  Widget buildPassManagementStatusRow(int? status) {
    String statusText;
    Color bgColor;
    Color textColor;
    Color borderColor;
    switch (status) {
      case 0:
        statusText = 'Created';
        bgColor = const Color(0xFFE3F2FD);      // Light Blue
        borderColor = const Color(0xFF1976D2);  // Blue Border
        textColor = const Color(0xFF0D47A1);    // Dark Blue
        break;

      case 1:
        statusText = 'Handed Over';
        bgColor = const Color(0xFFA5D6A7);      // Light Green
        borderColor = const Color(0xFF43A047);  // Green Border
        textColor = const Color(0xFF1B5E20);    // Dark Green
        break;

      case 2:
        statusText = 'Returned';
        bgColor = const Color(0xFF00838F);      // Light Cyan
        borderColor = const Color(0xFF00838F);  // Cyan Border
        textColor =  Colors.white;    // Dark Teal
        break;

      case 3:
        statusText = 'Non Returned';
        bgColor = const Color(0xFFFFF3E0);      // Light Orange
        borderColor = const Color(0xFFF57C00);  // Orange Border
        textColor = const Color(0xFFE65100);    // Dark Orange
        break;

      case 4:
        statusText = 'Lost';
        bgColor = const Color(0xFFFFEBEE);      // Light Red
        borderColor = const Color(0xFFD32F2F);  // Red Border
        textColor = const Color(0xFFB71C1C);    // Dark Red
        break;

      // case 5:
      //   statusText = 'Damaged/De-Activated';
      //   bgColor = const Color(0xFFFFF3E0);      // Light Orange
      //   borderColor = const Color(0xFFFB8C00);  // Deep Orange Border
      //   textColor = const Color(0xFFE65100);    // Dark Orange
      //   break;
      //
      // case 6:
      //   statusText = 'Defaced/De-Activated';
      //   bgColor = const Color(0xFFEFEBE9);      // Light Brown
      //   borderColor = const Color(0xFF8D6E63);  // Brown Border
      //   textColor = const Color(0xFF5D4037);    // Dark Brown
      //   break;

      case 7:
        statusText = 'Cancelled';
        bgColor = const Color(0xFFFFCDD2);      // Light Red
        borderColor = const Color(0xFFD32F2F);  // Red Border
        textColor = const Color(0xFFB71C1C);    // Dark Red
        break;

      case 8:
        statusText = 'Returned/Damaged';
        bgColor = const Color(0xFFE1F5FE);      // Light Sky Blue
        borderColor = const Color(0xFF0288D1);  // Blue Border
        textColor = const Color(0xFF01579B);    // Dark Blue
        break;

      case 9:
        statusText = 'Returned/Defaced';
        bgColor = const Color(0xFFE0F2F1);      // Light Teal
        borderColor = const Color(0xFF00796B);  // Teal Border
        textColor = const Color(0xFF004D40);    // Dark Teal
        break;

      case -1:
        statusText = 'Record Cancelled';
        bgColor = const Color(0xFFFFEBEE);      // Light Red
        borderColor = const Color(0xFFC62828);  // Strong Red Border
        textColor = const Color(0xFFB71C1C);    // Dark Red
        break;

      default:
        statusText = '';
        bgColor = const Color(0xFFFFFFFF);
        borderColor = const Color(0xFF000000);
        textColor = const Color(0xFF000000);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Status:',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: bgColor.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: borderColor, width: 0.1),
          ),
          child: Text(
            statusText,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );  }

  Widget passManagementPassTypeRow(int passType) {
    String passTypeText;

    switch (passType) {
      case 0:
        passTypeText = 'Day Pass';
        break;
      case 1:
        passTypeText = 'Visitor Pass';
        break;
      case 2:
        passTypeText = 'Vendor Pass';
        break;
      case 3:
        passTypeText = 'SEZ Pass';
        break;
      case 4:
        passTypeText = 'DWS Day Pass';
        break;
      case 5:
        passTypeText = 'DWS Visitor Pass';
        break;
      case 6:
        passTypeText = 'DWS Vendor Pass';
        break;
      default:
        passTypeText = ''; // Handle the default case if needed
    }
    return IntrinsicWidth(
      child: Row(
        children: [
          textHandling('PassType : ', passTypeText),
        ],
      ),
    );
  }


  Widget buildOccurrenceStatus(int status) {
    String statusText;
    Color bgColor;
    Color textColor;
    Color borderColor;

    switch (status) {
      case 0:
        statusText = 'Created';
        bgColor = const Color(0xFFBBDEFB);      // Light Blue
        borderColor = const Color(0xFF1976D2);  // Blue Border
        textColor = const Color(0xFF0D47A1);    // Dark Blue Text
        break;

      case 1:
        statusText = 'Submitted';
        bgColor = const Color(0xFFA5D6A7);      // Light Green
        borderColor = const Color(0xFF43A047);  // Green Border
        textColor = const Color(0xFF1B5E20);     // Yellow Text
        break;

      case -1:
        statusText = 'Cancelled';
        bgColor = const Color(0xFFFFCDD2);      // Light Red
        borderColor = const Color(0xFFD32F2F);  // Red Border
        textColor = const Color(0xFFB71C1C);    // Dark Red
        break;

      default:
        statusText = 'Unknown';
        bgColor = const Color(0xFFE0E0E0);
        borderColor = const Color(0xFF9E9E9E);
        textColor = const Color(0xFF424242);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Status:',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: bgColor.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: borderColor, width: 0.1),
          ),
          child: Text(
            statusText,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }

  //
  // Widget keyLossDestructionStatus(int status) {
  //   String statusText;
  //
  //   switch (status) {
  //     case 0:
  //       statusText = 'Created';
  //       break;
  //     case 1:
  //       statusText = 'Lock Change Initiated';
  //       break;
  //     case 2:
  //       statusText = 'Lost Initiated';
  //       break;
  //     case 3:
  //       statusText = 'Damaged Initiated';
  //       break;
  //     case 4:
  //       statusText = 'Lost Approved';
  //       break;
  //     case 5:
  //       statusText = 'Damaged Approved';
  //       break;
  //     case 6:
  //       statusText = 'Investigation Initiated';
  //       break;
  //     case 7:
  //       statusText = 'Destroy Initiated';
  //       break;
  //     case 8:
  //       statusText = 'Destroy Rejected';
  //       break;
  //     case 9:
  //       statusText = 'Destroy Approved';
  //       break;
  //     case 10:
  //       statusText = 'Closed';
  //       break;
  //     case 11:
  //       statusText = 'Cancelled';
  //       break;
  //     default:
  //       statusText = ''; // Handle the default case if needed
  //   }
  //   return IntrinsicWidth(
  //     child: Row(
  //       children: [
  //         textHandling('Status : ', statusText),
  //       ],
  //     ),
  //   );
  // }


  Widget keyLossDestructionStatus(int? status) {
    String statusText;
    Color bgColor;
    Color textColor;
    Color borderColor;
    switch (status) {
      case 0:
        statusText = 'Created';
        bgColor = const Color(0xFFE3F2FD);      // Light Blue
        borderColor = const Color(0xFF1976D2);  // Blue Border
        textColor = const Color(0xFF0D47A1);    // Dark Blue
        break;

      case 1:
        statusText = 'Lock Change Initiated';
        bgColor = const Color(0xFFA5D6A7);      // Light Green
        borderColor = const Color(0xFF43A047);  // Green Border
        textColor = const Color(0xFF1B5E20);    // Dark Green
        break;

      case 2:
        statusText = 'Lost Initiated';
        bgColor = const Color(0xFF00838F);      // Light Cyan
        borderColor = const Color(0xFF00838F);  // Cyan Border
        textColor =  Colors.white;    // Dark Teal
        break;

      case 3:
        statusText = 'Damaged Initiated';
        bgColor = const Color(0xFFFFF3E0);      // Light Orange
        borderColor = const Color(0xFFF57C00);  // Orange Border
        textColor = const Color(0xFFE65100);    // Dark Orange
        break;

      case 4:
        statusText = 'Lost Approved';
        bgColor = const Color(0xFFFFEBEE);      // Light Red
        borderColor = const Color(0xFFD32F2F);  // Red Border
        textColor = const Color(0xFFB71C1C);    // Dark Red
        break;

    case 5:
      statusText = 'Damaged Approved';
      bgColor = const Color(0xFFFFF3E0);      // Light Orange
      borderColor = const Color(0xFFFB8C00);  // Deep Orange Border
      textColor = const Color(0xFFE65100);    // Dark Orange
      break;

    case 6:
      statusText = 'Investigation Initiated';
      bgColor = const Color(0xFFEFEBE9);      // Light Brown
      borderColor = const Color(0xFF8D6E63);  // Brown Border
      textColor = const Color(0xFF5D4037);    // Dark Brown
      break;

      case 7:
        statusText = 'Destroy Initiated';
        bgColor = const Color(0xFFFFCDD2);      // Light Red
        borderColor = const Color(0xFFD32F2F);  // Red Border
        textColor = const Color(0xFFB71C1C);    // Dark Red
        break;

      case 8:
        statusText = 'Destroy Rejected';
        bgColor = const Color(0xFFE1F5FE);      // Light Sky Blue
        borderColor = const Color(0xFF0288D1);  // Blue Border
        textColor = const Color(0xFF01579B);    // Dark Blue
        break;

      case 9:
        statusText = 'Destroy Approved';
        bgColor = const Color(0xFFE0F2F1);      // Light Teal
        borderColor = const Color(0xFF00796B);  // Teal Border
        textColor = const Color(0xFF004D40);    // Dark Teal
        break;

      case 10:
        statusText = 'Closed';
        bgColor = const Color(0xFFF0F4C3);      // Light Lime
        borderColor = const Color(0xFF9E9D24);  // Lime Border
        textColor = const Color(0xFF827717);    // Dark Teal
        break;
      case -1:
        statusText = 'Record Cancelled';
        bgColor = const Color(0xFFFFEBEE);      // Light Red
        borderColor = const Color(0xFFC62828);  // Strong Red Border
        textColor = const Color(0xFFB71C1C);    // Dark Red
        break;

      default:
        statusText = '';
        bgColor = const Color(0xFFFFFFFF);
        borderColor = const Color(0xFF000000);
        textColor = const Color(0xFF000000);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Status:',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: bgColor.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: borderColor, width: 0.1),
          ),
          child: Text(
            statusText,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );  }

  //
  // Widget keyManagementStatus(int status) {
  //   String statusText;
  //
  //   switch (status) {
  //     case -1:
  //       statusText = 'Cancelled';
  //       break;
  //     case 0:
  //       statusText = 'Draft';
  //       break;
  //     case 1:
  //       statusText = 'Open';
  //       break;
  //     case 2:
  //       statusText = 'Closed';
  //       break;
  //     default:
  //       statusText = ''; // Handle the default case if needed
  //   }
  //   return IntrinsicWidth(
  //     child: Row(
  //       children: [
  //         textHandling('Status : ', statusText),
  //       ],
  //     ),
  //   );
  // }



  Widget keyManagementStatus(int status) {
    String statusText;
    Color bgColor;
    Color textColor;
    Color borderColor;

    switch (status) {
      case 0:
        statusText = 'Draft';
        bgColor = const Color(0xFFBBDEFB);      // Light Blue
        borderColor = const Color(0xFF1976D2);  // Blue Border
        textColor = const Color(0xFF0D47A1);    // Dark Blue Text
        break;

      case 1:
        statusText = 'Open';
        bgColor = const Color(0xFFA5D6A7);      // Light Green
        borderColor = const Color(0xFF43A047);  // Green Border
        textColor = const Color(0xFF1B5E20);     // Yellow Text
        break;

      case 2:
        statusText = 'Closed';
        bgColor = const Color(0xFFFFD180);
        borderColor = const Color(0xFFF57C00);
        textColor = const Color(0xFF4E342E);    // Yellow Text
        break;

      case -1:
        statusText = 'Cancelled';
        bgColor = const Color(0xFFFFCDD2);      // Light Red
        borderColor = const Color(0xFFD32F2F);  // Red Border
        textColor = const Color(0xFFB71C1C);    // Dark Red
        break;

      default:
        statusText = 'Unknown';
        bgColor = const Color(0xFFE0E0E0);
        borderColor = const Color(0xFF9E9E9E);
        textColor = const Color(0xFF424242);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Status:',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: bgColor.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: borderColor, width: 0.1),
          ),
          child: Text(
            statusText,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }

  // Widget keyManagementIssuanceStatus(int status) {
  //   String statusText;
  //
  //   switch (status) {
  //     case -1:
  //       statusText = 'Cancelled';
  //       break;
  //     case 0:
  //       statusText = 'Draft';
  //       break;
  //     case 1:
  //       statusText = 'Handed Over';
  //       break;
  //     case 2:
  //       statusText = 'Not Returned';
  //       break;
  //     case 3:
  //       statusText = 'Closed/Damaged';
  //       break;
  //     case 4:
  //       statusText = 'Closed/Lost';
  //       break;
  //     case 5:
  //       statusText = 'Lost/Not Returned';
  //       break;
  //     case 6:
  //       statusText = 'Closed/Lost/Not Returned';
  //       break;
  //     case 7:
  //       statusText = 'Closed/Lost/Damaged';
  //       break;
  //     case 8:
  //       statusText = 'Lost/Damaged';
  //       break;
  //     case 9:
  //       statusText = 'Lost/Damaged/Not Returned';
  //       break;
  //     case 10:
  //       statusText = 'Closed/Lost/Damaged/Not Returned';
  //       break;
  //     case 11:
  //       statusText = 'Damaged/Not Returned';
  //       break;
  //     case 12:
  //       statusText = 'Closed';
  //       break;
  //     default:
  //       statusText = '';
  //   }
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Flexible(
  //         child: textHandling('Status : ', statusText),
  //       ),
  //     ],
  //   );
  // }





  Widget keyManagementIssuanceStatus(int? status) {
    String statusText;
    Color bgColor;
    Color textColor;
    Color borderColor;
    switch (status) {
      case 0:
        statusText = 'Draft';
        bgColor = const Color(0xFFE3F2FD);      // Light Blue
        borderColor = const Color(0xFF1976D2);  // Blue Border
        textColor = const Color(0xFF0D47A1);    // Dark Blue
        break;

      case 1:
        statusText = 'Handed Over';
        bgColor = const Color(0xFFA5D6A7);      // Light Green
        borderColor = const Color(0xFF43A047);  // Green Border
        textColor = const Color(0xFF1B5E20);    // Dark Green
        break;

      case 2:
        statusText = 'Not Returned';
        bgColor = const Color(0xFF00838F);      // Light Cyan
        borderColor = const Color(0xFF00838F);  // Cyan Border
        textColor =  Colors.white;    // Dark Teal
        break;

      case 3:
        statusText = 'Closed/Damaged';
        bgColor = const Color(0xFFFFF3E0);      // Light Orange
        borderColor = const Color(0xFFF57C00);  // Orange Border
        textColor = const Color(0xFFE65100);    // Dark Orange
        break;

      case 4:
        statusText = 'Closed/Lost';
        bgColor = const Color(0xFFFFEBEE);      // Light Red
        borderColor = const Color(0xFFD32F2F);  // Red Border
        textColor = const Color(0xFFB71C1C);    // Dark Red
        break;

    case 5:
      statusText = 'Lost/Not Returned';
      bgColor = const Color(0xFFFFF3E0);      // Light Orange
      borderColor = const Color(0xFFFB8C00);  // Deep Orange Border
      textColor = const Color(0xFFE65100);    // Dark Orange
      break;

    case 6:
      statusText = 'Closed/Lost/Not Returned';
      bgColor = const Color(0xFFEFEBE9);      // Light Brown
      borderColor = const Color(0xFF8D6E63);  // Brown Border
      textColor = const Color(0xFF5D4037);    // Dark Brown
      break;

      case 7:
        statusText = 'Closed/Lost/Damaged';
        bgColor = const Color(0xFFFFCDD2);      // Light Red
        borderColor = const Color(0xFFD32F2F);  // Red Border
        textColor = const Color(0xFFB71C1C);    // Dark Red
        break;

      case 8:
        statusText = 'Lost/Damaged';
        bgColor = const Color(0xFFE1F5FE);      // Light Sky Blue
        borderColor = const Color(0xFF0288D1);  // Blue Border
        textColor = const Color(0xFF01579B);    // Dark Blue
        break;

      case 9:
        statusText = 'Lost/Damaged/Not Returned';
        bgColor = const Color(0xFFE0F2F1);      // Light Teal
        borderColor = const Color(0xFF00796B);  // Teal Border
        textColor = const Color(0xFF004D40);    // Dark Teal
        break;
      case 10:
        statusText = ' Closed/Lost/Damaged/Not Returned';
        bgColor = const Color(0xFF8D6E63);
        borderColor = const Color(0xFF4E342E);
        textColor = Colors.white;    // Dark Teal
        break;
      case 11:
        statusText = 'Damaged/Not Returned';
        bgColor = const Color(0xFFFFCDD2);
        borderColor = const Color(0xFFD32F2F);
        textColor = Colors.white;   // Dark Teal
        break;
      case 12:
        statusText = 'Closed';
        bgColor = const Color(0xFFF0F4C3);      // Light Lime
        borderColor = const Color(0xFF9E9D24);  // Lime Border
        textColor = const Color(0xFF827717);      // Dark Teal
        break;
      case -1:
        statusText = 'Cancelled';
        bgColor = const Color(0xFFFFEBEE);      // Light Red
        borderColor = const Color(0xFFC62828);  // Strong Red Border
        textColor = const Color(0xFFB71C1C);    // Dark Red
        break;

      default:
        statusText = '';
        bgColor = const Color(0xFFFFFFFF);
        borderColor = const Color(0xFF000000);
        textColor = const Color(0xFF000000);
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Status:',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 8),

        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: bgColor.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: borderColor, width: 0.1),
            ),
            child: Text(
              statusText,
              softWrap: true,
              overflow: TextOverflow.visible,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ),
        ),
      ],
    );
    }

  Widget keyManagementMasterHistoryStatus(int status) {
    String statusText;

    switch (status) {
      case 0:
        statusText = 'Created';
        break;
      case 1:
        statusText = 'Lock Changed Initiated';
        break;
      case 2:
        statusText = 'Lost Initiated';
        break;
      case 3:
        statusText = 'Damaged Initiated';
        break;
      case 4:
        statusText = 'Lost Approved';
        break;
      case 5:
        statusText = 'Damaged Approved';
        break;
      case 6:
        statusText = 'Investigation Initiated';
        break;
      case 7:
        statusText = 'Destroy Initiated';
        break;
      case 8:
        statusText = 'Destroy Rejected';
        break;
      case 9:
        statusText = 'Destroy Approved';
        break;
      case 10:
        statusText = 'Closed';
        break;
      case 11:
        statusText = 'Cancelled';
        break;
      default:
        statusText = ''; // Handle the default case if needed
    }
    return IntrinsicWidth(
      child: Row(
        children: [
          textHandling('Status : ', statusText),
        ],
      ),
    );
  }

  Widget buildIncidentStatus(int status) {
    String statusText;
    Color bgColor;
    Color textColor;
    Color borderColor;

    switch (status) {
      case 0:
        statusText = 'Created';
        bgColor =  Colors.greenAccent.shade100;
        borderColor = const Color(0xFF9E9E9E);
        textColor = const Color(0xFF424242);
        break;

      case 1:
        statusText = 'Complainant Review';
        bgColor = const Color(0xFFBBDEFB);
        borderColor = const Color(0xFF1976D2);
        textColor = const Color(0xFF0D47A1);
        break;

      case 2:
        statusText = 'IM Pre Review';
        bgColor = const Color(0xFFFFF9C4);
        borderColor = const Color(0xFFFBC02D);
        textColor = const Color(0xFF6D4C41);
        break;

      case 3:
        statusText = 'IM Pre Reject';
        bgColor = const Color(0xFFFFCDD2);
        borderColor = const Color(0xFFD32F2F);
        textColor = const Color(0xFFB71C1C);
        break;

      case 4:
        statusText = 'IM Pre Approve';
        bgColor = const Color(0xFFC8E6C9);
        borderColor = const Color(0xFF388E3C);
        textColor = const Color(0xFF1B5E20);
        break;

      case 5:
        statusText = 'IO Role Review';
        bgColor = const Color(0xFFE1BEE7);
        borderColor = const Color(0xFF8E24AA);
        textColor = const Color(0xFF4A148C);
        break;

      case 6:
        statusText = 'IO Role Reject';
        bgColor = const Color(0xFFFFEBEE);
        borderColor = const Color(0xFFC62828);
        textColor = const Color(0xFF8E0000);
        break;

      case 7:
        statusText = 'IO Role Approve';
        bgColor = const Color(0xFFD0F8CE);
        borderColor = const Color(0xFF43A047);
        textColor = const Color(0xFF1B5E20);
        break;

      case 8:
        statusText = 'Investigation';
        bgColor = const Color(0xFFE0F7FA);
        borderColor = const Color(0xFF0097A7);
        textColor = const Color(0xFF006064);
        break;

      case 9:
        statusText = 'Pass';
        bgColor = const Color(0xFFFFF3E0);
        borderColor = const Color(0xFFFF9800);
        textColor = const Color(0xFFEF6C00);
        break;

      case 10:
        statusText = 'Pass Review';
        bgColor = const Color(0xFFEDE7F6);
        borderColor = const Color(0xFF673AB7);
        textColor = const Color(0xFF4527A0);
        break;

      case 11:
        statusText = 'Pass Reject';
        bgColor = const Color(0xFFFFCDD2);
        borderColor = const Color(0xFFD32F2F);
        textColor = const Color(0xFF8E0000);
        break;

      case 12:
        statusText = 'Pass Approve';
        bgColor = const Color(0xFFC8E6C9);
        borderColor = const Color(0xFF2E7D32);
        textColor = const Color(0xFF1B5E20);
        break;

      case 13:
        statusText = 'RCA';
        bgColor = const Color(0xFFFFECB3);
        borderColor = const Color(0xFFFFB300);
        textColor = const Color(0xFF6D4C41);
        break;

      case 14:
        statusText = 'RCA Review';
        bgColor = const Color(0xFFE1F5FE);
        borderColor = const Color(0xFF0277BD);
        textColor = const Color(0xFF01579B);
        break;

      case 15:
        statusText = 'RCA Reject';
        bgColor = const Color(0xFFFFCDD2);
        borderColor = const Color(0xFFC62828);
        textColor = const Color(0xFF8E0000);
        break;

      case 16:
        statusText = 'RCA Approve';
        bgColor = const Color(0xFFA5D6A7);
        borderColor = const Color(0xFF43A047);
        textColor = const Color(0xFF1B5E20);
        break;

      case 17:
        statusText = 'RCA System Review';
        bgColor = const Color(0xFFD1C4E9);
        borderColor = const Color(0xFF512DA8);
        textColor = const Color(0xFF311B92);
        break;

      case 18:
        statusText = 'RCA System Reject';
        bgColor = const Color(0xFFFFCDD2);
        borderColor = const Color(0xFFD32F2F);
        textColor = const Color(0xFF8E0000);
        break;

      case 19:
        statusText = 'RCA System Approve';
        bgColor = const Color(0xFFC5E1A5);
        borderColor = const Color(0xFF558B2F);
        textColor = const Color(0xFF33691E);
        break;

      case 20:
        statusText = 'Data Loss';
        bgColor = const Color(0xFFFFD180);
        borderColor = const Color(0xFFF57C00);
        textColor = const Color(0xFF4E342E);
        break;

      case 21:
        statusText = 'Data Loss Review';
        bgColor = const Color(0xFFFFF59D);
        borderColor = const Color(0xFFFBC02D);
        textColor = const Color(0xFF6D4C41);
        break;

      case 22:
        statusText = 'Data Loss Reject';
        bgColor = const Color(0xFFFFCDD2);
        borderColor = const Color(0xFFD32F2F);
        textColor = const Color(0xFF8E0000);
        break;

      case 23:
        statusText = 'Data Loss Approve';
        bgColor = const Color(0xFFC8E6C9);
        borderColor = const Color(0xFF388E3C);
        textColor = const Color(0xFF1B5E20);
        break;

      case 24:
        statusText = 'Further Investigation';
        bgColor = const Color(0xFFE0F2F1);
        borderColor = const Color(0xFF00897B);
        textColor = const Color(0xFF004D40);
        break;

      case 25:
        statusText = 'RCA Action Plan';
        bgColor = const Color(0xFFE3F2FD);
        borderColor = const Color(0xFF1E88E5);
        textColor = const Color(0xFF0D47A1);
        break;

      case 26:
        statusText = 'RCA Action Plan Review';
        bgColor = const Color(0xFFFFF9C4);
        borderColor = const Color(0xFFFBC02D);
        textColor = const Color(0xFF6D4C41);
        break;

      case 27:
        statusText = 'RCA Action Plan Reject';
        bgColor = const Color(0xFFFFCDD2);
        borderColor = const Color(0xFFD32F2F);
        textColor = const Color(0xFF8E0000);
        break;

      case 28:
        statusText = 'RCA Action Plan Approve';
        bgColor = const Color(0xFFA5D6A7);
        borderColor = const Color(0xFF2E7D32);
        textColor = const Color(0xFF1B5E20);
        break;

      case 29:
        statusText = 'IO Review';
        bgColor = const Color(0xFFEDE7F6);
        borderColor = const Color(0xFF5E35B1);
        textColor = const Color(0xFF311B92);
        break;

      case 30:
        statusText = 'IO Reject';
        bgColor = const Color(0xFFFFCDD2);
        borderColor = const Color(0xFFC62828);
        textColor = const Color(0xFF8E0000);
        break;

      case 31:
        statusText = 'IO Approve';
        bgColor = const Color(0xFFC8E6C9);
        borderColor = const Color(0xFF2E7D32);
        textColor = const Color(0xFF1B5E20);
        break;

      case 32:
        statusText = 'FTE CWR Involved';
        bgColor = const Color(0xFFE0F7FA);
        borderColor = const Color(0xFF00ACC1);
        textColor = const Color(0xFF006064);
        break;

      case 33:
        statusText = 'IM Final Review';
        bgColor = const Color(0xFFAED581);
        borderColor = const Color(0xFF558B2F);
        textColor = const Color(0xFF33691E);
        break;

      case 34:
        statusText = 'Read Across';
        bgColor = const Color(0xFFFFF3E0);
        borderColor = const Color(0xFFFFA726);
        textColor = const Color(0xFF6D4C41);
        break;

      case 35:
        statusText = 'Read Across Review';
        bgColor = const Color(0xFFE1F5FE);
        borderColor = const Color(0xFF039BE5);
        textColor = const Color(0xFF01579B);
        break;

      case 36:
        statusText = 'Read Across Reject';
        bgColor = const Color(0xFFFFCDD2);
        borderColor = const Color(0xFFD32F2F);
        textColor = const Color(0xFF8E0000);
        break;

      case 37:
        statusText = 'Read Across Approve';
        bgColor = const Color(0xFFA5D6A7);
        borderColor = const Color(0xFF43A047);
        textColor = const Color(0xFF1B5E20);
        break;

      case 38:
        statusText = 'Investigation Done';
        bgColor = const Color(0xFFD1C4E9);
        borderColor = const Color(0xFF512DA8);
        textColor = const Color(0xFF311B92);
        break;

      case 39:
        statusText = 'Closed';
        bgColor = const Color(0xFFBDBDBD);
        borderColor = const Color(0xFF616161);
        textColor = const Color(0xFF212121);
        break;

      case 40:
      case -1:
        statusText = 'Cancelled';
        bgColor = const Color(0xFFFFCDD2);
        borderColor = const Color(0xFFD32F2F);
        textColor = const Color(0xFFB71C1C);
        break;

      default:
        statusText = 'Unknown';
        bgColor = const Color(0xFFE0E0E0);
        borderColor = const Color(0xFF9E9E9E);
        textColor = const Color(0xFF424242);
    }

    return Row(
      children: [
        const Text(
          'Status:',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: bgColor.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: borderColor, width: 0.6),
          ),
          child: Text(
            statusText,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }


  // dynamic buildSLAViolationStatus(int status, {bool? returnTextOnly}) {
  //   String statusText;
  //
  //   switch (status) {
  //     case 0:
  //       statusText = 'Draft';
  //       break;
  //     case 1:
  //       statusText = 'Active';
  //       break;
  //     case 2:
  //       statusText = 'Finalized';
  //       break;
  //     case -1:
  //       statusText = 'Cancelled';
  //       break;
  //     default:
  //       statusText = ''; // Handle the default case if needed
  //   }
  //
  //   if (returnTextOnly ?? false) {
  //     return statusText;
  //   }
  //
  //   return IntrinsicWidth(
  //     child: Row(
  //       children: [
  //         textHandling('Status : ', statusText),
  //       ],
  //     ),
  //   );
  //
  // }


  dynamic buildSLAViolationStatus(int status, {bool? returnTextOnly}) {
    String statusText;
    Color bgColor;
    Color textColor;
    Color borderColor;

    switch (status) {
      case 0:
        statusText = 'Draft';
        bgColor = const Color(0xFFBBDEFB);      // Light Blue
        borderColor = const Color(0xFF1976D2);  // Blue Border
        textColor = const Color(0xFF0D47A1);    // Dark Blue Text
        break;

      case 1:
        statusText = 'Active';
        bgColor = const Color(0xFFA5D6A7);      // Light Green
        borderColor = const Color(0xFF43A047);  // Green Border
        textColor = const Color(0xFF1B5E20);     // Yellow Text
        break;


      case 2:
        statusText = 'Finalized';
        bgColor = const Color(0xFFE1BEE7);      // Light Purple
        borderColor = const Color(0xFF8E24AA);  // Purple Border
        textColor = const Color(0xFF4A148C);     // Yellow Text
        break;

      case -1:
        statusText = 'Cancelled';
        bgColor = const Color(0xFFFFCDD2);      // Light Red
        borderColor = const Color(0xFFD32F2F);  // Red Border
        textColor = const Color(0xFFB71C1C);    // Dark Red
        break;

      default:
        statusText = 'Unknown';
        bgColor = const Color(0xFFE0E0E0);
        borderColor = const Color(0xFF9E9E9E);
        textColor = const Color(0xFF424242);
    }

    if (returnTextOnly ?? false) {
      return statusText;
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Status:',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: bgColor.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: borderColor, width: 0.1),
          ),
          child: Text(
            statusText,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }


  dynamic buildTransportMedicalStatus(int status, {bool? returnTextOnly}) {
    String statusText;
    Color bgColor;
    Color textColor;
    Color borderColor;

    switch (status) {
      case 0:
        statusText = 'Crated';
        bgColor = const Color(0xFFBBDEFB);      // Light Blue
        borderColor = const Color(0xFF1976D2);  // Blue Border
        textColor = const Color(0xFF0D47A1);    // Dark Blue Text
        break;

      case 1:
        statusText = 'Open';
        bgColor = const Color(0xFFA5D6A7);      // Light Green
        borderColor = const Color(0xFF43A047);  // Green Border
        textColor = const Color(0xFF1B5E20);     // Yellow Text
        break;


      case 2:
        statusText = 'Closed';
        bgColor = const Color(0xFFE1BEE7);      // Light Purple
        borderColor = const Color(0xFF8E24AA);  // Purple Border
        textColor = const Color(0xFF4A148C);     // Yellow Text
        break;

      case -1:
        statusText = 'Cancelled';
        bgColor = const Color(0xFFFFCDD2);      // Light Red
        borderColor = const Color(0xFFD32F2F);  // Red Border
        textColor = const Color(0xFFB71C1C);    // Dark Red
        break;

      default:
        statusText = 'Unknown';
        bgColor = const Color(0xFFE0E0E0);
        borderColor = const Color(0xFF9E9E9E);
        textColor = const Color(0xFF424242);
    }

    if (returnTextOnly ?? false) {
      return statusText;
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Status:',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: bgColor.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: borderColor, width: 0.1),
          ),
          child: Text(
            statusText,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }


  dynamic buildLSMStatus(int status, {bool? returnTextOnly}) {
    String statusText;

    switch (status) {
      case 1:
        statusText = 'Draft';
        break;
      case 2:
        statusText = 'Submitted';
        break;
      case 3:
        statusText = 'Distributed';
        break;
      case 4:
        statusText = 'Closed';
        break;
      case -1:
        statusText = 'Cancelled';
        break;
      default:
        statusText = ''; // Handle the default case if needed
    }

    if (returnTextOnly ?? false) {
      return statusText;
    }

    return IntrinsicWidth(
      child: Row(
        children: [
          textHandling('Status : ', statusText),
        ],
      ),
    );
  }

  dynamic buildWarning(int status, {bool? returnTextOnly}) {
    String statusText;

    switch (status) {
      case 0:
        statusText = 'Red';
        break;
      case 1:
        statusText = 'Orange';
        break;
      case 2:
        statusText = 'Yellow';
        break;
      case 3:
        statusText = 'Green';
        break;
      default:
        statusText = ''; // Handle the default case if needed
    }

    if (returnTextOnly ?? false) {
      return statusText;
    }

    return IntrinsicWidth(
      child: Row(
        children: [
          textHandling('Warning/Alert : ', statusText),
        ],
      ),
    );
  }


  dynamic buildForecastType(int status, {bool? returnTextOnly}) {
    String statusText;

    switch (status) {
      case 0:
        statusText = 'Next Day';
        break;
      case 1:
        statusText = 'Next Week';
        break;
      default:
        statusText = ''; // Handle the default case if needed
    }

    if (returnTextOnly ?? false) {
      return statusText;
    }

    return IntrinsicWidth(
      child: Row(
        children: [
          textHandling('Forecast Type : ', statusText),
        ],
      ),
    );
  }

  Color getStatusColor(int status) {
    switch (status) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.orange;
      case 2:
        return Colors.yellow;
      case 3:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }


  Widget leoVisit(bool status) {
    String statusText;
    switch (status) {
      case true:
        statusText = 'Yes';
        break;
      default:
        statusText = 'No'; // Handle the default case if needed
    }
    return IntrinsicWidth(
      child: Row(
        children: [
          textHandling('LEO Visit : ', statusText),
        ],
      ),
    );
  }

  Widget materialMovement(bool status) {
    String statusText;
    switch (status) {
      case true:
        statusText = 'Yes';
        break;
      default:
        statusText = 'No'; // Handle the default case if needed
    }
    return IntrinsicWidth(
      child: Row(
        children: [
          textHandling('Material Movement : ', statusText),
        ],
      ),
    );
  }

  Widget shiftBrfngAttnded(bool status) {
    String statusText;
    switch (status) {
      case true:
        statusText = 'Yes';
        break;
      default:
        statusText = 'No'; // Handle the default case if needed
    }
    return IntrinsicWidth(
      child: Row(
        children: [
          textHandling('Shift Briefing Attended : ', statusText),
        ],
      ),
    );
  }

  Widget incidentType(int incidentType) {
    String incidentTypeText;
    switch (incidentType) {
      case 0:
        incidentTypeText = 'Loss';
        break;
      case 1:
        incidentTypeText = 'Damage';
        break;
      case 2:
        incidentTypeText = 'Workplace Violence';
        break;
      case 3:
        incidentTypeText = 'Negligence';
        break;
      case 4:
        incidentTypeText = 'General';
        break;
      default:
        incidentTypeText = ''; // Handle the default case if needed
    }
    return IntrinsicWidth(
      child: Row(
        children: [
          textHandling('Incident Type : ', incidentTypeText),
        ],
      ),
    );
  }


  Widget transportIncidentType(int incidentType) {
    String incidentTypeText;
    switch (incidentType) {
      case 1:
        incidentTypeText = 'Medical Emergency';
        break;
      case 0:
        incidentTypeText = 'Transport';
        break;
      default:
        incidentTypeText = ''; // Handle the default case if needed
    }
    return IntrinsicWidth(
      child: Row(
        children: [
          textHandling('Incident Type : ', incidentTypeText),
        ],
      ),
    );
  }
  Widget passCategory(int category) {
    String categoryTypeText;
    switch (category) {
      case 0:
        categoryTypeText = 'Loss';
        break;
      case 1:
        categoryTypeText = 'Damage';
        break;
      default:
        categoryTypeText = ''; // Handle the default case if needed
    }
    return IntrinsicWidth(
      child: Row(
        children: [
          textHandling('Pass Category : ', categoryTypeText),
        ],
      ),
    );
  }

  dynamic contactDetailsStatus(int status, {bool? returnTextOnly}) {
    String statusText;
    Color bgColor;
    Color textColor;
    Color borderColor;

    switch (status) {
      case 0:
        statusText = 'Draft';
        bgColor = const Color(0xFFE1BEE7);      // Light Purple
        borderColor = const Color(0xFF8E24AA);  // Purple Border
        textColor = const Color(0xFF4A148C);    // Dark Orange
        break;

      case 1:
        statusText = 'Active';
        bgColor = const Color(0xFFC8E6C9);      // Light Green
        borderColor = const Color(0xFF388E3C);  // Dark Green
        textColor = const Color(0xFF1B5E20);// Text Orange
        break;

      case 2:
        statusText = 'Distributed';
        bgColor = const Color(0xFFBBDEFB);      // Light Blue
        borderColor = const Color(0xFF1976D2);  // Dark Blue
        textColor = const Color(0xFF0D47A1);   // Text Green
        break;

      case -1:
        statusText = 'Cancelled';
        bgColor = const Color(0xFFFFCDD2);      // Light Red
        borderColor = const Color(0xFFD32F2F);  // Dark Red
        textColor = const Color(0xFFB71C1C);    // Text Red
        break;

      default:
        statusText = 'Unknown';
        bgColor = const Color(0xFFE0E0E0);
        borderColor = const Color(0xFF9E9E9E);
        textColor = const Color(0xFF424242);
    }
    if (returnTextOnly ?? false) {
      return statusText;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Status:',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: bgColor.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: borderColor, width: 0.1),
          ),
          child: Text(
            statusText,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }


  dynamic patrollingStatus(int status, {bool? returnTextOnly}) {
    String statusText;
    Color bgColor;
    Color textColor;
    Color borderColor;

    switch (status) {
      case 0:
        statusText = 'Draft';
        bgColor = const Color(0xFFE1BEE7);      // Light Purple
        borderColor = const Color(0xFF8E24AA);  // Purple Border
        textColor = const Color(0xFF4A148C);    // Dark Orange
        break;

      case 1:
        statusText = 'LSM Review';
        bgColor = const Color(0xFFC8E6C9);      // Light Green
        borderColor = const Color(0xFF388E3C);  // Dark Green
        textColor = const Color(0xFF1B5E20);// Text Orange
        break;

      case 2:
        statusText = 'Action Pending';
        bgColor = const Color(0xFFBBDEFB);      // Light Blue
        borderColor = const Color(0xFF1976D2);  // Dark Blue
        textColor = const Color(0xFF0D47A1);   // Text Green
        break;

      case 3:
        statusText = 'Security Approval';
        bgColor = const Color(0xFFFFF9C4);
        borderColor = const Color(0xFFFBC02D);
        textColor = const Color(0xFF6D4C41);  // Text Green
        break;
      case 4:
        statusText = 'Closed';
        bgColor = const Color(0xFFFFCDD2);      // Light Red
        borderColor = const Color(0xFFD32F2F);  // Red Border
        textColor = const Color(0xFFB71C1C);// Text Green
        break;

      case 5:
        statusText = 'Revision Required';
        bgColor = const Color(0xFF00838F);      // Light Cyan
        borderColor = const Color(0xFF00838F);  // Cyan Border
        textColor =  Colors.white;     // Text Green
        break;

      case -1:
        statusText = 'Cancelled';
        bgColor = const Color(0xFFFFCDD2);      // Light Red
        borderColor = const Color(0xFFD32F2F);  // Dark Red
        textColor = const Color(0xFFB71C1C);    // Text Red
        break;

      default:
        statusText = 'Unknown';
        bgColor = const Color(0xFFE0E0E0);
        borderColor = const Color(0xFF9E9E9E);
        textColor = const Color(0xFF424242);
    }
    if (returnTextOnly ?? false) {
      return statusText;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Status:',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: bgColor.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: borderColor, width: 0.1),
          ),
          child: Text(
            statusText,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }

  // Widget dutyPostNameMasterStatus(int status) {
  //   String statusText;
  //
  //   switch (status) {
  //     case -1:
  //       statusText = 'Cancelled';
  //       break;
  //     case 0:
  //       statusText = 'Draft';
  //       break;
  //     case 1:
  //       statusText = 'Active';
  //       break;
  //     default:
  //       statusText = ''; // Handle the default case if needed
  //   }
  //   return IntrinsicWidth(
  //     child: Row(
  //       children: [
  //         textHandling('Status : ', statusText),
  //       ],
  //     ),
  //   );
  // }


  dynamic transportMedicalStatus(int status, {bool? returnTextOnly}) {
    String statusText;
    Color bgColor;
    Color textColor;
    Color borderColor;

    switch (status) {
      case 0:
        statusText = 'Created';
        bgColor = const Color(0xFFE1BEE7);      // Light Purple
        borderColor = const Color(0xFF8E24AA);  // Purple Border
        textColor = const Color(0xFF4A148C);    // Dark Orange
        break;

      case 1:
        statusText = 'Open';
        bgColor = const Color(0xFFC8E6C9);      // Light Green
        borderColor = const Color(0xFF388E3C);  // Dark Green
        textColor = const Color(0xFF1B5E20);// Text Orange
        break;

      case 2:
        statusText = 'Closed';
    bgColor = const Color(0xFFDCE090);      // Light Lime Green
    borderColor = const Color(0xFFAFB42B);  // Lime Border
    textColor = const Color(0xFF827717);// Text Orange
        break;

      case -1:
        statusText = 'Cancelled';
        bgColor = const Color(0xFFFFCDD2);      // Light Red
        borderColor = const Color(0xFFD32F2F);  // Dark Red
        textColor = const Color(0xFFB71C1C);    // Text Red
        break;

      default:
        statusText = 'Unknown';
        bgColor = const Color(0xFFE0E0E0);
        borderColor = const Color(0xFF9E9E9E);
        textColor = const Color(0xFF424242);
    }
    if (returnTextOnly ?? false) {
      return statusText;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Status:',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: bgColor.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: borderColor, width: 0.1),
          ),
          child: Text(
            statusText,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }
  dynamic dutyPostNameMasterStatus(int status, {bool? returnTextOnly}) {
    String statusText;
    Color bgColor;
    Color textColor;
    Color borderColor;

    switch (status) {
      case 0:
        statusText = 'Draft';
        bgColor = const Color(0xFFE1BEE7);      // Light Purple
        borderColor = const Color(0xFF8E24AA);  // Purple Border
        textColor = const Color(0xFF4A148C);    // Dark Orange
        break;

      case 1:
        statusText = 'Active';
        bgColor = const Color(0xFFC8E6C9);      // Light Green
        borderColor = const Color(0xFF388E3C);  // Dark Green
        textColor = const Color(0xFF1B5E20);// Text Orange
        break;

      case -1:
        statusText = 'Cancelled';
        bgColor = const Color(0xFFFFCDD2);      // Light Red
        borderColor = const Color(0xFFD32F2F);  // Dark Red
        textColor = const Color(0xFFB71C1C);    // Text Red
        break;

      default:
        statusText = 'Unknown';
        bgColor = const Color(0xFFE0E0E0);
        borderColor = const Color(0xFF9E9E9E);
        textColor = const Color(0xFF424242);
    }
    if (returnTextOnly ?? false) {
      return statusText;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Status:',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: bgColor.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: borderColor, width: 0.1),
          ),
          child: Text(
            statusText,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }


  dynamic dutyPostMasterStatus(int status, {bool? returnTextOnly}) {
    String statusText;
    Color bgColor;
    Color textColor;
    Color borderColor;

    switch (status) {
      case 1:
        statusText = 'Active';
        bgColor = const Color(0xFFC8E6C9);      // Light Green
        borderColor = const Color(0xFF388E3C);  // Dark Green
        textColor = const Color(0xFF1B5E20);// Text Orange
        break;

      case 2:
        statusText = 'Closed';
        bgColor = const Color(0xFFFFCDD2);      // Light Red
        borderColor = const Color(0xFFD32F2F);  // Dark Red
        textColor = const Color(0xFFB71C1C);    // Text Red
        break;

      default:
        statusText = 'Unknown';
        bgColor = const Color(0xFFE0E0E0);
        borderColor = const Color(0xFF9E9E9E);
        textColor = const Color(0xFF424242);
    }
    if (returnTextOnly ?? false) {
      return statusText;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Status:',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: bgColor.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: borderColor, width: 0.1),
          ),
          child: Text(
            statusText,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }

  Widget employeeTypeValues(int employeeType) {
    String employeeTypeText;

    switch (employeeType) {
      case 1:
        employeeTypeText = 'FTE';
        break;
      case 2:
        employeeTypeText = 'CWR T1';
        break;
      case 3:
        employeeTypeText = 'CWR T2';
        break;
      default:
        employeeTypeText = ''; // Handle the default case if needed
    }
    return IntrinsicWidth(
      child: Row(
        children: [
          textHandling('Employee Type : ', employeeTypeText),
        ],
      ),
    );
  }

  // Widget buildSecuritySystemStatusRow(int status) {
  //   String statusText;
  //
  //   switch (status) {
  //     case 1:
  //       statusText = 'Created';
  //       break;
  //     case 2:
  //       statusText = 'Submitted';
  //       break;
  //     case 3:
  //       statusText = 'Acknowledged';
  //       break;
  //     case 4:
  //       statusText = 'Hold';
  //       break;
  //     case 5:
  //       statusText = 'Rework';
  //       break;
  //     case 6:
  //       statusText = 'Review';
  //       break;
  //     case 7:
  //       statusText = 'Solve Proposed';
  //       break;
  //     case 8:
  //       statusText = 'Quotes Rejected';
  //       break;
  //     case 9:
  //       statusText = 'Quotes Approved';
  //       break;
  //     case 10:
  //       statusText = 'Po Raised';
  //       break;
  //     case 11:
  //       statusText = 'Work Completed';
  //       break;
  //     case 12:
  //       statusText = 'Invoice Requested';
  //       break;
  //     case 13:
  //       statusText = 'Invoice Submit';
  //       break;
  //     case 14:
  //       statusText = 'Closed';
  //       break;
  //     case -1:
  //       statusText = 'Cancelled';
  //       break;
  //
  //     default:
  //       statusText = ''; // Handle the default case if needed
  //   }
  //   return IntrinsicWidth(
  //     child: Row(
  //       children: [
  //         textHandling('Status : ', statusText),
  //       ],
  //     ),
  //   );
  // }

  Widget buildSecuritySystemStatusRow(int status) {
    String statusText;
    Color bgColor;
    Color textColor;
    Color borderColor;

    switch (status) {
      case 1:
        statusText = 'Created';
        bgColor = const Color(0xFFBBDEFB);      // Light Blue
        borderColor = const Color(0xFF1976D2);  // Blue Border
        textColor = const Color(0xFF0D47A1);    // Dark Blue
        break;

      case 2:
        statusText = 'Submitted';
        bgColor = const Color(0xFFDCE090);      // Light Lime Green
        borderColor = const Color(0xFFAFB42B);  // Lime Border
        textColor = const Color(0xFF827717);// Dark Purple
        break;

      case 3:
        statusText = 'Acknowledged';
        bgColor = const Color(0xFFC5CAE9);      // Light Indigo
        borderColor = const Color(0xFF3F51B5);  // Indigo Border
        textColor = const Color(0xFF1A237E);    // Dark Indigo
        break;

      case 4:
        statusText = 'Hold';
        bgColor = const Color(0xFFFFF9C4);      // Light Yellow
        borderColor = const Color(0xFFFBC02D);  // Yellow Border
        textColor = const Color(0xFFF57F17);    // Dark Yellow
        break;

      case 5:
        statusText = 'Rework';
        bgColor = const Color(0xFFFFE0B2);      // Light Orange
        borderColor = const Color(0xFFF57C00);  // Orange Border
        textColor = const Color(0xFFE65100);    // Dark Orange
        break;

      case 6:
        statusText = 'Review';
        bgColor = const Color(0xFFB2EBF2);      // Light Cyan
        borderColor = const Color(0xFF0097A7);  // Cyan Border
        textColor = const Color(0xFF006064);    // Dark Cyan
        break;

      case 7:
        statusText = 'Solve Proposed';
        bgColor = const Color(0xFFE1BEE7);      // Light Purple
        borderColor = const Color(0xFF8E24AA);  // Purple Border
        textColor = const Color(0xFF4A148C);       // Dark Lime
        break;

      case 8:
        statusText = 'Quotes Rejected';
        bgColor = const Color(0xFFFFCDD2);      // Light Red
        borderColor = const Color(0xFFD32F2F);  // Red Border
        textColor = const Color(0xFFB71C1C);    // Dark Red
        break;

      case 9:
        statusText = 'Quotes Approved';
        bgColor = const Color(0xFFC8E6C9);      // Light Green
        borderColor = const Color(0xFF388E3C);  // Green Border
        textColor = const Color(0xFF1B5E20);    // Dark Green
        break;

      case 10:
        statusText = 'Po Raised';
        bgColor = const Color(0xFFFFF3E0);      // Very Light Orange
        borderColor = const Color(0xFFFF9800);  // Strong Orange
        textColor = const Color(0xFFE65100);    // Dark Orange
        break;

      case 11:
        statusText = 'Work Completed';
        bgColor = const Color(0xFFD7CCC8);      // Light Brown
        borderColor = const Color(0xFF6D4C41);  // Brown Border
        textColor = const Color(0xFF4E342E);    // Dark Brown
        break;

      case 12:
        statusText = 'Invoice Requested';
        bgColor = const Color(0xFFE0F7FA);      // Light Blue-Cyan
        borderColor = const Color(0xFF00ACC1);  // Blue-Cyan Border
        textColor = const Color(0xFF006064);    // Dark Blue-Cyan
        break;

      case 13:
        statusText = 'Invoice Submit';
        bgColor = const Color(0xFFF8BBD0);      // Light Pink
        borderColor = const Color(0xFFC2185B);  // Pink Border
        textColor = const Color(0xFF880E4F);    // Dark Pink
        break;

      case 14:
        statusText = 'Closed';
        bgColor = const Color(0xFFCFD8DC);      // Light Grey-Blue
        borderColor = const Color(0xFF455A64);  // Blue-Grey Border
        textColor = const Color(0xFF263238);    // Dark Blue-Grey
        break;

      case -1:
        statusText = 'Cancelled';
        bgColor = const Color(0xFFFFCDD2);      // Light Red
        borderColor = const Color(0xFFD32F2F);  // Red Border
        textColor = const Color(0xFFB71C1C);    // Dark Red
        break;

      default:
        statusText = 'Unknown';
        bgColor = const Color(0xFFE0E0E0);
        borderColor = const Color(0xFF9E9E9E);
        textColor = const Color(0xFF424242);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Status:',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: bgColor.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: borderColor, width: 0.1),
          ),
          child: Text(
            statusText,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }

  Widget vIPVisitorStatusRow(int status) {
    String statusText;
    Color bgColor;
    Color textColor;
    Color borderColor;

    switch (status) {
      case -1:
        statusText = 'Cancelled';
        bgColor = const Color(0xFFFFCDD2);      // Light Red
        borderColor = const Color(0xFFD32F2F);  // Red Border
        textColor = const Color(0xFFB71C1C);
        break;
      case 0:
        statusText = 'Created';
        bgColor = const Color(0xFFC5CAE9);      // Light Indigo
        borderColor = const Color(0xFF3F51B5);  // Indigo Border
        textColor = const Color(0xFF1A237E);
        break;
      case 1:
        statusText = 'Submitted';
        bgColor = const Color(0xFFAED581);
        borderColor = const Color(0xFF558B2F);
        textColor = const Color(0xFF33691E);
        break;
      default:
        statusText = '';
        bgColor = const Color(0xFFE0E0E0);
        borderColor = const Color(0xFF9E9E9E);
        textColor = const Color(0xFF424242);// Handle the default case if needed
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Status:',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: bgColor.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: borderColor, width: 0.1),
          ),
          child: Text(
            statusText,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }
  //
  // Widget shiftScheduleStatusRow(int status) {
  //   String statusText;
  //
  //   switch (status) {
  //     case 0:
  //       statusText = 'Draft';
  //       break;
  //     case 1:
  //       statusText = 'Active';
  //       break;
  //     case 2:
  //       statusText = 'InActive';
  //       break;
  //     case -1:
  //       statusText = 'Cancelled';
  //       break;
  //     default:
  //       statusText = ''; // Handle the default case if needed
  //   }
  //   return IntrinsicWidth(
  //     child: Row(
  //       children: [
  //         textHandling('Status : ', statusText),
  //       ],
  //     ),
  //   );
  // }

  dynamic shiftScheduleStatusRow(int status, {bool? returnTextOnly}) {
    String statusText;
    Color bgColor;
    Color textColor;
    Color borderColor;

    switch (status) {
      case 0:
        statusText = 'Draft';
        bgColor = const Color(0xFFE1BEE7);      // Light Purple
        borderColor = const Color(0xFF8E24AA);  // Purple Border
        textColor = const Color(0xFF4A148C);    // Dark Orange
        break;

      case 1:
        statusText = 'Active';
        bgColor = const Color(0xFFC8E6C9);      // Light Green
        borderColor = const Color(0xFF388E3C);  // Dark Green
        textColor = const Color(0xFF1B5E20);// Text Orange
        break;

      case 2:
        statusText = 'In Active';
    bgColor = const Color(0xFFDCE090);      // Light Lime Green
    borderColor = const Color(0xFFAFB42B);  // Lime Border
    textColor = const Color(0xFF827717);// Text Orange
        break;

      case -1:
        statusText = 'Cancelled';
        bgColor = const Color(0xFFFFCDD2);      // Light Red
        borderColor = const Color(0xFFD32F2F);  // Dark Red
        textColor = const Color(0xFFB71C1C);    // Text Red
        break;

      default:
        statusText = 'Unknown';
        bgColor = const Color(0xFFE0E0E0);
        borderColor = const Color(0xFF9E9E9E);
        textColor = const Color(0xFF424242);
    }
    if (returnTextOnly ?? false) {
      return statusText;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Status:',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: bgColor.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: borderColor, width: 0.1),
          ),
          child: Text(
            statusText,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }


  Widget buildTicketStatusRow(int status) {
    String statusText;
    Color bgColor;
    Color textColor;
    Color borderColor;

    switch (status) {
      case 0:
        statusText = 'Draft';
        bgColor = const Color(0xFFBBDEFB);      // Light Blue
        borderColor = const Color(0xFF1976D2);  // Blue Border
        textColor = const Color(0xFF0D47A1);    // Dark Blue
        break;

      case 1:
        statusText = 'Open';
        bgColor = const Color(0xFFDCE090);      // Light Lime Green
        borderColor = const Color(0xFFAFB42B);  // Lime Border
        textColor = const Color(0xFF827717);// Dark Purple
        break;

      case 7:
        statusText = 'Duplicate';
        bgColor = const Color(0xFFC5CAE9);      // Light Indigo
        borderColor = const Color(0xFF3F51B5);  // Indigo Border
        textColor = const Color(0xFF1A237E);    // Dark Indigo
        break;

      case 11:
        statusText = 'Invalid';
        bgColor = const Color(0xFFFFCDD2);      // Light Red
        borderColor = const Color(0xFFD32F2F);  // Red Border
        textColor = const Color(0xFFB71C1C);  // Dark Yellow
        break;

      case 2:
        statusText = 'In Progress';
        bgColor = const Color(0xFFFFE0B2);      // Light Orange
        borderColor = const Color(0xFFF57C00);  // Orange Border
        textColor = const Color(0xFFE65100);    // Dark Orange
        break;

      case 3:
        statusText = 'Dev Completed';
        bgColor = const Color(0xFFB2EBF2);      // Light Cyan
        borderColor = const Color(0xFF0097A7);  // Cyan Border
        textColor = const Color(0xFF006064);    // Dark Cyan
        break;

      case 4:
        statusText = 'Testing';
        bgColor = const Color(0xFFE1BEE7);      // Light Purple
        borderColor = const Color(0xFF8E24AA);  // Purple Border
        textColor = const Color(0xFF4A148C);       // Dark Lime
        break;

      case 5:
        statusText = 'Done';
        bgColor = const Color(0xFFC8E6C9);      // Light Green
        borderColor = const Color(0xFF388E3C);  // Green Border
        textColor = const Color(0xFF1B5E20); // Dark Red
        break;

      case 10:
        statusText = 'Reopen';
        bgColor = const Color(0xFFFFCDD2);      // Light Red
        borderColor = const Color(0xFFD32F2F);  // Red Border
        textColor = const Color(0xFFB71C1C);  // Dark Green
        break;


      case 8:
        statusText = 'Block';
        bgColor = const Color(0xFFCFD8DC);      // Light Grey-Blue
        borderColor = const Color(0xFF455A64);  // Blue-Grey Border
        textColor = const Color(0xFF263238);    // Dark Blue-Grey
        break;

      case 9:
        statusText = 'Closed';
        bgColor = const Color(0xFFF8BBD0);      // Light Pink
        borderColor = const Color(0xFFC2185B);  // Pink Border
        textColor = const Color(0xFF880E4F);     // Dark Blue-Grey
        break;

      case -1:
        statusText = 'Cancelled';
        bgColor = const Color(0xFFFFF9C4);
        borderColor = const Color(0xFFFBC02D);
        textColor = const Color(0xFF6D4C41);    // Dark Blue-Grey
        break;

      default:
        statusText = 'Unknown';
        bgColor = const Color(0xFFE0E0E0);
        borderColor = const Color(0xFF9E9E9E);
        textColor = const Color(0xFF424242);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Status:',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: bgColor.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: borderColor, width: 0.1),
          ),
          child: Text(
            statusText,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }
  // Widget textHandling(String title, String desc) {
  //   return RichText(
  //     overflow: TextOverflow.ellipsis,
  //     text: TextSpan(
  //       style: Styles.textStyleNavigator,
  //       children: <TextSpan>[
  //         TextSpan(text: title),
  //         // if (desc.length > 15) ...[
  //         //   const TextSpan(
  //         //     text: '\n', // Add '\n' before desc
  //         //   ),
  //         // ],
  //         TextSpan(
  //           text: desc,
  //           style: Styles.textStyleNavigator600,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget textHandling(String title, String desc) {
  //   return RichText(
  //     softWrap: true,                   // 👈 allow multi-line wrapping
  //     maxLines: 1,                      // 👈 optional (limit lines)
  //     overflow: TextOverflow.ellipsis,  // 👈 show "..."
  //     text: TextSpan(
  //       style: Styles.textStyleNavigator,
  //       children: [
  //         TextSpan(text: title),
  //         TextSpan(
  //           text: desc,
  //           style: Styles.textStyleNavigator600,
  //         ),
  //       ],
  //     ),
  //   );
  // }
  Widget textHandling(String title, String desc) {
    return RichText(
      softWrap: true,                   // 👈 allow multi-line wrapping
      maxLines: 1,                      // 👈 optional (limit lines)
      overflow: TextOverflow.ellipsis,  // 👈 show "..."
      text: TextSpan(
        style: Styles.textStyleWhite14,
        children: [
          TextSpan(text: title),
          TextSpan(
            text: desc,
            style: Styles.textStyleWhite14,
          ),
        ],
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

  List<String> splitStringAfterComma(String inputString) {
    log('-inputString----$inputString-');
    return inputString
        .split(',')
        .where((item) => item.trim().isNotEmpty)
        .toList();
  }

  String joinListWithComma(List<String> inputList) {
    log('-inputList----${inputList.length}-');
    return inputList.join(',');
  }

  String getCurrentDate() {
    return DateFormat(Constants.fulldateFormat).format(DateTime.now());
  }

  void formError(dynamic state, BuildContext context) {
    if (state.status == FormStatus.formError) {
      log('FORM Error STATUS: ${state.status}');
      Validator().showToast(
        context,
        state.message ?? 'Invalid Information',
      );
    }
  }

  Future<void> errorAndLogout(dynamic state, BuildContext context) async {
    /// If the Token is cleared and the user is still logged in
    String token = await SharedPrefs.getToken();
    if (token.isEmptyOrNull) {
      InactivityFunctions().logoutUser(navigatorKey);
    }

    log('STATUS: ${state.status}');
    if (state.status == FormStatus.error && context.mounted) {
      UtilsCommon()
          .logCustomEvent(msg: state.message, customKey: 'ERROR_AND_LOGOUT');
      InactivityFunctions().logoutUser(navigatorKey);
      Validator().showToast(
        context,
        state.message ?? 'Invalid Information',
      );
    }
    if (state.status == FormStatus.permissionLocationError && context.mounted) {
      log('');
      var dialog = CustomAlertDialog(
          title: 'Location Permission',
          message: state.message,
          onPositivePressed: () async {
            openAppSettings();
            Navigator.of(context).pop();
          },
          onNegativePressed: () {
            log('--onNegativePressed--');
          },
          positiveBtnText: Constants.settings,
          negativeBtnText: Constants.no);
      showDialog(context: context, builder: (BuildContext context) => dialog);
    }
  }

  void emitErrorState(
    GenericResponse e,
    dynamic emit,
    dynamic state,
  ) {
    emit(
      state.copyWith(
        message: e.message,
        status: e.statusCode == '400' ? FormStatus.formError : FormStatus.error,
      ),
    );
  }

  bool isNumeric(String str) {
    return double.tryParse(str) != null;
  }
}
