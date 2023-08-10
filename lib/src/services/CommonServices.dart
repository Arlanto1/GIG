import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/get_user_model.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getLocations = '$baseUrl/getOrganisation?name=';
  static final String _getUserDetails = '$baseUrl/getUserDetails?userId=';
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

}
