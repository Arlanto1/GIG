import 'dart:developer';

import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/models/rates_response.dart';

import '../../../../models/responseModels/generic_creat_response.dart';
import '../../../../utils/shared_preferences.dart';
import '../models/drop_pick_up_response.dart';
import '../models/request/gm_rate_request.dart';
import '../models/request/pay_rate_request.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getRates = '$baseUrl/getGMRates?';
  static final String _getRate = '$baseUrl/getGMRateById/';
  static final String _createRate = '$baseUrl/createGMRate';
  static final String _createPayRate = '$baseUrl/createGuardRankRate';
  static final String _getFemaleDropPickUps= '$baseUrl/getDropPickup?';
}

class GuardingServices {

  Future<String> getUserEmail() async {
    String email =  await SharedPrefs.getEmail();
    return email;
  }

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
  Future<GenericCreateResponse> createGmRate({
    required GMRateRequest body,
    required bool isSubmit,
  }) async {
    final String url =
        "${Apis._createRate}?userEmail=${await getUserEmail()}&isSubmit=$isSubmit";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericCreateResponse.fromJson(response);
  }

  Future<GenericCreateResponse> createPayRate({
    required PayRateRequest body,
    required bool isSubmit,
    required String griId,
  }) async {
    final String url =
        "${Apis._createPayRate}?userEmail=${await getUserEmail()}&griId=$griId";
    log("API URL------2-2-2-2-2-: $url");
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericCreateResponse.fromJson(response);
  }



  Future<DropPickUpResponse> getFemaleDropPickUps({
    required String startPosition,
    required String maximumRecords,
    required String userId,
  }) async {
    String url =
        '${Apis._getFemaleDropPickUps}startPos=$startPosition&maxResults=$maximumRecords&userId=$userId';

    final response = await BaseApiService().getRequest(
      url: url,
    );

    return DropPickUpResponse.fromJson(response);
  }
}
