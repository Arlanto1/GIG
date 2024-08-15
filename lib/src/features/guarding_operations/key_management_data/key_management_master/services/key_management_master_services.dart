import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/models/requestModels/key_management_master_request.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getKeyHistoryListByType =
      '$baseUrl/getKmKeyLossDesListById/';

  static final String _getList = '$baseUrl/getKeyMgmtList?';

  static final String _getGIById = '$baseUrl/getKeyMgmtGiById';

  static final String _createKeyMasterGI = '$baseUrl/createKeyMgmtGI?';

  static final String _getKeyHistoryDetailsById = '$baseUrl/getKldById';

  static final String _deleteKeyHistoryDetailsById =
      '$baseUrl/deleteContactInfo';

  static final String _createKeyHistoryRecord = '$baseUrl/createKeyLossDes?';
}

class KeyManagementMasterServices {
  Future<String> getUserEmail() async {
    String email = await SharedPrefs.getEmail();
    return email;
  }

  // Future<ContactsListModel> getKeyHistoryListByType({
  //   required String id,
  //   required String type,
  // }) async {
  //   String url = '${Apis._getKeyHistoryListByType}$id?type=$type';
  //   var response = await BaseApiService().getRequest(
  //     isAuthenticated: true,
  //     url: url,
  //   );
  //   return ContactsListModel.fromJson(response);
  // }

  Future<KeyManagementMasterResponse> getList({
    required String startPosition,
    required String maximumRecords,
    required BaseFilterModel filters,
    // required String userId,
    // required String locationId,
  }) async {
    String url =
        '${Apis._getList}startPos=$startPosition&maxResults=$maximumRecords';
    var response = await BaseApiService().postRequest(
      requestedData: filters.toJson(),
      isAuthenticated: true,
      url: url,
    );
    return KeyManagementMasterResponse.fromJson(response);
  }

  Future<KeyManagementMasterModel> getById(int id) async {
    final String url = '${Apis._getGIById}/$id';
    var response = await BaseApiService().getRequest(
      url: url,
    );
    return KeyManagementMasterModel.fromJson(response);
  }

  /// Create Services

  Future<GenericResponse> createKeyManagementMaster({
    required KeyManagementMasterRequest body,
    required bool isSubmit,
  }) async {
    final String url =
        "${Apis._createKeyMasterGI}userEmail=${await getUserEmail()}&isSubmit=$isSubmit";
    log("API URL------2-2-2-2-2-: $url");
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }

  // Future<ContactListResponseModel> getKHd({
  //   required String startPosition,
  //   required String maximumRecords,
  // }) async {
  //   String url =
  //       '${Apis._getList}startPos=$startPosition&maxResults=$maximumRecords';
  //   var response = await BaseApiService().getRequest(
  //     isAuthenticated: true,
  //     url: url,
  //   );
  //   return ContactListResponseModel.fromJson(response);
  // }

  Future<KeyHistoryModel> getKHById(int id) async {
    final String url = '${Apis._getKeyHistoryDetailsById}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return KeyHistoryModel.fromJson(response);
  }

  Future<GenericResponse> deleteKHdById(int id) async {
    final String url = '${Apis._deleteKeyHistoryDetailsById}/$id';
    final response = await BaseApiService().deleteRequest(
      url: url,
    );
    return GenericResponse.fromJson(response);
  }

  Future<List<KeyManagementMasterModel>> getKeyHistoryListByType(
      {required int id, required int type}) async {
    final String url = '${Apis._getKeyHistoryListByType}$id?type=$type';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return List<KeyManagementMasterModel>.from(
        response.map((x) => KeyManagementMasterModel.fromJson(x)));
  }

  Future<GenericResponse> createKeyHistoryRecord({
    required KeyHistoryRecordRequest body,
    required bool isSubmit,
    required String? kmId,
    required String? keyIssuanceId,
  }) async {
    // var userId = await SharedPrefs.getUserId();
     String url =
        "${Apis._createKeyHistoryRecord}kmId=$kmId&isSubmit=$isSubmit";
    if(keyIssuanceId !=null){
    url  = '$url&kmiMasterId=$keyIssuanceId';
    }
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }
}
