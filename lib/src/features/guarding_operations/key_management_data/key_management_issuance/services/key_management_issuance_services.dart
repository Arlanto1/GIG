import 'package:db_atom/index.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getIssuanceProcessListByType =
      '$baseUrl/getKmiListById/';

  static final String _getKMI = '$baseUrl/getKmiList?';

  static final String _getKeyDescriptions = '$baseUrl/getKeyDescList';

  static final String _getById = '$baseUrl/getKmiGiById';
  static final String _getKeyDescById = '$baseUrl/getKeyDescById';

  static final String _createGeneralInformation = '$baseUrl/createKmiGI?';

  static final String _getIssuanceProcessById = '$baseUrl/getKmiById';
  static final String _deleteIssuanceProcessRecordsById =
      '$baseUrl/deleteKmiProcess';

  static final String _createIssuanceProcessRecord =
      '$baseUrl/createKmiProcess?';
}

class KeyManagementIssuanceServices {
  Future<List<KeyIssuanceProcessRecord>> getIssuanceProcessList({
    required String id,
  }) async {
    String url = '${Apis._getIssuanceProcessListByType}$id';
    var response = await BaseApiService().getRequest(
      isAuthenticated: true,
      url: url,
    );
    return List<KeyIssuanceProcessRecord>.from(
        response.map((x) => KeyIssuanceProcessRecord.fromJson(x)));
  }

  Future<List<Organisation>> getKeyDescriptions(
      {required int locationId, required bool isMasterKey}) async {
    String url =
        '${Apis._getKeyDescriptions}?locId=$locationId&isMasterKey=$isMasterKey';
    var response = await BaseApiService().getRequest(
      isAuthenticated: true,
      url: url,
    );
    return List<Organisation>.from(
        response.map((x) => Organisation.fromJson(x)));
  }

  Future<Organisation> getKeyDescById(
      {required int id, required bool isMasterKey}) async {
    final String url = '${Apis._getKeyDescById}/$id?isMasterKey=$isMasterKey';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return Organisation.fromJson(response);
  }

  Future<KeyManagementIssuanceResponseModel> getList({
    required String startPosition,
    required String maximumRecords,
    required BaseFilterModel filters,
    // required String userId,
    // required String locationId,
  }) async {
    String url =
        '${Apis._getKMI}startPos=$startPosition&maxResults=$maximumRecords';
    var response = await BaseApiService().postRequest(
      requestedData: filters.toJson(),
      isAuthenticated: true,
      url: url,
    );
    return KeyManagementIssuanceResponseModel.fromJson(response);
  }

  Future<KeyManagementIssuanceModel> getById(int id) async {
    final String url = '${Apis._getById}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return KeyManagementIssuanceModel.fromJson(response);
  }

  /// Create Services
  Future<GenericResponse> createKeyManagementIssuanceGi({
    required KeyManagementIssuanceRequest body,
    required bool isSubmit,
  }) async {
    // var userId = await SharedPrefs.getUserId();
    final String url = "${Apis._createGeneralInformation}isSubmit=$isSubmit";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }

  Future<KeyManagementProcessListResponseModel> getKeyIssuanceProcess({
    required String startPosition,
    required String maximumRecords,
  }) async {
    String url =
        '${Apis._getKMI}startPos=$startPosition&maxResults=$maximumRecords';
    var response = await BaseApiService().getRequest(
      isAuthenticated: true,
      url: url,
    );
    return KeyManagementProcessListResponseModel.fromJson(response);
  }

  Future<KeyIssuanceProcessRecord> getIssuanceProcessById(num id) async {
    final String url = '${Apis._getIssuanceProcessById}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return KeyIssuanceProcessRecord.fromJson(response);
  }

  Future<GenericResponse> deleteVpById(int id) async {
    final String url = '${Apis._deleteIssuanceProcessRecordsById}/$id';
    final response = await BaseApiService().deleteRequest(
      url: url,
    );
    return GenericResponse.fromJson(response);
  }

  Future<GenericResponse> createIssuanceProcessRecord({
    required KeyIssuanceProcessRecordRequest body,
    required bool isSubmit,
    required int kmiId,
  }) async {
    // var userId = await SharedPrefs.getUserId();
    final String url =
        "${Apis._createIssuanceProcessRecord}kmiId=$kmiId&isSubmit=$isSubmit";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }
}
