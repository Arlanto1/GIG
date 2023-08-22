import 'package:db_atom/src/features/material_movement/models/material_movements_model.dart';

import '../../../../models/department.dart';

class RatesResponse {
  final dynamic list;
  final List<GMRate>? items;
  final int? totalCount;
  final int? currentPageNo;
  final int? totalPageCount;

  RatesResponse({
    this.list,
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  RatesResponse.fromJson(Map<String, dynamic> json)
      : list = json['list'],
        items = (json['data'] as List?)?.map((dynamic e) => GMRate.fromJson(e as Map<String,dynamic>)).toList(),
        totalCount = json['totalCount'] as int?,
        currentPageNo = json['currentPageNo'] as int?,
        totalPageCount = json['totalPageCount'] as int?;

  Map<String, dynamic> toJson() => {
    'list' : list,
    'data' : items?.map((e) => e.toJson()).toList(),
    'totalCount' : totalCount,
    'currentPageNo' : currentPageNo,
    'totalPageCount' : totalPageCount
  };
}

class GMRate {
  final int? id;
  final String? slNo;
  final EntrySecurity? entrySecurity;
  final List<dynamic>? entities;
  final String? inputDate;
  final int? modifiedDate;
  final String? modifiedBy;
  final Department? vendor;
  final List<PayRate>? securityGuardRates;
  final List<PayRate>? securityOfficerRates;
  final List<PayRate>? securitySupervisorRates;
  final List<PayRate>? securityFacilitatorRates;
  final List<PayRate>? securityGunManRates;
  final List<History>? history;

  GMRate({
    this.id,
    this.slNo,
    this.entrySecurity,
    this.entities,
    this.inputDate,
    this.modifiedDate,
    this.modifiedBy,
    this.vendor,
    this.securityGuardRates,
    this.securityOfficerRates,
    this.securitySupervisorRates,
    this.securityFacilitatorRates,
    this.securityGunManRates,
    this.history,
  });

  GMRate.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        slNo = json['slNo'] as String?,
        entrySecurity = (json['entrySecurity'] as Map<String,dynamic>?) != null ? EntrySecurity.fromJson(json['entrySecurity'] as Map<String,dynamic>) : null,
        entities = json['entities'] as List?,
        inputDate = json['inputDate'] as String?,
        modifiedDate = json['modifiedDate'] as int?,
        modifiedBy = json['modifiedBy'] as String?,
        vendor = (json['vendor'] as Map<String,dynamic>?) != null ? Department.fromJson(json['vendor'] as Map<String,dynamic>) : null,
        securityGuardRates = (json['securityGuardRates'] as List?)?.map((dynamic e) => PayRate.fromJson(e as Map<String,dynamic>)).toList(),
        securityOfficerRates = (json['securityOfficerRates'] as List?)?.map((dynamic e) => PayRate.fromJson(e as Map<String,dynamic>)).toList(),
        securitySupervisorRates = (json['securitySupervisorRates'] as List?)?.map((dynamic e) => PayRate.fromJson(e as Map<String,dynamic>)).toList(),
        securityFacilitatorRates = (json['securityFacilitatorRates'] as List?)?.map((dynamic e) => PayRate.fromJson(e as Map<String,dynamic>)).toList(),
        securityGunManRates = (json['securityGunManRates'] as List?)?.map((dynamic e) => PayRate.fromJson(e as Map<String,dynamic>)).toList(),
        history = (json['history'] as List?)
            ?.map((dynamic e) => History.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
    'id' : id,
    'slNo' : slNo,
    'entrySecurity' : entrySecurity?.toJson(),
    'entities' : entities,
    'inputDate' : inputDate,
    'modifiedDate' : modifiedDate,
    'modifiedBy' : modifiedBy,
    'vendor' : vendor?.toJson(),
    'securityGuardRates' : securityGuardRates?.map((e) => e.toJson()).toList(),
    'securityOfficerRates' : securityOfficerRates?.map((e) => e.toJson()).toList(),
    'securitySupervisorRates' : securitySupervisorRates?.map((e) => e.toJson()).toList(),
    'securityFacilitatorRates' : securityFacilitatorRates?.map((e) => e.toJson()).toList(),
    'securityGunManRates' : securityGunManRates?.map((e) => e.toJson()).toList(),
    'history' : history
  };
}

class EntrySecurity {
  final int? userId;
  final String? userName;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final List<Roles>? roles;
  final List<RoleExtensions>? roleExtensions;
  final List<dynamic>? notApprovedRoles;
  final List<dynamic>? notApprovedRoleExtensions;
  final String? name;
  final String? userStatus;

  EntrySecurity({
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

  EntrySecurity.fromJson(Map<String, dynamic> json)
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
  final int? roleId;
  final String? application;
  final String? roleName;
  final List<RoleExtensions>? roleExtensions;
  final String? name;

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
        roleExtensions = (json['roleExtensions'] as List?)?.map((dynamic e) => RoleExtensions.fromJson(e as Map<String,dynamic>)).toList(),
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {
    'roleId' : roleId,
    'application' : application,
    'roleName' : roleName,
    'roleExtensions' : roleExtensions?.map((e) => e.toJson()).toList(),
    'name' : name
  };
}

class RoleExtensions {
  final int? roleExtensionId;
  final int? roleId;
  final String? displayName;
  final String? area;
  final String? filter;
  final dynamic rootNodeId;
  final dynamic nodeId;
  final dynamic accessRight;

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



class PayRate {
  final int? id;
  final int? rankId;
  final Department? vendor;
  final dynamic days;
  final dynamic perHour;
  final dynamic total;
  final dynamic fromDate;
  final dynamic toDate;
  final String? comment;

  PayRate({
    this.id,
    this.rankId,
    this.vendor,
    this.days,
    this.perHour,
    this.total,
    this.fromDate,
    this.toDate,
    this.comment,
  });

  PayRate.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        rankId = json['rankId'] as int?,
        vendor = (json['vendor'] as Map<String,dynamic>?) != null ? Department.fromJson(json['vendor'] as Map<String,dynamic>) : null,
        days = json['days'],
        perHour = json['perHour'],
        total = json['total'],
        fromDate = json['fromDate'],
        toDate = json['toDate'],
        comment = json['comment'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'rankId' : rankId,
    'vendor' : vendor?.toJson(),
    'days' : days,
    'perHour' : perHour,
    'total' : total,
    'fromDate' : fromDate,
    'toDate' : toDate,
    'comment' : comment
  };
}
