import 'package:dart_extensions/dart_extensions.dart';
import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/parking/models/parking_model.dart';
import 'package:db_atom/src/features/parking/models/requestModels/parking_request_model.dart';
import 'package:db_atom/src/models/base_filter_model.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';

import '../../../models/responseModels/generic_response.dart';


class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getList = '$baseUrl/getParkingList?';
  static final String _getDetails = '$baseUrl/getParkingById';
  static final String _create = '$baseUrl/createParking';
}

class ParkingService {
  Future<String> getUserEmail() async {
    String email = await SharedPrefs.getEmail();
    return email;
  }

  Future<ParkingResponse> getParkingList({
    required String startPosition,
    required String maximumRecords,
    // required String userId,
    String? occId,
    int? occType,
    String? kldId,
    required BaseFilterModel filters,
  }) async {
    String url =
        '${Apis._getList}startPos=$startPosition&maxResults=$maximumRecords';
    // 'userId=${await SharedPrefs.getUserId()}';
    if (!occId.isEmptyOrNull) {
      url = '$url&occuId=$occId&occType=$occType';
    } else if (!kldId.isEmptyOrNull) {
      url = '$url&kldId=$kldId';
    }
    var response = await BaseApiService().postRequest(
      requestedData: filters.toJson(),
      isAuthenticated: true,
      url: url,
    );
    return ParkingResponse.fromJson(response);
  }

  Future<ParkingModel> getParkingDetailsById(String id) async {
    final String url = '${Apis._getDetails}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return ParkingModel.fromJson(response);
  }

  Future<GenericResponse> createParking({
    required ParkingRequestModel body,
    required bool isSubmit,
  }) async {
    final String url = "${Apis._create}?isSubmit=$isSubmit";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }
}
