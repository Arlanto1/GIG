import 'package:db_atom/src/features/material_movement/models/material_movements_model.dart';
import 'package:db_atom/src/models/base_object.dart';
import 'package:db_atom/src/features/createfound/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../models/history.dart';
import '../../../models/organisation.dart';

part 'material_movement_model.g.dart';

@JsonSerializable()
class MaterialMovementModel extends BaseObject {
  int? id;
  String? slNo;
  String? inputDate;
  Organisation? location;
  Organisation? locationRegion;
  List<dynamic>? entities;
  bool? inwardMovement;
  bool? returnable;
  String? challanNo;
  String? materialComingFrom;
  String? materialFromAddress;
  String? materialDescription;
  int? quantity;
  List<ImageContent>? images;
  List<ImageContent>? receiverSign;
  List<ImageContent>? entrySecuritySign;
  String? receiverEmail;
  String? receiverEmployeeId;
  User? entrySecurity;
  int? status;
  String? modifiedBy;
  List<History>? history;
  String? requestorEmail;
  String? requestorEmployeeId;
  Organisation? requestorDepartment;
  String? sentTo;
  String? address;
  String? purpose;
  String? modelInfo;
  Organisation? unit;
  String? preparedBy;
  Organisation? preparedByDepartment;
  String? approver1Email;
  Organisation? approver1Department;
  String? approver2Email;
  Organisation? approver2Department;
  Organisation? receiverDepartment;
  String? takenOutEmail;
  String? takenOutContactNo;
  String? materialReturnedChallanNo;
  String? returnReceiverMailId;
  String? poNumber;
  int? returnQuantity;
  bool originalReceiver;
  String? otherReceiverName;
  String? otherReceiverEmployeeId;
  bool materialPhysicallyChecked;
  String? materialNotCheckedComment;
  String? takenOutAddress;
  String? entrySecurityName;
  String? receiverDepartmenttName;
  String? rejectedDate;
  String? rejectedBy;
  String? rejectionComment;
  String? approvedBy;
  String? approvedDate;
  String? expectedDateOfReturn;
  String? takenOutDate;
  String? actualDateOfReturn;

  final Organisation? takenOutDepartment;
  List<ImageContent>? gatePassSecuritySign;

  MaterialMovementModel({
    this.takenOutDepartment,
    this.gatePassSecuritySign,
    this.id,
    this.slNo,
    this.inputDate,
    this.location,
    this.locationRegion,
    this.entities,
    this.returnQuantity,
    this.inwardMovement = false,
    this.returnable = false,
    this.challanNo,
    this.materialComingFrom,
    this.materialFromAddress,
    this.materialDescription,
    this.quantity,
    this.images = const [],
    this.receiverEmail,
    this.receiverEmployeeId,
    this.entrySecurity,
    this.status,
    this.modifiedBy,
    this.history,
    this.requestorEmail,
    this.receiverSign= const [],
    this.entrySecuritySign= const [],
    this.requestorEmployeeId,
    this.requestorDepartment,
    this.sentTo,
    this.address,
    this.purpose,
    this.modelInfo,
    this.unit,
    this.preparedBy,
    this.preparedByDepartment,
    this.approver1Email,
    this.approver1Department,
    this.approver2Email,
    this.approver2Department,
    this.receiverDepartment,
    this.takenOutEmail,
    this.takenOutContactNo,
    this.materialReturnedChallanNo,
    this.returnReceiverMailId,
    this.poNumber,
    this.originalReceiver = false,
    this.otherReceiverName,
    this.otherReceiverEmployeeId,
    this.materialPhysicallyChecked = false,
    this.materialNotCheckedComment,
    this.takenOutAddress,
    this.entrySecurityName,
    this.receiverDepartmenttName,
    this.rejectedBy,
    this.rejectedDate,
    this.rejectionComment,
    this.approvedBy,
    this.approvedDate,
    this.takenOutDate,
    this.expectedDateOfReturn,
    this.actualDateOfReturn,
  });

  factory MaterialMovementModel.fromJson(Map<String, dynamic> json) =>
      _$MaterialMovementModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MaterialMovementModelToJson(this);

}
