part of 'duty_post_details_cubit.dart';

class DutyPostDetailsState extends Equatable {
  final FormStatus status;
  final Shift model;
  final Locations? locations;
  final User? loggedInUserDetails;
  final List<BaseUser>? users;
  final String? message;
  final CdUiLabels? labels;
  final List<Organisation>? ranks;
  final List<Organisation>? shifts;
  final Organisation? selectedRank;
  final Organisation? selectedShift;
  final NextAvailableDateRange? replacementDates;

  factory DutyPostDetailsState.initial({
    required Locations locations,
    required User loggedInUserDetails,
    required List<BaseUser>? users,
    final List<BaseUser>? emailUsers,
    required String errorMessage,
  }) {
    return DutyPostDetailsState(
      status: FormStatus.initial,
      model: Shift(),
      locations: locations,
      loggedInUserDetails: loggedInUserDetails,
      users: users,
      message: errorMessage,
    );
  }

  static const String msg = 'Please create replacement for ';

  ErrorResponse get isValidDraft {
    // List<BaseUser>? needReplacementUsers = model.selectedGuards?.where((u)=> !u.description.isEmptyOrNull).toList();
    // model.replacements

    if (model.selectedGuards != null && model.replacements != null) {
      for (BaseUser guard in model.selectedGuards!) {
        if (guard.description != null) {
          bool isReplaced = model.replacements!
              .any((replacement) => replacement.replacedFor == guard);
          if (!isReplaced) {
            return ErrorResponse(status: false, message: '$msg${guard.name}');
          }
        }
      }
    }
    // if (model.status == null) {
    //   return const ErrorResponse(status: false, message: 'Please enter Status');
    // }
    // if (model.entrySecurity == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Entry Security');
    // }
    // if (model.inputDate == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Created Date is required');
    // }
    // if (model.location == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Location');
    // }
    //
    // if (model.slNo.isEmptyOrNull) {
    //   return const ErrorResponse(status: false, message: 'Please enter SL No');
    // }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  ErrorResponse get isValid {

    if (model.selectedGuards != null && model.replacements != null) {
      for (BaseUser guard in model.selectedGuards!) {
        if (guard.description != null) {
          bool isReplaced = model.replacements!
              .any((replacement) => replacement.replacedFor == guard);
          if (!isReplaced) {
            return ErrorResponse(status: false, message: '$msg${guard.name}');
          }
        }
      }
    }
    // if (model.location == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Location');
    // }
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  @override
  List<Object?> get props => [model, status];

  const DutyPostDetailsState({
    required this.status,
    required this.model,
    this.locations,
    this.loggedInUserDetails,
    this.users,
    this.message,
    this.labels,
    this.ranks,
    this.shifts,
    this.selectedRank,
    this.selectedShift,
    this.replacementDates,
  });

  DutyPostDetailsState copyWith({
    FormStatus? status,
    Shift? model,
    Locations? locations,
    User? loggedInUserDetails,
    List<BaseUser>? users,
    String? message,
    final CdUiLabels? labels,
    List<Organisation>? ranks,
    List<Organisation>? shifts,
    Organisation? selectedRank,
    Organisation? selectedShift,
    NextAvailableDateRange? replacementDates,
  }) {
    return DutyPostDetailsState(
      status: status ?? this.status,
      model: model ?? this.model,
      locations: locations ?? this.locations,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      users: users ?? this.users,
      message: message ?? this.message,
      labels: labels ?? this.labels,
      ranks: ranks ?? this.ranks,
      shifts: shifts ?? this.shifts,
      selectedRank: selectedRank ?? this.selectedRank,
      selectedShift: selectedShift ?? this.selectedShift,
      replacementDates: replacementDates ?? this.replacementDates,
    );
  }
}
