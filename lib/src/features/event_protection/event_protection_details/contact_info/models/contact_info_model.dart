import 'package:db_atom/src/models/role.dart';
import 'package:db_atom/src/models/role_extension.dart';

import '../../../../../models/organisation.dart';
import '../../../../material_movement/models/material_movements_model.dart';

class ContactInfoModel {
  ContactInfoModel({
    this.id,
    this.status,
    this.lsm1,
    this.lsm1ContactNo,
    this.lsm2,
    this.lsm2ContactNo,
    this.bu1,
    this.bu1ContactNo,
    this.bu2,
    this.bu2ContactNo,
    this.requesterDepartment,
    this.epOfficers,
    this.srh1,
    this.srh2,
    this.bu1Dept,
    this.bu2Dept,
    this.systemVendor1,
    this.systemVendor2,
    this.systemVendor3,
    this.systemVendor1ContactNo,
    this.systemVendor2ContactNo,
    this.systemVendor3ContactNo,
    this.vendor1Primary,
    this.vendor1PrimaryContact,
    this.vendor1Secondary,
    this.vendor1SecondaryContact,
    this.vendor2Primary,
    this.vendor2PrimaryContact,
    this.vendor2Secondary,
    this.vendor2SecondaryContact,
    this.vendor3Primary,
    this.vendor3PrimaryContact,
    this.vendor3Secondary,
    this.vendor3SecondaryContact,
    this.extraSecurityDeployed,
  });

  int? id;
  int? status;
  Lsm1? lsm1;
  String? lsm1ContactNo;
  Lsm2? lsm2;
  String? lsm2ContactNo;
  Bu1? bu1;
  String? bu1ContactNo;
  Bu2? bu2;
  String? bu2ContactNo;
  RequesterDepartment? requesterDepartment;
  String? epOfficers;
  Srh1? srh1;
  Srh2? srh2;
  Organisation? bu1Dept;
  Organisation? bu2Dept;
  EpManager1? epManager1;
  EpManager2? epManager2;
  String? systemVendor1;
  String? systemVendor2;
  String? systemVendor3;
  String? systemVendor1ContactNo;
  String? systemVendor2ContactNo;
  String? systemVendor3ContactNo;
  String? vendor1Primary;
  String? vendor1PrimaryContact;
  String? vendor1Secondary;
  String? vendor1SecondaryContact;
  String? vendor2Primary;
  String? vendor2PrimaryContact;
  String? vendor2Secondary;
  String? vendor2SecondaryContact;
  String? vendor3Primary;
  String? vendor3PrimaryContact;
  String? vendor3Secondary;
  String? vendor3SecondaryContact;
  bool? extraSecurityDeployed;

  ContactInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    lsm1 = Lsm1.fromJson(json['lsm1']);
    lsm1ContactNo = json['lsm1ContactNo'];
    lsm2 = Lsm2.fromJson(json['lsm2']);
    lsm2ContactNo = json['lsm2ContactNo'];
    bu1 = Bu1.fromJson(json['bu1']);
    bu1ContactNo = json['bu1ContactNo'];
    bu2 = Bu2.fromJson(json['bu2']);
    bu2ContactNo = json['bu2ContactNo'];
    epManager1 = EpManager1.fromJson(json['lsm1']);
    epManager2 = EpManager2.fromJson(json['lsm1']);
    requesterDepartment =
        RequesterDepartment.fromJson(json['requesterDepartment']);
    epOfficers = json['epOfficers'];
    srh1 = Srh1.fromJson(json['srh1']);
    srh2 = Srh2.fromJson(json['srh2']);
    bu1Dept = Organisation.fromJson(json['bu1Dept']);
    bu2Dept = Organisation.fromJson(json['bu2Dept']);
    systemVendor1 = json['systemVendor1'];
    systemVendor2 = json['systemVendor2'];
    systemVendor3 = json['systemVendor3'];
    systemVendor1ContactNo = json['systemVendor1ContactNo'];
    systemVendor2ContactNo = json['systemVendor2ContactNo'];
    systemVendor3ContactNo = json['systemVendor3ContactNo'];
    vendor1Primary = json['vendor1Primary'];
    vendor1PrimaryContact = json['vendor1PrimaryContact'];
    vendor1Secondary = json['vendor1Secondary'];
    vendor1SecondaryContact = json['vendor1SecondaryContact'];
    vendor2Primary = json['vendor2Primary'];
    vendor2PrimaryContact = json['vendor2PrimaryContact'];
    vendor2Secondary = json['vendor2Secondary'];
    vendor2SecondaryContact = json['vendor2SecondaryContact'];
    vendor3Primary = json['vendor3Primary'];
    vendor3PrimaryContact = json['vendor3PrimaryContact'];
    vendor3Secondary = json['vendor3Secondary'];
    vendor3SecondaryContact = json['vendor3SecondaryContact'];
    extraSecurityDeployed = json['extraSecurityDeployed'];
  }

  get annualPowerShutdown => null;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['lsm1'] = lsm1?.toJson();
    data['lsm1ContactNo'] = lsm1ContactNo;
    data['lsm2'] = lsm2?.toJson();
    data['lsm2ContactNo'] = lsm2ContactNo;
    data['bu1'] = bu1?.toJson();
    data['bu1ContactNo'] = bu1ContactNo;
    data['bu2'] = bu2?.toJson();
    data['bu2ContactNo'] = bu2ContactNo;
    data['requesterDepartment'] = requesterDepartment?.toJson();
    data['epOfficers'] = epOfficers;
    data['srh1'] = srh1?.toJson();
    data['srh2'] = srh2?.toJson();
    data['epManager1'] = epManager1?.toJson();
    data['epManager2'] = epManager2?.toJson();
    data['bu1Dept'] = bu1Dept?.toJson();
    data['bu2Dept'] = bu2Dept?.toJson();
    data['systemVendor1'] = systemVendor1;
    data['systemVendor2'] = systemVendor2;
    data['systemVendor3'] = systemVendor3;
    data['systemVendor1ContactNo'] = systemVendor1ContactNo;
    data['systemVendor2ContactNo'] = systemVendor2ContactNo;
    data['systemVendor3ContactNo'] = systemVendor3ContactNo;
    data['vendor1Primary'] = vendor1Primary;
    data['vendor1PrimaryContact'] = vendor1PrimaryContact;
    data['vendor1Secondary'] = vendor1Secondary;
    data['vendor1SecondaryContact'] = vendor1SecondaryContact;
    data['vendor2Primary'] = vendor2Primary;
    data['vendor2PrimaryContact'] = vendor2PrimaryContact;
    data['vendor2Secondary'] = vendor2Secondary;
    data['vendor2SecondaryContact'] = vendor2SecondaryContact;
    data['vendor3Primary'] = vendor3Primary;
    data['vendor3PrimaryContact'] = vendor3PrimaryContact;
    data['vendor3Secondary'] = vendor3Secondary;
    data['vendor3SecondaryContact'] = vendor3SecondaryContact;
    data['extraSecurityDeployed'] = extraSecurityDeployed;
    return data;
  }
}

class Lsm1 {
  Lsm1({
    required this.userId,
    required this.userName,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.roles,
    required this.roleExtensions,
    required this.notApprovedRoles,
    required this.notApprovedRoleExtensions,
    required this.name,
    required this.userStatus,
  });

  late final int userId;
  late final String userName;
  late final String email;
  late final String firstName;
  late final String lastName;
  late final String phone;
  late final List<Role> roles;
  late final List<RoleExtension> roleExtensions;
  late final List<dynamic> notApprovedRoles;
  late final List<dynamic> notApprovedRoleExtensions;
  late final String name;
  late final String userStatus;

