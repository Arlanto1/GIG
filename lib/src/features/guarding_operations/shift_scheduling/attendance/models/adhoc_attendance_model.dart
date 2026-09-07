// class AdhocAttendanceGiModel {
//   final int? attendanceId;
//   final String? slNo;
//   final int? status;
//   final int? approvalStatus;
//   final String? screenTitle;
//   final String? emptyStateMessage;
//   final FormOptions? formOptions;
//   final List<Deployments>? deployments;
//   final String? lock;
//
//   AdhocAttendanceGiModel({
//     this.attendanceId,
//     this.slNo,
//     this.status,
//     this.approvalStatus,
//     this.screenTitle,
//     this.emptyStateMessage,
//     this.formOptions,
//     this.deployments,
//     this.lock,
//   });
//
//   factory AdhocAttendanceGiModel.fromJson(Map<String, dynamic> json) {
//     return AdhocAttendanceGiModel(
//       attendanceId: json['attendanceId'] as int?,
//       slNo: json['slNo'] as String?,
//       status: json['status'] as int?,
//       approvalStatus: json['approvalStatus'] as int?,
//       screenTitle: json['screenTitle'] as String?,
//       emptyStateMessage: json['emptyStateMessage'] as String?,
//       formOptions: json['formOptions'] != null
//           ? FormOptions.fromJson(json['formOptions'] as Map<String, dynamic>)
//           : null,
//       deployments: (json['deployments'] as List<dynamic>?)
//           ?.map((e) => Deployments.fromJson(e as Map<String, dynamic>))
//           .toList() ??
//           [],
//       lock: json['lock'] as String?,
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     'attendanceId': attendanceId,
//     'slNo': slNo,
//     'status': status,
//     'approvalStatus': approvalStatus,
//     'screenTitle': screenTitle,
//     'emptyStateMessage': emptyStateMessage,
//     'formOptions': formOptions?.toJson(),
//     'deployments': deployments?.map((e) => e.toJson()).toList(),
//     'lock': lock,
//   };
// }
// adhoc_attendance_model.dart

class AdhocAttendanceGiModel {
  final int? attendanceId;
  final String? slNo;
  final int? status;
  final int? approvalStatus;
   String? approvalComment;
  final String? screenTitle;
  final String? emptyStateMessage;
  final FormOptions? formOptions;
  final List<Deployments>? deployments;
  final String? lock;

  AdhocAttendanceGiModel({
    this.attendanceId,
    this.slNo,
    this.status,
    this.approvalStatus,
    this.approvalComment,
    this.screenTitle,
    this.emptyStateMessage,
    this.formOptions,
    this.deployments,
    this.lock,
  });

  // ADDED: lets callers (e.g. the cubit, when merging in locally-drafted
  // deployment cards) produce a new instance with just `deployments`
  // swapped out, without having to re-list every other field by hand.
  AdhocAttendanceGiModel copyWith({
    int? attendanceId,
    String? slNo,
    int? status,
    int? approvalStatus,
    String? approvalComment,
    String? screenTitle,
    String? emptyStateMessage,
    FormOptions? formOptions,
    List<Deployments>? deployments,
    String? lock,
  }) {
    return AdhocAttendanceGiModel(
      attendanceId: attendanceId ?? this.attendanceId,
      slNo: slNo ?? this.slNo,
      status: status ?? this.status,
      approvalStatus: approvalStatus ?? this.approvalStatus,
      approvalComment : approvalComment?? this.approvalComment,
      screenTitle: screenTitle ?? this.screenTitle,
      emptyStateMessage: emptyStateMessage ?? this.emptyStateMessage,
      formOptions: formOptions ?? this.formOptions,
      deployments: deployments ?? this.deployments,
      lock: lock ?? this.lock,
    );
  }

