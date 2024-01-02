import 'package:db_atom/src/models/organisation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'key_issuance_process_model.g.dart';

@JsonSerializable()
class KeyIssuanceProcessRecord {
  num? id;
  num? svpId;
  Organisation? violation;
  double? penaltyAmount;
  num? totalViolations;
  num? staffCategory;
  num? totalPenaltyAmount;

  KeyIssuanceProcessRecord({
    this.id,
    this.svpId,
    this.violation,
    this.penaltyAmount,
    this.totalViolations,
    this.staffCategory,
    this.totalPenaltyAmount,
  });

  factory KeyIssuanceProcessRecord.fromJson(Map<String, dynamic> json) =>
      _$KeyIssuanceProcessRecordFromJson(json);

  Map<String, dynamic> toJson() => _$KeyIssuanceProcessRecordToJson(this);

}


