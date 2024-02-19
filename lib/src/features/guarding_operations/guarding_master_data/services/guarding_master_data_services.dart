import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_master_data/models/requestModels/guarding_master_data_request.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getGuardingMastersData = '$baseUrl/getGMData?';

  static final String _getGuardingMasterData = '$baseUrl/getGMDataById';

  static final String _createGuardingMasterData = '$baseUrl/createGMData?';
  static final String _getGmPhysicallyFit = '$baseUrl/getGmPhysicallyFit?';
}

class GuardingMasterDataServices {
  Future<String> getUserEmail() async {
    String email = await SharedPrefs.getEmail();
    return email;
  }

  Future<GuardingMasterDataResponse> getGuardingMasterData({
    required String startPosition,
    required String maximumRecords,
    // required String userId,
    required String locationId,
  }) async {
    String url =
        '${Apis._getGuardingMastersData}startPos=$startPosition&maxResults=$maximumRecords&locationId=$locationId';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return GuardingMasterDataResponse.fromJson(response);
  }

  Future<GuardingMastersDataModel> getGuardingMastersData(int id) async {
    final String url = '${Apis._getGuardingMasterData}/$id';
    var response = await BaseApiService().getRequest(
      url: url,
    );
    return GuardingMastersDataModel.fromJson(response);
  }

  /// Create Services

  Future<GenericResponse> createGuardingMasterData({
    required GuardingMasterDataRequest body,
    required bool isSubmit,
  }) async {
    final String url =
        "${Apis._createGuardingMasterData}userEmail=${await getUserEmail()}&isSubmit=$isSubmit";
    log("API URL------2-2-2-2-2-: $url");
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }

  Future<PhysicallyFitModel> getGmPhysicallyFit({
    required PhysicallyFitRequestModel body,
  }) async {
    final String url = Apis._getGmPhysicallyFit;
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return PhysicallyFitModel.fromJson(response);
  }
}
