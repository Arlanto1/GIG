import 'dart:convert';
import 'dart:io';

import 'package:db_atom/main_DEV.dart';
import 'package:db_atom/src/appservices/app_service_handler.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/passmanagement/daypassregister/models/day_pass_info_response_model.dart';
import 'package:http/http.dart' as http;

import '../../../../configurations/base_api_service.dart';
import '../../daypassmgmt/passmgmtlist/models/day_passlist_item_model.dart';


class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getPassMgmtInfo = '$baseUrl/getPassMgmtInfo?';

}

class DayPassInfoServices {


  Future<DayPassInfoResponseModel> getpassinfoFoundArticleList(
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

  // Future<DayPassInfoResponseModel> getpassinfoFoundArticleList(String startPosition,
  //     String maximumRecords, String userId, String passType,bool isRegister,BuildContext context) async {
  //   // await Future.delayed(Duration(seconds: 3));
  //
  //   //final endpoint = ProdConfig().apiHost;
  //   final endpoint = Environment().config.apiHost;
  //
  //
  //   var value  = await  AppServicesHandler().globalGetServiceCall('/getPassMgmtInfo?startPos=$startPosition&maxResults=$maximumRecords&userId=$userId&passType=$passType',context);
  //
  //  return  DayPassInfoResponseModel.fromJson(value);
  // }

  Future<DayPassListItemResponse> getpassArticleById(int articleId,BuildContext context) async {
    // await Future.delayed(Duration(seconds: 3));

    // final endpoint = Environment().config.apiHost;
    // final url = Uri.parse('$endpoint/getPassMgmtInfoById/$articleId');
    // try {
    //   final response = await http.get(
    //     url,
    //     headers: {
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //   );
    //   if (response.statusCode == 200) {
    //     return DayPassListItemResponse.fromJson(json.decode(response.body));
    //   } else {
    //     throw json.decode(response.body);
    //   }
    // } on SocketException {
    //   throw json.decode('{"errorMessage":"Network Lost"}');
    // }
        var value  = await  AppServicesHandler().globalGetServiceCall('/getPassMgmtInfoById/$articleId',context);

   return  DayPassListItemResponse.fromJson(value);
  }
}
