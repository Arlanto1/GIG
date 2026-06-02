import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/utils/device_infomation.dart';
import '../models/refresh_token_request.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _login = '$baseUrl/login';
  static final String _loginSso = '$baseUrl/loginSso';
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

  Future<LoginResponseModel> ssoLoginUser(MsalUser data) async {
  //   String url = Apis._loginSso;
  //   log('---url----$url----');
  //   final response = await BaseApiService().postRequest(
  //       url: url, requestedData: {"request": data.toJson()}, isAuthenticated: false);
  //   return LoginResponseModel.fromJson(response);
  // }
    String url = Apis._loginSso;
    log('---loginSso url----$url----');
    final deviceId = await DeviceInformation.getDeviceId();
    final Map<String, dynamic> body = {
      'request': {
        'userName': data.username,       // ← was "username" via toJson()
        'displayName': data.displayName,
        'accessToken': data.accessToken,
        'tokenCreatedAt': data.tokenCreatedAt,
        'tokenExpiresOn': data.tokenExpiresOn,
        'deviceId': deviceId,            // ← newly added
      }
    };
    log('---loginSso payload----${body.toString()}----');
    final response = await BaseApiService().postRequest(
        url: url, requestedData: body, isAuthenticated: false);
    // LogService.add('loginSso Response: $response');
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
