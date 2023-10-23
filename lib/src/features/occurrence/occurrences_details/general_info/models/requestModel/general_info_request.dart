

import '../general_info_model.dart';

class OccurrenceGeneralInfoRequest {
  OccurrenceGeneralInfoRequest({
    required this.occurrence,
  });

  late final Occurrence occurrence;

  OccurrenceGeneralInfoRequest.fromJson(Map<String, dynamic> json) {
    occurrence =
        Occurrence.fromJson(json['occurrence']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['occurrence'] = occurrence.toJson();
    return _data;
  }
}