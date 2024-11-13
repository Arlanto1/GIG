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
      title: Constants.appname,
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

    switch (status) {
      case 0:
        statusText = 'Found';
        break;
      case 1:
        statusText = 'Under Security Custody';
        break;
      case 2:
        statusText = 'Handed Over/ Claimed';
        break;
      case -1:
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

  Widget buildLeoStatusRow(int status) {
    String statusText;

    switch (status) {
      case 0:
        statusText = 'Draft';
        break;
      case 1:
        statusText = 'Submitted';
        break;
      case 2:
        statusText = 'Verification Under Process';
        break;
      case 3:
        statusText = 'Distributed';
        break;
      case -1:
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

  Widget buildMaterialMovementStatusRow(int status) {
    String statusText;

    switch (status) {
      case 0:
        statusText = 'Draft';
        break;
      case 1:
        statusText = 'Business User Review';
        break;
      case 2:
        statusText = 'Submitted';
        break;
      case 3:
        statusText = 'LSM Review';
        break;
      case 4:
        statusText = 'LSM Approved';
        break;
      case 5:
        statusText = 'LSM Rejected';
        break;
      case 6:
        statusText = 'Approved';
        break;
      case 7:
        statusText = 'Rejected';
        break;
      case 8:
        statusText = 'Outward Waiting';
        break;
      case 9:
        statusText = 'Inward Waiting';
        break;
      case 10:
        statusText = 'Closed/Finalize';
        break;
      case -1:
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

  Widget buildMasterDataStatusRow(int status) {
    String statusText;

    switch (status) {
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
      case -1:
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

  dynamic buildAttendanceStatusRow(
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
        statusText = 'InActive';
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

    switch (status) {
      case 0:
        statusText = 'Draft';
        break;
      case 1:
        statusText = 'Business User Review';
        break;
      case 2:
        statusText = 'LSM Review';
        break;
      case 3:
        statusText = 'LSM Approved';
        break;
      case 4:
        statusText = 'LSM Rejected';
        break;
      case 5:
        statusText = 'Vendor Review';
        break;
      case 6:
        statusText = 'Vendor Approved';
        break;
      case 7:
        statusText = 'Vendor Rejected';
        break;
      case 8:
        statusText = 'Business User POC Review';
        break;
      case 9:
        statusText = 'Business User POC Approved';
        break;
      case 10:
        statusText = 'Business User POC Rejected';
        break;
      case 11:
        statusText = 'Security Vendor Review';
        break;
      case 12:
        statusText = 'Security Vendor Submitted';
        break;
      case 13:
        statusText = 'EP Pre Review';
        break;
      case 14:
        statusText = 'EP Pre Approved';
        break;
      case 15:
        statusText = 'EP Pre Rejected';
        break;
      case 16:
        statusText = 'SRH Review';
        break;
      case 17:
        statusText = 'SRH Approved';
        break;
      case 18:
        statusText = 'SRH Rejected';
        break;
      case 19:
        statusText = 'EP PO Required';
        break;
      case 20:
        statusText = 'PO Updated';
        break;
      case 21:
        statusText = 'Event Started';
        break;
      case 22:
        statusText = 'During Event';
        break;
      case 23:
        statusText = 'Event Concluded';
        break;
      case 24:
        statusText = 'EP Post Review';
        break;
      case 25:
        statusText = 'EP Post Approved';
        break;
      case 26:
        statusText = 'EP Post Rejected';
        break;
      case 27:
        statusText = 'Invoice Requested';
        break;
      case 28:
        statusText = 'Invoice Raised';
        break;
      case 29:
        statusText = 'Invoice Submitted';
        break;
      case 30:
        statusText = 'Closed';
        break;
      case -1:
        statusText = 'Cancelled';
        break;
      default:
        statusText = ''; // Handle the default case if needed
    }
    return IntrinsicWidth(
      child: textHandling('Status : ', statusText),
    );
  }

  Widget buildPassManagementStatusRow(int status) {
    String statusText = buildPassManagementStatus(status);
    return IntrinsicWidth(
      child: Row(
        children: [
          textHandling('Status: ', statusText),
        ],
      ),
    );
  }

  String buildPassManagementStatus(int? status) {
    String statusText;

    switch (status) {
      case 0:
        statusText = 'Created';
        break;
      case 1:
        statusText = 'Handed Over';
        break;
      case 2:
        statusText = 'Returned';
        break;
      case 3:
        statusText = 'Non Returned';
        break;
      case 4:
        statusText = 'Lost';
        break;
      case 5:
        statusText = 'Damaged/De-Activated';
        break;
      case 6:
        statusText = 'Defaced/De-Activated';
        break;
      case 7:
        statusText = 'Cancelled';
        break;
      case 8:
        statusText = 'Returned/Damaged';
        break;
      case 9:
        statusText = 'Returned/Defaced';
        break;
      case -1:
        statusText = 'Record Cancelled';
        break;
      default:
        statusText = ''; // Handle the default case if needed
    }
    return statusText;
  }

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

    switch (status) {
      case 0:
        statusText = 'Created';
        break;
      case 1:
        statusText = 'Submitted';
        break;
      case -1:
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

  Widget keyLossDestructionStatus(int status) {
    String statusText;

    switch (status) {
      case 0:
        statusText = 'Created';
        break;
      case 1:
        statusText = 'Lock Change Initiated';
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

  Widget keyManagementStatus(int status) {
    String statusText;

    switch (status) {
      case -1:
        statusText = 'Cancelled';
        break;
      case 0:
        statusText = 'Draft';
        break;
      case 1:
        statusText = 'Open';
        break;
      case 2:
        statusText = 'Closed';
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

  Widget keyManagementIssuanceStatus(int status) {
    String statusText;

    switch (status) {
      case -1:
        statusText = 'Cancelled';
        break;
      case 0:
        statusText = 'Draft';
        break;
      case 1:
        statusText = 'Handed Over';
        break;
      case 2:
        statusText = 'Not Returned';
        break;
      case 3:
        statusText = 'Closed/Damaged';
        break;
      case 4:
        statusText = 'Closed/Lost';
        break;
      case 5:
        statusText = 'Lost/Not Returned';
        break;
      case 6:
        statusText = 'Closed/Lost/Not Returned';
        break;
      case 7:
        statusText = 'Closed/Lost/Damaged';
        break;
      case 8:
        statusText = 'Lost/Damaged';
        break;
      case 9:
        statusText = 'Lost/Damaged/Not Returned';
        break;
      case 10:
        statusText = 'Closed/Lost/Damaged/Not Returned';
        break;
      case 11:
        statusText = 'Damaged/Not Returned';
        break;
      case 12:
        statusText = 'Closed';
        break;
      default:
        statusText = '';
    }
    return IntrinsicWidth(
      child: Row(
        children: [
          textHandling('Status : ', statusText),
        ],
      ),
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

    switch (status) {
      case 0:
        statusText = 'Created';
        break;
      case 1:
        statusText = 'Complainant Review';
        break;
      case 2:
        statusText = 'IM Pre Review';
        break;
      case 3:
        statusText = 'IM Pre Reject';
        break;
      case 4:
        statusText = 'IM Pre Approve';
        break;
      case 5:
        statusText = 'IO Role Review';
        break;
      case 6:
        statusText = 'IO Role Reject';
        break;
      case 7:
        statusText = 'IO Role Approve';
        break;
      case 8:
        statusText = 'Investigation';
        break;
      case 9:
        statusText = 'Pass';
        break;
      case 10:
        statusText = 'Pass Review';
        break;
      case 11:
        statusText = 'Pass Reject';
        break;
      case 12:
        statusText = 'Pass Approve';
        break;
      case 13:
        statusText = 'RCA';
        break;
      case 14:
        statusText = 'RCA Review';
        break;
      case 15:
        statusText = 'RCA Reject';
        break;
      case 16:
        statusText = 'RCA Approve';
        break;
      case 17:
        statusText = 'RCA System Review';
        break;
      case 18:
        statusText = 'RCA System Reject';
        break;
      case 19:
        statusText = 'RCA System Approve';
        break;
      case 20:
        statusText = 'Data Loss';
        break;
      case 21:
        statusText = 'Data Loss Review';
        break;
      case 22:
        statusText = 'Data Loss Reject';
        break;
      case 23:
        statusText = 'Data Loss Approve';
        break;
      case 24:
        statusText = 'Further Investigation';
        break;
      case 25:
        statusText = 'RCA Action Plan';
        break;
      case 26:
        statusText = 'RCA Action Plan Review';
        break;
      case 27:
        statusText = 'RCA Action Plan Reject';
        break;
      case 28:
        statusText = 'RCA Action Plan Approve';
        break;
      case 29:
        statusText = 'IO Review';
        break;
      case 30:
        statusText = 'IO Reject';
        break;
      case 31:
        statusText = 'IO Approve';
        break;
      case 32:
        statusText = 'FTE CWR Involved';
        break;
      case 33:
        statusText = 'IM Final Review';
        break;
      case 34:
        statusText = 'Read Across';
        break;
      case 35:
        statusText = 'Read Across Review';
        break;
      case 36:
        statusText = 'Read Across Reject';
        break;
      case 37:
        statusText = 'Read Across Approve';
        break;
      case 38:
        statusText = 'Investigation Done';
        break;
      case 39:
        statusText = 'Closed';
        break;
      case 40:
        statusText = 'Cancelled';
        break;
      case -1:
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

  dynamic buildSLAViolationStatus(int status, {bool? returnTextOnly}) {
    String statusText;

    switch (status) {
      case 0:
        statusText = 'Draft';
        break;
      case 1:
        statusText = 'Active';
        break;
      case 2:
        statusText = 'Finalized';
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

  Widget contactDetailsStatus(int status) {
    String statusText;

    switch (status) {
      case 0:
        statusText = 'Draft';
        break;
      case 1:
        statusText = 'Active';
        break;
      case -1:
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

  Widget dutyPostNameMasterStatus(int status) {
    String statusText;

    switch (status) {
      case -1:
        statusText = 'Cancelled';
        break;
      case 0:
        statusText = 'Draft';
        break;
      case 1:
        statusText = 'Active';
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

  Widget buildSecuritySystemStatusRow(int status) {
    String statusText;

    switch (status) {
      case 1:
        statusText = 'Created';
        break;
      case 2:
        statusText = 'Submitted';
        break;
      case 3:
        statusText = 'Acknowledged';
        break;
      case 4:
        statusText = 'Hold';
        break;
      case 5:
        statusText = 'Rework';
        break;
      case 6:
        statusText = 'Review';
        break;
      case 7:
        statusText = 'Solve Proposed';
        break;
      case 8:
        statusText = 'Quotes Rejected';
        break;
      case 9:
        statusText = 'Quotes Approved';
        break;
      case 10:
        statusText = 'Po Raised';
        break;
      case 11:
        statusText = 'Work Completed';
        break;
      case 12:
        statusText = 'Invoice Requested';
        break;
      case 13:
        statusText = 'Invoice Submit';
        break;
      case 14:
        statusText = 'Closed';
        break;
      case -1:
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

  Widget vIPVisitorStatusRow(int status) {
    String statusText;

    switch (status) {
      case -1:
        statusText = 'Cancelled';
        break;
      case 0:
        statusText = 'Created';
        break;
      case 1:
        statusText = 'Submitted';
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

  Widget shiftScheduleStatusRow(int status) {
    String statusText;

    switch (status) {
      case 0:
        statusText = 'Draft';
        break;
      case 1:
        statusText = 'Active';
        break;
      case 2:
        statusText = 'InActive';
        break;
      case -1:
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

  Widget textHandling(String title, String desc) {
    return RichText(
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: Styles.textStyleRegularNormalGrey14,
        children: <TextSpan>[
          TextSpan(text: title),
          // if (desc.length > 15) ...[
          //   const TextSpan(
          //     text: '\n', // Add '\n' before desc
          //   ),
          // ],
          TextSpan(
            text: desc,
            style: Styles.textStyleBoldGrey14,
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
