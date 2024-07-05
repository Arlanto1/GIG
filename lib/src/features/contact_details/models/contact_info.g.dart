// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactRecord _$ContactRecordFromJson(Map<String, dynamic> json) =>
    ContactRecord(
      id: (json['id'] as num?)?.toInt(),
      contactId: (json['contactId'] as num?)?.toInt(),
      email: json['email'] as String?,
      contactNo: json['contactNo'] as String?,
      rank: json['rank'] == null
          ? null
          : Organisation.fromJson(json['rank'] as Map<String, dynamic>),
      type: (json['type'] as num?)?.toInt(),
      state: json['state'] as String?,
      escalationLevel: (json['escltnLevel'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ContactRecordToJson(ContactRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contactId': instance.contactId,
      'email': instance.email,
      'state': instance.state,
      'contactNo': instance.contactNo,
      'rank': instance.rank,
      'type': instance.type,
      'escltnLevel': instance.escalationLevel,
    };
