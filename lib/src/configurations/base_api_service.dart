import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

class BaseApiService {
  Future<dynamic> getRequest(
      {required String url, bool? isAuthenticated}) async {
    try {
      log('url--getData---$url');
      var headers = await _getHeaders(isAuthenticated: isAuthenticated);
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
