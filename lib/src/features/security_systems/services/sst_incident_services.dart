import 'dart:developer';

import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/security_systems/models/sst_incident_response.dart';
import 'package:db_atom/src/models/responseModels/generic_error_response.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';

import '../../../models/responseModels/generic_create_response.dart';
import '../models/requestModel/general_info_request.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _get = '$baseUrl/getSSSLAList?';

  static final String _getDetails = '$baseUrl/getSSSLAById';
  static final String _create = '$baseUrl/createSSSLA?';
}

class SstIncidentServices {
  Future<SstIncidentResponse> get({
    required String startPosition,
    required String maximumRecords,
    required String userId,
  }) async {
    String url =
        '${Apis._get}startPos=$startPosition&maxResults=$maximumRecords&userId=${await SharedPrefs.getUserId()}';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return SstIncidentResponse.fromJson(response);
  }

  Future<SstIncident> getDetails(String id) async {
    final String url = '${Apis._getDetails}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return SstIncident.fromJson(response);
  }

  Future<GenericCreateResponse> loginUser({
    required SecuritySystemTicketIncidentRequest body,
    required bool isSubmit,
  }) async {
    var userId = await SharedPrefs.getUserId();
    final String url = "${Apis._create}?userEmail=$userId&isSubmit=$isSubmit";
    final response = await BaseApiService()
        .postRequest(url: url, requestedData: body.toJson());
    return GenericCreateResponse.fromJson(response);
  }

  Future<GenericCreateResponse> create({
    required SecuritySystemTicketIncidentRequest body,
    required bool isSubmit,
  }) async {
    var userId = await SharedPrefs.getUserId();
    final String url = "${Apis._create}?userEmail=$userId&isSubmit=$isSubmit";
    log("API URL------2-2-2-2-2-: $url");

    dynamic response;
    try {
      response = await BaseApiService().postRequest(
        url: url,
        requestedData: body.toJson(),
      );

    } catch (e) {
      log("--throw exception--: $e");
      if (response is GenericErrorResponse) {
        throw response;
      } else {
        // Handle unexpected response here
        throw Exception("Unexpected response: $response");
      }
    }

    log("response----create---: ${response.toString()}");
    return GenericCreateResponse.fromJson(response);
  }

}
