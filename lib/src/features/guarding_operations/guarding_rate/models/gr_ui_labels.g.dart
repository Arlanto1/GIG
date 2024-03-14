// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gr_ui_labels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GRUiLabels _$GRUiLabelsFromJson(Map<String, dynamic> json) => GRUiLabels(
      defaultLocale:
          GRUiLabelsLocale.fromJson(json['default'] as Map<String, dynamic>),
      locale: GRUiLabelsLocale.fromJson(json['locale'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GRUiLabelsToJson(GRUiLabels instance) =>
    <String, dynamic>{
      'locale': instance.locale,
      'default': instance.defaultLocale,
    };

GRUiLabelsLocale _$GRUiLabelsLocaleFromJson(Map<String, dynamic> json) =>
    GRUiLabelsLocale(
      json['com.arlanto.atom.guardingRate.rank.securityGuard'] as String?,
      json['com.arlanto.atom.guardingRate.comment'] as String?,
      json['com.arlanto.atom.guardingRate.rank.other'] as String?,
      json['com.arlanto.atom.guardingRate.days'] as String?,
      json['com.arlanto.atom.guardingRate.entity'] as String?,
      json['com.arlanto.atom.guardingRate.rank.securityFacilitator'] as String?,
      json['com.arlanto.atom.guardingRate.entrySecurity'] as String?,
      json['com.arlanto.atom.guardingRate.slNo'] as String?,
      json['com.arlanto.atom.guardingRate.locationRegion'] as String?,
      json['com.arlanto.atom.guardingRate.toDate'] as String?,
      json['com.arlanto.atom.guardingRate.perHr'] as String?,
      json['com.arlanto.atom.guardingRate.fromDate'] as String?,
      json['com.arlanto.atom.guardingRate.rank'] as String?,
      json['com.arlanto.atom.guardingRate.inputDate'] as String?,
      json['com.arlanto.atom.guardingRate.rank.securitySupervisor'] as String?,
      json['com.arlanto.atom.guardingRate.rank.securityOfficer'] as String?,
      json['com.arlanto.atom.guardingRate.rank.gunMan'] as String?,
      json['com.arlanto.atom.guardingRate.location'] as String?,
      json['com.arlanto.atom.guardingRate.entityName'] as String?,
      json['com.arlanto.atom.guardingRate.vendor'] as String?,
      json['com.arlanto.atom.guardingRate.revisedAmt'] as String?,
    );

Map<String, dynamic> _$GRUiLabelsLocaleToJson(GRUiLabelsLocale instance) =>
    <String, dynamic>{
      'com.arlanto.atom.guardingRate.rank.securityGuard':
          instance.securityGuard,
      'com.arlanto.atom.guardingRate.comment': instance.comment,
      'com.arlanto.atom.guardingRate.rank.other': instance.other,
      'com.arlanto.atom.guardingRate.days': instance.days,
      'com.arlanto.atom.guardingRate.entity': instance.entity,
      'com.arlanto.atom.guardingRate.rank.securityFacilitator':
          instance.securityFacilitator,
      'com.arlanto.atom.guardingRate.entrySecurity': instance.entrySecurity,
      'com.arlanto.atom.guardingRate.slNo': instance.slNo,
      'com.arlanto.atom.guardingRate.locationRegion': instance.locationRegion,
      'com.arlanto.atom.guardingRate.toDate': instance.toDate,
      'com.arlanto.atom.guardingRate.perHr': instance.perHr,
      'com.arlanto.atom.guardingRate.fromDate': instance.fromDate,
      'com.arlanto.atom.guardingRate.rank': instance.rank,
      'com.arlanto.atom.guardingRate.inputDate': instance.inputDate,
      'com.arlanto.atom.guardingRate.rank.securitySupervisor':
          instance.securitySupervisor,
      'com.arlanto.atom.guardingRate.rank.securityOfficer':
          instance.securityOfficer,
      'com.arlanto.atom.guardingRate.rank.gunMan': instance.gunMan,
      'com.arlanto.atom.guardingRate.location': instance.location,
      'com.arlanto.atom.guardingRate.entityName': instance.entityName,
      'com.arlanto.atom.guardingRate.vendor': instance.vendor,
      'com.arlanto.atom.guardingRate.revisedAmt': instance.revisedAmt,
    };
