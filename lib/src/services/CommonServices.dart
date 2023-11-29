import 'dart:developer';

import 'package:db_atom/main_DEV.dart';
import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/contact_details/models/contact_rank_response.dart';
import 'package:db_atom/src/features/createfound/models/emplyee_departments_model.dart';
import 'package:db_atom/src/features/createfound/models/get_articletype_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/serial_number_model.dart';
import 'package:db_atom/src/features/lawenforcement/models/addQualifications.dart';
import 'package:db_atom/src/features/material_movement/models/quantity_units.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/analyst_model.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/day_pass_reason_model.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/vendor_pass_reason_model.dart';
import 'package:db_atom/src/models/organisation.dart';

import '../features/createfound/models/create_user_model.dart';
import '../features/createfound/models/get_depositor_model.dart';
import '../features/createfound/models/user.dart';
import '../features/createfound/models/vendors_model.dart';
import '../features/lawenforcement/models/addentities.dart';
import '../features/material_movement/models/mm_ui_labels.dart';
import '../features/passmanagement/daypassmgmt/createpassmgmt/models/company_type_model.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;
  static const String v2 = '';

  // static const String v2 = '/v2';
  static final String _getUiLabels = '$baseUrl/getLabels?';
  static final String _getRanks = '$baseUrl/getOrganisation?name=';
  static final String _getLocations = '$baseUrl/getOrganisation?name=';
  static final String _getArticleType = '$baseUrl/getOrganisation?name=';
  static final String _getUserDetails = '$baseUrl/getUserDetails?userId=';
  static final String _getSlNo = '$baseUrl/getSlNo?';
  static final String _getUsersByRole = '$baseUrl/getUsersByRole?roleName=';
  static final String _getQuantityUnits =
      '$baseUrl$v2/getOrganisation?name=ATOM_MATERIAL_MOVEMENT_UNIT';
  static final String _getQualification =
      '$baseUrl$v2/getOrganisation?name=GUARD_QUALIFICATIONS';
  static final String _getUsers = '$baseUrl/getUsers?roleName=ATOM_STATIC_USER';

  static final String _createOrganisation = '$baseUrl/createOrganisation?';
  static final String _createUser = '$baseUrl/createUser?';
}

class CommonServices {

  Future<dynamic> getUiLabels({
    required String language,
    required String moduleCode,
    BuildContext? context,
  }) async {
    log('---language--$language---');
    String url = '${Apis._getUiLabels}locale=$language&module=$moduleCode';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return response;
  }

  Future<ContactRankResponse> getRanks({
    required String name,
    BuildContext? context,
  }) async {
    String url = '${Apis._getRanks}$name';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return ContactRankResponse.fromJson(response);
  }

  Future<Locations> getLocations({
    required String name,
    BuildContext? context,
  }) async {
    String url = '${Apis._getLocations}$name';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return Locations.fromJson(response);
  }

  Future<CompanyTypes> getCompanyTypes({
    required String name,
    BuildContext? context,
  }) async {
    String url = '${Apis._getLocations}$name';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return CompanyTypes.fromJson(response);
  }

  Future<DayPassReason> getDayPassreason({
    required String name,
    BuildContext? context,
  }) async {
    String url = '${Apis._getLocations}$name';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return DayPassReason.fromJson(response);
  }

  Future<VendorPassReason> getVendorPassReason({
    required String name,
    BuildContext? context,
  }) async {
    String url = '${Apis._getLocations}$name';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return VendorPassReason.fromJson(response);
  }

  Future<EmployeeDepartments> getDepartments({
    required String name,
    BuildContext? context,
  }) async {
    String url = '${Apis._getLocations}$name';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return EmployeeDepartments.fromJson(response);
  }

  Future<Vendors> getVendors({
    required String name,
  }) async {
    String url = '${Apis._getLocations}$name';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return Vendors.fromJson(response);
  }

  Future<GetArticleType> getArticleType({
    required String name,
    BuildContext? context,
  }) async {
    String url = '${Apis._getArticleType}$name';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return GetArticleType.fromJson(response);
  }

  Future<User> getUserDetails({
    required String userId,
    BuildContext? context,
  }) async {
    String url = '${Apis._getUserDetails}$userId';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return User.fromJson(response);
  }

  Future<SerialNumberModel> getSlNo({
    required String locationId,
    required String moduleCode,
    BuildContext? context,
  }) async {
    String url =
        '${Apis._getSlNo}locationId=$locationId&moduleCode=$moduleCode';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return SerialNumberModel.fromJson(response);
  }

  Future<Analyst> getUsersByRole({
    required String roleName,
    BuildContext? context,
  }) async {
    String url = '${Apis._getUsersByRole}$roleName';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return Analyst.fromJson(response);
  }

  Future<GetDepositor> getAtomStaticUsers({
    required String roleName,
    BuildContext? context,
  }) async {
    String url = '${Apis._getUsersByRole}$roleName';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return GetDepositor.fromJson(response);
  }

  Future<QuantityUnits> getQuantityUnits() async {
    String url = Apis._getQuantityUnits;
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return QuantityUnits.fromJson(response);
  }

  Future<AddEntities> getEntities({
    required String name,
  }) async {
    String url = '${Apis._getLocations}$name';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return AddEntities.fromJson(response);
  }

  Future<AddQualifications> getQualification({
    required String name,
  }) async {
    String url = Apis._getQualification;
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return AddQualifications.fromJson(response);
  }

  Future<List<User>> getUsers() async {
    String url = Apis._getUsers;
    final response = await BaseApiService().getRequest(
      url: url,
    );

    return List<User>.from(response.map((x) => User.fromJson(x)));
  }

  Future<Organisation> createOrganisation({
    required String name,
    required String orgName,
    BuildContext? context,
  }) async {
    final String url = "${Apis._createOrganisation}name=$name&orgName=$orgName";
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return Organisation.fromJson(response);
  }
  Future<CreateUserModel> createUser({
    required String firstName, required String lastName,
    required String email, required String role,
    BuildContext? context,
  }) async {
    final String url = "${Apis._createUser}firstName=$firstName&lastName=$lastName&email=$email&role=$role";
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return CreateUserModel.fromJson(response);
  }
}
