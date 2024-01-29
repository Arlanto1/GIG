// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'key_loss_destruction_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KeyLossDestructionListModel _$KeyLossDestructionListModelFromJson(
        Map<String, dynamic> json) =>
    KeyLossDestructionListModel(
      keyManagementId: json['keyManagementId'] as String?,
      id: json['id'] as int?,
      slNo: json['slNo'],
      type: json['type'] as int?,
      keyType: json['keyType'] as int?,
      hasLockChanged: json['hasLockChanged'] as bool?,
      keyDestructionProcess: json['keyDestructionProcess'],
      hasKeyLost: json['hasKeyLost'],
      srh: json['srh'] == null
          ? null
          : User.fromJson(json['srh'] as Map<String, dynamic>),
      securityManager: json['securityManager'] == null
          ? null
          : User.fromJson(json['securityManager'] as Map<String, dynamic>),
      investigationRequired: json['investigationRequired'] as bool?,
      lostKeyDetails: json['lostKeyDetails'] as String?,
      additionalInformation: json['additionalInformation'] as String?,
      destructionReason: json['destructionReason'],
      status: json['status'] as int?,
      noOfKeys: json['noOfKeys'] as int?,
      createdBy: json['createdBy'] == null
          ? null
          : User.fromJson(json['createdBy'] as Map<String, dynamic>),
      createdDate: json['createdDate'] as int?,
      modifiedDate: json['modifiedDate'] as int?,
      modifiedBy: json['modifiedBy'] as String?,
    )..lock = json['lock'] as String?;

Map<String, dynamic> _$KeyLossDestructionListModelToJson(
        KeyLossDestructionListModel instance) =>
    <String, dynamic>{
      'lock': instance.lock,
      'keyManagementId': instance.keyManagementId,
      'id': instance.id,
      'slNo': instance.slNo,
      'type': instance.type,
      'keyType': instance.keyType,
      'hasLockChanged': instance.hasLockChanged,
      'keyDestructionProcess': instance.keyDestructionProcess,
      'hasKeyLost': instance.hasKeyLost,
      'srh': instance.srh,
      'securityManager': instance.securityManager,
      'investigationRequired': instance.investigationRequired,
      'lostKeyDetails': instance.lostKeyDetails,
      'additionalInformation': instance.additionalInformation,
      'destructionReason': instance.destructionReason,
      'status': instance.status,
      'noOfKeys': instance.noOfKeys,
      'createdBy': instance.createdBy,
      'createdDate': instance.createdDate,
      'modifiedDate': instance.modifiedDate,
      'modifiedBy': instance.modifiedBy,
    };
