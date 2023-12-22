import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/dashboard/notifications/notification_details/models/notification_details_model.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getNotificationList = '$baseUrl/getNotificationList/';

  static final String _getNotificationById = '$baseUrl/getNotificationById';

  static final String _createGeneralInformation = '$baseUrl/createCDGI?';

  static final String _getContactDetailsById = '$baseUrl/getCntInfoById';
  static final String _deleteContactDetailsById = '$baseUrl/deleteContactInfo';

  static final String _createContactRecord = '$baseUrl/createContactInfo?';

  static final String _deleteContacts = '$baseUrl/deleteContactInfo';
}

class NotificationServices {
  Future<List<PieChartData>> getNotificationList() async {
    String url = Apis._getNotificationList;
    Map<String, dynamic> response = await BaseApiService().getRequest(
      isAuthenticated: true,
      url: url,
    );

    // Convert response to List<PieChartData>
    List<PieChartData> pieChartDataList = [];
    response.forEach((key, value) {
      double count = (value is int) ? value.toDouble() : 0.0;
      pieChartDataList.add(
        PieChartData(key, count, Utils().getRandomColor()),
      );
    });

    return pieChartDataList;
  }
  Future<NotificationDetailsModel> getById(int id) async {
    final String url = '${Apis._getNotificationById}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return NotificationDetailsModel.fromJson(response);
  }
}
