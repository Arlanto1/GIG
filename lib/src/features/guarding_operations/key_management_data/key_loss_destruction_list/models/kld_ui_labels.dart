import 'package:db_atom/index.dart';

part 'kld_ui_labels.g.dart';

@JsonSerializable()
class KLDUiLabels {
  KLDUiLabels({
    required this.defaultLocale,
    required this.locale,
  });

  factory KLDUiLabels.fromJson(Map<String, dynamic> json) =>
      _$KLDUiLabelsFromJson(json);

  Map<String, dynamic> toJson() => _$KLDUiLabelsToJson(this);

  @JsonKey(name: 'locale')
  final KLDUiLabelsLocale locale;
  @JsonKey(name: 'default')
  final KLDUiLabelsLocale defaultLocale;
}

@JsonSerializable()
class KLDUiLabelsLocale {
  @JsonKey(name: 'com.arlanto.atom.keyLossDestructionManagement.type')
  final String? type;
  @JsonKey(name: 'com.arlanto.atom.keyLossDestructionManagement.additionalInformation')
  final String? additionalInformation;
  @JsonKey(name: 'com.arlanto.atom.keyLossDestructionManagement.type.lockChange')
  final String? typeLockChange;
  @JsonKey(name: 'com.arlanto.atom.keyLossDestructionManagement.status.damaged')
  final String? statusDamaged;
  @JsonKey(name: 'com.arlanto.atom.keyLossDestructionManagement.type.destroy')
  final String? typeDestroy;
  @JsonKey(name: 'com.arlanto.atom.keyLossDestructionManagement.status.destroy')
  final String? statusDestroy;
  @JsonKey(name: 'com.arlanto.atom.keyLossDestructionManagement.securityManager')
  final String? securityManager;
  @JsonKey(name: 'com.arlanto.atom.keyLossDestructionManagement.investigationRequired')
  final String? investigationRequired;
  @JsonKey(name: 'com.arlanto.atom.keyLossDestructionManagement.createdBy')
  final String? createdBy;
  @JsonKey(name: 'com.arlanto.atom.keyLossDestructionManagement.keyType.normal')
  final String? keyTypeNormal;
  @JsonKey(name: 'com.arlanto.atom.keyLossDestructionManagement.status')
  final String? status;
  @JsonKey(name: 'com.arlanto.atom.keyLossDestructionManagement.hasLockChanged')
  final String? hasLockChanged;
  @JsonKey(name: 'com.arlanto.atom.keyLossDestructionManagement.status.lostApproved')
  final String? statusLostApproved;
  @JsonKey(name: 'com.arlanto.atom.keyLossDestructionManagement.keyType')
  final String? keyType;
  @JsonKey(name: 'com.arlanto.atom.keyLossDestructionManagement.status.lockChange')
  final String? statusLockChange;
  @JsonKey(name: 'com.arlanto.atom.keyLossDestructionManagement.hasKeyLost')
  final String? hasKeyLost;
  @JsonKey(name: 'com.arlanto.atom.keyLossDestructionManagement.type.lost')
  final String? typeLost;
  @JsonKey(name: 'com.arlanto.atom.keyLossDestructionManagement.status.created')
  final String? statusCreated;
  @JsonKey(name: 'com.arlanto.atom.keyLossDestructionManagement.lostKeyDetails')
  final String? lostKeyDetails;
  @JsonKey(name: 'com.arlanto.atom.keyLossDestructionManagement.noOfKeys')
  final String? noOfKeys;
  @JsonKey(name: 'com.arlanto.atom.keyLossDestructionManagement.slNo')
  final String? slNo;
  @JsonKey(name: 'com.arlanto.atom.keyLossDestructionManagement.status.investigation')
  final String? statusInvestigation;
  @JsonKey(name: 'com.arlanto.atom.keyLossDestructionManagement.status.destroyApproved')
  final String? statusDestroyApproved;
  @JsonKey(name: 'com.arlanto.atom.keyLossDestructionManagement.modifiedBy')
  final String? modifiedBy;
  @JsonKey(name: 'com.arlanto.atom.keyLossDestructionManagement.status.closed')
  final String? statusClosed;
  @JsonKey(name: 'com.arlanto.atom.keyLossDestructionManagement.keyType.master')
  final String? keyTypeMaster;
  @JsonKey(name: 'com.arlanto.atom.keyLossDestructionManagement.modifiedDate')
  final String? modifiedDate;
  @JsonKey(name: 'com.arlanto.atom.keyLossDestructionManagement.type.damage')
  final String? typeDamage;
  @JsonKey(name: 'com.arlanto.atom.keyLossDestructionManagement.status.destroyReject')
  final String? statusDestroyReject;
  @JsonKey(name: 'com.arlanto.atom.keyLossDestructionManagement.srh')
  final String? srh;
  @JsonKey(name: 'com.arlanto.atom.keyLossDestructionManagement.status.lost')
  final String? statusLost;
  @JsonKey(name: 'com.arlanto.atom.keyLossDestructionManagement.createdDate')
  final String? createdDate;
  @JsonKey(name: 'com.arlanto.atom.keyLossDestructionManagement.destructionReason')
  final String? destructionReason;
  @JsonKey(name: 'com.arlanto.atom.keyLossDestructionManagement.status.damagedApproved')
  final String? statusDamagedApproved;
  @JsonKey(name: 'com.arlanto.atom.keyLossDestructionManagement.status.cancel')
  final String? statusCancel;


  KLDUiLabelsLocale(
      this.type,
      this.additionalInformation,
      this.typeLockChange,
      this.statusDamaged,
      this.typeDestroy,
      this.statusDestroy,
      this.securityManager,
      this.investigationRequired,
      this.createdBy,
      this.keyTypeNormal,
      this.status,
      this.hasLockChanged,
      this.statusLostApproved,
      this.keyType,
      this.statusLockChange,
      this.hasKeyLost,
      this.typeLost,
      this.statusCreated,
      this.lostKeyDetails,
      this.noOfKeys,
      this.slNo,
      this.statusInvestigation,
      this.statusDestroyApproved,
      this.modifiedBy,
      this.statusClosed,
      this.keyTypeMaster,
      this.modifiedDate,
      this.typeDamage,
      this.statusDestroyReject,
      this.srh,
      this.statusLost,
      this.createdDate,
      this.destructionReason,
      this.statusDamagedApproved,
      this.statusCancel);

  factory KLDUiLabelsLocale.fromJson(Map<String, dynamic> json) =>
      _$KLDUiLabelsLocaleFromJson(json);

  Map<String, dynamic> toJson() => _$KLDUiLabelsLocaleToJson(this);
}
