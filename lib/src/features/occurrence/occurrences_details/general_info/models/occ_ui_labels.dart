import 'package:db_atom/index.dart';

part 'occ_ui_labels.g.dart';

@JsonSerializable()
class OCCUiLabels {
  OCCUiLabels({
    required this.defaultLocale,
    required this.locale,
  });

  factory OCCUiLabels.fromJson(Map<String, dynamic> json) =>
      _$OCCUiLabelsFromJson(json);

  Map<String, dynamic> toJson() => _$OCCUiLabelsToJson(this);

  @JsonKey(name: 'locale')
  final OCCUiLabelsLocale locale;
  @JsonKey(name: 'default')
  final OCCUiLabelsLocale defaultLocale;
}

@JsonSerializable()
class OCCUiLabelsLocale {
  @JsonKey(name: 'com.arlanto.atom.occurrence.yes')
  final String? yes;

  @JsonKey(name: 'com.arlanto.atom.occurrence.location')
  final String? location;

  @JsonKey(name: 'com.arlanto.atom.occurrence.leoVisit')
  final String? leoVisit;

  @JsonKey(name: 'com.arlanto.atom.occurrence.foundArticleTrnsctn')
  final String? foundArticleTrnsctn;

  @JsonKey(name: 'com.arlanto.atom.occurrence.status.create')
  final String? statusCreate;

  @JsonKey(name: 'com.arlanto.atom.occurrence.premisesRoundTkn')
  final String? premisesRoundTkn;

  @JsonKey(name: 'com.arlanto.atom.occurrence.atmVendorVisit')
  final String? atmVendorVisit;

  @JsonKey(name: 'com.arlanto.atom.occurrence.powerFailureStartDate')
  final String? powerFailureStartDate;

  @JsonKey(name: 'com.arlanto.atom.occurrence.slNo')
  final String? slNo;

  @JsonKey(name: 'com.arlanto.atom.occurrence.suspiciousActivity')
  final String? suspiciousActivity;

  @JsonKey(name: 'com.arlanto.atom.occurrence.powerFailure')
  final String? powerFailure;

  @JsonKey(name: 'com.arlanto.atom.occurrence.infraIssue')
  final String? infraIssue;

  @JsonKey(name: 'com.arlanto.atom.occurrence.fireAlarmEmrgncy')
  final String? fireAlarmEmrgncy;

  @JsonKey(name: 'com.arlanto.atom.occurrence.notifyScri')
  final String? notifyScri;

  @JsonKey(name: 'com.arlanto.atom.occurrence.secSysFailureIncdnt')
  final String? secSysFailureIncdnt;

  @JsonKey(name: 'com.arlanto.atom.occurrence.medicalEmrgncy')
  final String? medicalEmrgncy;

  @JsonKey(name: 'com.arlanto.atom.occurrence.handoverSecurity')
  final String? handoverSecurity;

  @JsonKey(name: 'com.arlanto.atom.occurrence.processBreachIncdnt')
  final String? processBreachIncdnt;

  @JsonKey(name: 'com.arlanto.atom.occurrence.anyEvent')
  final String? anyEvent;

  @JsonKey(name: 'com.arlanto.atom.occurrence.status.submit')
  final String? statusSubmit;

  @JsonKey(name: 'com.arlanto.atom.occurrence.comments')
  final String? comments;

  @JsonKey(name: 'com.arlanto.atom.occurrence.materialMovement')
  final String? materialMovement;

  @JsonKey(name: 'com.arlanto.atom.occurrence.landlordIssue')
  final String? landlordIssue;

  @JsonKey(name: 'com.arlanto.atom.occurrence.sysAlarmRcvd')
  final String? sysAlarmRcvd;

  @JsonKey(name: 'com.arlanto.atom.occurrence.transportIncdnt')
  final String? transportIncdnt;

  @JsonKey(name: 'com.arlanto.atom.occurrence.inputDate')
  final String? inputDate;

  @JsonKey(name: 'com.arlanto.atom.occurrence.followedUp')
  final String? followedUp;

  @JsonKey(name: 'com.arlanto.atom.occurrence.cwmVisit')
  final String? cwmVisit;

  @JsonKey(name: 'com.arlanto.atom.occurrence.entrySecurity')
  final String? entrySecurity;

  @JsonKey(name: 'com.arlanto.atom.occurrence.dgWrking')
  final String? dgWrking;

  @JsonKey(name: 'com.arlanto.atom.occurrence.socialEnggIncdnt')
  final String? socialEnggIncdnt;

  @JsonKey(name: 'com.arlanto.atom.occurrence.powerFailureEndDate')
  final String? powerFailureEndDate;

  @JsonKey(name: 'com.arlanto.atom.occurrence.no')
  final String? no;

  @JsonKey(name: 'com.arlanto.atom.occurrence.shiftBrfngAttnded')
  final String? shiftBrfngAttnded;

  @JsonKey(name: 'com.arlanto.atom.occurrence.status')
  final String? status;

  @JsonKey(name: 'com.arlanto.atom.occurrence.locationRegion')
  final String? locationRegion;


  OCCUiLabelsLocale(
      this.yes,
      this.location,
      this.leoVisit,
      this.foundArticleTrnsctn,
      this.statusCreate,
      this.premisesRoundTkn,
      this.atmVendorVisit,
      this.powerFailureStartDate,
      this.slNo,
      this.suspiciousActivity,
      this.powerFailure,
      this.infraIssue,
      this.fireAlarmEmrgncy,
      this.notifyScri,
      this.secSysFailureIncdnt,
      this.medicalEmrgncy,
      this.handoverSecurity,
      this.processBreachIncdnt,
      this.anyEvent,
      this.statusSubmit,
      this.comments,
      this.materialMovement,
      this.landlordIssue,
      this.sysAlarmRcvd,
      this.transportIncdnt,
      this.inputDate,
      this.followedUp,
      this.cwmVisit,
      this.entrySecurity,
      this.dgWrking,
      this.socialEnggIncdnt,
      this.powerFailureEndDate,
      this.no,
      this.shiftBrfngAttnded,
      this.status,
      this.locationRegion);

  factory OCCUiLabelsLocale.fromJson(Map<String, dynamic> json) =>
      _$OCCUiLabelsLocaleFromJson(json);

  Map<String, dynamic> toJson() => _$OCCUiLabelsLocaleToJson(this);
}
