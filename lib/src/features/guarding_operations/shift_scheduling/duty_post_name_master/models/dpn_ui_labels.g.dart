// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dpn_ui_labels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DPNUiLabels _$DPNUiLabelsFromJson(Map<String, dynamic> json) => DPNUiLabels(
      defaultLocale:
          DPNUiLabelsLocale.fromJson(json['default'] as Map<String, dynamic>),
      locale:
          DPNUiLabelsLocale.fromJson(json['locale'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DPNUiLabelsToJson(DPNUiLabels instance) =>
    <String, dynamic>{
      'locale': instance.locale,
      'default': instance.defaultLocale,
    };

DPNUiLabelsLocale _$DPNUiLabelsLocaleFromJson(Map<String, dynamic> json) =>
    DPNUiLabelsLocale(
      json['com.arlanto.atom.shiftschedule.dutypost.location'] as String?,
      json['com.arlanto.atom.shiftschedule.dutypost.existsTitle'] as String?,
      json['com.arlanto.atom.shiftschedule.dutypost.status.draft'] as String?,
      json['com.arlanto.atom.shiftschedule.dutypost.status'] as String?,
      json['com.arlanto.atom.shiftschedule.dutypost.modifiedBy'] as String?,
      json['com.arlanto.atom.shiftschedule.dutypost.name'] as String?,
      json['com.arlanto.atom.shiftschedule.dutypost.exists'] as String?,
      json['com.arlanto.atom.shiftschedule.dutypost.slNo'] as String?,
      json['com.arlanto.atom.shiftschedule.dutypost.transportShift'] as String?,
      json['com.arlanto.atom.shiftschedule.dutypost.postName'] as String?,
      json['com.arlanto.atom.shiftschedule.dutypost.status.active'] as String?,
      json['com.arlanto.atom.shiftschedule.dutypost.entrySecurity'] as String?,
      json['com.arlanto.atom.shiftschedule.dutypost.locationRegion'] as String?,
      json['com.arlanto.atom.shiftschedule.dutypost.inputDate'] as String?,
      json['com.arlanto.atom.shiftschedule.dutypost.modifiedDate'] as String?,
    );

Map<String, dynamic> _$DPNUiLabelsLocaleToJson(DPNUiLabelsLocale instance) =>
    <String, dynamic>{
      'com.arlanto.atom.shiftschedule.dutypost.location': instance.location,
      'com.arlanto.atom.shiftschedule.dutypost.existsTitle':
          instance.existsTitle,
      'com.arlanto.atom.shiftschedule.dutypost.status.draft':
          instance.statusDraft,
      'com.arlanto.atom.shiftschedule.dutypost.status': instance.status,
      'com.arlanto.atom.shiftschedule.dutypost.modifiedBy': instance.modifiedBy,
      'com.arlanto.atom.shiftschedule.dutypost.name': instance.name,
      'com.arlanto.atom.shiftschedule.dutypost.exists': instance.exists,
      'com.arlanto.atom.shiftschedule.dutypost.slNo': instance.slNo,
      'com.arlanto.atom.shiftschedule.dutypost.transportShift':
          instance.transportShift,
      'com.arlanto.atom.shiftschedule.dutypost.postName': instance.postName,
      'com.arlanto.atom.shiftschedule.dutypost.status.active':
          instance.statusActive,
      'com.arlanto.atom.shiftschedule.dutypost.entrySecurity':
          instance.entrySecurity,
      'com.arlanto.atom.shiftschedule.dutypost.locationRegion':
          instance.locationRegion,
      'com.arlanto.atom.shiftschedule.dutypost.inputDate': instance.inputDate,
      'com.arlanto.atom.shiftschedule.dutypost.modifiedDate':
          instance.modifiedDate,
    };
