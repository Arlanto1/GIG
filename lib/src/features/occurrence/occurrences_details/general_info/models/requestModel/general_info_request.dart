

import '../general_info_model.dart';

class OccurrenceGeneralInfoRequest {
  OccurrenceGeneralInfoRequest({
    required this.occurrence,
  });

  late final Occurrence occurrence;

  OccurrenceGeneralInfoRequest.fromJson(Map<String, dynamic> json) {
    occurrence =
        Occurrence.fromJson(json['occGi']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['occGi'] = occurrence.toJson();
    return _data;
  }
}