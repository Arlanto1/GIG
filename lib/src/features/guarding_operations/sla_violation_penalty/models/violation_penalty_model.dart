import 'package:db_atom/src/models/organisation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'violation_penalty_model.g.dart';

@JsonSerializable()
class ViolationPenaltyRecord {
  num? id;
  num? svpId;
  Organisation? violation;
  String? comments;
  double? penaltyAmount;
  num? totalViolations;
  int? staffCategory;
  int? shifts;
  num? totalPenaltyAmount;

  ViolationPenaltyRecord({
    this.id,
    this.svpId,
    this.violation,
    this.comments,
    this.penaltyAmount,
    this.totalViolations,
    this.staffCategory,
    this.shifts,
    this.totalPenaltyAmount,
  });

  factory ViolationPenaltyRecord.fromJson(Map<String, dynamic> json) =>
      _$ViolationPenaltyRecordFromJson(json);

  Map<String, dynamic> toJson() => _$ViolationPenaltyRecordToJson(this);
}
