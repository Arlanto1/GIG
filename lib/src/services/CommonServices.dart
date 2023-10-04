import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/createfound/models/emplyee_departments_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/serial_number_model.dart';
import 'package:db_atom/src/features/lawenforcement/models/addQualifications.dart';
import 'package:db_atom/src/features/material_movement/models/quantity_units.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/analyst_model.dart';

import '../features/createfound/models/get_depositor_model.dart';
import '../features/createfound/models/user.dart';
import '../features/lawenforcement/models/addentities.dart';
import '../models/entry_security.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getLocations = '$baseUrl/getOrganisation?name=';
  static final String _getUserDetails = '$baseUrl/getUserDetails?userId=';
  static final String _getSlNo = '$baseUrl/getSlNo?';
  static final String _getUsersByRole = '$baseUrl/getUsersByRole?roleName=';
  static final String _getQuantityUnits =
      '$baseUrl/getOrganisation?name=ATOM_MATERIAL_MOVEMENT_UNIT';
  static final String _getQualification =
      '$baseUrl/getOrganisation?name=GUARD_QUALIFICATIONS';
  static final String _getUsers = '$baseUrl/getUsers?roleName=ATOM_STATIC_USER';
}

class CommonServices {
  Future<GetLocations> getLocations({
    required String name,
  }) async {
    String url = '${Apis._getLocations}$name';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return GetLocations.fromJson(response);
  }

  Future<EmployeeDepartments> getDepartments({
    required String name,
  }) async {
    String url = '${Apis._getLocations}$name';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return EmployeeDepartments.fromJson(response);
  }

  Future<EntrySecurity> getUserDetails({
    required String userId,
  }) async {
    String url = '${Apis._getUserDetails}$userId';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return EntrySecurity.fromJson(response);
  }

  Future<SerialNumberModel> getSlNo({
    required String locationId,
    required String moduleCode,
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
  }) async {
    String url = '${Apis._getUsersByRole}$roleName';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return Analyst.fromJson(response);
  }

  Future<GetDepositor> getAtomStaticUsers({
    required String roleName,
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

    return List<User>.from(
        response.map((x) => User.fromJson(x)));
    // return [];
  }
}
