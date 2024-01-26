import 'dart:developer';

import 'package:db_atom/index.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getDutyPostMaster = '$baseUrl/getDpmList?';

  static final String _getDutyPostMasterById = '$baseUrl/getDpmById';
  static final String _getDutyPostsByLocation = '$baseUrl/getDpnByLocId';

  static final String _createDutyPostMaster = '$baseUrl/createDpm?';
}

class DutyPostMasterServices {
  Future<String> getUserEmail() async {
    String email = await SharedPrefs.getEmail();
    return email;
  }

  Future<DutyPostMasterResponse> getList({
    required String startPosition,
    required String maximumRecords,
    required String userId,
    required String locationId,
  }) async {
    String url =
        '${Apis._getDutyPostMaster}startPos=$startPosition&maxResults=$maximumRecords&userId=$userId&locationId=$locationId';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return DutyPostMasterResponse.fromJson(response);
  }

  Future<DutyPostMasterModel> getById(int id) async {
    final String url = '${Apis._getDutyPostMasterById}/$id';
    var response = await BaseApiService().getRequest(
      url: url,
    );
    return DutyPostMasterModel.fromJson(response);
  }

  Future<List<Organisation>> getDutyPostsByLocation({
    required String locationId,
  }) async {
    final String url = '${Apis._getDutyPostsByLocation}/$locationId';
    final response = await BaseApiService().getRequest(
      url: url,
    );

    return List<Organisation>.from(
        response.map((x) => Organisation.fromJson(x)));
  }

  /// Create Services

  Future<GenericResponse> createDutyPostMaster({
    required DutyPostMasterRequest body,
    required bool isSubmit,
  }) async {
    final String url =
        "${Apis._createDutyPostMaster}userEmail=${await getUserEmail()}&isSubmit=$isSubmit";
    log("API URL------2-2-2-2-2-: $url");
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }
}