  Lsm1.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    roles = List.from(json['roles']).map((e) => Role.fromJson(e)).toList();
    roleExtensions = List.from(json['roleExtensions'])
        .map((e) => RoleExtension.fromJson(e))
        .toList();
    notApprovedRoles =
        List.castFrom<dynamic, dynamic>(json['notApprovedRoles']);
    notApprovedRoleExtensions =
        List.castFrom<dynamic, dynamic>(json['notApprovedRoleExtensions']);
    name = json['name'];
    userStatus = json['userStatus'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['userName'] = userName;
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phone'] = phone;
    data['roles'] = roles.map((e) => e.toJson()).toList();
    data['roleExtensions'] = roleExtensions.map((e) => e.toJson()).toList();
    data['notApprovedRoles'] = notApprovedRoles;
    data['notApprovedRoleExtensions'] = notApprovedRoleExtensions;
    data['name'] = name;
    data['userStatus'] = userStatus;
    return data;
  }
}

class Lsm2 {
  Lsm2({
    required this.userId,
    required this.userName,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.roles,
    required this.roleExtensions,
    required this.notApprovedRoles,
    required this.notApprovedRoleExtensions,
    required this.name,
    required this.userStatus,
  });

  late final int userId;
  late final String userName;
  late final String email;
  late final String firstName;
  late final String lastName;
  late final String phone;
  late final List<Role> roles;
  late final List<RoleExtension> roleExtensions;
  late final List<dynamic> notApprovedRoles;
  late final List<dynamic> notApprovedRoleExtensions;
  late final String name;
  late final String userStatus;

  Lsm2.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    roles = List.from(json['roles']).map((e) => Role.fromJson(e)).toList();
    roleExtensions = List.from(json['roleExtensions'])
        .map((e) => RoleExtension.fromJson(e))
        .toList();
    notApprovedRoles =
        List.castFrom<dynamic, dynamic>(json['notApprovedRoles']);
    notApprovedRoleExtensions =
        List.castFrom<dynamic, dynamic>(json['notApprovedRoleExtensions']);
    name = json['name'];
    userStatus = json['userStatus'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['userName'] = userName;
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phone'] = phone;
    data['roles'] = roles.map((e) => e.toJson()).toList();
    data['roleExtensions'] = roleExtensions.map((e) => e.toJson()).toList();
    data['notApprovedRoles'] = notApprovedRoles;
    data['notApprovedRoleExtensions'] = notApprovedRoleExtensions;
    data['name'] = name;
    data['userStatus'] = userStatus;
    return data;
  }
}

class Bu1 {
  Bu1({
    required this.userId,
    required this.userName,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.roles,
    required this.roleExtensions,
    required this.notApprovedRoles,
    required this.notApprovedRoleExtensions,
    required this.name,
    required this.userStatus,
  });

  late final int userId;
  late final String userName;
  late final String email;
  late final String firstName;
  late final String lastName;
  late final String phone;
  late final List<Role> roles;
  late final List<RoleExtension> roleExtensions;
  late final List<dynamic> notApprovedRoles;
  late final List<dynamic> notApprovedRoleExtensions;
  late final String name;
  late final String userStatus;

  Bu1.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    roles = List.from(json['roles']).map((e) => Role.fromJson(e)).toList();
    roleExtensions = List.from(json['roleExtensions'])
        .map((e) => RoleExtension.fromJson(e))
        .toList();
    notApprovedRoles =
        List.castFrom<dynamic, dynamic>(json['notApprovedRoles']);
    notApprovedRoleExtensions =
        List.castFrom<dynamic, dynamic>(json['notApprovedRoleExtensions']);
    name = json['name'];
    userStatus = json['userStatus'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['userName'] = userName;
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phone'] = phone;
    data['roles'] = roles.map((e) => e.toJson()).toList();
    data['roleExtensions'] = roleExtensions.map((e) => e.toJson()).toList();
    data['notApprovedRoles'] = notApprovedRoles;
    data['notApprovedRoleExtensions'] = notApprovedRoleExtensions;
    data['name'] = name;
    data['userStatus'] = userStatus;
    return data;
  }
}

class Bu2 {
  Bu2({
    required this.userId,
    required this.userName,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.roles,
    required this.roleExtensions,
    required this.notApprovedRoles,
    required this.notApprovedRoleExtensions,
    required this.name,
    required this.userStatus,
  });

