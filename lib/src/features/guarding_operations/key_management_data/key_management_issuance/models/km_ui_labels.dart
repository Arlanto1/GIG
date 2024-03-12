import 'package:db_atom/index.dart';

part 'km_ui_labels.g.dart';

@JsonSerializable()
class KMUiLabels {
  KMUiLabels({
    required this.defaultLocale,
    required this.locale,
  });

  factory KMUiLabels.fromJson(Map<String, dynamic> json) =>
      _$KMUiLabelsFromJson(json);

  Map<String, dynamic> toJson() => _$KMUiLabelsToJson(this);

  @JsonKey(name: 'locale')
  final KMUiLabelsLocale locale;
  @JsonKey(name: 'default')
  final KMUiLabelsLocale defaultLocale;
}

@JsonSerializable()
class KMUiLabelsLocale {
  @JsonKey(name: 'com.arlanto.atom.keyManagement.slNo')
  final String? slNo;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.doorType.criticalDoor')
  final String? criticalDoor;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.noKeysIssuedMaster')
  final String? noKeysIssuedMaster;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.doorLockKey.yes')
  final String? doorLockKeyYes;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.keys')
  final String? keys;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.hasLockChanged.yes')
  final String? hasLockChangedYes;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.biAnnualReconciliation')
  final String? biAnnualReconciliation;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.notReturned')
  final String? notReturned;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.locationRegion')
  final String? locationRegion;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.keyNumber')
  final String? keyNumber;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.department.corporateSecuriy')
  final String? departmentCorporateSecuriy;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.keyReturnDateTime')
  final String? keyReturnDateTime;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.doorAccessControl.no')
  final String? doorAccessControlNo;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.handedOverDate')
  final String? handedOverDate;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.returned')
  final String? returned;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.available')
  final String? available;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.doorType.restrictedDoor')
  final String? doorTypeRestrictedDoor;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.createdDate')
  final String? createdDate;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.employeeType.fte')
  final String? employeeTypeFte;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.damagedMaster')
  final String? damagedMaster;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.entities')
  final String? entities;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.doorLockKey')
  final String? doorLockKey;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.returnedMaster')
  final String? returnedMaster;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.keyHandingOverDuration.oneDay')
  final String? keyHandingOverDurationOneDay;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.keysNotReturned')
  final String? keysNotReturned;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.status.lostDamagedNotReturned')
  final String? statusLostDamagedNotReturned;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.lost')
  final String? lost;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.hasLockChanged')
  final String? hasLockChanged;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.keyLostReportedSM.no')
  final String? keyLostReportedSMNo;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.keyStatus.misplaced')
  final String? keyStatusMisplaced;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.createdBy')
  final String? createdBy;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.status.closedLost')
  final String? statusClosedLost;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.returnedByName')
  final String? returnedByName;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.status.closedLostNotReturned')
  final String? statusClosedLostNotReturned;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.keyTagging.no')
  final String? keyTaggingNo;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.doorAccessControl')
  final String? doorAccessControl;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.keyStatus.handedOver')
  final String? keyStatusHandedOver;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.status.closedLostDamaged')
  final String? statusClosedLostDamaged;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.notReturnedMaster')
  final String? notReturnedMaster;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.dbSponsorCwrT2')
  final String? dbSponsorCwrT2;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.status.closed')
  final String? statusClosed;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.investigationRequired')
  final String? investigationRequired;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.noMasterKey')
  final String? noMasterKey;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.location')
  final String? location;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.doorType.perimeterDoor')
  final String? doorTypePerimeterDoor;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.status')
  final String? status;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.srh')
  final String? srh;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.department')
  final String? department;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.keysLost')
  final String? keysLost;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.employeeType.cwrT1')
  final String? employeeTypeCwrT1;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.employeeType.cwrT2')
  final String? employeeTypeCwrT2;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.status.returned')
  final String? statusReturned;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.keyIssProcess')
  final String? keyIssProcess;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.doorType.commonDoor')
  final String? doorTypeCommonDoor;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.status.handedOver')
  final String? statusHandedOver;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.masterKeys')
  final String? masterKeys;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.handedOverTo')
  final String? handedOverTo;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.status.totalDamage')
  final String? statusTotalDamage;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.keysAvailable')
  final String? keysAvailable;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.lsm')
  final String? lsm;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.keyTagging.na')
  final String? keyTaggingNa;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.modifiedDate')
  final String? modifiedDate;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.destructionReason')
  final String? destructionReason;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.keyDestructionProcess')
  final String? keyDestructionProcess;
  @JsonKey(
      name:
          'com.arlanto.atom.keyManagement.keyHandingOverDuration.moreThanOneday')
  final String? keyHandingOverDurationMoreThanOneday;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.doorLockKey.no')
  final String? doorLockKeyNo;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.employeeType')
  final String? employeeType;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.keyHandOverDue')
  final String? keyHandOverDue;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.doorName')
  final String? doorName;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.status.lost')
  final String? statusLost;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.status.damagedNotReturned')
  final String? statusDamagedNotReturned;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.status.notReturned')
  final String? statusNotReturned;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.status.open')
  final String? statusOpen;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.keyDescription')
  final String? keyDescription;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.damaged')
  final String? damaged;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.keyTagging.yes')
  final String? keyTaggingYes;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.employeeID')
  final String? employeeID;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.lostKeyDetails')
  final String? lostKeyDetails;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.keyNo')
  final String? keyNo;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.status.lostDamaged')
  final String? statusLostDamaged;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.keysDamaged')
  final String? keysDamaged;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.status.closedDamaged')
  final String? statusClosedDamaged;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.hasKeyLost.na')
  final String? hasKeyLostNa;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.additionalInformation')
  final String? additionalInformation;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.hasKeyLost.yes')
  final String? hasKeyLostYes;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.status.lostNotReturned')
  final String? statusLostNotReturned;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.keyStatus')
  final String? keyStatus;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.keyDestructionProcess.yes')
  final String? keyDestructionProcessYes;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.keyHandingOverDuration.daily')
  final String? keyHandingOverDurationDaily;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.lostMaster')
  final String? lostMaster;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.doorAccessControl.yes')
  final String? doorAccessControlYes;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.availableMaster')
  final String? availableMaster;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.keyStatus.holding')
  final String? keyStatusHolding;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.totalKeysReturned')
  final String? totalKeysReturned;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.modifiedBy')
  final String? modifiedBy;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.department.gre')
  final String? departmentGre;
  @JsonKey(
      name:
          'com.arlanto.atom.keyManagement.status.closedLostDamagedNotReturned')
  final String? statusClosedLostDamagedNotReturned;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.floor')
  final String? floor;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.status.draft')
  final String? statusDraft;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.totalAllocated')
  final String? totalAllocated;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.keyDestructionProcess.no')
  final String? keyDestructionProcessNo;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.physicallyReconcilied')
  final String? physicallyReconcilied;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.receiverSignAcceptance')
  final String? receiverSignAcceptance;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.keyDestructionProcess.na')
  final String? keyDestructionProcessNa;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.keyTagging')
  final String? keyTagging;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.hasKeyLost.reported')
  final String? hasKeyLostReported;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.noKeys')
  final String? noKeys;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.department.dept12')
  final String? departmentDept12;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.securitySign')
  final String? securitySign;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.hasLockChanged.no')
  final String? hasLockChangedNo;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.keysDesProcess')
  final String? keysDesProcess;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.haskeylost')
  final String? haskeylost;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.noKeysIssued')
  final String? noKeysIssued;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.keysReturned')
  final String? keysReturned;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.keyType')
  final String? keyType;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.total')
  final String? total;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.keysStored')
  final String? keysStored;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.alreadyIssued')
  final String? alreadyIssued;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.keyHandingOverDuration')
  final String? keyHandingOverDuration;
  @JsonKey(name: 'com.arlanto.atom.keyManagement.doorType')
  final String? doorType;

