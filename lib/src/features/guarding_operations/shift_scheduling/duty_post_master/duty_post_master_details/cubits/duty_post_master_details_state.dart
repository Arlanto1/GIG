part of 'duty_post_master_details_cubit.dart';

class DutyPostMasterDetailsState extends Equatable {
  final FormStatus status;
  final DutyPostMasterModel model;
  final Locations? locations;
  final User? loggedInUserDetails;
  final List<BaseUser>? users;
  final List<BaseUser>? emailUsers;
  final String? message;
  final List<User>? entrySecurities;
  final GmUiLabels? labels;

  factory DutyPostMasterDetailsState.initial({
    required DutyPostMasterModel model,
    required Locations locations,
    required User loggedInUserDetails,
    required List<BaseUser>? users,
    final List<BaseUser>? emailUsers,
    required String errorMessage,
    List<User>? entrySecurities,
  }) {
    return DutyPostMasterDetailsState(
      status: FormStatus.initial,
      model: model,
      locations: locations,
      loggedInUserDetails: loggedInUserDetails,
      users: users,
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

    if (model.height == null) {
      return const ErrorResponse(status: false, message: 'Please enter Height');
    }
    if (model.localLanguage == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Local language');
    }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  @override
  List<Object?> get props => [model, status];

  const DutyPostMasterDetailsState({
    required this.status,
    required this.model,
    this.locations,
    this.loggedInUserDetails,
    this.users,
    this.emailUsers,
    this.message,
    this.entrySecurities,
    this.labels,
  });

  DutyPostMasterDetailsState copyWith({
    FormStatus? status,
    DutyPostMasterModel? model,
    Locations? locations,
    User? loggedInUserDetails,
    List<BaseUser>? users,
    List<BaseUser>? emailUsers,
    String? message,
    List<User>? entrySecurities,
    final GmUiLabels? labels,
  }) {
    return DutyPostMasterDetailsState(
      status: status ?? this.status,
      model: model ?? this.model,
      locations: locations ?? this.locations,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      users: users ?? this.users,
      emailUsers: emailUsers ?? this.emailUsers,
      message: message ?? this.message,
      entrySecurities: entrySecurities ?? this.entrySecurities,
      labels: labels ?? this.labels,
    );
  }
}
