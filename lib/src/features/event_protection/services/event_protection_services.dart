import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_model.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getEventProtections = '$baseUrl/getEPLists?aps=0&';

  static final String _getGI = '$baseUrl/getEPGIById';

  // static final String _getCI = '$baseUrl/getEPCIById';
  static final String _getGuardInfo = '$baseUrl/getEPGuardInfoById';
  static final String _getEventInfo = '$baseUrl/getEPEmailInfoById';
  static final String _showGuardInfo = '$baseUrl/showGuardInfo';

  static final String _getArticleFounds = '$baseUrl/getArticleFound';

  static final String _createEventGeneralInformation = '$baseUrl/createEPGI?';
  static final String _createEventEi = '$baseUrl/createEventEi';
  static final String _showEpGrids = '$baseUrl/showEpGrids';
}

class EventProtectionServices {
  Future<String> getUserEmail() async {
    String email = await SharedPrefs.getEmail();
    return email;
  }

  Future<EventProtectionResponse> getEventProtections({
    required String startPosition,
    required String maximumRecords,
    required BaseFilterModel filters,
  }) async {
    String url =
        '${Apis._getEventProtections}startPos=$startPosition&maxResults=$maximumRecords';
    var response = await BaseApiService().postRequest(
      requestedData: filters.toJson(),
      isAuthenticated: true,
      url: url,
    );
    return EventProtectionResponse.fromJson(response);
  }

  Future<EventProtectionGi> getGI(String id) async {
    final String url = '${Apis._getGI}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return EventProtectionGi.fromJson(response);
  }

  Future<ShowEPGridsModel> showEpGrids(int id) async {
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

  Future<ShowGuardInfoResponse> showGuardInfo(String id) async {
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
    var userId = await SharedPrefs.getUserId();
    final String url =
        "${Apis._createEventGeneralInformation}?userEmail=$userId&isSubmit=$isSubmit";
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
    var userId = await SharedPrefs.getUserId();
    final String url =
        "${Apis._createEventEi}?userEmail=$userId&isSubmit=$isSubmit&event=$eventDuration";
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
}
