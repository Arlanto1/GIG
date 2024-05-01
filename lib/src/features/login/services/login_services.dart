import 'dart:developer';

import 'package:db_atom/src/features/login/models/login_model.dart';
import 'package:db_atom/src/features/login/models/login_request_model.dart';

import '../../../configurations/base_api_service.dart';
import '../../../configurations/environment_config.dart';
import '../models/refresh_token_request.dart';
import '../models/update_password_request.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _login = '$baseUrl/login';
  static const String _resetPassword = 'oauth2/resetPassword';
  static const String _updatePassword = 'oauth2/updatePassword';
  static const String _refreshToken = 'oauth2/tokenRefresh';
}

class LoginService {
  Future<LoginResponseModel> loginUser(LoginRequestModel data) async {
    String url = Apis._login;
    log('---url----$url----');
    final response = await BaseApiService().postRequest(
        url: url, requestedData: data.toJson(), isAuthenticated: false);
    return LoginResponseModel.fromJson(response);
  }

  Future<LoginResponseModel> forgotPwdAPI(LoginRequestModel data) async {
    String baseUrl = Apis.baseUrl.replaceAll('api/atomrestservice', '');
    String url = baseUrl + Apis._resetPassword;
    final response = await BaseApiService().postRequest(
        url: url, requestedData: data.toJson(), isAuthenticated: false);
    return LoginResponseModel.fromJson(response);
  }

  Future<LoginResponseModel> updatePassword(UpdatePasswordRequest data) async {
    String baseUrl = Apis.baseUrl.replaceAll('api/atomrestservice', '');
    String url = baseUrl + Apis._updatePassword;
    final response = await BaseApiService()
        .postRequest(url: url, requestedData: data.toJson());
    return LoginResponseModel.fromJson(response);
  }

  Future<LoginResponseModel> refreshToken(RefreshTokenRequest data) async {
    String baseUrl = Apis.baseUrl.replaceAll('api/atomrestservice', '');
    String url = baseUrl + Apis._refreshToken;
    final response = await BaseApiService()
        .postRequest(url: url, requestedData: data.toJson());
    return LoginResponseModel.fromJson(response);
  }
}
