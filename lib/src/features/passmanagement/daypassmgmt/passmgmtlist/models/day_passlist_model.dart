// // To parse this JSON data, do
// //
// //     final dayPassListResponse = dayPassListResponseFromJson(jsonString);

// import 'dart:convert';

// DayPassListResponse dayPassListResponseFromJson(String str) => DayPassListResponse.fromJson(json.decode(str));

// String dayPassListResponseToJson(DayPassListResponse data) => json.encode(data.toJson());

// class DayPassListResponse {
//     List<DayPassListElement>? list;
//     int? totalCount;
//     int? currentPageNo;
//     int? totalPageCount;

//     DayPassListResponse({
//         this.list,
//         this.totalCount,
//         this.currentPageNo,
//         this.totalPageCount,
//     });

//     factory DayPassListResponse.fromJson(Map<String, dynamic> json) => DayPassListResponse(
//         list: json["list"] == null ? [] : List<DayPassListElement>.from(json["list"]!.map((x) => DayPassListElement.fromJson(x))),
//         totalCount: json["totalCount"],
//         currentPageNo: json["currentPageNo"],
//         totalPageCount: json["totalPageCount"],
//     );

//     Map<String, dynamic> toJson() => {
//         "list": list == null ? [] : List<dynamic>.from(list!.map((x) => x.toJson())),
//         "totalCount": totalCount,
//         "currentPageNo": currentPageNo,
//         "totalPageCount": totalPageCount,
//     };
// }

// class DayPassListElement {
//     int? id;
//     String? slNo;
//     String? inputDate;
//     Locationion? location;
//     Locationion? locationRegion;
//     List<dynamic>? entities;
//     int? status;
//     List<dynamic>? history;
//     EntrySecurity? entrySecurity;
//     int? passType;
//     String? companyName;
//     String? employeeName;
//     String? employeeId;
//     String? email;
//     String? hostEmployeeId;
//     bool? exceptionalApproval;
//     String? startTime;
//     String? endTime;
//     List<dynamic>? evidenceDocuments;
//     String? contactNo;
//     bool? escortedByHost;
//     String? escortedBy;
//     String? escortedEmployeeId;
//     String? visitorComingFrom;
//     bool? idValidated;
//     int? idValidationType;
//     String? visitingPurpose;
//     int? category;
//     String? hostName;
//     String? entrySecurityName;
//     String? escortedByName;
//     String? passNo;
//     String? handOverSecurityName;
//     String? mifareNo;

//     DayPassListElement({
//         this.id,
//         this.slNo,
//         this.inputDate,
//         this.location,
//         this.locationRegion,
//         this.entities,
//         this.status,
//         this.history,
//         this.entrySecurity,
//         this.passType,
//         this.companyName,
//         this.employeeName,
//         this.employeeId,
//         this.email,
//         this.hostEmployeeId,
//         this.exceptionalApproval,
//         this.startTime,
//         this.endTime,
//         this.evidenceDocuments,
//         this.contactNo,
//         this.escortedByHost,
//         this.escortedBy,
//         this.escortedEmployeeId,
//         this.visitorComingFrom,
//         this.idValidated,
//         this.idValidationType,
//         this.visitingPurpose,
//         this.category,
//         this.hostName,
//         this.entrySecurityName,
//         this.escortedByName,
//         this.passNo,
//         this.handOverSecurityName,
//         this.mifareNo,
//     });

