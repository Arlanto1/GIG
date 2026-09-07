// class DbSponsorUserModel {
//   DbSponsorUserModel({
//     required this.dbSponsorUsers,
//   });
//
//   List<DbSponsorUsers> dbSponsorUsers;
//
//   DbSponsorUserModel.fromJson(Map<String, dynamic> json)
//       : dbSponsorUsers = (json['dbSponsorUsers'] as List?)
//       ?.map((dynamic e) => DbSponsorUsers.fromJson(e as Map<String, dynamic>))
//       .toList() ??
//       [];
//
//   Map<String, dynamic> toJson() => {
//     'dbSponsorUsers': dbSponsorUsers.map((e) => e.toJson()).toList(),
//   };
// }
//
// class DbSponsorUsers {
//   DbSponsorUsers({
//     this.id,
//     this.userName,
//     this.email,
//     this.firstName,
//     this.lastName,
//     this.phone,
//     this.roles,
//     this.roleExtensions,
//     this.notApprovedRoles,
//     this.notApprovedRoleExtensions,
//     this.employeeId,
//     this.name,
//     this.userInfo,
//     this.userStatus,
//   });
//
//   int? id;
//   String? userName;
//   String? email;
//   String? firstName;
//   String? lastName;
//   String? phone;
//   List<dynamic>? roles;
//   List<dynamic>? roleExtensions;
//   List<dynamic>? notApprovedRoles;
//   List<dynamic>? notApprovedRoleExtensions;
//   // employeeId comes back as either an int or an empty string depending on
//   // the user, so normalize via toString() instead of a hard `as String?`.
//   String? employeeId;
//   String? name;
//   String? userInfo;
//   String? userStatus;
//
//   DbSponsorUsers.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as int?,
//         userName = json['userName'] as String?,
//         email = json['email'] as String?,
//         firstName = json['firstName'] as String?,
//         lastName = json['lastName'] as String?,
//         phone = json['phone'] as String?,
//         roles = json['roles'] as List?,
//         roleExtensions = json['roleExtensions'] as List?,
//         notApprovedRoles = json['notApprovedRoles'] as List?,
//         notApprovedRoleExtensions = json['notApprovedRoleExtensions'] as List?,
//         employeeId = json['employeeId']?.toString(),
//         name = json['name'] as String?,
//         userInfo = json['userInfo'] as String?,
//         userStatus = json['userStatus'] as String?;
//
//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'userName': userName,
//     'email': email,
//     'firstName': firstName,
//     'lastName': lastName,
//     'phone': phone,
//     'roles': roles,
//     'roleExtensions': roleExtensions,
//     'notApprovedRoles': notApprovedRoles,
//     'notApprovedRoleExtensions': notApprovedRoleExtensions,
//     'employeeId': employeeId,
//     'name': name,
//     'userInfo': userInfo,
//     'userStatus': userStatus,
//   };
// }


class DbSponsorUserModel {
  DbSponsorUserModel({
    this.locationId,
    required this.dbSponsorUsers,
  });

  int? locationId;
  List<DbSponsorUsers> dbSponsorUsers;

  DbSponsorUserModel.fromJson(Map<String, dynamic> json)
      :
        locationId = json['locationId'] as int?,
        dbSponsorUsers = (json['dbSponsorUsers'] as List?)
            ?.map((dynamic e) =>
            DbSponsorUsers.fromJson(e as Map<String, dynamic>))
            .toList() ??
            [];

  Map<String, dynamic> toJson() => {
    'locationId': locationId,
    'dbSponsorUsers': dbSponsorUsers.map((e) => e.toJson()).toList(),
  };
}

class DbSponsorUsers {
  int? id;
  String? userName;
  String? email;
  String? firstName;
  String? lastName;
  String? name;
  String? userInfo;
  String? employeeId;

  DbSponsorUsers({
    this.id,
    this.userName,
    this.email,
    this.firstName,
    this.lastName,
    this.name,
    this.userInfo,
    this.employeeId,
  });

  DbSponsorUsers.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        userName = json['userName'] as String?,
        email = json['email'] as String?,
        firstName = json['firstName'] as String?,
        lastName = json['lastName'] as String?,
        name = json['name'] as String?,
        userInfo = json['userInfo'] as String?,
        employeeId = json['employeeId']?.toString();

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'userName': userName,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'name': name,
        'userInfo': userInfo,
        'employeeId': employeeId,
      };
}