  late final int userId;
  late final String userName;
  late final String email;
  late final String firstName;
  late final String lastName;
  late final String phone;
  late final List<Role> roles;
  late final List<RoleExtension> roleExtensions;
  late final List<dynamic> notApprovedRoles;
  late final List<dynamic> notApprovedRoleExtensions;
  late final String name;
  late final String userStatus;

  Bu2.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    roles = List.from(json['roles']).map((e) => Role.fromJson(e)).toList();
    roleExtensions = List.from(json['roleExtensions'])
        .map((e) => RoleExtension.fromJson(e))
        .toList();
    notApprovedRoles =
        List.castFrom<dynamic, dynamic>(json['notApprovedRoles']);
    notApprovedRoleExtensions =
        List.castFrom<dynamic, dynamic>(json['notApprovedRoleExtensions']);
    name = json['name'];
    userStatus = json['userStatus'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['userName'] = userName;
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phone'] = phone;
    data['roles'] = roles.map((e) => e.toJson()).toList();
    data['roleExtensions'] = roleExtensions.map((e) => e.toJson()).toList();
    data['notApprovedRoles'] = notApprovedRoles;
    data['notApprovedRoleExtensions'] = notApprovedRoleExtensions;
    data['name'] = name;
    data['userStatus'] = userStatus;
    return data;
  }
}

class RequesterDepartment {
  RequesterDepartment({
    required this.id,
    required this.name,
  });

  late final int id;
  late final String name;

  RequesterDepartment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Srh1 {
  Srh1({
    required this.userId,
    required this.userName,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.roles,
    required this.roleExtensions,
    required this.notApprovedRoles,
    required this.notApprovedRoleExtensions,
    required this.name,
    required this.userStatus,
  });

  late final int userId;
  late final String userName;
  late final String email;
  late final String firstName;
  late final String lastName;
  late final String phone;
  late final List<Role> roles;
  late final List<RoleExtension> roleExtensions;
  late final List<dynamic> notApprovedRoles;
  late final List<dynamic> notApprovedRoleExtensions;
  late final String name;
  late final String userStatus;

  Srh1.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    roles = List.from(json['roles']).map((e) => Role.fromJson(e)).toList();
    roleExtensions = List.from(json['roleExtensions'])
        .map((e) => RoleExtension.fromJson(e))
        .toList();
    notApprovedRoles =
        List.castFrom<dynamic, dynamic>(json['notApprovedRoles']);
    notApprovedRoleExtensions =
        List.castFrom<dynamic, dynamic>(json['notApprovedRoleExtensions']);
    name = json['name'];
    userStatus = json['userStatus'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['userName'] = userName;
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phone'] = phone;
    data['roles'] = roles.map((e) => e.toJson()).toList();
    data['roleExtensions'] = roleExtensions.map((e) => e.toJson()).toList();
    data['notApprovedRoles'] = notApprovedRoles;
    data['notApprovedRoleExtensions'] = notApprovedRoleExtensions;
    data['name'] = name;
    data['userStatus'] = userStatus;
    return data;
  }
}

class Srh2 {
  Srh2({
    required this.userId,
    required this.userName,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.roles,
    required this.roleExtensions,
    required this.notApprovedRoles,
    required this.notApprovedRoleExtensions,
    required this.name,
    required this.userStatus,
  });

  late final int userId;
  late final String userName;
  late final String email;
  late final String firstName;
  late final String lastName;
  late final String phone;
  late final List<Role> roles;
  late final List<RoleExtension> roleExtensions;
  late final List<dynamic> notApprovedRoles;
  late final List<dynamic> notApprovedRoleExtensions;
  late final String name;
  late final String userStatus;

