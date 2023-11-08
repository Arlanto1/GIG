import 'package:db_atom/main_DEV.dart';
import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/law_enforcement_list/models/law_enforcement_details.dart';
import 'package:db_atom/src/features/law_enforcement_list/models/law_enforcement_list_response.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getList = '$baseUrl/getLawEnfrcmntList?';
  static final String _getById = '$baseUrl/getLawEnfrcmnt';
}

class LawEnforcementListServices {
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
    final response =
        await BaseApiService().getRequest(url: url, isAuthenticated: false);

    return LawEnforcementDetails.fromJson(response);
  }

}
