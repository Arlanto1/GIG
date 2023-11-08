// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mm_ui_labels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MmUiLabels _$MmUiLabelsFromJson(Map<String, dynamic> json) => MmUiLabels(
      defaultLabels: MmUiLabelsDefault.fromJson(
          json['defaultLabels'] as Map<String, dynamic>),
      localeLabels: MmUiLabelsDefault.fromJson(
          json['localeLabels'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MmUiLabelsToJson(MmUiLabels instance) =>
    <String, dynamic>{
      'defaultLabels': instance.defaultLabels,
      'localeLabels': instance.localeLabels,
    };

MmUiLabelsDefault _$MmUiLabelsDefaultFromJson(Map<String, dynamic> json) =>
    MmUiLabelsDefault(
      unit: json['com.arlanto.atom.materialMovement.unit'] as String,
      receivedBy:
          json['com.arlanto.atom.materialMovement.receiverName'] as String,
      requestorEmployeeId:
          json['com.arlanto.atom.materialMovement.requestorEmployeeId']
              as String,
      materialReturnedChallanNo:
          json['com.arlanto.atom.materialMovement.materialReturnedChallanNo']
              as String,
      approver2Department:
          json['com.arlanto.atom.materialMovement.approver2Department']
              as String,
      entity: json['com.arlanto.atom.materialMovement.entity'] as String,
      originalReceiver:
          json['com.arlanto.atom.materialMovement.originalReceiver'] as String,
      takenOutEmail:
          json['com.arlanto.atom.materialMovement.takenOutEmail'] as String,
      expectedDateOfReturn:
          json['com.arlanto.atom.materialMovement.expectedDateOfReturn']
              as String,
      receiverDepartment:
          json['com.arlanto.atom.materialMovement.receiverDepartment']
              as String,
      submitted:
          json['com.arlanto.atom.materialMovement.status.submitted'] as String,
      rejectionComment:
          json['com.arlanto.atom.materialMovement.rejectionComment'] as String,
      materialComingFromAddress:
          json['com.arlanto.atom.materialMovement.materialComingFromAddress']
              as String,
      remarks: json['com.arlanto.atom.materialMovement.remarks'] as String,
      otherReceiverName:
          json['com.arlanto.atom.materialMovement.otherReceiverName'] as String,
      rejectedDate:
          json['com.arlanto.atom.materialMovement.rejectedDate'] as String,
      returnable:
          json['com.arlanto.atom.materialMovement.returnable'] as String,
      takenOutDate:
          json['com.arlanto.atom.materialMovement.takenOutDate'] as String,
      returnReceiverMailId:
          json['com.arlanto.atom.materialMovement.returnReceiverMailId']
              as String,
      rejectedBy:
          json['com.arlanto.atom.materialMovement.rejectedBy'] as String,
      materialComingFrom:
          json['com.arlanto.atom.materialMovement.materialComingFrom']
              as String,
      takenOutAddress:
          json['com.arlanto.atom.materialMovement.takenOutAddress'] as String,
      address: json['com.arlanto.atom.materialMovement.address'] as String,
      outwardPending:
          json['com.arlanto.atom.materialMovement.status.outWardWaiting']
              as String,
      slNo: json['com.arlanto.atom.materialMovement.slNo'] as String,
      createdBy:
          json['com.arlanto.atom.materialMovement.entrySecurity'] as String,
      receivedForEmployeeId:
          json['com.arlanto.atom.materialMovement.receiverEmployeeId']
              as String,
      approver1Department:
          json['com.arlanto.atom.materialMovement.approver1Department']
              as String,
      approved:
          json['com.arlanto.atom.materialMovement.status.approved'] as String,
      preparedByDepartment:
          json['com.arlanto.atom.materialMovement.preparedByDepartment']
              as String,
      outward: json['com.arlanto.atom.materialMovement.out'] as String,
      purpose: json['com.arlanto.atom.materialMovement.purpose'] as String,
      receiverSignature:
          json['com.arlanto.atom.materialMovement.receiverSign'] as String,
      inwardPending:
          json['com.arlanto.atom.materialMovement.status.inWardWaiting']
              as String,
      location: json['com.arlanto.atom.materialMovement.location'] as String,
      approver2Email:
          json['com.arlanto.atom.materialMovement.approver2Email'] as String,
      approvedDate:
          json['com.arlanto.atom.materialMovement.approvedDate'] as String,
      comment:
          json['com.arlanto.atom.materialMovement.materialNotCheckedComment']
              as String,
      dateOfCreation:
          json['com.arlanto.atom.materialMovement.inputDate'] as String,
      nonReturnable:
          json['com.arlanto.atom.materialMovement.nonReturnable'] as String,
      requestorDepartment:
          json['com.arlanto.atom.materialMovement.requestorDepartment']
              as String,
      preparedBy:
          json['com.arlanto.atom.materialMovement.preparedBy'] as String,
      materialBriefDescription:
          json['com.arlanto.atom.materialMovement.materialDescription']
              as String,
      requestorEmail:
          json['com.arlanto.atom.materialMovement.requestorEmail'] as String,
      draft: json['com.arlanto.atom.materialMovement.status.draft'] as String,
      takenOutBy:
          json['com.arlanto.atom.materialMovement.takenOutName'] as String,
      rejected:
          json['com.arlanto.atom.materialMovement.status.rejected'] as String,
      takenOutByDepartment:
          json['com.arlanto.atom.materialMovement.takenOutDepartment']
              as String,
      securitySignature:
          json['com.arlanto.atom.materialMovement.gatePassSecuritySign']
              as String,
      poNumber: json['com.arlanto.atom.materialMovement.poNumber'] as String,
      equipmentNoIdentification:
          json['com.arlanto.atom.materialMovement.modelInfo'] as String,
      quantity: json['com.arlanto.atom.materialMovement.quantity'] as String,
      takenOutByContactNo:
          json['com.arlanto.atom.materialMovement.takenOutContactNo'] as String,
      receiverEmail:
          json['com.arlanto.atom.materialMovement.receiverEmail'] as String,
      cancelled:
          json['com.arlanto.atom.materialMovement.status.cancelled'] as String,
      inward: json['com.arlanto.atom.materialMovement.in'] as String,
      returnQuantity:
          json['com.arlanto.atom.materialMovement.returnQuantity'] as String,
      materialMovementType:
          json['com.arlanto.atom.materialMovement.type'] as String,
      approver1Email:
          json['com.arlanto.atom.materialMovement.approver1Email'] as String,
      sentTo: json['com.arlanto.atom.materialMovement.sentTo'] as String,
      isMaterialPhysicallyChecked:
          json['com.arlanto.atom.materialMovement.materialPhysicallyChecked']
              as String,
      receivedByEmployeeId:
          json['com.arlanto.atom.materialMovement.otherReceiverEmployeeId']
              as String,
      status: json['com.arlanto.atom.materialMovement.status'] as String,
      approver1Name:
          json['com.arlanto.atom.materialMovement.approver1Name'] as String,
      returnReceiverName:
          json['com.arlanto.atom.materialMovement.returnReceiverName']
              as String,
      approver2Name:
          json['com.arlanto.atom.materialMovement.approver2Name'] as String,
      entrySecuritySign:
          json['com.arlanto.atom.materialMovement.entrySecuritySign'] as String,
      challanInvoiceGatePass:
          json['com.arlanto.atom.materialMovement.challanNo'] as String,
      requestorName:
          json['com.arlanto.atom.materialMovement.requestorName'] as String,
      actualDateOfReturn:
          json['com.arlanto.atom.materialMovement.actualDateOfReturn']
              as String,
      approvedBy:
          json['com.arlanto.atom.materialMovement.approvedBy'] as String,
      closedFinalized:
          json['com.arlanto.atom.materialMovement.status.closed'] as String,
    );

Map<String, dynamic> _$MmUiLabelsDefaultToJson(MmUiLabelsDefault instance) =>
    <String, dynamic>{
      'com.arlanto.atom.materialMovement.unit': instance.unit,
      'com.arlanto.atom.materialMovement.receiverName': instance.receivedBy,
      'com.arlanto.atom.materialMovement.requestorEmployeeId':
          instance.requestorEmployeeId,
      'com.arlanto.atom.materialMovement.materialReturnedChallanNo':
          instance.materialReturnedChallanNo,
      'com.arlanto.atom.materialMovement.approver2Department':
          instance.approver2Department,
      'com.arlanto.atom.materialMovement.entity': instance.entity,
      'com.arlanto.atom.materialMovement.originalReceiver':
          instance.originalReceiver,
      'com.arlanto.atom.materialMovement.takenOutEmail': instance.takenOutEmail,
      'com.arlanto.atom.materialMovement.expectedDateOfReturn':
          instance.expectedDateOfReturn,
      'com.arlanto.atom.materialMovement.receiverDepartment':
          instance.receiverDepartment,
      'com.arlanto.atom.materialMovement.status.submitted': instance.submitted,
      'com.arlanto.atom.materialMovement.rejectionComment':
          instance.rejectionComment,
      'com.arlanto.atom.materialMovement.materialComingFromAddress':
          instance.materialComingFromAddress,
      'com.arlanto.atom.materialMovement.remarks': instance.remarks,
      'com.arlanto.atom.materialMovement.otherReceiverName':
          instance.otherReceiverName,
      'com.arlanto.atom.materialMovement.rejectedDate': instance.rejectedDate,
      'com.arlanto.atom.materialMovement.returnable': instance.returnable,
      'com.arlanto.atom.materialMovement.takenOutDate': instance.takenOutDate,
      'com.arlanto.atom.materialMovement.returnReceiverMailId':
          instance.returnReceiverMailId,
      'com.arlanto.atom.materialMovement.rejectedBy': instance.rejectedBy,
      'com.arlanto.atom.materialMovement.materialComingFrom':
          instance.materialComingFrom,
      'com.arlanto.atom.materialMovement.takenOutAddress':
          instance.takenOutAddress,
      'com.arlanto.atom.materialMovement.address': instance.address,
      'com.arlanto.atom.materialMovement.status.outWardWaiting':
          instance.outwardPending,
      'com.arlanto.atom.materialMovement.slNo': instance.slNo,
      'com.arlanto.atom.materialMovement.entrySecurity': instance.createdBy,
      'com.arlanto.atom.materialMovement.receiverEmployeeId':
          instance.receivedForEmployeeId,
      'com.arlanto.atom.materialMovement.approver1Department':
          instance.approver1Department,
      'com.arlanto.atom.materialMovement.status.approved': instance.approved,
      'com.arlanto.atom.materialMovement.preparedByDepartment':
          instance.preparedByDepartment,
      'com.arlanto.atom.materialMovement.out': instance.outward,
      'com.arlanto.atom.materialMovement.purpose': instance.purpose,
      'com.arlanto.atom.materialMovement.receiverSign':
          instance.receiverSignature,
      'com.arlanto.atom.materialMovement.status.inWardWaiting':
          instance.inwardPending,
      'com.arlanto.atom.materialMovement.location': instance.location,
      'com.arlanto.atom.materialMovement.approver2Email':
          instance.approver2Email,
      'com.arlanto.atom.materialMovement.approvedDate': instance.approvedDate,
      'com.arlanto.atom.materialMovement.materialNotCheckedComment':
          instance.comment,
      'com.arlanto.atom.materialMovement.inputDate': instance.dateOfCreation,
      'com.arlanto.atom.materialMovement.nonReturnable': instance.nonReturnable,
      'com.arlanto.atom.materialMovement.requestorDepartment':
          instance.requestorDepartment,
      'com.arlanto.atom.materialMovement.preparedBy': instance.preparedBy,
      'com.arlanto.atom.materialMovement.materialDescription':
          instance.materialBriefDescription,
      'com.arlanto.atom.materialMovement.requestorEmail':
          instance.requestorEmail,
      'com.arlanto.atom.materialMovement.status.draft': instance.draft,
      'com.arlanto.atom.materialMovement.takenOutName': instance.takenOutBy,
      'com.arlanto.atom.materialMovement.status.rejected': instance.rejected,
      'com.arlanto.atom.materialMovement.takenOutDepartment':
          instance.takenOutByDepartment,
      'com.arlanto.atom.materialMovement.gatePassSecuritySign':
          instance.securitySignature,
      'com.arlanto.atom.materialMovement.poNumber': instance.poNumber,
      'com.arlanto.atom.materialMovement.modelInfo':
          instance.equipmentNoIdentification,
      'com.arlanto.atom.materialMovement.quantity': instance.quantity,
      'com.arlanto.atom.materialMovement.takenOutContactNo':
          instance.takenOutByContactNo,
      'com.arlanto.atom.materialMovement.receiverEmail': instance.receiverEmail,
      'com.arlanto.atom.materialMovement.status.cancelled': instance.cancelled,
      'com.arlanto.atom.materialMovement.in': instance.inward,
      'com.arlanto.atom.materialMovement.returnQuantity':
          instance.returnQuantity,
      'com.arlanto.atom.materialMovement.type': instance.materialMovementType,
      'com.arlanto.atom.materialMovement.approver1Email':
          instance.approver1Email,
      'com.arlanto.atom.materialMovement.sentTo': instance.sentTo,
      'com.arlanto.atom.materialMovement.materialPhysicallyChecked':
          instance.isMaterialPhysicallyChecked,
      'com.arlanto.atom.materialMovement.otherReceiverEmployeeId':
          instance.receivedByEmployeeId,
      'com.arlanto.atom.materialMovement.status': instance.status,
      'com.arlanto.atom.materialMovement.approver1Name': instance.approver1Name,
      'com.arlanto.atom.materialMovement.returnReceiverName':
          instance.returnReceiverName,
      'com.arlanto.atom.materialMovement.approver2Name': instance.approver2Name,
      'com.arlanto.atom.materialMovement.entrySecuritySign':
          instance.entrySecuritySign,
      'com.arlanto.atom.materialMovement.challanNo':
          instance.challanInvoiceGatePass,
      'com.arlanto.atom.materialMovement.requestorName': instance.requestorName,
      'com.arlanto.atom.materialMovement.actualDateOfReturn':
          instance.actualDateOfReturn,
      'com.arlanto.atom.materialMovement.approvedBy': instance.approvedBy,
      'com.arlanto.atom.materialMovement.status.closed':
          instance.closedFinalized,
    };
