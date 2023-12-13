
import 'package:dart_extensions/dart_extensions.dart';
import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/security_systems/models/sst_incident_response.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';

import '../../../models/responseModels/generic_response.dart';
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
    required int ticketType,
    required int staffType,
    String? occId,
  }) async {
    String url =
        '${Apis._get}startPos=$startPosition&maxResults=$maximumRecords&userId=${await SharedPrefs.getUserId()}'
        '&ticketType=$ticketType&staffType=$staffType';
    if (!occId.isEmptyOrNull) {
      url = '$url&occuId=$occId';
    }
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

  Future<GenericResponse> loginUser({
    required SecuritySystemTicketIncidentRequest body,
    required bool isSubmit,
  }) async {
    var userId = await SharedPrefs.getUserId();
    final String url = "${Apis._create}?userEmail=$userId&isSubmit=$isSubmit";
    final response = await BaseApiService()
        .postRequest(url: url, requestedData: body.toJson());
    return GenericResponse.fromJson(response);
  }

  Future<GenericResponse> create({
    required SecuritySystemTicketIncidentRequest body,
    required bool isSubmit,
  }) async {
    var userId = await SharedPrefs.getUserId();
    final String url = "${Apis._create}userEmail=$userId&isSubmit=$isSubmit";

    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }
}
