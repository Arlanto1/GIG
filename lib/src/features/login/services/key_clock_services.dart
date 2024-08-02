import 'dart:convert';
import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:http/http.dart' as http;

class Apis {
  static final String baseUrl = Environment().config.keyClockApiHost;
  static final String keyClockRealm = Environment().config.keyClockRealm;
  static final String keyClockClientSecret =
      Environment().config.keyClockClientSecret;

  static final String _login = '$baseUrl/login';
}

class KeyClockServices {
  // static const String baseUrl = 'http://localhost:8080';
  // static const String realm = 'master';
  // static const String clientId = '1234';
  // static const String clientSecret = 't8rO0xTSmoQMEX96XpLemqvEYwr5DIOQ';

  // static const String baseUrl = 'https://qa.keycloak.arlanto.com';
  // static const String realm = 'Atom';
  static const String clientId = 'atom';

  // static const String clientSecret = 'JbU8TZf8juktrQgsDjBwjb2W3FehRtPl';

  Future<String> login(LoginRequestModel data) async {
    Map<String, dynamic> requestBody = {
      'grant_type': 'password',
      'client_id': clientId,
      'username': data.request?.userName,
      'password': data.request?.password,
      'client_secret': Apis.keyClockClientSecret,
    };
    String url = Apis._login;
    log('---url----$url----');
    final response = await BaseApiService().postRequest(
        url: url, requestedData: requestBody, isAuthenticated: false);
    String accessToken = response['access_token'];
    return accessToken;
  }

  Future<Map<String, dynamic>> authenticate(
      String username, String password) async {
    // Keycloak authentication endpoint
    String authUrl =
        '${Apis.baseUrl}/realms/${Apis.keyClockRealm}/protocol/openid-connect/token';
    log('---authUrl----$authUrl----');

    // Construct the request body
    Map<String, dynamic> requestBody = {
      'grant_type': 'password',
      'client_id': clientId,
      'username': username,
      'password': password,
      'client_secret': Apis.keyClockClientSecret,
    };

    // Send a POST request to Keycloak's token endpoint
    var response = await http.post(
      Uri.parse(authUrl),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: Uri(queryParameters: requestBody).query,
    );

    // Parse the response
    if (response.statusCode == 200) {
      // Authentication successful, parse and return the token
      Map<String, dynamic> tokenData = json.decode(response.body);
      return tokenData;
    } else {
      // Authentication failed, return an error message
      var responseBody = json.decode(response.body);
      log('--responseBody----${responseBody.toString()}-');
      throw GenericResponse(message: responseBody['error_description']);

      // throw Exception(
      //     'Failed to authenticate. Status code: ${response.statusCode}');
    }
  }
}
