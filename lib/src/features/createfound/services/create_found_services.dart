import 'package:db_atom/src/appservices/app_service_handler.dart';
import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/create_found_submit_model.dart';
import 'package:db_atom/src/features/createfound/models/create_user_model.dart';
import 'package:db_atom/src/features/createfound/models/emplyee_departments_model.dart';
import 'package:db_atom/src/features/createfound/models/get_articletype_model.dart';
import 'package:db_atom/src/features/createfound/models/get_depositor_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/serial_number_model.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:flutter/material.dart';

import '../../../models/organisation.dart';
import '../models/user.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;


  static final String _getMaterialMovement = '$baseUrl/getMMById';

  static final String _addFound = '$baseUrl/addFound';
}

class CreateFoundServices {
  final endpoint = Environment().config.apiHost;

  // Future<SubmitCreateFoundModel> createFoundArticle(
  //     CreateFoundRequestBody requestBody,
  //     bool isSubmit,
  //     String username,
  //     BuildContext context) async {
  //   var value = await AppServicesHandler().globalPostServiceCall(
  //       '/addFound?isSubmit=$isSubmit&userEmail=username',
  //       context,
  //       json.encode(requestBody));
  //
  //   return SubmitCreateFoundModel.fromJson(value);
  // }
  /// Create Services
  Future<SubmitCreateFoundModel> createFoundArticle({
    required CreateFoundRequestBody body,
    required bool isSubmit,
    required String username,
    BuildContext? context,
  }) async {
    var userId = await SharedPrefs.getUserId();
    final String url =
        "${Apis._addFound}?userEmail=$userId&isSubmit=$isSubmit";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return SubmitCreateFoundModel.fromJson(response);
  }
  Future<SubmitCreateFoundModel> createFoundArticleHandle(
      Map<String, dynamic> requestBody,
      bool isSubmit,
      String username,
      BuildContext context) async {
    print(requestBody);

    var userId = await SharedPrefs.getUserId();
    final String url =
        "${Apis._addFound}?userEmail=$userId&isSubmit=$isSubmit";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: requestBody,
    );
    return SubmitCreateFoundModel.fromJson(response);
  }

  //Get Depositor users by role
  Future<GetDepositor> getUserByRoleDepositor(
      String userRole, BuildContext context) async {
    var value = await AppServicesHandler().globalpopupGetServiceCall(
        '/getUsersByRole?roleName=$userRole', context);

    return GetDepositor.fromJson(value);
  }

  //Get locations
  Future<GetLocations> getLocations(
      String locationStr, BuildContext context) async {
    var value = await AppServicesHandler().globalpopupGetServiceCall(
        '/getOrganisation?name=$locationStr', context);

    return GetLocations.fromJson(value);
  }

  //Get Employee Departments
  Future<EmployeeDepartments> getEmployeeDepartments(
      String departmentStr, BuildContext context) async {
    var value = await AppServicesHandler().globalpopupGetServiceCall(
        '/getOrganisation?name=$departmentStr', context);

    return EmployeeDepartments.fromJson(value);
  }

  //Get Article Type
  Future<GetArticleType> getArticleType(
      String articleTypeStr, BuildContext context) async {
    var value = await AppServicesHandler().globalpopupGetServiceCall(
        '/getOrganisation?name=$articleTypeStr', context);

    return GetArticleType.fromJson(value);
  }

  // Create organisation api call
  // Future<Organisation> createOrganisation(
  //     String name, String orgName, BuildContext context) async {
  //   var value = await AppServicesHandler().globalPostServiceCall(
  //       '/createOrganisation?name=$name&orgName=$orgName', context, '');
  //
  //   return Organisation.fromJson(value);
  // }



  // Create user api call
  Future<CreateUserModel> createUser(String firstName, String lastName,
      String email, String role, BuildContext context) async {
    var value = await AppServicesHandler().globalPostServiceCall(
        '/createUser?firstName=$firstName&lastName=$lastName&email=$email&role=$role',
        context,
        '');

    return CreateUserModel.fromJson(value);
  }

  // get user Details api call
  Future<User> getUserDetails(String userId, BuildContext context) async {
    var value = await AppServicesHandler()
        .globalpopupGetServiceCall('/getUserDetails?userId=$userId', context);

    return User.fromJson(value);
  }

  // get serailnumber Details api call
  Future<SerialNumberModel> getSerialnumberDetails(
      String locationId, String moduleCode, BuildContext context) async {
    var value = await AppServicesHandler().globalpopupGetServiceCall(
        '/getSlNo?locationId=$locationId&moduleCode=$moduleCode', context);

    return SerialNumberModel.fromJson(value);
  }
}
