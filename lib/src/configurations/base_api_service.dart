import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dart_extensions/dart_extensions.dart';
import 'package:db_atom/main.dart';
import 'package:db_atom/src/constants/constant_crashlytics_keys.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/models/responseModels/generic_response.dart';
import 'package:db_atom/src/models/responseModels/permission_error.dart';
import 'package:db_atom/src/utils/inactivity_functions.dart';
import 'package:db_atom/src/utils/location_handler.dart';
import 'package:db_atom/src/utils/utils_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  patch,
  delete,
}

class BaseApiService {
  Future<Map<String, String>> getHeaders({bool? isAuthenticated}) async {
    unawaited(InactivityFunctions().updateUserInteraction());
    Map<String, String> headers = {'Content-Type': 'application/json'};

    // Passing Location Parameter only if the location service is Enabled
    Position position;
    bool isIOS = Platform.isIOS;
    // log('---isIOS-$isIOS--');
    // if (isIOS) {
    //   LocationPermission locationPermission =
    //       await Geolocator.checkPermission();
    //   // log('-locationPermission.name--${locationPermission.name}-----');
    //   if (locationPermission != LocationPermission.deniedForever) {
    //     position = await determinePosition();
    //     headers.addAll({"Latitude": position.latitude.toString()});
    //     headers.addAll({"Longitude": position.longitude.toString()});
    //   } else {
    //     // throw PermissionError(message: Constants.locationPermissionError);
    //   }
    // }
    // else {
    //   PermissionStatus permissionStatus   = await requestLocationPermission();
    //   log('-permissionStatus--${permissionStatus.toString()}-----');
    //   if (!permissionStatus.isPermanentlyDenied) {
    //     position = await determinePosition();
    //     headers.addAll({"Latitude": position.latitude.toString()});
    //     headers.addAll({"Longitude": position.longitude.toString()});
    //   } else {
    //     // throw PermissionError(message: Constants.locationPermissionError);
    //   }
    // }

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
    int? statusCode;

    try {
      log('url--getData---$url');
      var headers = await getHeaders(
        isAuthenticated: isAuthenticated ?? true,
      );
      var response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      statusCode = response.statusCode; // Store status code
      log('response.statusCode----$statusCode');

      final responseBody = json.decode(response.body);
      if (response.statusCode == HttpStatus.ok) {
        return responseBody;
      } else {
        log("$url GET response is NOT OK: $statusCode");

        /// Handle specific status codes like token expiry, 401, 400
        if (response.statusCode == 449) {
          var response = await _refreshTokenAndRetry(
              originalUrl: url, requestType: RequestType.get);
          log('---response---449----');
          return response;
        }

        if (response.statusCode == 401 || response.statusCode == 400) {
          log("will log out now $statusCode");
          throw GenericResponse.fromJson(responseBody);
        }

        setFirebaseLog(
            requestType: RequestType.get,
            apiUrl: url,
            statusCode: response.statusCode.toString(),
            response: responseBody);
        throw responseBody;
      }
    } on SocketException {
      throw json.decode('{"errorMessage":"Network Lost"}');
    } catch (e) {
      var decodedResponse = tryJsonDecode(e);
      log("Exception thrown: $e");
      setFirebaseLog(
          requestType: RequestType.get,
          apiUrl: url,
          statusCode: statusCode?.toString() ?? unhandled,
          response: decodedResponse.toString());
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
    int? statusCode; // Declare statusCode variable to capture status code

    try {
      log("API URL: $url");
      log("requestedData - ${jsonEncode(requestedData)}");

      log("handleQaEnv");

      // Call the handleQaEnv method to display and pause the program
      if (await SharedPrefs.getLogsToggle() && url.contains('api.qa.')) {
        await handleQaEnv(
          true, // isQaEnv
          url, // url
          jsonEncode(requestedData), // body
        );
      }

      var response = await http.post(
        Uri.parse(url),
        headers: await getHeaders(isAuthenticated: isAuthenticated ?? true),
        body: json.encode(requestedData),
      );

      statusCode = response.statusCode;
      log("HTTP Status Code: $statusCode");

      var responseBody;
      if (!response.body.isEmptyOrNull) {
        responseBody = json.decode(response.body);
      }

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
        log("User is unauthorized. Logging out...");
        Map<String, dynamic> json = responseBody;
        json.putIfAbsent('statusCode', () => '400');
        throw GenericResponse.fromJson(json);
      } else if (response.statusCode == 401) {
        log("User is unauthorized. Logging out...");
        Map<String, dynamic> json = responseBody;
        json.putIfAbsent('statusCode', () => '401');
        throw GenericResponse.fromJson(json);
      }

      if (response.statusCode != HttpStatus.ok) {
        setFirebaseLog(
            requestType: RequestType.post,
            apiUrl: url,
            statusCode: response.statusCode.toString(),
            response: json.decode(response.body));
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
      throw json.decode('{"errorMessage":"Network Lost"}');
      rethrow;
    } on GenericResponse catch (e) {
      // Handle GenericCreateResponse
      log('--on GenericCreateResponse POST---${e.toString()}---');
      setFirebaseLog(
          requestType: RequestType.post,
          apiUrl: url,
          statusCode: statusCode?.toString() ?? unhandled,
          response: e.toString());
      rethrow;
    } catch (e) {
      // Handle other exceptions
      // Problem: try to parse the e in order to extract information properly
      var decodedResponse = tryJsonDecode(e);
      log("Exception thrown: $e");
      setFirebaseLog(
          requestType: RequestType.post,
          apiUrl: url,
          statusCode: statusCode?.toString() ?? unhandled,
          response: decodedResponse.toString());
      rethrow;
    }
  }

  dynamic tryJsonDecode(dynamic input) {
    try {
      // Try decoding if the input is already a JSON string
      if (input is String) {
        return jsonDecode(input);
      }

      // Try converting the object to JSON (if it has a toJson method)
      if (input != null && input is Map || input is List) {
        return input; // Input is already JSON serializable
      }

      // If the input has a toJson method, serialize it to JSON
      if (input != null && input.toJson != null) {
        return jsonEncode(input.toJson());
      }

      // Otherwise, return the string representation
      return input.toString();
    } catch (e) {
      // If any error occurs, return the string representation of the input
      return 'Could not decode: ${input.toString()}';
    }
  }

  Future<dynamic> patchRequest({
    required String url,
    bool? isAuthenticated,
  }) async {
    int? statusCode;
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
      statusCode = response.statusCode;
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
      var decodedResponse = tryJsonDecode(e);
      log("Exception thrown: $e");
      setFirebaseLog(
          requestType: RequestType.patch,
          apiUrl: url,
          statusCode: statusCode?.toString() ?? unhandled,
          response: decodedResponse.toString());
      rethrow;
    }
  }

