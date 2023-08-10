import 'dart:convert';
import 'dart:io';
import 'package:db_atom/src/appservices/service_model.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';



class HttpServiceHandler {

  //serviece call for getmethod
  Future<ServiceModel> serviceGetMethodwthoutParams(String url) async {
    
    try {
      var preferencesSystem = await SharedPreferences.getInstance();
      
      final _baseUrl = Environment().config.apiHost;

      String mainUrl = _baseUrl + url;
      print("URL====================: $mainUrl");
      HttpClient httpClient = new HttpClient();
      httpClient.connectionTimeout = const Duration(seconds: 15);
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(mainUrl));
      request.headers.set('content-type', 'application/json');
      request.headers.set('accept', 'application/json');
     final String tokentype =
            preferencesSystem.getString(Constants.abort) ?? '';   //TOKEN_TYPE) ?? '';
        final String authorisationKey =
            preferencesSystem.getString(Constants.abort) ?? ''; //AUTHORIZATION_CODE) ?? '';
      String autherToken = tokentype + "<" + authorisationKey + ">";
      request.headers.set('Authorization', autherToken);
      HttpClientResponse response = await request.close();
      Map<String, dynamic> mainReponse = {
        'status': true,
        'value': response,
        'error': null
      };
      ServiceModel model = ServiceModel.fromJson(mainReponse);
      return model;
    } on SocketException catch (e) {
      Map<String, dynamic> mainReponse = {
        'status': false,
        'value': null,
        'error': e
      };
      ServiceModel model = ServiceModel.fromJson(mainReponse);
      return model;
    }
  }

  Future<ServiceModel> servicePostMethodWithAuthentication(
      Object props, String url) async {
    final SharedPreferences preferencesSystem = await SharedPreferences.getInstance();
    try {
      // final String mainUrl = buildVariant.BASE_URL + url;
      // print('URL: $mainUrl');
       final _baseUrl = Environment().config.apiHost;

      String mainUrl = _baseUrl + url;
      final HttpClient httpClient = HttpClient();
      httpClient.connectionTimeout = const Duration(seconds: 60);
      final HttpClientRequest request = await httpClient.postUrl(Uri.parse(mainUrl));
      request.headers.set('content-type', 'application/json');
      request.headers.set('Accept', 'application/json');
      final String tokentype =
            preferencesSystem.getString(Constants.abort) ?? '';   //TOKEN_TYPE) ?? '';
        final String authorisationKey =
            preferencesSystem.getString(Constants.abort) ?? ''; 
      print('AuthKey: $authorisationKey');
      final String autherToken = tokentype + '<' + authorisationKey + '>';
      request.headers.set('Authorization', autherToken);
      request.add(utf8.encode(json.encode(props)));
      final HttpClientResponse response = await request.close();
      final Map<String, dynamic> mainReponse = {
        'status': true,
        'value': response,
        'error': null
      };
      final ServiceModel model = ServiceModel.fromJson(mainReponse);
      return model;
    } on SocketException catch (e) {
      final Map<String, dynamic> mainReponse = {
        'status': false,
        'value': null,
        'error': e
      };
      final ServiceModel model = ServiceModel.fromJson(mainReponse);
      return model;
    }
  }

  Future<ServiceModel> serviceDeletetMethodWithAuthentication(
      String url, String id) async {
    final SharedPreferences preferencesSystem = await SharedPreferences.getInstance();
    try {
      // final String mainUrl = buildVariant.BASE_URL + url + id;
      final _baseUrl = Environment().config.apiHost;

      String mainUrl = _baseUrl + url;
      final HttpClient httpClient = HttpClient();
      httpClient.connectionTimeout = const Duration(seconds: 15);
      final HttpClientRequest request =
          await httpClient.deleteUrl(Uri.parse(mainUrl));
      request.headers.set('content-type', 'application/json');
      request.headers.set('Accept', 'application/json');

      final String tokentype =
            preferencesSystem.getString(Constants.abort) ?? '';   //TOKEN_TYPE) ?? '';
        final String authorisationKey =
            preferencesSystem.getString(Constants.abort) ?? ''; 
      final String autherToken = tokentype + '<' + authorisationKey + '>';
      request.headers.set('Authorization', autherToken);
      //request.add(utf8.encode(json.encode(props)));
      final HttpClientResponse response = await request.close();
      final Map<String, dynamic> mainReponse = {
        'status': true,
        'value': response,
        'error': null
      };
      final ServiceModel model = ServiceModel.fromJson(mainReponse);
      return model;
    } on SocketException catch (e) {
      final Map<String, dynamic> mainReponse = {
        'status': false,
        'value': null,
        'error': e
      };
      final ServiceModel model = ServiceModel.fromJson(mainReponse);
      return model;
    }
  }

  Future<ServiceModel> serviceGetMethodWithHeadersWithAuthorization(
      String url, String passingUrl) async {
    final SharedPreferences preferencesSystem = await SharedPreferences.getInstance();
    try {
      //final String mainUrl = buildVariant.BASE_URL + url + passingUrl;
      final _baseUrl = Environment().config.apiHost;

      String mainUrl = _baseUrl + url;
      print('mainUrl: $mainUrl');
      final HttpClient httpClient = HttpClient();
      httpClient.connectionTimeout = const Duration(seconds: 15);
      final HttpClientRequest request = await httpClient.getUrl(Uri.parse(mainUrl));
      print('Service Hanlder-------mainUrl--------------$mainUrl');
      request.headers.set('content-type', 'application/json');
      request.headers.set('Accept', 'application/json');
      final String tokentype =
            preferencesSystem.getString(Constants.abort) ?? '';   //TOKEN_TYPE) ?? '';
        final String authorisationKey =
            preferencesSystem.getString(Constants.abort) ?? ''; 
      final String autherToken = tokentype + '<' + authorisationKey + '>';
      request.headers.set('Authorization', autherToken);
      //request.add(utf8.encode(json.encode(props)));
      final HttpClientResponse response = await request.close();
      final Map<String, dynamic> mainReponse = {
        'status': true,
        'value': response,
        'error': null
      };
      final ServiceModel model = ServiceModel.fromJson(mainReponse);
     print('Service Hanlder-------mainReponse--------------$mainReponse');

      return model;
    } on SocketException catch (e) {
      final Map<String, dynamic> mainReponse = {
        'status': false,
        'value': null,
        'error': e
      };
      final ServiceModel model = ServiceModel.fromJson(mainReponse);
      return model;
    }
  }   
}
