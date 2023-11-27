
import '../sla_violation_penalty_response_model.dart';

class SLAViolationPenaltyRequest {
  final SLAViolationPenaltyModel? sla;

  SLAViolationPenaltyRequest({
    this.sla,
  });

  SLAViolationPenaltyRequest.fromJson(Map<String, dynamic> json)
      : sla = (json['sla'] as Map<String, dynamic>?) != null
      ? SLAViolationPenaltyModel.fromJson(json['sla'] as Map<String, dynamic>)
      : null;

  Map<String, dynamic> toJson() => {'sla': sla?.toJson()};
}
