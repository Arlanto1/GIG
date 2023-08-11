import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/get_user_model.dart';
import 'package:db_atom/src/features/createfound/models/serial_number_model.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/analyst_model.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getLocations = '$baseUrl/getOrganisation?name=';
  static final String _getUserDetails = '$baseUrl/getUserDetails?userId=';
  static final String _getSlNo = '$baseUrl/getSlNo?';
  static final String _getUsersByRole = '$baseUrl/getUsersByRole?roleName=';
}

class CommonServices {
  Future<GetLocations> getLocations({
    required String locationName,
  }) async {
    String url = '${Apis._getLocations}$locationName';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return GetLocations.fromJson(response);
  }

  Future<GetUserDetails> getUserDetails({
    required String userId,
  }) async {
    String url = '${Apis._getUserDetails}$userId';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return GetUserDetails.fromJson(response);
  }

  Future<SerialNumberModel> getSlNo({
    required String locationId,
    required String moduleCode,
  }) async {
    String url = '${Apis._getSlNo}locationId=$locationId&moduleCode=$moduleCode';
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

}
