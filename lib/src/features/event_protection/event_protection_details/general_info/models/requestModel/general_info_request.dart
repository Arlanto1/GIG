

import '../general_info_model.dart';

class GeneralInfoRequest {
  GeneralInfoRequest({
    required this.eventProtectionGi,
  });

  late final EventProtectionGi eventProtectionGi;

  GeneralInfoRequest.fromJson(Map<String, dynamic> json) {
    eventProtectionGi =
        EventProtectionGi.fromJson(json['epGi']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['epGi'] = eventProtectionGi.toJson();
    return _data;
  }
}