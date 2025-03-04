

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/passmanagement/visitor_pass_management/models/requestModels/visitor_pass_management_request.dart';
import 'package:db_atom/src/features/passmanagement/visitor_pass_management/models/visitor_pass_management_model.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getVisitorPassManagements = '$baseUrl/getPassMgmtList?';

  static final String _getVisitorPassManagementById = '$baseUrl/getPassMgmtById';

  static final String _createVisitorPassManagement = '$baseUrl/createDayPass';
}

class VisitorPassManagementServices {

  Future<VisitorPassManagementResponse> getVisitorPassManagementList({
    required String startPosition,
    required String maximumRecords,
    required int passType,
    required BaseFilterModel filters,
  }) async {
    String url =
        '${Apis._getVisitorPassManagements}passType=$passType&startPos=$startPosition&maxResults=$maximumRecords';
    var response = await BaseApiService().postRequest(
      requestedData: filters.toJson(),
      isAuthenticated: true,
      url: url,
    );
    return VisitorPassManagementResponse.fromJson(response);
  }

  Future<VisitorPassManagementModel> getById(int id) async {
    final String url = '${Apis._getVisitorPassManagementById}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return VisitorPassManagementModel.fromJson(response);
  }

  /// Create Pass management
  Future<GenericResponse> createVisitorPass({
    required VisitorPassManagementRequest requestBody,
    required bool isSubmit,
  }) async {
    final String url = "${Apis._createVisitorPassManagement}isSubmit=$isSubmit";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: requestBody.toJson(),
    );
    return GenericResponse.fromJson(response);
  }

}
