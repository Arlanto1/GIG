import 'dart:convert';
import 'dart:io';

import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../configurations/environment_config.dart';
import 'refresh_token_response_model.dart';

class RefreshTokenService {
  static Future<int> getRefreshToken() async {
    String token = await SharedPrefs.getToken();
    await Future.delayed(const Duration(seconds: 3));

    final endpoint = Environment().config.apiHost;
    final url = Uri.parse('$endpoint/oauth2/token/refresh');
    final parameters = <String, dynamic>{
      "clientId": "vzelhdxCKJekoEJVP0KrCQ==",
      "clientSecret": "17XCc4+opLnRhsY0th3i3L1I++0MhfqPf1Y8jDBYJYE=",
      "token": token,
    };
    try {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          encoding: Encoding.getByName('utf-8'),
          body: parameters);
      if (response.statusCode == 200) {
        try {
          RefreshTokenResponseModel refreshTokenData =
              RefreshTokenResponseModel.fromJson(json.decode(response.body));
          print('refresh token data ${refreshTokenData.token}');
          await SharedPrefs.setToken(refreshTokenData.token ?? '');
          return refreshTokenData.status ?? 200;
        } catch (e) {
          return 449;
        }
      } else {
        print('refresh token error');
        return 449;
      }
    } on SocketException {
      return 449;
    }
  }
}
