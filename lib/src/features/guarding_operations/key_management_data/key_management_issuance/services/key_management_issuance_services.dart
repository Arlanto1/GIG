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

  static final String _getViolationPenaltiesListByType =
      '$baseUrl/getVpListById/';

  static final String _getVP = '$baseUrl/getSvpList?';

  static final String _getStaffCategoriesValues = '$baseUrl/getStaffCategAndViolations';

  static final String _getById = '$baseUrl/getSvpGiById';

  static final String _createGeneralInformation = '$baseUrl/createSvpGI?';

  static final String _getViolationPenaltyById = '$baseUrl/getVpById';
  static final String _deleteViolationRecordsById = '$baseUrl/deleteSlaVp';

  static final String _createViolationPenaltyRecord = '$baseUrl/createSlaVp?';
}

class KeyManagementIssuanceServices {
  Future<List<KeyIssuanceProcessRecord>> getViolationPenaltyList({
    required String id,
  }) async {
    String url = '${Apis._getViolationPenaltiesListByType}$id';
    var response = await BaseApiService().getRequest(
      isAuthenticated: true,
      url: url,
    );
    return List<KeyIssuanceProcessRecord>.from(
        response.map((x) => KeyIssuanceProcessRecord.fromJson(x)));
  }

  Future<Map<String, dynamic>> getStaffCategoriesValues() async {
    String url = Apis._getStaffCategoriesValues;
    Map<String, dynamic> response = await BaseApiService().getRequest(
      isAuthenticated: true,
      url: url,
    );

    return response;
  }

  Future<KeyManagementIssuanceResponseModel> getList({
    required String startPosition,
    required String maximumRecords,
    required String userId,
    required String locationId,
  }) async {
    String url =
        '${Apis._getVP}startPos=$startPosition&maxResults=$maximumRecords&userId=$userId&locationId=$locationId';
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
  Future<GenericResponse> createSLAViolationPenaltyGi({
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

  Future<KeyManagementProcessListResponseModel> getVp({
    required String startPosition,
    required String maximumRecords,
  }) async {
    String url =
        '${Apis._getVP}startPos=$startPosition&maxResults=$maximumRecords';
    var response = await BaseApiService().getRequest(
      isAuthenticated: true,
      url: url,
    );
    return KeyManagementProcessListResponseModel.fromJson(response);
  }

  Future<KeyIssuanceProcessRecord> getVPById(num id) async {
    final String url = '${Apis._getViolationPenaltyById}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return KeyIssuanceProcessRecord.fromJson(response);
  }

  Future<GenericResponse> deleteVpById(int id) async {
    final String url = '${Apis._deleteViolationRecordsById}/$id';
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
