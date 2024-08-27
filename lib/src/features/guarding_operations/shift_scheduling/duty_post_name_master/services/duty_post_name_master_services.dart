import 'dart:developer';

import 'package:db_atom/index.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getList = '$baseUrl/getDpnList?';

  static final String _getById = '$baseUrl/getDpnById';

  static final String _create = '$baseUrl/createDpn?';

  static final String _checkDutyPostNameExists =
      '$baseUrl/checkDutyPostExists?';
}

class DutyPostNameMasterServices {
  Future<String> getUserEmail() async {
    String email = await SharedPrefs.getEmail();
    return email;
  }

  Future<DutyPostNameMasterResponse> getList({
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
    return DutyPostNameMasterResponse.fromJson(response);
  }

  Future<DutyPostNameMasterModel> getById(int id) async {
    final String url = '${Apis._getById}/$id';
    var response = await BaseApiService().getRequest(
      url: url,
    );
    return DutyPostNameMasterModel.fromJson(response);
  }

  /// Create Services

  Future<GenericResponse> create({
    required DutyPostNameMasterRequest body,
    required bool isSubmit,
  }) async {
    final String url = "${Apis._create}&isSubmit=$isSubmit";
    log("API URL------2-2-2-2-2-: $url");
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }

  Future<MessageResponse> checkDutyPostNameExists(
      {required int locationId}) async {
    final String url = '${Apis._checkDutyPostNameExists}locationId=$locationId';
    var response = await BaseApiService().getRequest(
      url: url,
    );
    return MessageResponse.fromJson(response);
  }
}
