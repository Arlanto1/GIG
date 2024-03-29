// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duty_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rank _$RankFromJson(Map<String, dynamic> json) => Rank(
      rank: json['rank'] as int?,
      shifts: (json['shifts'] as List<dynamic>?)
          ?.map((e) => Shift.fromJson(e as Map<String, dynamic>))
          .toList(),
      attendanceShift: (json['attendanceShift'] as List<dynamic>?)
          ?.map((e) => Shift.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RankToJson(Rank instance) => <String, dynamic>{
      'rank': instance.rank,
      'shifts': instance.shifts,
      'attendanceShift': instance.attendanceShift,
    };

Shift _$ShiftFromJson(Map<String, dynamic> json) => Shift(
      shift: json['shift'] as String?,
      allowed: json['allowed'] as int?,
      attendanceShiftId: json['attendanceShiftId'] as int?,
      attdStatus: json['attdStatus'] as int?,
      activeShift: json['activeShift'] as bool? ?? false,
      selectedGuards: (json['selectedGuards'] as List<dynamic>?)
          ?.map((e) => BaseUser.fromJson(e as Map<String, dynamic>))
          .toList(),
      availableGuards: (json['availableGuards'] as List<dynamic>?)
          ?.map((e) => BaseUser.fromJson(e as Map<String, dynamic>))
          .toList(),
      selectForAttendance: (json['selectForAttendance'] as List<dynamic>?)
          ?.map((e) => BaseUser.fromJson(e as Map<String, dynamic>))
          .toList(),
      attended: (json['attended'] as List<dynamic>?)
          ?.map((e) => BaseUser.fromJson(e as Map<String, dynamic>))
          .toList(),
      previousShift: (json['previousShift'] as List<dynamic>?)
          ?.map((e) => BaseUser.fromJson(e as Map<String, dynamic>))
          .toList(),
      briefingPoints: json['briefingPoints'] as String?,
      replacements: (json['replacements'] as List<dynamic>?)
          ?.map((e) => Replacement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ShiftToJson(Shift instance) => <String, dynamic>{
      'shift': instance.shift,
      'attendanceShiftId': instance.attendanceShiftId,
      'allowed': instance.allowed,
      'attdStatus': instance.attdStatus,
      'activeShift': instance.activeShift,
      'selectedGuards': instance.selectedGuards,
      'availableGuards': instance.availableGuards,
      'replacements': instance.replacements,
      'selectForAttendance': instance.selectForAttendance,
      'attended': instance.attended,
      'previousShift': instance.previousShift,
      'briefingPoints': instance.briefingPoints,
    };

Replacement _$ReplacementFromJson(Map<String, dynamic> json) => Replacement(
      id: json['id'] as int?,
      replacedFor: json['replacedFor'] == null
          ? null
          : BaseUser.fromJson(json['replacedFor'] as Map<String, dynamic>),
      replacementBy: json['replacementBy'] == null
          ? null
          : BaseUser.fromJson(json['replacementBy'] as Map<String, dynamic>),
      fromDate: json['fromDate'] as String?,
      toDate: json['toDate'] as String?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$ReplacementToJson(Replacement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'replacedFor': instance.replacedFor,
      'replacementBy': instance.replacementBy,
      'fromDate': instance.fromDate,
      'toDate': instance.toDate,
      'status': instance.status,
    };
