//
// class OwnerUserModel {
//   OwnerUserModel({
//     required this.ownerType,
//     required this.locationId,
//     required this.users,
//   });
//   late final String ownerType;
//   late final int locationId;
//   late final List<ActionOwnerUser> users;
//
//   OwnerUserModel.fromJson(Map<String, dynamic> json){
//     ownerType = json['ownerType'];
//     locationId = json['locationId'];
//     users = List.from(json['users']).map((e)=>ActionOwnerUser.fromJson(e)).toList();
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['ownerType'] = ownerType;
//     _data['locationId'] = locationId;
//     _data['users'] = users.map((e)=>e.toJson()).toList();
//     return _data;
//   }
// }
//
//
// class ActionOwnerUser {
//   int? id;
//   String? userName;
//   String? email;
//   String? firstName;
//   String? lastName;
//   String? name;
//   String? userInfo;
//   String? employeeId;
//
//   ActionOwnerUser({
//     this.id,
//     this.userName,
//     this.email,
//     this.firstName,
//     this.lastName,
//     this.name,
//     this.userInfo,
//     this.employeeId,
//   });
//
//   ActionOwnerUser.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as int?,
//         userName = json['userName'] as String?,
//         email = json['email'] as String?,
//         firstName = json['firstName'] as String?,
//         lastName = json['lastName'] as String?,
//          name = json['name'] as String?,
//         userInfo = json['userInfo'] as String?,
//         employeeId = json['employeeId'] as String?;
//
//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'userName': userName,
//     'email': email,
//     'firstName': firstName,
//     'lastName': lastName,
//     'name': name,
//     'userInfo': userInfo,
//     'employeeId': employeeId
//   };
// }
//

class OwnerUserModel {
  OwnerUserModel({
    this.ownerType,
    this.locationId,
    required this.users,
  });

  String? ownerType;
  int? locationId;
  List<ActionOwnerUser> users;

  OwnerUserModel.fromJson(Map<String, dynamic> json)
      : ownerType = json['ownerType'] as String?,
        locationId = json['locationId'] as int?,
        users = (json['users'] as List?)
            ?.map((dynamic e) =>
            ActionOwnerUser.fromJson(e as Map<String, dynamic>))
            .toList() ??
            [];

  Map<String, dynamic> toJson() => {
    'ownerType': ownerType,
    'locationId': locationId,
    'users': users.map((e) => e.toJson()).toList(),
  };
}

class ActionOwnerUser {
  int? id;
  String? userName;
  String? email;
  String? firstName;
  String? lastName;
  String? name;
  String? userInfo;
  String? employeeId;

  ActionOwnerUser({
    this.id,
    this.userName,
    this.email,
    this.firstName,
    this.lastName,
    this.name,
    this.userInfo,
    this.employeeId,
  });

  ActionOwnerUser.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        userName = json['userName'] as String?,
        email = json['email'] as String?,
        firstName = json['firstName'] as String?,
        lastName = json['lastName'] as String?,
        name = json['name'] as String?,
        userInfo = json['userInfo'] as String?,
        employeeId = json['employeeId']?.toString();

  Map<String, dynamic> toJson() => {
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