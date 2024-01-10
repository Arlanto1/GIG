// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cd_ui_labels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CdUiLabels _$CdUiLabelsFromJson(Map<String, dynamic> json) => CdUiLabels(
      defaultLocale:
          CdUiLabelsLocale.fromJson(json['default'] as Map<String, dynamic>),
      locale: CdUiLabelsLocale.fromJson(json['locale'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CdUiLabelsToJson(CdUiLabels instance) =>
    <String, dynamic>{
      'locale': instance.locale,
      'default': instance.defaultLocale,
    };

CdUiLabelsLocale _$CdUiLabelsLocaleFromJson(Map<String, dynamic> json) =>
    CdUiLabelsLocale(
      json['com.arlanto.atom.contact.state'] as String?,
      json['com.arlanto.atom.contact.status'] as String?,
      json['com.arlanto.atom.contact.entrySecurity'] as String?,
      json['com.arlanto.atom.contact.typeOfContact.systemEscltn'] as String?,
      json['com.arlanto.atom.contact.slNo'] as String?,
      json['com.arlanto.atom.contact.guardngAgncyRank'] as String?,
      json['com.arlanto.atom.contact.contactNo'] as String?,
      json['com.arlanto.atom.contact.typeOfContact.supervisorRank'] as String?,
      json['com.arlanto.atom.contact.typeOfContact.zonalcontact'] as String?,
      json['com.arlanto.atom.contact.name'] as String?,
      json['com.arlanto.atom.contact.escltnLevel'] as String?,
      json['com.arlanto.atom.contact.zonalAreaManagerName'] as String?,
      json['com.arlanto.atom.contact.escltnLevel.esclevel1'] as String?,
      json['com.arlanto.atom.contact.location'] as String?,
      json['com.arlanto.atom.contact.escltnLevel.esclevel2'] as String?,
      json['com.arlanto.atom.contact.typeOfContact'] as String?,
      json['com.arlanto.atom.contact.typeOfContact.generalContact'] as String?,
      json['com.arlanto.atom.contact.status.draft'] as String?,
      json['com.arlanto.atom.contact.locationRegion'] as String?,
      json['com.arlanto.atom.contact.generalRank'] as String?,
      json['com.arlanto.atom.contact.inputDate'] as String?,
      json['com.arlanto.atom.contact.status.active'] as String?,
      json['com.arlanto.atom.contact.systemEscltnDept'] as String?,
      json['com.arlanto.atom.contact.email'] as String?,
      json['com.arlanto.atom.contact.typeOfContact.guardingAgency'] as String?,
      json['com.arlanto.atom.contact.zone'] as String?,
      json['com.arlanto.atom.contact.supervisorRank'] as String?,
    );

Map<String, dynamic> _$CdUiLabelsLocaleToJson(CdUiLabelsLocale instance) =>
    <String, dynamic>{
      'com.arlanto.atom.contact.state': instance.state,
      'com.arlanto.atom.contact.status': instance.status,
      'com.arlanto.atom.contact.entrySecurity': instance.entrySecurity,
      'com.arlanto.atom.contact.typeOfContact.systemEscltn':
          instance.systemEscalationContact,
      'com.arlanto.atom.contact.slNo': instance.slNo,
      'com.arlanto.atom.contact.guardngAgncyRank':
          instance.guardingAgencyEscalationRank,
      'com.arlanto.atom.contact.contactNo': instance.phoneNumber,
      'com.arlanto.atom.contact.typeOfContact.supervisorRank':
          instance.supervisorRank,
      'com.arlanto.atom.contact.typeOfContact.zonalcontact':
          instance.guardingAgencyZonalManager,
      'com.arlanto.atom.contact.name': instance.name,
      'com.arlanto.atom.contact.escltnLevel': instance.escalationLevel,
      'com.arlanto.atom.contact.zonalAreaManagerName': instance.areaManagerName,
      'com.arlanto.atom.contact.escltnLevel.esclevel1':
          instance.escalationLevel1,
      'com.arlanto.atom.contact.location': instance.location,
      'com.arlanto.atom.contact.escltnLevel.esclevel2':
          instance.escalationLevel2,
      'com.arlanto.atom.contact.typeOfContact': instance.contactType,
      'com.arlanto.atom.contact.typeOfContact.generalContact':
          instance.generalContact,
      'com.arlanto.atom.contact.status.draft': instance.draft,
      'com.arlanto.atom.contact.locationRegion': instance.locationRegion,
      'com.arlanto.atom.contact.generalRank': instance.rank,
      'com.arlanto.atom.contact.inputDate': instance.date,
      'com.arlanto.atom.contact.status.active': instance.active,
      'com.arlanto.atom.contact.systemEscltnDept':
          instance.systemEscalationMatrix,
      'com.arlanto.atom.contact.email': instance.email,
      'com.arlanto.atom.contact.typeOfContact.guardingAgency':
          instance.guardingAgencyEscalationContact,
      'com.arlanto.atom.contact.zone': instance.zone,
      'com.arlanto.atom.contact.supervisorRank': instance.supervisorRank2,
    };
