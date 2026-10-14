// part of 'attendance_shifts_cubit.dart';
//
// class AttendanceShiftsState extends Equatable {
//   final FormStatus status;
//   final ShiftModel model;
//   final String? message;
//   final List<String>? locationNames;
//   final List<String>? briefingPoints;
//   final CdUiLabels? labels;
//
//   final List<Organisation>? ranks;
//   final List<Organisation>? shifts;
//   final Organisation? selectedRank;
//   final Organisation? selectedShift;
//
//   final List<SlaList>? shiftSlaList;
//   final NextAvailableDateRange? replacementDates;
//
//   factory AttendanceShiftsState.initial({
//     required ShiftModel model,
//     required String errorMessage,
//     List<String>? dutyPostLocationNames,
//   }) {
//     return AttendanceShiftsState(
//       status: FormStatus.initial,
//       model: model,
//       message: errorMessage,
//       locationNames: dutyPostLocationNames,
//     );
//   }
//
//   ErrorResponse get isValidDraft {
//
//     // if (model.briefingPoints == null && model.attdStatus == 1) {
//     //   return const ErrorResponse(
//     //       status: false, message: 'Please select/enter Briefing Points');
//     // }
//     return const ErrorResponse(status: true, message: 'Form is Valid');
//   }
//
//   ErrorResponse get isValid {
//     // if (model.briefingPoints == null && model.attdStatus == 1) {
//     //   return const ErrorResponse(
//     //       status: false, message: 'Please select/enter Briefing Points');
//     // }
//     return const ErrorResponse(status: true, message: 'Form is Valid');
//   }
//
//   @override
//   List<Object?> get props => [model, status];
//
//   const AttendanceShiftsState({
//     required this.status,
//     required this.model,
//     this.locationNames,
//     this.message,
//     this.briefingPoints,
//     this.labels,
//     this.ranks,
//     this.shifts,
//     this.selectedRank,
//     this.selectedShift,
//     this.shiftSlaList,
//     this.replacementDates,
//
//   });
//
//   AttendanceShiftsState copyWith({
//     FormStatus? status,
//     ShiftModel? model,
//     String? message,
//     List<String>? briefingPoints,
//     List<SlaList>? shiftSlaList,
//     List<User>? entrySecurities,
//     List<Organisation>? ranks,
//     List<Organisation>? shifts,
//     Organisation? selectedRank,
//     Organisation? selectedShift,
//     final CdUiLabels? labels,
//     NextAvailableDateRange? replacementDates,
//   }) {
//     return AttendanceShiftsState(
//       status: status ?? this.status,
//       model: model ?? this.model,
//       locationNames: locationNames ?? locationNames,
//       message: message ?? this.message,
//       briefingPoints: briefingPoints ?? this.briefingPoints,
//       labels: labels ?? this.labels,
//       ranks: ranks ?? this.ranks,
//       shifts: shifts ?? this.shifts,
//       selectedRank: selectedRank ?? this.selectedRank,
//       selectedShift: selectedShift ?? this.selectedShift,
//       shiftSlaList: shiftSlaList ?? shiftSlaList,
//       replacementDates: replacementDates ?? this.replacementDates,
//     );
//   }
// }



part of 'attendance_shifts_cubit.dart';

class AttendanceShiftsState extends Equatable {
  final FormStatus status;
  final AttendanceModel model;
  final Locations? locations;
  final List<Organisation> vendors;
  final User? loggedInUserDetails;
  final List<BaseUser>? users;
  final List<BaseUser>? emailUsers;
  final String? message;
  final List<String>? locationNames;
  final List<User>? entrySecurities;
  final GmUiLabels? labels;
  final int? parentId;

  final DutyPostAttendanceModel? dutyPostAttendanceModel;

  // Dropdown source lists for the deployment form cards.
  final List<Organisation> designations;
  final List<Organisation> shifts;
  final List<Organisation> dutyHoursList;
  final List<Organisation> guardsList;
  final List<Organisation> dutyPostList;

