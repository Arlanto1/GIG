import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/models/base_filter_model.dart';

import '../../../../models/responseModels/generic_response.dart';
import '../models/requestModels/sla_violation_penalty_request.dart';
import '../models/requestModels/violation_penalty_request.dart';
import '../models/sla_violation_penalty_response_model.dart';
import '../models/violation_penalty_list_response_model.dart';
import '../models/violation_penalty_model.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getViolationPenaltiesListByType =
      '$baseUrl/getVpListById/';

  static final String _getVP = '$baseUrl/getSvpList?';

  static final String _getStaffCategoriesValues =
      '$baseUrl/getStaffCategAndViolations';

  static final String _getById = '$baseUrl/getSvpGiById';

  static final String _createGeneralInformation = '$baseUrl/createSvpGI?';

  static final String _getViolationPenaltyById = '$baseUrl/getVpById';
  static final String _deleteViolationRecordsById = '$baseUrl/deleteSlaVp';

  static final String _createViolationPenaltyRecord = '$baseUrl/createSlaVp?';
}

class SLAViolationPenaltyServices {
  Future<List<ViolationPenaltyRecord>> getViolationPenaltyList({
    required String id,
  }) async {
    String url = '${Apis._getViolationPenaltiesListByType}$id';
    var response = await BaseApiService().getRequest(
      isAuthenticated: true,
      url: url,
    );
    return List<ViolationPenaltyRecord>.from(
        response.map((x) => ViolationPenaltyRecord.fromJson(x)));
  }

  Future<Map<String, dynamic>> getStaffCategoriesValues() async {
    String url = Apis._getStaffCategoriesValues;
    Map<String, dynamic> response = await BaseApiService().getRequest(
      isAuthenticated: true,
      url: url,
    );

    return response;
  }

  Future<SLAViolationPenaltyResponseModel> getGSvp({
    required String startPosition,
    required String maximumRecords,
    int? attInfoId,
    required BaseFilterModel filters,
  }) async {
    String url =
        '${Apis._getVP}startPos=$startPosition&maxResults=$maximumRecords';

    // Append the 'aShiftInfoId' parameter in url if it's not null
    if (attInfoId != null) {
      url += '&aShiftInfoId=$attInfoId';
    }
    // String url =
    //     '${Apis._getVP}startPos=$startPosition&maxResults=$maximumRecords&aShiftInfoId=$aShiftInfoId';
    var response = await BaseApiService().postRequest(
      requestedData: filters.toJson(),
      isAuthenticated: true,
      url: url,
    );
    return SLAViolationPenaltyResponseModel.fromJson(response);
  }

  Future<SLAViolationPenaltyResponseModel> getSvpList({
    required String startPosition,
    required String maximumRecords,
    required int attInfoId,
  }) async {
    String url =
        '${Apis._getVP}startPos=$startPosition&maxResults=$maximumRecords&aShiftInfoId=$attInfoId';
    var response = await BaseApiService().getRequest(
      isAuthenticated: true,
      url: url,
    );
    return SLAViolationPenaltyResponseModel.fromJson(response);
  }


  Future<SLAViolationPenaltyModel> getGvpById(int id) async {
    final String url = '${Apis._getById}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return SLAViolationPenaltyModel.fromJson(response);
  }

  /// Create Services
  Future<GenericResponse> createSLAViolationPenaltyGi({
    required SLAViolationPenaltyRequest body,
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

  Future<ViolationPenaltyListResponseModel> getVp({
    required String startPosition,
    required String maximumRecords,
  }) async {
    String url =
        '${Apis._getVP}startPos=$startPosition&maxResults=$maximumRecords';
    var response = await BaseApiService().getRequest(
      isAuthenticated: true,
      url: url,
    );
    return ViolationPenaltyListResponseModel.fromJson(response);
  }

  Future<ViolationPenaltyRecord> getVPById(num id) async {
    final String url = '${Apis._getViolationPenaltyById}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return ViolationPenaltyRecord.fromJson(response);
  }

  Future<GenericResponse> deleteVpById(int id) async {
    final String url = '${Apis._deleteViolationRecordsById}/$id';
    final response = await BaseApiService().deleteRequest(
      url: url,
    );
    return GenericResponse.fromJson(response);
  }

  Future<GenericResponse> createViolationPenaltyRecord({
    required ViolationPenaltyRecordRequest body,
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
