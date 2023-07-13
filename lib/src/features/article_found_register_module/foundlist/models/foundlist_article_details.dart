// To parse this JSON data, do
//
//     final foundListArticleDetails = foundListArticleDetailsFromJson(jsonString);

import 'dart:convert';

FoundListArticleDetails foundListArticleDetailsFromJson(String str) => FoundListArticleDetails.fromJson(json.decode(str));

String foundListArticleDetailsToJson(FoundListArticleDetails data) => json.encode(data.toJson());

class FoundListArticleDetails {
    String? foundId;
    int? id;
    String? slNo;
    int? inputDate;
    int? typeOfAsset;
    int? foundDate;
    String? foundLocation;
    String? additionalInformation;
    int? quantity;
    String? color;
    List<dynamic>? images;
    bool? depositorDbEmp;
    FoundDepositor? depositor;
    String? employeeId;
    bool? claimantDbEmp;
    bool? claimantConfirmByEmail;
    dynamic claimant;
    bool? claimantNoSign;
    dynamic claimantSign;
    String? claimantEmployeeId;
    int? handoverDate;
    FoundDepositor? entrySecurity;
    FoundDepositor? handoverSecurity;
    int? status;
    int? modifiedDate;
    String? modifiedBy;
    dynamic eventProtection;
    String? depositorName;
    String? claimantName;
    String? locationName;
    String? entrySecurityName;
    String? handOverSecurityName;
    String? depositorDepartmentName;
    String? claimantDepartmentName;

    FoundListArticleDetails({
        this.foundId,
        this.id,
        this.slNo,
        this.inputDate,
        this.typeOfAsset,
        this.foundDate,
        this.foundLocation,
        this.additionalInformation,
        this.quantity,
        this.color,
        this.images,
        this.depositorDbEmp,
        this.depositor,
        this.employeeId,
        this.claimantDbEmp,
        this.claimantConfirmByEmail,
        this.claimant,
        this.claimantNoSign,
        this.claimantSign,
        this.claimantEmployeeId,
        this.handoverDate,
        this.entrySecurity,
        this.handoverSecurity,
        this.status,
        this.modifiedDate,
        this.modifiedBy,
        this.eventProtection,
        this.depositorName,
        this.claimantName,
        this.locationName,
        this.entrySecurityName,
        this.handOverSecurityName,
        this.depositorDepartmentName,
        this.claimantDepartmentName,
    });

    factory FoundListArticleDetails.fromJson(Map<String, dynamic> json) => FoundListArticleDetails(
        foundId: json["foundId"],
        id: json["id"],
        slNo: json["slNo"],
        inputDate: json["inputDate"],
        typeOfAsset: json["typeOfAsset"],
        foundDate: json["foundDate"],
        foundLocation: json["foundLocation"],
        additionalInformation: json["additionalInformation"],
        quantity: json["quantity"],
        color: json["color"],
        images: json["images"] == null ? [] : List<dynamic>.from(json["images"]!.map((x) => x)),
        depositorDbEmp: json["depositorDbEmp"],
        depositor: json["depositor"] == null ? null : FoundDepositor.fromJson(json["depositor"]),
        employeeId: json["employeeId"],
        claimantDbEmp: json["claimantDbEmp"],
        claimantConfirmByEmail: json["claimantConfirmByEmail"],
        claimant: json["claimant"],
        claimantNoSign: json["claimantNoSign"],
        claimantSign: json["claimantSign"],
        claimantEmployeeId: json["claimantEmployeeId"],
        handoverDate: json["handoverDate"],
        entrySecurity: json["entrySecurity"] == null ? null : FoundDepositor.fromJson(json["entrySecurity"]),
        handoverSecurity: json["handoverSecurity"] == null ? null : FoundDepositor.fromJson(json["handoverSecurity"]),
        status: json["status"],
        modifiedDate: json["modifiedDate"],
        modifiedBy: json["modifiedBy"],
        eventProtection: json["eventProtection"],
        depositorName: json["depositorName"],
        claimantName: json["claimantName"],
        locationName: json["locationName"],
        entrySecurityName: json["entrySecurityName"],
        handOverSecurityName: json["handOverSecurityName"],
        depositorDepartmentName: json["depositorDepartmentName"],
        claimantDepartmentName: json["claimantDepartmentName"],
    );

    Map<String, dynamic> toJson() => {
        "foundId": foundId,
        "id": id,
        "slNo": slNo,
        "inputDate": inputDate,
        "typeOfAsset": typeOfAsset,
        "foundDate": foundDate,
        "foundLocation": foundLocation,
        "additionalInformation": additionalInformation,
        "quantity": quantity,
        "color": color,
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "depositorDbEmp": depositorDbEmp,
        "depositor": depositor?.toJson(),
        "employeeId": employeeId,
        "claimantDbEmp": claimantDbEmp,
        "claimantConfirmByEmail": claimantConfirmByEmail,
        "claimant": claimant,
        "claimantNoSign": claimantNoSign,
        "claimantSign": claimantSign,
        "claimantEmployeeId": claimantEmployeeId,
        "handoverDate": handoverDate,
        "entrySecurity": entrySecurity?.toJson(),
        "handoverSecurity": handoverSecurity?.toJson(),
        "status": status,
        "modifiedDate": modifiedDate,
        "modifiedBy": modifiedBy,
        "eventProtection": eventProtection,
        "depositorName": depositorName,
        "claimantName": claimantName,
        "locationName": locationName,
        "entrySecurityName": entrySecurityName,
        "handOverSecurityName": handOverSecurityName,
        "depositorDepartmentName": depositorDepartmentName,
        "claimantDepartmentName": claimantDepartmentName,
    };
}

