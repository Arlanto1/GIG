import 'package:json_annotation/json_annotation.dart';

part 'mm_ui_labels.g.dart';

@JsonSerializable()
class MmUiLabels {
  final MmUiLabelsDefault defaultLabels;
  final MmUiLabelsDefault localeLabels;

  MmUiLabels({
    required this.defaultLabels,
    required this.localeLabels,
  });

  factory MmUiLabels.fromJson(Map<String, dynamic> json) =>
      _$MmUiLabelsFromJson(json);
  Map<String, dynamic> toJson() => _$MmUiLabelsToJson(this);
}

@JsonSerializable()
class MmUiLabelsDefault {
  @JsonKey(name: 'com.arlanto.atom.materialMovement.unit')
  final String unit;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.receiverName')
  final String receivedBy;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.requestorEmployeeId')
  final String requestorEmployeeId;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.materialReturnedChallanNo')
  final String materialReturnedChallanNo;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.approver2Department')
  final String approver2Department;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.entity')
  final String entity;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.originalReceiver')
  final String originalReceiver;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.takenOutEmail')
  final String takenOutEmail;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.expectedDateOfReturn')
  final String expectedDateOfReturn;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.receiverDepartment')
  final String receiverDepartment;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.status.submitted')
  final String submitted;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.rejectionComment')
  final String rejectionComment;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.materialComingFromAddress')
  final String materialComingFromAddress;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.remarks')
  final String remarks;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.otherReceiverName')
  final String otherReceiverName;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.rejectedDate')
  final String rejectedDate;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.returnable')
  final String returnable;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.takenOutDate')
  final String takenOutDate;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.returnReceiverMailId')
  final String returnReceiverMailId;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.rejectedBy')
  final String rejectedBy;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.materialComingFrom')
  final String materialComingFrom;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.takenOutAddress')
  final String takenOutAddress;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.address')
  final String address;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.status.outWardWaiting')
  final String outwardPending;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.slNo')
  final String slNo;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.entrySecurity')
  final String createdBy;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.receiverEmployeeId')
  final String receivedForEmployeeId;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.approver1Department')
  final String approver1Department;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.status.approved')
  final String approved;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.preparedByDepartment')
  final String preparedByDepartment;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.out')
  final String outward;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.purpose')
  final String purpose;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.receiverSign')
  final String receiverSignature;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.status.inWardWaiting')
  final String inwardPending;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.location')
  final String location;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.approver2Email')
  final String approver2Email;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.approvedDate')
  final String approvedDate;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.materialNotCheckedComment')
  final String comment;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.inputDate')
  final String dateOfCreation;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.nonReturnable')
  final String nonReturnable;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.requestorDepartment')
  final String requestorDepartment;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.preparedBy')
  final String preparedBy;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.materialDescription')
  final String materialBriefDescription;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.requestorEmail')
  final String requestorEmail;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.status.draft')
  final String draft;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.takenOutName')
  final String takenOutBy;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.status.rejected')
  final String rejected;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.takenOutDepartment')
  final String takenOutByDepartment;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.gatePassSecuritySign')
  final String securitySignature;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.poNumber')
  final String poNumber;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.modelInfo')
  final String equipmentNoIdentification;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.quantity')
  final String quantity;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.takenOutContactNo')
  final String takenOutByContactNo;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.receiverEmail')
  final String receiverEmail;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.status.cancelled')
  final String cancelled;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.in')
  final String inward;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.returnQuantity')
  final String returnQuantity;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.type')
  final String materialMovementType;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.approver1Email')
  final String approver1Email;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.sentTo')
  final String sentTo;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.materialPhysicallyChecked')
  final String isMaterialPhysicallyChecked;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.otherReceiverEmployeeId')
  final String receivedByEmployeeId;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.status')
  final String status;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.approver1Name')
  final String approver1Name;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.returnReceiverName')
  final String returnReceiverName;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.approver2Name')
  final String approver2Name;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.entrySecuritySign')
  final String entrySecuritySign;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.challanNo')
  final String challanInvoiceGatePass;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.requestorName')
  final String requestorName;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.actualDateOfReturn')
  final String actualDateOfReturn;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.approvedBy')
  final String approvedBy;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.status.closed')
  final String closedFinalized;

  MmUiLabelsDefault({
    required this.unit,
    required this.receivedBy,
    required this.requestorEmployeeId,
    required this.materialReturnedChallanNo,
    required this.approver2Department,
    required this.entity,
    required this.originalReceiver,
    required this.takenOutEmail,
    required this.expectedDateOfReturn,
    required this.receiverDepartment,
    required this.submitted,
    required this.rejectionComment,
    required this.materialComingFromAddress,
    required this.remarks,
    required this.otherReceiverName,
    required this.rejectedDate,
    required this.returnable,
    required this.takenOutDate,
    required this.returnReceiverMailId,
    required this.rejectedBy,
    required this.materialComingFrom,
    required this.takenOutAddress,
    required this.address,
    required this.outwardPending,
    required this.slNo,
    required this.createdBy,
    required this.receivedForEmployeeId,
    required this.approver1Department,
    required this.approved,
    required this.preparedByDepartment,
    required this.outward,
    required this.purpose,
    required this.receiverSignature,
    required this.inwardPending,
    required this.location,
    required this.approver2Email,
    required this.approvedDate,
    required this.comment,
    required this.dateOfCreation,
    required this.nonReturnable,
    required this.requestorDepartment,
    required this.preparedBy,
    required this.materialBriefDescription,
    required this.requestorEmail,
    required this.draft,
    required this.takenOutBy,
    required this.rejected,
    required this.takenOutByDepartment,
    required this.securitySignature,
    required this.poNumber,
    required this.equipmentNoIdentification,
    required this.quantity,
    required this.takenOutByContactNo,
    required this.receiverEmail,
    required this.cancelled,
    required this.inward,
    required this.returnQuantity,
    required this.materialMovementType,
    required this.approver1Email,
    required this.sentTo,
    required this.isMaterialPhysicallyChecked,
    required this.receivedByEmployeeId,
    required this.status,
    required this.approver1Name,
    required this.returnReceiverName,
    required this.approver2Name,
    required this.entrySecuritySign,
    required this.challanInvoiceGatePass,
    required this.requestorName,
    required this.actualDateOfReturn,
    required this.approvedBy,
    required this.closedFinalized,
  });

  factory MmUiLabelsDefault.fromJson(Map<String, dynamic> json) =>
      _$MmUiLabelsDefaultFromJson(json);
  Map<String, dynamic> toJson() => _$MmUiLabelsDefaultToJson(this);
}
