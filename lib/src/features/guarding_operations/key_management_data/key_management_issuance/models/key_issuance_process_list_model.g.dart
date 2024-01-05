// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'key_issuance_process_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KeyManagementProcessListModel _$KeyManagementProcessListModelFromJson(
        Map<String, dynamic> json) =>
    KeyManagementProcessListModel(
      keyIssuanceProcessRecord: (json['keyIssuanceProcessRecord'] as List<dynamic>?)
          ?.map(
              (e) => KeyIssuanceProcessRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..lock = json['lock'] as String?;

Map<String, dynamic> _$KeyManagementProcessListModelToJson(
        KeyManagementProcessListModel instance) =>
    <String, dynamic>{
      'lock': instance.lock,
      'keyIssuanceProcessRecord': instance.keyIssuanceProcessRecord,
    };
