import 'dart:convert';

import 'package:db_atom/index.dart';

import '../../../../../models/history.dart';

DayPassListResponse dayPassListResponseFromJson(String str) =>
    DayPassListResponse.fromJson(json.decode(str));

String dayPassListResponseToJson(DayPassListResponse data) =>
    json.encode(data.toJson());

class DayPassListResponse {
  List<PassManagementModel>? items;
  int? totalCount;
  int? currentPageNo;
  int? totalPageCount;

  DayPassListResponse({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  factory DayPassListResponse.fromJson(Map<String, dynamic> json) =>
      DayPassListResponse(
        items: json["list"] == null
            ? []
            : List<PassManagementModel>.from(
                json["list"]!.map((x) => PassManagementModel.fromJson(x))),
        totalCount: json["totalCount"],
        currentPageNo: json["currentPageNo"],
        totalPageCount: json["totalPageCount"],
      );

  Map<String, dynamic> toJson() => {
        "list": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "totalCount": totalCount,
        "currentPageNo": currentPageNo,
        "totalPageCount": totalPageCount,
      };
}

class PassManagementModel {
  int? id;
  String? slNo;
  String? inputDate;
  Organisation? location;
  Organisation? vendorPassReason;
  Organisation? locationRegion;
  List<Organisation>? entities;
  int? updatedStatus;
  int? status;
  String? modifiedDate;
  String? modifiedBy;
  List<History>? history;
  User? entrySecurity;
  User? handoverSecurity;
  int? passType;
  Organisation? companyType;
  String? companyName;
  String? employeeName;
  String? employeeId;
  String? email;
  User? host;
  String? hostEmployeeId;
  Organisation? department;
  Organisation? dayPassReason;
  bool? exceptionalApproval;
  PassInfo? passInfo;
  String? startTime;
  String? endTime;
  String? returnedTime;
  List<ImageContent>? evidenceDocuments;
  ImageContent? visitorImage;
  String? contactNo;
  bool? escortedByHost;
  String? escortedBy;
  String? escortedEmployeeId;
  String? visitorComingFrom;
  bool? idValidated;
  int? idValidationType;
  String? visitingPurpose;
  int? category;
  String? hostName;
  String? passNo;
  String? entrySecurityName;
  String? escortedByName;
  String? handOverSecurityName;
  String? mifareNo;
  String? passIssuedOn;
  User? employee;
  String? lock;

  PassManagementModel({
    this.id,
    this.slNo,
    this.inputDate,
    this.location,
    this.locationRegion,
    this.vendorPassReason,
    this.entities,
    this.status,
    this.modifiedDate,
    this.modifiedBy,
    this.history,
    this.entrySecurity,
    this.handoverSecurity,
    this.passType,
    this.companyType,
    this.companyName,
    this.employeeName,
    this.employeeId,
    this.email,
    this.host,
    this.updatedStatus,
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
    this.escortedByHost,
    this.escortedBy,
    this.escortedEmployeeId,
    this.visitorComingFrom,
    this.idValidated,
    this.idValidationType,
    this.visitingPurpose,
    this.category,
    this.hostName,
    this.passNo,
    this.entrySecurityName,
    this.escortedByName,
    this.handOverSecurityName,
    this.mifareNo,
    this.passIssuedOn,
    this.employee,
    this.visitorImage,
    this.lock,
  });

  factory PassManagementModel.fromJson(Map<String, dynamic> json) =>
      PassManagementModel(
        id: json["id"],
        slNo: json["slNo"],
        inputDate: json["inputDate"],
        location: json["location"] == null
            ? null
            : Organisation.fromJson(json["location"]),
        locationRegion: json["locationRegion"] == null
            ? null
            : Organisation.fromJson(json["locationRegion"]),
        vendorPassReason: json["vendorPassReason"] == null
            ? null
            : Organisation.fromJson(json["vendorPassReason"]),
        entities: json["entities"] == null
            ? []
            : List<Organisation>.from(
                json["entities"]!.map((x) => Organisation.fromJson(x))),
        status: json["status"],
        modifiedDate: json["modifiedDate"],
        modifiedBy: json["modifiedBy"],
        updatedStatus: json["updatedStatus"],
        history: json["history"] == null
            ? []
            : List<History>.from(
                json["history"]!.map((x) => History.fromJson(x))),
        entrySecurity: json["entrySecurity"] == null
            ? null
            : User.fromJson(json["entrySecurity"]),
        handoverSecurity: json["handoverSecurity"] == null
            ? null
            : User.fromJson(json["handoverSecurity"]),
        passType: json["passType"],
        companyType: json["companyType"] == null
            ? null
            : Organisation.fromJson(json["companyType"]),
        companyName: json["companyName"],
        employeeName: json["employeeName"],
        employeeId: json["employeeId"],
        email: json["email"],
        host: json["host"] == null ? null : User.fromJson(json["host"]),
        hostEmployeeId: json["hostEmployeeId"],
        department: json["department"] == null
            ? null
            : Organisation.fromJson(json["department"]),
        dayPassReason: json["dayPassReason"] == null
            ? null
            : Organisation.fromJson(json["dayPassReason"]),
        exceptionalApproval: json["exceptionalApproval"],
        passInfo: json["passInfo"] == null
            ? null
            : PassInfo.fromJson(json["passInfo"]),
        startTime: json["startTime"],
        endTime: json["endTime"],
        returnedTime: json["returnedTime"],
        evidenceDocuments: json["evidenceDocuments"] == null
            ? []
            : List<ImageContent>.from(json["evidenceDocuments"]!
                .map((x) => ImageContent.fromJson(x))),
        visitorImage: json["visitorImage"] == null
            ? null
            : ImageContent.fromJson(json["visitorImage"]),
        contactNo: json["contactNo"],
        escortedByHost: json["escortedByHost"],
        escortedBy: json["escortedBy"],
        escortedEmployeeId: json["escortedEmployeeId"],
        visitorComingFrom: json["visitorComingFrom"],
        idValidated: json["idValidated"],
        idValidationType: json["idValidationType"],
        visitingPurpose: json["visitingPurpose"],
        category: json["category"],
        hostName: json["hostName"],
        passNo: json["passNo"],
        entrySecurityName: json["entrySecurityName"],
        escortedByName: json["escortedByName"],
        handOverSecurityName: json["handOverSecurityName"],
        mifareNo: json["mifareNo"],
        passIssuedOn: json["passIssuedOn"],
        lock: json["lock"],
        employee:
            json["employee"] == null ? null : User.fromJson(json["employee"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slNo": slNo,
        "inputDate": inputDate,
        "location": location?.toJson(),
        "locationRegion": locationRegion?.toJson(),
        "updatedStatus": updatedStatus,
        "vendorPassReason": vendorPassReason?.toJson(),
        "entities": entities == null
            ? []
            : List<dynamic>.from(entities!.map((x) => x.toJson())),
        "status": status,
        "modifiedDate": modifiedDate,
        "modifiedBy": modifiedBy,
        "history": history == null
            ? []
            : List<dynamic>.from(history!.map((x) => x.toJson())),
        "entrySecurity": entrySecurity?.toJson(),
        "handoverSecurity": handoverSecurity?.toJson(),
        "passType": passType,
        "companyType": companyType?.toJson(),
        "companyName": companyName,
        "employeeName": employeeName,
        "employeeId": employeeId,
        "email": email,
        "host": host?.toJson(),
        "hostEmployeeId": hostEmployeeId,
        "department": department?.toJson(),
        "dayPassReason": dayPassReason?.toJson(),
        "exceptionalApproval": exceptionalApproval,
        "passInfo": passInfo?.toJson(),
        "startTime": startTime,
        "endTime": endTime,
        "returnedTime": returnedTime,
        "evidenceDocuments": evidenceDocuments == null
            ? []
            : List<dynamic>.from(evidenceDocuments!.map((x) => x)),
        "visitorImage": visitorImage?.toJson(),
        "contactNo": contactNo,
        "escortedByHost": escortedByHost,
        "escortedBy": escortedBy,
        "escortedEmployeeId": escortedEmployeeId,
        "visitorComingFrom": visitorComingFrom,
        "idValidated": idValidated,
        "idValidationType": idValidationType,
        "visitingPurpose": visitingPurpose,
        "category": category,
        "hostName": hostName,
        "passNo": passNo,
        "entrySecurityName": entrySecurityName,
        "escortedByName": escortedByName,
        "handOverSecurityName": handOverSecurityName,
        "mifareNo": mifareNo,
        "passIssuedOn": passIssuedOn,
        "employee": employee?.toJson(),
      };
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

  factory PassInfo.fromJson(Map<String, dynamic> json) => PassInfo(
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

  Map<String, dynamic> toJson() => {
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
