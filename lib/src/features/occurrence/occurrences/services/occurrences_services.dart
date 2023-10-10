import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';

import '../models/occurrence_response.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getOccurrence = '$baseUrl/getOCCLists?';

}

class OccurrenceServices {

  Future<OccurrenceResponse> getOccurrence({
    required String startPosition,
    required String maximumRecords,
    required String userId,
  }) async {
    String url =
        '${Apis._getOccurrence}startPos=$startPosition&maxResults=$maximumRecords&userId=$userId';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return OccurrenceResponse.fromJson(response);
  }


}
