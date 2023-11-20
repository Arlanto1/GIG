import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:db_atom/src/models/responseModels/generic_create_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../features/login/models/login_model.dart';
import '../features/login/models/refresh_token_request.dart';
import '../features/login/services/login_services.dart';
import '../models/responseModels/generic_error_response.dart';
import '../routing/router.dart';
import '../utils/shared_preferences.dart';

class BaseApiService {
  Future<Map<String, String>> _getHeaders({bool? isAuthenticated}) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};

    if (isAuthenticated != null && isAuthenticated) {
      String token = await SharedPrefs.getToken();
      log("token is:$token");
      headers.addAll({"Authorization": 'Bearer $token'});
    }
    return headers;
  }

  Future<dynamic> getRequest({
    required String url,
    bool? isAuthenticated,
  }) async {
    try {
      log('url--getData---$url');
      var headers = await _getHeaders(
        isAuthenticated: isAuthenticated ?? true,
      );
      var response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      log('response.statusCode----${response.statusCode}');
      final responseBody = json.decode(response.body);
      if (response.statusCode == HttpStatus.ok) {
        // log('response.body----${response.body}');
        // log('responseBody----$responseBody');
        return responseBody;
      } else {
        log("$url GET response is NOT OK:${response.statusCode}");

        /// If Token is Expired
        if (response.statusCode == 449) {
          var response = await _refreshTokenAndRetry(url);
          log('---response---449----');
          return response;
        }

        if (response.statusCode.toString() == "401") {
          log("will log out now${response.statusCode}");
          // TODO: Need to handle the logout case
          throw GenericCreateResponse.fromJson(responseBody);
        }
        throw json.decode(response.body);
      }
    } on SocketException {
      throw json.decode('{"errorMessage":"Network Lost"}');
    } catch (e) {
      log('$e');
      rethrow;
    }
  }

  logout(BuildContext context) async {
    // TODO: Need to clear Shared Preferences Data
    // Constants.clearLocal();
    Navigator.pushNamedAndRemoveUntil(
        context, loginScreenRoute, (route) => false);
  }

  Future<dynamic> _refreshTokenAndRetry(String originalUrl) async {
    log('--_refreshTokenAndRetry-$originalUrl--');
    // Call refresh token API
    await callRefreshTokenApi();

    // Retry the original request
    return getRequest(url: originalUrl);
  }

  Future<void> callRefreshTokenApi() async {
    RefreshTokenRequest request = RefreshTokenRequest(
      jwtRefreshRequest: JwtRefreshRequest(
        refreshToken: await SharedPrefs.getRefreshToken(),
        token: await SharedPrefs.getToken(),
      ),
    );
    final LoginService loginService = LoginService();
    LoginResponseModel loginData = await loginService.refreshToken(request);

    // Store the new token
    log('Store the new token');
    if (loginData.token == null || loginData.token!.isEmpty) {
      log('---SETTING EMPTY TOKEN--------');
      throw GenericErrorResponse(message: 'Refresh Token is null.');
    }
    await SharedPrefs.setToken(loginData.token!);
  }

  Future<dynamic> postRequest({
    required Map<String, dynamic> requestedData,
    bool? isAuthenticated,
    required String url,
    bool? showAlert,
    bool? showLoader,
  }) async {
    try {
      // log("requestedData - $requestedData");
      log("requestedData - ${jsonEncode(requestedData)}");
      var response = await http.post(
        Uri.parse(url),
        headers: await _getHeaders(
          isAuthenticated: isAuthenticated ?? true,
        ),
        body: json.encode(requestedData),
      );
      log("API URL: $url");
      log("HTTP Status Code: ${response.statusCode}");
      log("Response: ${response.body}");

      final responseBody = json.decode(response.body);

      if (response.statusCode == HttpStatus.ok) {
        return responseBody;
      } else {
        log("$url POST response is NOT OK:${response.statusCode}");

        /// If Token is Expired
        if (response.statusCode == 449) {
          var response = await _refreshTokenAndRetry(url);
          log('---response---449----');
          return response;
        }
        try {
          if (response.statusCode == 400) {
            final responseBody = json.decode(response.body);
            log("User is unauthorized. Logging out...");
            log("------responseBody.toString()-------------${responseBody.runtimeType.toString()}");
            // TODO: Handle logout logic here
            // logout(context); // You can define this method to handle logout

            throw GenericErrorResponse.fromJson(responseBody);
          }
        } catch (e) {
          // Handle the exception
          if (e is GenericErrorResponse) {
            // Handle the case when the response is a GenericErrorResponse
            log("Error ID: ${e.id}, Message: ${e.message}");
          } else {
            // Handle other types of exceptions or log them
            log("Unexpected error: $e");
          }
        }
        if (response.statusCode == 401) {
          log("User is unauthorized. Logging out...");
          log("------responseBody.toString()-------------${responseBody.toString()}");
          // TODO: Handle logout logic here
          // logout(context); // You can define this method to handle logout
          throw GenericCreateResponse.fromJson(responseBody);
        }

        // {"success":false,"message":"Incorrect Otp"}
        log("_response - ${responseBody['msg']}");
        if (responseBody["error"] != null &&
            responseBody["error"].runtimeType == String) {
          throw json.decode(response.body);
        }
        return response;
      }
    } on SocketException {
      // TODO: Handle Error
    } catch (e) {
      log("Exception thrown: $e");
      rethrow;
    }
  }
}
