import 'package:db_atom/src/models/organisation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'violation_penalty_model.g.dart';

@JsonSerializable()
class ViolationPenaltyRecord {
  num? id;
  num? svpId;
  Organisation? violation;
  double? penaltyAmount;
  num? totalViolations;
  num? staffCategory;
  num? totalPenaltyAmount;

  ViolationPenaltyRecord({
    this.id,
    this.svpId,
    this.violation,
    this.penaltyAmount,
    this.totalViolations,
    this.staffCategory,
    this.totalPenaltyAmount,
  });

  factory ViolationPenaltyRecord.fromJson(Map<String, dynamic> json) =>
      _$ViolationPenaltyRecordFromJson(json);

  Map<String, dynamic> toJson() => _$ViolationPenaltyRecordToJson(this);

}


