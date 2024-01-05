// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'key_issuance_process_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KeyIssuanceProcessRecord _$KeyIssuanceProcessRecordFromJson(
        Map<String, dynamic> json) =>
    KeyIssuanceProcessRecord(
      id: json['id'] as num?,
      svpId: json['svpId'] as num?,
      violation: json['violation'] == null
          ? null
          : Organisation.fromJson(json['violation'] as Map<String, dynamic>),
      penaltyAmount: (json['penaltyAmount'] as num?)?.toDouble(),
      totalViolations: json['totalViolations'] as num?,
      staffCategory: json['staffCategory'] as num?,
      totalPenaltyAmount: json['totalPenaltyAmount'] as num?,
    );

Map<String, dynamic> _$KeyIssuanceProcessRecordToJson(
        KeyIssuanceProcessRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'svpId': instance.svpId,
      'violation': instance.violation,
      'penaltyAmount': instance.penaltyAmount,
      'totalViolations': instance.totalViolations,
      'staffCategory': instance.staffCategory,
      'totalPenaltyAmount': instance.totalPenaltyAmount,
    };