//     factory DayPassListElement.fromJson(Map<String, dynamic> json) => DayPassListElement(
//         id: json["id"],
//         slNo: json["slNo"],
//         inputDate: json["inputDate"],
//         location: json["location"] == null ? null : Locationion.fromJson(json["location"]),
//         locationRegion: json["locationRegion"] == null ? null : Locationion.fromJson(json["locationRegion"]),
//         entities: json["entities"] == null ? [] : List<dynamic>.from(json["entities"]!.map((x) => x)),
//         status: json["status"],
//         history: json["history"] == null ? [] : List<dynamic>.from(json["history"]!.map((x) => x)),
//         entrySecurity: json["entrySecurity"] == null ? null : EntrySecurity.fromJson(json["entrySecurity"]),
//         passType: json["passType"],
//         companyName: json["companyName"],
//         employeeName: json["employeeName"],
//         employeeId: json["employeeId"],
//         email: json["email"],
//         hostEmployeeId: json["hostEmployeeId"],
//         exceptionalApproval: json["exceptionalApproval"],
//         startTime: json["startTime"],
//         endTime: json["endTime"],
//         evidenceDocuments: json["evidenceDocuments"] == null ? [] : List<dynamic>.from(json["evidenceDocuments"]!.map((x) => x)),
//         contactNo: json["contactNo"],
//         escortedByHost: json["escortedByHost"],
//         escortedBy: json["escortedBy"],
//         escortedEmployeeId: json["escortedEmployeeId"],
//         visitorComingFrom: json["visitorComingFrom"],
//         idValidated: json["idValidated"],
//         idValidationType: json["idValidationType"],
//         visitingPurpose: json["visitingPurpose"],
//         category: json["category"],
//         hostName: json["hostName"],
//         entrySecurityName: json["entrySecurityName"],
//         escortedByName: json["escortedByName"],
//         passNo: json["passNo"],
//         handOverSecurityName: json["handOverSecurityName"],
//         mifareNo: json["mifareNo"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "slNo": slNo,
//         "inputDate": inputDate,
//         "location": location?.toJson(),
//         "locationRegion": locationRegion?.toJson(),
//         "entities": entities == null ? [] : List<dynamic>.from(entities!.map((x) => x)),
//         "status": status,
//         "history": history == null ? [] : List<dynamic>.from(history!.map((x) => x)),
//         "entrySecurity": entrySecurity?.toJson(),
//         "passType": passType,
//         "companyName": companyName,
//         "employeeName": employeeName,
//         "employeeId": employeeId,
//         "email": email,
//         "hostEmployeeId": hostEmployeeId,
//         "exceptionalApproval": exceptionalApproval,
//         "startTime": startTime,
//         "endTime": endTime,
//         "evidenceDocuments": evidenceDocuments == null ? [] : List<dynamic>.from(evidenceDocuments!.map((x) => x)),
//         "contactNo": contactNo,
//         "escortedByHost": escortedByHost,
//         "escortedBy": escortedBy,
//         "escortedEmployeeId": escortedEmployeeId,
//         "visitorComingFrom": visitorComingFrom,
//         "idValidated": idValidated,
//         "idValidationType": idValidationType,
//         "visitingPurpose": visitingPurpose,
//         "category": category,
//         "hostName": hostName,
//         "entrySecurityName": entrySecurityName,
//         "escortedByName": escortedByName,
//         "passNo": passNo,
//         "handOverSecurityName": handOverSecurityName,
//         "mifareNo": mifareNo,
//     };
// }

// class EntrySecurity {
//     int? userId;
//     String? userName;
//     String? email;
//     String? firstName;
//     String? lastName;
//     String? phone;
//     List<Role>? roles;
//     List<RoleExtension>? roleExtensions;
//     List<dynamic>? notApprovedRoles;
//     List<dynamic>? notApprovedRoleExtensions;
//     String? name;
//     String? userStatus;

//     EntrySecurity({
//         this.userId,
//         this.userName,
//         this.email,
//         this.firstName,
//         this.lastName,
//         this.phone,
//         this.roles,
//         this.roleExtensions,
//         this.notApprovedRoles,
//         this.notApprovedRoleExtensions,
//         this.name,
//         this.userStatus,
//     });

//     factory EntrySecurity.fromJson(Map<String, dynamic> json) => EntrySecurity(
//         userId: json["userId"],
//         userName: json["userName"],
//         email: json["email"],
//         firstName: json["firstName"],
//         lastName: json["lastName"],
//         phone: json["phone"],
//         roles: json["roles"] == null ? [] : List<Role>.from(json["roles"]!.map((x) => Role.fromJson(x))),
//         roleExtensions: json["roleExtensions"] == null ? [] : List<RoleExtension>.from(json["roleExtensions"]!.map((x) => RoleExtension.fromJson(x))),
//         notApprovedRoles: json["notApprovedRoles"] == null ? [] : List<dynamic>.from(json["notApprovedRoles"]!.map((x) => x)),
//         notApprovedRoleExtensions: json["notApprovedRoleExtensions"] == null ? [] : List<dynamic>.from(json["notApprovedRoleExtensions"]!.map((x) => x)),
//         name: json["name"],
//         userStatus: json["userStatus"],
//     );

//     Map<String, dynamic> toJson() => {
//         "userId": userId,
//         "userName": userName,
//         "email": email,
//         "firstName": firstName,
//         "lastName": lastName,
//         "phone": phone,
//         "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x.toJson())),
//         "roleExtensions": roleExtensions == null ? [] : List<dynamic>.from(roleExtensions!.map((x) => x.toJson())),
//         "notApprovedRoles": notApprovedRoles == null ? [] : List<dynamic>.from(notApprovedRoles!.map((x) => x)),
//         "notApprovedRoleExtensions": notApprovedRoleExtensions == null ? [] : List<dynamic>.from(notApprovedRoleExtensions!.map((x) => x)),
//         "name": name,
//         "userStatus": userStatus,
//     };
// }

