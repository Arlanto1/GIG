// To parse this JSON data, do
//
//     final foundListModel = foundListModelFromJson(jsonString);

import 'dart:convert';

FoundListModel foundListModelFromJson(String str) => FoundListModel.fromJson(json.decode(str));

String foundListModelToJson(FoundListModel data) => json.encode(data.toJson());

class FoundListModel {
  List<FoundModel>? list;
  int? totalCount;
  int? currentPageNo;
  int? totalPageCount;

  FoundListModel({
    this.list,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  factory FoundListModel.fromJson(Map<String, dynamic> json) => FoundListModel(
        list: json["list"] == null
            ? []
            : List<FoundModel>.from(json["list"]!.map((x) => FoundModel.fromJson(x))),
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

class FoundModel {
  String? foundId;
  int? id;
  String? slNo;
  String? inputDate;
  int? typeOfAsset;
  String? foundDate;
  String? foundLocation;
  String? additionalInformation;
  int? quantity;
  String? color;
  List<dynamic>? images;
  bool? depositorDbEmp;
  Claimant? depositor;
  String? employeeId;
  bool? claimantDbEmp;
  bool? claimantConfirmByEmail;
  Claimant? claimant;
  bool? claimantNoSign;
  dynamic claimantSign;
  String? claimantEmployeeId;
  String? handoverDate;
  Claimant? entrySecurity;
  Claimant? handoverSecurity;
  int? status;
  String? modifiedDate;
  String? modifiedBy;
  dynamic eventProtection;
  String? depositorName;
  String? claimantName;
  String? locationName;
  String? entrySecurityName;
  String? handOverSecurityName;
  DepartmentName? depositorDepartmentName;
  DepartmentName? claimantDepartmentName;

  FoundModel({
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

  factory FoundModel.fromJson(Map<String, dynamic> json) => FoundModel(
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
        depositor: json["depositor"] == null ? null : Claimant.fromJson(json["depositor"]),
        employeeId: json["employeeId"],
        claimantDbEmp: json["claimantDbEmp"],
        claimantConfirmByEmail: json["claimantConfirmByEmail"],
        claimant: json["claimant"] == null ? null : Claimant.fromJson(json["claimant"]),
        claimantNoSign: json["claimantNoSign"],
        claimantSign: json["claimantSign"],
        claimantEmployeeId: json["claimantEmployeeId"],
        handoverDate: json["handoverDate"],
        entrySecurity:
            json["entrySecurity"] == null ? null : Claimant.fromJson(json["entrySecurity"]),
        handoverSecurity:
            json["handoverSecurity"] == null ? null : Claimant.fromJson(json["handoverSecurity"]),
        status: json["status"],
        modifiedDate: json["modifiedDate"],
        modifiedBy: json["modifiedBy"],
        eventProtection: json["eventProtection"],
        depositorName: json["depositorName"],
        claimantName: json["claimantName"],
        locationName: json["locationName"],
        entrySecurityName: json["entrySecurityName"],
        handOverSecurityName: json["handOverSecurityName"],
        depositorDepartmentName: departmentNameValues.map[json["depositorDepartmentName"]] ?? DepartmentName.EMPTY,
        claimantDepartmentName: departmentNameValues.map[json["claimantDepartmentName"]]  ?? DepartmentName.EMPTY,
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
        "claimant": claimant?.toJson(),
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
        "depositorDepartmentName": departmentNameValues.reverse[depositorDepartmentName],
        "claimantDepartmentName": departmentNameValues.reverse[claimantDepartmentName],
      };
}

class Claimant {
  int? userId;
  String? userName;
  String? email;
  String? password;
  String? firstName;
  String? lastName;
  Salutation? salutation;
  String? phone;
  String? mobile;
  String? fax;
  Location? location;
  Language? language;
  Timezone? timezone;
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
  Theme? theme;
  int? passwordChangedDate;
  String? name;
  UserStatus? userStatus;
  HibernateLazyInitializer? hibernateLazyInitializer;

  Claimant({
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
    this.hibernateLazyInitializer,
  });

  factory Claimant.fromJson(Map<String, dynamic> json) => Claimant(
        userId: json["userId"],
        userName: json["userName"],
        email: json["email"],
        password: json["password"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        salutation: salutationValues.map[json["salutation"]] ?? Salutation.EMPTY,
        phone: json["phone"],
        mobile: json["mobile"],
        fax: json["fax"],
        location: locationValues.map[json["location"]] ?? Location.EMPTY,
        language: languageValues.map[json["language"]] ?? Language.EN,
        timezone: timezoneValues.map[json["timezone"]] ?? Timezone.EUROPE_PARIS,
        roles: json["roles"] == null
            ? []
            : List<Role>.from(json["roles"]!.map((x) => Role.fromJson(x))),
        roleExtensions: json["roleExtensions"] == null
            ? []
            : List<RoleExtension>.from(
                json["roleExtensions"]!.map((x) => RoleExtension.fromJson(x))),
        notApprovedRoles: json["notApprovedRoles"] == null
            ? []
            : List<dynamic>.from(json["notApprovedRoles"]!.map((x) => x)),
        notApprovedRoleExtensions: json["notApprovedRoleExtensions"] == null
            ? []
            : List<dynamic>.from(json["notApprovedRoleExtensions"]!.map((x) => x)),
        recertificationDate: json["recertificationDate"],
        recertifiedBy: json["recertifiedBy"],
        nextRecertificationDate: json["nextRecertificationDate"],
        deactivated: json["deactivated"],
        expertMode: json["expertMode"],
        activeChange: json["activeChange"],
        theme: themeValues.map[json["theme"]] ?? Theme.BLUE,
        passwordChangedDate: json["passwordChangedDate"],
        name: json["name"],
        userStatus: userStatusValues.map[json["userStatus"]] ?? UserStatus.ACTIVE,
        hibernateLazyInitializer: json["hibernateLazyInitializer"] == null
            ? null
            : HibernateLazyInitializer.fromJson(json["hibernateLazyInitializer"]),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "userName": userName,
        "email": email,
        "password": password,
        "firstName": firstName,
        "lastName": lastName,
        "salutation": salutationValues.reverse[salutation],
        "phone": phone,
        "mobile": mobile,
        "fax": fax,
        "location": locationValues.reverse[location],
        "language": languageValues.reverse[language],
        "timezone": timezoneValues.reverse[timezone],
        "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x.toJson())),
        "roleExtensions": roleExtensions == null
            ? []
            : List<dynamic>.from(roleExtensions!.map((x) => x.toJson())),
        "notApprovedRoles":
            notApprovedRoles == null ? [] : List<dynamic>.from(notApprovedRoles!.map((x) => x)),
        "notApprovedRoleExtensions": notApprovedRoleExtensions == null
            ? []
            : List<dynamic>.from(notApprovedRoleExtensions!.map((x) => x)),
        "recertificationDate": recertificationDate,
        "recertifiedBy": recertifiedBy,
        "nextRecertificationDate": nextRecertificationDate,
        "deactivated": deactivated,
        "expertMode": expertMode,
        "activeChange": activeChange,
        "theme": themeValues.reverse[theme],
        "passwordChangedDate": passwordChangedDate,
        "name": name,
        "userStatus": userStatusValues.reverse[userStatus],
        "hibernateLazyInitializer": hibernateLazyInitializer?.toJson(),
      };
}

class HibernateLazyInitializer {
  HibernateLazyInitializer();

  factory HibernateLazyInitializer.fromJson(Map<String, dynamic> json) =>
      HibernateLazyInitializer();

  Map<String, dynamic> toJson() => {};
}

enum Language { EN }

final languageValues = EnumValues({"en": Language.EN});

enum Location { EMPTY, IN }

final locationValues = EnumValues({"": Location.EMPTY, "in": Location.IN});

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
        displayName: displayNameValues.map[json["displayName"]] ?? DisplayName.T1_ADMIN_SOURCE_SYSTEM_DEFAULT,
        area: areaValues.map[json["area"]] ?? Area.SOURCE_SYSTEM,
        filter: filterValues.map[json["filter"]] ?? Filter.DEFAULT,
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

enum Area { SOURCE_SYSTEM, CATEGORY }

final areaValues = EnumValues({"Category": Area.CATEGORY, "SourceSystem": Area.SOURCE_SYSTEM});

enum DisplayName {
  T1_USER_SOURCE_SYSTEM_DB_ATOM,
  T1_ANALYST_SOURCE_SYSTEM_DB_ATOM,
  T1_MANAGER_SOURCE_SYSTEM_DB_ATOM,
  T1_PERFORMER_SOURCE_SYSTEM_DB_ATOM,
  T1_ADMIN_SOURCE_SYSTEM_DB_ATOM,
  T1_ADMIN_CATEGORY_DB_ATOM,
  T1_ANALYST_CATEGORY_DB_ATOM,
  T1_MANAGER_CATEGORY_DB_ATOM,
  T1_PERFORMER_CATEGORY_DB_ATOM,
  T1_USER_CATEGORY_DB_ATOM,
  T1_ADMIN_SOURCE_SYSTEM_DEFAULT,
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

enum Filter { DB_ATOM, DEFAULT }

final filterValues = EnumValues({"DB_ATOM": Filter.DB_ATOM, "Default": Filter.DEFAULT});

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
        application: applicationValues.map[json["application"]] ?? Application.DB_ATOM,
        roleName: nameValues.map[json["roleName"]] ?? Name.ATOM_STATIC_USER,
        roleExtensions: json["roleExtensions"] == null
            ? []
            : List<RoleExtension>.from(
                json["roleExtensions"]!.map((x) => RoleExtension.fromJson(x))),
        name: nameValues.map[json["name"]] ?? Name.ATOM_STATIC_USER,
      );

  Map<String, dynamic> toJson() => {
        "roleId": roleId,
        "application": applicationValues.reverse[application],
        "roleName": nameValues.reverse[roleName],
        "roleExtensions": roleExtensions == null
            ? []
            : List<dynamic>.from(roleExtensions!.map((x) => x.toJson())),
        "name": nameValues.reverse[name],
      };
}

enum Application { TRACKING1, DB_ATOM }

final applicationValues =
    EnumValues({"DB_ATOM": Application.DB_ATOM, "Tracking1": Application.TRACKING1});

enum Name {
  T1_MANAGER,
  T1_ADMIN,
  T1_PERFORMER,
  T1_ANALYST,
  T1_USER,
  ATOM_STATIC_USER,
  T1_SUPER_ADMIN
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

enum Salutation { EMPTY, MR }

final salutationValues = EnumValues({"": Salutation.EMPTY, "Mr.": Salutation.MR});

enum Theme { BLUE }

final themeValues = EnumValues({"blue": Theme.BLUE});

enum Timezone { IST, EUROPE_PARIS }

final timezoneValues = EnumValues({"Europe/Paris": Timezone.EUROPE_PARIS, "IST": Timezone.IST});

enum UserStatus { ACTIVE }

final userStatusValues = EnumValues({"ACTIVE": UserStatus.ACTIVE});

enum DepartmentName { CORPORATE_SECURITY, EMPTY, DEPARTMENT1 }

final departmentNameValues = EnumValues({
  "Corporate Security": DepartmentName.CORPORATE_SECURITY,
  "Department1": DepartmentName.DEPARTMENT1,
  "": DepartmentName.EMPTY
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
