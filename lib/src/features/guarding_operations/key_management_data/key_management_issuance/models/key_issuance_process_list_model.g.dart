// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'key_issuance_process_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KeyManagementProcessListModel _$KeyManagementProcessListModelFromJson(
    Map<String, dynamic> json) =>
    KeyManagementProcessListModel(
      violationPenalties: (json['violationPenalties'] as List<dynamic>?)
          ?.map(
              (e) => ViolationPenaltyRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..lock = json['lock'] as String?;

Map<String, dynamic> _$KeyManagementProcessListModelToJson(
    KeyManagementProcessListModel instance) =>
    <String, dynamic>{
      'lock': instance.lock,
      'violationPenalties': instance.violationPenalties,
    };
