import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:db_atom/src/appservices/app_exception.dart';
import 'package:db_atom/src/common_widgets/spinnerdialog.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:db_atom/src/utils/network_handler.dart' as network_handler;
import 'package:db_atom/src/utils/alert_handler.dart' as alert_handler;

class AppServices {
final _baseUrl = Environment().config.apiHost;
  Future<dynamic> get(
      String url, String json, BuildContext context, String requestType) async {
    final bool isActive = await network_handler.networkChecking(context);

    if (isActive) {
      // if (requestType != Constants.SPLASH_USER_DEFAULT_DETAILS) {
      //   showLoadingDialog(context);
      // }
      dynamic responseJson;
      final SharedPreferences preferencesSystem =
          await SharedPreferences.getInstance();
      try {
        final String tokentype =
            preferencesSystem.getString(Constants.abort) ?? '';   //TOKEN_TYPE) ?? '';
        final String authorisationKey =
            preferencesSystem.getString(Constants.abort) ?? ''; //AUTHORIZATION_CODE) ?? '';
        final String autherToken = tokentype + '<' + authorisationKey + '>';
        final Map<String, String> headers = {
          'Content-type': 'application/json',
          'Authorization': autherToken,
          'Accept': 'application/json',

        };
        final String apiURL = _baseUrl + url;
        print('GET CALL===================$apiURL');
        print('headers===================$headers');
        final http.Response response = await http
            .get(Uri.parse(apiURL), headers: headers)
            .timeout(const Duration(seconds: 30));
        responseJson = _returnResponse(response, requestType, context);

        if (response.statusCode == 200) {
          print(responseJson);
          // if (requestType != Constants.SPLASH_USER_DEFAULT_DETAILS) {
          //   dismissLoadingDialog(context);
          // }

          return responseJson;
        } else {
          print('GET CALL===error response================$responseJson');
          final String message =
              responseJson['message'] as String ?? 'Unkown Server error.';
          showAlertMessage(message, context);
          // if (requestType != Constants.SPLASH_USER_DEFAULT_DETAILS) {
          //   dismissLoadingDialog(context);
          // }
          return null;
        }
      } on TimeoutException {
       // showAlertMessage('Unable to reach server.', context);
       showAlertMessage('No Network connection', context);
        return null;
      } on SocketException {
        showAlertMessage('No Network connection', context);
        return null;
      }
    } else {
      // showAlertMessage("No Network connection", context);
      return null;
    }
  }

  void showAlertMessage(String message, BuildContext context) {
    dismissLoadingDialog(context);
    alert_handler.alertDisplay(
        context, message != null ? message.toString() : 'Something went wrong');
    // if (message == "Token Expired") {
    //    Navigator.of(context).pushReplacementNamed(Constants.ROUTE_LANDING);
    // }
  }

  Future<dynamic> post(
      String url, Map json, BuildContext context, String requestType) async {
    final bool isActive = await network_handler.networkChecking(context);
    if (isActive) {
      showLoadingDialog(context);
      Map responseJson;
      final SharedPreferences preferencesSystem =
          await SharedPreferences.getInstance();
      try {
       final String tokentype =
            preferencesSystem.getString(Constants.abort) ?? '';   //TOKEN_TYPE) ?? '';
        final String authorisationKey =
            preferencesSystem.getString(Constants.abort) ?? ''; //AUTHORIZATION_CODE) ?? '';
        final String autherToken = tokentype + '<' + authorisationKey + '>';
        print('json==post params======$json');
        final String jsonBody = jsonEncode(json);
        final Map<String, String> headers = {
          'Content-type': 'application/json',
          'Authorization': autherToken
        }; //
        final String apiURL = _baseUrl + url;
        print('POST CALL===================$apiURL');
        final http.Response response = await http
            .post(Uri.parse(apiURL),
                headers: headers, body: jsonBody, encoding: utf8)
            .timeout(const Duration(seconds: 30));

        // if ((requestType == Services.SIGNUP_URL) &&
        //     response.statusCode == 200) {
        //   dismissLoadingDialog(context);
        //   return response.body.toString();
        // }

        responseJson = _returnResponse(response, requestType, context);

        print('POST CALL======responseJson=============$responseJson');

        if (response.statusCode == 200) {
          dismissLoadingDialog(context);
          return responseJson;
        } else {
          // if (requestType == Services.LOGIN_URL) {
          //   dismissLoadingDialog(context);
          //   return responseJson;
          // } else {
          //   print('POST FAIL');
          //   String message = 'Unable to reach  server';
          //   if (responseJson.containsKey('message')) {
          //     message =
          //         responseJson['message'] as String ?? 'Unknown Server error.';
          //   }

          //   showAlertMessage(message, context);
          //   dismissLoadingDialog(context);
          //   return null;
          // }
        }
      } on TimeoutException {
        //showAlertMessage('Unable to reach server.', context);
        showAlertMessage('No Network connection', context);
        return null;
      } on SocketException {
        showAlertMessage('No Internet connection', context);
        return null;
      }
    } else {
      // showAlertMessage("No Internet connection", context);
      return null;
    }
  }

  _asyncFileUpload(String text, File file) async{
   //create multipart request for POST or PATCH method
   var request = http.MultipartRequest("POST", Uri.parse("<url>"));
   //add text fields
   request.fields["text_field"] = text;
   //create multipart using filepath, string or bytes
   var pic = await http.MultipartFile.fromPath("file_field", file.path);
   //add multipart to request
   request.files.add(pic);
   var response = await request.send();

   //Get the response from the server
   var responseData = await response.stream.toBytes();
   var responseString = String.fromCharCodes(responseData);
   print(responseString);
}

  dynamic _returnResponse(
      http.Response response, String requestType, BuildContext context) {
    print('Status code------Http--------${response.statusCode}');

    // if (requestType != Constants.SPLASH_USER_DEFAULT_DETAILS) {
    //   dismissLoadingDialog(context);
    // }

    switch (response.statusCode) {
      case 200:
        final Map<String, dynamic> responseJson =
            json.decode(response.body.toString());
        return responseJson;
        break;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        final Map<String, dynamic> responseJson =
            json.decode(response.body.toString());
        return responseJson;

      case 403:
        showAlertMessage('Unauthorized Access', context);
        break;

      case 500:
      // if(requestType == Constants.SPLASH_USER_DEFAULT_DETAILS)
      // {
      //      final Map<String, dynamic> responseJson =
      //       json.decode(response.body.toString());
      //   return responseJson;
      // }
      // else
      // {
      //    showAlertMessage('$requestType API internal Error', context);
      // }
        
        break;

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

// class ApiResponse<T> {
//   Status status;
//   T data;
//   String message;

//   ApiResponse.loading(this.message) : status = Status.LOADING;
//   ApiResponse.completed(this.data) : status = Status.COMPLETED;
//   ApiResponse.error(this.message) : status = Status.ERROR;

//   @override
//   String toString() {
//     return 'Status : $status \n Message : $message \n Data : $data';
//   }
// }

// enum Status { LOADING, COMPLETED, ERROR }
