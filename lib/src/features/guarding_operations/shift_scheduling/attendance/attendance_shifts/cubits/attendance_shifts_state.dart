part of 'attendance_shifts_cubit.dart';

class AttendanceShiftsState extends Equatable {
  final FormStatus status;
  final DutyPostModel model;
  final Locations? locations;
  final List<Organisation> departments;
  final User? loggedInUserDetails;
  final List<BaseUser>? users;
  final List<BaseUser>? emailUsers;
  final String? message;
  final List<String>? locationNames;
  final List<User>? entrySecurities;
  final List<String>? briefingPoints;
  final GmUiLabels? labels;
  final List<SlaList>? shiftSlaList;

  factory AttendanceShiftsState.initial({
    required DutyPostModel model,
    required Locations locations,
    required User loggedInUserDetails,
    required List<BaseUser>? users,
    final List<BaseUser>? emailUsers,
    required final List<Organisation> departments,
    required String errorMessage,
    List<User>? entrySecurities,
    List<String>? dutyPostLocationNames,
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
      departments: departments,
    );
  }

  ErrorResponse get isValidDraft {
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  ErrorResponse get isValid {
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  @override
  List<Object?> get props => [model, status];

  const AttendanceShiftsState({
    required this.status,
    required this.model,
    this.locations,
    this.loggedInUserDetails,
    this.users,
    this.emailUsers,
    this.locationNames,
    this.message,
    this.briefingPoints,
    this.entrySecurities,
    this.labels,
    required this.departments,
    this.shiftSlaList,
  });

  AttendanceShiftsState copyWith({
    FormStatus? status,
    DutyPostModel? model,
    Locations? locations,
    User? loggedInUserDetails,
    List<BaseUser>? users,
    List<BaseUser>? emailUsers,
    List<String>? locationNames,
    List<Organisation>? vendors,
    String? message,
    List<String>? briefingPoints,
    List<SlaList>? shiftSlaList,
    List<User>? entrySecurities,
    final GmUiLabels? labels,
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
      briefingPoints: briefingPoints ?? this.briefingPoints,
      labels: labels ?? this.labels,
      departments: vendors ?? departments,
      shiftSlaList: shiftSlaList ?? shiftSlaList,
    );
  }
}
