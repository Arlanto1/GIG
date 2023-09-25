class User {
  int? userId;
  String? userName;
  String? email;
  String? firstName;
  String? lastName;
  String? phone;
  List<Roles>? roles;
  List<RoleExtensions>? roleExtensions;
  List<dynamic>? notApprovedRoles;
  List<dynamic>? notApprovedRoleExtensions;
  String? name;
  String? userStatus;

  User({
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

  User.fromJson(Map<String, dynamic> json)
      : userId = json['userId'] as int?,
        userName = json['userName'] as String?,
        email = json['email'] as String?,
        firstName = json['firstName'] as String?,
        lastName = json['lastName'] as String?,
        phone = json['phone'] as String?,
        roles = (json['roles'] as List?)?.map((dynamic e) => Roles.fromJson(e as Map<String,dynamic>)).toList(),
        roleExtensions = (json['roleExtensions'] as List?)?.map((dynamic e) => RoleExtensions.fromJson(e as Map<String,dynamic>)).toList(),
        notApprovedRoles = json['notApprovedRoles'] as List?,
        notApprovedRoleExtensions = json['notApprovedRoleExtensions'] as List?,
        name = json['name'] as String?,
        userStatus = json['userStatus'] as String?;

  Map<String, dynamic> toJson() => {
    'userId' : userId,
    'userName' : userName,
    'email' : email,
    'firstName' : firstName,
    'lastName' : lastName,
    'phone' : phone,
    'roles' : roles?.map((e) => e.toJson()).toList(),
    'roleExtensions' : roleExtensions?.map((e) => e.toJson()).toList(),
    'notApprovedRoles' : notApprovedRoles,
    'notApprovedRoleExtensions' : notApprovedRoleExtensions,
    'name' : name,
    'userStatus' : userStatus
  };
}

class Roles {
  int? roleId;
  String? application;
  String? roleName;
  List<dynamic>? roleExtensions;
  String? name;

  Roles({
    this.roleId,
    this.application,
    this.roleName,
    this.roleExtensions,
    this.name,
  });

  Roles.fromJson(Map<String, dynamic> json)
      : roleId = json['roleId'] as int?,
        application = json['application'] as String?,
        roleName = json['roleName'] as String?,
        roleExtensions = json['roleExtensions'] as List?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {
    'roleId' : roleId,
    'application' : application,
    'roleName' : roleName,
    'roleExtensions' : roleExtensions,
    'name' : name
  };
}

class RoleExtensions {
  int? roleExtensionId;
  int? roleId;
  String? displayName;
  String? area;
  String? filter;
  dynamic rootNodeId;
  dynamic nodeId;
  dynamic accessRight;

  RoleExtensions({
    this.roleExtensionId,
    this.roleId,
    this.displayName,
    this.area,
    this.filter,
    this.rootNodeId,
    this.nodeId,
    this.accessRight,
  });

  RoleExtensions.fromJson(Map<String, dynamic> json)
      : roleExtensionId = json['roleExtensionId'] as int?,
        roleId = json['roleId'] as int?,
        displayName = json['displayName'] as String?,
        area = json['area'] as String?,
        filter = json['filter'] as String?,
        rootNodeId = json['rootNodeId'],
        nodeId = json['nodeId'],
        accessRight = json['accessRight'];

  Map<String, dynamic> toJson() => {
    'roleExtensionId' : roleExtensionId,
    'roleId' : roleId,
    'displayName' : displayName,
    'area' : area,
    'filter' : filter,
    'rootNodeId' : rootNodeId,
    'nodeId' : nodeId,
    'accessRight' : accessRight
  };
}