import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/material_movement/material_movements/models/material_movements_model.dart';


class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getMaterialMovements =
      '$baseUrl/getMMList?';

  static final String _getMaterialMovement =
      '$baseUrl/getMMById';
}

class MaterialMovementServices {

  Future<MaterialMovementsModel> getMaterialMovements(
      {required String startPosition,
      required String maximumRecords,
      required String userId,
      required int mmType}) async {
    String url =
        '${Apis._getMaterialMovements}startPos=$startPosition&maxResults=$maximumRecords&userId=$userId&mmType=$mmType';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return MaterialMovementsModel.fromJson(response);
  }

  Future<MaterialMovementModel> getMaterialMovement(int id) async {
    final String url = '${Apis._getMaterialMovement}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return MaterialMovementModel.fromJson(response);
  }
}