  factory AttendanceShiftsState.initial({
    required AttendanceModel model,
    required Locations locations,
    required User loggedInUserDetails,
    required List<BaseUser>? users,
    final List<BaseUser>? emailUsers,
    required final List<Organisation> departments,
    required String errorMessage,
    List<User>? entrySecurities,
    List<String>? dutyPostLocationNames,
    DutyPostAttendanceModel? dutyPostAttendanceModel,
    List<Organisation>? designations,
    List<Organisation>? shifts,
    List<Organisation>? dutyHoursList,
    List<Organisation>? guardsList,
    List<Organisation>? dutyPostList,
  }) {
    return AttendanceShiftsState(
        status: FormStatus.initial,
        model: model,
        locations: locations,
        loggedInUserDetails: loggedInUserDetails,
        users: users,
        emailUsers: emailUsers,
        message: errorMessage,
        locationNames: dutyPostLocationNames,
        entrySecurities: entrySecurities,
        vendors: departments,
        dutyPostAttendanceModel: dutyPostAttendanceModel,
        designations: designations ?? const [],
        shifts: shifts ?? const [],
        dutyHoursList: dutyHoursList ?? const [],
        guardsList: guardsList ?? const [],
        dutyPostList:dutyPostList ?? const []
    );
  }

  ErrorResponse get isValidDraft {
    log('-model.status---${model.status}--');

    if (model.location == null) {
      log('-model.location-----isValidDraft-');
      return const ErrorResponse(
          status: false, message: 'Please enter Location');
    }
    if (model.status == null) {
      return const ErrorResponse(status: false, message: 'Please enter Status');
    }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  ErrorResponse get isValid {
    if (model.status == null) {
      return const ErrorResponse(status: false, message: 'Please enter Status');
    }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  @override
  List<Object?> get props =>
      [model, status, dutyPostAttendanceModel, designations, shifts, dutyHoursList, dutyPostList];

  const AttendanceShiftsState({
    required this.status,
    required this.model,
    this.locations,
    this.loggedInUserDetails,
    this.users,
    this.emailUsers,
    this.locationNames,
    this.message,
    this.entrySecurities,
    this.labels,
    required this.vendors,
    this.parentId,
    this.dutyPostAttendanceModel,
    this.designations = const [],
    this.shifts = const [],
    this.dutyHoursList = const [],
    this.guardsList = const [],
    this.dutyPostList = const [],
  });

  AttendanceShiftsState copyWith({
    FormStatus? status,
    AttendanceModel? model,
    Locations? locations,
    User? loggedInUserDetails,
    List<BaseUser>? users,
    List<BaseUser>? emailUsers,
    List<String>? locationNames,
    List<Organisation>? vendors,
    String? message,
    List<DutyPostModel>? dutyPosts,
    List<User>? entrySecurities,
    final GmUiLabels? labels,
    int? parentId,
    DutyPostAttendanceModel? dutyPostAttendanceModel,
    List<Organisation>? designations,
    List<Organisation>? shifts,
    List<Organisation>? dutyHoursList,
    List<Organisation>? guardsList,
    List<Organisation>? dutyPostList,

  }) {
    return AttendanceShiftsState(
      status: status ?? this.status,
      model: model ?? this.model,
      locations: locations ?? this.locations,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      users: users ?? this.users,
      emailUsers: emailUsers ?? this.emailUsers,
      locationNames: locationNames ?? this.locationNames,
      message: message ?? this.message,
      entrySecurities: entrySecurities ?? this.entrySecurities,
      labels: labels ?? this.labels,
      vendors: vendors ?? this.vendors,
      parentId: parentId ?? this.parentId,
      dutyPostAttendanceModel: dutyPostAttendanceModel ?? this.dutyPostAttendanceModel,
      designations: designations ?? this.designations,
      shifts: shifts ?? this.shifts,
      dutyHoursList: dutyHoursList ?? this.dutyHoursList,
      guardsList: guardsList ?? this.guardsList,
      dutyPostList: dutyPostList?? this.dutyPostList,

    );
  }
}