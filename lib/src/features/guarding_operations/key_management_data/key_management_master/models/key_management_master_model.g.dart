// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'key_management_master_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KeyManagementMasterModel _$KeyManagementMasterModelFromJson(
        Map<String, dynamic> json) =>
    KeyManagementMasterModel(
      id: json['id'] as int?,
      slNo: json['slNo'] as String?,
      location: json['location'] == null
          ? null
          : Organisation.fromJson(json['location'] as Map<String, dynamic>),
      region: json['region'] == null
          ? null
          : Organisation.fromJson(json['region'] as Map<String, dynamic>),
      createdBy: json['createdBy'] == null
          ? null
          : User.fromJson(json['createdBy'] as Map<String, dynamic>),
      status: json['status'] as int?,
      createdDate: json['createdDate'] as String?,
      entities: (json['entities'] as List<dynamic>?)
          ?.map((e) => Organisation.fromJson(e as Map<String, dynamic>))
          .toList(),
      floor: json['floor'] as String?,
      doorType: json['doorType'] == null
          ? null
          : Organisation.fromJson(json['doorType'] as Map<String, dynamic>),
      doorName: json['doorName'] as String?,
      doorAccessControl: json['doorAccessControl'] as bool? ?? false,
      doorLockKey: json['doorLockKey'] as bool? ?? false,
      keyNo: json['keyNo'] as String?,
      keyTagging: json['keyTagging'] as int?,
      noKeys: json['noKeys'] as int?,
      noMasterKey: json['noMasterKey'] as int?,
      total: json['total'] as int?,
      keysStored: json['keysStored'] as String?,
      modifiedDate: json['modifiedDate'] as String?,
      modifiedBy: json['modifiedBy'] as String?,
    )..lock = json['lock'] as String?;

Map<String, dynamic> _$KeyManagementMasterModelToJson(
        KeyManagementMasterModel instance) =>
    <String, dynamic>{
      'lock': instance.lock,
      'id': instance.id,
      'slNo': instance.slNo,
      'location': instance.location,
      'region': instance.region,
      'createdBy': instance.createdBy,
      'status': instance.status,
      'createdDate': instance.createdDate,
      'entities': instance.entities,
      'floor': instance.floor,
      'doorType': instance.doorType,
      'doorName': instance.doorName,
      'doorAccessControl': instance.doorAccessControl,
      'doorLockKey': instance.doorLockKey,
      'keyNo': instance.keyNo,
      'keyTagging': instance.keyTagging,
      'noKeys': instance.noKeys,
      'noMasterKey': instance.noMasterKey,
      'total': instance.total,
      'keysStored': instance.keysStored,
      'modifiedDate': instance.modifiedDate,
      'modifiedBy': instance.modifiedBy,
    };
