part of 'sla_violation_penalty_details_cubit.dart';

class SLAViolationPenaltyDetailsState extends Equatable {
  final FormStatus status;
  final SLAViolationPenaltyModel model;
  final Locations? locations;
  final User? loggedInUserDetails;
  final List<BaseUser>? users;
  final List<Organisation>? listOfEntities;
  final List<Organisation> vendors;
  final List<Organisation> typeOfServices;
  final String? message;
   final List<String>? pocs;

  factory SLAViolationPenaltyDetailsState.initial({
    required SLAViolationPenaltyModel model,
    required Locations locations,
    required User loggedInUserDetails,
    required List<BaseUser>? users,
    required final List<Organisation>? listOfEntities,
    required final List<Organisation> vendors,
    required final List<Organisation> typeOfServices,
    final List<BaseUser>? emailUsers,
    required String errorMessage,
    final List<String>? poc,

  }) {
    return SLAViolationPenaltyDetailsState(
      status: FormStatus.initial,
      model: model,
      locations: locations,
      loggedInUserDetails: loggedInUserDetails,
      users: users,
      listOfEntities: listOfEntities,
      vendors: vendors,
      typeOfServices: typeOfServices,
      message: errorMessage,
      pocs: poc,
    );
  }

  ErrorResponse get isValidDraft {
    if (model.status == null) {
      return const ErrorResponse(status: false, message: 'Please enter Status');
    }
    if (model.entrySecurity == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Entry Security');
    }
    if (model.inputDate == null) {
      return const ErrorResponse(
          status: false, message: 'Created Date is required');
    }
    if (model.location == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Location');
    }

    if (model.slNo.isEmptyOrNull) {
      return const ErrorResponse(status: false, message: 'Please enter SL No');
    }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  ErrorResponse get isValid {
    if (model.location == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Location');
    }
    if (model.vendor == null) {
      return const ErrorResponse(status: false, message: 'Please enter Vendor');
    }
    if (model.entity == null) {
      return const ErrorResponse(status: false, message: 'Please enter Entity');
    }
    if (model.typeOfService == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Type of Services');
    }
    if (model.approver == null) {
      return const ErrorResponse(status: false, message: 'Please enter ASL');
    }
    if (model.poc == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Guarding Agency POC');
    }
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  @override
  List<Object?> get props => [model, status];

  const SLAViolationPenaltyDetailsState({
    required this.status,
    required this.model,
    this.locations,
    this.loggedInUserDetails,
    this.listOfEntities,
    required this.vendors,
    required this.typeOfServices,
    this.users,
    this.message,
    this.pocs,
  });

  SLAViolationPenaltyDetailsState copyWith({
    FormStatus? status,
    SLAViolationPenaltyModel? model,
    Locations? locations,
    User? loggedInUserDetails,
    List<BaseUser>? users,
    List<Organisation>? listOfEntities,
    List<Organisation>? vendors,
    List<Organisation>? typeOfServices,
    List<String>? pocs,
    String? message,
  }) {
    return SLAViolationPenaltyDetailsState(
      status: status ?? this.status,
      model: model ?? this.model,
      locations: locations ?? this.locations,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      users: users ?? this.users,
      listOfEntities: listOfEntities ?? this.listOfEntities,
      vendors: vendors ?? this.vendors,
      typeOfServices: typeOfServices ?? this.typeOfServices,
      message: message ?? this.message,
      pocs: pocs ?? this.pocs,
    );
  }
}
