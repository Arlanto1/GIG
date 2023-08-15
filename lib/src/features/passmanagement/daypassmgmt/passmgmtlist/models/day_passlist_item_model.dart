
// import 'dart:convert';

// DayPassListItemResponse dayPassListItemResponseFromJson(String str) => DayPassListItemResponse.fromJson(json.decode(str));

// String dayPassListItemResponseToJson(DayPassListItemResponse data) => json.encode(data.toJson());

// class DayPassListItemResponse {
//     int? id;
//     String? slNo;
//     String? inputDate;
//     CompanyType? location;
//     CompanyType? locationRegion;
//     List<PassEntity>? entities;
//     int? status;
//     String? modifiedDate;
//     String? modifiedBy;
//     List<History>? history;
//     EntrySecurity? entrySecurity;
//     EntrySecurity? handoverSecurity;
//     int? passType;
//     CompanyType? companyType;
//     String? companyName;
//     String? employeeName;
//     String? employeeId;
//     String? email;
//     EntrySecurity? host;
//     String? hostEmployeeId;
//     CompanyType? department;
//     CompanyType? dayPassReason;
//     bool? exceptionalApproval;
//     PassInfo? passInfo;
//     String? startTime;
//     String? endTime;
//     String? returnedTime;
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
//     List<FoundImage>? images;

//     DayPassListItemResponse({
//         this.id,
//         this.slNo,
//         this.inputDate,
//         this.location,
//         this.locationRegion,
//         this.entities,
//         this.status,
//         this.modifiedDate,
//         this.modifiedBy,
//         this.history,
//         this.entrySecurity,
//         this.handoverSecurity,
//         this.passType,
//         this.companyType,
//         this.companyName,
//         this.employeeName,
//         this.employeeId,
//         this.email,
//         this.host,
//         this.hostEmployeeId,
//         this.department,
//         this.dayPassReason,
//         this.exceptionalApproval,
//         this.passInfo,
//         this.startTime,
//         this.endTime,
//         this.returnedTime,
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
//         this.images,
//     });

//     factory DayPassListItemResponse.fromJson(Map<String, dynamic> json) => DayPassListItemResponse(
//         id: json["id"],
//         slNo: json["slNo"],
//         inputDate: json["inputDate"],
//         location: json["location"] == null ? null : CompanyType.fromJson(json["location"]),
//         locationRegion: json["locationRegion"] == null ? null : CompanyType.fromJson(json["locationRegion"]),
//         entities: json["entities"] == null ? [] : List<PassEntity>.from(json["entities"]!.map((x) => PassEntity.fromJson(x))),
//         status: json["status"],
//         modifiedDate: json["modifiedDate"],
//         modifiedBy: json["modifiedBy"],
//         history: json["history"] == null ? [] : List<History>.from(json["history"]!.map((x) => History.fromJson(x))),
//         entrySecurity: json["entrySecurity"] == null ? null : EntrySecurity.fromJson(json["entrySecurity"]),
//         handoverSecurity: json["handoverSecurity"] == null ? null : EntrySecurity.fromJson(json["handoverSecurity"]),
//         passType: json["passType"],
//         companyType: json["companyType"] == null ? null : CompanyType.fromJson(json["companyType"]),
//         companyName: json["companyName"],
//         employeeName: json["employeeName"],
//         employeeId: json["employeeId"],
//         email: json["email"],
//         host: json["host"] == null ? null : EntrySecurity.fromJson(json["host"]),
//         hostEmployeeId: json["hostEmployeeId"],
//         department: json["department"] == null ? null : CompanyType.fromJson(json["department"]),
//         dayPassReason: json["dayPassReason"] == null ? null : CompanyType.fromJson(json["dayPassReason"]),
//         exceptionalApproval: json["exceptionalApproval"],
//         passInfo: json["passInfo"] == null ? null : PassInfo.fromJson(json["passInfo"]),
//         startTime: json["startTime"],
//         endTime: json["endTime"],
//         returnedTime: json["returnedTime"],
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
//         images: json["images"] == null ? [] : List<FoundImage>.from(json["images"]!.map((x) => FoundImage.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "slNo": slNo,
//         "inputDate": inputDate,
//         "location": location?.toJson(),
//         "locationRegion": locationRegion?.toJson(),
//         "entities": entities == null ? [] : List<dynamic>.from(entities!.map((x) => x.toJson())),
//         "status": status,
//         "modifiedDate": modifiedDate,
//         "modifiedBy": modifiedBy,
//         "history": history == null ? [] : List<dynamic>.from(history!.map((x) => x.toJson())),
//         "entrySecurity": entrySecurity?.toJson(),
//         "handoverSecurity": handoverSecurity?.toJson(),
//         "passType": passType,
//         "companyType": companyType?.toJson(),
//         "companyName": companyName,
//         "employeeName": employeeName,
//         "employeeId": employeeId,
//         "email": email,
//         "host": host?.toJson(),
//         "hostEmployeeId": hostEmployeeId,
//         "department": department?.toJson(),
//         "dayPassReason": dayPassReason?.toJson(),
//         "exceptionalApproval": exceptionalApproval,
//         "passInfo": passInfo?.toJson(),
//         "startTime": startTime,
//         "endTime": endTime,
//         "returnedTime": returnedTime,
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
//         "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
//     };
// }
// class PassEntity {
//     int? id;
//     String? name;

