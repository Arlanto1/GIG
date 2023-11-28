// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'violation_penalty_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ViolationPenaltyRecord _$ViolationPenaltyRecordFromJson(Map<String, dynamic> json) =>
    ViolationPenaltyRecord(
      id: json['id'] as int?,
          penaltyAmount: json['penaltyAmount'] as int?,
          totalViolations: json['totalViolations'] as int?,
          staffCategory: json['staffCategory'] as int?,
          // violation: json['violation'] == null
          // ? null
          // : Violation(id: id, name: name, keyname: keyname, description: description).fromJson(json['violation'] as Map<String, dynamic>),
          totalPenaltyAmount: json['totalPenaltyAmount'] as int?,
    );

Map<String, dynamic> _$ViolationPenaltyRecordToJson(ViolationPenaltyRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'penaltyAmount': instance.penaltyAmount,
      'totalViolations': instance.totalViolations,
      'staffCategory': instance.staffCategory,
     // 'violation': instance.violation,
      'totalPenaltyAmount': instance.totalPenaltyAmount,
    };
