import 'dart:developer';

import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/event_protection/event_protection_details/contact_info/models/ci_model.dart';
import 'package:db_atom/src/features/event_protection/models/event_protection_model.dart';
import 'package:db_atom/src/features/material_movement/models/material_movements_model.dart';
import 'package:db_atom/src/features/material_movement/models/requestModels/material_movement_request.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';

import '../../../models/responseModels/generic_creat_response.dart';
import '../event_protection_details/general_info/models/gi_model.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getEventProtections = '$baseUrl/getEPLists?';

  static final String _getGI = '$baseUrl/getEPGIById';
  static final String _getCI = '$baseUrl/getEPCIById';

  static final String _createMaterialMovement = '$baseUrl/createMtrlMvmt';
}

class EventProtectionServices {
  Future<String> getUserEmail() async {
    String email = await SharedPrefs.getEmail();
    return email;
  }

  Future<String> getUserId() async {
    String email = await SharedPrefs.getUserId();
    return email;
  }

  Future<EventProtectionResponse> getEventProtections({
    required String startPosition,
    required String maximumRecords,
    required String userId,
  }) async {
    String url =
        '${Apis._getEventProtections}startPos=$startPosition&maxResults=$maximumRecords&userId=${await getUserId()}';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return EventProtectionResponse.fromJson(response);
  }

  Future<GiModel> getGI(int id) async {
    final String url = '${Apis._getGI}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return GiModel.fromJson(response);
  }

  Future<CiModel> getCI(int id) async {
    final String url = '${Apis._getCI}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return CiModel.fromJson(response);
  }

  Future<bool> showGuardInfo(int id) async {
    final String url = '${Apis._getCI}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return true; // TODO: Need to check
  }

  /// Create Services

  Future<GenericCreateResponse> createMaterialMovement({
    required MaterialMovementRequest body,
    required bool isSubmit,
  }) async {
    var userId = await SharedPrefs.getUserId();
    final String url =
        "${Apis._createMaterialMovement}?userEmail=$userId&isSubmit=$isSubmit";
    log("API URL------2-2-2-2-2-: $url");
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericCreateResponse.fromJson(response);
  }

}
