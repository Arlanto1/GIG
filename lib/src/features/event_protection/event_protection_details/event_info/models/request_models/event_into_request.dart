import '../event_info_response.dart';

class EventInfoRequest {
  final EventInfoResponse? eventProtectionInfo;

  EventInfoRequest({
    this.eventProtectionInfo,
  });

  EventInfoRequest.fromJson(Map<String, dynamic> json)
      : eventProtectionInfo =
            (json['eventProtectionInfo'] as Map<String, dynamic>?) != null
                ? EventInfoResponse.fromJson(
                    json['eventProtectionInfo'] as Map<String, dynamic>)
                : null;

  Map<String, dynamic> toJson() =>
      {'eventProtectionInfo': eventProtectionInfo?.toJson()};
}

