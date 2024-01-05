// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// part of 'key_management_issuance_model.dart';
//
// // **************************************************************************
// // JsonSerializableGenerator
// // **************************************************************************
//
// KeyManagementIssuanceModel _$KeyManagementIssuanceModelFromJson(
//         Map<String, dynamic> json) =>
//     KeyManagementIssuanceModel(
//       id: json['id'] as int?,
//       createdBy: (json['createdBy'] as Map<String, dynamic>?) != null
//           ? User.fromJson(json['createdBy'] as Map<String, dynamic>)
//           : null,
//       createdDate: json['createdDate'] as String?,
//       status: json['status'] as int?,
//       keyHandOverDate: json['keyHandOverDate'] as String?,
//       location: (json['location'] as Map<String, dynamic>?) != null
//           ? Organisation.fromJson(json['location'] as Map<String, dynamic>)
//           : null,
//       slNo: json['slNo'] as String?,
//       entities: (json['entities'] as List?)
//           ?.map((dynamic e) => Organisation.fromJson(e as Map<String, dynamic>))
//           .toList(),
//       department: (json['department'] as Map<String, dynamic>?) != null
//           ? Organisation.fromJson(json['department'] as Map<String, dynamic>)
//           : null,
//       keyHandingOverDuration: json['keyHandingOverDuration'] as int?,
//       keyHandOverDue: json['keyHandOverDue'] as String?,
//       employeeType: json['employeeType'] as int?,
//       employeeID: json['employeeID'] as String?,
//       handedOverTo: (json['handedOverTo'] as Map<String, dynamic>?) != null
//           ? User.fromJson(json['handedOverTo'] as Map<String, dynamic>)
//           : null,
//       dbSponsorCwrT2: (json['dbSponsorCwrT2'] as Map<String, dynamic>?) != null
//           ? User.fromJson(json['dbSponsorCwrT2'] as Map<String, dynamic>)
//           : null,
//       keyReturnDateTime: json['keyReturnDateTime'] as String?,
//       returnedByName: json['returnedByName'] as String?,
//       modifiedDate: json['modifiedDate'] as String?,
//       modifiedBy: json['modifiedBy'] as String?,
//     )..lock = json['lock'] as String?;
//
// Map<String, dynamic> _$KeyManagementIssuanceModelToJson(
//         KeyManagementIssuanceModel instance) =>
//     <String, dynamic>{
//       'lock': instance.lock,
//       'id': instance.id,
//       'createdBy': instance.createdBy?.toJson(),
//       'createdDate': instance.createdDate,
//       'status': instance.status,
//       'keyHandOverDate': instance.keyHandOverDate,
//       'location': instance.location?.toJson(),
//       'slNo': instance.slNo,
//       'entities': instance.entities?.map((e) => e.toJson()).toList(),
//       'department': instance.department?.toJson(),
//       'keyHandingOverDuration': instance.keyHandingOverDuration,
//       'keyHandOverDue': instance.keyHandOverDue,
//       'employeeType': instance.employeeType,
//       'employeeID': instance.employeeID,
//       'handedOverTo': instance.handedOverTo?.toJson(),
//       'dbSponsorCwrT2': instance.dbSponsorCwrT2?.toJson(),
//       'keyReturnDateTime': instance.keyReturnDateTime,
//       'returnedByName': instance.returnedByName,
//       'modifiedDate': instance.modifiedDate,
//       'modifiedBy': instance.modifiedBy,
//     };
