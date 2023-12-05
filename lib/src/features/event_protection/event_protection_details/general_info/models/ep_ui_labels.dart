import 'package:json_annotation/json_annotation.dart';

part 'ep_ui_labels.g.dart';

@JsonSerializable()
class EpUiLabels {
  EpUiLabels({
    required this.defaultLocale,
    required this.locale,
  });

  factory EpUiLabels.fromJson(Map<String, dynamic> json) =>
      _$EpUiLabelsFromJson(json);

  Map<String, dynamic> toJson() => _$EpUiLabelsToJson(this);

  @JsonKey(name: 'locale')
  final EpUiLabelsLocale locale;
  @JsonKey(name: 'default')
  final EpUiLabelsLocale defaultLocale;
}

@JsonSerializable()
class EpUiLabelsLocale {
  @JsonKey(name: 'com.arlanto.atom.eventProtection.slNo')
  final String? slNo;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.inputDate')
  final String? inputDate;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.status')
  final String? status;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.locationRegion')
  final String? locationRegion;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.location')
  final String? location;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.entity')
  final String? entity;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.annualPowerShutdown')
  final String? annualPowerShutdown;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.eventStartDate')
  final String? eventStartDate;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.eventEndDate')
  final String? eventEndDate;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.epManager1')
  final String? epManager1;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.epManager2')
  final String? epManager2;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.lsm1')
  final String? lsm1;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.lsm2')
  final String? lsm2;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.lsm1ContactNo')
  final String? lsm1ContactNo;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.lsm2ContactNo')
  final String? lsm2ContactNo;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.bu1')
  final String? bu1;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.bu2')
  final String? bu2;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.bu1ContactNo')
  final String? bu1ContactNo;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.bu2ContactNo')
  final String? bu2ContactNo;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.requesterDepartment')
  final String? requesterDepartment;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.epOfficers')
  final String? epOfficers;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.srh1')
  final String? srh1;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.srh2')
  final String? srh2;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.bu1Dept')
  final String? bu1Dept;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.bu2Dept')
  final String? bu2Dept;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.systemVendor1')
  final String? systemVendor1;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.systemVendor2')
  final String? systemVendor2;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.systemVendor3')
  final String? systemVendor3;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.systemVendor1ContactNo')
  final String? systemVendor1ContactNo;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.systemVendor2ContactNo')
  final String? systemVendor2ContactNo;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.systemVendor3ContactNo')
  final String? systemVendor3ContactNo;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.extraSecurityDeployed')
  final String? extraSecurityDeployed;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.vendorId')
  final String? vendorId;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.guardingVendorPoc')
  final String? guardingVendorPoc;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityOfficerCount')
  final String? securityOfficerCount;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityOfficerCountHrs')
  final String? securityOfficerCountHrs;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.securitySupervisorCount')
  final String? securitySupervisorCount;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.securitySupervisorCountHrs')
  final String? securitySupervisorCountHrs;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityGuardCount')
  final String? securityGuardCount;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityGuardCountHrs')
  final String? securityGuardCountHrs;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityFacilitatorCount')
  final String? securityFacilitatorCount;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityFacilitatorCountHrs')
  final String? securityFacilitatorCountHrs;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.proposedVendors')
  final String? proposedVendors;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.budget')
  final String? budget;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.poNumber')
  final String? poNumber;

  EpUiLabelsLocale(
    this.slNo,
    this.inputDate,
    this.location,
    this.locationRegion,
    this.entity,
    this.status,
    this.annualPowerShutdown,
    this.eventStartDate,
    this.eventEndDate,
    this.epManager1,
    this.epManager2,
    this.lsm1,
    this.lsm1ContactNo,
    this.lsm2,
    this.lsm2ContactNo,
    this.bu1,
    this.bu1ContactNo,
    this.bu2,
    this.bu2ContactNo,
    this.requesterDepartment,
    this.epOfficers,
    this.srh1,
    this.srh2,
    this.bu1Dept,
    this.bu2Dept,
    this.systemVendor1,
    this.systemVendor2,
    this.systemVendor3,
    this.systemVendor1ContactNo,
    this.systemVendor2ContactNo,
    this.systemVendor3ContactNo,
    this.extraSecurityDeployed,
    this.vendorId,
    this.guardingVendorPoc,
    this.securityOfficerCount,
    this.securityOfficerCountHrs,
    this.securitySupervisorCount,
    this.securitySupervisorCountHrs,
    this.securityGuardCount,
    this.securityGuardCountHrs,
    this.securityFacilitatorCount,
    this.securityFacilitatorCountHrs,
    this.proposedVendors,
    this.budget,
    this.poNumber,
  );

  factory EpUiLabelsLocale.fromJson(Map<String, dynamic> json) =>
      _$EpUiLabelsLocaleFromJson(json);

  Map<String, dynamic> toJson() => _$EpUiLabelsLocaleToJson(this);
}
