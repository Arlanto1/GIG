// class SecuritySupervisorsModel {
//   SecuritySupervisorsModel({
//     required this.locationId,
//     required this.securitySupervisors,
//   });
//   late final int locationId;
//   late final List<SecuritySupervisors> securitySupervisors;
//
//   SecuritySupervisorsModel.fromJson(Map<String, dynamic> json){
//     locationId = json['locationId'];
//     securitySupervisors = List.from(json['securitySupervisors']).map((e)=>SecuritySupervisors.fromJson(e)).toList();
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['locationId'] = locationId;
//     _data['securitySupervisors'] = securitySupervisors.map((e)=>e.toJson()).toList();
//     return _data;
//   }
// }
//
// class SecuritySupervisors {
//   SecuritySupervisors({
//     required this.name,
//     required this.employeeId,
//     required this.id,
//     required this.email,
//   });
//   late final String name;
//   late final String employeeId;
//   late final int id;
//   late final String email;
//
//   SecuritySupervisors.fromJson(Map<String, dynamic> json){
//     name = json['name'];
//     employeeId = json['employeeId'];
//     id = json['id'];
//     email = json['email'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['name'] = name;
//     _data['employeeId'] = employeeId;
//     _data['id'] = id;
//     _data['email'] = email;
//     return _data;
//   }
// }

class SecuritySupervisorsModel {
  SecuritySupervisorsModel({
    this.locationId,
    required this.securitySupervisors,
  });

  int? locationId;
  List<SecuritySupervisors> securitySupervisors;

  SecuritySupervisorsModel.fromJson(Map<String, dynamic> json)
      : locationId = json['locationId'] as int?,
        securitySupervisors = (json['securitySupervisors'] as List?)
            ?.map((dynamic e) =>
            SecuritySupervisors.fromJson(e as Map<String, dynamic>))
            .toList() ??
            [];

  Map<String, dynamic> toJson() => {
    'locationId': locationId,
    'securitySupervisors':
    securitySupervisors.map((e) => e.toJson()).toList(),
  };
}

class SecuritySupervisors {
  SecuritySupervisors({
    this.name,
    this.employeeId,
    this.id,
    this.email,
  });

  String? name;
  // Same as LsmUsers.employeeId — API sends this as either int or empty
  // string depending on the user, so normalize with toString().
  String? employeeId;
  int? id;
  String? email;

  SecuritySupervisors.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        employeeId = json['employeeId']?.toString(),
        id = json['id'] as int?,
        email = json['email'] as String?;

  Map<String, dynamic> toJson() => {
    'name': name,
    'employeeId': employeeId,
    'id': id,
    'email': email,
  };
}