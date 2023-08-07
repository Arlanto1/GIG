// To parse this JSON data, do
//
//     final dayPassListResponse = dayPassListResponseFromJson(jsonString);

import 'dart:convert';

DayPassListResponse dayPassListResponseFromJson(String str) => DayPassListResponse.fromJson(json.decode(str));

String dayPassListResponseToJson(DayPassListResponse data) => json.encode(data.toJson());

class DayPassListResponse {
    List<DayPassListElement>? list;
    int? totalCount;
    int? currentPageNo;
    int? totalPageCount;

    DayPassListResponse({
        this.list,
        this.totalCount,
        this.currentPageNo,
        this.totalPageCount,
    });

    factory DayPassListResponse.fromJson(Map<String, dynamic> json) => DayPassListResponse(
        list: json["list"] == null ? [] : List<DayPassListElement>.from(json["list"]!.map((x) => DayPassListElement.fromJson(x))),
        totalCount: json["totalCount"],
        currentPageNo: json["currentPageNo"],
        totalPageCount: json["totalPageCount"],
    );

    Map<String, dynamic> toJson() => {
        "list": list == null ? [] : List<dynamic>.from(list!.map((x) => x.toJson())),
        "totalCount": totalCount,
        "currentPageNo": currentPageNo,
        "totalPageCount": totalPageCount,
    };
}

class DayPassListElement {
    int? id;
    String? slNo;
    String? inputDate;
    Locationion? location;
    Locationion? locationRegion;
    List<dynamic>? entities;
    int? status;
    List<dynamic>? history;
    EntrySecurity? entrySecurity;
    int? passType;
    String? companyName;
    String? employeeName;
    String? employeeId;
    String? email;
    String? hostEmployeeId;
    bool? exceptionalApproval;
    String? startTime;
    String? endTime;
    List<dynamic>? evidenceDocuments;
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
    String? entrySecurityName;
    String? escortedByName;
    String? passNo;
    String? handOverSecurityName;
    String? mifareNo;

    DayPassListElement({
        this.id,
        this.slNo,
        this.inputDate,
        this.location,
        this.locationRegion,
        this.entities,
        this.status,
        this.history,
        this.entrySecurity,
        this.passType,
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
        this.escortedByName,
        this.passNo,
        this.handOverSecurityName,
        this.mifareNo,
    });

    factory DayPassListElement.fromJson(Map<String, dynamic> json) => DayPassListElement(
        id: json["id"],
        slNo: json["slNo"],
        inputDate: json["inputDate"],
        location: json["location"] == null ? null : Locationion.fromJson(json["location"]),
        locationRegion: json["locationRegion"] == null ? null : Locationion.fromJson(json["locationRegion"]),
        entities: json["entities"] == null ? [] : List<dynamic>.from(json["entities"]!.map((x) => x)),
        status: json["status"],
        history: json["history"] == null ? [] : List<dynamic>.from(json["history"]!.map((x) => x)),
        entrySecurity: json["entrySecurity"] == null ? null : EntrySecurity.fromJson(json["entrySecurity"]),
        passType: json["passType"],
        companyName: json["companyName"],
        employeeName: json["employeeName"],
        employeeId: json["employeeId"],
        email: json["email"],
        hostEmployeeId: json["hostEmployeeId"],
        exceptionalApproval: json["exceptionalApproval"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        evidenceDocuments: json["evidenceDocuments"] == null ? [] : List<dynamic>.from(json["evidenceDocuments"]!.map((x) => x)),
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
        entrySecurityName: json["entrySecurityName"],
        escortedByName: json["escortedByName"],
        passNo: json["passNo"],
        handOverSecurityName: json["handOverSecurityName"],
        mifareNo: json["mifareNo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "slNo": slNo,
        "inputDate": inputDate,
        "location": location?.toJson(),
        "locationRegion": locationRegion?.toJson(),
        "entities": entities == null ? [] : List<dynamic>.from(entities!.map((x) => x)),
        "status": status,
        "history": history == null ? [] : List<dynamic>.from(history!.map((x) => x)),
        "entrySecurity": entrySecurity?.toJson(),
        "passType": passType,
        "companyName": companyName,
        "employeeName": employeeName,
        "employeeId": employeeId,
        "email": email,
        "hostEmployeeId": hostEmployeeId,
        "exceptionalApproval": exceptionalApproval,
        "startTime": startTime,
        "endTime": endTime,
        "evidenceDocuments": evidenceDocuments == null ? [] : List<dynamic>.from(evidenceDocuments!.map((x) => x)),
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
        "entrySecurityName": entrySecurityName,
        "escortedByName": escortedByName,
        "passNo": passNo,
        "handOverSecurityName": handOverSecurityName,
        "mifareNo": mifareNo,
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
    List<dynamic>? notApprovedRoles;
    List<dynamic>? notApprovedRoleExtensions;
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
        this.notApprovedRoles,
        this.notApprovedRoleExtensions,
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
        roles: json["roles"] == null ? [] : List<Role>.from(json["roles"]!.map((x) => Role.fromJson(x))),
        roleExtensions: json["roleExtensions"] == null ? [] : List<RoleExtension>.from(json["roleExtensions"]!.map((x) => RoleExtension.fromJson(x))),
        notApprovedRoles: json["notApprovedRoles"] == null ? [] : List<dynamic>.from(json["notApprovedRoles"]!.map((x) => x)),
        notApprovedRoleExtensions: json["notApprovedRoleExtensions"] == null ? [] : List<dynamic>.from(json["notApprovedRoleExtensions"]!.map((x) => x)),
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
        "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x.toJson())),
        "roleExtensions": roleExtensions == null ? [] : List<dynamic>.from(roleExtensions!.map((x) => x.toJson())),
        "notApprovedRoles": notApprovedRoles == null ? [] : List<dynamic>.from(notApprovedRoles!.map((x) => x)),
        "notApprovedRoleExtensions": notApprovedRoleExtensions == null ? [] : List<dynamic>.from(notApprovedRoleExtensions!.map((x) => x)),
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

class Locationion {
    int? id;
    String? name;

    Locationion({
        this.id,
        this.name,
    });

    factory Locationion.fromJson(Map<String, dynamic> json) => Locationion(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
