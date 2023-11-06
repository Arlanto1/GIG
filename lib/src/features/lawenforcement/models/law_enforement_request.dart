// To parse this JSON data, do
//
//     final lawEnforcementRequestBody = lawEnforcementRequestBodyFromJson(jsonString);

import 'dart:convert';

import 'package:db_atom/src/features/createfound/models/create_found_request.dart';

LawEnforcementRequestBody lawEnforcementRequestBodyFromJson(String str) => LawEnforcementRequestBody.fromJson(json.decode(str));

String lawEnforcementRequestBodyToJson(LawEnforcementRequestBody data) => json.encode(data.toJson());

class LawEnforcementRequestBody {
    LawEnforcement? lawEnforcement;

    LawEnforcementRequestBody({
        this.lawEnforcement,
    });

    factory LawEnforcementRequestBody.fromJson(Map<String, dynamic> json) => LawEnforcementRequestBody(
        lawEnforcement: json["lawEnforcement"] == null ? null : LawEnforcement.fromJson(json["lawEnforcement"]),
    );

    Map<String, dynamic> toJson() => {
        "lawEnforcement": lawEnforcement?.toJson(),
    };
}

class LawEnforcement {
    int? id;
    int? status;
    LawEntrySecurity? entrySecurity;
    LawLocation? location;
    List<DbOfficialEmailDepartment>? entities;
    String? slNo;
    String? inputDate;
    String? timeOfVisit;
    bool? officialCardVerified;
    bool? documentVerified;
    bool? visitorInUniform;
    String? dbOfficialEmail;
    String? dbOfficialAccompaniedEmail;
    DbOfficialEmailDepartment? dbOfficialEmailDepartment;
    DbOfficialEmailDepartment? visitPurpose;
    String? additionalInformation;
    List<VisitingOfficial>? visitingOfficials;
    List<MailList>? mailList;
    List<CreateImage>? images;

    LawEnforcement({
        this.id,
        this.status,
        this.entrySecurity,
        this.location,
        this.entities,
        this.slNo,
        this.inputDate,
        this.timeOfVisit,
        this.officialCardVerified,
        this.documentVerified,
        this.visitorInUniform,
        this.dbOfficialEmail,
        this.dbOfficialAccompaniedEmail,
        this.dbOfficialEmailDepartment,
        this.visitPurpose,
        this.additionalInformation,
        this.visitingOfficials,
        this.mailList,
        this.images,
    });

    factory LawEnforcement.fromJson(Map<String, dynamic> json) => LawEnforcement(
        id: json["id"],
        status: json["status"],
        entrySecurity: json["entrySecurity"] == null ? null : LawEntrySecurity.fromJson(json["entrySecurity"]),
        location: json["location"] == null ? null : LawLocation.fromJson(json["location"]),
        entities: json["entities"] == null ? [] : List<DbOfficialEmailDepartment>.from(json["entities"]!.map((x) => DbOfficialEmailDepartment.fromJson(x))),
        slNo: json["slNo"],
        inputDate: json["inputDate"],
        timeOfVisit: json["timeOfVisit"],
        officialCardVerified: json["officialCardVerified"],
        documentVerified: json["documentVerified"],
        visitorInUniform: json["visitorInUniform"],
        dbOfficialEmail: json["dbOfficialEmail"],
        dbOfficialAccompaniedEmail: json["dbOfficialAccompaniedEmail"],
        dbOfficialEmailDepartment: json["dbOfficialEmailDepartment"] == null ? null : DbOfficialEmailDepartment.fromJson(json["dbOfficialEmailDepartment"]),
        visitPurpose: json["visitPurpose"] == null ? null : DbOfficialEmailDepartment.fromJson(json["visitPurpose"]),
        additionalInformation: json["additionalInformation"],
        visitingOfficials: json["visitingOfficials"] == null ? [] : List<VisitingOfficial>.from(json["visitingOfficials"]!.map((x) => VisitingOfficial.fromJson(x))),
        mailList: json["mailList"] == null ? [] : List<MailList>.from(json["mailList"]),
        images: json["images"] == null
            ? []
            : List<CreateImage>.from(
                json["images"]!.map((x) => CreateImage.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "entrySecurity": entrySecurity?.toJson(),
        "location": location?.toJson(),
        "entities": entities == null ? [] : List<dynamic>.from(entities!.map((x) => x.toJson())),
        "slNo": slNo,
        "inputDate": inputDate,
        "timeOfVisit": timeOfVisit,
        "officialCardVerified": officialCardVerified,
        "documentVerified": documentVerified,
        "visitorInUniform": visitorInUniform,
        "dbOfficialEmail": dbOfficialEmail,
        "dbOfficialAccompaniedEmail": dbOfficialAccompaniedEmail,
        "dbOfficialEmailDepartment": dbOfficialEmailDepartment?.toJson(),
        "visitPurpose": visitPurpose?.toJson(),
        "additionalInformation": additionalInformation,
        "visitingOfficials": visitingOfficials == null ? [] : List<dynamic>.from(visitingOfficials!.map((x) => x.toJson())),
        "mailList": mailList == null ? [] : List<dynamic>.from(mailList!.map((x) => x)),
         "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
    };
}

class DbOfficialEmailDepartment {
    int? id;

    DbOfficialEmailDepartment({
        this.id,
    });

    factory DbOfficialEmailDepartment.fromJson(Map<String, dynamic> json) => DbOfficialEmailDepartment(
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
    };
}

class MailList {
    int? groupId;
    String? name;
    bool? isSelected;

    MailList({
        this.groupId,
        this.name,
        this.isSelected = false,
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

class LawEntrySecurity {
    int? userId;

    LawEntrySecurity({
        this.userId,
    });

    factory LawEntrySecurity.fromJson(Map<String, dynamic> json) => LawEntrySecurity(
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
    };
}

class LawLocation {
    int? id;
    String? name;

    LawLocation({
        this.id,
        this.name,
    });

    factory LawLocation.fromJson(Map<String, dynamic> json) => LawLocation(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class VisitingOfficial {
    String? name;
    String? designation;
    String? address;
    String? contactNo;
    String? email;
    DbOfficialEmailDepartment? department;
    bool? mandatory;

    VisitingOfficial({
        this.name,
        this.designation,
        this.address,
        this.contactNo,
        this.email,
        this.department,
        this.mandatory,
    });

    factory VisitingOfficial.fromJson(Map<String, dynamic> json) => VisitingOfficial(
        name: json["name"],
        designation: json["designation"],
        address: json["address"],
        contactNo: json["contactNo"],
        email: json["email"],
        department: json["department"] == null ? null : DbOfficialEmailDepartment.fromJson(json["department"]),
        mandatory: json["mandatory"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "designation": designation,
        "address": address,
        "contactNo": contactNo,
        "email": email,
        "department": department?.toJson(),
        "mandatory": mandatory,
    };
}
