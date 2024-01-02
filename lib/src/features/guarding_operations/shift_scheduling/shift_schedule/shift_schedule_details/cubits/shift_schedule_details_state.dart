part of 'shift_schedule_details_cubit.dart';

class ShiftScheduleDetailsState extends Equatable {
  final FormStatus status;
  final ShiftScheduleModel model;
  final Locations? locations;
  final User? loggedInUserDetails;
  final List<BaseUser>? users;
  final List<BaseUser>? emailUsers;
  final List<Organisation> departments;
  final String? message;
  final List<User>? entrySecurities;
  final GmUiLabels? labels;

  factory ShiftScheduleDetailsState.initial({
    required ShiftScheduleModel model,
    required Locations locations,
    required User loggedInUserDetails,
    required List<BaseUser>? users,
    final List<BaseUser>? emailUsers,
    required final List<Organisation> departments,
    required String errorMessage,
    List<User>? entrySecurities,
  }) {
    return ShiftScheduleDetailsState(
      status: FormStatus.initial,
      model: model,
      locations: locations,
      loggedInUserDetails: loggedInUserDetails,
      users: users,
      departments: departments,
      emailUsers: emailUsers,
      message: errorMessage,
      entrySecurities: entrySecurities,
    );
  }

  ErrorResponse get isValidDraft {
    log('-model.status---${model.status}--');

    if (model.location == null) {
      log('-model.location-----isValidDraft-');
      return const ErrorResponse(
          status: false, message: 'Please enter Location');
    }
    if (model.entrySecurity == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Entry Security');
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
    if (model.vendor == null) {
      return const ErrorResponse(status: false, message: 'Please enter Vendor');
    }
    if (model.dutyType == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Type of Duty');
    }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  @override
  List<Object?> get props => [model, status];

  const ShiftScheduleDetailsState({
    required this.status,
    required this.model,
    this.locations,
    this.loggedInUserDetails,
    this.users,
    this.emailUsers,
    this.message,
    this.entrySecurities,
    required this.departments,
    this.labels,
  });

  ShiftScheduleDetailsState copyWith({
    FormStatus? status,
    ShiftScheduleModel? model,
    Locations? locations,
    User? loggedInUserDetails,
    List<BaseUser>? users,
    List<BaseUser>? emailUsers,
    List<Organisation>? vendors,
    String? message,
    List<User>? entrySecurities,
    final GmUiLabels? labels,
  }) {
    return ShiftScheduleDetailsState(
      status: status ?? this.status,
      model: model ?? this.model,
      locations: locations ?? this.locations,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      users: users ?? this.users,
      emailUsers: emailUsers ?? this.emailUsers,
      departments: vendors ?? departments,
      message: message ?? this.message,
      entrySecurities: entrySecurities ?? this.entrySecurities,
      labels: labels ?? this.labels,
    );
  }
}
