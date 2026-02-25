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
  String? vendorPocName;
  String? vendorStaffList;
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
  MapImage? map;

  CSREventGiModel({
    this.id,
    this.slNo,
    this.createdBy,
    this.inputDate,
    this.location,
    this.locationRegion,
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
  });

  factory CSREventGiModel.fromJson(Map<String, dynamic> json) =>
      _$CSREventGiModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CSREventGiModelToJson(this);
}


class MapImage {
  MapImage({
    required this.id,
    required this.ownerName,
    required this.contentType,
    required this.uploadDate,
    required this.title,
    required this.eventProtectionId,
    required this.type,
    required this.deletable,
    required this.imageStreamData,
    required this.fileSize,
  });
  late final int id;
  late final String ownerName;
  late final String contentType;
  late final int uploadDate;
  late final String title;
  late final int eventProtectionId;
  late final int type;
  late final bool deletable;
  late final ImageStreamData imageStreamData;
  late final int fileSize;

  MapImage.fromJson(Map<String, dynamic> json){
    id = json['id'];
    ownerName = json['ownerName'];
    contentType = json['contentType'];
    uploadDate = json['uploadDate'];
    title = json['title'];
    eventProtectionId = json['eventProtectionId'];
    type = json['type'];
    deletable = json['deletable'];
    imageStreamData = ImageStreamData.fromJson(json['imageStreamData']);
    fileSize = json['fileSize'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['ownerName'] = ownerName;
    _data['contentType'] = contentType;
    _data['uploadDate'] = uploadDate;
    _data['title'] = title;
    _data['eventProtectionId'] = eventProtectionId;
    _data['type'] = type;
    _data['deletable'] = deletable;
    _data['imageStreamData'] = imageStreamData.toJson();
    _data['fileSize'] = fileSize;
    return _data;
  }
}

class ImageStreamData {
  ImageStreamData();

  ImageStreamData.fromJson(Map json);

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    return _data;
  }
}