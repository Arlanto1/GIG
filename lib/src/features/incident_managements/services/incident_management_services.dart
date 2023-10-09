import 'dart:developer';

import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_model.dart';
import 'package:db_atom/src/features/event_protection/event_protection_details/general_info/models/requestModel/general_info_request.dart';
import 'package:db_atom/src/features/event_protection/event_protection_details/general_information/guard_info/models/guard_info_model.dart';
import 'package:db_atom/src/features/event_protection/event_protection_details/general_information/guard_info/models/show_guard_info_response.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';

import '../../../models/responseModels/generic_creat_response.dart';
import '../../event_protection/event_protection_details/event_info/models/event_info_response.dart';
import '../../event_protection/event_protection_details/event_info/models/request_models/event_into_request.dart';
import '../../event_protection/event_protection_details/general_info/models/general_info_model.dart';
import '../models/incidents_response.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getIncidentMgmt = '$baseUrl/getIncidentMgmt?';

  static final String _getGI = '$baseUrl/getEPGIById';

  // static final String _getCI = '$baseUrl/getEPCIById';
  static final String _getGuardInfo = '$baseUrl/getEPGuardInfoById';
  static final String _getEventInfo = '$baseUrl/getEPEmailInfoById';
  static final String _showGuardInfo = '$baseUrl/showGuardInfo';

  static final String _getArticleFounds = '$baseUrl/getArticleFound';

  static final String _createEventGeneralInformation = '$baseUrl/createEPGI?';
  static final String _createEventEi = '$baseUrl/createEventEi';
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

  Future<EventProtectionGi> getGI(String id) async {
    final String url = '${Apis._getGI}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return EventProtectionGi.fromJson(response);
  }

  // Future<ContactInfoModel> getCI(String id) async {
  //   final String url = '${Apis._getCI}/$id';
  //   final response = await BaseApiService().getRequest(
  //     url: url,
  //   );
  //   return ContactInfoModel.fromJson(response);
  // }

  Future<GuardInfoModel> getEPGuardInfo(String id) async {
    final String url = '${Apis._getGuardInfo}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return GuardInfoModel.fromJson(response);
  }

  Future<EventInfoResponse> getEventInfo(String id, int eventDuration) async {
    final String url = "${Apis._getEventInfo}?id=$id&event=$eventDuration";
    final response = await BaseApiService().getRequest(
      url: url,
    );
    EventInfoResponse aa = EventInfoResponse.fromJson(response);

    log('-----aa-----${aa.id}-');
    return EventInfoResponse.fromJson(response);
  }

  Future<ShowGuardInfoResponse> showGuardInfo(String id) async {
    final String url = '${Apis._showGuardInfo}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return ShowGuardInfoResponse.fromJson(response);
  }

  Future<GenericCreateResponse> createEventGeneralInfo({
    required GeneralInfoRequest body,
    required bool isSubmit,
    // required int eventDuration,
  }) async {
    var userId = await SharedPrefs.getUserId();
    final String url =
        "${Apis._createEventGeneralInformation}?userEmail=$userId&isSubmit=$isSubmit";
    log("API URL------2-2-2-2-2-: $url");
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericCreateResponse.fromJson(response);
  }

  Future<GenericCreateResponse> createEventEi({
    required EventInfoRequest body,
    required bool isSubmit,
    required int eventDuration,
  }) async {
    var userId = await SharedPrefs.getUserId();
    final String url =
        "${Apis._createEventEi}?userEmail=$userId&isSubmit=$isSubmit&event=$eventDuration";
    log("API URL------2-2-2-2-2-: $url");
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericCreateResponse.fromJson(response);
  }

  Future<FoundListModel> getFoundArticleList({
    required String startPosition,
    required String maximumRecords,
    required String eventId,
  }) async {
    String url =
        '${Apis._getArticleFounds}?startPos=$startPosition&maxResults=$maximumRecords&eventId=$eventId&userId=${await SharedPrefs.getUserId()}';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return FoundListModel.fromJson(response);
  }
}
