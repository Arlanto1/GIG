import 'dart:developer';

import 'package:db_atom/src/features/login/models/login_model.dart';
import 'package:db_atom/src/features/login/models/login_request_model.dart';

import '../../../configurations/base_api_service.dart';
import '../../../configurations/environment_config.dart';
import '../models/refresh_token_request.dart';
import '../models/update_password_request.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static const String _login =
      'https://api.integration.dbatom.arlanto.com/oauth2/loginV2';
  static const String _resetPassword =
      'https://api.integration.dbatom.arlanto.com/oauth2/updatePassword';
  static const String _refreshToken =
      'https://api.integration.dbatom.arlanto.com/oauth2/tokenRefresh';
}

class LoginService {
  Future<LoginResponseModel> loginUser(LoginRequestModel data) async {
    const String url = Apis._login;
    final response = await BaseApiService()
        .postRequest(url: url, requestedData: data.toJson());
    log('response---@@-----$response-----');
    return LoginResponseModel.fromJson(response);
  }

  Future<LoginResponseModel> forgotPwdAPI(LoginRequestModel data) async {
    const String url = Apis._resetPassword;
    final response = await BaseApiService()
        .postRequest(url: url, requestedData: data.toJson(), isAuthenticated: false);
    log('response---@@-----$response-----');
    return LoginResponseModel.fromJson(response);
  }

  Future<LoginResponseModel> updatePassword(UpdatePasswordRequest data) async {
    const String url = Apis._resetPassword;
    final response = await BaseApiService()
        .postRequest(url: url, requestedData: data.toJson());
    log('response---@@-----$response-----');
    return LoginResponseModel.fromJson(response);
  }

  Future<LoginResponseModel> refreshToken(RefreshTokenRequest data) async {
    const String url = Apis._refreshToken;
    final response = await BaseApiService()
        .postRequest(url: url, requestedData: data.toJson());
    log('response---@@-----$response-----');
    return LoginResponseModel.fromJson(response);
  }
}
