import 'dart:developer';

import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';

import '../../../../models/responseModels/generic_creat_response.dart';
import '../../../event_protection/event_protection_details/general_info/models/general_info_model.dart';
import '../../../event_protection/event_protection_details/general_info/models/requestModel/general_info_request.dart';
import '../../incident_details/general_info/models/requestModel/general_info_request.dart';
import '../models/incidents_response.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getIncidentMgmt = '$baseUrl/getIncidentMgmt?';

  static final String _getIncidentDetails = '$baseUrl/getIncidentMgmtById';
  static final String _create = '$baseUrl/createIncidentMgmt?';

}

class IncidentServices {

  Future<IncidentsResponse> getIncidents({
    required String startPosition,
    required String maximumRecords,
    required String userId,
  }) async {
    String url =
        '${Apis._getIncidentMgmt}startPos=$startPosition&maxResults=$maximumRecords&userId=${await SharedPrefs.getUserId()}';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return IncidentsResponse.fromJson(response);
  }

  Future<Incident> getIncidentDetails(String id) async {
    final String url = '${Apis._getIncidentDetails}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return Incident.fromJson(response);
  }

  Future<GenericCreateResponse> create({
    required IncidentGeneralInfoRequest body,
    required bool isSubmit,
  }) async {
    var userId = await SharedPrefs.getUserId();
    final String url =
        "${Apis._create}?userEmail=$userId&isSubmit=$isSubmit";
    log("API URL------2-2-2-2-2-: $url");
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericCreateResponse.fromJson(response);
  }


}
