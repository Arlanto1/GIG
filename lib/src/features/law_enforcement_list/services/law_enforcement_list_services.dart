import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/law_enforcement_list/models/law_enforcement_details.dart';
import 'package:db_atom/src/features/law_enforcement_list/models/law_enforcement_list_response.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getLawEnforcementList =
      '$baseUrl/getLawEnfrcmntList?';

  static final String _getLawEnforcementById =
      '$baseUrl/getLawEnfrcmnt';
}

class LawEnforcementListServices {
  Future<LawEnforcementListResponse> getLawEnforcementList(
      String startPosition, String maximumRecords, String userId) async {
    String url =
        '${Apis._getLawEnforcementList}startPos=$startPosition&maxResults=$maximumRecords&userId=$userId';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return LawEnforcementListResponse.fromJson(response);
  }

  Future<LawEnforcementDetails> getLawEnforcementById(int lawEnforcementId) async {
    final String url = '${Apis._getLawEnforcementById}/$lawEnforcementId';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return LawEnforcementDetails.fromJson(response);
  }
}
