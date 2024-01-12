import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_name_master/models/duty_post_name_master_model.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_name_master/models/requestModel/duty_post_name_master_request.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getList = '$baseUrl/getDpnList?';

  static final String _getById = '$baseUrl/getDpnById';

  static final String _create = '$baseUrl/createDpn?';
}

class DutyPostNameMasterServices {
  Future<String> getUserEmail() async {
    String email = await SharedPrefs.getEmail();
    return email;
  }

  Future<DutyPostNameMasterResponse> getList({
    required String startPosition,
    required String maximumRecords,
  }) async {
    String url =
        '${Apis._getList}startPos=$startPosition&maxResults=$maximumRecords';
    final response = await BaseApiService().getRequest(
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
    final String url =
        "${Apis._create}&isSubmit=$isSubmit";
    log("API URL------2-2-2-2-2-: $url");
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }
}
