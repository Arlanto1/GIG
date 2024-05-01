import 'package:json_annotation/json_annotation.dart';

part 'cd_ui_labels.g.dart';

@JsonSerializable()
class CdUiLabels {
  CdUiLabels({
    required this.defaultLocale,
    required this.locale,
  });

  factory CdUiLabels.fromJson(Map<String, dynamic> json) =>
      _$CdUiLabelsFromJson(json);

  Map<String, dynamic> toJson() => _$CdUiLabelsToJson(this);

  @JsonKey(name: 'locale')
  final CdUiLabelsLocale locale;
  @JsonKey(name: 'default')
  final CdUiLabelsLocale defaultLocale;
}

@JsonSerializable()
class CdUiLabelsLocale {
  @JsonKey(name: 'com.arlanto.atom.contact.state')
  final String? state;

  @JsonKey(name: 'com.arlanto.atom.contact.status')
  final String? status;

  @JsonKey(name: 'com.arlanto.atom.contact.entrySecurity')
  final String? entrySecurity;

  @JsonKey(name: 'com.arlanto.atom.contact.typeOfContact.systemEscltn')
  final String? systemEscalationContact;

  @JsonKey(name: 'com.arlanto.atom.contact.slNo')
  final String? slNo;

  @JsonKey(name: 'com.arlanto.atom.contact.guardngAgncyRank')
  final String? guardingAgencyEscalationRank;

  @JsonKey(name: 'com.arlanto.atom.contact.contactNo')
  final String? phoneNumber;

  @JsonKey(name: 'com.arlanto.atom.contact.typeOfContact.supervisorRank')
  final String? supervisorRank;

  @JsonKey(name: 'com.arlanto.atom.contact.typeOfContact.zonalcontact')
  final String? guardingAgencyZonalManager;

  @JsonKey(name: 'com.arlanto.atom.contact.name')
  final String? name;

  @JsonKey(name: 'com.arlanto.atom.contact.escltnLevel')
  final String? escalationLevel;

  @JsonKey(name: 'com.arlanto.atom.contact.zonalAreaManagerName')
  final String? areaManagerName;

  @JsonKey(name: 'com.arlanto.atom.contact.escltnLevel.esclevel1')
  final String? escalationLevel1;

  @JsonKey(name: 'com.arlanto.atom.contact.location')
  final String? location;

  @JsonKey(name: 'com.arlanto.atom.contact.escltnLevel.esclevel2')
  final String? escalationLevel2;

  @JsonKey(name: 'com.arlanto.atom.contact.typeOfContact')
  final String? contactType;

  @JsonKey(name: 'com.arlanto.atom.contact.typeOfContact.generalContact')
  final String? generalContact;

  @JsonKey(name: 'com.arlanto.atom.contact.status.draft')
  final String? draft;

  @JsonKey(name: 'com.arlanto.atom.contact.locationRegion')
  final String? locationRegion;

  @JsonKey(name: 'com.arlanto.atom.contact.generalRank')
  final String? rank;

  @JsonKey(name: 'com.arlanto.atom.contact.inputDate')
  final String? date;

  @JsonKey(name: 'com.arlanto.atom.contact.status.active')
  final String? active;

  @JsonKey(name: 'com.arlanto.atom.contact.systemEscltnDept')
  final String? systemEscalationMatrix;

  @JsonKey(name: 'com.arlanto.atom.contact.email')
  final String? email;

  @JsonKey(name: 'com.arlanto.atom.contact.typeOfContact.guardingAgency')
  final String? guardingAgencyEscalationContact;

  @JsonKey(name: 'com.arlanto.atom.contact.zone')
  final String? zone;

  @JsonKey(name: 'com.arlanto.atom.contact.supervisorRank')
  final String? supervisorRank2;

  CdUiLabelsLocale(
      this.state,
      this.status,
      this.entrySecurity,
      this.systemEscalationContact,
      this.slNo,
      this.guardingAgencyEscalationRank,
      this.phoneNumber,
      this.supervisorRank,
      this.guardingAgencyZonalManager,
      this.name,
      this.escalationLevel,
      this.areaManagerName,
      this.escalationLevel1,
      this.location,
      this.escalationLevel2,
      this.contactType,
      this.generalContact,
      this.draft,
      this.locationRegion,
      this.rank,
      this.date,
      this.active,
      this.systemEscalationMatrix,
      this.email,
      this.guardingAgencyEscalationContact,
      this.zone,
      this.supervisorRank2);

  factory CdUiLabelsLocale.fromJson(Map<String, dynamic> json) =>
      _$CdUiLabelsLocaleFromJson(json);

  Map<String, dynamic> toJson() => _$CdUiLabelsLocaleToJson(this);
}
