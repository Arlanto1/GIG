part of 'general_info_model.dart';


EventProtectionGi _$EventProtectionGiFromJson(
    Map<String, dynamic> json) =>
    EventProtectionGi(
      id : json['id'] as int?,
      slNo : json['slNo'] as String?,
      inputDate : json['inputDate'] as String?,
      location : (json['location'] as Map<String, dynamic>?) != null
          ? Organisation.fromJson(json['location'] as Map<String, dynamic>)
          : null,
      locationRegion :
      (json['locationRegion'] as Map<String, dynamic>?) != null
          ? Organisation.fromJson(
          json['locationRegion'] as Map<String, dynamic>)
          : null,
      entities : (json['entities'] as List?)
          ?.map((dynamic e) => Organisation.fromJson(e as Map<String, dynamic>))
          .toList(),
      proposedVendors : (json['proposedVendors'] as List?)
          ?.map((dynamic e) => Organisation.fromJson(e as Map<String, dynamic>))
          .toList(),
      status : json['status'] as int?,
      modifiedBy : json['modifiedBy'] as String?,
      annualPowerShutdown : json['annualPowerShutdown'] as bool,
      eventStartDate : json['eventStartDate'] as String?,
      eventEndDate : json['eventEndDate'] as String?,
      epManager1 : (json['epManager1'] as Map<String, dynamic>?) != null
          ? User.fromJson(json['epManager1'] as Map<String, dynamic>)
          : null,
      epManager2 : (json['epManager2'] as Map<String, dynamic>?) != null
          ? User.fromJson(json['epManager2'] as Map<String, dynamic>)
          : null,
      lsm1 : (json['lsm1'] as Map<String, dynamic>?) != null
          ? User.fromJson(json['lsm1'] as Map<String, dynamic>)
          : null,
      lsm1ContactNo : json['lsm1ContactNo'] as String?,
      lsm2 : (json['lsm2'] as Map<String, dynamic>?) != null
          ? User.fromJson(json['lsm2'] as Map<String, dynamic>)
          : null,
      lsm2ContactNo : json['lsm2ContactNo'] as String?,
      bu1 : (json['bu1'] as Map<String, dynamic>?) != null
          ? User.fromJson(json['bu1'] as Map<String, dynamic>)
          : null,
      bu1ContactNo : json['bu1ContactNo'] as String?,
      bu2 : (json['bu2'] as Map<String, dynamic>?) != null
          ? User.fromJson(json['bu2'] as Map<String, dynamic>)
          : null,
      bu2ContactNo : json['bu2ContactNo'] as String?,
      requesterDepartment :
      (json['requesterDepartment'] as Map<String, dynamic>?) != null
          ? Organisation.fromJson(
          json['requesterDepartment'] as Map<String, dynamic>)
          : null,
      epOfficers : (json['epOfficers'] as List?)
          ?.map((dynamic e) => e as String)
          .toList(),
      srh1 : (json['srh1'] as Map<String, dynamic>?) != null
          ? User.fromJson(json['srh1'] as Map<String, dynamic>)
          : null,
      srh2 : (json['srh2'] as Map<String, dynamic>?) != null
          ? User.fromJson(json['srh2'] as Map<String, dynamic>)
          : null,
      bu1Dept : (json['bu1Dept'] as Map<String, dynamic>?) != null
          ? Organisation.fromJson(json['bu1Dept'] as Map<String, dynamic>)
          : null,
      bu2Dept : (json['bu2Dept'] as Map<String, dynamic>?) != null
          ? Organisation.fromJson(json['bu2Dept'] as Map<String, dynamic>)
          : null,
      systemVendor1 : json['systemVendor1'] as String?,
      systemVendor2 : json['systemVendor2'] as String?,
      systemVendor3 : json['systemVendor3'] as String?,
      systemVendor1ContactNo : json['systemVendor1ContactNo'] as String?,
      systemVendor2ContactNo : json['systemVendor2ContactNo'] as String?,
      systemVendor3ContactNo : json['systemVendor3ContactNo'] as String?,
      extraSecurityDeployed : json['extraSecurityDeployed'] as bool,
      vendorId : json['vendorId'] as String?,
      guardingVendorPoc : json['guardingVendorPoc'] as String?,
      securityOfficerCount : json['securityOfficerCount'] as int?,
      securityOfficerCountHrs : json['securityOfficerCountHrs'] as int?,
      securitySupervisorCount : json['securitySupervisorCount'] as int?,
      securitySupervisorCountHrs : json['securitySupervisorCountHrs'] as int?,
      securityGuardCount : json['securityGuardCount'] as int?,
      securityGuardCountHrs : json['securityGuardCountHrs'] as int?,
      securityFacilitatorCount : json['securityFacilitatorCount'] as int?,
      securityFacilitatorCountHrs :
      json['securityFacilitatorCountHrs'] as int?,
// proposedVendors = (json['proposedVendors'] as Map<String, dynamic>?) != null
//   ? Organisation.fromJson(json['proposedVendors'] as Map<String, dynamic>)
//   : null,
      budget : json['budget'] as double?,
      poNumber : json['poNumber'] as String?,
    )..lock = json['lock'] as String?;

