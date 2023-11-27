// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'violation_penalty_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ViolationPenaltyListModel _$ViolationPenaltyListModelFromJson(Map<String, dynamic> json) =>
    ViolationPenaltyListModel(
      id: json['id'] as int?,
      status: json['status'] as int?,
      modifiedBy: json['modifiedBy'] as String?,
          violationPenalties: (json['violationPenalties'] as List<dynamic>?)
          ?.map((e) => ViolationPenaltyRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..lock = json['lock'] as String?;

Map<String, dynamic> _$ViolationPenaltyListModelToJson(ViolationPenaltyListModel instance) =>
    <String, dynamic>{
      'lock': instance.lock,
      'id': instance.id,
      'status': instance.status,
      'modifiedBy': instance.modifiedBy,
      'contact': instance.violationPenalties,
    };
