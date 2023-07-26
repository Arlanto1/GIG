// To parse this JSON data, do
//
//     final lawEnforcementListResponse = lawEnforcementListResponseFromJson(jsonString);

import 'dart:convert';

LawEnforcementListResponse lawEnforcementListResponseFromJson(String str) =>
    LawEnforcementListResponse.fromJson(json.decode(str));

String lawEnforcementListResponseToJson(LawEnforcementListResponse data) =>
    json.encode(data.toJson());

class LawEnforcementListResponse {
  List<LawEnforcementListElement>? list;
  int? totalCount;
  int? currentPageNo;
  int? totalPageCount;

  LawEnforcementListResponse({
    this.list,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  factory LawEnforcementListResponse.fromJson(Map<String, dynamic> json) =>
      LawEnforcementListResponse(
        list: json["list"] == null
            ? []
            : List<LawEnforcementListElement>.from(json["list"]!
                .map((x) => LawEnforcementListElement.fromJson(x))),
        totalCount: json["totalCount"],
        currentPageNo: json["currentPageNo"],
        totalPageCount: json["totalPageCount"],
      );

  Map<String, dynamic> toJson() => {
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
        "totalCount": totalCount,
        "currentPageNo": currentPageNo,
        "totalPageCount": totalPageCount,
      };
}

class LawEnforcementListElement {
  int? id;
  String? slNo;
  String? inputDate;
  LawEnforcementLocation? location;
  LawEnforcementLocation? locationRegion;
  String? timeOfVisit;
  bool? officialCardVerified;
  LawEnforcementLocation? visitPurpose;
  bool? documentVerified;
  bool? visitorInUniform;
  String? dbOfficialEmail;
  LawEnforcementLocation? dbOfficialEmailDepartment;
  String? dbOfficialAccompaniedEmail;
  EntrySecurity? entrySecurity;
  String? additionalInformation;
  int? status;
  String? modifiedDate;
  String? modifiedBy;

  String? entityDesc;
  String? entrySecurityName;

  LawEnforcementListElement({
    this.id,
    this.slNo,
    this.inputDate,
    this.location,
    this.locationRegion,
    this.timeOfVisit,
    this.officialCardVerified,
    this.visitPurpose,
    this.documentVerified,
    this.visitorInUniform,
    this.dbOfficialEmail,
    this.dbOfficialEmailDepartment,
    this.dbOfficialAccompaniedEmail,
    this.entrySecurity,
    this.additionalInformation,
    this.status,
    this.modifiedDate,
    this.modifiedBy,
    this.entityDesc,
    this.entrySecurityName,
  });

  factory LawEnforcementListElement.fromJson(Map<String, dynamic> json) =>
      LawEnforcementListElement(
        id: json["id"],
        slNo: json["slNo"],
        inputDate: json["inputDate"],
        location: json["location"] == null
            ? null
            : LawEnforcementLocation.fromJson(json["location"]),
        locationRegion: json["locationRegion"] == null
            ? null
            : LawEnforcementLocation.fromJson(json["locationRegion"]),
        timeOfVisit: json["timeOfVisit"],
        officialCardVerified: json["officialCardVerified"],
        visitPurpose: json["visitPurpose"] == null
            ? null
            : LawEnforcementLocation.fromJson(json["visitPurpose"]),
        documentVerified: json["documentVerified"],
        visitorInUniform: json["visitorInUniform"],
        dbOfficialEmail: json["dbOfficialEmail"],
        dbOfficialAccompaniedEmail: json["dbOfficialAccompaniedEmail"],
        additionalInformation: json["additionalInformation"],
        status: json["status"],
        modifiedDate: json["modifiedDate"],
        modifiedBy: json["modifiedBy"],

        entityDesc: json["entityDesc"],
        entrySecurityName: json["entrySecurityName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slNo": slNo,
        "inputDate": inputDate,
        "location": location?.toJson(),
        "locationRegion": locationRegion?.toJson(),
        "timeOfVisit": timeOfVisit,
        "officialCardVerified": officialCardVerified,
        "visitPurpose": visitPurpose?.toJson(),
        "documentVerified": documentVerified,
        "visitorInUniform": visitorInUniform,
        "dbOfficialEmail": dbOfficialEmail,
        "dbOfficialEmailDepartment": dbOfficialEmailDepartment?.toJson(),
        "dbOfficialAccompaniedEmail": dbOfficialAccompaniedEmail,
        "entrySecurity": entrySecurity?.toJson(),
        "additionalInformation": additionalInformation,
        "status": status,
        "modifiedDate": modifiedDate,
        "modifiedBy": modifiedBy,

        "entityDesc": entityDesc,
        "entrySecurityName": entrySecurityName,
      };
}

class LawEnforcementLocation {
  int? id;
  String? name;

  LawEnforcementLocation({
    this.id,
    this.name,
  });

  factory LawEnforcementLocation.fromJson(Map<String, dynamic> json) =>
      LawEnforcementLocation(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class EntrySecurity {
  int? userId;
  String? userName;
  String? email;
  String? firstName;
  String? lastName;
  String? phone;
  List<Role>? roles;
  List<RoleExtension>? roleExtensions;
  String? name;
  String? userStatus;

  EntrySecurity({
    this.userId,
    this.userName,
    this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.roles,
    this.roleExtensions,
    this.name,
    this.userStatus,
  });

  factory EntrySecurity.fromJson(Map<String, dynamic> json) => EntrySecurity(
        userId: json["userId"],
        userName: json["userName"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phone: json["phone"],
        name: json["name"],
        userStatus: json["userStatus"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "userName": userName,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "name": name,
        "userStatus": userStatus,
      };
}

class RoleExtension {
  int? roleExtensionId;
  int? roleId;
  String? displayName;
  String? area;
  String? filter;
  dynamic rootNodeId;
  dynamic nodeId;
  dynamic accessRight;

  RoleExtension({
    this.roleExtensionId,
    this.roleId,
    this.displayName,
    this.area,
    this.filter,
    this.rootNodeId,
    this.nodeId,
    this.accessRight,
  });

  factory RoleExtension.fromJson(Map<String, dynamic> json) => RoleExtension(
        roleExtensionId: json["roleExtensionId"],
        roleId: json["roleId"],
        displayName: json["displayName"],
        area: json["area"],
        filter: json["filter"],
        rootNodeId: json["rootNodeId"],
        nodeId: json["nodeId"],
        accessRight: json["accessRight"],
      );

  Map<String, dynamic> toJson() => {
        "roleExtensionId": roleExtensionId,
        "roleId": roleId,
        "displayName": displayName,
        "area": area,
        "filter": filter,
        "rootNodeId": rootNodeId,
        "nodeId": nodeId,
        "accessRight": accessRight,
      };
}

class Role {
  int? roleId;
  String? application;
  String? roleName;
  List<RoleExtension>? roleExtensions;
  String? name;

  Role({
    this.roleId,
    this.application,
    this.roleName,
    this.roleExtensions,
    this.name,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        roleId: json["roleId"],
        application: json["application"],
        roleName: json["roleName"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "roleId": roleId,
        "application": application,
        "roleName": roleName,
        "name": name,
      };
}

class History {
  int? id;
  int? state;
  int? action;
  String? email;
  int? actiontime;

  History({
    this.id,
    this.state,
    this.action,
    this.email,
    this.actiontime,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["id"],
        state: json["state"],
        action: json["action"],
        email: json["email"],
        actiontime: json["actiontime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "state": state,
        "action": action,
        "email": email,
        "actiontime": actiontime,
      };
}

class MailList {
  int? groupId;
  String? name;

  MailList({
    this.groupId,
    this.name,
  });

  factory MailList.fromJson(Map<String, dynamic> json) => MailList(
        groupId: json["groupId"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "groupId": groupId,
        "name": name,
      };
}

class VisitingOfficial {
  int? id;
  String? name;
  String? designation;
  String? address;
  String? contactNo;
  String? email;
  bool? mandatory;

  VisitingOfficial({
    this.id,
    this.name,
    this.designation,
    this.address,
    this.contactNo,
    this.email,
    this.mandatory,
  });

  factory VisitingOfficial.fromJson(Map<String, dynamic> json) =>
      VisitingOfficial(
        id: json["id"],
        name: json["name"],
        designation: json["designation"],
        address: json["address"],
        contactNo: json["contactNo"],
        email: json["email"],
        mandatory: json["mandatory"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "designation": designation,
        "address": address,
        "contactNo": contactNo,
        "email": email,
        "mandatory": mandatory,
      };
}
