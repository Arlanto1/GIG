// To parse this JSON data, do
//
//     final lawEnforcementDetails = lawEnforcementDetailsFromJson(jsonString);

import 'dart:convert';

import 'package:db_atom/src/features/lawenforcement/models/law_enforement_request.dart';
import 'package:db_atom/src/models/organisation.dart';

import '../../createfound/models/user.dart';

LawEnforcementDetails lawEnforcementDetailsFromJson(String str) => LawEnforcementDetails.fromJson(json.decode(str));

String lawEnforcementDetailsToJson(LawEnforcementDetails data) => json.encode(data.toJson());

class LawEnforcementDetails {
    int? id;
    String? slNo;
    String? inputDate;
    Organisation? location;
    Organisation? locationRegion;
    String? timeOfVisit;
    bool? officialCardVerified;
    Organisation? visitPurpose;
    bool? documentVerified;
    List<FoundImage>? images;
    List<Organisation>? entities;
    bool? visitorInUniform;
    String? dbOfficialEmail;
    Organisation? dbOfficialEmailDepartment;
    String? dbOfficialAccompaniedEmail;
    User? entrySecurity;
    String? additionalInformation;
    int? status;
    String? modifiedDate;
    String? modifiedBy;
    List<dynamic>? history;
    List<LawVisitingOfficial>? visitingOfficials;
    List<Organisation>? mailList;
    String? entityDesc;
    String? entrySecurityName;

    LawEnforcementDetails({
        this.id,
        this.slNo,
        this.inputDate,
        this.location,
        this.locationRegion,
        this.timeOfVisit,
        this.officialCardVerified,
        this.visitPurpose,
        this.documentVerified,
        this.images,
        this.entities,
        this.visitorInUniform,
        this.dbOfficialEmail,
        this.dbOfficialEmailDepartment,
        this.dbOfficialAccompaniedEmail,
        this.entrySecurity,
        this.additionalInformation,
        this.status,
        this.modifiedDate,
        this.modifiedBy,
        this.history,
        this.visitingOfficials,
        this.mailList,
        this.entityDesc,
        this.entrySecurityName,
    });

    factory LawEnforcementDetails.fromJson(Map<String, dynamic> json) => LawEnforcementDetails(
        id: json["id"],
        slNo: json["slNo"],
        inputDate: json["inputDate"],
        location: json["location"] == null ? null : Organisation.fromJson(json["location"]),
        locationRegion: json["locationRegion"] == null ? null : Organisation.fromJson(json["locationRegion"]),
        timeOfVisit: json["timeOfVisit"],
        officialCardVerified: json["officialCardVerified"],
        visitPurpose: json["visitPurpose"] == null ? null : Organisation.fromJson(json["visitPurpose"]),
        documentVerified: json["documentVerified"],
        images: json["images"] == null ? [] : List<FoundImage>.from(json["images"]!.map((x) => FoundImage.fromJson(x))),
        entities: json["entities"] == null ? [] : List<Organisation>.from(json["entities"]!.map((x) => Organisation.fromJson(x))),
        visitorInUniform: json["visitorInUniform"],
        dbOfficialEmail: json["dbOfficialEmail"],
        dbOfficialEmailDepartment: json["dbOfficialEmailDepartment"] == null ? null : Organisation.fromJson(json["dbOfficialEmailDepartment"]),
        dbOfficialAccompaniedEmail: json["dbOfficialAccompaniedEmail"],
        entrySecurity: json["entrySecurity"] == null ? null : User.fromJson(json["entrySecurity"]),
        additionalInformation: json["additionalInformation"],
        status: json["status"],
        modifiedDate: json["modifiedDate"],
        modifiedBy: json["modifiedBy"],
        history: json["history"] == null ? [] : List<dynamic>.from(json["history"]!.map((x) => x)),
        visitingOfficials: json["visitingOfficials"] == null ? [] : List<LawVisitingOfficial>.from(json["visitingOfficials"]!.map((x) => LawVisitingOfficial.fromJson(x))),
        mailList: json["mailList"] == null ? [] : List<Organisation>.from(json["mailList"]!.map((x) => Organisation.fromJson(x))),
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
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
        "entities": entities == null ? [] : List<dynamic>.from(entities!.map((x) => x.toJson())),
        "visitorInUniform": visitorInUniform,
        "dbOfficialEmail": dbOfficialEmail,
        "dbOfficialEmailDepartment": dbOfficialEmailDepartment?.toJson(),
        "dbOfficialAccompaniedEmail": dbOfficialAccompaniedEmail,
        "entrySecurity": entrySecurity?.toJson(),
        "additionalInformation": additionalInformation,
        "status": status,
        "modifiedDate": modifiedDate,
        "modifiedBy": modifiedBy,
        "history": history == null ? [] : List<dynamic>.from(history!.map((x) => x)),
        "visitingOfficials": visitingOfficials == null ? [] : List<dynamic>.from(visitingOfficials!.map((x) => x.toJson())),
        'mailList': mailList?.map((e) => e.toJson()).toList(),
        "entityDesc": entityDesc,
        "entrySecurityName": entrySecurityName,
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
        roleExtensions: json["roleExtensions"] == null ? [] : List<RoleExtension>.from(json["roleExtensions"]!.map((x) => RoleExtension.fromJson(x))),
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "roleId": roleId,
        "application": application,
        "roleName": roleName,
        "roleExtensions": roleExtensions == null ? [] : List<dynamic>.from(roleExtensions!.map((x) => x.toJson())),
        "name": name,
    };
}

class FoundImage {
    int? id;
    String? ownerName;
    String? contentType;
    int? uploadDate;
    int? lawEnforcementId;
    String? title;
    int? fileSize;
    String? imageContent;

    FoundImage({
        this.id,
        this.ownerName,
        this.contentType,
        this.uploadDate,
        this.lawEnforcementId,
        this.title,
        this.fileSize,
        this.imageContent,
    });

    factory FoundImage.fromJson(Map<String, dynamic> json) => FoundImage(
        id: json["id"],
        ownerName: json["ownerName"],
        contentType: json["contentType"],
        uploadDate: json["uploadDate"],
        lawEnforcementId: json["lawEnforcementId"],
        title: json["title"],
        fileSize: json["fileSize"],
        imageContent: json["imageContent"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "ownerName": ownerName,
        "contentType": contentType,
        "uploadDate": uploadDate,
        "lawEnforcementId": lawEnforcementId,
        "title": title,
        "fileSize": fileSize,
        "imageContent": imageContent,
    };
}

class LawVisitingOfficial {
    int? id;
    String? name;
    String? designation;
    Organisation? department;
    String? address;
    String? contactNo;
    String? email;
    bool? mandatory;

    LawVisitingOfficial({
        this.id,
        this.name,
        this.designation,
        this.department,
        this.address,
        this.contactNo,
        this.email,
        this.mandatory,
    });

    factory LawVisitingOfficial.fromJson(Map<String, dynamic> json) => LawVisitingOfficial(
        id: json["id"],
        name: json["name"],
        designation: json["designation"],
        department: json["department"] == null ? null : Organisation.fromJson(json["department"]),
        address: json["address"],
        contactNo: json["contactNo"],
        email: json["email"],
        mandatory: json["mandatory"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "designation": designation,
        "department": department?.toJson(),
        "address": address,
        "contactNo": contactNo,
        "email": email,
        "mandatory": mandatory,
    };
}
