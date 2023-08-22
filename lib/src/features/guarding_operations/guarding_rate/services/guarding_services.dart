import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/createfound/models/emplyee_departments_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/get_user_model.dart';
import 'package:db_atom/src/features/createfound/models/serial_number_model.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/models/rates_response.dart';
import 'package:db_atom/src/features/material_movement/models/quantity_units.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/analyst_model.dart';

import '../../../createfound/models/get_depositor_model.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getRates = '$baseUrl/getGMRate?';
}

class GuardingServices {
  //TODO: Name change
  Future<RatesResponse> getMaterialMovements(
      {required String startPosition,
      required String maximumRecords,
      required String userId,
      required int mmType}) async {
    String url =
        '${Apis._getRates}startPos=$startPosition&maxResults=$maximumRecords&userId=$userId&mmType=$mmType';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return RatesResponse.fromJson(response);
  }
}
