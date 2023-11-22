import '../general_info_model.dart';

class OccurrenceGeneralInfoRequest {
  OccurrenceGeneralInfoRequest({
    required this.occurrence,
  });

  late final OccurrenceModel occurrence;

  OccurrenceGeneralInfoRequest.fromJson(Map<String, dynamic> json) {
    occurrence = OccurrenceModel.fromJson(json['occurrence']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['occurrence'] = occurrence.toJson();
    return data;
  }
}
