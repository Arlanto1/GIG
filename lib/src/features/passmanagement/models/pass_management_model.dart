
import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/passmanagement/models/day_pass_reason_model.dart';
import 'package:db_atom/src/features/passmanagement/models/vendor_pass_reason_model.dart';

part 'pass_management_model.g.dart';

class PassManagementResponseModel extends BaseObject {
  List<PassManagementModel>? items;
  int? totalCount;
  int? currentPageNo;
  int? totalPageCount;

  PassManagementResponseModel({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  PassManagementResponseModel.fromJson(Map<String, dynamic> json)
      : items = (json['passManagement'] as List?)
      ?.map((dynamic e) =>
      PassManagementModel.fromJson(e as Map<String, dynamic>))
      .toList(),
        totalCount = json['totalCount'] as int?,
        currentPageNo = json['currentPageNo'] as int?,
        totalPageCount = json['totalPageCount'] as int?;

  @override
  Map<String, dynamic> toJson() => {
    'passManagement': items?.map((e) => e.toJson()).toList(),
    'totalCount': totalCount,
    'currentPageNo': currentPageNo,
    'totalPageCount': totalPageCount
  };
}

@JsonSerializable()
class PassManagementModel extends BaseObject{
  final int? id;
  final String? slNo;
  final String? inputDate;
  final Organisation? location;
  final Organisation? locationRegion;
  final List<dynamic>? entities;
  final int? status;
  final String? modifiedBy;
  final User? entrySecurity;
  final HandoverSecurity? handoverSecurity;
  final int? passType;
  final Organisation? companyType;
  final String? companyName;
  final String? employeeName;
  final String? employeeId;
  final String? email;
  final User? host;
  final String? hostEmployeeId;
  final Organisation? department;
  final DayPassReason? dayPassReason;
  final bool? exceptionalApproval;
  final PassInfo? passInfo;
  final String? startTime;
  final String? endTime;
  final String? returnedTime;
  final List<dynamic>? evidenceDocuments;
  final String? contactNo;
  final VendorPassReason? vendorPassReason;
  final bool? escortedByHost;
  final String? escortedBy;
  final String? escortedEmployeeId;
  final String? visitorComingFrom;
  final bool? idValidated;
  final int? idValidationType;
  final String? visitingPurpose;
  final int? category;
  final String? passIssuedOn;
  final String? hostName;
  final String? handOverSecurityName;
  final String? mifareNo;
  final String? passNo;
  final String? escortedByName;
  final String? entrySecurityName;

  PassManagementModel({
    this.id,
    this.slNo,
    this.inputDate,
    this.location,
    this.locationRegion,
    this.entities,
    this.status,
    this.modifiedBy,
    this.entrySecurity,
    this.handoverSecurity,
    this.passType,
    this.companyType,
    this.companyName,
    this.employeeName,
    this.employeeId,
    this.email,
    this.host,
    this.hostEmployeeId,
    this.department,
    this.dayPassReason,
    this.exceptionalApproval,
    this.passInfo,
    this.startTime,
    this.endTime,
    this.returnedTime,
    this.evidenceDocuments,
    this.contactNo,
    this.vendorPassReason,
    this.escortedByHost,
    this.escortedBy,
    this.escortedEmployeeId,
    this.visitorComingFrom,
    this.idValidated,
    this.idValidationType,
    this.visitingPurpose,
    this.category,
    this.passIssuedOn,
    this.hostName,
    this.handOverSecurityName,
    this.mifareNo,
    this.passNo,
    this.escortedByName,
    this.entrySecurityName,
  });


  factory PassManagementModel.fromJson(Map<String, dynamic> json) =>
      _$PassManagementModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PassManagementModelToJson(this);
}


class PassInfo {
  int? id;
  int? passType;
  String? passNo;
  String? mifareNo;
  String? expiryDate;
  Organisation? location;
  Organisation? region;
  Organisation? entity;
  bool? dws;
  int? status;

  PassInfo({
    this.id,
    this.passType,
    this.passNo,
    this.mifareNo,
    this.expiryDate,
    this.location,
    this.region,
    this.entity,
    this.dws,
    this.status,
  });

  factory PassInfo.fromJson(Map<String, dynamic> json) =>
      PassInfo(
        id: json["id"],
        passType: json["passType"],
        passNo: json["passNo"],
        mifareNo: json["mifareNo"],
        expiryDate: json["expiryDate"],
        location: json["location"] == null
            ? null
            : Organisation.fromJson(json["location"]),
        region: json["region"] == null
            ? null
            : Organisation.fromJson(json["region"]),
        entity: json["entity"] == null
            ? null
            : Organisation.fromJson(json["entity"]),
        dws: json["dws"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "passType": passType,
        "passNo": passNo,
        "mifareNo": mifareNo,
        "expiryDate": expiryDate,
        "location": location?.toJson(),
        "region": region?.toJson(),
        "entity": entity?.toJson(),
        "dws": dws,
        "status": status,
      };
}