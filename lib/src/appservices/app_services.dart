import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:db_atom/src/appservices/app_exception.dart';
import 'package:db_atom/src/common_widgets/spinnerdialog.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/routing/router.dart';
import 'package:db_atom/src/utils/customalert.dart';
import 'package:db_atom/src/utils/generate_token/generate_token_service.dart';
import 'package:db_atom/src/utils/refresh_token/refresh_token_service.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:db_atom/src/utils/network_handler.dart' as network_handler;

class AppServices {
  int counterValue = 0;
  final _baseUrl = Environment().config.apiHost;
  Future<dynamic> get(String url, BuildContext context) async {
    final bool isActive = await network_handler.networkChecking(context);

    if (isActive) {
      dynamic responseJson;

      try {
        String autherToken = await SharedPrefs.getToken();
        final Map<String, String> headers;
        if (autherToken.isNotEmpty) {
          headers = {
            'Content-type': 'application/json',
            'Authorization': autherToken,
          };
        } else {
          headers = {
            'Content-type': 'application/json',
          };
        }
        final String apiURL = _baseUrl + url;
        print('GET CALL===================$apiURL');
        print('headers===================$headers');
        final http.Response response = await http
            .get(Uri.parse(apiURL), headers: headers)
            .timeout(const Duration(seconds: 30));
        responseJson = _returnResponse(response, context);

        if (response.statusCode == 200) {
          print(responseJson);

          return responseJson;
        } else if (response.statusCode == 401) {
          
          int refreshToken = await RefreshTokenService.getRefreshToken();
          if (refreshToken == 200) {
            counterValue = counterValue + 1;
            if (counterValue > 2) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginScreenRoute, (route) => false);
              return;
            }
            get(url, context);
            return refreshToken;
          } else if (refreshToken == 449) {
            int generateToken = await GenerateTokenService.getGenerateToken();
            if (generateToken == 200) {
              counterValue = counterValue + 1;
              if (counterValue > 2) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    loginScreenRoute, (route) => false);
                return;
              }
              get(url, context);
              return generateToken;
            } else {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginScreenRoute, (route) => false);
              return generateToken;
            }
          }
        } else {
          print('GET CALL===error response================$responseJson');
          String message =
              responseJson['message'] as String ?? 'Unkown Server error.';
          showAlertMessage(message, context);
          // if (requestType != Constants.SPLASH_USER_DEFAULT_DETAILS) {
          //   dismissLoadingDialog(context);
          // }
          return null;
        }
      } on TimeoutException {
        // showAlertMessage('Unable to reach server.', context);
        showAlertMessage('Unable to reach server.', context);
        return null;
      } on SocketException {
        showAlertMessage('No Network connection', context);
        return null;
      }
    } else {
      showAlertMessage("No Network connection", context);
      return null;
    }
  }

  

  void showAlertMessage(String message, BuildContext context) {
   
    var dialog = CustomAlertDialog(
      title: Constants.appname,
      message: message,
      onPostivePressed: () {
        //ValidatorlogoutAction(context);
        Navigator.of(context).pop();
      },
      positiveBtnText: Constants.ok,
      //negativeBtnText: Constants.no
    );
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }

  Future<dynamic> post(String url, BuildContext context, Object? body) async {
    final bool isActive = await network_handler.networkChecking(context);
    if (isActive) {
      Map responseJson;

      try {
        String autherToken = await SharedPrefs.getToken();
        final Map<String, String> headers;
        if (autherToken.isNotEmpty) {
          headers = {
            'Content-type': 'application/json',
            'Authorization': autherToken,
          };
        } else {
          headers = {
            'Content-type': 'application/json',
          };
        }
        final String apiURL = _baseUrl + url;
        print('POST CALL===================$apiURL');
        final http.Response response = await http
            .post(Uri.parse(apiURL),
                headers: headers, body: body, encoding: utf8)
            .timeout(const Duration(seconds: 30));

        responseJson = _returnResponse(response, context);

        print('POST CALL======responseJson=============$responseJson');

        if (response.statusCode == 200) {
          return responseJson;
        } else if (response.statusCode == 401) {
          
          int refreshToken = await RefreshTokenService.getRefreshToken();
          if (refreshToken == 200) {
            counterValue = counterValue + 1;
            if (counterValue > 2) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginScreenRoute, (route) => false);
              return;
            }
            post(url, context,body);
            return refreshToken;
          } else if (refreshToken == 449) {
            int generateToken = await GenerateTokenService.getGenerateToken();
            if (generateToken == 200) {
              counterValue = counterValue + 1;
              if (counterValue > 2) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    loginScreenRoute, (route) => false);
                return;
              }
             post(url, context,body);
              return generateToken;
            } else {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginScreenRoute, (route) => false);
              return generateToken;
            }
          }
        } else {
          print('POST CALL===error response================$responseJson');
          String message =
              responseJson['message'] as String ?? 'Unkown Server error.';
          showAlertMessage(message, context);

          return null;
        }
      } on TimeoutException {
        //showAlertMessage('Unable to reach server.', context);
        showAlertMessage('Unable to reach server.', context);
        return null;
      } on SocketException {
        showAlertMessage('No Internet connection', context);
        return null;
      }
    } else {
       showAlertMessage("No Internet connection", context);
      return null;
    }
  }

  _asyncFileUpload(String text, File file) async {
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

  dynamic _returnResponse(http.Response response, BuildContext context) {
    print('Status code------Http--------${response.statusCode}');

    // if (requestType != Constants.SPLASH_USER_DEFAULT_DETAILS) {
    //   dismissLoadingDialog(context);
    // }

    switch (response.statusCode) {
      case 200:
        final Map<String, dynamic> responseJson =
            json.decode(response.body.toString());
        return responseJson;
      case 400:
        showAlertMessage('Badrequest Access', context);
        return response.statusCode;

      case 401:
         return response.statusCode;

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
        showAlertMessage(' API internal Error', context);
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
