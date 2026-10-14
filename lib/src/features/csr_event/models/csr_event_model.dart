import '../../../../index.dart';

part 'csr_event_model.g.dart';

class CSREventResponse {
  final List<CSREventGiModel>? items;
  final int? totalCount;
  final int? currentPageNo;
  final int? totalPageCount;

  CSREventResponse({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  CSREventResponse.fromJson(Map<String, dynamic> json)
      : items = (json['data'] as List?)
            ?.map((dynamic e) =>
                CSREventGiModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        totalCount = json['totalCount'] as int?,
        currentPageNo = json['currentPageNo'] as int?,
        totalPageCount = json['totalPageCount'] as int?;

  Map<String, dynamic> toJson() => {
        'data': items?.map((e) => e.toJson()).toList(),
        'totalCount': totalCount,
        'currentPageNo': currentPageNo,
        'totalPageCount': totalPageCount
      };
}

@JsonSerializable()
class CSREventGiModel extends BaseObject {
  int? id;
  String? slNo;
  User? createdBy;
  String? inputDate;
  Organisation? location;
  Organisation? locationRegion;
  Organisation? locationType;
  List<Organisation>? entities;
  int? status;
  String? modifiedBy;
  bool eventType;
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
  List<String>? vendorPocName;
  List<String>?  vendorStaffList;
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
  String? eventName;
  String? eventLocation;
  int? totalAttendies;
  int? externalVipAttendance;
  String? vendorContactNo;
  // Organisation? proposedVendors;
  double? budget;
  String? poNumber;
  String? vendorCompanyName;
  ImageContent? map;
  bool? ambulanceStationed;
  bool? photographyApproved;
  List<ImageContent>? photographyApprovedProof;
  List<ImageContent>? vendorStaffDetails;
  int? mediaExposure;
  int? sensitiveInfoRisk;
  String? additionalInfo;
  List<AssistanceSuppModel>? commandSupport;


  CSREventGiModel({
    this.id,
    this.slNo,
    this.createdBy,
    this.inputDate,
    this.location,
    this.locationRegion,
    this.locationType,
    this.entities,
    this.status,
    this.modifiedBy,
    this.eventType = false,
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
    this.vendorPocName,
    this.vendorStaffList,
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
    this.eventName,
    this.eventLocation,
    this.totalAttendies,
    this.externalVipAttendance,
    this.vendorContactNo,
    this.vendorCompanyName,
    this.map,
    this.ambulanceStationed = false,
    this.photographyApproved = false,
    this.photographyApprovedProof,
    this.vendorStaffDetails,
    this.mediaExposure,
    this.sensitiveInfoRisk,
    this.additionalInfo,
    this.commandSupport
  });

  factory CSREventGiModel.fromJson(Map<String, dynamic> json) =>
      _$CSREventGiModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CSREventGiModelToJson(this);
}


class AssistanceSuppModel {
  int? id;
  int? type;
  String? contactNo;
  String? name;
  int? role;

  AssistanceSuppModel({
    this.id,
    this.type,
    this.contactNo,
    this.name,
    this.role
  });

  AssistanceSuppModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        type = json['type'] as int?,
        name= json['name'] as String?,
        contactNo= json['contactNo'] as String?,
        role = json['role'] as int?;

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'name':name,
    'contactNo':contactNo,
    'role':role,

  };
}
