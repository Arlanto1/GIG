import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../routing/router.dart';

class BaseApiService {
  Future<dynamic> getRequest(
      {required String url, bool? isAuthenticated}) async {
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
      if (response.statusCode == HttpStatus.ok) {
        var responseBody = json.decode(response.body);
        // log('responseBody----$responseBody');
        return responseBody;
      } else {
        log("$url GET response is NOT OK:${response.statusCode}");
        if (response.statusCode.toString() == "401") {
          log("will log out now${response.statusCode}");
          // TODO: Need to handle the logout case
          // logout();
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

      var _response = json.decode(response.body);

      if (response.statusCode == HttpStatus.ok) {
        return _response;
      } else {
        log("$url POST response is NOT OK:${response.statusCode}");
        if (response.statusCode == 401) {
          log(" will logout   int");
          // logout(context);
        }
        if (response.statusCode.toString() == "401") {
          log(" will logout");
          // logout(context);
        }

        // {"success":false,"message":"Incorrect Otp"}
        var _response = json.decode(response.body);
        log("_response - ${_response['error']}");
        if (_response["error"] != null &&
            _response["error"].runtimeType == String) {
          throw json.decode(response.body);
        }
      }
    } on SocketException {
      // TODO: Handle Error
    } catch (e) {
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

  Future<Map<String, String>> _getHeaders({bool? isAuthenticated}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };

    if (isAuthenticated != null && isAuthenticated) {
      //TODO: Need to implement it
      // String? token = await Constants.getPrefrenceValue(Constants.token);
      // log("token is:$token");
      // if (token != null) {
      //   headers.addAll({"Authorization": token});
      //   return headers;
      // }
    }

    return headers;
  }
}
