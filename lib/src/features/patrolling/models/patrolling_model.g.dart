// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patrolling_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatrollingModel _$PatrollingModelFromJson(Map<String, dynamic> json) =>
    PatrollingModel(
      id: (json['id'] as num?)?.toInt(),
      slNo: json['slNo'] as String?,
      inputDate: json['inputDate'] as String?,
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
      entity: json['entity'] == null
          ? null
          : Organisation.fromJson(json['entity'] as Map<String, dynamic>),
      entrySecurity: json['entrySecurity'] == null
          ? null
          : User.fromJson(json['entrySecurity'] as Map<String, dynamic>),
      status: (json['status'] as num?)?.toInt(),
      modifiedBy: json['modifiedBy'] as String?,
      modifiedDate: json['modifiedDate'] as String?,
      history: (json['history'] as List<dynamic>?)
          ?.map((e) => History.fromJson(e as Map<String, dynamic>))
          .toList(),
      lsm: json['lsm'] == null
          ? null
          : User.fromJson(json['lsm'] as Map<String, dynamic>),
      securitySupervisor: json['securitySupervisor'] == null
          ? null
          : User.fromJson(json['securitySupervisor'] as Map<String, dynamic>),
      shift: (json['shift'] as num?)?.toInt(),
      submittedDate: json['submittedDate'] as String?,
      verifiedDate: json['verifiedDate'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Items.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..lock = json['lock'] as String?
      ..subsectionId = (json['subsectionId'] as num?)?.toInt();

Map<String, dynamic> _$PatrollingModelToJson(PatrollingModel instance) =>
    <String, dynamic>{
      'lock': instance.lock,
      'id': instance.id,
      'subsectionId': instance.subsectionId,
      'slNo': instance.slNo,
      'inputDate': instance.inputDate,
      'location': instance.location,
      'locationRegion': instance.locationRegion,
      'locationType': instance.locationType,
      'entity': instance.entity,
      'entrySecurity': instance.entrySecurity,
      'status': instance.status,
      'modifiedBy': instance.modifiedBy,
      'modifiedDate': instance.modifiedDate,
      'submittedDate': instance.submittedDate,
      'verifiedDate': instance.verifiedDate,
      'history': instance.history,
      'lsm': instance.lsm,
      'securitySupervisor': instance.securitySupervisor,
      'shift': instance.shift,
      'items': instance.items,
    };
