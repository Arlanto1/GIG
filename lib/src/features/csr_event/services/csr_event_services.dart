import 'dart:developer';
import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_model.dart';
import 'package:db_atom/src/features/csr_event/models/csr_event_model.dart';

import '../../event_protection/event_protection_details/event_info/models/notification_model.dart';
import '../../event_protection/event_protection_details/event_info/models/request_models/notification_email_request.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getCSREvent = '$baseUrl/getOtherEPLists?';

  static final String _getGI = '$baseUrl/getEPGIById';

  // static final String _getCI = '$baseUrl/getEPCIById';
  static final String _getGuardInfo = '$baseUrl/getEPGuardInfoById';
  static final String _getEventInfo = '$baseUrl/getEPEmailInfoById';
  static final String _showGuardInfo = '$baseUrl/showGuardInfo';

  static final String _getArticleFounds = '$baseUrl/getArticleFound';

  static final String _createEventGeneralInformation = '$baseUrl/createEPGI?';
  static final String _createEventEi = '$baseUrl/createEventEi';
  static final String _showEpGrids = '$baseUrl/showEpGrids';
  static final String _createNotification = '$baseUrl/createEpNoty';
  static final String _getNotificationById = '$baseUrl/getEpNotyById';
  static final String _getNotificationList = '$baseUrl/getEpNotyLists';


}

class CSREventServices {
  Future<String> getUserEmail() async {
    String email = await SharedPrefs.getEmail();
    return email;
  }

  Future<CSREventResponse> getCSREventList({
    required String startPosition,
    required String maximumRecords,
    required BaseFilterModel filters,
    required int type,
  }) async {
    String url =
        '${Apis._getCSREvent}startPos=$startPosition&maxResults=$maximumRecords&type=$type';
    var response = await BaseApiService().postRequest(
      requestedData: filters.toJson(),
      isAuthenticated: true,
      url: url,
    );
    log('url: $url');
    debugPrint('url123: $url');

    return CSREventResponse.fromJson(response);
  }

  Future<CSREventGiModel> getGI(int id) async {
    final String url = '${Apis._getGI}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    log('ID $url');
    debugPrint('ID12345');

    debugPrint('ID $url');
    return CSREventGiModel.fromJson(response);
  }

  Future<ShowEPGridsModel> showEventGrids(int id) async {
    final String url = '${Apis._showEpGrids}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return ShowEPGridsModel.fromJson(response);
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

  Future<ShowGuardInfoResponse> showGuardInfo(int id) async {
    final String url = '${Apis._showGuardInfo}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return ShowGuardInfoResponse.fromJson(response);
  }

  Future<GenericResponse> createEventGeneralInfo({
    required GeneralInfoRequest body,
    required bool isSubmit,
    // required int eventDuration,
  }) async {
    final String url =
        "${Apis._createEventGeneralInformation}isSubmit=$isSubmit";
    log("API URL------2-2-2-2-2-: $url");
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }

  Future<GenericResponse> createEventEi({
    required EventInfoRequest body,
    required bool isSubmit,
    required int eventDuration,
  }) async {
    final String url =
        "${Apis._createEventEi}?isSubmit=$isSubmit&event=$eventDuration";
    log("API URL------2-2-2-2-2-: $url");
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }

  Future<FoundListModel> getFoundArticleList({
    required String startPosition,
    required String maximumRecords,
    required String eventId,
  }) async {
    String url =
        '${Apis._getArticleFounds}?startPos=$startPosition&maxResults=$maximumRecords&eventId=$eventId';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return FoundListModel.fromJson(response);
  }

  Future<EventNotificationResponse> getNotificationList(String id) async {
    final String url = '${Apis._getNotificationList}?epId=$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return EventNotificationResponse.fromJson(response);
  }

  Future<EventNotificationModel> getNotificationById(String id) async {
    final String url = '${Apis._getNotificationById}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return EventNotificationModel.fromJson(response);
  }

  Future<GenericResponse> createEventNotification({
    required NotificationEmailRequest body,
    required int eventDuration,
    required int epId,
  }) async {
    final String url =
        "${Apis._createNotification}?epId=$epId&type=$eventDuration";
    log("API URL------2-2-2-2-2-: $url");
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }
}
