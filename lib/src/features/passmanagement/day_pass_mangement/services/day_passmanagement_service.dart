

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/passmanagement/day_pass_mangement/models/day_pass_management_model.dart';
import 'package:db_atom/src/features/passmanagement/day_pass_mangement/models/requestModels/day_pass_management_request.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getPassManagements = '$baseUrl/getPassMgmtList?';

  static final String _getPassManagementById = '$baseUrl/getPassMgmtById';

  static final String _createPassManagement = '$baseUrl/createDayPass';
}

class DayPassManagementServices {

  Future<DayPassManagementResponseModel> getPassManagementList({
    required String startPosition,
    required String maximumRecords,
    required int passType,
    required BaseFilterModel filters,
  }) async {
    String url =
        '${Apis._getPassManagements}passType=$passType&startPos=$startPosition&maxResults=$maximumRecords';
    var response = await BaseApiService().postRequest(
      requestedData: filters.toJson(),
      isAuthenticated: true,
      url: url,
    );
    return DayPassManagementResponseModel.fromJson(response);
  }

  Future<DayPassManagementModel> getById(int id) async {
    final String url = '${Apis._getPassManagementById}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return DayPassManagementModel.fromJson(response);
  }

  /// Create Pass management
  Future<GenericResponse> createPass({
    required DayPassManagementRequest requestBody,
    required bool isSubmit,
  }) async {
    final String url = "${Apis._createPassManagement}?isSubmit=$isSubmit";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: requestBody.toJson(),
    );
    return GenericResponse.fromJson(response);
  }

}
