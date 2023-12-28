import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/models/attendance_model.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getGuardingMastersData = '$baseUrl/getGMData?';
}

class AttendanceServices {
  Future<String> getUserEmail() async {
    String email = await SharedPrefs.getEmail();
    return email;
  }

  Future<AttendanceResponse> getList({
    required String startPosition,
    required String maximumRecords,
    required String userId,
    required String locationId,
  }) async {
    String url =
        '${Apis._getGuardingMastersData}startPos=$startPosition&maxResults=$maximumRecords&userId=$userId&locationId=$locationId';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return AttendanceResponse.fromJson(response);
  }
}
