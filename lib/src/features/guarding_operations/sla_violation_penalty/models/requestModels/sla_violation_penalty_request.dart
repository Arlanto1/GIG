import '../sla_violation_penalty_response_model.dart';

class SLAViolationPenaltyRequest {
  final SLAViolationPenaltyModel? svpGi;

  SLAViolationPenaltyRequest({
    this.svpGi,
  });

  SLAViolationPenaltyRequest.fromJson(Map<String, dynamic> json)
      : svpGi = (json['svpGi'] as Map<String, dynamic>?) != null
            ? SLAViolationPenaltyModel.fromJson(
                json['sla'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {'svpGi': svpGi?.toJson()};
}
