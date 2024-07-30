import 'dart:convert';

import '../../../../../../index.dart';
import '../../passmgmtlist/models/day_passlist_model.dart';

CreatePassMgmtBody createPassMgmtBodyFromJson(String str) =>
    CreatePassMgmtBody.fromJson(json.decode(str));

String createPassMgmtBodyToJson(CreatePassMgmtBody data) =>
    json.encode(data.toJson());

class CreatePassMgmtBody {
  PassManagement? passManagement;

  CreatePassMgmtBody({
    this.passManagement,
  });

  factory CreatePassMgmtBody.fromJson(Map<String, dynamic> json) =>
      CreatePassMgmtBody(
        passManagement: json["passManagement"] == null
            ? null
            : PassManagement.fromJson(json["passManagement"]),
      );

  Map<String, dynamic> toJson() => {
        "passManagement": passManagement?.toJson(),
      };
}

class PassManagement extends BaseObject {
  int? id;
  String? slNo;
  String? inputDate;
  Organisation? location;
  Organisation? dayPassReason;
  Organisation? vendorPassReason;
  Organisation? locationRegion;
  List<Organisation>? entities;
  int? status;
  int? updatedStatus;
  List<dynamic>? history;
  int? passType;
  Organisation? companyType;
  String? companyName;
  String? employeeName;
  String? employeeId;
  String? email;
  String? hostEmployeeId;
  bool? exceptionalApproval;
  PassInfo? passInfo;
  String? endTime;

  //List<ImageContent>? evidenceDocuments;
  String? contactNo;
  bool? escortedByHost;
  String? escortedBy;
  String? escortedEmployeeId;
  String? visitorComingFrom;
  bool? idValidated;
  int? idValidationType;
  String? visitingPurpose;
  int? category;
  String? passIssuedOn;
  String? hostName;
  String? entrySecurityName;
  String? escortedByName;
  String? passNo;
  String? handOverSecurityName;
  String? mifareNo;
  List<ImageContent>? evidenceDocuments;
  Organisation? department;
  User? host;
  String? visitorName;
  List<ImageContent>? visitorImage;
  Organisation? visitingDepartment;
  String? startTime;
  User? entrySecurity;
  User? employee;
  User? handoverSecurity;
  String? returnedTime;

  PassManagement({
    this.id,
    this.slNo,
    this.inputDate,
    this.location,
    this.locationRegion,
    this.entities,
    this.status,
    this.history,
    this.passType,
    this.companyType,
    this.companyName,
    this.employeeName,
    this.employeeId,
    this.email,
    this.hostEmployeeId,
    this.exceptionalApproval,
    this.passInfo,
    this.endTime,
    //this.evidenceDocuments,
    this.contactNo,
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
    this.entrySecurityName,
    this.escortedByName,
    this.passNo,
    this.handOverSecurityName,
    this.mifareNo,
    this.evidenceDocuments,
    this.department,
    this.host,
    this.visitorName,
    this.visitorImage,
    this.visitingDepartment,
    this.dayPassReason,
    this.vendorPassReason,
    this.startTime,
    this.updatedStatus,
    this.entrySecurity,
    this.employee,
    this.handoverSecurity,
    this.returnedTime,
  });

