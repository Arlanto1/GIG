import 'package:json_annotation/json_annotation.dart';

part 'mm_ui_labels.g.dart';

@JsonSerializable()
class MmUiLabels {
  MmUiLabels({
    required this.locale,
  });

  factory MmUiLabels.fromJson(Map<String, dynamic> json) =>
      _$MmUiLabelsFromJson(json);

  Map<String, dynamic> toJson() => _$MmUiLabelsToJson(this);

  final MmUiLabelsLocale locale;
}

@JsonSerializable()
class MmUiLabelsLocale {
  MmUiLabelsLocale({
    @JsonKey(name: 'com.arlanto.atom.materialMovement.unit') required this.unit,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.receiverName')
    required this.receiverName,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.requestorEmployeeId')
    required this.requestorEmployeeId,
    @JsonKey(
        name: 'com.arlanto.atom.materialMovement.materialReturnedChallanNo')
    required this.materialReturnedChallanNo,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.approver2Department')
    required this.approver2Department,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.entity')
    required this.entity,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.originalReceiver')
    required this.originalReceiver,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.takenOutEmail')
    required this.takenOutEmail,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.expectedDateOfReturn')
    required this.expectedDateOfReturn,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.receiverDepartment')
    required this.receiverDepartment,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.rejectionComment')
    required this.rejectionComment,
    @JsonKey(
        name: 'com.arlanto.atom.materialMovement.materialComingFromAddress')
    required this.materialComingFromAddress,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.remarks')
    required this.remarks,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.otherReceiverName')
    required this.otherReceiverName,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.rejectedDate')
    required this.rejectedDate,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.returnable')
    required this.returnable,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.takenOutDate')
    required this.takenOutDate,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.returnReceiverMailId')
    required this.returnReceiverMailId,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.rejectedBy')
    required this.rejectedBy,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.materialComingFrom')
    required this.materialComingFrom,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.takenOutAddress')
    required this.takenOutAddress,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.address')
    required this.address,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.status.outWardWaiting')
    required this.statusOutWardWaiting,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.slNo') required this.slNo,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.entrySecurity')
    required this.entrySecurity,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.receiverEmployeeId')
    required this.receiverEmployeeId,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.approver1Department')
    required this.approver1Department,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.status.approved')
    required this.statusApproved,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.preparedByDepartment')
    required this.preparedByDepartment,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.out') required this.out,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.purpose')
    required this.purpose,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.receiverSign')
    required this.receiverSign,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.status.inWardWaiting')
    required this.statusInWardWaiting,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.submitted')
    required this.submitted,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.location')
    required this.location,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.approver2Email')
    required this.approver2Email,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.approvedDate')
    required this.approvedDate,
    @JsonKey(
        name: 'com.arlanto.atom.materialMovement.materialNotCheckedComment')
    required this.materialNotCheckedComment,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.inputDate')
    required this.inputDate,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.nonReturnable')
    required this.nonReturnable,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.requestorDepartment')
    required this.requestorDepartment,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.preparedBy')
    required this.preparedBy,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.materialDescription')
    required this.materialDescription,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.requestorEmail')
    required this.requestorEmail,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.status.draft')
    required this.statusDraft,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.takenOutName')
    required this.takenOutName,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.status.rejected')
    required this.statusRejected,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.takenOutDepartment')
    required this.takenOutDepartment,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.gatePassSecuritySign')
    required this.gatePassSecuritySign,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.poNumber')
    required this.poNumber,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.modelInfo')
    required this.modelInfo,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.quantity')
    required this.quantity,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.takenOutContactNo')
    required this.takenOutContactNo,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.receiverEmail')
    required this.receiverEmail,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.status.cancelled')
    required this.statusCancelled,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.in') required this.inward,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.returnQuantity')
    required this.returnQuantity,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.type') required this.type,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.approver1Email')
    required this.approver1Email,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.sentTo')
    required this.sentTo,
    @JsonKey(
        name: 'com.arlanto.atom.materialMovement.materialPhysicallyChecked')
    required this.materialPhysicallyChecked,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.otherReceiverEmployeeId')
    required this.otherReceiverEmployeeId,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.status')
    required this.status,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.approver1Name')
    required this.approver1Name,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.returnReceiverName')
    required this.returnReceiverName,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.approver2Name')
    required this.approver2Name,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.entrySecuritySign')
    required this.entrySecuritySign,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.challanNo')
    required this.challanNo,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.requestorName')
    required this.requestorName,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.actualDateOfReturn')
    required this.actualDateOfReturn,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.approvedBy')
    required this.approvedBy,
    @JsonKey(name: 'com.arlanto.atom.materialMovement.status.closed')
    required this.statusClosed,
  });

  factory MmUiLabelsLocale.fromJson(Map<String, dynamic> json) =>
      _$MmUiLabelsLocaleFromJson(json);

  Map<String, dynamic> toJson() => _$MmUiLabelsLocaleToJson(this);

  final String unit;
  final String receiverName;
  final String requestorEmployeeId;
  final String materialReturnedChallanNo;
  final String approver2Department;
  final String entity;
  final String originalReceiver;
  final String takenOutEmail;
  final String expectedDateOfReturn;
  final String receiverDepartment;
  final String rejectionComment;
  final String materialComingFromAddress;
  final String remarks;
  final String otherReceiverName;
  final String rejectedDate;
  final String returnable;
  final String takenOutDate;
  final String returnReceiverMailId;
  final String rejectedBy;
  final String materialComingFrom;
  final String takenOutAddress;
  final String address;
  final String statusOutWardWaiting;
  final String slNo;
  final String entrySecurity;
  final String receiverEmployeeId;
  final String approver1Department;
  final String statusApproved;
  final String preparedByDepartment;
  final String out;
  final String purpose;
  final String receiverSign;
  final String statusInWardWaiting;
  final String submitted;
  final String location;
  final String approver2Email;
  final String approvedDate;
  final String materialNotCheckedComment;
  final String inputDate;
  final String nonReturnable;
  final String requestorDepartment;
  final String preparedBy;
  final String materialDescription;
  final String requestorEmail;
  final String statusDraft;
  final String takenOutName;
  final String statusRejected;
  final String takenOutDepartment;
  final String gatePassSecuritySign;
  final String poNumber;
  final String modelInfo;
  final String quantity;
  final String takenOutContactNo;
  final String receiverEmail;
  final String statusCancelled;
  final String inward;
  final String returnQuantity;
  final String type;
  final String approver1Email;
  final String sentTo;
  final String materialPhysicallyChecked;
  final String otherReceiverEmployeeId;
  final String status;
  final String approver1Name;
  final String returnReceiverName;
  final String approver2Name;
  final String entrySecuritySign;
  final String challanNo;
  final String requestorName;
  final String actualDateOfReturn;
  final String approvedBy;
  final String statusClosed;
}
