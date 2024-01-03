import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/models/key_management_master_model.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/models/requestModels/key_management_master_request.dart';


class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getList = '$baseUrl/getKeyMgmtList?';

  static final String _getGIById = '$baseUrl/getKeyMgmtGiById';

  static final String _createGuardingMasterData = '$baseUrl/createGMData?';
}

class KeyManagementMasterServices {

  Future<String> getUserEmail() async {
    String email =  await SharedPrefs.getEmail();
    return email;
  }

  Future<KeyManagementMasterResponse> getList({
    required String startPosition,
    required String maximumRecords,
    // required String userId,
    // required String locationId,
  }) async {
    String url =
        '${Apis._getList}startPos=$startPosition&maxResults=$maximumRecords';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    log('--response----${response.toString()}-');

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
        "${Apis._createGuardingMasterData}userEmail=${await getUserEmail()}&isSubmit=$isSubmit";
    log("API URL------2-2-2-2-2-: $url");
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }

}
