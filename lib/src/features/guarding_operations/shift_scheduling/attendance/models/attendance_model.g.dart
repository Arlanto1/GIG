// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceModel _$AttendanceModelFromJson(Map<String, dynamic> json) =>
    AttendanceModel(
      id: (json['id'] as num?)?.toInt(),
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
      dutyType: (json['dutyType'] as num?)?.toInt(),
      status: (json['status'] as num?)?.toInt(),
      approvalStatus: (json['approvalStatus'] as num?)?.toInt(),
      entrySecurityName: json['entrySecurityName'] as String?,
      isEligibleToEdit: json['isEligibleToEdit'] as bool? ?? false,
      modifiedBy: json['modifiedBy'] as String?,
      modifiedDate: json['modifiedDate'] as String?,
      shiftInfo: json['shiftInfo'] == null
          ? null
          : Organisation.fromJson(json['shiftInfo'] as Map<String, dynamic>),
      briefingPoints: json['briefingPoints'] as String?,
      briefingPointsA: json['briefingPointsA'] as String?,
      briefingPointsB: json['briefingPointsB'] as String?,
      briefingPointsC: json['briefingPointsC'] as String?,
      briefingPointsG: json['briefingPointsG'] as String?,
    )..lock = json['lock'] as String?;

Map<String, dynamic> _$AttendanceModelToJson(AttendanceModel instance) =>
    <String, dynamic>{
      'lock': instance.lock,
      'id': instance.id,
      'location': instance.location,
      'locationRegion': instance.locationRegion,
      'inputDate': instance.inputDate,
      'slNo': instance.slNo,
      'vendor': instance.vendor,
      'dutyType': instance.dutyType,
      'status': instance.status,
      'approvalStatus': instance.approvalStatus,
      'entrySecurityName': instance.entrySecurityName,
      'isEligibleToEdit': instance.isEligibleToEdit,
      'modifiedBy': instance.modifiedBy,
      'modifiedDate': instance.modifiedDate,
      'shiftInfo': instance.shiftInfo,
      'briefingPoints': instance.briefingPoints,
      'briefingPointsA': instance.briefingPointsA,
      'briefingPointsB': instance.briefingPointsB,
      'briefingPointsC': instance.briefingPointsC,
      'briefingPointsG': instance.briefingPointsG,
    };
