part of 'shift_schedule_details_cubit.dart';

class ShiftScheduleDetailsState extends Equatable {
  final FormStatus status;
  final ShiftScheduleModel model;
  final DutyPostModel? selectedDutyPostModel;
  final Locations? locations;
  final User? loggedInUserDetails;
  final List<BaseUser>? users;
  final List<BaseUser>? emailUsers;
  final List<Organisation> vendors;
  final String? message;
  final List<User>? entrySecurities;
  final List<DutyPostModel>? dutyPosts;
  final SSUiLabels? labels;
  final List<String>? pocs;
  final NextAvailableDateRange? availableDate;

  factory ShiftScheduleDetailsState.initial({
    required ShiftScheduleModel model,
    required Locations locations,
    required User loggedInUserDetails,
    required List<BaseUser>? users,
    final List<BaseUser>? emailUsers,
    required final List<Organisation> vendors,
    required String errorMessage,
    List<User>? entrySecurities,
    final DutyPostModel? selectedDutyPostModel,
    final List<String>? pocs,
  }) {
    return ShiftScheduleDetailsState(
      status: FormStatus.initial,
      model: model,
      locations: locations,
      loggedInUserDetails: loggedInUserDetails,
      users: users,
      vendors: vendors,
      emailUsers: emailUsers,
      message: errorMessage,
      entrySecurities: entrySecurities,
      selectedDutyPostModel: selectedDutyPostModel,
      pocs: pocs,
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
    if (model.vendor?.name == null || model.vendor!.name.isEmptyOrNull) {
      return const ErrorResponse(status: false, message: 'Please enter Vendor');
    }
    if (model.dutyType == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Duty Type');
    }
    if (model.poc.isEmptyOrNull) {
      return const ErrorResponse(
          status: false, message: 'Please add Poc');
    }
    if (model.fromDate.isEmptyOrNull) {
      return const ErrorResponse(
          status: false, message: 'Please enter From Date');
    }
    if (model.toDate.isEmptyOrNull) {
      return const ErrorResponse(
          status: false, message: 'Please enter To Date');
    }
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  ErrorResponse get isValid {
    if (model.status == null) {
      return const ErrorResponse(status: false, message: 'Please enter Status');
    }
    if (model.vendor?.name == null || model.vendor!.name.isEmptyOrNull) {
      return const ErrorResponse(status: false, message: 'Please enter Vendor');
    }
    if (model.dutyType == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Duty Type');
    }
    if (model.poc.isEmptyOrNull) {
      return const ErrorResponse(
          status: false, message: 'Please add Poc');
    }
    if (model.fromDate.isEmptyOrNull) {
      return const ErrorResponse(
          status: false, message: 'Please enter From Date');
    }
    if (model.toDate.isEmptyOrNull) {
      return const ErrorResponse(
          status: false, message: 'Please enter To Date');
    }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  @override
  List<Object?> get props => [model, status];

  const ShiftScheduleDetailsState({
    required this.status,
    required this.model,
    this.selectedDutyPostModel,
    this.locations,
    this.loggedInUserDetails,
    this.users,
    this.emailUsers,
    this.message,
    this.entrySecurities,
    this.dutyPosts,
    required this.vendors,
    this.labels,
    this.pocs,
    this.availableDate,
  });

  ShiftScheduleDetailsState copyWith({
    FormStatus? status,
    ShiftScheduleModel? model,
    DutyPostModel? seletedDutyPostModel,
    Locations? locations,
    User? loggedInUserDetails,
    List<BaseUser>? users,
    List<BaseUser>? emailUsers,
    List<Organisation>? vendors,
    String? message,
    List<User>? entrySecurities,
    List<DutyPostModel>? dutyPosts,
    final SSUiLabels? labels,
    List<String>? pocs,
    NextAvailableDateRange? availableDate,
  }) {
    return ShiftScheduleDetailsState(
      status: status ?? this.status,
      model: model ?? this.model,
      selectedDutyPostModel: seletedDutyPostModel ?? selectedDutyPostModel,
      locations: locations ?? this.locations,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      users: users ?? this.users,
      emailUsers: emailUsers ?? this.emailUsers,
      vendors: vendors ?? this.vendors,
      message: message ?? this.message,
      entrySecurities: entrySecurities ?? this.entrySecurities,
      dutyPosts: dutyPosts ?? this.dutyPosts,
      labels: labels ?? this.labels,
      pocs: pocs ?? this.pocs,
      availableDate: availableDate ?? this.availableDate,
    );
  }
}
