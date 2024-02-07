import 'package:db_atom/src/features/createfound/models/user.dart';
import 'package:db_atom/src/features/incident_management/models/incidents_response.dart';
import 'package:db_atom/src/models/organisation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'general_info_model.g.dart';

class OccurrenceResponse {
  final List<OccurrenceModel>? items;
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
            ?.map((dynamic e) => OccurrenceModel.fromJson(e as Map<String, dynamic>))
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

@JsonSerializable()
class OccurrenceModel {
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
  // String? modifiedDate;
  String? modifiedBy;
  List<PowerFailures>? powerFailures;
  List<IncidentModel>? incidentItems;
  List<dynamic>? secSysFailureIncident;
  bool followedUp;
  int? status;

  OccurrenceModel({
    this.id,
    this.slNo,
    this.inputDate,
    this.entrySecurity,
    this.handoverSecurity,
    this.location,
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
    // this.modifiedDate,
    this.modifiedBy,
    this.incidentItems,
    this.secSysFailureIncident,
    this.followedUp = false,
    this.status,
    this.powerFailures,
  });

  factory OccurrenceModel.fromJson(Map<String, dynamic> json) =>
      _$OccurrenceModelFromJson(json);

  Map<String, dynamic> toJson() => _$OccurrenceModelToJson(this);

}

class PowerFailures {
  final int? id;
  final String? powerFailureStartDate;
  final String? powerFailureEndDate;

  PowerFailures({
    this.id,
    this.powerFailureStartDate,
    this.powerFailureEndDate,
  });

  PowerFailures.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        powerFailureStartDate = json['powerFailureStartDate'] as String?,
        powerFailureEndDate = json['powerFailureEndDate'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'powerFailureStartDate' : powerFailureStartDate,
    'powerFailureEndDate' : powerFailureEndDate
  };
}