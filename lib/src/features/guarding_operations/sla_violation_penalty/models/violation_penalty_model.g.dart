// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'violation_penalty_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ViolationPenaltyRecord _$ViolationPenaltyRecordFromJson(
        Map<String, dynamic> json) =>
    ViolationPenaltyRecord(
      id: json['id'] as num?,
      svpId: json['svpId'] as num?,
      violation: json['violation'] == null
          ? null
          : Organisation.fromJson(json['violation'] as Map<String, dynamic>),
      comments: json['comments'] as String?,
      penaltyAmount: (json['penaltyAmount'] as num?)?.toDouble(),
      totalViolations: json['totalViolations'] as num?,
      staffCategory: (json['staffCategory'] as num?)?.toInt(),
      shifts: (json['shifts'] as num?)?.toInt(),
      totalPenaltyAmount: json['totalPenaltyAmount'] as num?,
    );

Map<String, dynamic> _$ViolationPenaltyRecordToJson(
        ViolationPenaltyRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'svpId': instance.svpId,
      'violation': instance.violation,
      'comments': instance.comments,
      'penaltyAmount': instance.penaltyAmount,
      'totalViolations': instance.totalViolations,
      'staffCategory': instance.staffCategory,
      'shifts': instance.shifts,
      'totalPenaltyAmount': instance.totalPenaltyAmount,
    };
