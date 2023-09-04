import 'dart:convert';
import 'dart:io';
import 'package:db_atom/main_DEV.dart';
import 'package:db_atom/src/appservices/app_service_handler.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/passmgmtlist/models/day_passlist_item_model.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/passmgmtlist/models/day_passlist_model.dart';

import 'package:http/http.dart' as http;

class DayPassListServices {
  Future<DayPassListResponse> getpassFoundArticleList(String startPosition, String maximumRecords,String userId, String passtype,BuildContext context) async {
   // await Future.delayed(Duration(seconds: 3));

    //final endpoint = ProdConfig().apiHost;
    //  final endpoint = Environment().config.apiHost;
    // final url =
    //     Uri.parse('$endpoint/getPassMgmtList');
    //     final url =
    //     Uri.parse('$endpoint/getPassMgmtList?startPos=$startPosition&maxResults=$maximumRecords&userId=$userId&passType=$passtype');
    //     print(url);
    // try {
    
    //   final response = await http.get(
    //     url,
    //     headers: {
    //       'Content-Type': 'application/json; charset=UTF-8',
    //       // 'startPos' : startPosition,
    //       // 'maxResults' : maximumRecords,
    //       // 'userId': userId,
    //       // 'passType':passtype

    //     },
    //   );
    //   print(response.body);
    //   if (response.statusCode == 200) {
    //     try {
    //     return DayPassListResponse.fromJson(json.decode(response.body));
    //     }
    //     catch(e)
    //     {
    //       print(e);
    //       return DayPassListResponse();
    //     }
    //   } else {
    //     throw json.decode(response.body);
    //   }
    // } on SocketException {
    //   throw json.decode('{"errorMessage":"Network Lost"}');
    // }

    var value  = await  AppServicesHandler().globalGetServiceCall('/getPassMgmtList?startPos=$startPosition&maxResults=$maximumRecords&userId=$userId&passType=$passtype',context);

   return  DayPassListResponse.fromJson(value);
  }

  Future<DayPassListItemResponse> getpassArticleById(int articleId,BuildContext context) async {
    // await Future.delayed(Duration(seconds: 3));

    // final endpoint = Environment().config.apiHost;
    // final url = Uri.parse('$endpoint/getPassMgmtById/$articleId');
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

    var value  = await  AppServicesHandler().globalGetServiceCall('/getPassMgmtById/$articleId',context);

   return  DayPassListItemResponse.fromJson(value);
  }
}
