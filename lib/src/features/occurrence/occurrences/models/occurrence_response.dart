
import 'package:db_atom/src/models/entry_security.dart';
import 'package:db_atom/src/models/organisation.dart';


class OccurrenceResponse {
   List<Occurrence>? items;
   int? totalCount;
   int? currentPageNo;
   int? totalPageCount;

  OccurrenceResponse({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  OccurrenceResponse.fromJson(Map<String, dynamic> json)
      : items = (json['occurrence'] as List?)?.map((dynamic e) => Occurrence.fromJson(e as Map<String,dynamic>)).toList(),
        totalCount = json['totalCount'] as int?,
        currentPageNo = json['currentPageNo'] as int?,
        totalPageCount = json['totalPageCount'] as int?;

  Map<String, dynamic> toJson() => {
    'occurrence' : items?.map((e) => e.toJson()).toList(),
    'totalCount' : totalCount,
    'currentPageNo' : currentPageNo,
    'totalPageCount' : totalPageCount
  };
}

class Occurrence {
   int? id;
   String? slNo;
   String? inputDate;
   EntrySecurity? entrySecurity;
   Organisation? location;
   Organisation? locationRegion;
   bool? shiftBrfngAttnded;
   bool? premisesRoundTkn;
   String? premisesRoundTknComments;
   bool? medicalEmrgncy;
   String? medicalEmrgncyComments;
   bool? materialMovement;
   bool? leoVisit;
   bool? socialEnggIncdnt;
   String? socialEnggIncdntComments;
   bool? foundArticleTrnsctn;
   bool? processBreachIncdnt;
   bool? infraIssue;
   String? infraIssueComments;
   bool? suspiciousActivity;
   bool? fireAlarmEmrgncy;
   String? fireAlarmEmrgncyComments;
   bool? landlordIssue;
   String? landlordIssueComments;
   bool? secSysFailureIncdnt;
   bool? sysAlarmRcvd;
   String? sysAlarmRcvdComments;
   bool? transportIncdnt;
   String? transportIncdntComments;
   bool? anyEvent;
   String? notifyScri;
   bool? powerFailure;
   bool? atmVendorVisit;
   bool? cwmVisit;
   String? comments;
   bool? dgWrking;
   String? modifiedDate;
   String? modifiedBy;
   List<dynamic>? incidentItems;
   List<dynamic>? secSysFailureIncident;
   bool? followedUp;
   int? status;

  Occurrence({
    this.id,
    this.slNo,
    this.inputDate,
    this.entrySecurity,
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
        entrySecurity = (json['entrySecurity'] as Map<String,dynamic>?) != null ? EntrySecurity.fromJson(json['entrySecurity'] as Map<String,dynamic>) : null,
        location = (json['location'] as Map<String,dynamic>?) != null ? Organisation.fromJson(json['location'] as Map<String,dynamic>) : null,
        locationRegion = (json['locationRegion'] as Map<String,dynamic>?) != null ? Organisation.fromJson(json['locationRegion'] as Map<String,dynamic>) : null,
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
    'id' : id,
    'slNo' : slNo,
    'inputDate' : inputDate,
    'entrySecurity' : entrySecurity?.toJson(),
    'location' : location?.toJson(),
    'locationRegion' : locationRegion?.toJson(),
    'shiftBrfngAttnded' : shiftBrfngAttnded,
    'premisesRoundTkn' : premisesRoundTkn,
    'premisesRoundTknComments' : premisesRoundTknComments,
    'medicalEmrgncy' : medicalEmrgncy,
    'medicalEmrgncyComments' : medicalEmrgncyComments,
    'materialMovement' : materialMovement,
    'leoVisit' : leoVisit,
    'socialEnggIncdnt' : socialEnggIncdnt,
    'socialEnggIncdntComments' : socialEnggIncdntComments,
    'foundArticleTrnsctn' : foundArticleTrnsctn,
    'processBreachIncdnt' : processBreachIncdnt,
    'infraIssue' : infraIssue,
    'infraIssueComments' : infraIssueComments,
    'suspiciousActivity' : suspiciousActivity,
    'fireAlarmEmrgncy' : fireAlarmEmrgncy,
    'fireAlarmEmrgncyComments' : fireAlarmEmrgncyComments,
    'landlordIssue' : landlordIssue,
    'landlordIssueComments' : landlordIssueComments,
    'secSysFailureIncdnt' : secSysFailureIncdnt,
    'sysAlarmRcvd' : sysAlarmRcvd,
    'sysAlarmRcvdComments' : sysAlarmRcvdComments,
    'transportIncdnt' : transportIncdnt,
    'transportIncdntComments' : transportIncdntComments,
    'anyEvent' : anyEvent,
    'notifyScri' : notifyScri,
    'powerFailure' : powerFailure,
    'atmVendorVisit' : atmVendorVisit,
    'cwmVisit' : cwmVisit,
    'comments' : comments,
    'dgWrking' : dgWrking,
    'modifiedDate' : modifiedDate,
    'modifiedBy' : modifiedBy,
    'incidentItems' : incidentItems,
    'secSysFailureIncident' : secSysFailureIncident,
    'followedUp' : followedUp,
    'status' : status
  };
}