import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/material_movement/models/material_movement_model.dart';
import 'package:db_atom/src/features/material_movement/models/material_movements_model.dart';
import 'package:db_atom/src/features/material_movement/models/requestModels/material_movement_request.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';

import '../../../models/responseModels/generic_response.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getMaterialMovements = '$baseUrl/getMMList?';

  static final String _getMaterialMovement = '$baseUrl/getMMById';

  static final String _createMaterialMovement = '$baseUrl/createMtrlMvmt';
}

class MaterialMovementServices {
  Future<MaterialMovementsModel> getMaterialMovements({
    required String startPosition,
    required String maximumRecords,
    required String userId,
    required int mmType,
  }) async {
    String url =
        '${Apis._getMaterialMovements}mmType=$mmType&startPos=$startPosition&maxResults=$maximumRecords&userId=$userId';
    var response = await BaseApiService().getRequest(
      isAuthenticated: true,
      url: url,
    );
    return MaterialMovementsModel.fromJson(response);
  }

  Future<MaterialMovementModel> getById(int id) async {
    final String url = '${Apis._getMaterialMovement}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return MaterialMovementModel.fromJson(response);
  }

  /// Create Services
  Future<GenericResponse> createMaterialMovement({
    required MaterialMovementRequest body,
    required bool isSubmit,
  }) async {
    var userId = await SharedPrefs.getUserId();
    final String url =
        "${Apis._createMaterialMovement}?userEmail=$userId&isSubmit=$isSubmit";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }
}
