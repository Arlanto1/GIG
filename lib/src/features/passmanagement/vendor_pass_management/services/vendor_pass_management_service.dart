

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/passmanagement/vendor_pass_management/models/requestModels/vendor_pass_management_request.dart';
import 'package:db_atom/src/features/passmanagement/vendor_pass_management/models/vendor_pass_management_model.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getVendorPassManagements = '$baseUrl/getPassMgmtList?';

  static final String _getVendorPassManagementById = '$baseUrl/getPassMgmtById';

  static final String _createVendorPassManagement = '$baseUrl/createDayPass';
}

class VendorPassManagementServices {

  Future<VendorPassManagementResponse> getVendorPassManagementList({
    required String startPosition,
    required String maximumRecords,
    required int passType,
    required BaseFilterModel filters,
    bool? returnable,
  }) async {
    String url =
        '${Apis._getVendorPassManagements}passType=$passType&startPos=$startPosition&maxResults=$maximumRecords';
    var response = await BaseApiService().postRequest(
      requestedData: filters.toJson(),
      isAuthenticated: true,
      url: url,
    );
    return VendorPassManagementResponse.fromJson(response);
  }

  Future<VendorPassManagementModel> getById(int id) async {
    final String url = '${Apis._getVendorPassManagementById}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return VendorPassManagementModel.fromJson(response);
  }

  /// Create Pass management
  Future<GenericResponse> createVendorPass({
    required VendorPassManagementRequest requestBody,
    required bool isSubmit,
  }) async {
    final String url = "${Apis._createVendorPassManagement}isSubmit=$isSubmit";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: requestBody.toJson(),
    );
    return GenericResponse.fromJson(response);
  }

}
