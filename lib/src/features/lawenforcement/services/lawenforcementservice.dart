import 'package:db_atom/main_DEV.dart';
import 'package:db_atom/src/appservices/app_service_handler.dart';
import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/createfound/models/create_user_model.dart';
import 'package:db_atom/src/features/createfound/models/emplyee_departments_model.dart';
import 'package:db_atom/src/features/createfound/models/get_depositor_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/serial_number_model.dart';
import 'package:db_atom/src/features/lawenforcement/models/addentities.dart';
import 'package:db_atom/src/features/lawenforcement/models/distribution_model.dart';
import 'package:db_atom/src/features/lawenforcement/models/law_enforement_request.dart';
import 'package:db_atom/src/features/lawenforcement/models/leodepartments.dart';
import 'package:db_atom/src/features/lawenforcement/models/leopurposevisit.dart';
import 'package:db_atom/src/features/lawenforcement/models/submit_law_enforcement_response.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';

import '../../../models/organisation.dart';
import '../../createfound/models/user.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _create = '$baseUrl/saveLawEnfrcmnt';
}

class LawEnforcementService {
  final endpoint = Environment().config.apiHost;

  Future<SubmitLawEnforcementResponse> createLawFoundArticle({
    required LawEnforcementRequestBody body,
    required bool isSubmit,
    BuildContext? context,
  }) async {
    var username = await SharedPrefs.getUsername();
    final String url = "${Apis._create}?userEmail=$username&isSubmit=$isSubmit";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return SubmitLawEnforcementResponse.fromJson(response);
  }

  // get Entities api call
  Future<AddEntities> getEntities(String name, BuildContext context) async {
    var value = await AppServicesHandler()
        .globalpopupGetServiceCall('/getOrganisation?name=$name', context);

    return AddEntities.fromJson(value);
  }

  //Get locations
  Future<GetLocations> getLocations(
      String locationStr, BuildContext context) async {
    var value = await AppServicesHandler().globalpopupGetServiceCall(
        '/getOrganisation?name=$locationStr', context);

    return GetLocations.fromJson(value);
  }

  // get serailnumber Details api call
  Future<SerialNumberModel> getSerialnumberDetails(
      String locationId, String moduleCode, BuildContext context) async {
    var value = await AppServicesHandler().globalpopupGetServiceCall(
        '/getSlNo?locationId=$locationId&moduleCode=$moduleCode', context);

    return SerialNumberModel.fromJson(value);
  }

  // get Entities api call
  Future<LeoPurposeVisit> getLeopurposeofvisit(
      String name, BuildContext context) async {
    var value = await AppServicesHandler()
        .globalpopupGetServiceCall('/getOrganisation?name=$name', context);

    return LeoPurposeVisit.fromJson(value);
  }

  Future<LeoDepartments> getLeodepartments(
      String name, BuildContext context) async {
    var value = await AppServicesHandler()
        .globalpopupGetServiceCall('/getOrganisation?name=$name', context);

    return LeoDepartments.fromJson(value);
  }

  Future<GetDepositor> getDBOfficialdepartments(
      String name, BuildContext context) async {
    var value = await AppServicesHandler()
        .globalpopupGetServiceCall('/getUsersByRole?roleName=$name', context);

    return GetDepositor.fromJson(value);
  }

  //Get Employee Departments
  Future<EmployeeDepartments> getEmployeeDepartments(
      String departmentStr, BuildContext context) async {
    var value = await AppServicesHandler().globalpopupGetServiceCall(
        '/getOrganisation?name=$departmentStr', context);

    return EmployeeDepartments.fromJson(value);
  }

  // get user Details api call
  Future<User> getUserDetails(String userId, BuildContext context) async {
    var value = await AppServicesHandler()
        .globalpopupGetServiceCall('/getUserDetails?userId=$userId', context);

    return User.fromJson(value);
  }

  // get distribution group Details api call
  Future<DistributionGroupModel> getDistributiongroupDetails(
      BuildContext context) async {
    var value = await AppServicesHandler()
        .globalpopupGetServiceCall('/getGroup', context);

    return DistributionGroupModel.fromJson(value);
  }

  // Create organisation api call
  Future<Organisation> createOrganisation(
      String name, String orgName, BuildContext context) async {
    var value = await AppServicesHandler().globalPostServiceCall(
        '/createOrganisation?name=$name&orgName=$orgName', context, '');

    return Organisation.fromJson(value);
  }

// Create user api call
  Future<CreateUserModel> createUser(String firstName, String lastName,
      String email, String role, BuildContext context) async {
    var value = await AppServicesHandler().globalPostServiceCall(
        '/createUser?firstName=$firstName&lastName=$lastName&email=$email&role=$role',
        context,
        '');

    return CreateUserModel.fromJson(value);
  }
}