// class RoleExtension {
//     int? roleExtensionId;
//     int? roleId;
//     String? displayName;
//     String? area;
//     String? filter;
//     dynamic rootNodeId;
//     dynamic nodeId;
//     dynamic accessRight;

//     RoleExtension({
//         this.roleExtensionId,
//         this.roleId,
//         this.displayName,
//         this.area,
//         this.filter,
//         this.rootNodeId,
//         this.nodeId,
//         this.accessRight,
//     });

//     factory RoleExtension.fromJson(Map<String, dynamic> json) => RoleExtension(
//         roleExtensionId: json["roleExtensionId"],
//         roleId: json["roleId"],
//         displayName: json["displayName"],
//         area: json["area"],
//         filter: json["filter"],
//         rootNodeId: json["rootNodeId"],
//         nodeId: json["nodeId"],
//         accessRight: json["accessRight"],
//     );

//     Map<String, dynamic> toJson() => {
//         "roleExtensionId": roleExtensionId,
//         "roleId": roleId,
//         "displayName": displayName,
//         "area": area,
//         "filter": filter,
//         "rootNodeId": rootNodeId,
//         "nodeId": nodeId,
//         "accessRight": accessRight,
//     };
// }

// class Role {
//     int? roleId;
//     String? application;
//     String? roleName;
//     List<RoleExtension>? roleExtensions;
//     String? name;

//     Role({
//         this.roleId,
//         this.application,
//         this.roleName,
//         this.roleExtensions,
//         this.name,
//     });

//     factory Role.fromJson(Map<String, dynamic> json) => Role(
//         roleId: json["roleId"],
//         application: json["application"],
//         roleName: json["roleName"],
//         roleExtensions: json["roleExtensions"] == null ? [] : List<RoleExtension>.from(json["roleExtensions"]!.map((x) => RoleExtension.fromJson(x))),
//         name: json["name"],
//     );

//     Map<String, dynamic> toJson() => {
//         "roleId": roleId,
//         "application": application,
//         "roleName": roleName,
//         "roleExtensions": roleExtensions == null ? [] : List<dynamic>.from(roleExtensions!.map((x) => x.toJson())),
//         "name": name,
//     };
// }

// class Locationion {
//     int? id;
//     String? name;

//     Locationion({
//         this.id,
//         this.name,
//     });

