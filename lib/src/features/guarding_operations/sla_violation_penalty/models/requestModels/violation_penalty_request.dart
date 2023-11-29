import 'package:db_atom/src/features/contact_details/models/contact_info.dart';

class ViolationPenaltyRecordRequest {
  ContactRecord? vp;

  ViolationPenaltyRecordRequest({
    this.vp,
  });

  ViolationPenaltyRecordRequest.fromJson(Map<String, dynamic> json)
      : vp = (json['vp'] as Map<String,dynamic>?) != null ? ContactRecord.fromJson(json['vp'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'vp' : vp?.toJson()
  };
}
