import 'package:db_atom/index.dart';

import '../attendance_shifts/views/attendance_shifts_view.dart';

class DutyPostAttendanceModel {
  DutyPostAttendanceModel({
     this.attendanceInfoId,
     this.dutyPosts,
     this.briefingPointsG,
     this.briefingPointsC,
     this.briefingPointsB,
     this.isEligibleToEdit,
     this.briefingPoints,
     this.briefingPointsA,
     this.inputDate,
     this.slNo,
     this.status,
    this.lock,
  });
    int? attendanceInfoId;
    List<DutyPosts>? dutyPosts;
    String? briefingPointsG;
    String? briefingPointsC;
    String? briefingPointsB;
    bool? isEligibleToEdit;
    String? briefingPoints;
    String? briefingPointsA;
    String? inputDate;
    String? slNo;
    int? status;
    Null lock;

  DutyPostAttendanceModel.fromJson(Map<String, dynamic> json){
    attendanceInfoId = json['attendanceInfoId'];
    dutyPosts = List.from(json['dutyPosts']).map((e)=>DutyPosts.fromJson(e)).toList();
    briefingPointsG = json['briefingPointsG'];
    briefingPointsC = json['briefingPointsC'];
    briefingPointsB = json['briefingPointsB'];
    isEligibleToEdit = json['isEligibleToEdit'];
    briefingPoints = json['briefingPoints'];
    briefingPointsA = json['briefingPointsA'];
    inputDate = json['inputDate'];
    slNo = json['slNo'];
    status = json['status'];
    lock = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['attendanceInfoId'] = attendanceInfoId;
    _data['dutyPosts'] = dutyPosts?.map((e)=>e.toJson()).toList();
    _data['briefingPointsG'] = briefingPointsG;
    _data['briefingPointsC'] = briefingPointsC;
    _data['briefingPointsB'] = briefingPointsB;
    _data['isEligibleToEdit'] = isEligibleToEdit;
    _data['briefingPoints'] = briefingPoints;
    _data['briefingPointsA'] = briefingPointsA;
    _data['inputDate'] = inputDate;
    _data['slNo'] = slNo;
    _data['status'] = status;
    _data['lock'] = lock;
    return _data;
  }
}

class DutyPosts {
  DutyPosts({
     this.dutyPostName,
     this.ranks,
     this.dutyPostNameId,
  });
    String? dutyPostName;
    List<Ranks>? ranks;
    int? dutyPostNameId;

  DutyPosts.fromJson(Map<String, dynamic> json){
    dutyPostName = json['dutyPostName'];
    ranks = List.from(json['ranks']).map((e)=>Ranks.fromJson(e)).toList();
    dutyPostNameId = json['dutyPostNameId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['dutyPostName'] = dutyPostName;
    _data['ranks'] = ranks?.map((e)=>e.toJson()).toList();
    _data['dutyPostNameId'] = dutyPostNameId;
    return _data;
  }
}

class Ranks {
  Ranks({
     this.rankId,
     this.rankName,
     this.shifts,
  });
    int? rankId;
    String? rankName;
    List<Shifts>? shifts;