//     factory Locationion.fromJson(Map<String, dynamic> json) => Locationion(
//         id: json["id"],
//         name: json["name"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//     };
// }

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
    CompanyType? location;
    CompanyType? locationRegion;
    List<CompanyType>? entities;
    int? status;
    String? modifiedDate;
    String? modifiedBy;
    List<History>? history;
    Employee? entrySecurity;
    Employee? handoverSecurity;
    int? passType;
    CompanyType? companyType;
    String? companyName;
    String? employeeName;
    String? employeeId;
    String? email;
    Employee? host;
    String? hostEmployeeId;
    CompanyType? department;
    CompanyType? dayPassReason;
    bool? exceptionalApproval;
    PassInfo? passInfo;
    String? startTime;
    String? endTime;
    String? returnedTime;
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
    String? passNo;
    String? entrySecurityName;
    String? escortedByName;
    String? handOverSecurityName;
    String? mifareNo;
    String? passIssuedOn;
    Employee? employee;

    DayPassListElement({
        this.id,
        this.slNo,
        this.inputDate,
        this.location,
        this.locationRegion,
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
    });

    factory DayPassListElement.fromJson(Map<String, dynamic> json) => DayPassListElement(
        id: json["id"],
        slNo: json["slNo"],
        inputDate: json["inputDate"],
        location: json["location"] == null ? null : CompanyType.fromJson(json["location"]),
        locationRegion: json["locationRegion"] == null ? null : CompanyType.fromJson(json["locationRegion"]),
        entities: json["entities"] == null ? [] : List<CompanyType>.from(json["entities"]!.map((x) => CompanyType.fromJson(x))),
        status: json["status"],
        modifiedDate: json["modifiedDate"],
        modifiedBy: json["modifiedBy"],
        history: json["history"] == null ? [] : List<History>.from(json["history"]!.map((x) => History.fromJson(x))),
        entrySecurity: json["entrySecurity"] == null ? null : Employee.fromJson(json["entrySecurity"]),
        handoverSecurity: json["handoverSecurity"] == null ? null : Employee.fromJson(json["handoverSecurity"]),
        passType: json["passType"],
        companyType: json["companyType"] == null ? null : CompanyType.fromJson(json["companyType"]),
        companyName: json["companyName"],
        employeeName: json["employeeName"],
        employeeId: json["employeeId"],
        email: json["email"],
        host: json["host"] == null ? null : Employee.fromJson(json["host"]),
        hostEmployeeId: json["hostEmployeeId"],
        department: json["department"] == null ? null : CompanyType.fromJson(json["department"]),
        dayPassReason: json["dayPassReason"] == null ? null : CompanyType.fromJson(json["dayPassReason"]),
        exceptionalApproval: json["exceptionalApproval"],
        passInfo: json["passInfo"] == null ? null : PassInfo.fromJson(json["passInfo"]),
        startTime: json["startTime"],
        endTime: json["endTime"],
        returnedTime: json["returnedTime"],
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
        passNo: json["passNo"],
        entrySecurityName: json["entrySecurityName"],
        escortedByName: json["escortedByName"],
        handOverSecurityName: json["handOverSecurityName"],
        mifareNo: json["mifareNo"],
        passIssuedOn: json["passIssuedOn"],
        employee: json["employee"] == null ? null : Employee.fromJson(json["employee"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "slNo": slNo,
        "inputDate": inputDate,
        "location": location?.toJson(),
        "locationRegion": locationRegion?.toJson(),
        "entities": entities == null ? [] : List<dynamic>.from(entities!.map((x) => x.toJson())),
        "status": status,
        "modifiedDate": modifiedDate,
        "modifiedBy": modifiedBy,
        "history": history == null ? [] : List<dynamic>.from(history!.map((x) => x.toJson())),
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
        "passNo": passNo,
        "entrySecurityName": entrySecurityName,
        "escortedByName": escortedByName,
        "handOverSecurityName": handOverSecurityName,
        "mifareNo": mifareNo,
        "passIssuedOn": passIssuedOn,
        "employee": employee?.toJson(),
    };
}

class CompanyType {
    int? id;
    String? name;

    CompanyType({
        this.id,
        this.name,
    });

    factory CompanyType.fromJson(Map<String, dynamic> json) => CompanyType(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class Employee {
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
    UserStatus? userStatus;

    Employee({
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

    factory Employee.fromJson(Map<String, dynamic> json) => Employee(
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
        userStatus: userStatusValues.map[json["userStatus"]]!,
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
        "userStatus": userStatusValues.reverse[userStatus],
    };
}

class RoleExtension {
    int? roleExtensionId;
    int? roleId;
    DisplayName? displayName;
    Area? area;
    Filter? filter;
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
        displayName: displayNameValues.map[json["displayName"]]!,
        area: areaValues.map[json["area"]]!,
        filter: filterValues.map[json["filter"]]!,
        rootNodeId: json["rootNodeId"],
        nodeId: json["nodeId"],
        accessRight: json["accessRight"],
    );

    Map<String, dynamic> toJson() => {
        "roleExtensionId": roleExtensionId,
        "roleId": roleId,
        "displayName": displayNameValues.reverse[displayName],
        "area": areaValues.reverse[area],
        "filter": filterValues.reverse[filter],
        "rootNodeId": rootNodeId,
        "nodeId": nodeId,
        "accessRight": accessRight,
    };
}

enum Area {
    CATEGORY,
    SOURCE_SYSTEM
}

final areaValues = EnumValues({
    "Category": Area.CATEGORY,
    "SourceSystem": Area.SOURCE_SYSTEM
});

enum DisplayName {
    T1_ADMIN_CATEGORY_DB_ATOM,
    T1_ADMIN_SOURCE_SYSTEM_DB_ATOM,
    T1_ADMIN_SOURCE_SYSTEM_DEFAULT,
    T1_ANALYST_CATEGORY_DB_ATOM,
    T1_ANALYST_SOURCE_SYSTEM_DB_ATOM,
    T1_MANAGER_CATEGORY_DB_ATOM,
    T1_MANAGER_SOURCE_SYSTEM_DB_ATOM,
    T1_PERFORMER_CATEGORY_DB_ATOM,
    T1_PERFORMER_SOURCE_SYSTEM_DB_ATOM,
    T1_USER_CATEGORY_DB_ATOM,
    T1_USER_SOURCE_SYSTEM_DB_ATOM,
    T1_USER_SOURCE_SYSTEM_DEFAULT
}

final displayNameValues = EnumValues({
    "T1_Admin Category DB_ATOM": DisplayName.T1_ADMIN_CATEGORY_DB_ATOM,
    "T1_Admin Source System DB_ATOM": DisplayName.T1_ADMIN_SOURCE_SYSTEM_DB_ATOM,
    "T1_Admin Source System Default": DisplayName.T1_ADMIN_SOURCE_SYSTEM_DEFAULT,
    "T1_Analyst Category DB_ATOM": DisplayName.T1_ANALYST_CATEGORY_DB_ATOM,
    "T1_Analyst Source System DB_ATOM": DisplayName.T1_ANALYST_SOURCE_SYSTEM_DB_ATOM,
    "T1_Manager Category DB_ATOM": DisplayName.T1_MANAGER_CATEGORY_DB_ATOM,
    "T1_Manager Source System DB_ATOM": DisplayName.T1_MANAGER_SOURCE_SYSTEM_DB_ATOM,
    "T1_Performer Category DB_ATOM": DisplayName.T1_PERFORMER_CATEGORY_DB_ATOM,
    "T1_Performer Source System DB_ATOM": DisplayName.T1_PERFORMER_SOURCE_SYSTEM_DB_ATOM,
    "T1_User Category DB_ATOM": DisplayName.T1_USER_CATEGORY_DB_ATOM,
    "T1_User Source System DB_ATOM": DisplayName.T1_USER_SOURCE_SYSTEM_DB_ATOM,
    "T1_User Source System Default": DisplayName.T1_USER_SOURCE_SYSTEM_DEFAULT
});

enum Filter {
    DB_ATOM,
    DEFAULT
}

final filterValues = EnumValues({
    "DB_ATOM": Filter.DB_ATOM,
    "Default": Filter.DEFAULT
});

class Role {
    int? roleId;
    Application? application;
    Name? roleName;
    List<RoleExtension>? roleExtensions;
    Name? name;

    Role({
        this.roleId,
        this.application,
        this.roleName,
        this.roleExtensions,
        this.name,
    });

    factory Role.fromJson(Map<String, dynamic> json) => Role(
        roleId: json["roleId"],
        application: applicationValues.map[json["application"]]!,
        roleName: nameValues.map[json["roleName"]]!,
        roleExtensions: json["roleExtensions"] == null ? [] : List<RoleExtension>.from(json["roleExtensions"]!.map((x) => RoleExtension.fromJson(x))),
        name: nameValues.map[json["name"]]!,
    );

    Map<String, dynamic> toJson() => {
        "roleId": roleId,
        "application": applicationValues.reverse[application],
        "roleName": nameValues.reverse[roleName],
        "roleExtensions": roleExtensions == null ? [] : List<dynamic>.from(roleExtensions!.map((x) => x.toJson())),
        "name": nameValues.reverse[name],
    };
}

enum Application {
    DB_ATOM,
    TRACKING1
}

final applicationValues = EnumValues({
    "DB_ATOM": Application.DB_ATOM,
    "Tracking1": Application.TRACKING1
});

enum Name {
    ATOM_STATIC_USER,
    T1_ADMIN,
    T1_ANALYST,
    T1_MANAGER,
    T1_PERFORMER,
    T1_SUPER_ADMIN,
    T1_USER
}

final nameValues = EnumValues({
    "ATOM_STATIC_USER": Name.ATOM_STATIC_USER,
    "T1_Admin": Name.T1_ADMIN,
    "T1_Analyst": Name.T1_ANALYST,
    "T1_Manager": Name.T1_MANAGER,
    "T1_Performer": Name.T1_PERFORMER,
    "T1_SuperAdmin": Name.T1_SUPER_ADMIN,
    "T1_User": Name.T1_USER
});

enum UserStatus {
    ACTIVE
}

final userStatusValues = EnumValues({
    "ACTIVE": UserStatus.ACTIVE
});

class History {
    int? id;
    int? state;
    int? action;
    String? email;
    int? actiontime;
    String? parameters;

    History({
        this.id,
        this.state,
        this.action,
        this.email,
        this.actiontime,
        this.parameters,
    });

    factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["id"],
        state: json["state"],
        action: json["action"],
        email: json["email"],
        actiontime: json["actiontime"],
        parameters: json["parameters"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "state": state,
        "action": action,
        "email": email,
        "actiontime": actiontime,
        "parameters": parameters,
    };
}

class PassInfo {
    int? id;
    int? passType;
    String? passNo;
    String? mifareNo;
    String? expiryDate;
    CompanyType? location;
    CompanyType? region;
    CompanyType? entity;
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
        location: json["location"] == null ? null : CompanyType.fromJson(json["location"]),
        region: json["region"] == null ? null : CompanyType.fromJson(json["region"]),
        entity: json["entity"] == null ? null : CompanyType.fromJson(json["entity"]),
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

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}

