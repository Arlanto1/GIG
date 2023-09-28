import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:db_atom/src/features/login/models/refresh_token_request.dart';
import 'package:db_atom/src/features/login/services/login_services.dart';
import 'package:db_atom/src/models/responseModels/generic_creat_response.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../features/login/models/login_model.dart';
import '../routing/router.dart';

class BaseApiService {
  Future<dynamic> getRequest({
    required String url,
    bool isAuthenticated = true,
  }) async {
    try {
      final headers = await _getHeaders(isAuthenticated: isAuthenticated);
      final response = await _performGetRequest(url, headers);
      // log("Response: ${response.body}");
      var handleResponse = _handleResponse(response, url);
      log('_return handleResponse;-----');
      return handleResponse;
    } on SocketException {
      throw NetworkException('Network Lost');
    } catch (e) {
      log('Error: $e');
      rethrow;
    }
  }

  Future<Map<String, String>> _getHeaders({bool? isAuthenticated}) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};

    if (isAuthenticated != null && isAuthenticated) {
      String token = await SharedPrefs.getToken();
      // log("token is:$token");
      headers.addAll({"Authorization": 'Bearer $token'});
    }
    return headers;
  }

  Future<http.Response> _performGetRequest(
      String url, Map<String, String> headers) async {
    // log('GET request URL: $url');
    final response = await http.get(Uri.parse(url), headers: headers);
    log('Response status code: ${response.statusCode}');
    return response;
  }

  Future<dynamic> _handleResponse(http.Response response, String url) async {
    log('GET request URL: $url');
    final responseBody = json.decode(response.body);
    log('-responseBody--$responseBody--');
    if (response.statusCode == HttpStatus.ok) {
      // log('_return responseBody;----${responseBody.toString()}-');
      return responseBody;
    } else {
      log('GET request failed with status code: ${response.statusCode}');

      // /// If Token is Expired
      // if (response.statusCode == 449) {
      //   var response = await _refreshTokenAndRetry(url);
      //   log('---response---449----');
      //   return response;
      // }

      if (response.statusCode == 401) {
        log('User is unauthorized. Logging out...');
        // TODO: Handle logout logic here
      }
      log('Error response body: $responseBody');
      throw LoginResponseModel.fromJson(responseBody);
    }
  }

  Future<dynamic> _refreshTokenAndRetry(String originalUrl) async {
    log('--_refreshTokenAndRetry-$originalUrl--');
    // Call refresh token API
    await callRefreshToken();

    // Retry the original request
    final refreshedHeaders = await _getHeaders(isAuthenticated: true);
    final response = await _performGetRequest(originalUrl, refreshedHeaders);
    // log('-_refreshTokenAndRetry----response-${json.decode(response.body)}--');

    // Return the response from the internal getRequest call
    var resp = await _handleResponse(response, originalUrl);
    log('-----resp---------------${json.decode(resp.body)}-----');
    return resp;
  }

  Future<void> callRefreshToken() async {
    RefreshTokenRequest request = RefreshTokenRequest(
      jwtRefreshRequest: JwtRefreshRequest(
        refreshToken: await SharedPrefs.getRefreshToken(),
        token: await SharedPrefs.getToken(),
      ),
    );
    final LoginService loginService = LoginService();
    LoginResponseModel loginData = await loginService.refreshToken(request);

    // Store the new token
    await SharedPrefs.setToken(loginData.token ?? '');
  }

  Future<dynamic> postRequest({
    required Map<String, dynamic> requestedData,
    bool? isAuthenticated,
    required String url,
    bool? showAlert,
    bool? showLoader,
  }) async {
    try {
      final headers =
          await _getHeaders(isAuthenticated: isAuthenticated ?? true);
      log("API URL: $url");
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(requestedData),
      );

      final responseBody = json.decode(response.body);

      // log("Request Body: ${json.encode(requestedData)}");
      log("HTTP Status Code: ${response.statusCode}");
      // log("Response: ${response.body}");

      if (response.statusCode == HttpStatus.ok) {
        return responseBody;
      } else {
        log("$url POST response is NOT OK: ${response.statusCode}");

        /// If Token is Expired
        if (response.statusCode == 449) {
          /// Call refresh token API
          await callRefreshToken();

          /// call API again
          postRequest(url: url, requestedData: requestedData);
        }

        if (response.statusCode == 401) {
          log("User is unauthorized. Logging out...");
          // TODO: Handle logout logic here
          // logout(context); // You can define this method to handle logout
          throw GenericCreateResponse.fromJson(responseBody);
        }

        if (responseBody != null &&
            responseBody is Map<String, dynamic> &&
            responseBody.containsKey("error")) {
          throw GenericCreateResponse.fromJson(responseBody);
        } else {
          // Handle other error cases here
          throw GenericCreateResponse.fromJson(responseBody);
        }
      }
    } on SocketException {
      // Handle network-related errors
      throw NetworkException("Network Lost");
    } catch (e) {
      // Handle other exceptions
      log("Exception thrown: $e");
      rethrow;
    }
  }

  logout(BuildContext context) async {
    // TODO: Need to clear Shared Preferences Data
    // Constants.clearLocal();
    Navigator.pushNamedAndRemoveUntil(
        context, loginScreenRoute, (route) => false);
  }
}

class ApiException implements Exception {
  final dynamic message;

  ApiException(this.message);

  @override
  String toString() {
    return 'ApiException: $message';
  }
}

class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);

  @override
  String toString() {
    return 'NetworkException: $message';
  }
}
