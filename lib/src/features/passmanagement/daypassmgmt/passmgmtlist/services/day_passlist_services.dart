import 'package:db_atom/main_DEV.dart';
import 'package:db_atom/src/appservices/app_service_handler.dart';

import '../../../../../configurations/base_api_service.dart';
import '../../../../../configurations/environment_config.dart';
import '../../../../../utils/shared_preferences.dart';
import '../models/day_passlist_model.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getPassMgmtList = '$baseUrl/getPassMgmtList?';
}

class DayPassListServices {
  Future<DayPassListResponse> getPassMgmtList({
    required String startPosition,
    required String maximumRecords,
    required String userId,
    required String passType,
  }) async {
    String url =
        '${Apis._getPassMgmtList}startPos=$startPosition&maxResults=$maximumRecords&userId=${await SharedPrefs.getUserId()}&passType=$passType';
    var response = await BaseApiService().getRequest(
      isAuthenticated: true,
      url: url,
    );

    return DayPassListResponse.fromJson(response);
  }

  Future<DayPassListElement> getpassArticleById(
      int articleId, BuildContext context) async {
    var value = await AppServicesHandler()
        .globalGetServiceCall('/getPassMgmtById/$articleId', context);

    return DayPassListElement.fromJson(value);
  }
}
