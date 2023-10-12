

import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';

import '../models/occurrence_response.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _get = '$baseUrl/getOCCLists?';
  //static final String _getOccurrence = '$baseUrl/getOCCById?';
  //static final String _createOccurrence = '$baseUrl/createOccurrence?';

}

class OccurrenceServices {

  Future<String> getUserEmail() async {
    String email =  await SharedPrefs.getEmail();
    return email;
  }
  Future<OccurrenceResponse> getIncidents({
    required String startPosition,
    required String maximumRecords,
    required String userId,
  }) async {
    String url =
        '${Apis._get}startPos=$startPosition&maxResults=$maximumRecords&userId=${await SharedPrefs.getUserId()}';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return OccurrenceResponse.fromJson(response);
  }
  // Future<Occurrence> getOccurrence(int id) async {
  //   final String url = '${Apis._getOccurrence}/$id';
  //   var response = await BaseApiService().getRequest(
  //     url: url,
  //   );
  //   return Occurrence.fromJson(response);
  // }

  // Future<GenericCreateResponse> createOccurrence({
  //   required OccurrenceGeneralInfoRequest body,
  //   required bool isSubmit,
  // }) async {
  //   final String url =
  //       "${Apis._createOccurrence}?userEmail=${await getUserEmail()}&isSubmit=$isSubmit";
  //   log("API URL------2-2-2-2-2-: $url");
  //   final response = await BaseApiService().postRequest(
  //     url: url,
  //     requestedData: body.toJson(),
  //   );
  //   return GenericCreateResponse.fromJson(response);
  // }
}
