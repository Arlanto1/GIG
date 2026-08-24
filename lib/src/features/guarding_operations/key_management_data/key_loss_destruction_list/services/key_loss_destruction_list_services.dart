import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_loss_destruction_list/models/key_loss_destruction_list_model.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_loss_destruction_list/models/requestModels/key_loss_destruction_request.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getKeyLossDestruction =
      '$baseUrl/getKemMgmtDestructiontList?';

  static final String _getGIById = '$baseUrl/getKldById';
  static final String _createKeyLossDes = '$baseUrl/createKeyLossDes';
}

class KeyLossDestructionListServices {
  Future<String> getUserEmail() async {
    String email = await SharedPrefs.getEmail();
    return email;
  }

  Future<KeyLossDestructionListResponse> getList({
    required String startPosition,
    required String maximumRecords,
    required BaseFilterModel filters,
  }) async {
    String url =
        '${Apis._getKeyLossDestruction}startPos=$startPosition&maxResults=$maximumRecords';
    var response = await BaseApiService().postRequest(
      requestedData: filters.toJson(),
      isAuthenticated: true,
      url: url,
    );
    return KeyLossDestructionListResponse.fromJson(response);
  }

  Future<KeyLossDestructionListModel> getById(int id) async {
    final String url = '${Apis._getGIById}/$id';
    var response = await BaseApiService().getRequest(
      url: url,
    );
    return KeyLossDestructionListModel.fromJson(response);
  }

  /// Create Services

  Future<GenericResponse> createKeyLossDestruction({
    required KeyLossDestructionRequest body,
    required bool isSubmit,
    required int? kmId,
  }) async {
    final String url =
        "${Apis._createKeyLossDes}?kmId=$kmId&isSubmit=$isSubmit&isKeyManagementMaster=false";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }
}
