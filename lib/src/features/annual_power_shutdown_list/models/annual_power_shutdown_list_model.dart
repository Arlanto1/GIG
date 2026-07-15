import '../../../../index.dart';

part 'annual_power_shutdown_list_model.g.dart';

class AnnualPowerShutdownListResponse {
  List<AnnualPowerShutdownListModel>? items;
  int? totalCount;
  int? currentPageNo;
  int? totalPageCount;

  AnnualPowerShutdownListResponse({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  AnnualPowerShutdownListResponse.fromJson(Map<String, dynamic> json)
      : items = (json['data'] as List?)
            ?.map((dynamic e) => AnnualPowerShutdownListModel.fromJson(
                e as Map<String, dynamic>))
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
class AnnualPowerShutdownListModel extends BaseObject {
  int? id;
  String? slNo;
  String? inputDate;
  Organisation? location;
  Organisation? locationRegion;
  List<Organisation>? entities;
  int? status;
  User? createdBy;
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
  String? vendor1Primary;
  String? vendor1PrimaryContact;
  String? vendor1Secondary;
  String? vendor1SecondaryContact;
  String? vendor2Primary;
  String? vendor2PrimaryContact;
  String? vendor2Secondary;
  String? vendor2SecondaryContact;
  String? vendor3Primary;
  String? vendor3PrimaryContact;
  String? vendor3Secondary;
  String? vendor3SecondaryContact;
  List<EventProtectionGuardsInfos>? eventProtectionGuardsInfos;


  AnnualPowerShutdownListModel({
    this.id,
    this.slNo,
    this.inputDate,
    this.location,
    this.createdBy,
    this.locationRegion,
    this.entities,
    this.status,
    this.modifiedBy,
    this.annualPowerShutdown = true,
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
    this.vendor1Primary,
    this.vendor1PrimaryContact,
    this.vendor1Secondary,
    this.vendor1SecondaryContact,
    this.vendor2Primary,
    this.vendor2PrimaryContact,
    this.vendor2Secondary,
    this.vendor2SecondaryContact,
    this.vendor3Primary,
    this.vendor3PrimaryContact,
    this.vendor3Secondary,
    this.vendor3SecondaryContact,
    this.eventProtectionGuardsInfos,
  });

  factory AnnualPowerShutdownListModel.fromJson(Map<String, dynamic> json) =>
      _$AnnualPowerShutdownListModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AnnualPowerShutdownListModelToJson(this);
}


class EventProtectionGuardsInfos {
  EventProtectionGuardsInfos({
     this.id,
     this.staffCategory,
     this.staffCategoryCount,
     this.totalDutyHours,
     this.totalCost,
  });
    int? id;
    int? staffCategory;
    int? staffCategoryCount;
    int? totalDutyHours;
    double? totalCost;

  EventProtectionGuardsInfos.fromJson(Map<String, dynamic> json){
    id = json['id'];
    staffCategory = json['staffCategory'];
    staffCategoryCount = json['staffCategoryCount'];
    totalDutyHours = json['totalDutyHours'];
    totalCost = json['totalCost'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['staffCategory'] = staffCategory;
    _data['staffCategoryCount'] = staffCategoryCount;
    _data['totalDutyHours'] = totalDutyHours;
    _data['totalCost'] = totalCost;
    return _data;
  }
}