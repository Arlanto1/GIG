import '../general_info_model.dart';

class GeneralInfoRequest {
  GeneralInfoRequest({
    required this.eventProtectionGi,
  });

  late final EventProtectionGi eventProtectionGi;

  GeneralInfoRequest.fromJson(Map<String, dynamic> json) {
    eventProtectionGi = EventProtectionGi.fromJson(json['epGi']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['epGi'] = eventProtectionGi.toJson();
    return data;
  }
}
