// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'csr_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CSREventGiModel _$CSREventGiModelFromJson(Map<String, dynamic> json) =>
    CSREventGiModel(
      id: (json['id'] as num?)?.toInt(),
      slNo: json['slNo'] as String?,
      createdBy: json['createdBy'] == null
          ? null
          : User.fromJson(json['createdBy'] as Map<String, dynamic>),
      inputDate: json['inputDate'] as String?,
      location: json['location'] == null
          ? null
          : Organisation.fromJson(json['location'] as Map<String, dynamic>),
      locationRegion: json['locationRegion'] == null
          ? null
          : Organisation.fromJson(
              json['locationRegion'] as Map<String, dynamic>),
      entities: (json['entities'] as List<dynamic>?)
          ?.map((e) => Organisation.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: (json['status'] as num?)?.toInt(),
      modifiedBy: json['modifiedBy'] as String?,
      eventType: json['eventType'] as bool? ?? false,
      eventStartDate: json['eventStartDate'] as String?,
      eventEndDate: json['eventEndDate'] as String?,
      epManager1: json['epManager1'] == null
          ? null
          : User.fromJson(json['epManager1'] as Map<String, dynamic>),
      epManager2: json['epManager2'] == null
          ? null
          : User.fromJson(json['epManager2'] as Map<String, dynamic>),
      lsm1: json['lsm1'] == null
          ? null
          : User.fromJson(json['lsm1'] as Map<String, dynamic>),
      lsm1ContactNo: json['lsm1ContactNo'] as String?,
      lsm2: json['lsm2'] == null
          ? null
          : User.fromJson(json['lsm2'] as Map<String, dynamic>),
      lsm2ContactNo: json['lsm2ContactNo'] as String?,
      bu1: json['bu1'] == null
          ? null
          : User.fromJson(json['bu1'] as Map<String, dynamic>),
      bu1ContactNo: json['bu1ContactNo'] as String?,
      bu2: json['bu2'] == null
          ? null
          : User.fromJson(json['bu2'] as Map<String, dynamic>),
      bu2ContactNo: json['bu2ContactNo'] as String?,
      requesterDepartment: json['requesterDepartment'] == null
          ? null
          : Organisation.fromJson(
              json['requesterDepartment'] as Map<String, dynamic>),
      vendorPocName: json['vendorPocName'] as String?,
      vendorStaffList: json['vendorStaffList'] as String?,
      srh1: json['srh1'] == null
          ? null
          : User.fromJson(json['srh1'] as Map<String, dynamic>),
      srh2: json['srh2'] == null
          ? null
          : User.fromJson(json['srh2'] as Map<String, dynamic>),
      bu1Dept: json['bu1Dept'] == null
          ? null
          : Organisation.fromJson(json['bu1Dept'] as Map<String, dynamic>),
      bu2Dept: json['bu2Dept'] == null
          ? null
          : Organisation.fromJson(json['bu2Dept'] as Map<String, dynamic>),
      systemVendor1: json['systemVendor1'] as String?,
      systemVendor2: json['systemVendor2'] as String?,
      systemVendor3: json['systemVendor3'] as String?,
      systemVendor1ContactNo: json['systemVendor1ContactNo'] as String?,
      systemVendor2ContactNo: json['systemVendor2ContactNo'] as String?,
      systemVendor3ContactNo: json['systemVendor3ContactNo'] as String?,
      extraSecurityDeployed: json['extraSecurityDeployed'] as bool? ?? false,
      vendorId: json['vendorId'] as String?,
      guardingVendorPoc: json['guardingVendorPoc'] as String?,
      securityOfficerCount: (json['securityOfficerCount'] as num?)?.toInt(),
      securityOfficerCountHrs:
          (json['securityOfficerCountHrs'] as num?)?.toInt(),
      securitySupervisorCount:
          (json['securitySupervisorCount'] as num?)?.toInt(),
      securitySupervisorCountHrs:
          (json['securitySupervisorCountHrs'] as num?)?.toInt(),
      securityGuardCount: (json['securityGuardCount'] as num?)?.toInt(),
      securityGuardCountHrs: (json['securityGuardCountHrs'] as num?)?.toInt(),
      securityFacilitatorCount:
          (json['securityFacilitatorCount'] as num?)?.toInt(),
      securityFacilitatorCountHrs:
          (json['securityFacilitatorCountHrs'] as num?)?.toInt(),
      proposedVendors: (json['proposedVendors'] as List<dynamic>?)
          ?.map((e) => Organisation.fromJson(e as Map<String, dynamic>))
          .toList(),
      budget: (json['budget'] as num?)?.toDouble(),
      poNumber: json['poNumber'] as String?,
      eventName: json['eventName'] as String?,
      eventLocation: json['eventLocation'] as String?,
      totalAttendies: (json['totalAttendies'] as num?)?.toInt(),
      externalVipAttendance: (json['externalVipAttendance'] as num?)?.toInt(),
      vendorContactNo: json['vendorContactNo'] as String?,
      vendorCompanyName: json['vendorCompanyName'] as String?,
      map: json['map'] == null
          ? null
          : MapImage.fromJson(json['map'] as Map<String, dynamic>),
    )..lock = json['lock'] as String?;

Map<String, dynamic> _$CSREventGiModelToJson(CSREventGiModel instance) =>
    <String, dynamic>{
      'lock': instance.lock,
      'id': instance.id,
      'slNo': instance.slNo,
      'createdBy': instance.createdBy,
      'inputDate': instance.inputDate,
      'location': instance.location,
      'locationRegion': instance.locationRegion,
      'entities': instance.entities,
      'status': instance.status,
      'modifiedBy': instance.modifiedBy,
      'eventType': instance.eventType,
      'eventStartDate': instance.eventStartDate,
      'eventEndDate': instance.eventEndDate,
      'epManager1': instance.epManager1,
      'epManager2': instance.epManager2,
      'lsm1': instance.lsm1,
      'lsm1ContactNo': instance.lsm1ContactNo,
      'lsm2': instance.lsm2,
      'lsm2ContactNo': instance.lsm2ContactNo,
      'bu1': instance.bu1,
      'bu1ContactNo': instance.bu1ContactNo,
      'bu2': instance.bu2,
      'bu2ContactNo': instance.bu2ContactNo,
      'requesterDepartment': instance.requesterDepartment,
      'vendorPocName': instance.vendorPocName,
      'vendorStaffList': instance.vendorStaffList,
      'srh1': instance.srh1,
      'srh2': instance.srh2,
      'bu1Dept': instance.bu1Dept,
      'bu2Dept': instance.bu2Dept,
      'systemVendor1': instance.systemVendor1,
      'systemVendor2': instance.systemVendor2,
      'systemVendor3': instance.systemVendor3,
      'systemVendor1ContactNo': instance.systemVendor1ContactNo,
      'systemVendor2ContactNo': instance.systemVendor2ContactNo,
      'systemVendor3ContactNo': instance.systemVendor3ContactNo,
      'extraSecurityDeployed': instance.extraSecurityDeployed,
      'vendorId': instance.vendorId,
      'guardingVendorPoc': instance.guardingVendorPoc,
      'securityOfficerCount': instance.securityOfficerCount,
      'securityOfficerCountHrs': instance.securityOfficerCountHrs,
      'securitySupervisorCount': instance.securitySupervisorCount,
      'securitySupervisorCountHrs': instance.securitySupervisorCountHrs,
      'securityGuardCount': instance.securityGuardCount,
      'securityGuardCountHrs': instance.securityGuardCountHrs,
      'securityFacilitatorCount': instance.securityFacilitatorCount,
      'securityFacilitatorCountHrs': instance.securityFacilitatorCountHrs,
      'proposedVendors': instance.proposedVendors,
      'eventName': instance.eventName,
      'eventLocation': instance.eventLocation,
      'totalAttendies': instance.totalAttendies,
      'externalVipAttendance': instance.externalVipAttendance,
      'vendorContactNo': instance.vendorContactNo,
      'budget': instance.budget,
      'poNumber': instance.poNumber,
      'vendorCompanyName': instance.vendorCompanyName,
      'map': instance.map,
    };
