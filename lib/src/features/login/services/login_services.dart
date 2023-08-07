// Created by Ashok

import 'dart:convert';
import 'dart:io';

import 'package:db_atom/src/features/login/models/login_model.dart';
import 'package:db_atom/src/features/login/models/login_request_model.dart';
import 'package:db_atom/src/utils/refresh_token/refresh_token_service.dart';
import 'package:http/http.dart' as http;

import '../../../configurations/environment_config.dart';

class LoginService {
  Future<LoginResponseModel> loginUser(LoginRequestModel data) async {
    await Future.delayed(const Duration(seconds: 3));

    final endpoint = Environment().config.apiHost;
    final url = Uri.parse('https://api.integration.dbatom.arlanto.com/oauth2/login');
    print('login url ${url}');
    try {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(data));
      if (response.statusCode == 200) {
        print('login success ');
        try {
          return LoginResponseModel.fromJson(json.decode(response.body));
        } catch (e) {
          return LoginResponseModel();
        }
      } else if (response.statusCode == 401) {
        print('login failed ');

        int refreshToken = await RefreshTokenService.getRefreshToken();
        if (refreshToken == 200) {
          LoginResponseModel model = await loginUser(data);
          return model;
        } else {
          return LoginResponseModel();
        }
      } else {
        print('login failed ');

        throw json.decode(response.body);
      }
    } on SocketException {
      throw json.decode('{"errorMessage":"Network Lost"}');
    }
  }
}

class LoginRequestBody {
  String id;
  String password;
  String otp;
  LoginRequestBody(
      {required this.id, required this.password, required this.otp});

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data["id"] = id;
    data["password"] = password;
    data['otp'] = otp;
    return data;
  }
}
