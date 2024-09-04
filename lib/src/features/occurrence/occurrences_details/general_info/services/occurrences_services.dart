import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/occurrence/occurrences_details/general_info/models/requestModel/general_info_request.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _get = '$baseUrl/getOCCLists?';
  static final String _getOccurrence = '$baseUrl/getOCCById';
  static final String _createOccurrence = '$baseUrl/createOccurrence?';
  static final String _getOccPowerFailure = '$baseUrl/getOccPowerFailure/';
  static final String _getOccFollowUp = '$baseUrl/getOccFollowUp/';
}

class OccurrenceDetailsServices {
  Future<String> getUserEmail() async {
    String email = await SharedPrefs.getEmail();
    return email;
  }

  Future<OccurrenceResponse> getIncidents({
    required String startPosition,
    required String maximumRecords,
    required String userId,
  }) async {
    String url =
        '${Apis._get}startPos=$startPosition&maxResults=$maximumRecords';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return OccurrenceResponse.fromJson(response);
  }

  Future<OccurrenceModel> getOccurrence(String id) async {
    final String url = '${Apis._getOccurrence}/$id';
    var response = await BaseApiService().getRequest(
      url: url,
    );
    return OccurrenceModel.fromJson(response);
  }

  Future<GenericResponse> create({
    required OccurrenceGeneralInfoRequest body,
    required bool isSubmit,
  }) async {
    final String url =
        "${Apis._createOccurrence}userEmail=${await getUserEmail()}&isSubmit=$isSubmit";
    log("API URL------2-2-2-2-2-: $url");
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }

  Future<PowerFailureModel> getOccPowerFailure(
      {required String locationId}) async {
    final String url = "${Apis._getOccPowerFailure}$locationId";
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return PowerFailureModel.fromJson(response);
  }

  Future<StringResponse> getOccFollowUp({required String locationId}) async {
    final String url = "${Apis._getOccFollowUp}$locationId";
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return StringResponse.fromJson(response);
  }
}
