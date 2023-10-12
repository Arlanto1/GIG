import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';

import '../models/incidents_response.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getIncidentMgmt = '$baseUrl/getIncidentMgmt?';
  }

class IncidentServices {

  Future<IncidentsResponse> getIncidents({
    required String startPosition,
    required String maximumRecords,
    required String userId,
  }) async {
    String url =
        '${Apis._getIncidentMgmt}startPos=$startPosition&maxResults=$maximumRecords&userId=${await SharedPrefs.getUserId()}';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return IncidentsResponse.fromJson(response);
  }



}
