import 'dart:developer';

import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/transport_medical_incident/models/request_models/notification_email_request.dart';
import 'package:db_atom/src/features/transport_medical_incident/models/request_models/transport_medical_request_model.dart';
import 'package:db_atom/src/features/transport_medical_incident/models/transport_email_notification.dart';
import 'package:db_atom/src/features/transport_medical_incident/models/transport_medical_incident_model.dart';
import 'package:db_atom/src/models/base_filter_model.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import '../../../models/responseModels/generic_response.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _get = '$baseUrl/getEmergencyIncidentList?';
  static final String _getById = '$baseUrl/getEIncidentById';
  static final String _create = '$baseUrl/createEmergencyIncident';
  static final String _createNotification = '$baseUrl/createEiNoty';
  static final String _getNotificationById = '$baseUrl/getEiNotyById';
  static final String _getNotificationList = '$baseUrl/getEiNotyLists';
  static final String _getNotificationByTMId = '$baseUrl/getEINotificationInfoById';

}

class TransportMedicalServices {
  Future<String> getUserEmail() async {
    String email = await SharedPrefs.getEmail();
    return email;
  }

  Future<TransportMedicalResponse> getTransportMedicalList({
    required String startPosition,
    required String maximumRecords,
    required int incidentType,
    required BaseFilterModel filters,
  }) async {
    String url =
        '${Apis._get}startPos=$startPosition&maxResults=$maximumRecords&incidentType=$incidentType';
    var response = await BaseApiService().postRequest(
      requestedData: filters.toJson(),
      isAuthenticated: true,
      url: url,
    );
    return TransportMedicalResponse.fromJson(response);
  }

  Future<TransportMedicalModel> getTransportById(String id) async {
    final String url = '${Apis._getById}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return TransportMedicalModel.fromJson(response);
  }

  Future<GenericResponse> createTransportMedical({
    required TransportMedicalRequest body,
    required bool isSubmit,
    // required int eventDuration,
  }) async {
    final String url = "${Apis._create}?isSubmit=$isSubmit";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }


  Future<TransportEmailNotificationResponse> getNotificationList(String id) async {
    final String url = '${Apis._getNotificationList}?eiId=$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return TransportEmailNotificationResponse.fromJson(response);
  }

  Future<TransportEmailNotificationModel> getNotificationById(String id) async {
    final String url = '${Apis._getNotificationById}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return TransportEmailNotificationModel.fromJson(response);
  }

  Future<TransportEmailNotificationModel> getNotificationDetailsById(String id) async {
    final String url = '${Apis._getNotificationByTMId}?id=$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return TransportEmailNotificationModel.fromJson(response);
  }

  Future<GenericResponse> createTransportNotification({
    required TransportNotificationEmailRequest body,
     int? eiId,
  }) async {
    final String url =
        "${Apis._createNotification}?eiId=$eiId";
    log("API URL------2-2-2-2-2-: $url");
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    // log('Request ${body.toJson()}');
    return GenericResponse.fromJson(response);
  }
}
