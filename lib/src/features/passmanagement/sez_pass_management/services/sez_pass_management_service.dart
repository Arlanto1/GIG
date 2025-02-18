import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/passmanagement/sez_pass_management/models/requestModels/sez_pass_management_request.dart';
import 'package:db_atom/src/features/passmanagement/sez_pass_management/models/sez_pass_management_model.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getSezPassManagements = '$baseUrl/getPassMgmtList?';

  static final String _getSezPassManagementById = '$baseUrl/getPassMgmtById';

  static final String _createSezPassManagement = '$baseUrl/createPass';
}

class SezPassManagementServices {

  Future<SezPassManagementResponseModel> getSezPassManagementList({
    required String startPosition,
    required String maximumRecords,
    required int passType,
    required BaseFilterModel filters,
  }) async {
    String url =
        '${Apis._getSezPassManagements}passType=$passType&startPos=$startPosition&maxResults=$maximumRecords';
    var response = await BaseApiService().postRequest(
      requestedData: filters.toJson(),
      isAuthenticated: true,
      url: url,
    );
    return SezPassManagementResponseModel.fromJson(response);
  }

  Future<SezPassManagementModel> getById(int id) async {
    final String url = '${Apis._getSezPassManagementById}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return SezPassManagementModel.fromJson(response);
  }

  /// Create Pass management
  Future<GenericResponse> createSezPass({
    required SezPassManagementRequest requestBody,
    required bool isSubmit,
  }) async {
    final String url = "${Apis._createSezPassManagement}isSubmit=$isSubmit";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: requestBody.toJson(),
    );
    return GenericResponse.fromJson(response);
  }

}
