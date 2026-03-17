import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/ticketing_system/models/assignee_model.dart';
import 'package:db_atom/src/features/ticketing_system/models/projects_model.dart';
import 'package:db_atom/src/features/ticketing_system/models/requestModel/ticketing_system_request_model.dart';
import 'package:db_atom/src/features/ticketing_system/models/ticketing_system_list_model.dart';
import 'package:db_atom/src/features/ticketing_system/models/ticketing_system_model.dart';
import 'package:db_atom/src/features/ticketing_system/models/trackers_model.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getTicketingSystemList =
      '$baseUrl/getTicketingSystemList?';

  static final String _getTicketingSystemById = '$baseUrl/getTicketingSystemById';

  static final String _createTicketingSystem = '$baseUrl/createTicketingSystemNew';
  static final String _getTrackers = '$baseUrl/getTrackerList';
  static final String _getProjects = '$baseUrl/getProjectList';
  static final String _getPriority = '$baseUrl/getPriorityList';
  static final String _getAssignee = '$baseUrl/getAssigneeList';
}

class TicketingSystemServices {
  Future<TicketingSystemListResponse> getTicketingSystemList({
    required String startPosition,
    required String maximumRecords,
    required BaseFilterModel filters,
  }) async {
    String url =
        '${Apis._getTicketingSystemList}&startPos=$startPosition&maxResults=$maximumRecords';
    var response = await BaseApiService().postRequest(
      requestedData: filters.toJson(),
      isAuthenticated: true,
      url: url,
    );
    return TicketingSystemListResponse.fromJson(response);
  }

  Future<TicketingSystemModel> getById(int id) async {
    final String url = '${Apis._getTicketingSystemById}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );

    log('url $url');
    return TicketingSystemModel.fromJson(response);
  }

  /// Create Services
  Future<GenericResponse> createTicketingSystem({
    required TicketingSystemRequest body,
    required bool isSubmit,
  }) async {
    // var userId = await SharedPrefs.getUserId();
    final String url = "${Apis._createTicketingSystem}?isSubmit=$isSubmit";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }


  Future<Projects> getProjects() async {
    String url = Apis._getProjects;
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return Projects.fromJson(response);
  }

  Future<Trackers> getTrackers() async {
    String url = Apis._getTrackers;
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return Trackers.fromJson(response);
  }


  Future<Assignee> getAssignee() async {
    String url = Apis._getAssignee;
    final response = await BaseApiService().getRequest(
      url: url,
    );

    return Assignee.fromJson(response);
  }
}
