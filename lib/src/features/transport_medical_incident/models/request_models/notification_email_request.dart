import 'package:db_atom/src/features/transport_medical_incident/models/transport_email_notification.dart';


class TransportNotificationEmailRequest {
  final TransportEmailNotificationModel? transportEmailNotificationInfo;

  TransportNotificationEmailRequest({
    this.transportEmailNotificationInfo,
  });

  TransportNotificationEmailRequest.fromJson(Map<String, dynamic> json)
      : transportEmailNotificationInfo =
  (json['emergencyNotification'] as Map<String, dynamic>?) != null
      ? TransportEmailNotificationModel.fromJson(
      json['emergencyNotification'] as Map<String, dynamic>)
      : null;

  Map<String, dynamic> toJson() =>
      {'emergencyNotification': transportEmailNotificationInfo?.toJson()};
}