  Ranks.fromJson(Map<String, dynamic> json){
    rankId = json['rankId'];
    rankName = json['rankName'];
    shifts = List.from(json['shifts']).map((e)=>Shifts.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['rankId'] = rankId;
    _data['rankName'] = rankName;
    _data['shifts'] = shifts?.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Shifts {
  Shifts({
     this.attended,
     this.shiftId,
     this.allowed,
     this.shift,
     this.availableGuards,
     this.shiftName,
     this.attdStatus,
     this.selectForAttendance,
     this.attendanceShiftId,
     this.activeShift,
     this.previousShift,
     this.replacements,
     this.selectForReplacements,
    // this.slaViolations = const [],
  });
    List<Attended>? attended;
    int? shiftId;
    int? allowed;
    String? shift;
    List<AvailableGuards>? availableGuards;
    String? shiftName;
    int? attdStatus;
    List<SelectForAttendance>? selectForAttendance;
    int? attendanceShiftId;
    bool? activeShift;
    List<dynamic>? previousShift;
    List<Replacement>? replacements;
    List<SelectForReplacements>? selectForReplacements;
    List<ShiftSlaViolation> slaViolations =[];

  Shifts.fromJson(Map<String, dynamic> json){
    attended = List.from(json['attended']).map((e)=>Attended.fromJson(e)).toList();
    shiftId = json['shiftId'];
    allowed = json['allowed'];
    shift = json['shift'];
    availableGuards = List.from(json['availableGuards']).map((e)=>AvailableGuards.fromJson(e)).toList();
    shiftName = json['shiftName'];
    attdStatus = json['attdStatus'];
    selectForAttendance = List.from(json['selectForAttendance']).map((e)=>SelectForAttendance.fromJson(e)).toList();
    attendanceShiftId = json['attendanceShiftId'];
    activeShift = json['activeShift'];
    previousShift = List.castFrom<dynamic, dynamic>(json['previousShift']);
    replacements = List.from(json['replacements']).map((e)=>Replacement.fromJson(e)).toList();
    selectForReplacements = List.from(json['selectForReplacements']).map((e)=>SelectForReplacements.fromJson(e)).toList();
    // slaViolations = List.from(json['slaViolations']);

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['attended'] = attended?.map((e)=>e.toJson()).toList();
    _data['shiftId'] = shiftId;
    _data['allowed'] = allowed;
    _data['shift'] = shift;
    _data['availableGuards'] = availableGuards?.map((e)=>e.toJson()).toList();
    _data['shiftName'] = shiftName;
    _data['attdStatus'] = attdStatus;
    _data['selectForAttendance'] = selectForAttendance?.map((e)=>e.toJson()).toList();
    _data['attendanceShiftId'] = attendanceShiftId;
    _data['activeShift'] = activeShift;
    _data['previousShift'] = previousShift;
    _data['replacements'] = replacements?.map((e)=>e.toJson()).toList();
    _data['selectForReplacements'] = selectForReplacements?.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Attended {
  Attended({
     this.id,
     this.name,
  });
    int? id;
    String? name;

  Attended.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class AvailableGuards {
  AvailableGuards({
     this.id,
     this.name,
  });
    int? id;
    String? name;

  AvailableGuards.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class SelectForAttendance {
  SelectForAttendance({
     this.id,
     this.name,
  });
    int? id;
    String? name;

  SelectForAttendance.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class SelectForReplacements {
  SelectForReplacements({
     this.id,
     this.name,
  });
    int? id;
    String? name;

  SelectForReplacements.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

// class Replacement {
//   Replacement({
//      this.id,
//      this.replacedFor,
//      this.replacementBy,
//      this.fromDate,
//      this.toDate,
//      this.status,
//      this.statusActive,
//   });
//    int? id;
//    ReplacedFor? replacedFor;
//    ReplacementBy? replacementBy;
//    String? fromDate;
//    String? toDate;
//    int? status;
//    bool? statusActive;
//
//   Replacement.fromJson(Map<String, dynamic> json){
//     id = json['id'];
//     replacedFor = ReplacedFor.fromJson(json['replacedFor']);
//     replacementBy = ReplacementBy.fromJson(json['replacementBy']);
//     fromDate = json['fromDate'];
//     toDate = json['toDate'];
//     status = json['status'];
//     statusActive = json['statusActive'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['replacedFor'] = replacedFor?.toJson();
//     _data['replacementBy'] = replacementBy?.toJson();
//     _data['fromDate'] = fromDate;
//     _data['toDate'] = toDate;
//     _data['status'] = status;
//     _data['statusActive'] = statusActive;
//     return _data;
//   }
// }

class ReplacedFor {
  ReplacedFor({
     this.id,
     this.name,
  });
   int? id;
   String? name;

  ReplacedFor.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class ReplacementBy {
  ReplacementBy({
     this.id,
     this.name,
  });
   int? id;
   String? name;

  ReplacementBy.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}
