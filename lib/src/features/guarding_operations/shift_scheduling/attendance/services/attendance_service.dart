import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/models/requestModel/adhoc_attendance_request.dart';

import '../models/adhoc_attendance_model.dart';
import '../models/dutyPost_attendance_model.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getList = '$baseUrl/getAttendanceList?';
  static final String _getById = '$baseUrl/getAttendanceById';

  static final String _getDutyPostsById = '$baseUrl/getAttdDpList';
  static final String _getDutyPostById = '$baseUrl/getAttdDpById';
  static final String _getAdhocAttendanceById = '$baseUrl/getAdhocAttendanceById';
  static final String _getAdhocDesignation = '$baseUrl/getAdhocDesignationList';
  static final String  _getAdhocDutyHourList = '$baseUrl/getAdhocDutyHourList';
  static final String  _getAdhocShiftList ='$baseUrl/getAdhocShiftList';
  static final String  _getAdhocDutyPostList ='$baseUrl/getAdhocDutyPostList';
  static final String  _getAdhocAvailableGuards = '$baseUrl/getAvailableGuards';
  static final String _createAdhocAttendance = '$baseUrl/adhocAttendanceGi?';
  static final String _getNextAvailableReplacementDates =
      '$baseUrl/getNextAvailableReplacementDates';
  static final String _getDutyPostAttendanceById = '$baseUrl/getAttendanceDutyPosts';


  /// Rank List
  static final String _getAttendanceRanksByDutyPostId =
      '$baseUrl/getAttRanksListByAssignedDutyPostId/';
  static final String _getAttendanceShiftByByDutyPostIdAndRankId =
      '$baseUrl/getAttShiftListByAssignedDutyPostId/';

  static final String _getBriefingPoints = '$baseUrl/getBriefingPoints';

  static final String _createAttendanceGi = '$baseUrl/attendanceGi?';
  static final String _updateAttendance = '$baseUrl/updateAttendance?';
  static final String _createAttendanceDutyPost = '$baseUrl/createAttDutyPost?';

  static final String _getAttAvailableGuardsByDate =
      '$baseUrl/getAttAvailableGuardsByDate';
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

  Future<ShiftModel> getDutyPostById({
    required int attInfoId,
    required int dutyPostNameId,
    required int rankId,
    required int shiftId,
  }) async {
    final String url =
        '${Apis
        ._getDutyPostById}?attInfoId=$attInfoId&dutyPostNameId=$dutyPostNameId&rankId=$rankId&shiftId=$shiftId';
    final response = await BaseApiService().getRequest(
      url: url,
    );

    return ShiftModel.fromJson(response);
  }

  Future<GenericResponse> createAttendanceGi({
    required AttendanceRequest body,
    required bool isSubmit,
  }) async {
    final String url = "${Apis._createAttendanceGi}&isSubmit=$isSubmit";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }

  Future<GenericResponse> createAttendanceShiftDutyPost({
    required AttendanceShiftDutyPostRequest body,
    required bool isSubmit,
    required bool isRemove,
  }) async {
    final String url = "${Apis
        ._updateAttendance}&isSubmit=$isSubmit&isRemove=$isRemove";
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
        '${Apis
        ._getAttendanceRanksByDutyPostId}$attendanceId?shiftAssignedDutyPostId=$dutyPostId';
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
        '${Apis
        ._getAttendanceShiftByByDutyPostIdAndRankId}$attendanceId?shiftAssignedDutyPostId=$dutyPostId&rankId=$rankId';
    final response = await BaseApiService().getRequest(
      url: url,
    );

    return List<Organisation>.from(
        response.map((x) => Organisation.fromJson(x)));
  }

  Future<List<BaseUser>> getAttAvailableGuardsByDate({
    required int dutyPostId,
    required int rankId,
    required int shiftId,
    required String fromDate,
    required String toDate,
  }) async {
    String url =
        '${Apis
        ._getAttAvailableGuardsByDate}/$dutyPostId?rankId=$rankId&fromDate=$fromDate&toDate=$toDate&shiftId=$shiftId';
    final response = await BaseApiService().getRequest(
      url: url,
    );

    return List<BaseUser>.from(response.map((x) => BaseUser.fromJson(x)));
  }


  Future<DutyPostAttendanceModel> getDutyPostAttendanceById({
    required int? attInfoId,
  }) async {
    final String url =
        '${Apis._getDutyPostAttendanceById}/$attInfoId';
    final response = await BaseApiService().getRequest(
      url: url,
    );

    return DutyPostAttendanceModel.fromJson(response);
  }

  Future<AdhocAttendanceGiModel> getAdhocAttendanceById({
    required int? attInfoId,
  }) async {
    final String url =
        '${Apis._getAdhocAttendanceById}/$attInfoId';
    final response = await BaseApiService().getRequest(
      url: url,
    );

    return AdhocAttendanceGiModel.fromJson(response);
  }


  // Future<List<Organisation>> getAdhocDesignation() async {
  //   final String url = Apis._getAdhocDesignation;
  //   final response = await BaseApiService().getRequest(
  //     url: url,
  //   );
  //
  //   return List<Organisation>.from(response.map((x) => x));
  // }
  //
  // Future<List<Organisation>> getAdhocDutyHourList() async {
  //   final String url = Apis._getAdhocDutyHourList;
  //   final response = await BaseApiService().getRequest(
  //     url: url,
  //   );
  //
  //   return List<Organisation>.from(response.map((x) => x));
  // }
  //
  // Future<List<Organisation>> getAdhocShiftList() async {
  //   final String url = Apis._getAdhocShiftList;
  //   final response = await BaseApiService().getRequest(
  //     url: url,
  //   );
  //   return List<Organisation>.from(response.map((x) => x));
  // }

  Future<List<Organisation>> getAdhocAvailableGuards({
    required int locId,
    required int vendorId,
  }) async {
    final String url = '${Apis._getAdhocAvailableGuards}?locationId=$locId&vendorId=$vendorId';
    final response = await BaseApiService().getRequest(
      url: url,
    );

    return List<Organisation>.from(
      response.map((x) => Organisation.fromJson(x as Map<String, dynamic>)),
    );
  }

  Future<List<Organisation>> getAdhocDesignation() async {
    final String url = Apis._getAdhocDesignation;
    final response = await BaseApiService().getRequest(
      url: url,
    );

    return List<Organisation>.from(
      response.map((x) => Organisation.fromJson(x as Map<String, dynamic>)),
    );
  }

  Future<List<Organisation>> getAdhocDutyHourList() async {
    final String url = Apis._getAdhocDutyHourList;
    final response = await BaseApiService().getRequest(
      url: url,
    );

    return List<Organisation>.from(
      response.map((x) => Organisation.fromJson(x as Map<String, dynamic>)),
    );
  }

  Future<List<Organisation>> getAdhocShiftList() async {
    final String url = Apis._getAdhocShiftList;
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return List<Organisation>.from(
      response.map((x) => Organisation.fromJson(x as Map<String, dynamic>)),
    );
  }

  Future<List<Organisation>> getAdhocDutyPost({required int? id}) async {
    final String url = '${Apis._getAdhocDutyPostList}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return List<Organisation>.from(
      response.map((x) => Organisation.fromJson(x as Map<String, dynamic>)),
    );
  }

  //
  Future<GenericResponse> createAdhocAttendance({
    required AdhocAttendanceRequest body,
    required bool isSubmit,
    bool? isApprovedStatus,
  }) async {
     String url = "${Apis
        ._createAdhocAttendance}isSubmit=$isSubmit";

    if (isApprovedStatus != null) {
      url += '&isApprovedStatus=$isApprovedStatus';
    }

    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }

  Future<GenericResponse> createDutyPostAttendance({
    required AttendanceShiftDutyPostRequest body,
    required bool isSubmit,
    bool? isApprovedStatus,
  }) async {
    String url = "${Apis
        ._createAttendanceDutyPost}isSubmit=$isSubmit";

    if (isApprovedStatus != null) {
      url += '&isApprovedStatus=$isApprovedStatus';
    }

    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }

  Future<NextAvailableDateRange> getNextAvailableReplacementDates({
    required int? dutyPostId,
    required int rankId,
    required int shiftId,
    required int userId,
  required int? attendanceId
  }) async {
    String url =
        '${Apis._getNextAvailableReplacementDates}/$dutyPostId?attendanceInfoId=$attendanceId&replaceForUserId=$userId&rankId=$rankId&shiftId=$shiftId';
    final response = await BaseApiService().getRequest(
      url: url,
    );

    return NextAvailableDateRange.fromJson(response);
  }
}