import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';

import '../models/guarding_master_report_model.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getGuardingMasterReport = '$baseUrl/getGMReport?';
}

class GuardingMasterReportServices {
  Future<GuardingMasterReportModel> getGuardingMasterReport({
    required String startPosition,
    required String maximumRecords,
    required String userId,
  }) async {
    String url =
        '${Apis._getGuardingMasterReport}startPos=$startPosition&maxResults=$maximumRecords&userId=$userId';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return GuardingMasterReportModel.fromJson(response);
  }
}
