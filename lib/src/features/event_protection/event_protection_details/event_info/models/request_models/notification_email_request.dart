import '../event_info_response.dart';

class NotificationEmailRequest {
  final EventInfoResponse? eventProtectionInfo;

  NotificationEmailRequest({
    this.eventProtectionInfo,
  });

  NotificationEmailRequest.fromJson(Map<String, dynamic> json)
      : eventProtectionInfo =
  (json['eventNotification'] as Map<String, dynamic>?) != null
      ? EventInfoResponse.fromJson(
      json['eventNotification'] as Map<String, dynamic>)
      : null;

  Map<String, dynamic> toJson() =>
      {'eventNotification': eventProtectionInfo?.toJson()};
}
