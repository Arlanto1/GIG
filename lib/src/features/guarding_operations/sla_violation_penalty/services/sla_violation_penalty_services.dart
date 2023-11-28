import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/contact_details/models/contact_details_list_response_model.dart';
import 'package:db_atom/src/features/contact_details/models/contact_info.dart';
import 'package:db_atom/src/features/contact_details/models/requestModels/contact_details_gi_request.dart';

import '../../../../models/responseModels/generic_response.dart';
import '../models/requestModels/sla_violation_penalty_request.dart';
import '../models/requestModels/violation_penalty_request.dart';
import '../models/sla_violation_penalty_response_model.dart';
import '../models/violation_penalty_list_response_model.dart';
import '../models/violation_penalty_model.dart';


class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getContactListByType = '$baseUrl/getGcdTypeById/';

  static final String _getVP = '$baseUrl/getSvpList?';

  static final String _getById = '$baseUrl/getSvpGiById';

  static final String _createGeneralInformation = '$baseUrl/createCDGI?';

  static final String _getContactDetailsById = '$baseUrl/getCntInfoById';
  static final String _deleteContactDetailsById = '$baseUrl/deleteContactInfo';

  static final String _createContactRecord = '$baseUrl/createContactInfo?';

  static final String _deleteContacts = '$baseUrl/deleteContactInfo';
}

class SLAViolationPenaltyServices {
  Future<ViolationPenaltyListModel> getContactListByType({
    required String id,
    required String type,
  }) async {
    String url = '${Apis._getContactListByType}$id?type=$type';
    var response = await BaseApiService().getRequest(
      isAuthenticated: true,
      url: url,
    );
    return ViolationPenaltyListModel.fromJson(response);
  }

  Future<SLAViolationPenaltyResponseModel> getGcd({
    required String startPosition,
    required String maximumRecords,
  }) async {
    String url =
        '${Apis._getVP}startPos=$startPosition&maxResults=$maximumRecords';
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

  Future<ViolationPenaltyListResponseModel> getCd({
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

  Future<ViolationPenaltyRecord> getCdById(int id) async {
    final String url = '${Apis._getContactDetailsById}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return ViolationPenaltyRecord.fromJson(response);
  }

  Future<GenericResponse> deleteCdById(int id) async {
    final String url = '${Apis._deleteContactDetailsById}/$id';
    final response = await BaseApiService().deleteRequest(
      url: url,
    );
    return GenericResponse.fromJson(response);
  }

  Future<GenericResponse> createContactRecord({
    required ViolationPenaltyRecordRequest body,
    required bool isSubmit,
  }) async {
    // var userId = await SharedPrefs.getUserId();
    final String url = "${Apis._createContactRecord}isSubmit=$isSubmit";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }

  Future<ViolationPenaltyRecord> deleteContacts(int id) async {
    final String url = '${Apis._deleteContacts}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return ViolationPenaltyRecord.fromJson(response);
  }
}
