import 'dart:convert';
import 'dart:io';

import 'package:db_atom/src/utils/refresh_token/refresh_token_response_model.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../configurations/environment_config.dart';

class GenerateTokenService {
  static Future<int> getGenerateToken() async {
    String token = await SharedPrefs.getToken();

    final endpoint = Environment().config.apiHost;
    final url =
        Uri.parse('https://api.integration.dbatom.arlanto.com/oauth2/token')
            .replace(queryParameters: {
      "clientId": "vzelhdxCKJekoEJVP0KrCQ==",
      "clientSecret": "17XCc4+opLnRhsY0th3i3L1I++0MhfqPf1Y8jDBYJYE=",
    });
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        //encoding:encoding ,
      );
      if (response.statusCode == 200) {
        try {
          final refreshTokenData =
              RefreshTokenResponseModel.fromJson(json.decode(response.body));
          await SharedPrefs.setToken(refreshTokenData.token ?? '');

          return refreshTokenData.status ?? 200;
        } catch (e) {
          return 449;
        }
      } else {
        return 449;
      }
    } on SocketException {
      return 449;
    }
  }
}
