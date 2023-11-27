// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sla_violation_penalty_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SLAViolationPenaltyModel _$SLAViolationPenaltyModelFromJson(Map<String, dynamic> json) =>
    SLAViolationPenaltyModel(
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
          entities : (json['entities'] as List?)
              ?.map((dynamic e) => Organisation.fromJson(e as Map<String, dynamic>))
              .toList(),
          vendors : (json['vendors'] as List?)
              ?.map((dynamic e) => Organisation.fromJson(e as Map<String, dynamic>))
              .toList(),
      asl : (json['asl'] as Map<String, dynamic>?) != null
          ? User.fromJson(json['asl'] as Map<String, dynamic>)
          : null,
    )..lock = json['lock'] as String?;

Map<String, dynamic> _$SLAViolationPenaltyModelToJson(SLAViolationPenaltyModel instance) =>
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
          'entities': instance.entities?.map((e) => e.toJson()).toList(),
          'vendors': instance.vendors?.map((e) => e.toJson()).toList(),
      'asl':instance. asl?.toJson(),

    };
