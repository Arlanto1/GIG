// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'violation_penalty_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ViolationPenaltyListModel _$ViolationPenaltyListModelFromJson(Map<String, dynamic> json) =>
    ViolationPenaltyListModel(
          violationPenalties: (json['violationPenalties'] as List<dynamic>?)
          ?.map((e) => ViolationPenaltyRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..lock = json['lock'] as String?;

Map<String, dynamic> _$ViolationPenaltyListModelToJson(ViolationPenaltyListModel instance) =>
    <String, dynamic>{
      'lock': instance.lock,
      'violationPenalties': instance.violationPenalties,
    };