//     PassEntity({
//         this.id,
//         this.name,
//     });

//     factory PassEntity.fromJson(Map<String, dynamic> json) => PassEntity(
//         id: json["id"],
//         name: json["name"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//     };
// }
// class CompanyType {
//     int? id;
//     String? name;

//     CompanyType({
//         this.id,
//         this.name,
//     });

//     factory CompanyType.fromJson(Map<String, dynamic> json) => CompanyType(
//         id: json["id"],
//         name: json["name"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
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


// class FoundImage {
//     int? id;
//     String? ownerName;
//     String? contentType;
//     int? uploadDate;
//     int? lawEnforcementId;
//     String? title;
//     int? fileSize;
//     String? imageContent;

//     FoundImage({
//         this.id,
//         this.ownerName,
//         this.contentType,
//         this.uploadDate,
//         this.lawEnforcementId,
//         this.title,
//         this.fileSize,
//         this.imageContent,
//     });

//     factory FoundImage.fromJson(Map<String, dynamic> json) => FoundImage(
//         id: json["id"],
//         ownerName: json["ownerName"],
//         contentType: json["contentType"],
//         uploadDate: json["uploadDate"],
//         lawEnforcementId: json["lawEnforcementId"],
//         title: json["title"],
//         fileSize: json["fileSize"],
//         imageContent: json["imageContent"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "ownerName": ownerName,
//         "contentType": contentType,
//         "uploadDate": uploadDate,
//         "lawEnforcementId": lawEnforcementId,
//         "title": title,
//         "fileSize": fileSize,
//         "imageContent": imageContent,
//     };
// }


// class RoleExtension {
//     int? roleExtensionId;
//     int? roleId;
//     DisplayName? displayName;
//     Area? area;
//     Filter? filter;
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
//         displayName: displayNameValues.map[json["displayName"]]!,
//         area: areaValues.map[json["area"]]!,
//         filter: filterValues.map[json["filter"]]!,
//         rootNodeId: json["rootNodeId"],
//         nodeId: json["nodeId"],
//         accessRight: json["accessRight"],
//     );

//     Map<String, dynamic> toJson() => {
//         "roleExtensionId": roleExtensionId,
//         "roleId": roleId,
//         "displayName": displayNameValues.reverse[displayName],
//         "area": areaValues.reverse[area],
//         "filter": filterValues.reverse[filter],
//         "rootNodeId": rootNodeId,
//         "nodeId": nodeId,
//         "accessRight": accessRight,
//     };
// }

// enum Area {
//     CATEGORY,
//     SOURCE_SYSTEM
// }

// final areaValues = EnumValues({
//     "Category": Area.CATEGORY,
//     "SourceSystem": Area.SOURCE_SYSTEM
// });

// enum DisplayName {
//     T1_USER_CATEGORY_DB_ATOM,
//     T1_USER_SOURCE_SYSTEM_DB_ATOM,
//     T1_USER_SOURCE_SYSTEM_DEFAULT
// }

