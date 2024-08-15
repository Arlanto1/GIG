import 'dart:developer';

import 'package:db_atom/index.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getList = '$baseUrl/getShiftSchdList?';

  static final String _getById = '$baseUrl/getSsGiById';
  static final String _getDutyPostsById = '$baseUrl/getSsDpById';
  static final String _getDutyPostById = '$baseUrl/getGuardsByAssignedId';
  static final String _getDutyPostAssignedId = '$baseUrl/getDutyPostAssignedId';
  static final String _getDutyPostsByLocationAndVendor =
      '$baseUrl/getSsDpByLocAndVendor?';

  static final String _createShiftSchedule = '$baseUrl/createSsGi?';
  static final String _assignGuards = '$baseUrl/assignGuards?';
  static final String _getNextAvailableDate = '$baseUrl/getNextAvailableDate?';
  static final String _getRanksListByAssignedDutyPostId =
      '$baseUrl/getRanksListByAssignedDutyPostId';
  static final String _getShiftListByAssignedDutyPostId =
      '$baseUrl/getShiftListByAssignedDutyPostId';
  static final String _getAvailableSelectedGuardsByShift =
      '$baseUrl/getAvailableSelectedGuardsByShift';
  static final String _saveSelectedGuards = '$baseUrl/saveSelectedGuards?';
  static final String _getNextAvailableReplacementDates =
      '$baseUrl/getNextAvailableReplacementDates';
}

class ShiftScheduleServices {
  Future<String> getUserEmail() async {
    String email = await SharedPrefs.getEmail();
    return email;
  }

  Future<ShiftScheduleResponse> getList({
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
    return ShiftScheduleResponse.fromJson(response);
  }

  Future<ShiftScheduleModel> getById(int id) async {
    final String url = '${Apis._getById}/$id';
    var response = await BaseApiService().getRequest(
      url: url,
    );
    return ShiftScheduleModel.fromJson(response);
  }

  Future<List<DutyPostModel>> getDutyPostsById({
    required int? id,
    required int? dutyType,
  }) async {
    if (id == null) {
      return [];
    }
    final String url = '${Apis._getDutyPostsById}/$id?dutyType=$dutyType';
    final response = await BaseApiService().getRequest(
      url: url,
    );

    return List<DutyPostModel>.from(
        response.map((x) => DutyPostModel.fromJson(x)));
  }

  Future<DutyPostModel> getDutyPostByShiftIdAndDutyPostNameId({
    required int shiftId,
    required int dutyPostId,
  }) async {
    final String url =
        '${Apis._getDutyPostAssignedId}?shiftInfoId=$shiftId&dutyPostId=$dutyPostId';
    final response = await BaseApiService().getRequest(
      url: url,
    );

    return DutyPostModel.fromJson(response);
  }

  Future<DutyPostModel> getDutyPostById({
    required int? id,
  }) async {
    final String url = '${Apis._getDutyPostById}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );

    return DutyPostModel.fromJson(response);
  }

  Future<List<DutyPostModel>> getDutyPostsByLocationAndVendor({
    required int locationId,
    required int vendorId,
    required int? dutyType,
  }) async {
    String url =
        '${Apis._getDutyPostsByLocationAndVendor}loc=$locationId&vend=$vendorId&dutyType=$dutyType';
    final response = await BaseApiService().getRequest(
      url: url,
    );

    return List<DutyPostModel>.from(
        response.map((x) => DutyPostModel.fromJson(x)));
  }

  /// Create Services
  Future<GenericResponse> createShiftSchedule({
    required ShiftScheduleRequest body,
    required bool isSubmit,
  }) async {
    final String url = "${Apis._createShiftSchedule}&isSubmit=$isSubmit";
    log("API URL------2-2-2-2-2-: $url");
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }

  Future<GenericResponse> assignGuards({
    required DutyPostRequest body,
    required bool isSubmit,
  }) async {
    final String url = "${Apis._assignGuards}&isSubmit=$isSubmit";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }

  Future<NextAvailableDateRange> getNextAvailableDate({
    required int locationId,
    required int vendorId,
  }) async {
    String url =
        '${Apis._getNextAvailableDate}locationId=$locationId&vendorId=$vendorId';
    final response = await BaseApiService().getRequest(
      url: url,
    );

    return NextAvailableDateRange.fromJson(response);
  }

  /// Get Rank List
  Future<List<Organisation>> getRanksListByAssignedDutyPostId({
    required int dutyPostId,
  }) async {
    String url = '${Apis._getRanksListByAssignedDutyPostId}/$dutyPostId';
    final response = await BaseApiService().getRequest(
      url: url,
    );

    return List<Organisation>.from(
        response.map((x) => Organisation.fromJson(x)));
  }

  /// Get Shift List By Rank Id
  Future<List<Organisation>> getShiftListByAssignedDutyPostId({
    required int dutyPostId,
    required int rankId,
  }) async {
    String url =
        '${Apis._getShiftListByAssignedDutyPostId}/$dutyPostId?rankId=$rankId';
    final response = await BaseApiService().getRequest(
      url: url,
    );

    return List<Organisation>.from(
        response.map((x) => Organisation.fromJson(x)));
  }

  Future<ShiftModel> getAvailableSelectedGuardsByShift({
    required int dutyPostId,
    required int rankId,
    required int shiftId,
  }) async {
    String url =
        '${Apis._getAvailableSelectedGuardsByShift}/$dutyPostId?rankId=$rankId&shiftId=$shiftId';
    final response = await BaseApiService().getRequest(
      url: url,
    );

    return ShiftModel.fromJson(response);
  }

  Future<NextAvailableDateRange> getNextAvailableReplacementDates({
    required int dutyPostId,
    required int rankId,
    required int shiftId,
    required int userId,
  }) async {
    String url =
        '${Apis._getNextAvailableReplacementDates}/$dutyPostId?replaceForUserId=$userId&rankId=$rankId&shiftId=$shiftId';
    final response = await BaseApiService().getRequest(
      url: url,
    );

    return NextAvailableDateRange.fromJson(response);
  }

  Future<GenericResponse> saveSelectedGuards({
    required ShiftRequest body,
    required bool isSubmit,
    required int dutyPostId,
    required int rankId,
    required int shiftId,
    required int shiftScheduleId,
  }) async {
    final String url =
        "${Apis._saveSelectedGuards}isSubmit=$isSubmit&shiftAssignedDutyPostId=$dutyPostId&rankId=$rankId&shiftId=$shiftId&shiftScheduleId=$shiftScheduleId";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }
}
