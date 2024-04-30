import 'package:db_atom/src/features/guarding_operations/sla_violation_penalty/models/violation_penalty_model.dart';

class ViolationPenaltyRecordRequest {
  ViolationPenaltyRecord? vp;

  ViolationPenaltyRecordRequest({
    this.vp,
  });

  ViolationPenaltyRecordRequest.fromJson(Map<String, dynamic> json)
      : vp = (json['vp'] as Map<String, dynamic>?) != null
            ? ViolationPenaltyRecord.fromJson(
                json['vp'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {'vp': vp?.toJson()};
}
