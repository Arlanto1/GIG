import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/ticketing_system/models/projects_model.dart';
import 'package:db_atom/src/features/ticketing_system/models/requestModel/ticketing_system_request_model.dart';
import 'package:db_atom/src/features/ticketing_system/models/ticketing_system_list_model.dart';
import 'package:db_atom/src/features/ticketing_system/models/ticketing_system_model.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getTicketingSystemList =
      '$baseUrl/getRedmineIssuesList?';

  static final String _getTicketingSystemById = '$baseUrl/getIssueById';

  static final String _createTicketingSystem = '$baseUrl/createIssue';

  static final String _getAssigneeList = '$baseUrl/getAssigneeList';

  static final String _getTrackers = '$baseUrl/getTrackerList';
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
    return TicketingSystemModel.fromJson(response);
  }

  /// Create Services
  Future<GenericResponse> createTicketingSystem({
    required TicketingSystemRequest body,
  }) async {
    // var userId = await SharedPrefs.getUserId();
    final String url = Apis._createTicketingSystem;
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }

  Future<BaseUser> getAssigneeList() async {
    String url = Apis._getAssigneeList;
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return BaseUser.fromJson(response);
  }

  Future<Projects> getTrackers() async {
    String url = Apis._getTrackers;
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return Projects.fromJson(response);
  }

}
