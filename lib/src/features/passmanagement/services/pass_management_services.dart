

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/passmanagement/models/pass_management_model.dart';
import 'package:db_atom/src/features/passmanagement/models/requestModels/pass_management_request.dart';


class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getPassManagements = '$baseUrl/getPassMgmtList?';

  static final String _getPassManagementById = '$baseUrl/getPassMgmtById';

  static final String _createPassManagement = '$baseUrl/createPass';
}

class PassManagementServices {

  Future<PassManagementResponseModel> getPassManagementList({
    required String startPosition,
    required String maximumRecords,
    required int mmType,
    required BaseFilterModel filters,
    bool? returnable,
  }) async {
    String url =
        '${Apis._getPassManagements}mmType=$mmType&startPos=$startPosition&maxResults=$maximumRecords';
    if (returnable != null) {
      url = '$url&returnable=$returnable';
    }
    var response = await BaseApiService().postRequest(
      requestedData: filters.toJson(),
      isAuthenticated: true,
      url: url,
    );
    return PassManagementResponseModel.fromJson(response);
  }

  Future<PassManagementModel> getById(int id) async {
    final String url = '${Apis._getPassManagementById}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return PassManagementModel.fromJson(response);
  }

  /// Create Pass management
  Future<GenericResponse> createPass({
    required PassManagementRequest requestBody,
    required bool isSubmit,
  }) async {
    final String url = "${Apis._createPassManagement}isSubmit=$isSubmit";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: requestBody.toJson(),
    );
    return GenericResponse.fromJson(response);
  }

}
