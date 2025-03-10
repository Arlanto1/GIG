
part of "day_passmanagement_details_cubit.dart";

class DayPassManagementDetailsState extends Equatable {
  final FormStatus status;
  final DayPassManagementModel model;
  final Locations? locations;
  final User? loggedInUserDetails;
  final List<Organisation> getCompanyTypeResponse;
  final List<BaseUser>? emailUsers;
  final List<BaseUser>? employee;
  final List<BaseUser>? dbSponsor;
  final List<BaseUser>? host;
  final List<Organisation>? listOfEntities;
  final List<Organisation> dayPassReason;
  final List<Organisation>? passNo;
  final List<Organisation>? passType;
  final List<Organisation> departments;
  final List<Organisation>? getStatus;
  final List<ImageContent> uploadAttachments;
  final String? message;
  final MmUiLabels? labels;

  factory DayPassManagementDetailsState.initial({
    required DayPassManagementModel model,
    required Locations locations,
    required final List<Organisation>? listOfEntities,
    required final List<Organisation> dayPassReason,
    required final List<Organisation> passNo,
    required final List<Organisation> passType,
    required final List<Organisation> getCompanyTypeResponse,
    required List<BaseUser>? users,
    final List<BaseUser>? emailUsers,
    required String errorMessage,
    required List<Organisation> departments,
    required final List<Organisation> getStatus,
    required List<ImageContent> uploadAttachments,
  }) {
    return DayPassManagementDetailsState(
      status: FormStatus.initial,
      model: model,
      locations: locations,
      listOfEntities: listOfEntities,
      dayPassReason:dayPassReason,
      passNo:passNo,
      passType:passType,
      getStatus:getStatus,
      getCompanyTypeResponse: getCompanyTypeResponse,
      emailUsers: emailUsers,
      message: errorMessage,
      departments: departments,
      uploadAttachments: uploadAttachments,
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
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  @override
  List<Object?> get props => [model, status];

  const DayPassManagementDetailsState({
    required this.status,
    required this.model,
    this.locations,
    this.listOfEntities,
    required this.dayPassReason,
    required this.passNo,
    required this.passType,
    required this.getStatus,
    required this.getCompanyTypeResponse,
    this.loggedInUserDetails,
    this.emailUsers,
    required this.departments,
    required this.uploadAttachments,
    this.message,
    this.labels,
    this.employee,
    this.dbSponsor,
    this.host,
  });

  DayPassManagementDetailsState copyWith({
    FormStatus? status,
    DayPassManagementModel? model,
    Locations? locations,
    List<Organisation>? listOfEntities,
    List<Organisation>? companyType,
    List<Organisation>? dayPassReason,
    List<Organisation>? passNo,
    List<Organisation>? passType,
    List<Organisation>? getStatus,
    User? loggedInUserDetails,
    List<BaseUser>? emailUsers,
    List<BaseUser>? employee,
    List<BaseUser>? dbSponsor,
    List<BaseUser>? host,
    List<BaseUser>? receiverEmailUsers,
    List<Organisation>? departments,
    List<ImageContent>? uploadAttachments,
    String? message,
    MmUiLabels? labels,
  }) {
    return DayPassManagementDetailsState(
      status: status ?? this.status,
      model: model ?? this.model,
      locations: locations ?? this.locations,
      listOfEntities: listOfEntities ?? this.listOfEntities,
      dayPassReason:dayPassReason?? this.dayPassReason,
      passNo:passNo??this.passNo,
      passType:passType??this.passType,
      getStatus:getStatus??this.getStatus,
      getCompanyTypeResponse: companyType ?? getCompanyTypeResponse,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      emailUsers: emailUsers ?? this.emailUsers,
      employee: employee ?? this.employee,
      dbSponsor: dbSponsor ?? this.dbSponsor,
      host: host ?? this.host,
      departments: departments ?? this.departments,
      uploadAttachments: uploadAttachments ?? this.uploadAttachments,
      message: message ?? this.message,
      labels: labels ?? this.labels,
    );
  }
}