  factory AdhocAttendanceGiModel.fromJson(Map<String, dynamic> json) {
    return AdhocAttendanceGiModel(
      attendanceId: json['attendanceId'] as int?,
      slNo: json['slNo'] as String?,
      status: json['status'] as int?,
      approvalStatus: json['approvalStatus'] as int?,
      approvalComment: json['approvalComment'] as String?,
      screenTitle: json['screenTitle'] as String?,
      emptyStateMessage: json['emptyStateMessage'] as String?,
      formOptions: json['formOptions'] != null
          ? FormOptions.fromJson(json['formOptions'] as Map<String, dynamic>)
          : null,
      deployments: (json['deployments'] as List<dynamic>?)
          ?.map((e) => Deployments.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
      lock: json['lock'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'attendanceId': attendanceId,
    'slNo': slNo,
    'status': status,
    'approvalStatus': approvalStatus,
    'approvalComment':approvalComment,
    'screenTitle': screenTitle,
    'emptyStateMessage': emptyStateMessage,
    'formOptions': formOptions?.toJson(),
    'deployments': deployments?.map((e) => e.toJson()).toList(),
    'lock': lock,
  };
}

class FormOptions {
  final List<NameOnly>? dutyPosts;
  final List<IdName>? designations;
  final List<IdName>? shifts;
  final List<IdName>? dutyHours;
  final DefaultCard? defaultCard;

  FormOptions({
    this.dutyPosts,
    this.designations,
    this.shifts,
    this.dutyHours,
    this.defaultCard,
  });

  factory FormOptions.fromJson(Map<String, dynamic> json) {
    return FormOptions(
      dutyPosts: (json['dutyPosts'] as List<dynamic>?)
          ?.map((e) => NameOnly.fromJson(e as Map<String, dynamic>))
          .toList(),
      designations: (json['designations'] as List<dynamic>?)
          ?.map((e) => IdName.fromJson(e as Map<String, dynamic>))
          .toList(),
      shifts: (json['shifts'] as List<dynamic>?)
          ?.map((e) => IdName.fromJson(e as Map<String, dynamic>))
          .toList(),
      dutyHours: (json['dutyHours'] as List<dynamic>?)
          ?.map((e) => IdName.fromJson(e as Map<String, dynamic>))
          .toList(),
      defaultCard: json['defaultCard'] != null
          ? DefaultCard.fromJson(json['defaultCard'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'dutyPosts': dutyPosts?.map((e) => e.toJson()).toList(),
    'designations': designations?.map((e) => e.toJson()).toList(),
    'shifts': shifts?.map((e) => e.toJson()).toList(),
    'dutyHours': dutyHours?.map((e) => e.toJson()).toList(),
    'defaultCard': defaultCard?.toJson(),
  };
}

class NameOnly {
  final String? name;
  NameOnly({this.name});
  factory NameOnly.fromJson(Map<String, dynamic> json) =>
      NameOnly(name: json['name'] as String?);
  Map<String, dynamic> toJson() => {'name': name};
}

class IdName {
  final int? id;
  final String? name;
  IdName({this.id, this.name});
  factory IdName.fromJson(Map<String, dynamic> json) => IdName(
    id: json['id'] as int?,
    name: json['name'] as String?,
  );
  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

class DefaultCard {
  final String? dutyPostName;
  final String? shift;
  final String? designation;
  final String? requiredLabel;
  final String? dutyHoursLabel;

  DefaultCard({
    this.dutyPostName,
    this.shift,
    this.designation,
    this.requiredLabel,
    this.dutyHoursLabel,
  });

  factory DefaultCard.fromJson(Map<String, dynamic> json) => DefaultCard(
    dutyPostName: json['dutyPostName'] as String?,
    shift: json['shift'] as String?,
    designation: json['designation'] as String?,
    requiredLabel: json['requiredLabel'] as String?,
    dutyHoursLabel: json['dutyHoursLabel'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'dutyPostName': dutyPostName,
    'shift': shift,
    'designation': designation,
    'requiredLabel': requiredLabel,
    'dutyHoursLabel': dutyHoursLabel,
  };
}

class Deployments {
  final int? attendanceShiftId;
  final String? dutyPostName;
  final int? shiftId;
  final String? shift;
  final int? rankId;
  final String? designation;
  final int? required;
  final int? supplied;
  final int? shortage;
  final int? overTime;
  final int? dutyHours;
  final int? attendanceStatus;
  final String? attendanceStatusLabel;
  final String? attendanceDateTime;
  final List<AttendedGuard>? attendedGuards;
  final List<dynamic>? violations;

  Deployments({
    this.attendanceShiftId,
    this.dutyPostName,
    this.shiftId,
    this.shift,
    this.rankId,
    this.designation,
    this.required,
    this.supplied,
    this.shortage,
    this.overTime,
    this.dutyHours,
    this.attendanceStatus,
    this.attendanceStatusLabel,
    this.attendanceDateTime,
    this.attendedGuards,
    this.violations,
  });

  factory Deployments.fromJson(Map<String, dynamic> json) {
    return Deployments(
      attendanceShiftId: json['attendanceShiftId'] as int?,
      dutyPostName: json['dutyPostName'] as String?,
      shiftId: json['shiftId'] as int?,
      shift: json['shift'] as String?,
      rankId: json['rankId'] as int?,
      designation: json['designation'] as String?,
      required: json['required'] as int?,
      supplied: json['supplied'] as int?,
      shortage: json['shortage'] as int?,
      overTime: json['overTime'] as int?,
      dutyHours: json['dutyHours'] as int?,
      attendanceStatus: json['attendanceStatus'] as int?,
      attendanceStatusLabel: json['attendanceStatusLabel'] as String?,
      attendanceDateTime: json['attendanceDateTime'] as String?,
      attendedGuards: (json['attendedGuards'] as List<dynamic>?)
          ?.map((e) => AttendedGuard.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
      violations: (json['violations'] as List<dynamic>?) ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    'attendanceShiftId': attendanceShiftId,
    'dutyPostName': dutyPostName,
    'shiftId': shiftId,
    'shift': shift,
    'rankId': rankId,
    'designation': designation,
    'required': required,
    'supplied': supplied,
    'shortage': shortage,
    'overTime': overTime,
    'dutyHours': dutyHours,
    'attendanceStatus': attendanceStatus,
    'attendanceStatusLabel': attendanceStatusLabel,
    'attendanceDateTime': attendanceDateTime,
    'attendedGuards': attendedGuards?.map((e) => e.toJson()).toList(),
    'violations': violations,
  };
}

class AttendedGuard {
  final int? attendanceId;
  final int? guardId;
  final String? guardName;
  final int? shiftId;
  final String? shift;
  final String? startDateTime;
  final String? endDateTime;
  final int? overTime;
  final double? totalHours;

  AttendedGuard({
    this.attendanceId,
    this.guardId,
    this.guardName,
    this.shiftId,
    this.shift,
    this.startDateTime,
    this.endDateTime,
    this.overTime,
    this.totalHours,
  });

  factory AttendedGuard.fromJson(Map<String, dynamic> json) {
    return AttendedGuard(
      attendanceId: json['attendanceId'] as int?,
      guardId: json['guardId'] as int?,
      guardName: json['guardName'] as String?,
      shiftId: json['shiftId'] as int?,
      shift: json['shift'] as String?,
      startDateTime: json['startDateTime'] as String?,
      endDateTime: json['endDateTime'] as String?,
      overTime: json['overTime'] as int?,
      totalHours: (json['totalHours'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'attendanceId': attendanceId,
    'guardId': guardId,
    'guardName': guardName,
    'shiftId': shiftId,
    'shift': shift,
    'startDateTime': startDateTime,
    'endDateTime': endDateTime,
    'overTime': overTime,
    'totalHours': totalHours,
  };
}