import 'package:json_annotation/json_annotation.dart';

part 'leo_ui_labels.g.dart';

@JsonSerializable()
class LeoUiLabels {
  LeoUiLabels({
    required this.defaultLocale,
    required this.locale,
  });

  factory LeoUiLabels.fromJson(Map<String, dynamic> json) =>
      _$LeoUiLabelsFromJson(json);

  Map<String, dynamic> toJson() => _$LeoUiLabelsToJson(this);

  @JsonKey(name: 'locale')
  final LeoUiLabelsLocale locale;
  @JsonKey(name: 'default')
  final LeoUiLabelsLocale defaultLocale;
}

@JsonSerializable()
class LeoUiLabelsLocale {
  @JsonKey(name: 'com.arlanto.atom.lawEnforcement.visitingOfficialDepartment')
  String? visitingOfficialDepartment;

  @JsonKey(name: 'com.arlanto.atom.lawEnforcement.entity')
  String? entity;

  @JsonKey(name: 'com.arlanto.atom.lawEnforcement.visitingOfficialEmail')
  String? visitingOfficialEmail;

  @JsonKey(name: 'com.arlanto.atom.lawEnforcement.entrySecurity')
  String? entrySecurity;

  @JsonKey(name: 'com.arlanto.atom.lawEnforcement.status.draft')
  String? statusDraft;

  @JsonKey(name: 'com.arlanto.atom.lawEnforcement.status.submitted')
  String? statusSubmitted;

  @JsonKey(name: 'com.arlanto.atom.lawEnforcement.status.verified')
  String? statusVerified;

  @JsonKey(name: 'com.arlanto.atom.lawEnforcement.timeOfVisit')
  String? timeOfVisit;

  @JsonKey(name: 'com.arlanto.atom.lawEnforcement.visitorInUniform')
  String? visitorInUniform;

  @JsonKey(name: 'com.arlanto.atom.lawEnforcement.distributionList')
  String? distributionList;

  @JsonKey(name: 'com.arlanto.atom.lawEnforcement.visitingOfficialName')
  String? visitingOfficialName;

  @JsonKey(name: 'com.arlanto.atom.lawEnforcement.officialCardVerified')
  String? officialCardVerified;

  @JsonKey(name: 'com.arlanto.atom.lawEnforcement.dbOfficialAccompaniedEmail')
  String? dbOfficialAccompaniedEmail;

  @JsonKey(name: 'com.arlanto.atom.lawEnforcement.additionalInformation')
  String? additionalInformation;

  @JsonKey(name: 'com.arlanto.atom.lawEnforcement.visitPurpose')
  String? visitPurpose;

  @JsonKey(name: 'com.arlanto.atom.lawEnforcement.visitingOfficialContactNo')
  String? visitingOfficialContactNo;

  @JsonKey(name: 'com.arlanto.atom.lawEnforcement.status.distributed')
  String? statusDistributed;

  @JsonKey(name: 'com.arlanto.atom.lawEnforcement.visitingOfficialDesignation')
  String? visitingOfficialDesignation;

  @JsonKey(name: 'com.arlanto.atom.lawEnforcement.status')
  String? status;

  @JsonKey(name: 'com.arlanto.atom.lawEnforcement.slNo')
  String? slNo;

  @JsonKey(name: 'com.arlanto.atom.lawEnforcement.inputDate')
  String? inputDate;

  @JsonKey(name: 'com.arlanto.atom.lawEnforcement.visitingOfficialAddress')
  String? visitingOfficialAddress;

  @JsonKey(name: 'com.arlanto.atom.lawEnforcement.location')
  String? location;

  @JsonKey(name: 'com.arlanto.atom.lawEnforcement.dbOfficialEmailDepartment')
  String? dbOfficialEmailDepartment;

  @JsonKey(name: 'com.arlanto.atom.lawEnforcement.entityName')
  String? entityName;

  @JsonKey(name: 'com.arlanto.atom.lawEnforcement.dbOfficialEmail')
  String? dbOfficialEmail;

  @JsonKey(name: 'com.arlanto.atom.lawEnforcement.locationRegion')
  String? locationRegion;

  @JsonKey(name: 'com.arlanto.atom.lawEnforcement.visitingOfficialName.add')
  String? visitingOfficialNameAdd;

  @JsonKey(name: 'com.arlanto.atom.lawEnforcement.documentVerified')
  String? documentVerified;

  LeoUiLabelsLocale(
      this.visitingOfficialDepartment,
      this.entity,
      this.visitingOfficialEmail,
      this.entrySecurity,
      this.statusDraft,
      this.statusSubmitted,
      this.statusVerified,
      this.timeOfVisit,
      this.visitorInUniform,
      this.distributionList,
      this.visitingOfficialName,
      this.officialCardVerified,
      this.dbOfficialAccompaniedEmail,
      this.additionalInformation,
      this.visitPurpose,
      this.visitingOfficialContactNo,
      this.statusDistributed,
      this.visitingOfficialDesignation,
      this.status,
      this.slNo,
      this.inputDate,
      this.visitingOfficialAddress,
      this.location,
      this.dbOfficialEmailDepartment,
      this.entityName,
      this.dbOfficialEmail,
      this.locationRegion,
      this.visitingOfficialNameAdd,
      this.documentVerified);

  factory LeoUiLabelsLocale.fromJson(Map<String, dynamic> json) =>
      _$LeoUiLabelsLocaleFromJson(json);

  Map<String, dynamic> toJson() => _$LeoUiLabelsLocaleToJson(this);
}
