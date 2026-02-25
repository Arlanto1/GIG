import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/incident_management/models/incidents_response.dart';

import '../../../../opsTeamSituationUpdate/model/opsTeamSitutationModel.dart';

part 'general_info_model.g.dart';

class OccurrenceResponse {
  List<OccurrenceModel>? items;
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
      : items = (json['data'] as List?)
            ?.map((dynamic e) =>
                OccurrenceModel.fromJson(e as Map<String, dynamic>))
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

// @JsonSerializable()
@JsonSerializable(explicitToJson: true)
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
  String? modifiedDate;
  String? modifiedBy;
  List<PowerFailureModel>? powerFailures;
  List<IncidentModel>? incidentItems;
  List<dynamic>? secSysFailureIncident;
  bool followedUp;
  int? status;
  int? shifts;
  Organisation? ipadSerialNo;
  Organisation? dutyPostLocation;
  String? privacyScreenComments;
  bool monsoon;
  bool privacyScreenPresent;
  List<LsmSituationalModel>? lsmUpdateList;
  String? lock;

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
    this.modifiedDate,
    this.modifiedBy,
    this.incidentItems,
    this.secSysFailureIncident,
    this.followedUp = false,
    this.status,
    this.powerFailures,
    this.shifts,
    this.ipadSerialNo,
    this.dutyPostLocation,
    this.privacyScreenComments,
    this.monsoon = false,
    this.privacyScreenPresent=false,
    this.lsmUpdateList,
    this.lock,
  });

  factory OccurrenceModel.fromJson(Map<String, dynamic> json) =>
      _$OccurrenceModelFromJson(json);

  Map<String, dynamic> toJson() => _$OccurrenceModelToJson(this);
}


