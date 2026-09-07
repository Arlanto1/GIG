part of 'material_movement_details_cubit.dart';

class MaterialMovementDetailsState extends Equatable {
  final FormStatus status;

  final MaterialMovementModel model;
  final Locations? locations;
  final User? loggedInUserDetails;
  final ApprovalModel approvalModel;

  // final List<BaseUser>? users;
  final List<BaseUser>? emailUsers;
  final List<BaseUser>? requestorEmailUsers;
  final List<BaseUser>? approver1Users;
  final List<BaseUser>? approver2Users;
  final List<BaseUser>? returnReceiverEmailId;
  final List<BaseUser>? receiverEmailUsers;
  final List<MaterialItem> materialItems;
  final List<Organisation> departments;
  final List<ImageContent>? loadAttachments;
  final List<Organisation> quantityUnits;
  final int? eventId;
  final bool? isReadOnly;
  final String? message;
  final String? rejectionComment;
  final bool isInward;
  final bool returnable;
  final bool isReceiverSignEditable;
  final bool isEntrySecuritySignatureSignEditable;
  final bool isGatePassSecuritySignatureSignEditable;
  final MmUiLabels? labels;
  final List<BaseUser>? requestor2EmailUsers;

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
    required List<MaterialItem> materialItems,
    String? rejectionComment,
    required ApprovalModel approvalModel,
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
      materialItems: materialItems,
      approvalModel: approvalModel,
    );
  }

  ErrorResponse get isValidDraft {
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
    // log('12345 ${model.requestorEmail}');
    // log('222 ${model.requestorEmail == model.approver1Email}');
    //
    // if (model.inwardMovement == false &&
    //     model.requestorEmail != null &&
    //     model.approver1Email!.isNotEmpty &&
    //     model.requestorEmail == model.approver1Email) {
    //   return const ErrorResponse(
    //       status: false,
    //       message:
    //           'Selected Approver1 Email is already selected in other list');
    // }
    //
    // if (model.inwardMovement == false &&
    //     model.requestorEmail != null &&
    //     model.approver2Email!.isNotEmpty &&
    //     model.requestorEmail == model.approver2Email) {
    //   return const ErrorResponse(
    //       status: false,
    //       message:
    //           'Selected Approver2 Email is already selected in other list');
    // }
    //
    // if (model.inwardMovement == false &&
    //     model.approver1Email != null &&
    //     model.approver1Email!.isNotEmpty &&
    //     model.approver1Email == model.approver2Email) {
    //   return const ErrorResponse(
    //       status: false,
    //       message:
    //           'Selected Approver2 Email is already selected in other list ');
    // }
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  ErrorResponse get isValid {
    if (model.location == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Location');
    }
    // if ( model.isI && model.challanNo.isEmptyOrNull) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Challan/Invoice Nos/Gate Pass');
    // }
    //
    // if (model.materialItems == null &&
    //     model.materialItems.isEmptyOrNull) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please add at least one material Description');
    // }
    if (model.inwardMovement == false &&
        model.requestorEmployeeId.isEmptyOrNull) {
      return const ErrorResponse(
          status: false, message: 'Please enter Requestor Employee Id');
    }

    if (model.inwardMovement == false && model.approver1Email.isEmptyOrNull) {
      return const ErrorResponse(
          status: false, message: 'Please enter Approver1 Email');
    }
    if (model.inwardMovement == false && model.approver1Department == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Approver1 Department');
    }

    if (model.inwardMovement == false && model.approver2Email.isEmptyOrNull) {
      return const ErrorResponse(
          status: false, message: 'Please enter Approver2 Email');
    }
    // if (model.inwardMovement == false && model.approver2Department == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Approver2 Department');
    // }

    /// For Inward Movement Only
    if (model.inwardMovement ?? false) {
      if (model.expectedDateOfReturn == null &&
          model.returnable == true &&
          (model.status == 0 || model.status == null)) {
        return const ErrorResponse(
            status: false, message: 'Please enter Expected date of Return');
      }
      if (model.materialComingFrom.isEmptyOrNull) {
        return const ErrorResponse(
            status: false, message: 'Please enter Sender\'s Name');
      }
      if (model.materialFromAddress.isEmptyOrNull) {
        return const ErrorResponse(
            status: false,
            message: 'Please enter Material coming from (Brief address)');
      }
      if (!model.originalReceiver && model.receiverEmployeeId.isEmptyOrNull) {
        return const ErrorResponse(
            status: false, message: 'Please enter Received for Employee Id');
      }

      if (!model.originalReceiver && model.receiverEmail.isEmptyOrNull) {
        return const ErrorResponse(
            status: false, message: 'Please enter Received For');
      }

      if (model.receiverDepartmenttName.isEmptyOrNull) {
        return const ErrorResponse(
            status: false, message: 'Please enter Receiver Department');
      }
      if (!model.originalReceiver &&
          model.otherReceiverEmployeeId.isEmptyOrNull) {
        return const ErrorResponse(
            status: false, message: 'Please enter Received by Employee Id');
      }

      if (!model.originalReceiver && model.otherReceiverName.isEmptyOrNull) {
        return const ErrorResponse(
            status: false, message: 'Please enter Received by');
      }

      if (model.receiverDepartment == null) {
        return const ErrorResponse(
            status: false, message: 'Please enter Receiver Department');
      }

      if (model.materialPhysicallyChecked == false &&
          model.materialNotCheckedComment.isEmptyOrNull) {
        return const ErrorResponse(
            status: false,
            message: 'Please enter Physically not checked comment');
      }
    }

    ///Outward
    if (model.status == 2 && model.materialPhysicallyChecked == false) {
      return const ErrorResponse(
          status: false,
          message: 'Please Select Material Physically Checked as true');
    }

    // if (model.materialDescription.isEmptyOrNull &&
    //     model.status != 0 &&
    //     model.status != null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Material Brief Description');
    // }
    // if (model.quantity == null && model.status! > 0 && model.status != null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Quantity');
    // }
    // if (model.status! > 0 && model.quantity == 0) {
    //   return const ErrorResponse(
    //       status: false, message: 'Quantity cannot be zero!');
    // }
    //
    // if (model.quantity != null && model.quantity! < 0) {
    //   return const ErrorResponse(
    //       status: false, message: 'Only positive number are allowed');
    // }
    // if (model.unit == null && model.status! > 0) {
    //   return const ErrorResponse(status: false, message: 'Please enter Unit');
    // }
    // if (model.modelInfo.isEmptyOrNull &&
    //     model.status != 0 &&
    //     model.status != null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Equipment No/Identification');
    // }
    // if (model.modelInfo.isEmptyOrNull &&
    //     model.status != 0 &&
    //     model.status != null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Equipment No/Identification');
    // }
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
        model.status != null &&
        model.inwardMovement == false) {
      return const ErrorResponse(
          status: false, message: 'Please enter Purpose');
    }

    // if (model.preparedBy.isEmptyOrNull &&
    //     model.status != 0 &&
    //     model.status != null  &&  model.inwardMovement == false) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Prepared By');
    // }
    //
    // if (model.preparedByDepartment == null &&
    //     model.status != 0 &&
    //     model.status != null  &&  model.inwardMovement == false) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Prepared By Department');
    // }

    if (model.expectedDateOfReturn == null &&
        model.returnable == true &&
        model.status == 1 &&
        model.inwardMovement == false) {
      return const ErrorResponse(
          status: false, message: 'Please enter Expected date of Return');
    }

    // if (model.returnable == true &&
    //     model.rejectionComment == null &&
    //     model.status == 3) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Rejection Comment');
    // }
    if (!model.materialPhysicallyChecked &&
        isInward &&
        model.materialNotCheckedComment.isEmptyOrNull) {
      return const ErrorResponse(
          status: false, message: 'Comment is Mandatory');
    }

    if (!model.materialPhysicallyChecked &&
        !isInward &&
        model.materialNotCheckedComment.isEmptyOrNull &&
        model.status == 6) {
      return const ErrorResponse(
          status: false, message: 'Comment is Mandatory');
    }

    if (model.returnable == true &&
        !isInward &&
        model.comment.isEmptyOrNull &&
        model.status == 9) {
      return const ErrorResponse(
          status: false, message: 'Comment is Mandatory');
    }

    // if (!isInward && model.entrySecuritySign == null && model.status == 6) {
    //   return const ErrorResponse(
    //       status: false, message: 'Security Signature is Mandatory');
    // }
    if ((!model.takenOutContactNo.isEmptyOrNull &&
        model.takenOutContactNo!.length < 10)) {
      return const ErrorResponse(
        status: false,
        message: 'Please enter valid Taken Out By Contact Number',
      );
    }

    if ((model.inwardMovement == false) &&
        model.requestorEmail != null &&
        model.requestorEmail == model.approver1Email) {
      return const ErrorResponse(
          status: false,
          message:
              'Selected Approver1 Email is already selected in other list');
    }

    if ((model.inwardMovement == false) &&
        model.requestor2Email != null &&
        model.requestorEmail != null &&
        model.requestorEmail == model.requestor2Email) {
      return const ErrorResponse(
          status: false,
          message:
              'Selected Requestor 1 Email is already selected in other list');
    }

    if ((model.inwardMovement == false) &&
        model.requestorEmail != null &&
        model.requestorEmail == model.approver2Email) {
      return const ErrorResponse(
          status: false,
          message:
              'Selected Approver2 Email is already selected in other list');
    }

    if ((model.inwardMovement == false) &&
        model.requestor2Email != null &&
        model.requestorEmail == model.approver2Email) {
      return const ErrorResponse(
          status: false,
          message:
              'Selected Approver2 Email is already selected in other list');
    }
    if ((model.inwardMovement == false) &&
        model.requestor2Email != null &&
        model.requestor2Email == model.approver2Email) {
      return const ErrorResponse(
          status: false,
          message:
              'Selected Approver2 Email is already selected in other list');
    }
    if ((model.inwardMovement == false) &&
        model.approver1Email != null &&
        model.approver1Email == model.approver2Email) {
      return const ErrorResponse(
          status: false,
          message:
              'Selected Approver2 Email is already selected in other list ');
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
    this.isGatePassSecuritySignatureSignEditable = false,
    this.loggedInUserDetails,
    this.emailUsers,
    required this.departments,
    this.loadAttachments,
    required this.quantityUnits,
    this.eventId,
    this.message,
    this.isInward = false,
    this.returnable = false,
    this.labels,
    this.requestorEmailUsers,
    this.returnReceiverEmailId,
    this.approver1Users,
    this.approver2Users,
    this.receiverEmailUsers,
    this.rejectionComment,
    this.isReadOnly,
    required this.materialItems,
    this.requestor2EmailUsers,
    required this.approvalModel,
  });

  MaterialMovementDetailsState copyWith({
    FormStatus? status,
    MaterialMovementModel? model,
    Locations? locations,
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
    bool? isReceiverSignEditable,
    bool? isEntrySecuritySignatureSignEditable,
    bool? isGatePassSecuritySignatureSignEditable,
    bool? isReadOnly,
    List<MaterialItem>? materialItems,
    List<BaseUser>? requestor2EmailUsers,
    ApprovalModel? approvalModel,
  }) {
    return MaterialMovementDetailsState(
      status: status ?? this.status,
      model: model ?? this.model,
      isReadOnly: isReadOnly ?? this.isReadOnly,
      locations: locations ?? this.locations,
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
      isReceiverSignEditable:
          isReceiverSignEditable ?? this.isReceiverSignEditable,
      rejectionComment: rejectionComment ?? this.rejectionComment,
      isEntrySecuritySignatureSignEditable:
          isEntrySecuritySignatureSignEditable ??
              this.isEntrySecuritySignatureSignEditable,
      isGatePassSecuritySignatureSignEditable: isGatePassSecuritySignatureSignEditable ?? this.isGatePassSecuritySignatureSignEditable,
      materialItems: materialItems ?? this.materialItems,
      requestor2EmailUsers: requestor2EmailUsers ?? this.requestor2EmailUsers,
      approvalModel: approvalModel ?? this.approvalModel,
    );
  }
}
