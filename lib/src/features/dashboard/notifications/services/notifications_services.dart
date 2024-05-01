import 'package:db_atom/index.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getNotificationList = '$baseUrl/getNotificationList?';

  static final String _getNotificationById = '$baseUrl/getNotificationById';
  static final String _readRecord = '$baseUrl/markNotificationAsRead';
  static final String _deleteById = '$baseUrl/deleteNotification';
  static final String _deleteAll = '$baseUrl/deleteAllNotifications';
  static final String _getNotificationCount = '$baseUrl/getNotificationCount';
}

class NotificationServices {
  Future<NotificationsResponseModel> getNotificationList({
    required String startPosition,
    required String maximumRecords,
  }) async {
    String url =
        '${Apis._getNotificationList}startPos=$startPosition&maxResults=$maximumRecords';
    var response = await BaseApiService().getRequest(
      isAuthenticated: true,
      url: url,
    );
    return NotificationsResponseModel.fromJson(response);
  }

  Future<NotificationModel> getById(int id) async {
    final String url = '${Apis._getNotificationById}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return NotificationModel.fromJson(response);
  }

  Future<int> getNotificationCount() async {
    final String url = Apis._getNotificationCount;
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return response['count'];
  }

  Future<GenericResponse> readRecord(int id) async {
    final String url = '${Apis._readRecord}/$id';
    final response = await BaseApiService().deleteRequest(
      url: url,
    );
    return GenericResponse.fromJson(response);
  }

  Future<GenericResponse> deleteById(int id) async {
    final String url = '${Apis._deleteById}/$id';
    final response = await BaseApiService().deleteRequest(
      url: url,
    );
    return GenericResponse.fromJson(response);
  }

  Future<GenericResponse> deleteAll() async {
    final String url = Apis._deleteAll;
    final response = await BaseApiService().deleteRequest(
      url: url,
    );
    return GenericResponse.fromJson(response);
  }
}

class NotificationCount {
  final int? count;

  NotificationCount({
    this.count,
  });

  NotificationCount.fromJson(Map<String, dynamic> json)
      : count = json['count'] as int?;

  Map<String, dynamic> toJson() => {'count': count};
}
