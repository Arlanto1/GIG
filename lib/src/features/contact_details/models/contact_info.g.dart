// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_info.dart';

ContactInfo _$ContactInfoFromJson(Map<String, dynamic> json) =>
    ContactInfo(
      id: json['id'] as int?,
      contactId: json['contactId'] as int?,
      email: json['email'] as String?,
      contactNo: json['contactNo'] as String?,
      rank: json['contact'] == null
          ? null
          : Organisation.fromJson(json['contact'] as Map<String, dynamic>),
      type: json['type'] as int?,
    );

Map<String, dynamic> _$ContactInfoToJson(ContactInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.contactId,
      'modifiedBy': instance.email,
      'contactNo': instance.contactNo,
      'contact': instance.rank,
      'type': instance.type,
    };
