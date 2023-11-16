part of 'contacts_list_response_model.dart';

ContactsListModel _$ContactsListModelFromJson(Map<String, dynamic> json) =>
    ContactsListModel(
      id: json['id'] as int?,
          status: json['status'] as int?,
          modifiedBy: json['modifiedBy'] as String?,
          contact : (json['contact'] as List?)?.map((dynamic e) => Contacts.fromJson(e as Map<String,dynamic>)).toList(),
    )..lock = json['lock'] as String?;

Map<String, dynamic> _$ContactsListModelToJson(ContactsListModel instance) =>
    <String, dynamic>{
      'lock': instance.lock,
      'id': instance.id,
      'status': instance.status,
      'contact': instance.contact,
      'modifiedBy': instance.modifiedBy,
    };
