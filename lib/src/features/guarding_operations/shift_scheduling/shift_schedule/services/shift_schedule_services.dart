import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/models/requestModel/duty_post_request.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getList = '$baseUrl/getShiftSchdList?';

  static final String _getById = '$baseUrl/getSsGiById';
  static final String _getDutyPostsById = '$baseUrl/getSsDpById';
  static final String _getDutyPostById = '$baseUrl/getGuardsByAssignedId';
  static final String _getDutyPostsByLocationAndVendor =
      '$baseUrl/getSsDpByLocAndVendor?';

  static final String _createShiftSchedule = '$baseUrl/createSsGi?';
  static final String _assignGuards = '$baseUrl/assignGuards?';
}

class ShiftScheduleServices {
  Future<String> getUserEmail() async {
    String email = await SharedPrefs.getEmail();
    return email;
  }

  Future<ShiftScheduleResponse> getList({
    required String startPosition,
    required String maximumRecords,
  }) async {
    String url =
        '${Apis._getList}startPos=$startPosition&maxResults=$maximumRecords';
    final response = await BaseApiService().getRequest(
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
    BuildContext? context,
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

  Future<DutyPostModel> getDutyPostById({
    required int? id,
    BuildContext? context,
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
  }) async {
    String url =
        '${Apis._getDutyPostsByLocationAndVendor}loc=$locationId&vend=$vendorId';
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
    log("API URL------2-2-2-2-2-: $url");
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }
}
