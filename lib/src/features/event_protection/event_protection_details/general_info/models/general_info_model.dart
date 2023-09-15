import 'package:db_atom/src/models/entity.dart';

import '../../../../../models/department.dart';
import '../../../../../models/location.dart';
import '../../../../../models/location_region.dart';
import '../../../../createfound/models/get_user_model.dart';


// class EventProtectionGi {
//   EventProtectionGi({
//     this.slNo,
//     this.inputDate,
//     this.location,
//     this.locationRegion,
//     this.entities,
//     this.status,
//     this.modifiedBy,
//     this.annualPowerShutdown,
//     this.id,
//   });
//
//   int? id;
//   String? slNo;
//   String? inputDate;
//   Location? location;
//   LocationRegion? locationRegion;
//   List<Entity>? entities;
//   int? status;
//   String? modifiedBy;
//   bool? annualPowerShutdown;
//   Lsm1? lsm1;
//   String? lsm1ContactNo;
//   Lsm2? lsm2;
//   String? lsm2ContactNo;
//   Bu1? bu1;
//   String? bu1ContactNo;
//   Bu2? bu2;
//   String? bu2ContactNo;
//   Department? requesterDepartment;
//   String? epOfficers;
//   Srh1? srh1;
//   Srh1? srh2;
//   Department? bu1Dept;
//   Department? bu2Dept;
//   EpManager1? epManager1;
//   EpManager2? epManager2;
//   String? systemVendor1;
//   String? systemVendor2;
//   String? systemVendor3;
//   String? systemVendor1ContactNo;
//   String? systemVendor2ContactNo;
//   String? systemVendor3ContactNo;
//   String? vendor1Primary;
//   String? vendor1PrimaryContact;
//   String? vendor1Secondary;
//   String? vendor1SecondaryContact;
//   String? vendor2Primary;
//   String? vendor2PrimaryContact;
//   String? vendor2Secondary;
//   String? vendor2SecondaryContact;
//   String? vendor3Primary;
//   String? vendor3PrimaryContact;
//   String? vendor3Secondary;
//   String? vendor3SecondaryContact;
//   bool? extraSecurityDeployed;
//
//
//   EventProtectionGi.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     slNo = json['slNo'];
//     inputDate = json['inputDate'];
//     location = Location.fromJson(json['location']);
//     locationRegion = LocationRegion.fromJson(json['locationRegion']);
//     entities =
//         List.from(json['entities']).map((e) => Entity.fromJson(e)).toList();
//     status = json['status'];
//     modifiedBy = json['modifiedBy'];
//     annualPowerShutdown = json['annualPowerShutdown'];
//   }
//
//   Map<String, dynamic> toJson() {
//    _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['slNo'] = slNo;
//     _data['inputDate'] = inputDate;
//     _data['location'] = location?.toJson();
//     _data['locationRegion'] = locationRegion?.toJson();
//     _data['entities'] = entities?.map((e) => e.toJson()).toList();
//     _data['status'] = status;
//     _data['modifiedBy'] = modifiedBy;
//     _data['annualPowerShutdown'] = annualPowerShutdown;
//     return _data;
//   }
// }

// class EventProtectionGi {
//  EpGi? epGi;
//
//   EventProtectionGi({
//     this.epGi,
//   });
//
//   EventProtectionGi.fromJson(Map<String, dynamic> json)
//       : epGi = (json['epGi'] as Map<String,dynamic>?) != null ? EpGi.fromJson(json['epGi'] as Map<String,dynamic>) : null;
//
//   Map<String, dynamic> toJson() => {
//     'epGi' : epGi?.toJson()
//   };
// }

