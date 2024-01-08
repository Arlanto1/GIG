import 'dart:developer';

import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/annual_power_shutdown_list/annual_power_shutdown_list/models/annual_power_shutdown_model.dart';
import 'package:db_atom/src/features/annual_power_shutdown_list/models/annual_power_shutdown_list_model.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';

import '../../../models/responseModels/generic_response.dart';
import '../models/requestModel/annual_power_shutdown_list_request.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getAnnualPowerShutdownList = '$baseUrl/getEPLists?';

  static final String _getGI = '$baseUrl/getEPGIById';

  static final String _createAnnualPowerShutdownList = '$baseUrl/createEPGI?';
}

class AnnualPowerShutdownListServices {
  Future<String> getUserEmail() async {
    String email = await SharedPrefs.getEmail();
    return email;
  }

  Future<AnnualPowerShutDownResponse> getAnnualPowerShutdownList({
    required String startPosition,
    required String maximumRecords,
    required String userId,
  }) async {
    String url =
        '${Apis._getAnnualPowerShutdownList}startPos=$startPosition&maxResults=$maximumRecords&userId=${await SharedPrefs.getUserId()}';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return AnnualPowerShutDownResponse.fromJson(response);
  }

  Future<AnnualPowerShutdownListModel> getById(String id) async {
    final String url = '${Apis._getGI}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return AnnualPowerShutdownListModel.fromJson(response);
  }

  Future<GenericResponse> createAnnualPowerShutdownList({
    required AnnualPowerShutdownListRequest body,
    required bool isSubmit,
    // required int eventDuration,
  }) async {
    var userId = await SharedPrefs.getUserId();
    final String url =
        "${Apis._createAnnualPowerShutdownList}?userEmail=$userId&isSubmit=$isSubmit";
    log("API URL------2-2-2-2-2-: $url");
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }
}
