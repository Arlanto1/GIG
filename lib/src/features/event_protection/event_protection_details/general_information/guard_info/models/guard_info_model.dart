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
  List<ProposedVendors>? proposedVendors;
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
        .map((e) => ProposedVendors.fromJson(e))
        .toList();
    budget = json['budget'];
    poNumber = json['poNumber'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['status'] = status;
    _data['vendorId'] = vendorId;
    _data['guardingVendorPoc'] = guardingVendorPoc;
    _data['securityOfficerCount'] = securityOfficerCount;
    _data['securityOfficerCountHrs'] = securityOfficerCountHrs;
    _data['securitySupervisorCount'] = securitySupervisorCount;
    _data['securitySupervisorCountHrs'] = securitySupervisorCountHrs;
    _data['securityGuardCount'] = securityGuardCount;
    _data['securityGuardCountHrs'] = securityGuardCountHrs;
    _data['securityFacilitatorCount'] = securityFacilitatorCount;
    _data['securityFacilitatorCountHrs'] = securityFacilitatorCountHrs;
    _data['proposedVendors'] = proposedVendors?.map((e) => e.toJson()).toList();
    _data['budget'] = budget;
    _data['poNumber'] = poNumber;
    return _data;
  }
}

class ProposedVendors {
  ProposedVendors({
    required this.id,
    required this.name,
  });

  late final int id;
  late final String name;

  ProposedVendors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}
