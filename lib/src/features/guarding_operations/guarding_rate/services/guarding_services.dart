import 'dart:developer';

import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/models/rates_response.dart';

import '../../../../utils/shared_preferences.dart';
import '../../../material_movement/models/responseModels/material_movement_response.dart';
import '../models/request/gm_rate_request.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getRates = '$baseUrl/getGMRates?';
  static final String _getRate = '$baseUrl/getGMRateById/';
  static final String _createRate = '$baseUrl/createGMRate';
}

class GuardingServices {
  Future<RatesResponse> getRates({
    required String startPosition,
    required String maximumRecords,
    required String userId,
  }) async {
    String url =
        '${Apis._getRates}startPos=$startPosition&maxResults=$maximumRecords&userId=$userId';

    final response = await BaseApiService().getRequest(
      url: url,
    );

    return RatesResponse.fromJson(response);
  }

  Future<GMRate> getRate(int id) async {
    final String url = '${Apis._getRate}$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return GMRate.fromJson(response);
  }

  /// Create
  Future<MaterialMovementResponse> createGmRate({
    required GMRateRequest body,
    required bool isSubmit,
  }) async {
    var userId = await SharedPrefs.getUserId();
    final String url =
        "${Apis._createRate}?userEmail=$userId&isSubmit=$isSubmit";
    log("API URL------2-2-2-2-2-: $url");
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return MaterialMovementResponse.fromJson(response);
  }
}