// final displayNameValues = EnumValues({
//     "T1_User Category DB_ATOM": DisplayName.T1_USER_CATEGORY_DB_ATOM,
//     "T1_User Source System DB_ATOM": DisplayName.T1_USER_SOURCE_SYSTEM_DB_ATOM,
//     "T1_User Source System Default": DisplayName.T1_USER_SOURCE_SYSTEM_DEFAULT
// });

// enum Filter {
//     DB_ATOM,
//     DEFAULT
// }

// final filterValues = EnumValues({
//     "DB_ATOM": Filter.DB_ATOM,
//     "Default": Filter.DEFAULT
// });

// class Role {
//     int? roleId;
//     Application? application;
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
//         application: applicationValues.map[json["application"]]!,
//         roleName: json["roleName"],
//         roleExtensions: json["roleExtensions"] == null ? [] : List<RoleExtension>.from(json["roleExtensions"]!.map((x) => RoleExtension.fromJson(x))),
//         name: json["name"],
//     );

//     Map<String, dynamic> toJson() => {
//         "roleId": roleId,
//         "application": applicationValues.reverse[application],
//         "roleName": roleName,
//         "roleExtensions": roleExtensions == null ? [] : List<dynamic>.from(roleExtensions!.map((x) => x.toJson())),
//         "name": name,
//     };
// }
// enum Application {
//     DB_ATOM,
//     TRACKING1
// }

// final applicationValues = EnumValues({
//     "DB_ATOM": Application.DB_ATOM,
//     "Tracking1": Application.TRACKING1
// });

// class History {
//     int? id;
//     int? state;
//     int? action;
//     String? email;
//     int? actiontime;
//     String? parameters;

//     History({
//         this.id,
//         this.state,
//         this.action,
//         this.email,
//         this.actiontime,
//         this.parameters,
//     });

//     factory History.fromJson(Map<String, dynamic> json) => History(
//         id: json["id"],
//         state: json["state"],
//         action: json["action"],
//         email: json["email"],
//         actiontime: json["actiontime"],
//         parameters: json["parameters"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "state": state,
//         "action": action,
//         "email": email,
//         "actiontime": actiontime,
//         "parameters": parameters,
//     };
// }

// class PassInfo {
//     int? id;
//     int? passType;
//     String? passNo;
//     String? mifareNo;
//     String? expiryDate;
//     CompanyType? location;
//     CompanyType? region;
//     CompanyType? entity;
//     bool? dws;
//     int? status;

//     PassInfo({
//         this.id,
//         this.passType,
//         this.passNo,
//         this.mifareNo,
//         this.expiryDate,
//         this.location,
//         this.region,
//         this.entity,
//         this.dws,
//         this.status,
//     });

//     factory PassInfo.fromJson(Map<String, dynamic> json) => PassInfo(
//         id: json["id"],
//         passType: json["passType"],
//         passNo: json["passNo"],
//         mifareNo: json["mifareNo"],
//         expiryDate: json["expiryDate"],
//         location: json["location"] == null ? null : CompanyType.fromJson(json["location"]),
//         region: json["region"] == null ? null : CompanyType.fromJson(json["region"]),
//         entity: json["entity"] == null ? null : CompanyType.fromJson(json["entity"]),
//         dws: json["dws"],
//         status: json["status"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "passType": passType,
//         "passNo": passNo,
//         "mifareNo": mifareNo,
//         "expiryDate": expiryDate,
//         "location": location?.toJson(),
//         "region": region?.toJson(),
//         "entity": entity?.toJson(),
//         "dws": dws,
//         "status": status,
//     };
// }

// class EnumValues<T> {
//     Map<String, T> map;
//     late Map<T, String> reverseMap;

//     EnumValues(this.map);

//     Map<T, String> get reverse {
//         reverseMap = map.map((k, v) => MapEntry(v, k));
//         return reverseMap;
//     }
// }


// To parse this JSON data, do
//
//     final dayPassListItemResponse = dayPassListItemResponseFromJson(jsonString);

import 'dart:convert';

