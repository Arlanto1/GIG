// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'key_management_master_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KeyManagementMasterModel _$KeyManagementMasterModelFromJson(
        Map<String, dynamic> json) =>
    KeyManagementMasterModel(
      keyManagementId: json['keyManagementId'] as String?,
      id: json['id'] as int?,
      slNo: json['slNo'] as String?,
      createdBy: json['createdBy'] == null
          ? null
          : User.fromJson(json['createdBy'] as Map<String, dynamic>),
      entities: (json['entities'] as List<dynamic>?)
          ?.map((e) => Organisation.fromJson(e as Map<String, dynamic>))
          .toList(),
      location: json['location'] == null
          ? null
          : Organisation.fromJson(json['location'] as Map<String, dynamic>),
      region: json['region'] == null
          ? null
          : Organisation.fromJson(json['region'] as Map<String, dynamic>),
      floor: json['floor'] as String?,
      doorType: Organisation.fromJson(json['doorType'] as Map<String, dynamic>),
      doorName: json['doorName'] as String?,
      doorAccessControl: json['doorAccessControl'] as bool? ?? false,
      doorLockKey: json['doorLockKey'] as bool? ?? false,
      keyNo: json['keyNo'] as String?,
      keyTagging: json['keyTagging'] as int?,
      noKeys: json['noKeys'] as int,
      noKeysIssued: json['noKeysIssued'] as int,
      available: json['available'],
      returned: json['returned'],
      notReturned: json['notReturned'],
      lost: json['lost'],
      damaged: json['damaged'],
      noMasterKey: json['noMasterKey'] as int,
      noKeysIssuedMaster: json['noKeysIssuedMaster'],
      availableMaster: json['availableMaster'],
      returnedMaster: json['returnedMaster'],
      notReturnedMaster: json['notReturnedMaster'],
      lostMaster: json['lostMaster'],
      damagedMaster: json['damagedMaster'],
      total: json['total'],
      keysStored: json['keysStored'] as String?,
      modifiedDate: json['modifiedDate'],
      modifiedBy: json['modifiedBy'],
      lockChanged: json['lockChanged'] as List<dynamic>?,
      loss: json['loss'] as List<dynamic>?,
      damage: json['damage'] as List<dynamic>?,
      destroy: json['destroy'] as List<dynamic>?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$KeyManagementMasterModelToJson(
        KeyManagementMasterModel instance) =>
    <String, dynamic>{
      'keyManagementId': instance.keyManagementId,
      'id': instance.id,
      'slNo': instance.slNo,
      'createdBy': instance.createdBy,
      'entities': instance.entities,
      'location': instance.location,
      'region': instance.region,
      'floor': instance.floor,
      'doorType': instance.doorType,
      'doorName': instance.doorName,
      'doorAccessControl': instance.doorAccessControl,
      'doorLockKey': instance.doorLockKey,
      'keyNo': instance.keyNo,
      'keyTagging': instance.keyTagging,
      'noKeys': instance.noKeys,
      'noKeysIssued': instance.noKeysIssued,
      'available': instance.available,
      'returned': instance.returned,
      'notReturned': instance.notReturned,
      'lost': instance.lost,
      'damaged': instance.damaged,
      'noMasterKey': instance.noMasterKey,
      'noKeysIssuedMaster': instance.noKeysIssuedMaster,
      'availableMaster': instance.availableMaster,
      'returnedMaster': instance.returnedMaster,
      'notReturnedMaster': instance.notReturnedMaster,
      'lostMaster': instance.lostMaster,
      'damagedMaster': instance.damagedMaster,
      'total': instance.total,
      'keysStored': instance.keysStored,
      'modifiedDate': instance.modifiedDate,
      'modifiedBy': instance.modifiedBy,
      'lockChanged': instance.lockChanged,
      'loss': instance.loss,
      'damage': instance.damage,
      'destroy': instance.destroy,
      'status': instance.status,
    };
