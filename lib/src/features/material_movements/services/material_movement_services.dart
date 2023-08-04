import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/law_enforcement_list/models/law_enforcement_details.dart';
import 'package:db_atom/src/features/law_enforcement_list/models/law_enforcement_list_response.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getMaterialMovements =
      '$baseUrl/getMMList?';

  static final String _getMaterialMovement =
      '$baseUrl/getMMById';
}

class MaterialMovementServices {

  Future<LawEnforcementListResponse> getMaterialMovements(
      {required String startPosition,
      required String maximumRecords,
      required String userId,
      required int mmType}) async {
    String url =
        '${Apis._getMaterialMovements}startPos=$startPosition&maxResults=$maximumRecords&userId=$userId&mmType=$mmType';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return LawEnforcementListResponse.fromJson(response);
  }

  Future<LawEnforcementDetails> getMaterialMovement(int id) async {
    final String url = '${Apis._getMaterialMovement}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return LawEnforcementDetails.fromJson(response);
  }
}
