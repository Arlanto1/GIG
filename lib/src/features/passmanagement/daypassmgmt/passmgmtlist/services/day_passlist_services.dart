
import 'package:db_atom/src/models/base_filter_model.dart';
import 'package:flutter/material.dart';

import '../../../../../configurations/base_api_service.dart';
import '../../../../../configurations/environment_config.dart';
import '../models/day_passlist_model.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getList = '$baseUrl/getPassMgmtList?';
  static final String _getById = '$baseUrl/getPassMgmtById';
}

class DayPassListServices {
  Future<DayPassListResponse> getListWithFilters({
    required String startPosition,
    required String maximumRecords,
    required String passType,
    required BaseFilterModel filters,
  }) async {
    String url =
        '${Apis._getList}startPos=$startPosition&maxResults=$maximumRecords&passType=$passType';
    var response = await BaseApiService().postRequest(
      requestedData: filters.toJson(),
      isAuthenticated: true,
      url: url,
    );
    return DayPassListResponse.fromJson(response);
  }

  Future<PassManagementModel> getById(int id, BuildContext context) async {
    final String url = '${Apis._getById}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );

    return PassManagementModel.fromJson(response);
  }
}
