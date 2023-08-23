import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/models/rates_response.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getRates = '$baseUrl/getGMRates?';
  static final String _getRate = '$baseUrl/getGMRateById/';
}

class GuardingServices {
  Future<RatesResponse> getRates({
    required String startPosition,
    required String maximumRecords,
    required String userId,
  }) async {
    String url =
        '${Apis._getRates}startPos=$startPosition&maxResults=$maximumRecords&userId=$userId';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return RatesResponse.fromJson(response);
  }

  Future<GMRate> getRate(int id) async {
    final String url = '${Apis._getRate}$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return GMRate.fromJson(response);
  }
}
