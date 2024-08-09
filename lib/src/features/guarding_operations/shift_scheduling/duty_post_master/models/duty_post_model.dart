import 'dart:developer';

import '../../../../../../index.dart';

part 'duty_post_model.g.dart';

class DutyPostModel {
  int? id;
  int? dutyPostNameId;

  String? name;
  List<Rank>? ranks;

  DutyPostModel({
    this.id,
    this.name,
    this.ranks,
  });

  DutyPostModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        dutyPostNameId = json['dutyPostNameId'] as int?,
        name = json['name'] as String?,
        ranks = (json['ranks'] as List?)
            ?.map((dynamic e) => Rank.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'dutyPostNameId': dutyPostNameId,
        'name': name,
        'ranks': ranks?.map((e) => e.toJson()).toList(),
      };

  @override
  String toString() {
    return 'DutyPostModel{id: $id, dutyPostNameId: $dutyPostNameId, name: $name, ranks: $ranks}';
  }
}

@JsonSerializable()
class Rank {
  int? rank;
  List<Shift>? shifts;
  List<Shift>? attendanceShift;

  Rank({
    this.rank,
    this.shifts,
    this.attendanceShift,
  });

  factory Rank.fromJson(Map<String, dynamic> json) {
    try {
      return _$RankFromJson(json);
    } catch (e) {
      if (e is CheckedFromJsonException) {
        // Access the information about the error
        log('Error during deserialization: ${e.message}, path: ${e.key}');
      } else {
        // Handle other types of exceptions if needed
        log('Unexpected error during deserialization: $e');
      }

      // Return a default instance or handle differently based on your needs.
      return Rank();
    }
  }

  Map<String, dynamic> toJson() => _$RankToJson(this);

  // Rank.fromJson(Map<String, dynamic> json)
  //     : rank = json['rank'] as int?,
  //       shifts = (json['shifts'] as List?)
  //           ?.map((dynamic e) => Shift.fromJson(e as Map<String, dynamic>))
  //           .toList(),
  //       attendanceShift = (json['attendanceShift'] as List?)
  //           ?.map((dynamic e) => Shift.fromJson(e as Map<String, dynamic>))
  //           .toList();
  //
  // Map<String, dynamic> toJson() =>
  //     {'rank': rank, 'shifts': shifts?.map((e) => e.toJson()).toList()};

  @override
  String toString() {
    return 'Rank{rank: $rank, shifts: $shifts}';
  }
}

@JsonSerializable()
class Shift {
  String? shift;
  int? attendanceShiftId;
  int? allowed;
  int? attdStatus;
  bool activeShift;
  List<BaseUser>? selectedGuards;
  List<BaseUser>? availableGuards;
  Set<Replacement>? replacements;

  List<BaseUser>? selectForAttendance;
  List<BaseUser>? attended;
  List<BaseUser>? previousShift;
  String? briefingPoints;

  Shift({
    this.shift,
    this.allowed,
    this.attendanceShiftId,
    this.attdStatus,
    this.activeShift = false,
    this.selectedGuards,
    this.availableGuards,
    this.selectForAttendance,
    this.attended,
    this.previousShift,
    this.briefingPoints,
    this.replacements,
  });

  factory Shift.fromJson(Map<String, dynamic> json) {
    try {
      return _$ShiftFromJson(json);
    } catch (e) {
      if (e is CheckedFromJsonException) {
        // Access the information about the error
        log('Error during deserialization: ${e.message}, path: ${e.key}');
      } else {
        // Handle other types of exceptions if needed
        log('Unexpected error during deserialization: $e');
      }

      // Return a default instance or handle differently based on your needs.
      return Shift();
    }
  }

  Map<String, dynamic> toJson() => _$ShiftToJson(this);

  @override
  String toString() {
    return 'Shift{shift: $shift, attendanceShiftId: $attendanceShiftId, allowed: $allowed, attdStatus: $attdStatus, activeShift: $activeShift, selectedGuards: $selectedGuards, availableGuards: $availableGuards, replacements: $replacements, selectForAttendance: $selectForAttendance, attended: $attended, previousShift: $previousShift, briefingPoints: $briefingPoints}';
  }

// Shift.fromJson(Map<String, dynamic> json)
//     : shift = json['shift'] as String?,
//       allowed = json['allowed'] as int?,
//       selectedGuards = (json['selectedGuards'] as List?)
//           ?.map((dynamic e) => BaseUser.fromJson(e as Map<String, dynamic>))
//           .toList(),
//       availableGuards = (json['availableGuards'] as List?)
//           ?.map((dynamic e) => BaseUser.fromJson(e as Map<String, dynamic>))
//           .toList(),
//       replacements = (json['replacements'] as List?)
//           ?.map(
//               (dynamic e) => Replacement.fromJson(e as Map<String, dynamic>))
//           .toList();
//
// Map<String, dynamic> toJson() => {
//       'shift': shift,
//       'allowed': allowed,
//       'selectedGuards': selectedGuards?.map((e) => e.toJson()).toList(),
//       'availableGuards': availableGuards?.map((e) => e.toJson()).toList(),
//       'replacement': replacement
//     };
}

@JsonSerializable()
class Replacement {
  int? id;
  BaseUser? replacedFor;
  BaseUser? replacementBy;
  String? fromDate;
  String? toDate;
  int? status;

  /// For front end only
  String? tempId;

  Replacement({
    this.id,
    this.replacedFor,
    this.replacementBy,
    this.fromDate,
    this.toDate,
    this.status,
    this.tempId,
  });

  factory Replacement.fromJson(Map<String, dynamic> json) {
    try {
      return _$ReplacementFromJson(json);
    } catch (e) {
      if (e is CheckedFromJsonException) {
        // Access the information about the error
        log('Error during deserialization: ${e.message}, path: ${e.key}');
      } else {
        // Handle other types of exceptions if needed
        log('Unexpected error during deserialization: $e');
      }

      // Return a default instance or handle differently based on your needs.
      return Replacement();
    }
  }

  Map<String, dynamic> toJson() => _$ReplacementToJson(this);

  @override
  String toString() {
    return 'Replacement{id: $id, replacedFor: $replacedFor, replacementBy: $replacementBy, fromDate: $fromDate, toDate: $toDate, status: $status}';
  }
}
