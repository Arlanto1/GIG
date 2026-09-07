// class LsmUserModel {
//   LsmUserModel({
//     required this.lsmUsers,
//   });
//   late final List<LsmUsers> lsmUsers;
//
//   LsmUserModel.fromJson(Map<String, dynamic> json){
//     lsmUsers = List.from(json['lsmUsers']).map((e)=>LsmUsers.fromJson(e)).toList();
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['lsmUsers'] = lsmUsers.map((e)=>e.toJson()).toList();
//     return _data;
//   }
// }
//
// class LsmUsers {
//   LsmUsers({
//     required this.userId,
//     required this.userName,
//     required this.email,
//     required this.firstName,
//     required this.lastName,
//     required this.phone,
//     required this.roles,
//     required this.roleExtensions,
//     required this.notApprovedRoles,
//     required this.notApprovedRoleExtensions,
//     this.employeeId,
//     required this.name,
//     required this.userInfo,
//     required this.userStatus,
//   });
//     int? userId;
//     String? userName;
//     String? email;
//     String? firstName;
//     String? lastName;
//     String? phone;
//     List<dynamic>? roles;
//     List<dynamic>? roleExtensions;
//     List<dynamic>? notApprovedRoles;
//     List<dynamic>? notApprovedRoleExtensions;
//     String? employeeId;
//     String? name;
//     String? userInfo;
//     String? userStatus;
//
//   LsmUsers.fromJson(Map<String, dynamic> json){
//     userId = json['userId'];
//     userName = json['userName'];
//     email = json['email'];
//     firstName = json['firstName'];
//     lastName = json['lastName'];
//     phone = json['phone'];
//     roles = List.castFrom<dynamic, dynamic>(json['roles']);
//     roleExtensions = List.castFrom<dynamic, dynamic>(json['roleExtensions']);
//     notApprovedRoles = List.castFrom<dynamic, dynamic>(json['notApprovedRoles']);
//     notApprovedRoleExtensions = List.castFrom<dynamic, dynamic>(json['notApprovedRoleExtensions']);
//     employeeId = null;
//     name = json['name'];
//     userInfo = json['userInfo'];
//     userStatus = json['userStatus'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['userId'] = userId;
//     _data['userName'] = userName;
//     _data['email'] = email;
//     _data['firstName'] = firstName;
//     _data['lastName'] = lastName;
//     _data['phone'] = phone;
//     _data['roles'] = roles;
//     _data['roleExtensions'] = roleExtensions;
//     _data['notApprovedRoles'] = notApprovedRoles;
//     _data['notApprovedRoleExtensions'] = notApprovedRoleExtensions;
//     _data['employeeId'] = employeeId;
//     _data['name'] = name;
//     _data['userInfo'] = userInfo;
//     _data['userStatus'] = userStatus;
//     return _data;
//   }
// }

class LsmUserModel {
  LsmUserModel({
    required this.lsmUsers,
  });

  List<LsmUsers> lsmUsers;

  LsmUserModel.fromJson(Map<String, dynamic> json)
      : lsmUsers = (json['lsmUsers'] as List?)
      ?.map((dynamic e) => LsmUsers.fromJson(e as Map<String, dynamic>))
      .toList() ??
      [];

  Map<String, dynamic> toJson() => {
    'lsmUsers': lsmUsers.map((e) => e.toJson()).toList(),
  };
}

class LsmUsers {
  LsmUsers({
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
    this.employeeId,
    this.name,
    this.userInfo,
    this.userStatus,
  });

  int? userId;
  String? userName;
  String? email;
  String? firstName;
  String? lastName;
  String? phone;
  List<dynamic>? roles;
  List<dynamic>? roleExtensions;
  List<dynamic>? notApprovedRoles;
  List<dynamic>? notApprovedRoleExtensions;
  // employeeId comes back as either an int or an empty string depending on
  // the user, so normalize via toString() instead of a hard `as String?`.
  String? employeeId;
  String? name;
  String? userInfo;
  String? userStatus;

  LsmUsers.fromJson(Map<String, dynamic> json)
      : userId = json['userId'] as int?,
        userName = json['userName'] as String?,
        email = json['email'] as String?,
        firstName = json['firstName'] as String?,
        lastName = json['lastName'] as String?,
        phone = json['phone'] as String?,
        roles = json['roles'] as List?,
        roleExtensions = json['roleExtensions'] as List?,
        notApprovedRoles = json['notApprovedRoles'] as List?,
        notApprovedRoleExtensions = json['notApprovedRoleExtensions'] as List?,
        employeeId = json['employeeId']?.toString(),
        name = json['name'] as String?,
        userInfo = json['userInfo'] as String?,
        userStatus = json['userStatus'] as String?;

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'userName': userName,
    'email': email,
    'firstName': firstName,
    'lastName': lastName,
    'phone': phone,
    'roles': roles,
    'roleExtensions': roleExtensions,
    'notApprovedRoles': notApprovedRoles,
    'notApprovedRoleExtensions': notApprovedRoleExtensions,
    'employeeId': employeeId,
    'name': name,
    'userInfo': userInfo,
    'userStatus': userStatus,
  };
}