DayPassListItemResponse dayPassListItemResponseFromJson(String str) => DayPassListItemResponse.fromJson(json.decode(str));

String dayPassListItemResponseToJson(DayPassListItemResponse data) => json.encode(data.toJson());

class DayPassListItemResponse {
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
    EntrySecurity? entrySecurity;
    EntrySecurity? handoverSecurity;
    int? passType;
    CompanyType? companyType;
    String? companyName;
    String? employeeName;
    String? employeeId;
    String? email;
    EntrySecurity? host;
    String? hostEmployeeId;
    CompanyType? department;
    CompanyType? dayPassReason;
    CompanyType? vendorPassReason;
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
    String? entrySecurityName;
    String? escortedByName;
    String? passNo;
    String? handOverSecurityName;
    String? mifareNo;
    List<FoundImage>? images;
    List<FoundImage>? visitorImage;
    String? visitorName;

    DayPassListItemResponse({
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
        this.entrySecurityName,
        this.escortedByName,
        this.passNo,
        this.handOverSecurityName,
        this.mifareNo,
        this.images,
        this.visitorImage,
        this.visitorName,
        this.vendorPassReason,
    });

    factory DayPassListItemResponse.fromJson(Map<String, dynamic> json) => DayPassListItemResponse(
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
        entrySecurity: json["entrySecurity"] == null ? null : EntrySecurity.fromJson(json["entrySecurity"]),
        handoverSecurity: json["handoverSecurity"] == null ? null : EntrySecurity.fromJson(json["handoverSecurity"]),
        passType: json["passType"],
        companyType: json["companyType"] == null ? null : CompanyType.fromJson(json["companyType"]),
        companyName: json["companyName"],
        employeeName: json["employeeName"],
        employeeId: json["employeeId"],
        email: json["email"],
        visitorName: json["visitorName"],
        host: json["host"] == null ? null : EntrySecurity.fromJson(json["host"]),
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
        entrySecurityName: json["entrySecurityName"],
        escortedByName: json["escortedByName"],
        passNo: json["passNo"],
        handOverSecurityName: json["handOverSecurityName"],
        mifareNo: json["mifareNo"],
        images: json["images"] == null ? [] : List<FoundImage>.from(json["images"]!.map((x) => FoundImage.fromJson(x))),
        visitorImage: json["visitorImage"] == null ? [] : List<FoundImage>.from(json["visitorImage"]!.map((x) => FoundImage.fromJson(x))),
        vendorPassReason: json["vendorPassReason"] == null ? null : CompanyType.fromJson(json["vendorPassReason"]),
        
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
        "visitorName":visitorName,
        "host": host?.toJson(),
        "hostEmployeeId": hostEmployeeId,
        "department": department?.toJson(),
        "dayPassReason": dayPassReason?.toJson(),
        "vendorPassReason": vendorPassReason?.toJson(),
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
        "entrySecurityName": entrySecurityName,
        "escortedByName": escortedByName,
        "passNo": passNo,
        "handOverSecurityName": handOverSecurityName,
        "mifareNo": mifareNo,
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
        "visitorImage":visitorImage == null ? [] : List<dynamic>.from(visitorImage!.map((x) => x.toJson())),
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
        displayName: json["displayName"],
        area: areaValues.map[json["area"]]!,
        filter: filterValues.map[json["filter"]]!,
        rootNodeId: json["rootNodeId"],
        nodeId: json["nodeId"],
        accessRight: json["accessRight"],
    );

    Map<String, dynamic> toJson() => {
        "roleExtensionId": roleExtensionId,
        "roleId": roleId,
        "displayName": displayName,
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
        application: applicationValues.map[json["application"]]!,
        roleName: json["roleName"],
        roleExtensions: json["roleExtensions"] == null ? [] : List<RoleExtension>.from(json["roleExtensions"]!.map((x) => RoleExtension.fromJson(x))),
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "roleId": roleId,
        "application": applicationValues.reverse[application],
        "roleName": roleName,
        "roleExtensions": roleExtensions == null ? [] : List<dynamic>.from(roleExtensions!.map((x) => x.toJson())),
        "name": name,
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