  factory PassManagement.fromJson(Map<String, dynamic> json) => PassManagement(
        id: json["id"],
        slNo: json["slNo"],
        host: json["host"] == null ? null : User.fromJson(json["host"]),
        inputDate: json["inputDate"],
        location: json["location"] == null
            ? null
            : Organisation.fromJson(json["location"]),
        dayPassReason: json["dayPassReason"] == null
            ? null
            : Organisation.fromJson(json["dayPassReason"]),
        vendorPassReason: json["vendorPassReason"] == null
            ? null
            : Organisation.fromJson(json["vendorPassReason"]),
        locationRegion: json["locationRegion"] == null
            ? null
            : Organisation.fromJson(json["locationRegion"]),
        entities: json["entities"] == null
            ? []
            : List<Organisation>.from(
                json["entities"]!.map((x) => Organisation.fromJson(x))),
        status: json["status"],
        updatedStatus: json["updatedStatus"],
        history: json["history"] == null
            ? []
            : List<dynamic>.from(json["history"]!.map((x) => x)),
        passType: json["passType"],
        companyType: json["companyType"] == null
            ? null
            : Organisation.fromJson(json["companyType"]),
        companyName: json["companyName"],
        employeeName: json["employeeName"],
        employeeId: json["employeeId"],
        email: json["email"],
        hostEmployeeId: json["hostEmployeeId"],
        exceptionalApproval: json["exceptionalApproval"],
        passInfo: json["passInfo"] == null
            ? null
            : PassInfo.fromJson(json["passInfo"]),
        endTime: json["endTime"],
        // evidenceDocuments: json["evidenceDocuments"] == null
        //     ? []
        //     : List<dynamic>.from(json["evidenceDocuments"]!.map((x) => x)),
        contactNo: json["contactNo"],
        escortedByHost: json["escortedByHost"],
        escortedBy: json["escortedBy"],
        escortedEmployeeId: json["escortedEmployeeId"],
        visitorComingFrom: json["visitorComingFrom"],
        idValidated: json["idValidated"],
        idValidationType: json["idValidationType"],
        visitingPurpose: json["visitingPurpose"],
        category: json["category"],
        passIssuedOn: json["passIssuedOn"],
        hostName: json["hostName"],
        entrySecurityName: json["entrySecurityName"],
        escortedByName: json["escortedByName"],
        passNo: json["passNo"],
        handOverSecurityName: json["handOverSecurityName"],
        mifareNo: json["mifareNo"],
        evidenceDocuments: json["evidenceDocuments"] == null
            ? []
            : List<ImageContent>.from(json["evidenceDocuments"]!
                .map((x) => ImageContent.fromJson(x))),
        department: json["department"] == null
            ? null
            : Organisation.fromJson(json["department"]),
        visitingDepartment: json["visitingDepartment"] == null
            ? null
            : Organisation.fromJson(json["visitingDepartment"]),
        visitorName: json["visitorName"],
        visitorImage: json["visitorImage"] == null
            ? []
            : List<ImageContent>.from(
                json["visitorImage"]!.map((x) => ImageContent.fromJson(x))),
        startTime: json["startTime"],
        entrySecurity: json["entrySecurity"] == null
            ? null
            : User.fromJson(json["entrySecurity"]),

        employee:
            json["employee"] == null ? null : User.fromJson(json["employee"]),
        handoverSecurity: json["handoverSecurity"] == null
            ? null
            : User.fromJson(json["handoverSecurity"]),
        returnedTime: json["returnedTime"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "slNo": slNo,
        "host": host?.toJson(),
        "inputDate": inputDate,
        "location": location?.toJson(),
        "locationRegion": locationRegion?.toJson(),
        "entities": entities == null
            ? []
            : List<dynamic>.from(entities!.map((x) => x.toJson())),
        "status": status,
        "history":
            history == null ? [] : List<dynamic>.from(history!.map((x) => x)),
        "passType": passType,
        "companyType": companyType?.toJson(),
        "companyName": companyName,
        "employeeName": employeeName,
        "employeeId": employeeId,
        "email": email,
        "hostEmployeeId": hostEmployeeId,
        "exceptionalApproval": exceptionalApproval,
        "passInfo": passInfo?.toJson(),
        "endTime": endTime,
        // "evidenceDocuments": evidenceDocuments == null
        //     ? []
        //     : List<dynamic>.from(evidenceDocuments!.map((x) => x)),
        "contactNo": contactNo,
        "escortedByHost": escortedByHost,
        "escortedBy": escortedBy,
        "escortedEmployeeId": escortedEmployeeId,
        "visitorComingFrom": visitorComingFrom,
        "idValidated": idValidated,
        "idValidationType": idValidationType,
        "visitingPurpose": visitingPurpose,
        "category": category,
        "passIssuedOn": passIssuedOn,
        "hostName": hostName,
        "entrySecurityName": entrySecurityName,
        "escortedByName": escortedByName,
        "passNo": passNo,
        "handOverSecurityName": handOverSecurityName,
        "mifareNo": mifareNo,
        "evidenceDocuments": evidenceDocuments == null
            ? []
            : List<dynamic>.from(evidenceDocuments!.map((x) => x.toJson())),
        "department": department?.toJson(),
        "visitorName": visitorName,
        "visitorImage": visitorImage == null
            ? []
            : List<dynamic>.from(visitorImage!.map((x) => x.toJson())),
        "visitingDepartment": visitingDepartment?.toJson(),
        "dayPassReason": dayPassReason?.toJson(),
        "vendorPassReason": vendorPassReason?.toJson(),
        "startTime": startTime,
        "updatedStatus": updatedStatus,
        "entrySecurity": entrySecurity?.toJson(),
        "employee": employee?.toJson(),
        "handoverSecurity": handoverSecurity?.toJson(),
        "returnedTime": returnedTime,
      };
}

class PassHost {
  int? id;
  String? name;
  String? email;
  String? firstName;
  String? lastName;

  PassHost({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.name,
  });

  factory PassHost.fromJson(Map<String, dynamic> json) => PassHost(
        id: json["id"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "name": name,
      };
}
