import 'package:db_atom/src/features/createfound/models/user.dart';

import '../../../models/organisation.dart';

class OccurrenceResponse {
  final List<Occurrence>? items;
  final int? totalCount;
  final int? currentPageNo;
  final int? totalPageCount;

  OccurrenceResponse({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  OccurrenceResponse.fromJson(Map<String, dynamic> json)
      : items = (json['data'] as List?)
            ?.map((dynamic e) => Occurrence.fromJson(e as Map<String, dynamic>))
            .toList(),
        totalCount = json['totalCount'] as int?,
        currentPageNo = json['currentPageNo'] as int?,
        totalPageCount = json['totalPageCount'] as int?;

  Map<String, dynamic> toJson() => {
        'data': items?.map((e) => e.toJson()).toList(),
        'totalCount': totalCount,
        'currentPageNo': currentPageNo,
        'totalPageCount': totalPageCount
      };
}

class Occurrence {
  final int? id;
  final String? slNo;
  final String? inputDate;
  final User? entrySecurity;
  final User? handoverSecurity;
  final Organisation? location;
  final Organisation? locationRegion;
  final bool? shiftBrfngAttnded;
  final bool? premisesRoundTkn;
  final String? premisesRoundTknComments;
  final bool? medicalEmrgncy;
  final String? medicalEmrgncyComments;
  final bool? materialMovement;
  final bool? leoVisit;
  final bool? socialEnggIncdnt;
  final String? socialEnggIncdntComments;
  final bool? foundArticleTrnsctn;
  final bool? processBreachIncdnt;
  final bool? infraIssue;
  final String? infraIssueComments;
  final bool? suspiciousActivity;
  final bool? fireAlarmEmrgncy;
  final String? fireAlarmEmrgncyComments;
  final bool? landlordIssue;
  final String? landlordIssueComments;
  final bool? secSysFailureIncdnt;
  final bool? sysAlarmRcvd;
  final String? sysAlarmRcvdComments;
  final bool? transportIncdnt;
  final String? transportIncdntComments;
  final bool? anyEvent;
  final String? notifyScri;
  final bool? powerFailure;
  final bool? atmVendorVisit;
  final bool? cwmVisit;
  final String? comments;
  final bool? dgWrking;
  final String? modifiedDate;
  final String? modifiedBy;
  final List<dynamic>? incidentItems;
  final List<dynamic>? secSysFailureIncident;
  final bool? followedUp;
  final int? status;

  Occurrence({
    this.id,
    this.slNo,
    this.inputDate,
    this.entrySecurity,
    this.handoverSecurity,
    this.location,
    this.locationRegion,
    this.shiftBrfngAttnded,
    this.premisesRoundTkn,
    this.premisesRoundTknComments,
    this.medicalEmrgncy,
    this.medicalEmrgncyComments,
    this.materialMovement,
    this.leoVisit,
    this.socialEnggIncdnt,
    this.socialEnggIncdntComments,
    this.foundArticleTrnsctn,
    this.processBreachIncdnt,
    this.infraIssue,
    this.infraIssueComments,
    this.suspiciousActivity,
    this.fireAlarmEmrgncy,
    this.fireAlarmEmrgncyComments,
    this.landlordIssue,
    this.landlordIssueComments,
    this.secSysFailureIncdnt,
    this.sysAlarmRcvd,
    this.sysAlarmRcvdComments,
    this.transportIncdnt,
    this.transportIncdntComments,
    this.anyEvent,
    this.notifyScri,
    this.powerFailure,
    this.atmVendorVisit,
    this.cwmVisit,
    this.comments,
    this.dgWrking,
    this.modifiedDate,
    this.modifiedBy,
    this.incidentItems,
    this.secSysFailureIncident,
    this.followedUp,
    this.status,
  });

  Occurrence.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        slNo = json['slNo'] as String?,
        inputDate = json['inputDate'] as String?,
        entrySecurity = (json['entrySecurity'] as Map<String, dynamic>?) != null
            ? User.fromJson(
                json['entrySecurity'] as Map<String, dynamic>)
            : null,
        handoverSecurity =
            (json['handoverSecurity'] as Map<String, dynamic>?) != null
                ? User.fromJson(
                    json['handoverSecurity'] as Map<String, dynamic>)
                : null,
        location = (json['location'] as Map<String, dynamic>?) != null
            ? Organisation.fromJson(json['location'] as Map<String, dynamic>)
            : null,
        locationRegion =
            (json['locationRegion'] as Map<String, dynamic>?) != null
                ? Organisation.fromJson(
                    json['locationRegion'] as Map<String, dynamic>)
                : null,
        shiftBrfngAttnded = json['shiftBrfngAttnded'] as bool?,
        premisesRoundTkn = json['premisesRoundTkn'] as bool?,
        premisesRoundTknComments = json['premisesRoundTknComments'] as String?,
        medicalEmrgncy = json['medicalEmrgncy'] as bool?,
        medicalEmrgncyComments = json['medicalEmrgncyComments'] as String?,
        materialMovement = json['materialMovement'] as bool?,
        leoVisit = json['leoVisit'] as bool?,
        socialEnggIncdnt = json['socialEnggIncdnt'] as bool?,
        socialEnggIncdntComments = json['socialEnggIncdntComments'] as String?,
        foundArticleTrnsctn = json['foundArticleTrnsctn'] as bool?,
        processBreachIncdnt = json['processBreachIncdnt'] as bool?,
        infraIssue = json['infraIssue'] as bool?,
        infraIssueComments = json['infraIssueComments'] as String?,
        suspiciousActivity = json['suspiciousActivity'] as bool?,
        fireAlarmEmrgncy = json['fireAlarmEmrgncy'] as bool?,
        fireAlarmEmrgncyComments = json['fireAlarmEmrgncyComments'] as String?,
        landlordIssue = json['landlordIssue'] as bool?,
        landlordIssueComments = json['landlordIssueComments'] as String?,
        secSysFailureIncdnt = json['secSysFailureIncdnt'] as bool?,
        sysAlarmRcvd = json['sysAlarmRcvd'] as bool?,
        sysAlarmRcvdComments = json['sysAlarmRcvdComments'] as String?,
        transportIncdnt = json['transportIncdnt'] as bool?,
        transportIncdntComments = json['transportIncdntComments'] as String?,
        anyEvent = json['anyEvent'] as bool?,
        notifyScri = json['notifyScri'] as String?,
        powerFailure = json['powerFailure'] as bool?,
        atmVendorVisit = json['atmVendorVisit'] as bool?,
        cwmVisit = json['cwmVisit'] as bool?,
        comments = json['comments'] as String?,
        dgWrking = json['dgWrking'] as bool?,
        modifiedDate = json['modifiedDate'] as String?,
        modifiedBy = json['modifiedBy'] as String?,
        incidentItems = json['incidentItems'] as List?,
        secSysFailureIncident = json['secSysFailureIncident'] as List?,
        followedUp = json['followedUp'] as bool?,
        status = json['status'] as int?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'slNo': slNo,
        'inputDate': inputDate,
        'entrySecurity': entrySecurity?.toJson(),
        'location': location?.toJson(),
        'locationRegion': locationRegion?.toJson(),
        'shiftBrfngAttnded': shiftBrfngAttnded,
        'premisesRoundTkn': premisesRoundTkn,
        'premisesRoundTknComments': premisesRoundTknComments,
        'medicalEmrgncy': medicalEmrgncy,
        'medicalEmrgncyComments': medicalEmrgncyComments,
        'materialMovement': materialMovement,
        'leoVisit': leoVisit,
        'socialEnggIncdnt': socialEnggIncdnt,
        'socialEnggIncdntComments': socialEnggIncdntComments,
        'foundArticleTrnsctn': foundArticleTrnsctn,
        'processBreachIncdnt': processBreachIncdnt,
        'infraIssue': infraIssue,
        'infraIssueComments': infraIssueComments,
        'suspiciousActivity': suspiciousActivity,
        'fireAlarmEmrgncy': fireAlarmEmrgncy,
        'fireAlarmEmrgncyComments': fireAlarmEmrgncyComments,
        'landlordIssue': landlordIssue,
        'landlordIssueComments': landlordIssueComments,
        'secSysFailureIncdnt': secSysFailureIncdnt,
        'sysAlarmRcvd': sysAlarmRcvd,
        'sysAlarmRcvdComments': sysAlarmRcvdComments,
        'transportIncdnt': transportIncdnt,
        'transportIncdntComments': transportIncdntComments,
        'anyEvent': anyEvent,
        'notifyScri': notifyScri,
        'powerFailure': powerFailure,
        'atmVendorVisit': atmVendorVisit,
        'cwmVisit': cwmVisit,
        'comments': comments,
        'dgWrking': dgWrking,
        'modifiedDate': modifiedDate,
        'modifiedBy': modifiedBy,
        'incidentItems': incidentItems,
        'secSysFailureIncident': secSysFailureIncident,
        'followedUp': followedUp,
        'status': status ,
    'handoverSecurity': handoverSecurity,
  };
}
