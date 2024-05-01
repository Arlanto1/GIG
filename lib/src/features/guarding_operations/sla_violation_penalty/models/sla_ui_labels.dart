import 'package:json_annotation/json_annotation.dart';

part 'sla_ui_labels.g.dart';

@JsonSerializable()
class SlaUiLabels {
  SlaUiLabels({
    required this.defaultLocale,
    required this.locale,
  });

  factory SlaUiLabels.fromJson(Map<String, dynamic> json) =>
      _$SlaUiLabelsFromJson(json);

  Map<String, dynamic> toJson() => _$SlaUiLabelsToJson(this);

  @JsonKey(name: 'locale')
  final SlaUiLabelsLocale locale;
  @JsonKey(name: 'default')
  final SlaUiLabelsLocale defaultLocale;
}

@JsonSerializable()
class SlaUiLabelsLocale {
  @JsonKey(name: 'com.arlanto.atom.violtnPenalty.approver')
  final String? approver;

  @JsonKey(name: 'com.arlanto.atom.violtnPenalty.typeOfService')
  final String? typeOfService;

  @JsonKey(name: 'com.arlanto.atom.violtnPenalty.staffCategory')
  final String? staffCategory;

  @JsonKey(name: 'com.arlanto.atom.violtnPenalty.staffCategory.grdngAgency')
  final String? grdngAgency;

  @JsonKey(name: 'com.arlanto.atom.violtnPenalty.status.draft')
  final String? statusDraft;

  @JsonKey(name: 'com.arlanto.atom.violtnPenalty.staffCategory.secLady')
  final String? secLady;

  @JsonKey(name: 'com.arlanto.atom.violtnPenalty.location')
  final String? location;

  @JsonKey(name: 'com.arlanto.atom.violtnPenalty.poc')
  final String? poc;

  @JsonKey(name: 'com.arlanto.atom.violtnPenalty.inputDate')
  final String? inputDate;

  @JsonKey(name: 'com.arlanto.atom.violtnPenalty.staffCategory.secGuard')
  final String? secGuard;

  @JsonKey(name: 'com.arlanto.atom.violtnPenalty.staffCategory.secFacilitator')
  final String? secFacilitator;

  @JsonKey(name: 'com.arlanto.atom.violtnPenalty.vendor')
  final String? vendor;

  @JsonKey(name: 'com.arlanto.atom.violtnPenalty.staffCategory.secOfficer')
  final String? secOfficer;

  @JsonKey(name: 'com.arlanto.atom.violtnPenalty.entrySecurity')
  final String? entrySecurity;

  @JsonKey(name: 'com.arlanto.atom.violtnPenalty.totalViolations')
  final String? totalViolations;

  @JsonKey(name: 'com.arlanto.atom.violtnPenalty.slNo')
  final String? slNo;

  @JsonKey(name: 'com.arlanto.atom.violtnPenalty.staffCategory.na')
  final String? na;

  @JsonKey(name: 'com.arlanto.atom.violtnPenalty.locationRegion')
  final String? locationRegion;

  @JsonKey(name: 'com.arlanto.atom.violtnPenalty.active')
  final String? statusActive;

  @JsonKey(name: 'com.arlanto.atom.violtnPenalty.finalize')
  final String? statusFinalize;

  @JsonKey(name: 'com.arlanto.atom.violtnPenalty.totalPenaltyAmount')
  final String? totalPenaltyAmount;

  @JsonKey(name: 'com.arlanto.atom.violtnPenalty.entity')
  final String? entity;

  @JsonKey(name: 'com.arlanto.atom.violtnPenalty.staffCategory.secSupervisor')
  final String? secSupervisor;

  @JsonKey(name: 'com.arlanto.atom.violtnPenalty.status')
  final String? status;

  @JsonKey(name: 'com.arlanto.atom.violtnPenalty.penaltyAmount')
  final String? penaltyAmount;

  @JsonKey(name: 'com.arlanto.atom.violtnPenalty.violation')
  final String? violation;

  SlaUiLabelsLocale(
      this.approver,
      this.typeOfService,
      this.staffCategory,
      this.grdngAgency,
      this.statusDraft,
      this.secLady,
      this.location,
      this.poc,
      this.inputDate,
      this.secGuard,
      this.secFacilitator,
      this.vendor,
      this.secOfficer,
      this.entrySecurity,
      this.totalViolations,
      this.slNo,
      this.na,
      this.locationRegion,
      this.statusActive,
      this.statusFinalize,
      this.totalPenaltyAmount,
      this.entity,
      this.secSupervisor,
      this.status,
      this.penaltyAmount,
      this.violation);

  factory SlaUiLabelsLocale.fromJson(Map<String, dynamic> json) =>
      _$SlaUiLabelsLocaleFromJson(json);

  Map<String, dynamic> toJson() => _$SlaUiLabelsLocaleToJson(this);
}
