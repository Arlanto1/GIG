// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'violation_penalty_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ViolationPenaltyRecord _$ViolationPenaltyRecordFromJson(
        Map<String, dynamic> json) =>
    ViolationPenaltyRecord(
      id: json['id'] as int?,
      svpId: json['svpId'] as int?,
      penaltyAmount: json['penaltyAmount'] as double?,
      totalViolations: json['totalViolations'] as int?,
      staffCategory: json['staffCategory'] as int?,
      violation: json['violation'] == null
          ? null
          : Violation.fromJson(json['violation'] as Map<String, dynamic>),
      totalPenaltyAmount: json['totalPenaltyAmount'] as double?,
    );

Map<String, dynamic> _$ViolationPenaltyRecordToJson(
        ViolationPenaltyRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'svpId': instance.svpId,
      'penaltyAmount': instance.penaltyAmount,
      'totalViolations': instance.totalViolations,
      'staffCategory': instance.staffCategory,
      'violation': instance.violation,
      'totalPenaltyAmount': instance.totalPenaltyAmount,
    };
