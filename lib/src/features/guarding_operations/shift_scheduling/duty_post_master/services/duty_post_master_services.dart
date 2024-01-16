import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_master/models/duty_post_master_model.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_master/models/requestModel/duty_post_master_request.dart';


class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getList = '$baseUrl/getGMData?';

  static final String _getGuardingMasterData = '$baseUrl/getGMDataById';

  static final String _createGuardingMasterData = '$baseUrl/createGMData?';
}

class DutyPostMasterServices {

  Future<String> getUserEmail() async {
    String email =  await SharedPrefs.getEmail();
    return email;
  }

  Future<DutyPostMasterResponse> getList({
    required String startPosition,
    required String maximumRecords,
    required String userId,
    required String locationId,
  }) async {
    String url =
        '${Apis._getList}startPos=$startPosition&maxResults=$maximumRecords&userId=$userId&locationId=$locationId';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return DutyPostMasterResponse.fromJson(response);
  }

  Future<DutyPostMasterModel> getById(int id) async {
    final String url = '${Apis._getGuardingMasterData}/$id';
    var response = await BaseApiService().getRequest(
      url: url,
    );
    return DutyPostMasterModel.fromJson(response);
  }

  /// Create Services

  Future<GenericResponse> createDutyPostMaster({
    required DutyPostMasterRequest body,
    required bool isSubmit,
  }) async {
    final String url =
        "${Apis._createGuardingMasterData}userEmail=${await getUserEmail()}&isSubmit=$isSubmit";
    log("API URL------2-2-2-2-2-: $url");
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }

}