  Future<dynamic> deleteRequest({
    required String url,
    bool? isAuthenticated,
  }) async {
    int? statusCode;
    try {
      log('url--delete---$url');
      var headers = await getHeaders(
        isAuthenticated: isAuthenticated ?? true,
      );
      var response = await http.delete(
        Uri.parse(url),
        headers: headers,
      );
      statusCode = response.statusCode;
      log("HTTP Status Code: $statusCode");
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
      var decodedResponse = tryJsonDecode(e);
      log("Exception thrown: $e");
      setFirebaseLog(
          requestType: RequestType.delete,
          apiUrl: url,
          statusCode: statusCode?.toString() ?? unhandled,
          response: decodedResponse.toString());
    }
  }

  void setFirebaseLog({
    required RequestType requestType,
    required String apiUrl,
    required String statusCode,
    required String response,
  }) {
    UtilsCommon().logCustomEvent(
      msg: 'RequestType $requestType, '
          '\'API URL: $apiUrl, '
          '\'Response Code: $statusCode, '
          '\'Response: $response',
      customKey: 'API_ISSUE'
    );
  }
}

Future<void> handleQaEnv(bool isQaEnv, String url, String body) async {
  if (isQaEnv) {
    log("QA Environment");
    log("URL: $url");
    log("Body: $body");

    // Copy URL and body to clipboard
    await Clipboard.setData(ClipboardData(text: url));
    await Clipboard.setData(ClipboardData(text: body));

    // Using Completer to pause execution
    Completer<void> completer = Completer<void>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Show your dialog or UI that should pause execution here
      await showDialog<void>(
        context: navigatorKey.currentContext!,
        builder: (context) {
          return AlertDialog(
            title: const Text('QA Environment'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('URL: $url'),
                  const SizedBox(height: 8),
                  const Text('Body:'),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    height: 200,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(body),
                    ), // Limit the height for the scrollable area
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: url));
                        },
                        child: const Text('Copy URL'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: body));
                        },
                        child: const Text('Copy Body'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  completer.complete(); // Continue execution
                },
                child: const Text('Dismiss'),
              ),
            ],
          );
        },
      );
    });

    await completer.future; // This will pause the code until dismiss is clicked
  }
}
