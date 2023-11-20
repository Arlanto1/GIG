import '../general_info_model.dart';

class OccurrenceGeneralInfoRequest {
  OccurrenceGeneralInfoRequest({
    required this.occurrence,
  });

  late final Occurrence occurrence;

  OccurrenceGeneralInfoRequest.fromJson(Map<String, dynamic> json) {
    occurrence = Occurrence.fromJson(json['occurrence']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['occurrence'] = occurrence.toJson();
    return data;
  }
}
