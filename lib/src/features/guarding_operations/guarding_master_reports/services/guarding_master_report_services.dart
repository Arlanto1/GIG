import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/models/base_filter_model.dart';

import '../models/guarding_master_report_model.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getGuardingMasterReport = '$baseUrl/getGMReport?';
}

class GuardingMasterReportServices {
  Future<GuardingMasterReportModel> getGuardingMasterReport({
    required String startPosition,
    required String maximumRecords,
    required BaseFilterModel filters,
  }) async {
    String url =
        '${Apis._getGuardingMasterReport}startPos=$startPosition&maxResults=$maximumRecords';
    var response = await BaseApiService().postRequest(
      requestedData: filters.toJson(),
      isAuthenticated: true,
      url: url,
    );
    return GuardingMasterReportModel.fromJson(response);
  }
}
