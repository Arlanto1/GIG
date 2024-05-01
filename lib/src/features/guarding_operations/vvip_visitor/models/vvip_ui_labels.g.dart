// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vvip_ui_labels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VVIPUiLabels _$VVIPUiLabelsFromJson(Map<String, dynamic> json) => VVIPUiLabels(
      defaultLocale:
          VVIPUiLabelsLocale.fromJson(json['default'] as Map<String, dynamic>),
      locale:
          VVIPUiLabelsLocale.fromJson(json['locale'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VVIPUiLabelsToJson(VVIPUiLabels instance) =>
    <String, dynamic>{
      'locale': instance.locale,
      'default': instance.defaultLocale,
    };

VVIPUiLabelsLocale _$VVIPUiLabelsLocaleFromJson(Map<String, dynamic> json) =>
    VVIPUiLabelsLocale(
      json['com.arlanto.atom.vvipVisit.list.designation'] as String?,
      json['com.arlanto.atom.vvipVisit.list.startDateVisit'] as String?,
      json['com.arlanto.atom.vvipVisit.status.created'] as String?,
      json['com.arlanto.atom.vvipVisit.slNo'] as String?,
      json['com.arlanto.atom.vvipVisit.entrySecurity'] as String?,
      json['com.arlanto.atom.vvipVisit.list.endDateVisit'] as String?,
      json['com.arlanto.atom.vvipVisit.locationRegion'] as String?,
      json['com.arlanto.atom.vvipVisit.status.submitted'] as String?,
      json['com.arlanto.atom.vvipVisit.location'] as String?,
      json['com.arlanto.atom.vvipVisit.status'] as String?,
      json['com.arlanto.atom.vvipVisit.inputDate'] as String?,
      json['com.arlanto.atom.vvipVisit.list.email'] as String?,
      json['com.arlanto.atom.vvipVisit.status.cancelled'] as String?,
      json['com.arlanto.atom.vvipVisit.list.purpose'] as String?,
      json['com.arlanto.atom.vvipVisit.list.name'] as String?,
      json['com.arlanto.atom.vvipVisit.list.baseLocation'] as String?,
    );

Map<String, dynamic> _$VVIPUiLabelsLocaleToJson(VVIPUiLabelsLocale instance) =>
    <String, dynamic>{
      'com.arlanto.atom.vvipVisit.list.designation':
          instance.visitorDesignation,
      'com.arlanto.atom.vvipVisit.list.startDateVisit': instance.startDateVisit,
      'com.arlanto.atom.vvipVisit.status.created': instance.statusCreated,
      'com.arlanto.atom.vvipVisit.slNo': instance.slNo,
      'com.arlanto.atom.vvipVisit.entrySecurity': instance.entrySecurity,
      'com.arlanto.atom.vvipVisit.list.endDateVisit': instance.endDateVisit,
      'com.arlanto.atom.vvipVisit.locationRegion': instance.locationRegion,
      'com.arlanto.atom.vvipVisit.status.submitted': instance.statusSubmitted,
      'com.arlanto.atom.vvipVisit.location': instance.location,
      'com.arlanto.atom.vvipVisit.status': instance.status,
      'com.arlanto.atom.vvipVisit.inputDate': instance.inputDate,
      'com.arlanto.atom.vvipVisit.list.email': instance.visitorEmailId,
      'com.arlanto.atom.vvipVisit.status.cancelled': instance.statusCancelled,
      'com.arlanto.atom.vvipVisit.list.purpose': instance.purposeOfVisit,
      'com.arlanto.atom.vvipVisit.list.name': instance.visitorName,
      'com.arlanto.atom.vvipVisit.list.baseLocation':
          instance.baseLocationOfVisitor,
    };
