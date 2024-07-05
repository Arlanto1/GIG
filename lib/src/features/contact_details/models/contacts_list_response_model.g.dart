// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactsListModel _$ContactsListModelFromJson(Map<String, dynamic> json) =>
    ContactsListModel(
      id: (json['id'] as num?)?.toInt(),
      status: (json['status'] as num?)?.toInt(),
      modifiedBy: json['modifiedBy'] as String?,
      contacts: (json['contact'] as List<dynamic>?)
          ?.map((e) => ContactRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..lock = json['lock'] as String?;

Map<String, dynamic> _$ContactsListModelToJson(ContactsListModel instance) =>
    <String, dynamic>{
      'lock': instance.lock,
      'id': instance.id,
      'status': instance.status,
      'modifiedBy': instance.modifiedBy,
      'contact': instance.contacts,
    };
