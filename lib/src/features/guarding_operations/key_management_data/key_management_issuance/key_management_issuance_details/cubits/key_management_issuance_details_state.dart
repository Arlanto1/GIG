part of 'key_management_issuance_details_cubits.dart';

class KeyManagementIssuanceDetailsState extends Equatable {
  final FormStatus status;
  final KeyManagementIssuanceModel model;
  final Locations? locations;
  final User? loggedInUserDetails;
  final List<BaseUser>? users;
  final List<Organisation>? listOfEntities;
  final List<Organisation> departments;
  final List<Organisation> typeOfServices;
  final String? message;
  final List<BaseUser>? emailUsers;
  final KMUiLabels? labels;

  factory KeyManagementIssuanceDetailsState.initial({
    required KeyManagementIssuanceModel model,
    required Locations locations,
    required User loggedInUserDetails,
    required List<BaseUser>? users,
    required final List<Organisation>? listOfEntities,
    required List<Organisation> departments,
    required final List<Organisation> typeOfServices,
    final List<BaseUser>? emailUsers,
    required String errorMessage,
    final List<String>? pocs,
  }) {
    return KeyManagementIssuanceDetailsState(
      status: FormStatus.initial,
      model: model,
      locations: locations,
      loggedInUserDetails: loggedInUserDetails,
      users: users,
      listOfEntities: listOfEntities,
      departments: departments,
      typeOfServices: typeOfServices,
      message: errorMessage,
      emailUsers: emailUsers,
    );
  }

  ErrorResponse get isValidDraft {
    if (model.createdBy == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Entry Security');
    }
    if (model.status == null) {
      return const ErrorResponse(status: false, message: 'Please enter Status');
    }
    if (model.createdDate == null) {
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
    if (model.entities == null) {
      return const ErrorResponse(status: false, message: 'Please enter Entity');
    }

    if (model.department == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Department');
    }
    if (model.keyHandingOverDuration == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Key Handing Over Duration');
    }

    if (model.keyHandOverDue == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Key Return Due Date');
    }
    if (model.employeeType == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Employee Type');
    }
    if (model.employeeID == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Employee Id');
    }
    if (model.handedOverTo == null && model.employeeType != 3) {
      return const ErrorResponse(
          status: false, message: 'Please enter Handed Over To');
    }
    if (model.handedOverToCwrT2 == null && model.employeeType == 3) {
      return const ErrorResponse(
          status: false, message: 'Please enter Handed Over To');
    }

    if (model.dbSponsorCwrT2 == null && model.employeeType == 3) {
      return const ErrorResponse(
          status: false, message: 'Please enter DB Sponsor of CWR T2');
    }
    if (model.status != null && model.status != 0 && model.returnedByName.isEmptyOrNull) {
      return const ErrorResponse(
          status: false, message: 'Please enter Returned By Name');
    }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  ErrorResponse get isValid {
    if (model.createdBy == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Entry Security');
    }
    if (model.status == null) {
      return const ErrorResponse(status: false, message: 'Please enter Status');
    }
    if (model.createdDate == null) {
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
    if (model.entities == null) {
      return const ErrorResponse(status: false, message: 'Please enter Entity');
    }

    if (model.department == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Department');
    }
    if (model.keyHandingOverDuration == null  || model.keyHandingOverDuration == 0) {
      return const ErrorResponse(
          status: false, message: 'Please enter Key Handing Over Duration');
    }

    if (model.keyHandOverDue == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Key Return Due Date');
    }
    if (model.employeeType == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Employee Type');
    }
    if (model.employeeID == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Employee Id');
    }
    if (model.handedOverTo == null && model.employeeType != 3) {
      return const ErrorResponse(
          status: false, message: 'Please enter Handed Over To');
    }
    if (model.handedOverToCwrT2 == null && model.employeeType == 3) {
      return const ErrorResponse(
          status: false, message: 'Please enter Handed Over To');
    }

    if (model.dbSponsorCwrT2 == null && model.employeeType == 3) {
      return const ErrorResponse(
          status: false, message: 'Please enter DB Sponsor of CWR T2');
    }
    if (model.status != null && model.status != 0 && model.returnedByName.isEmptyOrNull) {
      return const ErrorResponse(
          status: false, message: 'Please enter Returned By Name');
    }
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  @override
  List<Object?> get props => [model, status];

  const KeyManagementIssuanceDetailsState({
    required this.status,
    required this.model,
    this.locations,
    this.loggedInUserDetails,
    this.listOfEntities,
    required this.departments,
    required this.typeOfServices,
    this.users,
    this.message,
    this.labels,
    this.emailUsers,
  });

  KeyManagementIssuanceDetailsState copyWith({
    FormStatus? status,
    KeyManagementIssuanceModel? model,
    Locations? locations,
    User? loggedInUserDetails,
    List<BaseUser>? users,
    List<Organisation>? listOfEntities,
    List<Organisation>? departments,
    List<Organisation>? typeOfServices,
    String? message,
    List<BaseUser>? emailUsers,
    KMUiLabels? labels,
  }) {
    return KeyManagementIssuanceDetailsState(
      status: status ?? this.status,
      model: model ?? this.model,
      locations: locations ?? this.locations,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      users: users ?? this.users,
      listOfEntities: listOfEntities ?? this.listOfEntities,
      departments: departments ?? this.departments,
      typeOfServices: typeOfServices ?? this.typeOfServices,
      message: message ?? this.message,
      emailUsers: emailUsers ?? this.emailUsers,
      labels: labels ?? this.labels,
    );
  }
}
