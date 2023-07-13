import 'dart:convert';

CreateUserModel createUserModelFromJson(String str) => CreateUserModel.fromJson(json.decode(str));

String createUserModelToJson(CreateUserModel data) => json.encode(data.toJson());

class CreateUserModel {
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
  dynamic recertifiedBy;
  dynamic nextRecertificationDate;
  bool? deactivated;
  bool? expertMode;
  dynamic activeChange;
  dynamic theme;
  dynamic passwordChangedDate;
  String? name;
  String? userStatus;

  CreateUserModel({
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

  factory CreateUserModel.fromJson(Map<String, dynamic> json) => CreateUserModel(
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
        roleExtensions: json["roleExtensions"] == null
            ? []
            : List<RoleExtension>.from(
                json["roleExtensions"]!.map((x) => RoleExtension.fromJson(x))),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "roleId": roleId,
        "application": application,
        "roleName": roleName,
        "roleExtensions": roleExtensions == null
            ? []
            : List<dynamic>.from(roleExtensions!.map((x) => x.toJson())),
        "name": name,
      };
}