Map<String, dynamic> _$EventProtectionGiToJson(
    EventProtectionGi instance) =>
    <String, dynamic>{
      'lock': instance.lock,
      'id':instance. id,
      'slNo': instance.slNo,
      'inputDate': instance.inputDate,
      'location':instance. location?.toJson(),
      'locationRegion': instance.locationRegion?.toJson(),
      'entities': instance.entities?.map((e) => e.toJson()).toList(),
      'proposedVendors': instance.proposedVendors?.map((e) => e.toJson()).toList(),
      'status': instance.status,
      'modifiedBy':instance. modifiedBy,
      'annualPowerShutdown': instance.annualPowerShutdown,
      'eventStartDate': instance.eventStartDate,
      'eventEndDate': instance.eventEndDate,
      'epManager1':instance. epManager1?.toJson(),
      'epManager2':instance. epManager2?.toJson(),
      'lsm1': instance.lsm1?.toJson(),
      'lsm1ContactNo': instance.lsm1ContactNo,
      'lsm2': instance.lsm2?.toJson(),
      'lsm2ContactNo': instance.lsm2ContactNo,
      'bu1': instance.bu1?.toJson(),
      'bu1ContactNo':instance.bu1ContactNo,
      'bu2':instance. bu2?.toJson(),
      'bu2ContactNo': instance.bu2ContactNo,
      'requesterDepartment':instance. requesterDepartment?.toJson(),
      'epOfficers': instance.epOfficers,
      'srh1':instance. srh1?.toJson(),
      'srh2': instance.srh2?.toJson(),
      'bu1Dept': instance.bu1Dept?.toJson(),
      'bu2Dept': instance.bu2Dept?.toJson(),
      'systemVendor1': instance.systemVendor1,
      'systemVendor2': instance.systemVendor2,
      'systemVendor3':instance. systemVendor3,
      'systemVendor1ContactNo': instance.systemVendor1ContactNo,
      'systemVendor2ContactNo': instance.systemVendor2ContactNo,
      'systemVendor3ContactNo':instance. systemVendor3ContactNo,
      'extraSecurityDeployed': instance.extraSecurityDeployed,
      'vendorId': instance.vendorId,
      'guardingVendorPoc': instance.guardingVendorPoc,
      'securityOfficerCount':instance. securityOfficerCount,
      'securityOfficerCountHrs':instance.securityOfficerCountHrs,
      'securitySupervisorCount': instance.securitySupervisorCount,
      'securitySupervisorCountHrs': instance.securitySupervisorCountHrs,
      'securityGuardCount': instance.securityGuardCount,
      'securityGuardCountHrs': instance.securityGuardCountHrs,
      'securityFacilitatorCount':instance. securityFacilitatorCount,
      'securityFacilitatorCountHrs': instance.securityFacilitatorCountHrs,
// 'proposedVendors': proposedVendors?.toJson(),
      'budget': instance.budget,
      'poNumber':instance. poNumber
    };