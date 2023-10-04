import 'package:db_atom/main_DEV.dart';
import 'package:db_atom/src/appservices/app_service_handler.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/passmanagement/daypassregister/models/day_pass_info_response_model.dart';

import '../../../../configurations/base_api_service.dart';
import '../../daypassmgmt/passmgmtlist/models/day_passlist_item_model.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getPassMgmtInfo = '$baseUrl/getPassMgmtInfo?';
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

  Future<DayPassListItemResponse> getpassArticleById(
      int articleId, BuildContext context) async {
    var value = await AppServicesHandler()
        .globalGetServiceCall('/getPassMgmtInfoById/$articleId', context);

    return DayPassListItemResponse.fromJson(value);
  }
}
