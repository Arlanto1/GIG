import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/ticketing_system/models/assignee_model.dart';
import 'package:db_atom/src/features/ticketing_system/models/priorities_model.dart';
import 'package:db_atom/src/features/ticketing_system/models/projects_model.dart';
import 'package:db_atom/src/features/ticketing_system/models/requestModel/ticketing_system_request_model.dart';
import 'package:db_atom/src/features/ticketing_system/models/ticketing_system_model.dart';
import 'package:db_atom/src/features/ticketing_system/models/trackers_model.dart';

import '../models/ticketing_new_list_model.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getTicketingSystemList =
      '$baseUrl/getRedmineIssuesList?projectKey=atom-v2';

  static final String _getTicketingSystemById = '$baseUrl/getIssueById';

  static final String _createTicketingSystem = '$baseUrl/createIssue';
  static final String _getTrackers = '$baseUrl/getTrackerList';
  static final String _getProjects = '$baseUrl/getProjectList';
  static final String _getAssignee = '$baseUrl/getAssigneeList';
  static final String _getPriorityList = '$baseUrl/getPriorityList';

}

class TicketingSystemServices {
  Future<TicketingNewListModelResponse> getTicketingSystemList({
    required String startPosition,
    required String maximumRecords,
    required BaseFilterModel filters,
  }) async {
    String url =
        '${Apis
        ._getTicketingSystemList}&startPos=$startPosition&maxResults=$maximumRecords';
    var response = await BaseApiService().postRequest(
      requestedData: filters.toJson(),
      isAuthenticated: true,
      url: url,
    );
    return TicketingNewListModelResponse.fromJson(response);
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


  Future<Assignee> getAssignee(int projectId, String projectName) async {
    String url = '${Apis._getAssignee}?projectId=$projectId&projectName=$projectName';
    final response = await BaseApiService().getRequest(
      url: url,
    );

    return Assignee.fromJson(response);
  }

  Future<Priorities> getPriorityList() async {
    String url = Apis._getPriorityList;
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return Priorities.fromJson(response);
  }


  // Future<List<Organisation>> getStatuses({
  //   required String? id,
  //   BuildContext? context,
  // }) async {
  //   String url = '${Apis._getStatus}/ ';
  //   if(id !=null){
  //      url = '${Apis._getStatus}/$id';
  //   }
  //   final response = await BaseApiService().getRequest(
  //     url: url,
  //   );
  //
  //   if (response == null) {
  //     return [];
  //   }
  //   return List<Organisation>.from(
  //       response.map((x) => Organisation.fromJson(x)));
  // }
}