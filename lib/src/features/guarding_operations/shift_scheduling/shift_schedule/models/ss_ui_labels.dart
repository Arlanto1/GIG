import 'package:db_atom/index.dart';

part 'ss_ui_labels.g.dart';

@JsonSerializable()
class SSUiLabels {
  SSUiLabels({
    required this.defaultLocale,
    required this.locale,
  });

  factory SSUiLabels.fromJson(Map<String, dynamic> json) =>
      _$SSUiLabelsFromJson(json);

  Map<String, dynamic> toJson() => _$SSUiLabelsToJson(this);

  @JsonKey(name: 'locale')
  final SSUiLabelsLocale locale;
  @JsonKey(name: 'default')
  final SSUiLabelsLocale defaultLocale;
}

@JsonSerializable()
class SSUiLabelsLocale {
  @JsonKey(name: 'com.arlanto.atom.guardShiftInfo.dutypost.existsTitle')
  final String? dutypostExistsTitle;
  @JsonKey(name: 'com.arlanto.atom.guardShiftInfo.postName')
  final String? postName;
  @JsonKey(name: 'com.arlanto.atom.guardShiftInfo.dutyType.buildingAndTransport')
  final String? dutyTypeBuildingAndTransport;
  @JsonKey(name: 'com.arlanto.atom.guardShiftInfo.location')
  final String? location;
  @JsonKey(name: 'com.arlanto.atom.guardShiftInfo.dutyType')
  final String? dutyType;
  @JsonKey(name: 'com.arlanto.atom.guardShiftInfo.shiftC')
  final String? shiftC;
  @JsonKey(name: 'com.arlanto.atom.guardShiftInfo.shiftB')
  final String? shiftB;
  @JsonKey(name: 'com.arlanto.atom.guardShiftInfo.fromDate')
  final String? fromDate;
  @JsonKey(name: 'com.arlanto.atom.guardShiftInfo.shiftA')
  final String? shiftA;
  @JsonKey(name: 'com.arlanto.atom.guardShiftInfo.shift.selected')
  final String? shiftSelected;
  @JsonKey(name: 'com.arlanto.atom.guardShiftInfo.inputDate')
  final String? inputDate;
  @JsonKey(name: 'com.arlanto.atom.guardShiftInfo.createdDate')
  final String? createdDate;
  @JsonKey(name: 'com.arlanto.atom.guardShiftInfo.slNo')
  final String? slNo;
  @JsonKey(name: 'com.arlanto.atom.guardShiftInfo.dutyType.building')
  final String? dutyTypeBuilding;
  @JsonKey(name: 'com.arlanto.atom.guardShiftInfo.status.active')
  final String? statusActive;
  @JsonKey(name: 'com.arlanto.atom.guardShiftInfo.entrySecurity')
  final String? entrySecurity;
  @JsonKey(name: 'com.arlanto.atom.guardShiftInfo.createdBy')
  final String? createdBy;
  @JsonKey(name: 'com.arlanto.atom.guardShiftInfo.status')
  final String? status;
  @JsonKey(name: 'com.arlanto.atom.guardShiftInfo.modifiedDate')
  final String? modifiedDate;
  @JsonKey(name: 'com.arlanto.atom.guardShiftInfo.vendor')
  final String? vendor;
  @JsonKey(name: 'com.arlanto.atom.guardShiftInfo.shift')
  final String? shift;
  @JsonKey(name: 'com.arlanto.atom.guardShiftInfo.locationRegion')
  final String? locationRegion;
  @JsonKey(name: 'com.arlanto.atom.guardShiftInfo.shiftG')
  final String? shiftG;
  @JsonKey(name: 'com.arlanto.atom.guardShiftInfo.status.leave')
  final String? statusLeave;
  @JsonKey(name: 'com.arlanto.atom.guardShiftInfo.status.weekOff')
  final String? statusWeekOff;
  @JsonKey(name: 'com.arlanto.atom.guardShiftInfo.modifiedBy')
  final String? modifiedBy;
  @JsonKey(name: 'com.arlanto.atom.guardShiftInfo.rankId')
  final String? rankId;
  @JsonKey(name: 'com.arlanto.atom.guardShiftInfo.dutypost.exists')
  final String? dutypostExists;
  @JsonKey(name: 'com.arlanto.atom.guardShiftInfo.allowed')
  final String? allowed;
  @JsonKey(name: 'com.arlanto.atom.guardShiftInfo.total')
  final String? total;
  @JsonKey(name: 'com.arlanto.atom.guardShiftInfo.status.draft')
  final String? statusDraft;
  @JsonKey(name: 'com.arlanto.atom.guardShiftInfo.toDate')
  final String? toDate;
  @JsonKey(name: 'com.arlanto.atom.guardShiftInfo.status.inActive')
  final String? statusInactive;
  @JsonKey(name: 'com.arlanto.atom.guardShiftInfo.dutyType.transport')
  final String? dutyTypeTransport;
  @JsonKey(name: 'com.arlanto.atom.guardShiftInfo.guardStaff')
  final String? guardStaff;


  SSUiLabelsLocale(
      this.dutypostExistsTitle,
      this.postName,
      this.dutyTypeBuildingAndTransport,
      this.location,
      this.dutyType,
      this.shiftC,
      this.shiftB,
      this.fromDate,
      this.shiftA,
      this.shiftSelected,
      this.inputDate,
      this.createdDate,
      this.slNo,
      this.dutyTypeBuilding,
      this.statusActive,
      this.entrySecurity,
      this.createdBy,
      this.status,
      this.modifiedDate,
      this.vendor,
      this.shift,
      this.locationRegion,
      this.shiftG,
      this.statusLeave,
      this.statusWeekOff,
      this.modifiedBy,
      this.rankId,
      this.dutypostExists,
      this.allowed,
      this.total,
      this.statusDraft,
      this.toDate,
      this.statusInactive,
      this.dutyTypeTransport,
      this.guardStaff);

  factory SSUiLabelsLocale.fromJson(Map<String, dynamic> json) =>
      _$SSUiLabelsLocaleFromJson(json);

  Map<String, dynamic> toJson() => _$SSUiLabelsLocaleToJson(this);
}
