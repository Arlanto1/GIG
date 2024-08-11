part of 'material_movement_details_cubit.dart';

class MaterialMovementDetailsState extends Equatable {
  final FormStatus status;

  final MaterialMovementModel model;
  final Locations? locations;
  final User? loggedInUserDetails;

  // final List<BaseUser>? users;
  final List<BaseUser>? emailUsers;
  final List<BaseUser>? requestorEmailUsers;
  final List<BaseUser>? approver1Users;
  final List<BaseUser>? approver2Users;
  final List<BaseUser>? returnReceiverEmailId;

  final List<Organisation> departments;
  final List<ImageContent>? loadAttachments;
  final List<Organisation> quantityUnits;
  final int? eventId;
  final bool? isReadOnly;
  final String? message;
  final String? rejectionComment;
  final bool isInward;
  final bool isReceiverSignEditable;
  final bool isEntrySecuritySignatureSignEditable;
  final MmUiLabels? labels;

  factory MaterialMovementDetailsState.initial({
    required MaterialMovementModel model,
    required Locations locations,
    required List<BaseUser>? users,
    final List<BaseUser>? emailUsers,
    required String errorMessage,
    required List<Organisation> departments,
    required List<ImageContent> loadAttachments,
    required List<Organisation> quantityUnits,
    required int? eventId,
    String? rejectionComment,
  }) {
    return MaterialMovementDetailsState(
      status: FormStatus.initial,
      model: model,
      locations: locations,
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
    if (model.challanNo.isEmptyOrNull) {
      return const ErrorResponse(
          status: false, message: 'Please enter Challan No');
    }

    /// For Inward Movement Only
    if (model.inwardMovement ?? false) {
      if (model.materialComingFrom.isEmptyOrNull) {
        return const ErrorResponse(
            status: false, message: 'Please enter Sender\'s Name');
      }
      if (model.materialFromAddress.isEmptyOrNull &&
          model.status != 0 &&
          model.status != null) {
        return const ErrorResponse(
            status: false,
            message: 'Please enter Material coming from (Brief address)');
      }

      if (!model.originalReceiver && model.receiverEmail.isEmptyOrNull) {
        return const ErrorResponse(
            status: false, message: 'Please enter Received For');
      }
      if (!model.originalReceiver && model.receiverEmployeeId.isEmptyOrNull) {
        return const ErrorResponse(
            status: false, message: 'Please enter Received for Employee Id');
      }

      if (model.originalReceiver && model.receiverEmployeeId.isEmptyOrNull) {
        return const ErrorResponse(
            status: false, message: 'Please enter Received by Employee Id');
      }
      if (!model.originalReceiver &&
          model.otherReceiverEmployeeId.isEmptyOrNull) {
        return const ErrorResponse(
            status: false, message: 'Please enter Received by Employee Id');
      }

      if (model.receiverEmail.isEmptyOrNull) {
        return const ErrorResponse(
            status: false, message: 'Please enter Received by');
      }

      if (model.receiverDepartmenttName.isEmptyOrNull) {
        return const ErrorResponse(
            status: false, message: 'Please enter Receiver Department');
      }

      if (model.receiverDepartment == null) {
        return const ErrorResponse(
            status: false, message: 'Please enter Receiver Department');
      }
    }
    if (model.status == 2 && model.materialPhysicallyChecked == false) {
      return const ErrorResponse(
          status: false,
          message: 'Please Select Material Physically Checked as true');
    }

    if (model.materialDescription.isEmptyOrNull &&
        model.status != 0 &&
        model.status != null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Material Brief Description');
    }
    if (model.quantity == null && model.status != 0 && model.status != null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Quantity');
    }
    if (model.unit == null && model.status != 0) {
      return const ErrorResponse(status: false, message: 'Please enter Unit');
    }

    if (model.modelInfo.isEmptyOrNull &&
        model.status != 0 &&
        model.status != null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Equipment No/Identification');
    }
    if (model.modelInfo.isEmptyOrNull &&
        model.status != 0 &&
        model.status != null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Equipment No/Identification');
    }
    if (model.address.isEmptyOrNull &&
        model.status != 0 &&
        model.status != null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Sent to Address');
    }
    if (model.requestorDepartment == null && (model.status == 1)) {
      return const ErrorResponse(
          status: false, message: 'Please enter Requester Department');
    }
    if (model.sentTo.isEmptyOrNull &&
        model.status != 0 &&
        model.status != null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Sent To(Name)');
    }
    if (model.purpose.isEmptyOrNull &&
        model.status != 0 &&
        model.status != null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Purpose');
    }
    if (model.preparedByDepartment == null &&
        model.status != 0 &&
        model.status != null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Prepared By Department');
    }
    if (model.expectedDateOfReturn == null &&
        model.returnable! &&
        model.status != 0 &&
        model.status != null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Expected date of Return');
    }
    if (model.returnable == true &&
        model.rejectionComment == null &&
        model.status == 3) {
      return const ErrorResponse(
          status: false, message: 'Please enter Rejection Comment');
    }
    if (!model.materialPhysicallyChecked &&
        isInward &&
        model.materialNotCheckedComment.isEmptyOrNull) {
      return const ErrorResponse(
          status: false, message: 'Comment is Mandatory');
    }
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  @override
  List<Object?> get props => [model, status];

  const MaterialMovementDetailsState({
    required this.status,
    required this.model,
    this.locations,
    this.isReceiverSignEditable = false,
    this.isEntrySecuritySignatureSignEditable = false,
    this.loggedInUserDetails,
    this.emailUsers,
    required this.departments,
    this.loadAttachments,
    required this.quantityUnits,
    this.eventId,
    this.message,
    this.isInward = false,
    this.labels,
    this.requestorEmailUsers,
    this.returnReceiverEmailId,
    this.approver1Users,
    this.approver2Users,
    this.rejectionComment,
    this.isReadOnly,
  });

  MaterialMovementDetailsState copyWith({
    FormStatus? status,
    MaterialMovementModel? model,
    Locations? locations,
    User? loggedInUserDetails,
    // List<BaseUser>? users,
    List<BaseUser>? emailUsers,
    List<BaseUser>? requestorEmailUsers,
    List<BaseUser>? returnReceiverEmailId,
    List<BaseUser>? approver1Users,
    List<BaseUser>? approver2Users,
    List<Organisation>? departments,
    List<ImageContent>? loadAttachments,
    List<Organisation>? quantityUnits,
    int? eventId,
    String? message,
    String? rejectionComment,
    MmUiLabels? labels,
    bool? isReceiverSignEditable,
    bool? isEntrySecuritySignatureSignEditable,
    bool? isReadOnly,
  }) {
    return MaterialMovementDetailsState(
      status: status ?? this.status,
      model: model ?? this.model,
      isReadOnly: isReadOnly ?? this.isReadOnly,
      locations: locations ?? this.locations,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      emailUsers: emailUsers ?? this.emailUsers,
      requestorEmailUsers: requestorEmailUsers ?? this.requestorEmailUsers,
      returnReceiverEmailId: returnReceiverEmailId ?? this.returnReceiverEmailId,
      approver1Users: approver1Users ?? this.approver1Users,
      approver2Users: approver2Users ?? this.approver2Users,
      departments: departments ?? this.departments,
      loadAttachments: loadAttachments ?? this.loadAttachments,
      quantityUnits: quantityUnits ?? this.quantityUnits,
      eventId: eventId ?? this.eventId,
      message: message ?? this.message,
      labels: labels ?? this.labels,
      isReceiverSignEditable:
          isReceiverSignEditable ?? this.isReceiverSignEditable,
      rejectionComment: rejectionComment ?? this.rejectionComment,
      isEntrySecuritySignatureSignEditable:
          isEntrySecuritySignatureSignEditable ??
              this.isEntrySecuritySignatureSignEditable,
    );
  }
}
