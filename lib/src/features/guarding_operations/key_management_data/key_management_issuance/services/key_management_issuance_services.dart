import 'package:db_atom/index.dart';
import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_issuance/models/key_issuance_process_list_model.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_issuance/models/key_issuance_process_model.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_issuance/models/key_management_issuance_model.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_issuance/models/requestModels/key_issuance_process.request.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_issuance/models/requestModels/key_management_issuance_request.dart';
import 'package:db_atom/src/models/responseModels/generic_response.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getIssuanceProcessListByType =
      '$baseUrl/getKmiListById/';

  static final String _getKMI = '$baseUrl/getKmiList?';

  static final String _getKeyDescriptionValues = '$baseUrl/getKeyDescList';

  static final String _getById = '$baseUrl/getKmiGiById';

  static final String _createGeneralInformation = '$baseUrl/createKmiGI?';

  static final String _getIssuanceProcessById = '$baseUrl/getKmiById';
  static final String _deleteIssuanceProcessRecordsById =
      '$baseUrl/deleteSlaVp';

  static final String _createViolationPenaltyRecord = '$baseUrl/createSlaVp?';
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

  Future<List<Organisation>> getKeyDescriptionValues({required String locId
  } ) async {
    String url = '${Apis._getKeyDescriptionValues}?locId=$locId';
    var  response = await BaseApiService().getRequest(
      isAuthenticated: true,
      url: url,
    );
    return List<Organisation>.from(response.map((x) => Organisation.fromJson(x)));
  }

  Future<KeyManagementIssuanceResponseModel> getList({
    required String startPosition,
    required String maximumRecords,
    // required String userId,
    // required String locationId,
  }) async {
    String url =
        '${Apis._getKMI}startPos=$startPosition&maxResults=$maximumRecords';
    var response = await BaseApiService().getRequest(
      isAuthenticated: true,
      url: url,
    );
    return KeyManagementIssuanceResponseModel.fromJson(response);
  }

  Future<KeyManagementIssuanceModel> getKMIById(int id) async {
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

  Future<GenericResponse> createViolationPenaltyRecord({
    required KeyIssuanceProcessRecordRequest body,
    required bool isSubmit,
  }) async {
    // var userId = await SharedPrefs.getUserId();
    final String url =
        "${Apis._createViolationPenaltyRecord}isSubmit=$isSubmit";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }
}