class FoundDepositor {
    int? userId;
    String? userName;
    String? email;
    String? password;
    String? firstName;
    String? lastName;
    String? salutation;
    String? phone;
    String? mobile;
    String? fax;
    String? location;
    String? language;
    String? timezone;
    List<Role>? roles;
    List<RoleExtension>? roleExtensions;
    List<dynamic>? notApprovedRoles;
    List<dynamic>? notApprovedRoleExtensions;
    dynamic recertificationDate;
    String? recertifiedBy;
    dynamic nextRecertificationDate;
    bool? deactivated;
    bool? expertMode;
    dynamic activeChange;
    String? theme;
    dynamic passwordChangedDate;
    String? name;
    String? userStatus;

    FoundDepositor({
        this.userId,
        this.userName,
        this.email,
        this.password,
        this.firstName,
        this.lastName,
        this.salutation,
        this.phone,
        this.mobile,
        this.fax,
        this.location,
        this.language,
        this.timezone,
        this.roles,
        this.roleExtensions,
        this.notApprovedRoles,
        this.notApprovedRoleExtensions,
        this.recertificationDate,
        this.recertifiedBy,
        this.nextRecertificationDate,
        this.deactivated,
        this.expertMode,
        this.activeChange,
        this.theme,
        this.passwordChangedDate,
        this.name,
        this.userStatus,
    });

    factory FoundDepositor.fromJson(Map<String, dynamic> json) => FoundDepositor(
        userId: json["userId"],
        userName: json["userName"],
        email: json["email"],
        password: json["password"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        salutation: json["salutation"],
        phone: json["phone"],
        mobile: json["mobile"],
        fax: json["fax"],
        location: json["location"],
        language: json["language"],
        timezone: json["timezone"],
        roles: json["roles"] == null ? [] : List<Role>.from(json["roles"]!.map((x) => Role.fromJson(x))),
        roleExtensions: json["roleExtensions"] == null ? [] : List<RoleExtension>.from(json["roleExtensions"]!.map((x) => RoleExtension.fromJson(x))),
        notApprovedRoles: json["notApprovedRoles"] == null ? [] : List<dynamic>.from(json["notApprovedRoles"]!.map((x) => x)),
        notApprovedRoleExtensions: json["notApprovedRoleExtensions"] == null ? [] : List<dynamic>.from(json["notApprovedRoleExtensions"]!.map((x) => x)),
        recertificationDate: json["recertificationDate"],
        recertifiedBy: json["recertifiedBy"],
        nextRecertificationDate: json["nextRecertificationDate"],
        deactivated: json["deactivated"],
        expertMode: json["expertMode"],
        activeChange: json["activeChange"],
        theme: json["theme"],
        passwordChangedDate: json["passwordChangedDate"],
        name: json["name"],
        userStatus: json["userStatus"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "userName": userName,
        "email": email,
        "password": password,
        "firstName": firstName,
        "lastName": lastName,
        "salutation": salutation,
        "phone": phone,
        "mobile": mobile,
        "fax": fax,
        "location": location,
        "language": language,
        "timezone": timezone,
        "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x.toJson())),
        "roleExtensions": roleExtensions == null ? [] : List<dynamic>.from(roleExtensions!.map((x) => x.toJson())),
        "notApprovedRoles": notApprovedRoles == null ? [] : List<dynamic>.from(notApprovedRoles!.map((x) => x)),
        "notApprovedRoleExtensions": notApprovedRoleExtensions == null ? [] : List<dynamic>.from(notApprovedRoleExtensions!.map((x) => x)),
        "recertificationDate": recertificationDate,
        "recertifiedBy": recertifiedBy,
        "nextRecertificationDate": nextRecertificationDate,
        "deactivated": deactivated,
        "expertMode": expertMode,
        "activeChange": activeChange,
        "theme": theme,
        "passwordChangedDate": passwordChangedDate,
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

enum Area { SOURCE_SYSTEM, CATEGORY }

final areaValues = EnumValues({
    "Category": Area.CATEGORY,
    "SourceSystem": Area.SOURCE_SYSTEM
});

enum Filter { DB_ATOM, DEFAULT }

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

enum Application { TRACKING1, DB_ATOM }

final applicationValues = EnumValues({
    "DB_ATOM": Application.DB_ATOM,
    "Tracking1": Application.TRACKING1
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
