import 'package:db_atom/index.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getList = '$baseUrl/getAttendanceList?';
  static final String _getById = '$baseUrl/getAttendanceById';

  static final String _getDutyPostsById = '$baseUrl/getAttdDpList';
  static final String _getDutyPostById = '$baseUrl/getAttdDpById';

  /// Rank List
  static final String _getAttendanceRanksByDutyPostId =
      '$baseUrl/getAttRanksListByAssignedDutyPostId/';
  static final String _getAttendanceShiftByByDutyPostIdAndRankId =
      '$baseUrl/getAttShiftListByAssignedDutyPostId/';

  static final String _getBriefingPoints = '$baseUrl/getBriefingPoints';

  static final String _create = '$baseUrl/updateAttendance?';
}

class AttendanceServices {
  Future<String> getUserEmail() async {
    String email = await SharedPrefs.getEmail();
    return email;
  }

  Future<AttendanceResponse> getList({
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
    return AttendanceResponse.fromJson(response);
  }

  Future<AttendanceModel> getById(int id) async {
    final String url = '${Apis._getById}/$id';
    var response = await BaseApiService().getRequest(
      url: url,
    );
    return AttendanceModel.fromJson(response);
  }

  Future<List<DutyPostModel>> getDutyPostsById({
    required int? id,
  }) async {
    if (id == null) {
      return [];
    }
    final String url = '${Apis._getDutyPostsById}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );

    return List<DutyPostModel>.from(
        response.map((x) => DutyPostModel.fromJson(x)));
  }

  Future<List<String>> getBriefingPoints() async {
    final String url = Apis._getBriefingPoints;
    final response = await BaseApiService().getRequest(
      url: url,
    );

    return List<String>.from(response.map((x) => x));
  }

  Future<Shift> getDutyPostById({
    required int attInfoId,
    required int dutyPostNameId,
    required int rankId,
    required int shiftId,
  }) async {
    final String url =
        '${Apis._getDutyPostById}?attInfoId=$attInfoId&dutyPostNameId=$dutyPostNameId&rankId=$rankId&shiftId=$shiftId';
    final response = await BaseApiService().getRequest(
      url: url,
    );

    return Shift.fromJson(response);
  }

  Future<GenericResponse> create({
    required AttendanceRequest body,
    required bool isSubmit,
  }) async {
    final String url = "${Apis._create}&isSubmit=$isSubmit";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }

  Future<GenericResponse> createAttendanceShiftDutyPost({
    required AttendanceShiftDutyPostRequest body,
    required bool isSubmit,
  }) async {
    final String url = "${Apis._create}&isSubmit=$isSubmit";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }

  /// Get Rank List
  Future<List<Organisation>> getAttendanceRanksByDutyPostId({
    required int attendanceId,
    required int dutyPostId,
  }) async {
    String url =
        '${Apis._getAttendanceRanksByDutyPostId}$attendanceId?shiftAssignedDutyPostId=$dutyPostId';
    final response = await BaseApiService().getRequest(
      url: url,
    );

    return List<Organisation>.from(
        response.map((x) => Organisation.fromJson(x)));
  }

  /// Get Shift List By Rank Id
  Future<List<Organisation>> getAttendanceShiftByByDutyPostIdAndRankId({
    required int attendanceId,
    required int dutyPostId,
    required int rankId,
  }) async {
    String url =
        '${Apis._getAttendanceShiftByByDutyPostIdAndRankId}$attendanceId?shiftAssignedDutyPostId=$dutyPostId&rankId=$rankId';
    final response = await BaseApiService().getRequest(
      url: url,
    );

    return List<Organisation>.from(
        response.map((x) => Organisation.fromJson(x)));
  }
}
