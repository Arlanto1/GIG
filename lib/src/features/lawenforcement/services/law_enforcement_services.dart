import 'package:db_atom/main_DEV.dart';
import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/createfound/models/create_user_model.dart';
import 'package:db_atom/src/features/createfound/models/emplyee_departments_model.dart';
import 'package:db_atom/src/features/createfound/models/get_depositor_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/serial_number_model.dart';
import 'package:db_atom/src/features/law_enforcement_list/models/law_enforcement_details.dart';
import 'package:db_atom/src/features/law_enforcement_list/models/law_enforcement_list_response.dart';
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

  static final String _getList = '$baseUrl/getLawEnfrcmntList?';
  static final String _getById = '$baseUrl/getLawEnfrcmnt';
  static final String _create = '$baseUrl/saveLawEnfrcmnt';
  static final String _getLocations = '$baseUrl/getOrganisation?name=';
  static final String _getSlNo = '$baseUrl/getSlNo?';
  static final String _getUsersByRole = '$baseUrl/getUsersByRole?roleName=';
  static final String _getUserDetails = '$baseUrl/getUserDetails?userId=';
  static final String _getGroup = '$baseUrl/getGroup';
  static final String _createOrganisation = '$baseUrl/createOrganisation?';
  static final String _createUser = '$baseUrl/createUser?';
}

class LawEnforcementServices {
  final endpoint = Environment().config.apiHost;

  Future<LawEnforcementListResponse> getList({
    required String startPosition,
    required String maximumRecords,
    required String userId,
    BuildContext? context,
  }) async {
    String url =
        '${Apis._getList}startPos=$startPosition&maxResults=$maximumRecords&userId=$userId';
    var response = await BaseApiService().getRequest(
      isAuthenticated: true,
      url: url,
    );
    return LawEnforcementListResponse.fromJson(response);
  }

  Future<LawEnforcementDetails> getById(
    int id,
    BuildContext context,
  ) async {
    final String url = '${Apis._getById}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
      isAuthenticated: true,
    );

    return LawEnforcementDetails.fromJson(response);
  }

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
  Future<AddEntities> getEntities(
    String name,
  ) async {
    String url = '${Apis._getLocations}$name';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return AddEntities.fromJson(response);
  }

  //Get locations
  Future<GetLocations> getLocations(String name, BuildContext? context) async {
    String url = '${Apis._getLocations}$name';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return GetLocations.fromJson(response);
  }

  // get serailnumber Details api call
  Future<SerialNumberModel> getSerialnumberDetails(
    String locationId,
    String moduleCode,
    BuildContext? context,
  ) async {
    String url =
        '${Apis._getSlNo}locationId=$locationId&moduleCode=$moduleCode';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return SerialNumberModel.fromJson(response);
  }

  Future<LeoPurposeVisit> getLeopurposeofvisit(
      String name, BuildContext? context) async {
    String url = '${Apis._getLocations}$name';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return LeoPurposeVisit.fromJson(response);
  }

  Future<LeoDepartments> getLeodepartments(
      String name, BuildContext? context) async {
    String url = '${Apis._getLocations}$name';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return LeoDepartments.fromJson(response);
  }

  Future<GetDepositor> getDBOfficialdepartments(
    String roleName,
    BuildContext? context,
  ) async {
    String url = '${Apis._getUsersByRole}$roleName';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return GetDepositor.fromJson(response);
  }

  //Get Employee Departments
  Future<EmployeeDepartments> getEmployeeDepartments(
      String name, BuildContext? context) async {
    String url = '${Apis._getLocations}$name';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return EmployeeDepartments.fromJson(response);
  }

  Future<User> getUserDetails(
    String userId,
    BuildContext? context,
  ) async {
    String url = '${Apis._getUserDetails}$userId';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return User.fromJson(response);
  }

  Future<DistributionGroupModel> getDistributiongroupDetails(
    BuildContext? context,
  ) async {
    String url = '${Apis._getGroup}';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return DistributionGroupModel.fromJson(response);
  }

  Future<Organisation> createOrganisation(
    String name,
    String orgName,
    BuildContext? context,
  ) async {
    final String url = "${Apis._createOrganisation}name=$name&orgName=$orgName";
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return Organisation.fromJson(response);
  }

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
}
