import 'dart:convert';
import 'dart:developer';
import 'dart:io';

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
      log('--response-11--$response}--');
      return _handleResponse(response);
    } on SocketException {
      throw NetworkException('Network Lost');
    } catch (e) {
      log('Error: $e');
      rethrow;
    }
  }

  Future<Map<String, String>> _getHeaders({bool? isAuthenticated}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json'
    };

    if (isAuthenticated != null && isAuthenticated) {
      //TODO: Need to implement it
      String token = await SharedPrefs.getToken();
      log("token is:$token");
        headers.addAll({"Authorization": 'Bearer $token'});
      // headers.addAll({"Bearer": token});
      return headers;
    }

    log('--headers------1---${headers.toString()}----');
    return headers;
  }

  Future<http.Response> _performGetRequest(
      String url, Map<String, String> headers) async {
    log('GET request URL: $url');
    final response = await http.get(Uri.parse(url), headers: headers);
    log('Response status code: ${response.statusCode}');
    return response;
  }

  dynamic _handleResponse(http.Response response) {
    log('----_handleResponse---${response.body.toString()}---');
    log('----_handleResponse--decode-${json.decode(response.body)}---');

    final responseBody = json.decode(response.body);
    log('----_handleResponse---responseBody-$responseBody--');

    if (response.statusCode == HttpStatus.ok) {
      log('----_handleResponse---responseBody----HttpStatus.ok------$responseBody--');
      return responseBody;
    } else {
      log('GET request failed with status code: ${response.statusCode}');
      if (response.statusCode == 401) {
        log('User is unauthorized. Logging out...');
        // TODO: Handle logout logic here
      }
      log('Error response body: $responseBody');
      throw LoginResponseModel.fromJson(responseBody);
    }
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
      log('Headers: ${headers.toString()}----');
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(requestedData),
      );

      final responseBody = json.decode(response.body);

      log("API URL: $url");
      log("Request Body: ${json.encode(requestedData)}");
      log("HTTP Status Code: ${response.statusCode}");
      log("Response: ${response.body}");

      if (response.statusCode == HttpStatus.ok) {
        return responseBody;
      } else {
        log("$url POST response is NOT OK: ${response.statusCode}");
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
