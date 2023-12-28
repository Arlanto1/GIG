import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/dashboard/notifications/notification_details/models/notification_details_model.dart';
import 'package:db_atom/src/features/dashboard/notifications/notification_details/models/notifications_response_model.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getNotificationList = '$baseUrl/getNotificationList?';

  static final String _getNotificationById = '$baseUrl/getNotificationById';
  static final String _deleteById = '$baseUrl/deleteNotification';
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

  Future<NotificationDetailsModel> getById(int id) async {
    final String url = '${Apis._getNotificationById}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return NotificationDetailsModel.fromJson(response);
  }

  Future<GenericResponse> deleteById(int id) async {
    final String url = '${Apis._deleteById}/$id';
    final response = await BaseApiService().deleteRequest(
      url: url,
    );
    return GenericResponse.fromJson(response);
  }
}
