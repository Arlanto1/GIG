import 'dart:convert';

import 'package:db_atom/main_DEV.dart';
import 'package:db_atom/src/appservices/app_service_handler.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/createfound/models/create_user_model.dart';
import 'package:db_atom/src/features/createfound/models/emplyee_departments_model.dart';
import 'package:db_atom/src/features/createfound/models/get_depositor_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/lawenforcement/models/addentities.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/create_pass_mgmt_request_body.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/create_pass_mgmt_response.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/day_pass_numbers_list.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';

import '../../../../../configurations/base_api_service.dart';
import '../../../../../models/organisation.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _createPass = '$baseUrl/createPass?';
  static final String getOrganisation = '$baseUrl/getOrganisation?name=';
  static final String _getUsersByRole = '$baseUrl/getUsersByRole?roleName=';
  static final String _getPassNo = '$baseUrl/getActivePassInfo?passType=';
  static final String _createUser = '$baseUrl/createUser?';

}

class CreatePassMgmtService {
  final endpoint = Environment().config.apiHost;

  // Create user api call
  Future<CreateUserModel> createUser(
      String firstName,  String lastName,
      String email,  String role,
      BuildContext? context,
      ) async {
    final String url = "${Apis._createUser}firstName=$firstName&lastName=$lastName&email=$email&role=$role";
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

  Future<CreatePassMgmtResponse> createLawFoundArticleHandle(
      Map<String, dynamic> requestBody,
      bool isSubmit,
      String username,
      BuildContext context) async {
    var value = await AppServicesHandler().globalPostServiceCall(
        '/createPass?isSubmit=$isSubmit&userEmail=username',
        context,
        json.encode(requestBody));

    return CreatePassMgmtResponse.fromJson(value);
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

  Future<GetLocations> getLocations({
    required String name,
  }) async {
    String url = '${Apis.getOrganisation}$name';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return GetLocations.fromJson(response);
  }

  //Get Employee Departments
  Future<EmployeeDepartments> getEmployeeDepartments(
      String departmentStr, BuildContext context) async {
    var value = await AppServicesHandler().globalpopupGetServiceCall(
        '/getOrganisation?name=$departmentStr', context);

    return EmployeeDepartments.fromJson(value);
  }


  // Create organisation api call
  Future<Organisation> createOrganisation(
      String name, String orgName, BuildContext context) async {
    var value = await AppServicesHandler().globalpopupGetServiceCall(
        '/createOrganisation?name=$name&orgName=$orgName', context);

    return Organisation.fromJson(value);
  }

  Future<DayPassNumberLists> getPassNo(
      String passtype, String locatonid, BuildContext context) async {
    String url = '${Apis._getPassNo}$passtype&locationId=$locatonid';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return DayPassNumberLists.fromJson(response);
  }
}
