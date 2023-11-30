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
      violation: json['violation'] == null
          ? null
          : Organisation.fromJson(json['violation'] as Map<String, dynamic>),
      penaltyAmount: (json['penaltyAmount'] as num?)?.toDouble(),
      totalViolations: json['totalViolations'] as int?,
      staffCategory: json['staffCategory'] as int?,
      totalPenaltyAmount: (json['totalPenaltyAmount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ViolationPenaltyRecordToJson(
        ViolationPenaltyRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'svpId': instance.svpId,
      'violation': instance.violation,
      'penaltyAmount': instance.penaltyAmount,
      'totalViolations': instance.totalViolations,
      'staffCategory': instance.staffCategory,
      'totalPenaltyAmount': instance.totalPenaltyAmount,
    };
