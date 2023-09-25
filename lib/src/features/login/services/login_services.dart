// Created by Ashok

import 'dart:developer';

import 'package:db_atom/src/features/login/models/login_model.dart';
import 'package:db_atom/src/features/login/models/login_request_model.dart';

import '../../../configurations/base_api_service.dart';
import '../../../configurations/environment_config.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static const String _login = 'https://api.integration.dbatom.arlanto.com/oauth2/loginV2';
  static const String _resetPassword = 'https://api.integration.dbatom.arlanto.com/oauth2/reset/password';
}

class LoginService {
  Future<LoginResponseModel> loginUser(LoginRequestModel data) async {
    const String url = Apis._login;
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: data.toJson()
    );
    log('response---@@-----$response-----');
    return LoginResponseModel.fromJson(response);
  }

  Future<LoginResponseModel> forgotPwdAPI(LoginRequestModel data) async {

    const String url = Apis._resetPassword;
    final response = await BaseApiService().postRequest(
        url: url,
        requestedData: data.toJson()
    );
    log('response---@@-----$response-----');
    return LoginResponseModel.fromJson(response);
    // final endpoint = Environment().config.apiHost;
    // final url = Uri.parse(
    //     'https://api.integration.dbatom.arlanto.com/oauth2/reset/password');
    // log('login url $url');
    // try {
    //   final response = await http.post(url,
    //       headers: {
    //         'Content-Type': 'application/json; charset=UTF-8',
    //       },
    //       body: json.encode(data));
    //   if (response.statusCode == 200) {
    //     log('login success ');
    //     try {
    //       return LoginResponseModel.fromJson(json.decode(response.body));
    //     } catch (e) {
    //       return LoginResponseModel.fromJson(json.decode(response.body));
    //     }
    //   }
      // else if (response.statusCode == 401) {
      //   log('login failed ');

      //   int refreshToken = await RefreshTokenService.getRefreshToken();
      //   if (refreshToken == 200) {
      //     LoginResponseModel model = await forgotPwdAPI(data);
      //     return model;
      //   } else {
      //     return LoginResponseModel.fromJson(json.decode(response.body));
      //   }
      // }
    //   else {
    //     log('login failed ');
    //
    //     LoginResponseModel.fromJson(json.decode(response.body));
    //     throw json.decode('{"errorMessage":"Network Lost"}');
    //   }
    // } on SocketException {
    //   throw json.decode('{"errorMessage":"Network Lost"}');
    // }
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
    if (id.isNotEmpty) data["id"] = id;
    if (password.isNotEmpty) data["password"] = password;
    if (otp.isNotEmpty) data['otp'] = otp;
    return data;
  }
}
