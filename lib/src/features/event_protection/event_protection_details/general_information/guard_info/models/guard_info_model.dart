import '../../../../../../models/organisation.dart';

class GuardInfoModel {
  GuardInfoModel({
    this.id,
    this.status,
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

  int? id;
  int? status;
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
  double? budget;
  String? poNumber;

  GuardInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    vendorId = json['vendorId'];
    guardingVendorPoc = json['guardingVendorPoc'];
    securityOfficerCount = json['securityOfficerCount'];
    securityOfficerCountHrs = json['securityOfficerCountHrs'];
    securitySupervisorCount = json['securitySupervisorCount'];
    securitySupervisorCountHrs = json['securitySupervisorCountHrs'];
    securityGuardCount = json['securityGuardCount'];
    securityGuardCountHrs = json['securityGuardCountHrs'];
    securityFacilitatorCount = json['securityFacilitatorCount'];
    securityFacilitatorCountHrs = json['securityFacilitatorCountHrs'];
    proposedVendors = List.from(json['proposedVendors'])
        .map((e) => Organisation.fromJson(e))
        .toList();
    budget = json['budget'];
    poNumber = json['poNumber'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['vendorId'] = vendorId;
    data['guardingVendorPoc'] = guardingVendorPoc;
    data['securityOfficerCount'] = securityOfficerCount;
    data['securityOfficerCountHrs'] = securityOfficerCountHrs;
    data['securitySupervisorCount'] = securitySupervisorCount;
    data['securitySupervisorCountHrs'] = securitySupervisorCountHrs;
    data['securityGuardCount'] = securityGuardCount;
    data['securityGuardCountHrs'] = securityGuardCountHrs;
    data['securityFacilitatorCount'] = securityFacilitatorCount;
    data['securityFacilitatorCountHrs'] = securityFacilitatorCountHrs;
    data['proposedVendors'] = proposedVendors?.map((e) => e.toJson()).toList();
    data['budget'] = budget;
    data['poNumber'] = poNumber;
    return data;
  }
}

