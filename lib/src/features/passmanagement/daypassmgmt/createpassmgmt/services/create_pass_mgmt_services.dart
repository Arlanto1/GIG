import 'dart:developer';

import 'package:db_atom/index.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _createPass = '$baseUrl/createPass?';
  static final String getOrganisation = '$baseUrl/getOrganisation?name=';
  static final String _getUsersByRole = '$baseUrl/getUsersByRole?roleName=';
  static final String _getPassNo = '$baseUrl/getActivePassInfo?passType=';
  static final String _createUser = '$baseUrl/createUser?';
  static final String _getPassValidUntil = '$baseUrl/getPassValidUntil?';
  static final String _getPassTypes = '$baseUrl/getPassType?';
}

class CreatePassMgmtService {
  final endpoint = Environment().config.apiHost;

  // Create user api call
  Future<CreateUserModel> createUser(
    String firstName,
    String lastName,
    String email,
    String role,
    BuildContext? context,
  ) async {
    final String url =
        "${Apis._createUser}firstName=$firstName&lastName=$lastName&email=$email&role=$role";
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return CreateUserModel.fromJson(response);
  }

  Future<CreatePassMgmtResponse> createPass({
    required CreatePassMgmtBody requestBody,
    required bool isSubmit,
  }) async {
    var getUsername = await SharedPrefs.getUserId();

    final String url =
        "${Apis._createPass}userEmail=$getUsername&isSubmit=$isSubmit";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: requestBody.toJson(),
    );
    return CreatePassMgmtResponse.fromJson(response);
  }

  /// get Entities api call
  Future<AddEntities> getEntities({
    required String name,
    required BuildContext context,
  }) async {
    String url = '${Apis.getOrganisation}$name';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return AddEntities.fromJson(response);
  }

  Future<GetDepositor> getUserByRoleDepositor({
    required String roleName,
  }) async {
    String url = '${Apis._getUsersByRole}$roleName';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return GetDepositor.fromJson(response);
  }

  Future<DayPassNumberLists> getPassNo(
      String passType, String locationId, BuildContext context) async {
    String url = '${Apis._getPassNo}$passType&locationId=$locationId';
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

  Future<List<String>> getPassTypes({
    required int passId,
    required int locationId,
    BuildContext? context,
  }) async {
    String url = '${Apis._getPassTypes}passType=$passId&locationId=$locationId';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return List<String>.from(response);
  }
}