  KMUiLabelsLocale(
      this.slNo,
      this.criticalDoor,
      this.noKeysIssuedMaster,
      this.doorLockKeyYes,
      this.keys,
      this.hasLockChangedYes,
      this.biAnnualReconciliation,
      this.notReturned,
      this.locationRegion,
      this.keyNumber,
      this.departmentCorporateSecuriy,
      this.keyReturnDateTime,
      this.doorAccessControlNo,
      this.handedOverDate,
      this.returned,
      this.available,
      this.doorTypeRestrictedDoor,
      this.createdDate,
      this.employeeTypeFte,
      this.damagedMaster,
      this.entities,
      this.doorLockKey,
      this.returnedMaster,
      this.keyHandingOverDurationOneDay,
      this.keysNotReturned,
      this.statusLostDamagedNotReturned,
      this.lost,
      this.hasLockChanged,
      this.keyLostReportedSMNo,
      this.keyStatusMisplaced,
      this.createdBy,
      this.statusClosedLost,
      this.returnedByName,
      this.statusClosedLostNotReturned,
      this.keyTaggingNo,
      this.doorAccessControl,
      this.keyStatusHandedOver,
      this.statusClosedLostDamaged,
      this.notReturnedMaster,
      this.dbSponsorCwrT2,
      this.statusClosed,
      this.investigationRequired,
      this.noMasterKey,
      this.location,
      this.doorTypePerimeterDoor,
      this.status,
      this.srh,
      this.department,
      this.keysLost,
      this.employeeTypeCwrT1,
      this.employeeTypeCwrT2,
      this.statusReturned,
      this.keyIssProcess,
      this.doorTypeCommonDoor,
      this.statusHandedOver,
      this.masterKeys,
      this.handedOverTo,
      this.statusTotalDamage,
      this.keysAvailable,
      this.lsm,
      this.keyTaggingNa,
      this.modifiedDate,
      this.destructionReason,
      this.keyDestructionProcess,
      this.keyHandingOverDurationMoreThanOneday,
      this.doorLockKeyNo,
      this.employeeType,
      this.keyHandOverDue,
      this.doorName,
      this.statusLost,
      this.statusDamagedNotReturned,
      this.statusNotReturned,
      this.statusOpen,
      this.keyDescription,
      this.damaged,
      this.keyTaggingYes,
      this.employeeID,
      this.lostKeyDetails,
      this.keyNo,
      this.statusLostDamaged,
      this.keysDamaged,
      this.statusClosedDamaged,
      this.hasKeyLostNa,
      this.additionalInformation,
      this.hasKeyLostYes,
      this.statusLostNotReturned,
      this.keyStatus,
      this.keyDestructionProcessYes,
      this.keyHandingOverDurationDaily,
      this.lostMaster,
      this.doorAccessControlYes,
      this.availableMaster,
      this.keyStatusHolding,
      this.totalKeysReturned,
      this.modifiedBy,
      this.departmentGre,
      this.statusClosedLostDamagedNotReturned,
      this.floor,
      this.statusDraft,
      this.totalAllocated,
      this.keyDestructionProcessNo,
      this.physicallyReconcilied,
      this.receiverSignAcceptance,
      this.keyDestructionProcessNa,
      this.keyTagging,
      this.hasKeyLostReported,
      this.noKeys,
      this.departmentDept12,
      this.securitySign,
      this.hasLockChangedNo,
      this.keysDesProcess,
      this.haskeylost,
      this.noKeysIssued,
      this.keysReturned,
      this.keyType,
      this.total,
      this.keysStored,
      this.alreadyIssued,
      this.keyHandingOverDuration,
      this.doorType);

  factory KMUiLabelsLocale.fromJson(Map<String, dynamic> json) =>
      _$KMUiLabelsLocaleFromJson(json);

  Map<String, dynamic> toJson() => _$KMUiLabelsLocaleToJson(this);
}
