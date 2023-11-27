import 'package:db_atom/src/features/contact_details/models/contact_info.dart';

class ViolationPenaltyRecordRequest {
  ContactRecord? cit;

  ViolationPenaltyRecordRequest({
    this.cit,
  });

  ViolationPenaltyRecordRequest.fromJson(Map<String, dynamic> json)
      : cit = (json['cit'] as Map<String,dynamic>?) != null ? ContactRecord.fromJson(json['cit'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'cit' : cit?.toJson()
  };
}
