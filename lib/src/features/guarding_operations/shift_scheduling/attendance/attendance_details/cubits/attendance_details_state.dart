part of 'attendance_details_cubit.dart';

class AttendanceDetailsState extends Equatable {
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
  final List<DutyPostModel>? dutyPosts;
  final GmUiLabels? labels;
  final int? parentId;
  final int? selectedDutyPostNameId;
  final DutyPostModel? selectedDutyPostModel;

  factory AttendanceDetailsState.initial({
    required AttendanceModel model,
    required Locations locations,
    required User loggedInUserDetails,
    required List<BaseUser>? users,
    final List<BaseUser>? emailUsers,
    required final List<Organisation> departments,
    required String errorMessage,
    List<User>? entrySecurities,
    List<String>? dutyPostLocationNames,
  }) {
    return AttendanceDetailsState(
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
    );
  }

  ErrorResponse get isValidDraft {
    log('-model.status---${model.status}--');

    if (model.location == null) {
      log('-model.location-----isValidDraft-');
      return const ErrorResponse(
          status: false, message: 'Please enter Location');
    }
    // if (model.entrySecurity == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Entry Security');
    // }
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
  List<Object?> get props => [model, status];

  const AttendanceDetailsState({
    required this.status,
    required this.model,
    this.locations,
    this.loggedInUserDetails,
    this.users,
    this.emailUsers,
    this.locationNames,
    this.message,
    this.dutyPosts,
    this.entrySecurities,
    this.labels,
    required this.vendors,
    this.parentId,
    this.selectedDutyPostNameId,
    this.selectedDutyPostModel,
  });

  AttendanceDetailsState copyWith({
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
    int? selectedDutyPostNameId,
    DutyPostModel? selectedDutyPostModel,
  }) {
    return AttendanceDetailsState(
      status: status ?? this.status,
      model: model ?? this.model,
      locations: locations ?? this.locations,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      users: users ?? this.users,
      emailUsers: emailUsers ?? this.emailUsers,
      locationNames: locationNames ?? this.locationNames,
      message: message ?? this.message,
      entrySecurities: entrySecurities ?? this.entrySecurities,
      dutyPosts: dutyPosts ?? this.dutyPosts,
      labels: labels ?? this.labels,
      vendors: vendors ?? this.vendors,
      parentId: parentId ?? this.parentId,
      selectedDutyPostNameId:
          selectedDutyPostNameId ?? this.selectedDutyPostNameId,
      selectedDutyPostModel:
          selectedDutyPostModel ?? this.selectedDutyPostModel,
    );
  }
}
