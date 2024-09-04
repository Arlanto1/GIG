import 'dart:developer';

import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/create_found_submit_model.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:flutter/material.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _addFound = '$baseUrl/addFound';
}

class CreateFoundServices {
  final endpoint = Environment().config.apiHost;

  /// Create Services
  Future<SubmitCreateFoundModel> createFoundArticle({
    required CreateFoundRequestBody body,
    required bool isSubmit,
    required String username,
    int? eventId,
  }) async {
    var userId = await SharedPrefs.getUserId();
    String url = "${Apis._addFound}?userEmail=$userId&isSubmit=$isSubmit";
    log('----eventId---$eventId--');
    if (eventId != null) {
      url = '$url&eventProtectionId=$eventId';
    }
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return SubmitCreateFoundModel.fromJson(response);
  }

  Future<SubmitCreateFoundModel> createFoundArticleHandle(
      Map<String, dynamic> requestBody,
      bool isSubmit,
      String username,
      BuildContext context) async {
    var userId = await SharedPrefs.getUserId();
    final String url = "${Apis._addFound}?userEmail=$userId&isSubmit=$isSubmit";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: requestBody,
    );
    return SubmitCreateFoundModel.fromJson(response);
  }
}