  Srh2.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    roles = List.from(json['roles']).map((e) => Role.fromJson(e)).toList();
    roleExtensions = List.from(json['roleExtensions'])
        .map((e) => RoleExtension.fromJson(e))
        .toList();
    notApprovedRoles =
        List.castFrom<dynamic, dynamic>(json['notApprovedRoles']);
    notApprovedRoleExtensions =
        List.castFrom<dynamic, dynamic>(json['notApprovedRoleExtensions']);
    name = json['name'];
    userStatus = json['userStatus'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['userName'] = userName;
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phone'] = phone;
    data['roles'] = roles.map((e) => e.toJson()).toList();
    data['roleExtensions'] = roleExtensions.map((e) => e.toJson()).toList();
    data['notApprovedRoles'] = notApprovedRoles;
    data['notApprovedRoleExtensions'] = notApprovedRoleExtensions;
    data['name'] = name;
    data['userStatus'] = userStatus;
    return data;
  }
}

class EpManager1 {
  EpManager1({
    required this.userId,
    required this.userName,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.roles,
    required this.roleExtensions,
    required this.notApprovedRoles,
    required this.notApprovedRoleExtensions,
    required this.name,
    required this.userStatus,
  });
  late final int userId;
  late final String userName;
  late final String email;
  late final String firstName;
  late final String lastName;
  late final String phone;
  late final List<Role> roles;
  late final List<RoleExtension> roleExtensions;
  late final List<dynamic> notApprovedRoles;
  late final List<dynamic> notApprovedRoleExtensions;
  late final String name;
  late final String userStatus;

  EpManager1.fromJson(Map<String, dynamic> json){
    userId = json['userId'];
    userName = json['userName'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    roles = List.from(json['roles']).map((e)=>Role.fromJson(e)).toList();
    roleExtensions = List.from(json['roleExtensions']).map((e)=>RoleExtension.fromJson(e)).toList();
    notApprovedRoles = List.castFrom<dynamic, dynamic>(json['notApprovedRoles']);
    notApprovedRoleExtensions = List.castFrom<dynamic, dynamic>(json['notApprovedRoleExtensions']);
    name = json['name'];
    userStatus = json['userStatus'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['userName'] = userName;
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phone'] = phone;
    data['roles'] = roles.map((e)=>e.toJson()).toList();
    data['roleExtensions'] = roleExtensions.map((e)=>e.toJson()).toList();
    data['notApprovedRoles'] = notApprovedRoles;
    data['notApprovedRoleExtensions'] = notApprovedRoleExtensions;
    data['name'] = name;
    data['userStatus'] = userStatus;
    return data;
  }
}
class EpManager2 {
  EpManager2({
    required this.userId,
    required this.userName,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.roles,
    required this.roleExtensions,
    required this.notApprovedRoles,
    required this.notApprovedRoleExtensions,
    required this.name,
    required this.userStatus,
  });
  late final int userId;
  late final String userName;
  late final String email;
  late final String firstName;
  late final String lastName;
  late final String phone;
  late final List<Role> roles;
  late final List<RoleExtension> roleExtensions;
  late final List<dynamic> notApprovedRoles;
  late final List<dynamic> notApprovedRoleExtensions;
  late final String name;
  late final String userStatus;

  EpManager2.fromJson(Map<String, dynamic> json){
    userId = json['userId'];
    userName = json['userName'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    roles = List.from(json['roles']).map((e)=>Role.fromJson(e)).toList();
    roleExtensions = List.from(json['roleExtensions']).map((e)=>RoleExtension.fromJson(e)).toList();
    notApprovedRoles = List.castFrom<dynamic, dynamic>(json['notApprovedRoles']);
    notApprovedRoleExtensions = List.castFrom<dynamic, dynamic>(json['notApprovedRoleExtensions']);
    name = json['name'];
    userStatus = json['userStatus'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['userName'] = userName;
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phone'] = phone;
    data['roles'] = roles.map((e)=>e.toJson()).toList();
    data['roleExtensions'] = roleExtensions.map((e)=>e.toJson()).toList();
    data['notApprovedRoles'] = notApprovedRoles;
    data['notApprovedRoleExtensions'] = notApprovedRoleExtensions;
    data['name'] = name;
    data['userStatus'] = userStatus;
    return data;
  }
}