class EventProtectionGi {
 int? id;
 String? slNo;
 String? inputDate;
 Location? location;
 LocationRegion? locationRegion;
 List<Entity>? entities;
 int? status;
 String? modifiedBy;
 bool annualPowerShutdown;
 String? eventStartDate;
 String? eventEndDate;
 GetUserDetails? epManager1;
 GetUserDetails? epManager2;
 GetUserDetails? lsm1;
 String? lsm1ContactNo;
 GetUserDetails? lsm2;
 String? lsm2ContactNo;
 GetUserDetails? bu1;
 String? bu1ContactNo;
 GetUserDetails? bu2;
 String? bu2ContactNo;
 Department? requesterDepartment;
 String? epOfficers;
 GetUserDetails? srh1;
 GetUserDetails? srh2;
 Department? bu1Dept;
 Department? bu2Dept;
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
 List<Department>? proposedVendors;
 double? budget;
 String? poNumber;

  EventProtectionGi({
    this.id,
    this.slNo,
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
    this.extraSecurityDeployed =false,
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

  EventProtectionGi.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        slNo = json['slNo'] as String?,
        inputDate = json['inputDate'] as String?,
        location = (json['location'] as Map<String,dynamic>?) != null ? Location.fromJson(json['location'] as Map<String,dynamic>) : null,
        locationRegion = (json['locationRegion'] as Map<String,dynamic>?) != null ? LocationRegion.fromJson(json['locationRegion'] as Map<String,dynamic>) : null,
        entities = (json['entities'] as List?)?.map((dynamic e) => Entity.fromJson(e as Map<String,dynamic>)).toList(),
        status = json['status'] as int?,
        modifiedBy = json['modifiedBy'] as String?,
        annualPowerShutdown = json['annualPowerShutdown'] as bool,
        eventStartDate = json['eventStartDate'] as String?,
        eventEndDate = json['eventEndDate'] as String?,
        epManager1 = (json['epManager1'] as Map<String,dynamic>?) != null ? GetUserDetails.fromJson(json['epManager1'] as Map<String,dynamic>) : null,
        epManager2 = (json['epManager2'] as Map<String,dynamic>?) != null ? GetUserDetails.fromJson(json['epManager2'] as Map<String,dynamic>) : null,
        lsm1 = (json['lsm1'] as Map<String,dynamic>?) != null ? GetUserDetails.fromJson(json['lsm1'] as Map<String,dynamic>) : null,
        lsm1ContactNo = json['lsm1ContactNo'] as String?,
        lsm2 = (json['lsm2'] as Map<String,dynamic>?) != null ? GetUserDetails.fromJson(json['lsm2'] as Map<String,dynamic>) : null,
        lsm2ContactNo = json['lsm2ContactNo'] as String?,
        bu1 = (json['bu1'] as Map<String,dynamic>?) != null ? GetUserDetails.fromJson(json['bu1'] as Map<String,dynamic>) : null,
        bu1ContactNo = json['bu1ContactNo'] as String?,
        bu2 = (json['bu2'] as Map<String,dynamic>?) != null ? GetUserDetails.fromJson(json['bu2'] as Map<String,dynamic>) : null,
        bu2ContactNo = json['bu2ContactNo'] as String?,
        requesterDepartment = (json['requesterDepartment'] as Map<String,dynamic>?) != null ? Department.fromJson(json['requesterDepartment'] as Map<String,dynamic>) : null,
        epOfficers = json['epOfficers'] as String?,
        srh1 = (json['srh1'] as Map<String,dynamic>?) != null ? GetUserDetails.fromJson(json['srh1'] as Map<String,dynamic>) : null,
        srh2 = (json['srh2'] as Map<String,dynamic>?) != null ? GetUserDetails.fromJson(json['srh2'] as Map<String,dynamic>) : null,
        bu1Dept = (json['bu1Dept'] as Map<String,dynamic>?) != null ? Department.fromJson(json['bu1Dept'] as Map<String,dynamic>) : null,
        bu2Dept = (json['bu2Dept'] as Map<String,dynamic>?) != null ? Department.fromJson(json['bu2Dept'] as Map<String,dynamic>) : null,
        systemVendor1 = json['systemVendor1'] as String?,
        systemVendor2 = json['systemVendor2'] as String?,
        systemVendor3 = json['systemVendor3'] as String?,
        systemVendor1ContactNo = json['systemVendor1ContactNo'] as String?,
        systemVendor2ContactNo = json['systemVendor2ContactNo'] as String?,
        systemVendor3ContactNo = json['systemVendor3ContactNo'] as String?,
        extraSecurityDeployed = json['extraSecurityDeployed'] as bool,
        vendorId = json['vendorId'] as String?,
        guardingVendorPoc = json['guardingVendorPoc'] as String?,
        securityOfficerCount = json['securityOfficerCount'] as int?,
        securityOfficerCountHrs = json['securityOfficerCountHrs'] as int?,
        securitySupervisorCount = json['securitySupervisorCount'] as int?,
        securitySupervisorCountHrs = json['securitySupervisorCountHrs'] as int?,
        securityGuardCount = json['securityGuardCount'] as int?,
        securityGuardCountHrs = json['securityGuardCountHrs'] as int?,
        securityFacilitatorCount = json['securityFacilitatorCount'] as int?,
        securityFacilitatorCountHrs = json['securityFacilitatorCountHrs'] as int?,
        proposedVendors = (json['proposedVendors'] as List?)?.map((dynamic e) => Department.fromJson(e as Map<String,dynamic>)).toList(),
        budget = json['budget'] as double?,
        poNumber = json['poNumber'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'slNo' : slNo,
    'inputDate' : inputDate,
    'location' : location?.toJson(),
    'locationRegion' : locationRegion?.toJson(),
    'entities' : entities?.map((e) => e.toJson()).toList(),
    'status' : status,
    'modifiedBy' : modifiedBy,
    'annualPowerShutdown' : annualPowerShutdown,
    'eventStartDate' : eventStartDate,
    'eventEndDate' : eventEndDate,
    'epManager1' : epManager1?.toJson(),
    'epManager2' : epManager2?.toJson(),
    'lsm1' : lsm1?.toJson(),
    'lsm1ContactNo' : lsm1ContactNo,
    'lsm2' : lsm2?.toJson(),
    'lsm2ContactNo' : lsm2ContactNo,
    'bu1' : bu1?.toJson(),
    'bu1ContactNo' : bu1ContactNo,
    'bu2' : bu2?.toJson(),
    'bu2ContactNo' : bu2ContactNo,
    'requesterDepartment' : requesterDepartment?.toJson(),
    'epOfficers' : epOfficers,
    'srh1' : srh1?.toJson(),
    'srh2' : srh2?.toJson(),
    'bu1Dept' : bu1Dept?.toJson(),
    'bu2Dept' : bu2Dept?.toJson(),
    'systemVendor1' : systemVendor1,
    'systemVendor2' : systemVendor2,
    'systemVendor3' : systemVendor3,
    'systemVendor1ContactNo' : systemVendor1ContactNo,
    'systemVendor2ContactNo' : systemVendor2ContactNo,
    'systemVendor3ContactNo' : systemVendor3ContactNo,
    'extraSecurityDeployed' : extraSecurityDeployed,
    'vendorId' : vendorId,
    'guardingVendorPoc' : guardingVendorPoc,
    'securityOfficerCount' : securityOfficerCount,
    'securityOfficerCountHrs' : securityOfficerCountHrs,
    'securitySupervisorCount' : securitySupervisorCount,
    'securitySupervisorCountHrs' : securitySupervisorCountHrs,
    'securityGuardCount' : securityGuardCount,
    'securityGuardCountHrs' : securityGuardCountHrs,
    'securityFacilitatorCount' : securityFacilitatorCount,
    'securityFacilitatorCountHrs' : securityFacilitatorCountHrs,
    'proposedVendors' : proposedVendors?.map((e) => e.toJson()).toList(),
    'budget' : budget,
    'poNumber' : poNumber
  };
}








