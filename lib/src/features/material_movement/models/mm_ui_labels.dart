
import 'package:json_annotation/json_annotation.dart';

part 'mm_ui_labels.g.dart';

@JsonSerializable()
class MmUiLabels {
  MmUiLabels({
    required this.locale,
    required this.defaultLocale,
  });

  factory MmUiLabels.fromJson(Map<String, dynamic> json) =>
      _$MmUiLabelsFromJson(json);

  Map<String, dynamic> toJson() => _$MmUiLabelsToJson(this);

  @JsonKey(name: 'locale')
  final MmUiLabelsLocale locale;
  @JsonKey(name: 'default')
  final MmUiLabelsLocale defaultLocale;
}

@JsonSerializable()
class MmUiLabelsLocale {
  MmUiLabelsLocale({
    required this.unit,
    required this.receiverName,
    required this.requestorEmployeeId,
    required this.materialReturnedChallanNo,
    required this.approver2Department,
    required this.entity,
    required this.originalReceiver,
    required this.takenOutEmail,
    required this.expectedDateOfReturn,
    required this.receiverDepartment,
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
    required this.statusOutWardWaiting,
    required this.slNo,
    required this.entrySecurity,
    required this.receiverEmployeeId,
    required this.approver1Department,
    required this.statusApproved,
    required this.preparedByDepartment,
    required this.out,
    required this.purpose,
    required this.receiverSign,
    required this.statusInWardWaiting,
    required this.submitted,
    required this.location,
    required this.approver2Email,
    required this.approvedDate,
    required this.materialNotCheckedComment,
    required this.inputDate,
    required this.nonReturnable,
    required this.requestorDepartment,
    required this.preparedBy,
    required this.materialDescription,
    required this.requestorEmail,
    required this.statusDraft,
    required this.takenOutName,
    required this.statusRejected,
    required this.takenOutDepartment,
    required this.gatePassSecuritySign,
    required this.poNumber,
    required this.modelInfo,
    required this.quantity,
    required this.takenOutContactNo,
    required this.receiverEmail,
    required this.statusCancelled,
    required this.inward,
    required this.returnQuantity,
    required this.type,
    required this.approver1Email,
    required this.sentTo,
    required this.materialPhysicallyChecked,
    required this.otherReceiverEmployeeId,
    required this.status,
    required this.approver1Name,
    required this.returnReceiverName,
    required this.approver2Name,
    required this.entrySecuritySign,
    required this.challanNo,
    required this.requestorName,
    required this.actualDateOfReturn,
    required this.approvedBy,
    required this.statusClosed,
  });

  factory MmUiLabelsLocale.fromJson(Map<String, dynamic> json) =>
      _$MmUiLabelsLocaleFromJson(json);

  // factory MmUiLabelsLocale.fromJson(Map<String, dynamic> json) {
  //
  //   try {
  //     return _$MmUiLabelsLocaleFromJson(json);
  //   } catch (e) {
  //     log('Error parsing MmUiLabelsLocale: $e');
  //
  //     if (e is TypeError) {
  //       log('e is TypeError  ${e.stackTrace}');
  //       // Check if the error is a type error, indicating a type mismatch.
  //       // Log the key causing the issue.
  //       if (e.stackTrace != null) {
  //         final stackTraceLines = e.stackTrace.toString().split('\n');
  //         final keyMatch = RegExp(r"at Object\.cast \((.*?)\)")
  //             .firstMatch(stackTraceLines[1]);
  //         if (keyMatch != null && keyMatch.groupCount >= 1) {
  //           final key = keyMatch.group(1);
  //           log('Problematic JSON key: $key');
  //         }
  //       }
  //     }
  //     rethrow;
  //   }
  // }

  Map<String, dynamic> toJson() => _$MmUiLabelsLocaleToJson(this);

  @JsonKey(name: 'com.arlanto.atom.materialMovement.unit')
  final String? unit;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.receiverName')
  final String? receiverName;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.requestorEmployeeId')
  final String? requestorEmployeeId;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.materialReturnedChallanNo')
  final String? materialReturnedChallanNo;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.approver2Department')
  final String? approver2Department;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.entity')
  final String? entity;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.originalReceiver')
  final String? originalReceiver;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.takenOutEmail')
  final String? takenOutEmail;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.expectedDateOfReturn')
  final String? expectedDateOfReturn;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.receiverDepartment')
  final String? receiverDepartment;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.rejectionComment')
  final String? rejectionComment;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.materialComingFromAddress')
  final String? materialComingFromAddress;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.remarks')
  final String? remarks;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.otherReceiverName')
  final String? otherReceiverName;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.rejectedDate')
  final String? rejectedDate;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.returnable')
  final String? returnable;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.takenOutDate')
  final String? takenOutDate;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.returnReceiverMailId')
  final String? returnReceiverMailId;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.rejectedBy')
  final String? rejectedBy;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.materialComingFrom')
  final String? materialComingFrom;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.takenOutAddress')
  final String? takenOutAddress;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.address')
  final String? address;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.status.outWardWaiting')
  final String? statusOutWardWaiting;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.slNo')
  final String? slNo;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.entrySecurity')
  final String? entrySecurity;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.materialNotCheckedComment')
  final String? materialNotCheckedComment;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.inputDate')
  final String? inputDate;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.nonReturnable')
  final String? nonReturnable;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.requestorDepartment')
  final String? requestorDepartment;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.preparedBy')
  final String? preparedBy;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.materialDescription')
  final String? materialDescription;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.requestorEmail')
  final String? requestorEmail;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.status.draft')
  final String? statusDraft;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.takenOutName')
  final String? takenOutName;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.status.rejected')
  final String? statusRejected;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.takenOutDepartment')
  final String? takenOutDepartment;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.gatePassSecuritySign')
  final String? gatePassSecuritySign;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.poNumber')
  final String? poNumber;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.modelInfo')
  final String? modelInfo;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.quantity')
  final String? quantity;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.takenOutContactNo')
  final String? takenOutContactNo;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.receiverEmail')
  final String? receiverEmail;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.status.cancelled')
  final String? statusCancelled;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.in')
  final String? inward;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.returnQuantity')
  final String? returnQuantity;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.type')
  final String? type;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.approver1Email')
  final String? approver1Email;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.sentTo')
  final String? sentTo;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.materialPhysicallyChecked')
  final String? materialPhysicallyChecked;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.receiverEmployeeId')
  final String? receiverEmployeeId;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.approver1Department')
  final String? approver1Department;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.status.approved')
  final String? statusApproved;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.preparedByDepartment')
  final String? preparedByDepartment;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.out')
  final String? out;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.purpose')
  final String? purpose;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.receiverSign')
  final String? receiverSign;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.status.inWardWaiting')
  final String? statusInWardWaiting;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.submitted')
  final String? submitted;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.location')
  final String? location;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.approver2Email')
  final String? approver2Email;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.approvedDate')
  final String? approvedDate;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.otherReceiverEmployeeId')
  final String? otherReceiverEmployeeId;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.status')
  final String? status;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.approver1Name')
  final String? approver1Name;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.returnReceiverName')
  final String? returnReceiverName;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.approver2Name')
  final String? approver2Name;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.entrySecuritySign')
  final String? entrySecuritySign;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.challanNo')
  final String? challanNo;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.requestorName')
  final String? requestorName;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.actualDateOfReturn')
  final String? actualDateOfReturn;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.approvedBy')
  final String? approvedBy;

  @JsonKey(name: 'com.arlanto.atom.materialMovement.status.closed')
  final String? statusClosed;
}
