import 'dart:developer';

import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_master_data/models/requestModels/guarding_master_data_request.dart';

import '../../../../utils/shared_preferences.dart';
import '../../../material_movement/models/responseModels/material_movement_response.dart';
import '../models/guarding_master_data_model.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getGuardingMastersData = '$baseUrl/getGMData?';

  static final String _getGuardingMasterData = '$baseUrl/getGMDataById';

  static final String _createGuardingMasterData = '$baseUrl/createGMData?';
}

class GuardingMasterDataServices {
  Future<GuardingMasterDataResponse> getGuardingMasterData({
    required String startPosition,
    required String maximumRecords,
    required String userId,
    required String locationId,
  }) async {
    String url =
        '${Apis._getGuardingMastersData}startPos=$startPosition&maxResults=$maximumRecords&userId=$userId&locationId=$locationId';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return GuardingMasterDataResponse.fromJson(response);
  }

  Future<GuardingMastersDataModel> getGuardingMastersData(int id) async {
    final String url = '${Apis._getGuardingMasterData}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return GuardingMastersDataModel.fromJson(response);
  }

  /// Create Services

  Future<GenericCreateResponse> createGuardingMasterData({
    required GuardingMasterDataRequest body,
    required bool isSubmit,
  }) async {
    var userId = await SharedPrefs.getUserId();
    final String url =
        "${Apis._createGuardingMasterData}?userEmail=$userId&isSubmit=$isSubmit";
    log("API URL------2-2-2-2-2-: $url");
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericCreateResponse.fromJson(response);
  }
}
