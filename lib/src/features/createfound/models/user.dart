import '../../../models/role.dart';
import '../../../models/role_extension.dart';

class User {
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
        roles = (json['roles'] as List?)?.map((dynamic e) => Role.fromJson(e as Map<String,dynamic>)).toList(),
        roleExtensions = (json['roleExtensions'] as List?)?.map((dynamic e) => RoleExtension.fromJson(e as Map<String,dynamic>)).toList(),
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
