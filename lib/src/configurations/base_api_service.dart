import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dart_extensions/dart_extensions.dart';
import 'package:db_atom/src/models/responseModels/generic_response.dart';
import 'package:db_atom/src/utils/location_handler.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

import '../features/login/models/login_model.dart';
import '../features/login/models/refresh_token_request.dart';
import '../features/login/services/login_services.dart';
import '../models/responseModels/token_expired.dart';
import '../routing/router.dart';
import '../utils/shared_preferences.dart';

enum RequestType {
  get,
  post,
  delete,
}

class BaseApiService {
  Future<Map<String, String>> getHeaders({bool? isAuthenticated}) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};

    // Passing Location Parameter only if the location service is Enabled

    Position position;
    bool isIOS = Platform.isIOS;
    // log('---isIOS-$isIOS--');
    if (isIOS) {
      LocationPermission locationPermission =
          await Geolocator.checkPermission();
      // log('-locationPermission.name--${locationPermission.name}-----');
      if (locationPermission != LocationPermission.deniedForever) {
        position = await determinePosition();
        headers.addAll({"Latitude": position.latitude.toString()});
        headers.addAll({"Longitude": position.longitude.toString()});
      }
    } else {
      PermissionStatus permissionStatus = await requestLocationPermission();
      log('-permissionStatus--${permissionStatus.toString()}-----');
      if (!permissionStatus.isPermanentlyDenied) {
        position = await determinePosition();
        headers.addAll({"Latitude": position.latitude.toString()});
        headers.addAll({"Longitude": position.longitude.toString()});
      }
    }

    if (isAuthenticated != null && isAuthenticated) {
      String token = await SharedPrefs.getToken();
      // log("token is:$token");
      if (token.isEmptyOrNull) {
        throw TokenExpiredException(message: 'Session has Expired');
      }
      headers.addAll({"Authorization": 'Bearer $token'});
    }
    // log("headers: $headers");
    return headers;
  }

  Future<dynamic> getRequest({
    required String url,
    bool? isAuthenticated,
  }) async {
    try {
      log('url--getData---$url');
      var headers = await getHeaders(
        isAuthenticated: isAuthenticated ?? true,
      );
      // log('headers---${headers.toString()}');
      var response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      log('response.statusCode----${response.statusCode}');
      // if (!url.contains('getLabels') || url.contains('Location')) {
      //   log('response.body----${response.body}');
      // }
      final responseBody = json.decode(response.body);
      if (response.statusCode == HttpStatus.ok) {
        // log('response.body----${response.body}');
        // log('responseBody----$responseBody');
        return responseBody;
      } else {
        log("$url GET response is NOT OK:${response.statusCode}");

        /// If Token is Expired
        if (response.statusCode == 449) {
          var response = await _refreshTokenAndRetry(
              originalUrl: url, requestType: RequestType.get);
          log('---response---449----');
          return response;
        }

        if (response.statusCode.toString() == "401") {
          log("will log out now${response.statusCode}");
          // TODO: Need to handle the logout case
          throw GenericResponse.fromJson(responseBody);
        }
        if (response.statusCode.toString() == "400") {
          log("will log out now${response.statusCode}");
          // TODO: Need to handle the logout case
          throw GenericResponse.fromJson(responseBody);
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

  Future<dynamic> _refreshTokenAndRetry({
    required String originalUrl,
    required RequestType requestType,
    Map<String, dynamic>? requestedData,
  }) async {
    log('--_refreshTokenAndRetry-$originalUrl--');
    // Call refresh token API
    await callRefreshTokenApi();

    // Retry the original request
    if (requestType == RequestType.get) {
      return getRequest(url: originalUrl);
    }

    if (requestType == RequestType.post) {
      return postRequest(
        url: originalUrl,
        requestedData: requestedData!,
      );
    }
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
      throw GenericResponse(message: 'Refresh Token is null.');
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
      log("API URL: $url");
      log("requestedData - ${jsonEncode(requestedData)}");

      var response = await http.post(
        Uri.parse(url),
        headers: await getHeaders(isAuthenticated: isAuthenticated ?? true),
        body: json.encode(requestedData),
      );


      // throw GenericResponse(message: 'TEST');
      log("HTTP Status Code: ${response.statusCode}");
      // log("Response: ${response.body}");
      // if (url.contains('getIncidentMgmtById')) {
      //   log("Response: ${response.body}");
      // }
      var responseBody;
      if (!response.body.isEmptyOrNull) {
        responseBody = json.decode(response.body);
      }

      // responseBody = json.decode(response.body);

      if (response.statusCode == HttpStatus.ok) {
        return responseBody ?? '';
      } else if (response.statusCode == 449) {
        // Token Expired
        return await _refreshTokenAndRetry(
          originalUrl: url,
          requestType: RequestType.post,
          requestedData: requestedData,
        );
      } else if (response.statusCode == 400) {
        // final responseBody = json.decode(response.body);
        log("User is unauthorized. Logging out...");
        log("------responseBody.toString()-------------${responseBody.runtimeType.toString()}");
        Map<String, dynamic> json = responseBody;
        json.putIfAbsent('statusCode', () => '400');
        throw GenericResponse.fromJson(json);
      } else if (response.statusCode == 401) {
        // Unauthorized
        log("User is unauthorized. Logging out...");
        Map<String, dynamic> json = responseBody;
        json.putIfAbsent('statusCode', () => '401');
        throw GenericResponse.fromJson(json);
      }

      if (response.statusCode != HttpStatus.ok) {
        // Handle other error cases
        log("$url POST response is NOT OK:${response.statusCode}");
        log("_response - ${responseBody['msg']}");
        if (responseBody["error"] != null &&
            responseBody["error"].runtimeType == String) {
          throw json.decode(response.body);
        }
      }
      return response;
    } on SocketException {
      // Handle SocketException
      // TODO: Handle Error
    } on GenericResponse catch (e) {
      // Handle GenericCreateResponse
      log('--on GenericCreateResponse POST---${e.toString()}---');
      rethrow;
    } catch (e) {
      // Handle other exceptions
      log("Exception thrown: $e");
      rethrow;
    }
  }

  Future<dynamic> patchRequest({
    required String url,
    bool? isAuthenticated,
  }) async {
    try {
      log('url--patch---$url');
      var headers = await getHeaders(
        isAuthenticated: isAuthenticated ?? true,
      );
      var response = await http.patch(
        Uri.parse(url),
        headers: headers,
      );
      log('response.statusCode----${response.statusCode}');
      final responseBody = json.decode(response.body);
      if (response.statusCode == HttpStatus.ok) {
        return responseBody;
      } else {
        log("$url DELETE response is NOT OK:${response.statusCode}");
        log("$response DELETE response is NOT OK:${response.toString()}");

        /// If Token is Expired
        if (response.statusCode == 449) {
          var response = await _refreshTokenAndRetry(
              originalUrl: url, requestType: RequestType.delete);
          log('---response---449----');
          return response;
        }
        if (response.statusCode == 400) {
          final responseBody = json.decode(response.body);
          log("User is unauthorized. Logging out...");
          log("------responseBody.toString()-------------${responseBody.runtimeType.toString()}");
          throw GenericResponse.fromJson(responseBody);
        }
        if (response.statusCode.toString() == "401") {
          log("will log out now${response.statusCode}");
          // TODO: Need to handle the logout case
          throw GenericResponse.fromJson(responseBody);
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

  Future<dynamic> deleteRequest({
    required String url,
    bool? isAuthenticated,
  }) async {
    try {
      log('url--delete---$url');
      var headers = await getHeaders(
        isAuthenticated: isAuthenticated ?? true,
      );
      var response = await http.delete(
        Uri.parse(url),
        headers: headers,
      );
      log('response.statusCode----${response.statusCode}');
      final responseBody = json.decode(response.body);
      if (response.statusCode == HttpStatus.ok) {
        return responseBody;
      } else {
        log("$url DELETE response is NOT OK:${response.statusCode}");
        log("$response DELETE response is NOT OK:${response.toString()}");

        /// If Token is Expired
        if (response.statusCode == 449) {
          var response = await _refreshTokenAndRetry(
              originalUrl: url, requestType: RequestType.delete);
          log('---response---449----');
          return response;
        }
        if (response.statusCode == 400) {
          final responseBody = json.decode(response.body);
          log("User is unauthorized. Logging out...");
          log("------responseBody.toString()-------------${responseBody.runtimeType.toString()}");
          throw GenericResponse.fromJson(responseBody);
        }
        if (response.statusCode.toString() == "401") {
          log("will log out now${response.statusCode}");
          // TODO: Need to handle the logout case
          throw GenericResponse.fromJson(responseBody);
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
}
