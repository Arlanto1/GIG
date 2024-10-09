// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_movement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaterialMovementModel _$MaterialMovementModelFromJson(
        Map<String, dynamic> json) =>
    MaterialMovementModel(
      takenOutDepartment: json['takenOutDepartment'] == null
          ? null
          : Organisation.fromJson(
              json['takenOutDepartment'] as Map<String, dynamic>),
      gatePassSecuritySign: (json['gatePassSecuritySign'] as List<dynamic>?)
          ?.map((e) => ImageContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: (json['id'] as num?)?.toInt(),
      slNo: json['slNo'] as String?,
      inputDate: json['inputDate'] as String?,
      location: json['location'] == null
          ? null
          : Organisation.fromJson(json['location'] as Map<String, dynamic>),
      locationRegion: json['locationRegion'] == null
          ? null
          : Organisation.fromJson(
              json['locationRegion'] as Map<String, dynamic>),
      entities: json['entities'] as List<dynamic>?,
      returnQuantity: (json['returnQuantity'] as num?)?.toInt(),
      inwardMovement: json['inwardMovement'] as bool? ?? false,
      returnable: json['returnable'] as bool?,
      challanNo: json['challanNo'] as String?,
      materialComingFrom: json['materialComingFrom'] as String?,
      materialFromAddress: json['materialFromAddress'] as String?,
      materialDescription: json['materialDescription'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => ImageContent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      receiverEmail: json['receiverEmail'] as String?,
      receiverEmployeeId: json['receiverEmployeeId'] as String?,
      entrySecurity: json['entrySecurity'] == null
          ? null
          : User.fromJson(json['entrySecurity'] as Map<String, dynamic>),
      status: (json['status'] as num?)?.toInt(),
      modifiedBy: json['modifiedBy'] as String?,
      history: (json['history'] as List<dynamic>?)
          ?.map((e) => History.fromJson(e as Map<String, dynamic>))
          .toList(),
      requestorEmail: json['requestorEmail'] as String?,
      receiverSign: json['receiverSign'] == null
          ? null
          : ImageContent.fromJson(json['receiverSign'] as Map<String, dynamic>),
      entrySecuritySign: json['entrySecuritySign'] == null
          ? null
          : ImageContent.fromJson(
              json['entrySecuritySign'] as Map<String, dynamic>),
      requestorEmployeeId: json['requestorEmployeeId'] as String?,
      requestorDepartment: json['requestorDepartment'] == null
          ? null
          : Organisation.fromJson(
              json['requestorDepartment'] as Map<String, dynamic>),
      sentTo: json['sentTo'] as String?,
      address: json['address'] as String?,
      purpose: json['purpose'] as String?,
      modelInfo: json['modelInfo'] as String?,
      unit: json['unit'] == null
          ? null
          : Organisation.fromJson(json['unit'] as Map<String, dynamic>),
      preparedBy: json['preparedBy'] as String?,
      preparedByDepartment: json['preparedByDepartment'] == null
          ? null
          : Organisation.fromJson(
              json['preparedByDepartment'] as Map<String, dynamic>),
      approver1Email: json['approver1Email'] as String?,
      approver1Department: json['approver1Department'] == null
          ? null
          : Organisation.fromJson(
              json['approver1Department'] as Map<String, dynamic>),
      approver2Email: json['approver2Email'] as String?,
      approver2Department: json['approver2Department'] == null
          ? null
          : Organisation.fromJson(
              json['approver2Department'] as Map<String, dynamic>),
      receiverDepartment: json['receiverDepartment'] == null
          ? null
          : Organisation.fromJson(
              json['receiverDepartment'] as Map<String, dynamic>),
      takenOutEmail: json['takenOutEmail'] as String?,
      takenOutContactNo: json['takenOutContactNo'] as String?,
      materialReturnedChallanNo: json['materialReturnedChallanNo'] as String?,
      returnReceiverMailId: json['returnReceiverMailId'] as String?,
      poNumber: json['poNumber'] as String?,
      originalReceiver: json['originalReceiver'] as bool? ?? false,
      otherReceiverName: json['otherReceiverName'] as String?,
      otherReceiverEmployeeId: json['otherReceiverEmployeeId'] as String?,
      materialPhysicallyChecked:
          json['materialPhysicallyChecked'] as bool? ?? false,
      materialNotCheckedComment: json['materialNotCheckedComment'] as String?,
      takenOutAddress: json['takenOutAddress'] as String?,
      entrySecurityName: json['entrySecurityName'] as String?,
      receiverDepartmenttName: json['receiverDepartmenttName'] as String?,
      rejectedBy: json['rejectedBy'] as String?,
      rejectedDate: json['rejectedDate'] as String?,
      rejectionComment: json['rejectionComment'] as String?,
      approvedBy: json['approvedBy'] as String?,
      approvedDate: json['approvedDate'] as String?,
      takenOutDate: json['takenOutDate'] as String?,
      expectedDateOfReturn: json['expectedDateOfReturn'] as String?,
      actualDateOfReturn: json['actualDateOfReturn'] as String?,
      comment: json['comment'] as String?,
      isEligibleToEdit: json['isEligibleToEdit'] as bool? ?? false,
      modifiedDate: json['modifiedDate'] as String?,
    )..lock = json['lock'] as String?;

Map<String, dynamic> _$MaterialMovementModelToJson(
        MaterialMovementModel instance) =>
    <String, dynamic>{
      'lock': instance.lock,
      'id': instance.id,
      'slNo': instance.slNo,
      'inputDate': instance.inputDate,
      'location': instance.location,
      'locationRegion': instance.locationRegion,
      'entities': instance.entities,
      'inwardMovement': instance.inwardMovement,
      'returnable': instance.returnable,
      'challanNo': instance.challanNo,
      'materialComingFrom': instance.materialComingFrom,
      'materialFromAddress': instance.materialFromAddress,
      'materialDescription': instance.materialDescription,
      'quantity': instance.quantity,
      'images': instance.images,
      'receiverSign': instance.receiverSign,
      'entrySecuritySign': instance.entrySecuritySign,
      'receiverEmail': instance.receiverEmail,
      'receiverEmployeeId': instance.receiverEmployeeId,
      'entrySecurity': instance.entrySecurity,
      'status': instance.status,
      'history': instance.history,
      'requestorEmail': instance.requestorEmail,
      'requestorEmployeeId': instance.requestorEmployeeId,
      'requestorDepartment': instance.requestorDepartment,
      'sentTo': instance.sentTo,
      'address': instance.address,
      'purpose': instance.purpose,
      'modelInfo': instance.modelInfo,
      'unit': instance.unit,
      'preparedBy': instance.preparedBy,
      'preparedByDepartment': instance.preparedByDepartment,
      'approver1Email': instance.approver1Email,
      'approver1Department': instance.approver1Department,
      'approver2Email': instance.approver2Email,
      'approver2Department': instance.approver2Department,
      'receiverDepartment': instance.receiverDepartment,
      'takenOutEmail': instance.takenOutEmail,
      'takenOutContactNo': instance.takenOutContactNo,
      'materialReturnedChallanNo': instance.materialReturnedChallanNo,
      'returnReceiverMailId': instance.returnReceiverMailId,
      'poNumber': instance.poNumber,
      'returnQuantity': instance.returnQuantity,
      'originalReceiver': instance.originalReceiver,
      'otherReceiverName': instance.otherReceiverName,
      'otherReceiverEmployeeId': instance.otherReceiverEmployeeId,
      'materialPhysicallyChecked': instance.materialPhysicallyChecked,
      'materialNotCheckedComment': instance.materialNotCheckedComment,
      'takenOutAddress': instance.takenOutAddress,
      'entrySecurityName': instance.entrySecurityName,
      'receiverDepartmenttName': instance.receiverDepartmenttName,
      'rejectedDate': instance.rejectedDate,
      'rejectedBy': instance.rejectedBy,
      'rejectionComment': instance.rejectionComment,
      'approvedBy': instance.approvedBy,
      'approvedDate': instance.approvedDate,
      'expectedDateOfReturn': instance.expectedDateOfReturn,
      'takenOutDate': instance.takenOutDate,
      'actualDateOfReturn': instance.actualDateOfReturn,
      'takenOutDepartment': instance.takenOutDepartment,
      'gatePassSecuritySign': instance.gatePassSecuritySign,
      'comment': instance.comment,
      'isEligibleToEdit': instance.isEligibleToEdit,
      'modifiedBy': instance.modifiedBy,
      'modifiedDate': instance.modifiedDate,
    };
