// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sla_violation_penalty_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SLAViolationPenaltyModel _$SLAViolationPenaltyModelFromJson(
        Map<String, dynamic> json) =>
    SLAViolationPenaltyModel(
      id: (json['id'] as num?)?.toInt(),
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
      status: (json['status'] as num?)?.toInt(),
      entity: (json['entity'] as List<dynamic>?)
          ?.map((e) => Organisation.fromJson(e as Map<String, dynamic>))
          .toList(),
      vendor: (json['vendor'] as List<dynamic>?)
          ?.map((e) => Organisation.fromJson(e as Map<String, dynamic>))
          .toList(),
      poc: json['poc'] as String?,
      typeOfService: (json['typeOfService'] as List<dynamic>?)
          ?.map((e) => Organisation.fromJson(e as Map<String, dynamic>))
          .toList(),
      approver: json['approver'] == null
          ? null
          : User.fromJson(json['approver'] as Map<String, dynamic>),
      attdInfoId: json['attdInfoId'] as String?,
      entitiesInfo: json['entitiesInfo'] as String?,
      vendorInfo: json['vendorInfo'] as String?,
      typeOfServiceInfo: json['typeOfServiceInfo'] as String?,
    )..lock = json['lock'] as String?;

Map<String, dynamic> _$SLAViolationPenaltyModelToJson(
        SLAViolationPenaltyModel instance) =>
    <String, dynamic>{
      'lock': instance.lock,
      'id': instance.id,
      'slNo': instance.slNo,
      'location': instance.location,
      'locationRegion': instance.locationRegion,
      'inputDate': instance.inputDate,
      'entrySecurity': instance.entrySecurity,
      'status': instance.status,
      'vendor': instance.vendor,
      'typeOfService': instance.typeOfService,
      'entity': instance.entity,
      'approver': instance.approver,
      'poc': instance.poc,
      'attdInfoId': instance.attdInfoId,
      'entitiesInfo': instance.entitiesInfo,
      'vendorInfo': instance.vendorInfo,
      'typeOfServiceInfo': instance.typeOfServiceInfo,
    };
