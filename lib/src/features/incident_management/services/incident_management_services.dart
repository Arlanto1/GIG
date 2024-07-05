import 'package:dart_extensions/dart_extensions.dart';
import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/models/base_filter_model.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';

import '../../../models/responseModels/generic_response.dart';
import '../incident_details/general_info/models/requestModel/general_info_request.dart';
import '../models/incidents_response.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _get = '$baseUrl/getIncidentMgmt?';
  static final String _getDetails = '$baseUrl/getIncidentMgmtById';
  static final String _create = '$baseUrl/createIncidentMgmt';
}

class IncidentManagementServices {
  Future<String> getUserEmail() async {
    String email = await SharedPrefs.getEmail();
    return email;
  }

  Future<IncidentsResponse> getIncidents({
    required String startPosition,
    required String maximumRecords,
    // required String userId,
    String? occId,
    int? occType,
    int? kldId,
    required BaseFilterModel filters,
  }) async {
    String url =
        '${Apis._get}startPos=$startPosition&maxResults=$maximumRecords';
    // 'userId=${await SharedPrefs.getUserId()}';
    if (!occId.isEmptyOrNull) {
      url = '$url&occuId=$occId&occType=$occType';
    } else if (kldId != 0 && kldId != null) {
      url = '$url&kldId=$kldId';
    }
    var response = await BaseApiService().postRequest(
      requestedData: filters.toJson(),
      isAuthenticated: true,
      url: url,
    );
    return IncidentsResponse.fromJson(response);
  }

  Future<IncidentModel> getIncidentDetails(String id) async {
    final String url = '${Apis._getDetails}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return IncidentModel.fromJson(response);
  }

  Future<GenericResponse> createIncidentManagement({
    required IncidentGeneralInfoRequest body,
    required bool isSubmit,
    // required int eventDuration,
  }) async {
    var userId = await SharedPrefs.getUserId();
    final String url = "${Apis._create}?userEmail=$userId&isSubmit=$isSubmit";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }
}
