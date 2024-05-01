import 'package:db_atom/src/models/organisation.dart';

import '../../../../../models/history.dart';
import '../../../../../models/role.dart';
import '../../../../../models/role_extension.dart';
import '../../../../createfound/models/user.dart';
import 'day_passlist_model.dart';

class DayPassListResponse {
  final List<PassManagementModel>? items;
  final int? totalCount;
  final int? currentPageNo;
  final int? totalPageCount;

  DayPassListResponse({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  DayPassListResponse.fromJson(Map<String, dynamic> json)
      : items = (json['list'] as List?)
            ?.map((dynamic e) =>
                PassManagementModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        totalCount = json['totalCount'] as int?,
        currentPageNo = json['currentPageNo'] as int?,
        totalPageCount = json['totalPageCount'] as int?;

  Map<String, dynamic> toJson() => {
        'list': items?.map((e) => e.toJson()).toList(),
        'totalCount': totalCount,
        'currentPageNo': currentPageNo,
        'totalPageCount': totalPageCount
      };
}

class DayPassListItemResponse {
  final int? id;
  final String? slNo;
  final String? inputDate;
  final Organisation? location;
  final Organisation? locationRegion;
  final List<Organisation>? entities;
  final int? status;
  final String? modifiedDate;
  final String? modifiedBy;
  final List<History>? history;
  final User? entrySecurity;
  final HandoverSecurity? handoverSecurity;
  final int? passType;
  final Organisation? companyType;
  final String? companyName;
  final String? employeeName;
  final String? employeeId;
  final String? email;
  final String? hostEmployeeId;
  final bool? exceptionalApproval;
  final PassInfo? passInfo;
  final String? startTime;
  final String? endTime;
  final String? returnedTime;
  final List<dynamic>? evidenceDocuments;
  final String? contactNo;
  final bool? escortedByHost;
  final String? escortedBy;
  final String? escortedEmployeeId;
  final String? visitorComingFrom;
  final bool? idValidated;
  final int? idValidationType;
  final String? visitingPurpose;
  final int? category;
  final String? passIssuedOn;
  final String? hostName;
  final String? entrySecurityName;
  final String? escortedByName;
  final String? passNo;
  final String? handOverSecurityName;
  final String? mifareNo;

  DayPassListItemResponse({
    this.id,
    this.slNo,
    this.inputDate,
    this.location,
    this.locationRegion,
    this.entities,
    this.status,
    this.modifiedDate,
    this.modifiedBy,
    this.history,
    this.entrySecurity,
    this.handoverSecurity,
    this.passType,
    this.companyType,
    this.companyName,
    this.employeeName,
    this.employeeId,
    this.email,
    this.hostEmployeeId,
    this.exceptionalApproval,
    this.passInfo,
    this.startTime,
    this.endTime,
    this.returnedTime,
    this.evidenceDocuments,
    this.contactNo,
    this.escortedByHost,
    this.escortedBy,
    this.escortedEmployeeId,
    this.visitorComingFrom,
    this.idValidated,
    this.idValidationType,
    this.visitingPurpose,
    this.category,
    this.passIssuedOn,
    this.hostName,
    this.entrySecurityName,
    this.escortedByName,
    this.passNo,
    this.handOverSecurityName,
    this.mifareNo,
  });

  DayPassListItemResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        slNo = json['slNo'] as String?,
        inputDate = json['inputDate'] as String?,
        location = (json['location'] as Map<String, dynamic>?) != null
            ? Organisation.fromJson(json['location'] as Map<String, dynamic>)
            : null,
        locationRegion =
            (json['locationRegion'] as Map<String, dynamic>?) != null
                ? Organisation.fromJson(
                    json['locationRegion'] as Map<String, dynamic>)
                : null,
        entities = (json['entities'] as List?)
            ?.map(
                (dynamic e) => Organisation.fromJson(e as Map<String, dynamic>))
            .toList(),
        status = json['status'] as int?,
        modifiedDate = json['modifiedDate'] as String?,
        modifiedBy = json['modifiedBy'] as String?,
        history = (json['history'] as List?)
            ?.map((dynamic e) => History.fromJson(e as Map<String, dynamic>))
            .toList(),
        entrySecurity = (json['entrySecurity'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['entrySecurity'] as Map<String, dynamic>)
            : null,
        handoverSecurity =
            (json['handoverSecurity'] as Map<String, dynamic>?) != null
                ? HandoverSecurity.fromJson(
                    json['handoverSecurity'] as Map<String, dynamic>)
                : null,
        passType = json['passType'] as int?,
        companyType = (json['companyType'] as Map<String, dynamic>?) != null
            ? Organisation.fromJson(json['companyType'] as Map<String, dynamic>)
            : null,
        companyName = json['companyName'] as String?,
        employeeName = json['employeeName'] as String?,
        employeeId = json['employeeId'] as String?,
        email = json['email'] as String?,
        hostEmployeeId = json['hostEmployeeId'] as String?,
        exceptionalApproval = json['exceptionalApproval'] as bool?,
        passInfo = (json['passInfo'] as Map<String, dynamic>?) != null
            ? PassInfo.fromJson(json['passInfo'] as Map<String, dynamic>)
            : null,
        startTime = json['startTime'] as String?,
        endTime = json['endTime'] as String?,
        returnedTime = json['returnedTime'] as String?,
        evidenceDocuments = json['evidenceDocuments'] as List?,
        contactNo = json['contactNo'] as String?,
        escortedByHost = json['escortedByHost'] as bool?,
        escortedBy = json['escortedBy'] as String?,
        escortedEmployeeId = json['escortedEmployeeId'] as String?,
        visitorComingFrom = json['visitorComingFrom'] as String?,
        idValidated = json['idValidated'] as bool?,
        idValidationType = json['idValidationType'] as int?,
        visitingPurpose = json['visitingPurpose'] as String?,
        category = json['category'] as int?,
        passIssuedOn = json['passIssuedOn'] as String?,
        hostName = json['hostName'] as String?,
        entrySecurityName = json['entrySecurityName'] as String?,
        escortedByName = json['escortedByName'] as String?,
        passNo = json['passNo'] as String?,
        handOverSecurityName = json['handOverSecurityName'] as String?,
        mifareNo = json['mifareNo'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'slNo': slNo,
        'inputDate': inputDate,
        'location': location?.toJson(),
        'locationRegion': locationRegion?.toJson(),
        'entities': entities?.map((e) => e.toJson()).toList(),
        'status': status,
        'modifiedDate': modifiedDate,
        'modifiedBy': modifiedBy,
        'history': history?.map((e) => e.toJson()).toList(),
        'entrySecurity': entrySecurity?.toJson(),
        'handoverSecurity': handoverSecurity?.toJson(),
        'passType': passType,
        'companyType': companyType?.toJson(),
        'companyName': companyName,
        'employeeName': employeeName,
        'employeeId': employeeId,
        'email': email,
        'hostEmployeeId': hostEmployeeId,
        'exceptionalApproval': exceptionalApproval,
        'passInfo': passInfo?.toJson(),
        'startTime': startTime,
        'endTime': endTime,
        'returnedTime': returnedTime,
        'evidenceDocuments': evidenceDocuments,
        'contactNo': contactNo,
        'escortedByHost': escortedByHost,
        'escortedBy': escortedBy,
        'escortedEmployeeId': escortedEmployeeId,
        'visitorComingFrom': visitorComingFrom,
        'idValidated': idValidated,
        'idValidationType': idValidationType,
        'visitingPurpose': visitingPurpose,
        'category': category,
        'passIssuedOn': passIssuedOn,
        'hostName': hostName,
        'entrySecurityName': entrySecurityName,
        'escortedByName': escortedByName,
        'passNo': passNo,
        'handOverSecurityName': handOverSecurityName,
        'mifareNo': mifareNo
      };
}

class HandoverSecurity {
  final int? userId;
  final String? userName;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final List<Role>? roles;
  final List<RoleExtension>? roleExtensions;
  final List<dynamic>? notApprovedRoles;
  final List<dynamic>? notApprovedRoleExtensions;
  final String? name;
  final String? userStatus;

  HandoverSecurity({
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

  HandoverSecurity.fromJson(Map<String, dynamic> json)
      : userId = json['userId'] as int?,
        userName = json['userName'] as String?,
        email = json['email'] as String?,
        firstName = json['firstName'] as String?,
        lastName = json['lastName'] as String?,
        phone = json['phone'] as String?,
        roles = (json['roles'] as List?)
            ?.map((dynamic e) => Role.fromJson(e as Map<String, dynamic>))
            .toList(),
        roleExtensions = (json['roleExtensions'] as List?)
            ?.map((dynamic e) =>
                RoleExtension.fromJson(e as Map<String, dynamic>))
            .toList(),
        notApprovedRoles = json['notApprovedRoles'] as List?,
        notApprovedRoleExtensions = json['notApprovedRoleExtensions'] as List?,
        name = json['name'] as String?,
        userStatus = json['userStatus'] as String?;

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'userName': userName,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'roles': roles?.map((e) => e.toJson()).toList(),
        'roleExtensions': roleExtensions?.map((e) => e.toJson()).toList(),
        'notApprovedRoles': notApprovedRoles,
        'notApprovedRoleExtensions': notApprovedRoleExtensions,
        'name': name,
        'userStatus': userStatus
      };
}
