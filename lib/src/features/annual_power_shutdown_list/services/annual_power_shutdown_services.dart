import 'dart:developer';

import 'package:db_atom/index.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getAnnualPowerShutdownList =
      '$baseUrl/getEPLists?aps=1&';

  static final String _getGI = '$baseUrl/getEPGIById';

  static final String _createAnnualPowerShutdownList = '$baseUrl/createEPGI';
  static final String _getEpGuardBudgetCost = '$baseUrl/getEpGuardBudgetCost';
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
        '${Apis._getAnnualPowerShutdownList}startPos=$startPosition&maxResults=$maximumRecords';
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

  Future<BudgetCostModel> getEpGuardBudgetCost({
    required BudgetCostModel body,
  }) async {
    final String url = Apis._getEpGuardBudgetCost;
    log("API URL------2-2-2-2-2-: $url");
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return BudgetCostModel.fromJson(response);
  }
}
