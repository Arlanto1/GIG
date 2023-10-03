import 'package:db_atom/src/models/entity.dart';

import '../../../../../models/department.dart';
import '../../../../../models/entry_security.dart';
import '../../../../../models/location.dart';
import '../../../../../models/location_region.dart';
import 'day_passlist_model.dart';

class DayPassListResponse {
  final List<DayPassListElement>? items;
  final int? totalCount;
  final int? currentPageNo;
  final int? totalPageCount;

  DayPassListResponse({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  DayPassListResponse.fromJson(Map<String, dynamic> json)
      : items = (json['items'] as List?)
            ?.map((dynamic e) => DayPassListElement.fromJson(e as Map<String, dynamic>))
            .toList(),
        totalCount = json['totalCount'] as int?,
        currentPageNo = json['currentPageNo'] as int?,
        totalPageCount = json['totalPageCount'] as int?;

  Map<String, dynamic> toJson() => {
        'items': items?.map((e) => e.toJson()).toList(),
        'totalCount': totalCount,
        'currentPageNo': currentPageNo,
        'totalPageCount': totalPageCount
      };
}

class DayPassListItemResponse {
  final int? id;
  final String? slNo;
  final String? inputDate;
  final Location? location;
  final LocationRegion? locationRegion;
  final List<Entity>? entities;
  final int? status;
  final Department? department;
  final List<dynamic>? history;
  final EntrySecurity? entrySecurity;
   final int? passType;
  final CompanyType? companyType;
  final CompanyType? dayPassReason;
  final CompanyType? vendorPassReason;
  final String? companyName;
  final String? employeeName;
  final String? employeeId;
  final String? email;
  final String? hostEmployeeId;
  final bool? exceptionalApproval;
  final String? startTime;
  final String? endTime;
  final List<dynamic>? evidenceDocuments;
  final String? contactNo;
  final bool? escortedByHost;
  final String? escortedBy;
  final String? escortedEmployeeId;
  final String? visitorComingFrom;
  final bool? idValidated;
  final int? idValidationType;
  final String? visitingPurpose;
  final int? category;
  final String? hostName;
  final String? entrySecurityName;
  final String? passNo;
  final String? escortedByName;
  final String? handOverSecurityName;
  final String? mifareNo;
  final Employee? host;
  final PassInfo? passInfo;


  DayPassListItemResponse({
    this.id,
    this.slNo,
    this.inputDate,
    this.location,
    this.locationRegion,
    this.host,
    this.entities,
    this.status,
    this.history,
    this.entrySecurity,
    this.passType,
    this.companyType,
   this.dayPassReason,
    this.vendorPassReason,
    this.companyName,
    this.employeeName,
    this.employeeId,
    this.email,
    this.hostEmployeeId,
    this.exceptionalApproval,
    this.startTime,
    this.endTime,
    this.evidenceDocuments,
    this.contactNo,
    this.escortedByHost,
    this.escortedBy,
    this.escortedEmployeeId,
    this.visitorComingFrom,
    this.idValidated,
    this.idValidationType,
    this.visitingPurpose,
    this.category,
    this.hostName,
    this.entrySecurityName,
    this.passNo,
    this.escortedByName,
    this.handOverSecurityName,
    this.mifareNo,
    this.department,
    this.passInfo,
  });

  DayPassListItemResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        slNo = json['slNo'] as String?,
        inputDate = json['inputDate'] as String?,
        location = (json['location'] as Map<String, dynamic>?) != null
            ? Location.fromJson(json['location'] as Map<String, dynamic>)
            : null,
        host = (json['host'] as Map<String, dynamic>?) != null
            ? Employee.fromJson(json['host'] as Map<String, dynamic>)
            : null,
        passInfo = (json['passInfo'] as Map<String, dynamic>?) != null
            ? PassInfo.fromJson(json['passInfo'] as Map<String, dynamic>)
            : null,
        locationRegion =
            (json['locationRegion'] as Map<String, dynamic>?) != null
                ? LocationRegion.fromJson(
                    json['locationRegion'] as Map<String, dynamic>)
                : null,
        entities = (json['entities'] as List?)
            ?.map((dynamic e) => Entity.fromJson(e as Map<String, dynamic>))
            .toList(),
        status = json['status'] as int?,
        history = json['history'] as List?,
        entrySecurity = (json['entrySecurity'] as Map<String, dynamic>?) != null
            ? EntrySecurity.fromJson(
                json['entrySecurity'] as Map<String, dynamic>)
            : null,
        passType = json['passType'] as int?,
        companyType = (json['companyType'] as Map<String, dynamic>?) != null
            ? CompanyType.fromJson(json['companyType'] as Map<String, dynamic>)
            : null,
        dayPassReason = (json['dayPassReason'] as Map<String, dynamic>?) != null
            ? CompanyType.fromJson(json['dayPassReason'] as Map<String, dynamic>)
            : null,
        vendorPassReason = (json['vendorPassReason'] as Map<String, dynamic>?) != null
            ? CompanyType.fromJson(json['vendorPassReason'] as Map<String, dynamic>)
            : null,
      companyName = json['companyName'] as String?,
        employeeName = json['employeeName'] as String?,
        employeeId = json['employeeId'] as String?,
        email = json['email'] as String?,
        hostEmployeeId = json['hostEmployeeId'] as String?,
        exceptionalApproval = json['exceptionalApproval'] as bool?,
        startTime = json['startTime'] as String?,
        endTime = json['endTime'] as String?,
        evidenceDocuments = json['evidenceDocuments'] as List?,
        contactNo = json['contactNo'] as String?,
        escortedByHost = json['escortedByHost'] as bool?,
        escortedBy = json['escortedBy'] as String?,
        escortedEmployeeId = json['escortedEmployeeId'] as String?,
        visitorComingFrom = json['visitorComingFrom'] as String?,
        idValidated = json['idValidated'] as bool?,
        idValidationType = json['idValidationType'] as int?,
        visitingPurpose = json['visitingPurpose'] as String?,
        category = json['category'] as int?,
        hostName = json['hostName'] as String?,
        entrySecurityName = json['entrySecurityName'] as String?,
        passNo = json['passNo'] as String?,
        escortedByName = json['escortedByName'] as String?,
        handOverSecurityName = json['handOverSecurityName'] as String?,
        mifareNo = json['mifareNo'] as String?,
        department = (json['department'] as Map<String, dynamic>?) != null
            ? Department.fromJson(json['department'] as Map<String, dynamic>)
            : null;


  Map<String, dynamic> toJson() => {
        'id': id,
        'slNo': slNo,
        'inputDate': inputDate,
        'location': location?.toJson(),
        'locationRegion': locationRegion?.toJson(),
        'entities': entities,
        'status': status,
        'history': history,
        'entrySecurity': entrySecurity?.toJson(),
        'passType': passType,
        'companyType': companyType?.toJson(),
        'companyName': companyName,
        'employeeName': employeeName,
        'employeeId': employeeId,
        'email': email,
        'hostEmployeeId': hostEmployeeId,
        'exceptionalApproval': exceptionalApproval,
        'startTime': startTime,
        'endTime': endTime,
    "host": host?.toJson(),
       "passInfo": passInfo?.toJson(),
    "dayPassReason": dayPassReason?.toJson(),
    "vendorPassReason": vendorPassReason?.toJson(),
        'evidenceDocuments': evidenceDocuments,
        'contactNo': contactNo,
        'escortedByHost': escortedByHost,
        'escortedBy': escortedBy,
        'escortedEmployeeId': escortedEmployeeId,
        'visitorComingFrom': visitorComingFrom,
        'idValidated': idValidated,
        'idValidationType': idValidationType,
        'visitingPurpose': visitingPurpose,
        'category': category,
        'hostName': hostName,
        'entrySecurityName': entrySecurityName,
        'passNo': passNo,
        'escortedByName': escortedByName,
        'handOverSecurityName': handOverSecurityName,
        'mifareNo': mifareNo
      };
}

class CompanyType {
  final int? id;
  final String? name;

  CompanyType({
    this.id,
    this.name,
  });

  CompanyType.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
