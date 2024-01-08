import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/models/requestModel/shift_schedule_request.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/models/shift_schedule_model.dart';


class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getGuardingMastersData = '$baseUrl/getGMData?';

  static final String _getGuardingMasterData = '$baseUrl/getGMDataById';

  static final String _createGuardingMasterData = '$baseUrl/createGMData?';
}

class ShiftScheduleServices {

  Future<String> getUserEmail() async {
    String email =  await SharedPrefs.getEmail();
    return email;
  }

  Future<ShiftScheduleResponse> getList({
    required String startPosition,
    required String maximumRecords,
    required String userId,
    required String locationId,
  }) async {
    String url =
        '${Apis._getGuardingMastersData}startPos=$startPosition&maxResults=$maximumRecords&userId=$userId&locationId=$locationId';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return ShiftScheduleResponse.fromJson(response);
  }

  Future<ShiftScheduleModel> getById(int id) async {
    final String url = '${Apis._getGuardingMasterData}/$id';
    var response = await BaseApiService().getRequest(
      url: url,
    );
    return ShiftScheduleModel.fromJson(response);
  }

  /// Create Services

  Future<GenericResponse> createShiftSchedule({
    required ShiftScheduleRequest body,
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
