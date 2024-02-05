
import 'package:db_atom/src/models/base_object.dart';

import '../../../../../models/organisation.dart';
import '../../../../createfound/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'general_info_model.g.dart';

@JsonSerializable()
class EventProtectionGi  extends BaseObject{
  int? id;
  String? slNo;
  User? createdBy;
  String? inputDate;
  Organisation? location;
  Organisation? locationRegion;
  List<Organisation>? entities;
  int? status;
  String? modifiedBy;
  bool annualPowerShutdown;
  String? eventStartDate;
  String? eventEndDate;
  User? epManager1;
  User? epManager2;
  User? lsm1;
  String? lsm1ContactNo;
  User? lsm2;
  String? lsm2ContactNo;
  User? bu1;
  String? bu1ContactNo;
  User? bu2;
  String? bu2ContactNo;
  Organisation? requesterDepartment;
  List<String>? epOfficers;
  User? srh1;
  User? srh2;
  Organisation? bu1Dept;
  Organisation? bu2Dept;
  String? systemVendor1;
  String? systemVendor2;
  String? systemVendor3;
  String? systemVendor1ContactNo;
  String? systemVendor2ContactNo;
  String? systemVendor3ContactNo;
  bool extraSecurityDeployed;
  String? vendorId;
  String? guardingVendorPoc;
  int? securityOfficerCount;
  int? securityOfficerCountHrs;
  int? securitySupervisorCount;
  int? securitySupervisorCountHrs;
  int? securityGuardCount;
  int? securityGuardCountHrs;
  int? securityFacilitatorCount;
  int? securityFacilitatorCountHrs;
  List<Organisation>? proposedVendors;
  // Organisation? proposedVendors;
  double? budget;
  String? poNumber;

  EventProtectionGi({
    this.id,
    this.slNo,
    this.createdBy,
    this.inputDate,
    this.location,
    this.locationRegion,
    this.entities,
    this.status,
    this.modifiedBy,
    this.annualPowerShutdown = false,
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
    this.extraSecurityDeployed = false,
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
  });

  factory EventProtectionGi.fromJson(Map<String, dynamic> json) =>
      _$EventProtectionGiFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EventProtectionGiToJson(this);


}
