// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'violation_penalty_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ViolationPenaltyRecord _$ViolationPenaltyRecordFromJson(Map<String, dynamic> json) =>
    ViolationPenaltyRecord(
      id: json['id'] as int?,
      contactId: json['contactId'] as int?,
      email: json['email'] as String?,
      contactNo: json['contactNo'] as String?,
      rank: json['rank'] == null
          ? null
          : Organisation.fromJson(json['rank'] as Map<String, dynamic>),
      type: json['type'] as int?,
    );

Map<String, dynamic> _$ViolationPenaltyRecordToJson(ViolationPenaltyRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contactId': instance.contactId,
      'email': instance.email,
      'contactNo': instance.contactNo,
      'rank': instance.rank,
      'type': instance.type,
    };
