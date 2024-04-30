// To parse this JSON data, do
//
//     final lawEnforcementListResponse = lawEnforcementListResponseFromJson(jsonString);

import 'dart:convert';

import 'package:db_atom/src/models/organisation.dart';

import '../../createfound/models/user.dart';

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
  Organisation? location;
  Organisation? locationRegion;
  String? timeOfVisit;
  bool? officialCardVerified;
  Organisation? visitPurpose;
  bool? documentVerified;
  bool? visitorInUniform;
  String? dbOfficialEmail;
  Organisation? dbOfficialEmailDepartment;
  String? dbOfficialAccompaniedEmail;
  User? entrySecurity;
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
            : Organisation.fromJson(json["location"]),
        locationRegion: json["locationRegion"] == null
            ? null
            : Organisation.fromJson(json["locationRegion"]),
        timeOfVisit: json["timeOfVisit"],
        officialCardVerified: json["officialCardVerified"],
        visitPurpose: json["visitPurpose"] == null
            ? null
            : Organisation.fromJson(json["visitPurpose"]),
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
