import 'dart:developer';

import 'package:db_atom/index.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _createPass = '$baseUrl/createPass?';
  static final String getOrganisation = '$baseUrl/getOrganisation?name=';
  static final String _getUsersByRole = '$baseUrl/getUsersByRole?roleName=';
  static final String _getPassNo = '$baseUrl/getActivePassInfo?passType=';
  static final String _getPassValidUntil = '$baseUrl/getPassValidUntil?';
  static final String _getPassTypes = '$baseUrl/getPassType?';
}

class CreatePassMgmtService {
  final endpoint = Environment().config.apiHost;

  Future<CreatePassMgmtResponse> createPass({
    required CreatePassMgmtBody requestBody,
    required bool isSubmit,
  }) async {
    final String url = "${Apis._createPass}isSubmit=$isSubmit";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: requestBody.toJson(),
    );
    return CreatePassMgmtResponse.fromJson(response);
  }

  /// get Entities api call
  Future<AddEntities> getEntities({
    required String name,
  }) async {
    String url = '${Apis.getOrganisation}$name';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return AddEntities.fromJson(response);
  }

  Future<GetDepositor> getUserByRoleDepositor({
    required String roleName,
    int? locationId,
  }) async {
    String url = '${Apis._getUsersByRole}$roleName';
    if (locationId != null) {
      url = '$url&locationId=$locationId';
    }
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return GetDepositor.fromJson(response);
  }

  Future<DayPassNumberLists> getPassNo({
    required int passType,
    required int locationId,
    required bool isDwsPass,
  }) async {
    String url = '${Apis._getPassNo}$passType&locationId=$locationId&isDwsPass=$isDwsPass';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return DayPassNumberLists.fromJson(response);
  }

  Future<String> getPassValidUntil({required int passCategory}) async {
    final String url = '${Apis._getPassValidUntil}category=$passCategory';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return response['date'];
  }

  Future<List<Organisation>> getPassTypes({
    required int passId,
    required int locationId,
    BuildContext? context,
  }) async {
    String url = '${Apis._getPassTypes}passType=$passId&locationId=$locationId';
    final response = await BaseApiService().getRequest(
      url: url,
    );

    log('----response----${response.toString()}----');

    return List<Organisation>.from(
        response.map((x) => Organisation.fromJson(x)));
  }
}
