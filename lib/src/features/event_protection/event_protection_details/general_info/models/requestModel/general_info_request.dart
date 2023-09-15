

import '../general_info_model.dart';

class GeneralInfoRequest {
  GeneralInfoRequest({
    required this.eventProtectionGi,
  });

  late final EventProtectionGi eventProtectionGi;

  GeneralInfoRequest.fromJson(Map<String, dynamic> json) {
    eventProtectionGi =
        EventProtectionGi.fromJson(json['eventProtectionGi']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['eventProtectionGi'] = eventProtectionGi.toJson();
    return _data;
  }
}