// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_details_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactDetailModel _$ContactDetailModelFromJson(Map<String, dynamic> json) =>
    ContactDetailModel(
      id: (json['id'] as num?)?.toInt(),
      slNo: json['slNo'] as String?,
      location: json['location'] == null
          ? null
          : Organisation.fromJson(json['location'] as Map<String, dynamic>),
      locationRegion: json['locationRegion'] == null
          ? null
          : Organisation.fromJson(
              json['locationRegion'] as Map<String, dynamic>),
      locationType: json['locationType'] == null
          ? null
          : Organisation.fromJson(json['locationType'] as Map<String, dynamic>),
      inputDate: json['inputDate'] as String?,
      entrySecurity: json['entrySecurity'] == null
          ? null
          : User.fromJson(json['entrySecurity'] as Map<String, dynamic>),
      modifiedDate: json['modifiedDate'] as String?,
      modifiedBy: json['modifiedBy'] as String?,
      status: (json['status'] as num?)?.toInt(),
    )..lock = json['lock'] as String?;

Map<String, dynamic> _$ContactDetailModelToJson(ContactDetailModel instance) =>
    <String, dynamic>{
      'lock': instance.lock,
      'id': instance.id,
      'slNo': instance.slNo,
      'location': instance.location,
      'locationRegion': instance.locationRegion,
      'locationType': instance.locationType,
      'inputDate': instance.inputDate,
      'entrySecurity': instance.entrySecurity,
      'modifiedDate': instance.modifiedDate,
      'modifiedBy': instance.modifiedBy,
      'status': instance.status,
    };
