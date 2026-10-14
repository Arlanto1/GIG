// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duty_post_master_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DutyPostMasterModel _$DutyPostMasterModelFromJson(Map<String, dynamic> json) =>
    DutyPostMasterModel(
      id: (json['id'] as num?)?.toInt(),
      status: (json['status'] as num?)?.toInt(),
      location: json['location'] == null
          ? null
          : Organisation.fromJson(json['location'] as Map<String, dynamic>),
      region: json['region'] == null
          ? null
          : Organisation.fromJson(json['region'] as Map<String, dynamic>),
      dutyPostLocation: json['dutyPostLocation'] == null
          ? null
          : Organisation.fromJson(
              json['dutyPostLocation'] as Map<String, dynamic>),
      locationType: json['locationType'] == null
          ? null
          : Organisation.fromJson(json['locationType'] as Map<String, dynamic>),
      shiftA: (json['shiftA'] as num?)?.toInt(),
      shiftB: (json['shiftB'] as num?)?.toInt(),
      shiftC: (json['shiftC'] as num?)?.toInt(),
      shiftG: (json['shiftG'] as num?)?.toInt(),
      rankId: (json['rankId'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
      createdDate: json['createdDate'] as String?,
      createdBy: json['createdBy'] == null
          ? null
          : User.fromJson(json['createdBy'] as Map<String, dynamic>),
      modifiedDate: json['modifiedDate'] as String?,
      modifiedBy: json['modifiedBy'] as String?,
      isEligibleToEdit: json['isEligibleToEdit'] as bool? ?? false,
    )..lock = json['lock'] as String?;

Map<String, dynamic> _$DutyPostMasterModelToJson(
        DutyPostMasterModel instance) =>
    <String, dynamic>{
      'lock': instance.lock,
      'id': instance.id,
      'status': instance.status,
      'location': instance.location,
      'region': instance.region,
      'dutyPostLocation': instance.dutyPostLocation,
      'locationType': instance.locationType,
      'shiftA': instance.shiftA,
      'shiftB': instance.shiftB,
      'shiftC': instance.shiftC,
      'shiftG': instance.shiftG,
      'rankId': instance.rankId,
      'total': instance.total,
      'createdDate': instance.createdDate,
      'createdBy': instance.createdBy,
      'modifiedDate': instance.modifiedDate,
      'modifiedBy': instance.modifiedBy,
      'isEligibleToEdit': instance.isEligibleToEdit,
    };
