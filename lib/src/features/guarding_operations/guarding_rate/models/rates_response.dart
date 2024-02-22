import 'package:db_atom/src/models/role_extension.dart';

import '../../../../models/organisation.dart';
import '../../../createfound/models/user.dart';

class RatesResponse {
  List<GMRate>? items;
  num? totalCount;
  num? currentPageNo;
  num? totalPageCount;

  RatesResponse({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  RatesResponse.fromJson(Map<String, dynamic> json)
      : items = (json['data'] as List?)
            ?.map((dynamic e) => GMRate.fromJson(e as Map<String, dynamic>))
            .toList(),
        totalCount = json['totalCount'] as num?,
        currentPageNo = json['currentPageNo'] as num?,
        totalPageCount = json['totalPageCount'] as num?;

  Map<String, dynamic> toJson() => {
        'data': items?.map((e) => e.toJson()).toList(),
        'totalCount': totalCount,
        'currentPageNo': currentPageNo,
        'totalPageCount': totalPageCount
      };
}

class GMRate {
  int? id;
  String? slNo;
  Organisation? location;
  Organisation? locationRegion;
  User? entrySecurity;
  List<Organisation>? entities;
  String? inputDate;

  // num? modifiedDate;
  String? modifiedBy;
  Organisation? vendor;
  List<PayRate>? securityGuardRates;
  List<PayRate>? securityOfficerRates;
  List<PayRate>? securitySupervisorRates;
  List<PayRate>? securityFacilitatorRates;
  List<PayRate>? securityGunManRates;
  List<PayRate>? otherRates;
  List<dynamic>? history;

  GMRate({
    this.id,
    this.slNo,
    this.location,
    this.locationRegion,
    this.entrySecurity,
    this.entities,
    this.inputDate,
    // this.modifiedDate,
    this.modifiedBy,
    this.vendor,
    this.securityGuardRates,
    this.securityOfficerRates,
    this.securitySupervisorRates,
    this.securityFacilitatorRates,
    this.securityGunManRates,
    this.otherRates,
    this.history,
  });

  GMRate.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        slNo = json['slNo'] as String?,
        location = (json['location'] as Map<String, dynamic>?) != null
            ? Organisation.fromJson(json['location'] as Map<String, dynamic>)
            : null,
        locationRegion =
            (json['locationRegion'] as Map<String, dynamic>?) != null
                ? Organisation.fromJson(
                    json['locationRegion'] as Map<String, dynamic>)
                : null,
        entrySecurity = (json['entrySecurity'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['entrySecurity'] as Map<String, dynamic>)
            : null,
        entities = (json['entities'] as List?)
            ?.map(
                (dynamic e) => Organisation.fromJson(e as Map<String, dynamic>))
            .toList(),
        inputDate = json['inputDate'] as String?,
        // modifiedDate = json['modifiedDate'] as num?,
        modifiedBy = json['modifiedBy'] as String?,
        vendor = (json['vendor'] as Map<String, dynamic>?) != null
            ? Organisation.fromJson(json['vendor'] as Map<String, dynamic>)
            : null,
        securityGuardRates = (json['securityGuardRates'] as List?)
            ?.map((dynamic e) => PayRate.fromJson(e as Map<String, dynamic>))
            .toList(),
        securityOfficerRates = (json['securityOfficerRates'] as List?)
            ?.map((dynamic e) => PayRate.fromJson(e as Map<String, dynamic>))
            .toList(),
        securitySupervisorRates = (json['securitySupervisorRates'] as List?)
            ?.map((dynamic e) => PayRate.fromJson(e as Map<String, dynamic>))
            .toList(),
        securityFacilitatorRates = (json['securityFacilitatorRates'] as List?)
            ?.map((dynamic e) => PayRate.fromJson(e as Map<String, dynamic>))
            .toList(),
        securityGunManRates = (json['securityGunManRates'] as List?)
            ?.map((dynamic e) => PayRate.fromJson(e as Map<String, dynamic>))
            .toList(),
        otherRates = (json['otherRates'] as List?)
            ?.map((dynamic e) => PayRate.fromJson(e as Map<String, dynamic>))
            .toList(),
        history = json['history'] as List?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'slNo': slNo,
        'location': location?.toJson(),
        'locationRegion': locationRegion?.toJson(),
        'entrySecurity': entrySecurity?.toJson(),
        'entities': entities,
        'inputDate': inputDate,
        // 'modifiedDate': modifiedDate,
        'modifiedBy': modifiedBy,
        'vendor': vendor?.toJson(),
        'securityGuardRates':
            securityGuardRates?.map((e) => e.toJson()).toList(),
        'securityOfficerRates':
            securityOfficerRates?.map((e) => e.toJson()).toList(),
        'securitySupervisorRates':
            securitySupervisorRates?.map((e) => e.toJson()).toList(),
        'securityFacilitatorRates':
            securityFacilitatorRates?.map((e) => e.toJson()).toList(),
        'securityGunManRates':
            securityGunManRates?.map((e) => e.toJson()).toList(),
        'otherRates': otherRates?.map((e) => e.toJson()).toList(),
        'history': history
      };
}

class Roles {
  num? roleId;
  String? application;
  String? roleName;
  List<RoleExtension>? roleExtensions;
  String? name;

  Roles({
    this.roleId,
    this.application,
    this.roleName,
    this.roleExtensions,
    this.name,
  });

  Roles.fromJson(Map<String, dynamic> json)
      : roleId = json['roleId'] as num?,
        application = json['application'] as String?,
        roleName = json['roleName'] as String?,
        roleExtensions = (json['roleExtensions'] as List?)
            ?.map((dynamic e) =>
                RoleExtension.fromJson(e as Map<String, dynamic>))
            .toList(),
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {
        'roleId': roleId,
        'application': application,
        'roleName': roleName,
        'roleExtensions': roleExtensions?.map((e) => e.toJson()).toList(),
        'name': name
      };
}

class PayRate {
  int? id;
  num? rankId;
  Organisation? vendor;
  num? days;
  double? perHour;
  num? total;
  String? fromDate;
  String? toDate;
  String? comment;

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
        rankId = json['rankId'] as num?,
        vendor = (json['vendor'] as Map<String, dynamic>?) != null
            ? Organisation.fromJson(json['vendor'] as Map<String, dynamic>)
            : null,
        days = json['days'] as num?,
        perHour = json['perHour'] as double?,
        total = json['total'] as num?,
        fromDate = json['fromDate'] as String?,
        toDate = json['toDate'] as String?,
        comment = json['comment'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'rankId': rankId,
        'vendor': vendor?.toJson(),
        'days': days,
        'perHour': perHour,
        'total': total,
        'fromDate': fromDate,
        'toDate': toDate,
        'comment': comment
      };
}
