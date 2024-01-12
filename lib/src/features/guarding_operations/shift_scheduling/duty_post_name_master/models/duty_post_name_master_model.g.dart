// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duty_post_name_master_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DutyPostNameMasterModel _$DutyPostNameMasterModelFromJson(
        Map<String, dynamic> json) =>
    DutyPostNameMasterModel(
      id: json['id'] as int?,
      slNo: json['slNo'] as String?,
      location: json['location'] == null
          ? null
          : Organisation.fromJson(json['location'] as Map<String, dynamic>),
      locationRegion: json['locationRegion'] == null
          ? null
          : Organisation.fromJson(
              json['locationRegion'] as Map<String, dynamic>),
      inputDate: json['inputDate'] as String?,
      entrySecurity: json['entrySecurity'] == null
          ? null
          : User.fromJson(json['entrySecurity'] as Map<String, dynamic>),
      modifiedDate: json['modifiedDate'] as String?,
      modifiedBy: json['modifiedBy'] as String?,
      status: json['status'] as int?,
      dpName: (json['dpName'] as List<dynamic>?)
          ?.map((e) => DpName.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..lock = json['lock'] as String?;

Map<String, dynamic> _$DutyPostNameMasterModelToJson(
        DutyPostNameMasterModel instance) =>
    <String, dynamic>{
      'lock': instance.lock,
      'id': instance.id,
      'slNo': instance.slNo,
      'location': instance.location,
      'locationRegion': instance.locationRegion,
      'inputDate': instance.inputDate,
      'entrySecurity': instance.entrySecurity,
      'modifiedDate': instance.modifiedDate,
      'modifiedBy': instance.modifiedBy,
      'status': instance.status,
      'dpName': instance.dpName,
    };
