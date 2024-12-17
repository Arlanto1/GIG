// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duty_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rank _$RankFromJson(Map<String, dynamic> json) => Rank(
      rank: (json['rank'] as num?)?.toInt(),
      shifts: (json['shifts'] as List<dynamic>?)
          ?.map((e) => ShiftModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      attendanceShift: (json['attendanceShift'] as List<dynamic>?)
          ?.map((e) => ShiftModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RankToJson(Rank instance) => <String, dynamic>{
      'rank': instance.rank,
      'shifts': instance.shifts,
      'attendanceShift': instance.attendanceShift,
    };

ShiftModel _$ShiftModelFromJson(Map<String, dynamic> json) => ShiftModel(
      shift: json['shift'] as String?,
      allowed: (json['allowed'] as num?)?.toInt(),
      attendanceShiftId: (json['attendanceShiftId'] as num?)?.toInt(),
      attdStatus: (json['attdStatus'] as num?)?.toInt(),
      activeShift: json['activeShift'] as bool? ?? false,
      selectedGuards: (json['selectedGuards'] as List<dynamic>?)
          ?.map((e) => BaseUser.fromJson(e as Map<String, dynamic>))
          .toSet(),
      availableGuards: (json['availableGuards'] as List<dynamic>?)
          ?.map((e) => BaseUser.fromJson(e as Map<String, dynamic>))
          .toSet(),
      selectForAttendance: (json['selectForAttendance'] as List<dynamic>?)
          ?.map((e) => BaseUser.fromJson(e as Map<String, dynamic>))
          .toSet(),
      attended: (json['attended'] as List<dynamic>?)
          ?.map((e) => BaseUser.fromJson(e as Map<String, dynamic>))
          .toSet(),
      previousShift: (json['previousShift'] as List<dynamic>?)
          ?.map((e) => BaseUser.fromJson(e as Map<String, dynamic>))
          .toSet(),
      briefingPoints: json['briefingPoints'] as String?,
      replacements: (json['replacements'] as List<dynamic>?)
          ?.map((e) => Replacement.fromJson(e as Map<String, dynamic>))
          .toSet(),
      selectForReplacements: (json['selectForReplacements'] as List<dynamic>?)
          ?.map((e) => BaseUser.fromJson(e as Map<String, dynamic>))
          .toSet(),
    )..lock = json['lock'] as String?;

Map<String, dynamic> _$ShiftModelToJson(ShiftModel instance) =>
    <String, dynamic>{
      'lock': instance.lock,
      'shift': instance.shift,
      'attendanceShiftId': instance.attendanceShiftId,
      'allowed': instance.allowed,
      'attdStatus': instance.attdStatus,
      'activeShift': instance.activeShift,
      'selectedGuards': instance.selectedGuards?.toList(),
      'availableGuards': instance.availableGuards?.toList(),
      'replacements': instance.replacements?.toList(),
      'selectForAttendance': instance.selectForAttendance?.toList(),
      'selectForReplacements': instance.selectForReplacements?.toList(),
      'attended': instance.attended?.toList(),
      'previousShift': instance.previousShift?.toList(),
      'briefingPoints': instance.briefingPoints,
    };

Replacement _$ReplacementFromJson(Map<String, dynamic> json) => Replacement(
      id: (json['id'] as num?)?.toInt(),
      replacedFor: json['replacedFor'] == null
          ? null
          : BaseUser.fromJson(json['replacedFor'] as Map<String, dynamic>),
      replacementBy: json['replacementBy'] == null
          ? null
          : BaseUser.fromJson(json['replacementBy'] as Map<String, dynamic>),
      fromDate: json['fromDate'] as String?,
      toDate: json['toDate'] as String?,
      status: (json['status'] as num?)?.toInt(),
      tempId: json['tempId'] as String?,
      statusActive: json['statusActive'] as bool?,
    );

Map<String, dynamic> _$ReplacementToJson(Replacement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'replacedFor': instance.replacedFor,
      'replacementBy': instance.replacementBy,
      'fromDate': instance.fromDate,
      'toDate': instance.toDate,
      'status': instance.status,
      'statusActive': instance.statusActive,
      'tempId': instance.tempId,
    };
