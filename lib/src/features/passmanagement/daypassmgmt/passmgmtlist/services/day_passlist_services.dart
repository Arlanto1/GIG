
import 'package:flutter/material.dart';

import '../../../../../configurations/base_api_service.dart';
import '../../../../../configurations/environment_config.dart';
import '../../../../../utils/shared_preferences.dart';
import '../models/day_passlist_model.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getList = '$baseUrl/getPassMgmtList?';
  static final String _getById = '$baseUrl/getPassMgmtById';
}

class DayPassListServices {
  Future<DayPassListResponse> getList({
    required String startPosition,
    required String maximumRecords,
    required String userId,
    required String passType,
  }) async {
    String url =
        '${Apis._getList}startPos=$startPosition&maxResults=$maximumRecords&userId=${await SharedPrefs.getUserId()}&passType=$passType';
    var response = await BaseApiService().getRequest(
      isAuthenticated: true,
      url: url,
    );

    return DayPassListResponse.fromJson(response);
  }

  Future<DayPassListElement> getById(int id, BuildContext context) async {
    final String url = '${Apis._getById}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );

    return DayPassListElement.fromJson(response);
  }
}
