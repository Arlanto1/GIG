import 'package:db_atom/index.dart';

part 'dpn_ui_labels.g.dart';

@JsonSerializable()
class DPNUiLabels {
  DPNUiLabels({
    required this.defaultLocale,
    required this.locale,
  });

  factory DPNUiLabels.fromJson(Map<String, dynamic> json) =>
      _$DPNUiLabelsFromJson(json);

  Map<String, dynamic> toJson() => _$DPNUiLabelsToJson(this);

  @JsonKey(name: 'locale')
  final DPNUiLabelsLocale locale;
  @JsonKey(name: 'default')
  final DPNUiLabelsLocale defaultLocale;
}

@JsonSerializable()
class DPNUiLabelsLocale {
  @JsonKey(name: 'com.arlanto.atom.shiftschedule.dutypost.location')
  final String? location;
  @JsonKey(name: 'com.arlanto.atom.shiftschedule.dutypost.existsTitle')
  final String? existsTitle;
  @JsonKey(name: 'com.arlanto.atom.shiftschedule.dutypost.status.draft')
  final String? statusDraft;
  @JsonKey(name: 'com.arlanto.atom.shiftschedule.dutypost.status')
  final String? status;
  @JsonKey(name: 'com.arlanto.atom.shiftschedule.dutypost.modifiedBy')
  final String? modifiedBy;
  @JsonKey(name: 'com.arlanto.atom.shiftschedule.dutypost.name')
  final String? name;
  @JsonKey(name: 'com.arlanto.atom.shiftschedule.dutypost.exists')
  final String? exists;
  @JsonKey(name: 'com.arlanto.atom.shiftschedule.dutypost.slNo')
  final String? slNo;
  @JsonKey(name: 'com.arlanto.atom.shiftschedule.dutypost.transportShift')
  final String? transportShift;
  @JsonKey(name: 'com.arlanto.atom.shiftschedule.dutypost.postName')
  final String? postName;
  @JsonKey(name: 'com.arlanto.atom.shiftschedule.dutypost.status.active')
  final String? statusActive;
  @JsonKey(name: 'com.arlanto.atom.shiftschedule.dutypost.entrySecurity')
  final String? entrySecurity;
  @JsonKey(name: 'com.arlanto.atom.shiftschedule.dutypost.locationRegion')
  final String? locationRegion;
  @JsonKey(name: 'com.arlanto.atom.shiftschedule.dutypost.inputDate')
  final String? inputDate;
  @JsonKey(name: 'com.arlanto.atom.shiftschedule.dutypost.modifiedDate')
  final String? modifiedDate;

  DPNUiLabelsLocale(
      this.location,
      this.existsTitle,
      this.statusDraft,
      this.status,
      this.modifiedBy,
      this.name,
      this.exists,
      this.slNo,
      this.transportShift,
      this.postName,
      this.statusActive,
      this.entrySecurity,
      this.locationRegion,
      this.inputDate,
      this.modifiedDate);

  factory DPNUiLabelsLocale.fromJson(Map<String, dynamic> json) =>
      _$DPNUiLabelsLocaleFromJson(json);

  Map<String, dynamic> toJson() => _$DPNUiLabelsLocaleToJson(this);
}
