// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kld_ui_labels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KLDUiLabels _$KLDUiLabelsFromJson(Map<String, dynamic> json) => KLDUiLabels(
      defaultLocale:
          KLDUiLabelsLocale.fromJson(json['default'] as Map<String, dynamic>),
      locale:
          KLDUiLabelsLocale.fromJson(json['locale'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$KLDUiLabelsToJson(KLDUiLabels instance) =>
    <String, dynamic>{
      'locale': instance.locale,
      'default': instance.defaultLocale,
    };

KLDUiLabelsLocale _$KLDUiLabelsLocaleFromJson(Map<String, dynamic> json) =>
    KLDUiLabelsLocale(
      json['com.arlanto.atom.keyLossDestructionManagement.type'] as String?,
      json['com.arlanto.atom.keyLossDestructionManagement.additionalInformation']
          as String?,
      json['com.arlanto.atom.keyLossDestructionManagement.type.lockChange']
          as String?,
      json['com.arlanto.atom.keyLossDestructionManagement.status.damaged']
          as String?,
      json['com.arlanto.atom.keyLossDestructionManagement.type.destroy']
          as String?,
      json['com.arlanto.atom.keyLossDestructionManagement.status.destroy']
          as String?,
      json['com.arlanto.atom.keyLossDestructionManagement.securityManager']
          as String?,
      json['com.arlanto.atom.keyLossDestructionManagement.investigationRequired']
          as String?,
      json['com.arlanto.atom.keyLossDestructionManagement.createdBy']
          as String?,
      json['com.arlanto.atom.keyLossDestructionManagement.keyType.normal']
          as String?,
      json['com.arlanto.atom.keyLossDestructionManagement.status'] as String?,
      json['com.arlanto.atom.keyLossDestructionManagement.hasLockChanged']
          as String?,
      json['com.arlanto.atom.keyLossDestructionManagement.status.lostApproved']
          as String?,
      json['com.arlanto.atom.keyLossDestructionManagement.keyType'] as String?,
      json['com.arlanto.atom.keyLossDestructionManagement.status.lockChange']
          as String?,
      json['com.arlanto.atom.keyLossDestructionManagement.hasKeyLost']
          as String?,
      json['com.arlanto.atom.keyLossDestructionManagement.type.lost']
          as String?,
      json['com.arlanto.atom.keyLossDestructionManagement.status.created']
          as String?,
      json['com.arlanto.atom.keyLossDestructionManagement.lostKeyDetails']
          as String?,
      json['com.arlanto.atom.keyLossDestructionManagement.noOfKeys'] as String?,
      json['com.arlanto.atom.keyLossDestructionManagement.slNo'] as String?,
      json['com.arlanto.atom.keyLossDestructionManagement.status.investigation']
          as String?,
      json['com.arlanto.atom.keyLossDestructionManagement.status.destroyApproved']
          as String?,
      json['com.arlanto.atom.keyLossDestructionManagement.modifiedBy']
          as String?,
      json['com.arlanto.atom.keyLossDestructionManagement.status.closed']
          as String?,
      json['com.arlanto.atom.keyLossDestructionManagement.keyType.master']
          as String?,
      json['com.arlanto.atom.keyLossDestructionManagement.modifiedDate']
          as String?,
      json['com.arlanto.atom.keyLossDestructionManagement.type.damage']
          as String?,
      json['com.arlanto.atom.keyLossDestructionManagement.status.destroyReject']
          as String?,
      json['com.arlanto.atom.keyLossDestructionManagement.srh'] as String?,
      json['com.arlanto.atom.keyLossDestructionManagement.status.lost']
          as String?,
      json['com.arlanto.atom.keyLossDestructionManagement.createdDate']
          as String?,
      json['com.arlanto.atom.keyLossDestructionManagement.destructionReason']
          as String?,
      json['com.arlanto.atom.keyLossDestructionManagement.status.damagedApproved']
          as String?,
      json['com.arlanto.atom.keyLossDestructionManagement.status.cancel']
          as String?,
    );

Map<String, dynamic> _$KLDUiLabelsLocaleToJson(KLDUiLabelsLocale instance) =>
    <String, dynamic>{
      'com.arlanto.atom.keyLossDestructionManagement.type': instance.type,
      'com.arlanto.atom.keyLossDestructionManagement.additionalInformation':
          instance.additionalInformation,
      'com.arlanto.atom.keyLossDestructionManagement.type.lockChange':
          instance.typeLockChange,
      'com.arlanto.atom.keyLossDestructionManagement.status.damaged':
          instance.statusDamaged,
      'com.arlanto.atom.keyLossDestructionManagement.type.destroy':
          instance.typeDestroy,
      'com.arlanto.atom.keyLossDestructionManagement.status.destroy':
          instance.statusDestroy,
      'com.arlanto.atom.keyLossDestructionManagement.securityManager':
          instance.securityManager,
      'com.arlanto.atom.keyLossDestructionManagement.investigationRequired':
          instance.investigationRequired,
      'com.arlanto.atom.keyLossDestructionManagement.createdBy':
          instance.createdBy,
      'com.arlanto.atom.keyLossDestructionManagement.keyType.normal':
          instance.keyTypeNormal,
      'com.arlanto.atom.keyLossDestructionManagement.status': instance.status,
      'com.arlanto.atom.keyLossDestructionManagement.hasLockChanged':
          instance.hasLockChanged,
      'com.arlanto.atom.keyLossDestructionManagement.status.lostApproved':
          instance.statusLostApproved,
      'com.arlanto.atom.keyLossDestructionManagement.keyType': instance.keyType,
      'com.arlanto.atom.keyLossDestructionManagement.status.lockChange':
          instance.statusLockChange,
      'com.arlanto.atom.keyLossDestructionManagement.hasKeyLost':
          instance.hasKeyLost,
      'com.arlanto.atom.keyLossDestructionManagement.type.lost':
          instance.typeLost,
      'com.arlanto.atom.keyLossDestructionManagement.status.created':
          instance.statusCreated,
      'com.arlanto.atom.keyLossDestructionManagement.lostKeyDetails':
          instance.lostKeyDetails,
      'com.arlanto.atom.keyLossDestructionManagement.noOfKeys':
          instance.noOfKeys,
      'com.arlanto.atom.keyLossDestructionManagement.slNo': instance.slNo,
      'com.arlanto.atom.keyLossDestructionManagement.status.investigation':
          instance.statusInvestigation,
      'com.arlanto.atom.keyLossDestructionManagement.status.destroyApproved':
          instance.statusDestroyApproved,
      'com.arlanto.atom.keyLossDestructionManagement.modifiedBy':
          instance.modifiedBy,
      'com.arlanto.atom.keyLossDestructionManagement.status.closed':
          instance.statusClosed,
      'com.arlanto.atom.keyLossDestructionManagement.keyType.master':
          instance.keyTypeMaster,
      'com.arlanto.atom.keyLossDestructionManagement.modifiedDate':
          instance.modifiedDate,
      'com.arlanto.atom.keyLossDestructionManagement.type.damage':
          instance.typeDamage,
      'com.arlanto.atom.keyLossDestructionManagement.status.destroyReject':
          instance.statusDestroyReject,
      'com.arlanto.atom.keyLossDestructionManagement.srh': instance.srh,
      'com.arlanto.atom.keyLossDestructionManagement.status.lost':
          instance.statusLost,
      'com.arlanto.atom.keyLossDestructionManagement.createdDate':
          instance.createdDate,
      'com.arlanto.atom.keyLossDestructionManagement.destructionReason':
          instance.destructionReason,
      'com.arlanto.atom.keyLossDestructionManagement.status.damagedApproved':
          instance.statusDamagedApproved,
      'com.arlanto.atom.keyLossDestructionManagement.status.cancel':
          instance.statusCancel,
    };
