import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';

import '../models/guarding_master_data_model.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getGuardingMasterData = '$baseUrl/getGMData?';
}

class GuardingMasterDataServices {

  Future<GuardingMasterDataModel> getGuardingMasterData({
    required String startPosition,
    required String maximumRecords,
    required String userId,
    required String locationId,
  }) async {
    String url =
        '${Apis._getGuardingMasterData}startPos=$startPosition&maxResults=$maximumRecords&userId=$userId&locationId=$locationId';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return GuardingMasterDataModel.fromJson(response);
  }
}
