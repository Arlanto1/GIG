import 'package:db_atom/index.dart';

part 'vvip_ui_labels.g.dart';

@JsonSerializable()
class VVIPUiLabels {
  VVIPUiLabels({
    required this.defaultLocale,
    required this.locale,
  });

  factory VVIPUiLabels.fromJson(Map<String, dynamic> json) =>
      _$VVIPUiLabelsFromJson(json);

  Map<String, dynamic> toJson() => _$VVIPUiLabelsToJson(this);

  @JsonKey(name: 'locale')
  final VVIPUiLabelsLocale locale;
  @JsonKey(name: 'default')
  final VVIPUiLabelsLocale defaultLocale;
}

@JsonSerializable()
class VVIPUiLabelsLocale {
  @JsonKey(name: 'com.arlanto.atom.vvipVisit.list.designation')
  final String? visitorDesignation;
  @JsonKey(name: 'com.arlanto.atom.vvipVisit.list.startDateVisit')
  final String? startDateVisit;
  @JsonKey(name: 'com.arlanto.atom.vvipVisit.status.created')
  final String? statusCreated;
  @JsonKey(name: 'com.arlanto.atom.vvipVisit.slNo')
  final String? slNo;
  @JsonKey(name: 'com.arlanto.atom.vvipVisit.entrySecurity')
  final String? entrySecurity;
  @JsonKey(name: 'com.arlanto.atom.vvipVisit.list.endDateVisit')
  final String? endDateVisit;
  @JsonKey(name: 'com.arlanto.atom.vvipVisit.locationRegion')
  final String? locationRegion;
  @JsonKey(name: 'com.arlanto.atom.vvipVisit.status.submitted')
  final String? statusSubmitted;
  @JsonKey(name: 'com.arlanto.atom.vvipVisit.location')
  final String? location;
  @JsonKey(name: 'com.arlanto.atom.vvipVisit.status')
  final String? status;
  @JsonKey(name: 'com.arlanto.atom.vvipVisit.inputDate')
  final String? inputDate;
  @JsonKey(name: 'com.arlanto.atom.vvipVisit.list.email')
  final String? visitorEmailId;
  @JsonKey(name: 'com.arlanto.atom.vvipVisit.status.cancelled')
  final String? statusCancelled;
  @JsonKey(name: 'com.arlanto.atom.vvipVisit.list.purpose')
  final String? purposeOfVisit;
  @JsonKey(name: 'com.arlanto.atom.vvipVisit.list.name')
  final String? visitorName;
  @JsonKey(name: 'com.arlanto.atom.vvipVisit.list.baseLocation')
  final String? baseLocationOfVisitor;

  VVIPUiLabelsLocale(
      this.visitorDesignation,
      this.startDateVisit,
      this.statusCreated,
      this.slNo,
      this.entrySecurity,
      this.endDateVisit,
      this.locationRegion,
      this.statusSubmitted,
      this.location,
      this.status,
      this.inputDate,
      this.visitorEmailId,
      this.statusCancelled,
      this.purposeOfVisit,
      this.visitorName,
      this.baseLocationOfVisitor);

  factory VVIPUiLabelsLocale.fromJson(Map<String, dynamic> json) =>
      _$VVIPUiLabelsLocaleFromJson(json);

  Map<String, dynamic> toJson() => _$VVIPUiLabelsLocaleToJson(this);
}
