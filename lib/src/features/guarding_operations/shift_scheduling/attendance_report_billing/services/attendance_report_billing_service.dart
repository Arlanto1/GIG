import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance_report_billing/models/attendance_report_billing.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getList = '$baseUrl/getAttdReportList?';

}

class AttendanceReportBillingServices {
  Future<String> getUserEmail() async {
    String email = await SharedPrefs.getEmail();
    return email;
  }

  Future<AttendanceReportBillingResponse> getList({
    required String startPosition,
    required String maximumRecords,
    required BaseFilterModel filters,

  }) async {
    String url =
        '${Apis._getList}startPos=$startPosition&maxResults=$maximumRecords';
    var response = await BaseApiService().postRequest(
      requestedData: filters.toJson(),
      isAuthenticated: true,
      url: url,
    );
    return AttendanceReportBillingResponse.fromJson(response);
  }

}
