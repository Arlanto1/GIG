import 'package:db_atom/index.dart';

part 'gr_ui_labels.g.dart';

@JsonSerializable()
class GRUiLabels {
  GRUiLabels({
    required this.defaultLocale,
    required this.locale,
  });

  factory GRUiLabels.fromJson(Map<String, dynamic> json) =>
      _$GRUiLabelsFromJson(json);

  Map<String, dynamic> toJson() => _$GRUiLabelsToJson(this);

  @JsonKey(name: 'locale')
  final GRUiLabelsLocale locale;
  @JsonKey(name: 'default')
  final GRUiLabelsLocale defaultLocale;
}

@JsonSerializable()
class GRUiLabelsLocale {
  @JsonKey(name: 'com.arlanto.atom.guardingRate.rank.securityGuard')
  final String? securityGuard;

  @JsonKey(name: 'com.arlanto.atom.guardingRate.comment')
  final String? comment;

  @JsonKey(name: 'com.arlanto.atom.guardingRate.rank.other')
  final String? other;

  @JsonKey(name: 'com.arlanto.atom.guardingRate.days')
  final String? days;

  @JsonKey(name: 'com.arlanto.atom.guardingRate.entity')
  final String? entity;

  @JsonKey(name: 'com.arlanto.atom.guardingRate.rank.securityFacilitator')
  final String? securityFacilitator;

  @JsonKey(name: 'com.arlanto.atom.guardingRate.entrySecurity')
  final String? entrySecurity;

  @JsonKey(name: 'com.arlanto.atom.guardingRate.slNo')
  final String? slNo;

  @JsonKey(name: 'com.arlanto.atom.guardingRate.locationRegion')
  final String? locationRegion;

  @JsonKey(name: 'com.arlanto.atom.guardingRate.toDate')
  final String? toDate;

  @JsonKey(name: 'com.arlanto.atom.guardingRate.perHr')
  final String? perHr;

  @JsonKey(name: 'com.arlanto.atom.guardingRate.fromDate')
  final String? fromDate;

  @JsonKey(name: 'com.arlanto.atom.guardingRate.rank')
  final String? rank;

  @JsonKey(name: 'com.arlanto.atom.guardingRate.inputDate')
  final String? inputDate;

  @JsonKey(name: 'com.arlanto.atom.guardingRate.rank.securitySupervisor')
  final String? securitySupervisor;

  @JsonKey(name: 'com.arlanto.atom.guardingRate.rank.securityOfficer')
  final String? securityOfficer;

  @JsonKey(name: 'com.arlanto.atom.guardingRate.rank.gunMan')
  final String? gunMan;

  @JsonKey(name: 'com.arlanto.atom.guardingRate.location')
  final String? location;

  @JsonKey(name: 'com.arlanto.atom.guardingRate.entityName')
  final String? entityName;

  @JsonKey(name: 'com.arlanto.atom.guardingRate.vendor')
  final String? vendor;

  @JsonKey(name: 'com.arlanto.atom.guardingRate.revisedAmt')
  final String? revisedAmt;


  GRUiLabelsLocale(
      this.securityGuard,
      this.comment,
      this.other,
      this.days,
      this.entity,
      this.securityFacilitator,
      this.entrySecurity,
      this.slNo,
      this.locationRegion,
      this.toDate,
      this.perHr,
      this.fromDate,
      this.rank,
      this.inputDate,
      this.securitySupervisor,
      this.securityOfficer,
      this.gunMan,
      this.location,
      this.entityName,
      this.vendor,
      this.revisedAmt);

  factory GRUiLabelsLocale.fromJson(Map<String, dynamic> json) =>
      _$GRUiLabelsLocaleFromJson(json);

  Map<String, dynamic> toJson() => _$GRUiLabelsLocaleToJson(this);
}
