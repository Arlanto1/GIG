import 'package:db_atom/main_DEV.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/passmanagement/daypassregister/models/day_pass_info_response_model.dart';

import '../../../../configurations/base_api_service.dart';
import '../../daypassmgmt/passmgmtlist/models/day_passlist_item_model.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getPassMgmtInfo = '$baseUrl/getPassMgmtInfo?';
  static final String _getById = '$baseUrl/getPassMgmtInfoById?';
}

class DayPassInfoServices {
  Future<DayPassInfoResponseModel> getPassInfoFoundArticleList(
      {required String startPosition,
      required String maximumRecords,
      required String userId,
      required String passType}) async {
    String url =
        '${Apis._getPassMgmtInfo}startPos=$startPosition&maxResults=$maximumRecords&userId=$userId&passType=$passType';
    var response = await BaseApiService().getRequest(
      isAuthenticated: true,
      url: url,
    );

    return DayPassInfoResponseModel.fromJson(response);
  }

  Future<DayPassListItemResponse> getById(int id, BuildContext context) async {
    final String url = '${Apis._getById}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );

    return DayPassListItemResponse.fromJson(response);
  }
}
