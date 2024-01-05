// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'key_management_issuance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KeyManagementIssuanceModel _$KeyManagementIssuanceModelFromJson(
        Map<String, dynamic> json) =>
    KeyManagementIssuanceModel(
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
      status: json['status'] as int?,
      entity: (json['entity'] as List<dynamic>?)
          ?.map((e) => Organisation.fromJson(e as Map<String, dynamic>))
          .toList(),
      vendor: json['vendor'] == null
          ? null
          : Organisation.fromJson(json['vendor'] as Map<String, dynamic>),
      employeeId: json['employeeId'] as String?,
      typeOfService: (json['typeOfService'] as List<dynamic>?)
          ?.map((e) => Organisation.fromJson(e as Map<String, dynamic>))
          .toList(),
      approver: json['approver'] == null
          ? null
          : User.fromJson(json['approver'] as Map<String, dynamic>),
      employeeType: json['employeeType'] as int?,
      keyHandingOverDuration: json['keyHandingOverDuration'] as int?,
    )..lock = json['lock'] as String?;

Map<String, dynamic> _$KeyManagementIssuanceModelToJson(
        KeyManagementIssuanceModel instance) =>
    <String, dynamic>{
      'lock': instance.lock,
      'id': instance.id,
      'slNo': instance.slNo,
      'location': instance.location,
      'locationRegion': instance.locationRegion,
      'inputDate': instance.inputDate,
      'entrySecurity': instance.entrySecurity,
      'status': instance.status,
      'employeeType': instance.employeeType,
      'keyHandingOverDuration': instance.keyHandingOverDuration,
      'vendor': instance.vendor,
      'typeOfService': instance.typeOfService,
      'entity': instance.entity,
      'approver': instance.approver,
      'employeeId': instance.employeeId,
    };
