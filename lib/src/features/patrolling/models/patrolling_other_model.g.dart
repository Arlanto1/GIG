// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patrolling_other_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatrollingOtherModel _$PatrollingOtherModelFromJson(
        Map<String, dynamic> json) =>
    PatrollingOtherModel(
      subsectionId: (json['subsectionId'] as num?)?.toInt(),
      subsectionName: json['subsectionName'] as String?,
      fromSequence: (json['fromSequence'] as num?)?.toInt(),
      toSequence: (json['toSequence'] as num?)?.toInt(),
      totalQuestions: (json['totalQuestions'] as num?)?.toInt(),
      slNo: json['slNo'] as String?,
      status: (json['status'] as num?)?.toInt(),
      inputDate: json['inputDate'] as String?,
      submittedDate: json['submittedDate'] as String?,
      verifiedDate: json['verifiedDate'] as String?,
      closedDate: json['closedDate'] as String?,
      locationId: (json['locationId'] as num?)?.toInt(),
      locationName: json['locationName'] as String?,
      regionId: (json['regionId'] as num?)?.toInt(),
      regionName: json['regionName'] as String?,
      entityId: (json['entityId'] as num?)?.toInt(),
      entityName: json['entityName'] as String?,
      entrySecurityId: (json['entrySecurityId'] as num?)?.toInt(),
      entrySecurityName: json['entrySecurityName'] as String?,
      securitySupervisorId: (json['securitySupervisorId'] as num?)?.toInt(),
      securitySupervisorName: json['securitySupervisorName'] as String?,
      lsmId: (json['lsmId'] as num?)?.toInt(),
      lsmName: json['lsmName'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Items.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..lock = json['lock'] as String?;

Map<String, dynamic> _$PatrollingOtherModelToJson(
        PatrollingOtherModel instance) =>
    <String, dynamic>{
      'lock': instance.lock,
      'subsectionId': instance.subsectionId,
      'subsectionName': instance.subsectionName,
      'fromSequence': instance.fromSequence,
      'toSequence': instance.toSequence,
      'totalQuestions': instance.totalQuestions,
      'slNo': instance.slNo,
      'status': instance.status,
      'inputDate': instance.inputDate,
      'submittedDate': instance.submittedDate,
      'verifiedDate': instance.verifiedDate,
      'closedDate': instance.closedDate,
      'locationId': instance.locationId,
      'locationName': instance.locationName,
      'regionId': instance.regionId,
      'regionName': instance.regionName,
      'entityId': instance.entityId,
      'entityName': instance.entityName,
      'entrySecurityId': instance.entrySecurityId,
      'entrySecurityName': instance.entrySecurityName,
      'securitySupervisorId': instance.securitySupervisorId,
      'securitySupervisorName': instance.securitySupervisorName,
      'lsmId': instance.lsmId,
      'lsmName': instance.lsmName,
      'items': instance.items,
    };
