
import 'dart:developer';

import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/patrolling/models/owner_user_model.dart';
import 'package:db_atom/src/features/patrolling/models/patrolling_other_model.dart';
import 'package:db_atom/src/features/patrolling/models/requestModel/patrolling_other_request.dart';
import 'package:db_atom/src/features/patrolling/models/requestModel/patrolling_request_model.dart';
import 'package:db_atom/src/models/base_filter_model.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import '../../../models/responseModels/generic_response.dart';
import '../models/patrolling_model.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _get = '$baseUrl/getPatrollingList?';
  static final String _getGenInfoById = '$baseUrl/getPatrollingById';
  static final String _createGenInfo = '$baseUrl/createPatrolling';
  static final String _getSubSecById = '$baseUrl/getPatrollingSubsectionById';
  static final String _getNewSubSecById = '$baseUrl/getPatrollingSubsectionTemplate';
  static final String _createOtherInfo = '$baseUrl/createPatrollingSubsection';
  static final String _getGenInfoDetails = '$baseUrl/getPTRDefaults';
  static final String _getOwnerUserDetails = '$baseUrl/getPatrollingActionOwners';

}

class PatrollingService {
  Future<String> getUserEmail() async {
    String email = await SharedPrefs.getEmail();
    return email;
  }

  Future<PatrollingModelResponse> getPatrollingList({
    required String startPosition,
    required String maximumRecords,
    required BaseFilterModel filters,
  }) async {
    String url =
        '${Apis
        ._get}startPos=$startPosition&maxResults=$maximumRecords';
    var response = await BaseApiService().postRequest(
      requestedData: filters.toJson(),
      isAuthenticated: true,
      url: url,
    );
    return PatrollingModelResponse.fromJson(response);
  }

  Future<PatrollingModel> getGeneralInfoById(String id) async {
    final String url = '${Apis._getGenInfoById}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    log('url $url');
    log('response $response');
    return PatrollingModel.fromJson(response);
  }

  Future<PatrollingOtherModel> getSubSectionById(String id, String subId) async {
    final String url = '${Apis._getSubSecById}/$id/$subId';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return PatrollingOtherModel.fromJson(response);
  }

  Future<PatrollingOtherModel> getNewSubSectionById(String subId) async {
    final String url = '${Apis._getNewSubSecById}/$subId';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return PatrollingOtherModel.fromJson(response);
  }
  Future<GenericResponse> createGenInfo({
    required PatrollingRequestModel body,
    required bool isSubmit,
    // required int eventDuration,
  }) async {
    final String url = "${Apis._createGenInfo}?isSubmit=$isSubmit";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }

  Future<GenericResponse> createOtherInfo({
    required PatrollingOtherRequestModel body,
    required bool isSubmit,
    required String id,
    required String subId,
  }) async {
    final String url = "${Apis._createOtherInfo}/$id/$subId?isSubmit=$isSubmit";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }


  Future<PatrollingModel> getGenIndoDetails(String userId) async {
    final String url = '${Apis._getGenInfoDetails}?userId=$userId';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return PatrollingModel.fromJson(response);
  }

  Future<OwnerUserModel> getOwnerUser(int locId, String ownerType) async {
    final String url = '${Apis._getOwnerUserDetails}?locationId=$locId&ownerType=$ownerType';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return OwnerUserModel.fromJson(response);
  }

}