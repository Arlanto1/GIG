import 'package:db_atom/src/features/createfound/models/user.dart';
import 'package:db_atom/src/models/organisation.dart';

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
  int? id;
  String? slNo;
  String? inputDate;
  User? entrySecurity;
  User? handoverSecurity;
  Organisation? location;
  Organisation? locationRegion;
  bool shiftBrfngAttnded;
  bool premisesRoundTkn;
  String? premisesRoundTknComments;
  bool medicalEmrgncy;
  String? medicalEmrgncyComments;
  bool materialMovement;
  bool leoVisit;
  bool socialEnggIncdnt;
  String? socialEnggIncdntComments;
  bool foundArticleTrnsctn;
  bool processBreachIncdnt;
  bool infraIssue;
  String? infraIssueComments;
  bool suspiciousActivity;
  bool fireAlarmEmrgncy;
  String? fireAlarmEmrgncyComments;
  bool landlordIssue;
  String? landlordIssueComments;
  bool secSysFailureIncdnt;
  bool sysAlarmRcvd;
  String? sysAlarmRcvdComments;
  bool transportIncdnt;
  String? transportIncdntComments;
  bool anyEvent;
  String? notifyScri;
  bool powerFailure;
  bool atmVendorVisit;
  bool cwmVisit;
  String? comments;
  bool dgWrking;
  String? modifiedDate;
  String? modifiedBy;
  String? powerFailureStartDate;
  String? powerFailureEndDate;
  List<dynamic>? incidentItems;
  List<dynamic>? secSysFailureIncident;
  bool followedUp;
  int? status;

  Occurrence({
    this.id,
    this.slNo,
    this.inputDate,
    this.entrySecurity,
    this.handoverSecurity,
    this.location,
    this.powerFailureStartDate,
    this.powerFailureEndDate,
    this.locationRegion,
    this.shiftBrfngAttnded = false,
    this.premisesRoundTkn = false,
    this.premisesRoundTknComments,
    this.medicalEmrgncy = false,
    this.medicalEmrgncyComments,
    this.materialMovement = false,
    this.leoVisit = false,
    this.socialEnggIncdnt = false,
    this.socialEnggIncdntComments,
    this.foundArticleTrnsctn = false,
    this.processBreachIncdnt = false,
    this.infraIssue = false,
    this.infraIssueComments,
    this.suspiciousActivity = false,
    this.fireAlarmEmrgncy = false,
    this.fireAlarmEmrgncyComments,
    this.landlordIssue = false,
    this.landlordIssueComments,
    this.secSysFailureIncdnt = false,
    this.sysAlarmRcvd = false,
    this.sysAlarmRcvdComments,
    this.transportIncdnt = false,
    this.transportIncdntComments,
    this.anyEvent = false,
    this.notifyScri,
    this.powerFailure = false,
    this.atmVendorVisit = false,
    this.cwmVisit = false,
    this.comments,
    this.dgWrking = false,
    this.modifiedDate,
    this.modifiedBy,
    this.incidentItems,
    this.secSysFailureIncident,
    this.followedUp = false,
    this.status,
  });

  Occurrence.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        slNo = json['slNo'] as String?,
        inputDate = json['inputDate'] as String?,
        entrySecurity = (json['entrySecurity'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['entrySecurity'] as Map<String, dynamic>)
            : null,
        handoverSecurity = (json['handoverSecurity']
                    as Map<String, dynamic>?) !=
                null
            ? User.fromJson(json['handoverSecurity'] as Map<String, dynamic>)
            : null,
        location = (json['location'] as Map<String, dynamic>?) != null
            ? Organisation.fromJson(json['location'] as Map<String, dynamic>)
            : null,
        locationRegion =
            (json['locationRegion'] as Map<String, dynamic>?) != null
                ? Organisation.fromJson(
                    json['locationRegion'] as Map<String, dynamic>)
                : null,
        shiftBrfngAttnded = json['shiftBrfngAttnded'] as bool,
        premisesRoundTkn = json['premisesRoundTkn'] as bool,
        premisesRoundTknComments = json['premisesRoundTknComments'] as String?,
        medicalEmrgncy = json['medicalEmrgncy'] as bool,
        medicalEmrgncyComments = json['medicalEmrgncyComments'] as String?,
        materialMovement = json['materialMovement'] as bool,
        leoVisit = json['leoVisit'] as bool,
        socialEnggIncdnt = json['socialEnggIncdnt'] as bool,
        socialEnggIncdntComments = json['socialEnggIncdntComments'] as String?,
        foundArticleTrnsctn = json['foundArticleTrnsctn'] as bool,
        processBreachIncdnt = json['processBreachIncdnt'] as bool,
        infraIssue = json['infraIssue'] as bool,
        infraIssueComments = json['infraIssueComments'] as String?,
        suspiciousActivity = json['suspiciousActivity'] as bool,
        fireAlarmEmrgncy = json['fireAlarmEmrgncy'] as bool,
        fireAlarmEmrgncyComments = json['fireAlarmEmrgncyComments'] as String?,
        landlordIssue = json['landlordIssue'] as bool,
        landlordIssueComments = json['landlordIssueComments'] as String?,
        secSysFailureIncdnt = json['secSysFailureIncdnt'] as bool,
        sysAlarmRcvd = json['sysAlarmRcvd'] as bool,
        sysAlarmRcvdComments = json['sysAlarmRcvdComments'] as String?,
        transportIncdnt = json['transportIncdnt'] as bool,
        transportIncdntComments = json['transportIncdntComments'] as String?,
        anyEvent = json['anyEvent'] as bool,
        notifyScri = json['notifyScri'] as String?,
        powerFailure = json['powerFailure'] as bool,
        atmVendorVisit = json['atmVendorVisit'] as bool,
        cwmVisit = json['cwmVisit'] as bool,
        comments = json['comments'] as String?,
        dgWrking = json['dgWrking'] as bool,
        modifiedDate = json['modifiedDate'] as String?,
        powerFailureStartDate = json['powerFailureStartDate'] as String?,
        powerFailureEndDate = json['powerFailureEndDate'] as String?,
        modifiedBy = json['modifiedBy'] as String?,
        incidentItems = json['incidentItems'] as List?,
        secSysFailureIncident = json['secSysFailureIncident'] as List?,
        followedUp = json['followedUp'] as bool,
        status = json['status'] as int?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'slNo': slNo,
        'inputDate': inputDate,
        'powerFailureStartDate': powerFailureStartDate,
        'powerFailureEndDate': powerFailureEndDate,
        'entrySecurity': entrySecurity?.toJson(),
        'handoverSecurity': handoverSecurity?.toJson(),
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
        'status': status
      };
}
