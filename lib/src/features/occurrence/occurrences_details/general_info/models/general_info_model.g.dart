// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OccurrenceModel _$OccurrenceModelFromJson(Map<String, dynamic> json) =>
    OccurrenceModel(
      id: (json['id'] as num?)?.toInt(),
      slNo: json['slNo'] as String?,
      inputDate: json['inputDate'] as String?,
      entrySecurity: json['entrySecurity'] == null
          ? null
          : User.fromJson(json['entrySecurity'] as Map<String, dynamic>),
      handoverSecurity: json['handoverSecurity'] == null
          ? null
          : User.fromJson(json['handoverSecurity'] as Map<String, dynamic>),
      location: json['location'] == null
          ? null
          : Organisation.fromJson(json['location'] as Map<String, dynamic>),
      locationRegion: json['locationRegion'] == null
          ? null
          : Organisation.fromJson(
              json['locationRegion'] as Map<String, dynamic>),
      shiftBrfngAttnded: json['shiftBrfngAttnded'] as bool? ?? false,
      premisesRoundTkn: json['premisesRoundTkn'] as bool? ?? false,
      premisesRoundTknComments: json['premisesRoundTknComments'] as String?,
      medicalEmrgncy: json['medicalEmrgncy'] as bool? ?? false,
      medicalEmrgncyComments: json['medicalEmrgncyComments'] as String?,
      materialMovement: json['materialMovement'] as bool? ?? false,
      leoVisit: json['leoVisit'] as bool? ?? false,
      socialEnggIncdnt: json['socialEnggIncdnt'] as bool? ?? false,
      socialEnggIncdntComments: json['socialEnggIncdntComments'] as String?,
      foundArticleTrnsctn: json['foundArticleTrnsctn'] as bool? ?? false,
      processBreachIncdnt: json['processBreachIncdnt'] as bool? ?? false,
      infraIssue: json['infraIssue'] as bool? ?? false,
      infraIssueComments: json['infraIssueComments'] as String?,
      suspiciousActivity: json['suspiciousActivity'] as bool? ?? false,
      fireAlarmEmrgncy: json['fireAlarmEmrgncy'] as bool? ?? false,
      fireAlarmEmrgncyComments: json['fireAlarmEmrgncyComments'] as String?,
      landlordIssue: json['landlordIssue'] as bool? ?? false,
      landlordIssueComments: json['landlordIssueComments'] as String?,
      secSysFailureIncdnt: json['secSysFailureIncdnt'] as bool? ?? false,
      sysAlarmRcvd: json['sysAlarmRcvd'] as bool? ?? false,
      sysAlarmRcvdComments: json['sysAlarmRcvdComments'] as String?,
      transportIncdnt: json['transportIncdnt'] as bool? ?? false,
      transportIncdntComments: json['transportIncdntComments'] as String?,
      anyEvent: json['anyEvent'] as bool? ?? false,
      notifyScri: json['notifyScri'] as String?,
      powerFailure: json['powerFailure'] as bool? ?? false,
      atmVendorVisit: json['atmVendorVisit'] as bool? ?? false,
      cwmVisit: json['cwmVisit'] as bool? ?? false,
      comments: json['comments'] as String?,
      dgWrking: json['dgWrking'] as bool? ?? false,
      modifiedBy: json['modifiedBy'] as String?,
      incidentItems: (json['incidentItems'] as List<dynamic>?)
          ?.map((e) => IncidentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      secSysFailureIncident: json['secSysFailureIncident'] as List<dynamic>?,
      followedUp: json['followedUp'] as bool? ?? false,
      status: (json['status'] as num?)?.toInt(),
      powerFailures: (json['powerFailures'] as List<dynamic>?)
          ?.map((e) => PowerFailureModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      lock: json['lock'] as String?,
    );

Map<String, dynamic> _$OccurrenceModelToJson(OccurrenceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slNo': instance.slNo,
      'inputDate': instance.inputDate,
      'entrySecurity': instance.entrySecurity,
      'handoverSecurity': instance.handoverSecurity,
      'location': instance.location,
      'locationRegion': instance.locationRegion,
      'shiftBrfngAttnded': instance.shiftBrfngAttnded,
      'premisesRoundTkn': instance.premisesRoundTkn,
      'premisesRoundTknComments': instance.premisesRoundTknComments,
      'medicalEmrgncy': instance.medicalEmrgncy,
      'medicalEmrgncyComments': instance.medicalEmrgncyComments,
      'materialMovement': instance.materialMovement,
      'leoVisit': instance.leoVisit,
      'socialEnggIncdnt': instance.socialEnggIncdnt,
      'socialEnggIncdntComments': instance.socialEnggIncdntComments,
      'foundArticleTrnsctn': instance.foundArticleTrnsctn,
      'processBreachIncdnt': instance.processBreachIncdnt,
      'infraIssue': instance.infraIssue,
      'infraIssueComments': instance.infraIssueComments,
      'suspiciousActivity': instance.suspiciousActivity,
      'fireAlarmEmrgncy': instance.fireAlarmEmrgncy,
      'fireAlarmEmrgncyComments': instance.fireAlarmEmrgncyComments,
      'landlordIssue': instance.landlordIssue,
      'landlordIssueComments': instance.landlordIssueComments,
      'secSysFailureIncdnt': instance.secSysFailureIncdnt,
      'sysAlarmRcvd': instance.sysAlarmRcvd,
      'sysAlarmRcvdComments': instance.sysAlarmRcvdComments,
      'transportIncdnt': instance.transportIncdnt,
      'transportIncdntComments': instance.transportIncdntComments,
      'anyEvent': instance.anyEvent,
      'notifyScri': instance.notifyScri,
      'powerFailure': instance.powerFailure,
      'atmVendorVisit': instance.atmVendorVisit,
      'cwmVisit': instance.cwmVisit,
      'comments': instance.comments,
      'dgWrking': instance.dgWrking,
      'modifiedBy': instance.modifiedBy,
      'powerFailures': instance.powerFailures,
      'incidentItems': instance.incidentItems,
      'secSysFailureIncident': instance.secSysFailureIncident,
      'followedUp': instance.followedUp,
      'status': instance.status,
      'lock': instance.lock,
    };
