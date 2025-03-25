part of 'law_enforcement_details_cubit_new.dart';

class LawEnforcementDetailsState extends Equatable {
  final FormStatus status;
  final LawEnforcementModelNew model;
  final Locations? locations;
  final User? loggedInUserDetails;
  final List<BaseUser>? users;
  final List<BaseUser>? emailUsers;
  final List<Organisation>? listOfEntities;
  final List<Organisation>? getEntitiesResponse;
  final List<Organisation> department;
  final List<Organisation> visitingDepartment;
  final List<Organisation> visitPurpose;
  final List<Organisation>? distributionGroups;
  final String? message;
  final List<ImageContent> loadAttachments;
  final SlaUiLabels? labels;

  factory LawEnforcementDetailsState.initial({
    required LawEnforcementModelNew model,
    required Locations locations,
    required User loggedInUserDetails,
    required List<BaseUser>? users,
    final List<BaseUser>? emailUsers,
    required final List<Organisation>? listOfEntities,
    required final List<Organisation>? distributionGroups,
    required final List<Organisation>? getEntitiesResponse,
    required final List<Organisation> department,
    required final List<Organisation> visitPurpose,
    required final List<Organisation>  visitingDepartment,
    required String errorMessage,
    required  List<ImageContent> loadAttachments,
  }) {
    return LawEnforcementDetailsState(
      status: FormStatus.initial,
      model: model,
      locations: locations,
      loggedInUserDetails: loggedInUserDetails,
      users: users,
      emailUsers: emailUsers,
      listOfEntities: listOfEntities,
      distributionGroups:distributionGroups,
      getEntitiesResponse: getEntitiesResponse,
      department: department,
      visitPurpose: visitPurpose,
      visitingDepartment:visitingDepartment,
      message: errorMessage,
      loadAttachments: loadAttachments,
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
    // if (model.vendor == null) {
    //   return const ErrorResponse(status: false, message: 'Please enter Vendor');
    // }
    // if (model.entity == null) {
    //   return const ErrorResponse(status: false, message: 'Please enter Entity');
    // }
    // if (model.typeOfService == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Type of Services');
    // }
    // if (model.approver == null) {
    //   return const ErrorResponse(status: false, message: 'Please enter ASL');
    // }
    // if (model.poc == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Guarding Agency POC');
    // }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  @override
  List<Object?> get props => [model, status];

  const LawEnforcementDetailsState({
    required this.status,
    required this.model,
    this.locations,
    this.loggedInUserDetails,
    this.listOfEntities,
    this.distributionGroups,
    this.getEntitiesResponse,
    required this.department,
    required this.visitPurpose,
    required this.visitingDepartment,
    this.users,
    this.emailUsers,
    this.message,
    required this.loadAttachments,
    this.labels,
  });

  LawEnforcementDetailsState copyWith({
    FormStatus? status,
    LawEnforcementModelNew? model,
    Locations? locations,
    User? loggedInUserDetails,
    List<BaseUser>? users,
    List<BaseUser>? emailUsers,
    List<Organisation>? listOfEntities,
    List<Organisation>? distributionGroups,
    List<Organisation>? getEntitiesResponse,
    List<Organisation>? department,
    List<Organisation>? visitPurpose,
    List<Organisation>? visitingDepartment,
    List<ImageContent>? loadAttachments,
    String? message,
    SlaUiLabels? labels,
  }) {
    return LawEnforcementDetailsState(
      status: status ?? this.status,
      model: model ?? this.model,
      locations: locations ?? this.locations,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      users: users ?? this.users,
      listOfEntities: listOfEntities ?? this.listOfEntities,
      distributionGroups:distributionGroups?? this.distributionGroups,
      department: department ?? this.department,
      visitPurpose: visitPurpose ?? this.visitPurpose,
      visitingDepartment:visitingDepartment ?? this.visitingDepartment,
      message: message ?? this.message,
      loadAttachments: loadAttachments ?? this.loadAttachments,
      labels: labels ?? this.labels,
      emailUsers: emailUsers ?? this.emailUsers,
    );
  }
}
