import 'package:db_atom/src/models/organisation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'violation_penalty_model.g.dart';

@JsonSerializable()
class ViolationPenaltyRecord {
  final int? id;
  final int? contactId;
  final String? email;
  final String? contactNo;
  final Organisation? rank;
  final int? type;

  ViolationPenaltyRecord({
    this.id,
    this.contactId,
    this.email,
    this.contactNo,
    this.rank,
    this.type,
  });

  factory ViolationPenaltyRecord.fromJson(Map<String, dynamic> json) =>
      _$ViolationPenaltyRecordFromJson(json);

  Map<String, dynamic> toJson() => _$ViolationPenaltyRecordToJson(this);
}
