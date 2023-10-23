import 'package:db_atom/main_DEV.dart';
import 'package:db_atom/src/appservices/app_service_handler.dart';
import 'package:db_atom/src/features/law_enforcement_list/models/law_enforcement_details.dart';
import 'package:db_atom/src/features/law_enforcement_list/models/law_enforcement_list_response.dart';

class LawEnforcementListServices {
  Future<LawEnforcementListResponse> getLawEnforcementList(String startPosition, String maximumRecords,String userId,BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));

    //final endpoint = ProdConfig().apiHost;
    //  final endpoint = Environment().config.apiHost;
    // final url =
    //     Uri.parse('$endpoint/getLawEnfrcmntList?startPos=$startPosition&maxResults=$maximumRecords&userId=$userId');
    //     print(url);
    // try {
    //   final response = await http.get(
    //     url,
    //     headers: {
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //   );
    //   if (response.statusCode == 200) {
    //     try {
    //     return LawEnforcementListResponse.fromJson(json.decode(response.body));
    //     }
    //     catch(e)
    //     {
    //       print('error response ${e}');
    //       return LawEnforcementListResponse();
    //     }
    //   } else {
    //     throw json.decode(response.body);
    //   }
    // } on SocketException {
    //   throw json.decode('{"errorMessage":"Network Lost"}');
    // }
     var value  = await AppServicesHandler().globalGetServiceCall('/getLawEnfrcmntList?startPos=$startPosition&maxResults=$maximumRecords&userId=$userId',context);

   return  LawEnforcementListResponse.fromJson(value);
    
  }

  Future<LawEnforcementDetails> getLawEnforcementById(int lawEnforcementId,BuildContext context) async {
    // await Future.delayed(const Duration(seconds: 2));

    // final endpoint = Environment().config.apiHost;
    // final url = Uri.parse('$endpoint/getLawEnfrcmnt/$lawEnforcementId');
    // try {
    //   final response = await http.get(
    //     url,
    //     headers: {
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //   );
    //   if (response.statusCode == 200) {
    //     return LawEnforcementDetails.fromJson(json.decode(response.body));
    //   } else {
    //     throw json.decode(response.body);
    //   }
    // } on SocketException {
    //   throw json.decode('{"errorMessage":"Network Lost"}');
    // }
     var value  = await AppServicesHandler().globalGetServiceCall('/getLawEnfrcmnt/$lawEnforcementId',context);

   return  LawEnforcementDetails.fromJson(value);
  }
}
