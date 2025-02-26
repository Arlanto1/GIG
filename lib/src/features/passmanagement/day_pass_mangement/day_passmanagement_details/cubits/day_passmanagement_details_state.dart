
part of "day_passmanagement_details_cubit.dart";

class DayPassManagementDetailsState extends Equatable {
  final FormStatus status;
  final DayPassManagementModel model;
  final Locations? locations;
  final User? loggedInUserDetails;
  final List<Organisation> getCompanyTypeResponse;
  // final List<BaseUser>? users;
  final List<BaseUser>? emailUsers;
  final List<BaseUser>? requestorEmailUsers;
  final List<BaseUser>? approver1Users;
  final List<BaseUser>? approver2Users;
  final List<BaseUser>? returnReceiverEmailId;
  final List<BaseUser>? receiverEmailUsers;
  final List<Organisation>? listOfEntities;
  final List<Organisation> dayPassReason;
  final List<Organisation>? passNo;
  final List<Organisation> departments;
  final List<ImageContent>? loadAttachments;
  final List<Organisation> quantityUnits;
  final int? eventId;
  final bool? isReadOnly;
  final String? message;
  final String? rejectionComment;
  final bool isInward;
  final bool returnable;
  final MmUiLabels? labels;

  factory DayPassManagementDetailsState.initial({
    required DayPassManagementModel model,
    required Locations locations,
    required final List<Organisation>? listOfEntities,
    required final List<Organisation> dayPassReason,
    required final List<Organisation> passNo,
    required final List<Organisation> getCompanyTypeResponse,
    required List<BaseUser>? users,
    final List<BaseUser>? emailUsers,
    required String errorMessage,
    required List<Organisation> departments,
    required List<ImageContent> loadAttachments,
    required List<Organisation> quantityUnits,
    required int? eventId,
    String? rejectionComment,
  }) {
    return DayPassManagementDetailsState(
      status: FormStatus.initial,
      model: model,
      locations: locations,
      listOfEntities: listOfEntities,
      dayPassReason:dayPassReason,
      passNo:passNo,
      getCompanyTypeResponse: getCompanyTypeResponse,
      emailUsers: emailUsers,
      message: errorMessage,
      departments: departments,
      loadAttachments: loadAttachments,
      quantityUnits: quantityUnits,
      eventId: eventId,
      rejectionComment: rejectionComment,
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
    required this.getCompanyTypeResponse,
    this.loggedInUserDetails,
    this.emailUsers,
    required this.departments,
    this.loadAttachments,
    required this.quantityUnits,
    this.eventId,
    this.message,
    this.isInward = false,
    this.returnable=false,
    this.labels,
    this.requestorEmailUsers,
    this.returnReceiverEmailId,
    this.approver1Users,
    this.approver2Users,
    this.receiverEmailUsers,
    this.rejectionComment,
    this.isReadOnly,
  });

  DayPassManagementDetailsState copyWith({
    FormStatus? status,
    DayPassManagementModel? model,
    Locations? locations,
    List<Organisation>? listOfEntities,
    List<Organisation>? companyType,
    List<Organisation>? dayPassReason,
    List<Organisation>? passNo,
    User? loggedInUserDetails,
    List<BaseUser>? emailUsers,
    List<BaseUser>? requestorEmailUsers,
    List<BaseUser>? returnReceiverEmailId,
    List<BaseUser>? approver1Users,
    List<BaseUser>? approver2Users,
    List<BaseUser>? receiverEmailUsers,
    List<Organisation>? departments,
    List<ImageContent>? loadAttachments,
    List<Organisation>? quantityUnits,
    int? eventId,
    String? message,
    String? rejectionComment,
    MmUiLabels? labels,
    bool? isReadOnly,
  }) {
    return DayPassManagementDetailsState(
      status: status ?? this.status,
      model: model ?? this.model,
      isReadOnly: isReadOnly ?? this.isReadOnly,
      locations: locations ?? this.locations,
      listOfEntities: listOfEntities ?? this.listOfEntities,
      dayPassReason:dayPassReason?? this.dayPassReason,
      passNo:passNo??this.passNo,
      getCompanyTypeResponse: companyType ?? getCompanyTypeResponse,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      emailUsers: emailUsers ?? this.emailUsers,
      requestorEmailUsers: requestorEmailUsers ?? this.requestorEmailUsers,
      returnReceiverEmailId:
      returnReceiverEmailId ?? this.returnReceiverEmailId,
      approver1Users: approver1Users ?? this.approver1Users,
      approver2Users: approver2Users ?? this.approver2Users,
      receiverEmailUsers: receiverEmailUsers ?? this.receiverEmailUsers,
      departments: departments ?? this.departments,
      loadAttachments: loadAttachments ?? this.loadAttachments,
      quantityUnits: quantityUnits ?? this.quantityUnits,
      eventId: eventId ?? this.eventId,
      message: message ?? this.message,
      labels: labels ?? this.labels,
      rejectionComment: rejectionComment ?? this.rejectionComment,
    );
  }
}
