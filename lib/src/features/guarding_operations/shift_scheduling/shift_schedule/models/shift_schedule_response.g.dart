// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_schedule_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShiftScheduleModel _$ShiftScheduleModelFromJson(Map<String, dynamic> json) =>
    ShiftScheduleModel(
      id: json['id'] as int?,
      entrySecurity: json['entrySecurity'] == null
          ? null
          : User.fromJson(json['entrySecurity'] as Map<String, dynamic>),
      location: json['location'] == null
          ? null
          : Organisation.fromJson(json['location'] as Map<String, dynamic>),
      locationRegion: json['locationRegion'] == null
          ? null
          : Organisation.fromJson(
              json['locationRegion'] as Map<String, dynamic>),
      inputDate: json['inputDate'] as String?,
      slNo: json['slNo'] as String?,
      vendor: json['vendor'] == null
          ? null
          : Organisation.fromJson(json['vendor'] as Map<String, dynamic>),
      dutyType: json['dutyType'] as int?,
      status: json['status'] as int?,
      fromDate: json['fromDate'] as String?,
      toDate: json['toDate'] as String?,
      modifiedBy: json['modifiedBy'] as String?,
      modifiedDate: json['modifiedDate'] as String?,
      poc: json['poc'] as String?,
    )..lock = json['lock'] as String?;

Map<String, dynamic> _$ShiftScheduleModelToJson(ShiftScheduleModel instance) =>
    <String, dynamic>{
      'lock': instance.lock,
      'id': instance.id,
      'entrySecurity': instance.entrySecurity,
      'location': instance.location,
      'locationRegion': instance.locationRegion,
      'inputDate': instance.inputDate,
      'slNo': instance.slNo,
      'vendor': instance.vendor,
      'dutyType': instance.dutyType,
      'status': instance.status,
      'fromDate': instance.fromDate,
      'toDate': instance.toDate,
      'modifiedBy': instance.modifiedBy,
      'modifiedDate': instance.modifiedDate,
      'poc': instance.poc,
    };
