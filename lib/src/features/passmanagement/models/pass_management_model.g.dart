// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pass_management_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PassManagementModel _$PassManagementModelFromJson(Map<String, dynamic> json) =>
    PassManagementModel(
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
      status: (json['status'] as num?)?.toInt(),
      modifiedBy: json['modifiedBy'] as String?,
      entrySecurity: json['entrySecurity'] == null
          ? null
          : User.fromJson(json['entrySecurity'] as Map<String, dynamic>),
      handoverSecurity: json['handoverSecurity'] == null
          ? null
          : HandoverSecurity.fromJson(
              json['handoverSecurity'] as Map<String, dynamic>),
      passType: (json['passType'] as num?)?.toInt(),
      companyType: json['companyType'] == null
          ? null
          : Organisation.fromJson(json['companyType'] as Map<String, dynamic>),
      companyName: json['companyName'] as String?,
      employeeName: json['employeeName'] as String?,
      employeeId: json['employeeId'] as String?,
      email: json['email'] as String?,
      host: json['host'] == null
          ? null
          : User.fromJson(json['host'] as Map<String, dynamic>),
      hostEmployeeId: json['hostEmployeeId'] as String?,
      department: json['department'] == null
          ? null
          : Organisation.fromJson(json['department'] as Map<String, dynamic>),
      dayPassReason: json['dayPassReason'] == null
          ? null
          : DayPassReason.fromJson(
              json['dayPassReason'] as Map<String, dynamic>),
      exceptionalApproval: json['exceptionalApproval'] as bool?,
      passInfo: json['passInfo'] == null
          ? null
          : PassInfo.fromJson(json['passInfo'] as Map<String, dynamic>),
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      returnedTime: json['returnedTime'] as String?,
      evidenceDocuments: json['evidenceDocuments'] as List<dynamic>?,
      contactNo: json['contactNo'] as String?,
      vendorPassReason: json['vendorPassReason'] == null
          ? null
          : VendorPassReason.fromJson(
              json['vendorPassReason'] as Map<String, dynamic>),
      escortedByHost: json['escortedByHost'] as bool?,
      escortedBy: json['escortedBy'] as String?,
      escortedEmployeeId: json['escortedEmployeeId'] as String?,
      visitorComingFrom: json['visitorComingFrom'] as String?,
      idValidated: json['idValidated'] as bool?,
      idValidationType: (json['idValidationType'] as num?)?.toInt(),
      visitingPurpose: json['visitingPurpose'] as String?,
      category: (json['category'] as num?)?.toInt(),
      passIssuedOn: json['passIssuedOn'] as String?,
      hostName: json['hostName'] as String?,
      handOverSecurityName: json['handOverSecurityName'] as String?,
      mifareNo: json['mifareNo'] as String?,
      passNo: json['passNo'] as String?,
      escortedByName: json['escortedByName'] as String?,
      entrySecurityName: json['entrySecurityName'] as String?,
    )..lock = json['lock'] as String?;

Map<String, dynamic> _$PassManagementModelToJson(
        PassManagementModel instance) =>
    <String, dynamic>{
      'lock': instance.lock,
      'id': instance.id,
      'slNo': instance.slNo,
      'inputDate': instance.inputDate,
      'location': instance.location,
      'locationRegion': instance.locationRegion,
      'entities': instance.entities,
      'status': instance.status,
      'modifiedBy': instance.modifiedBy,
      'entrySecurity': instance.entrySecurity,
      'handoverSecurity': instance.handoverSecurity,
      'passType': instance.passType,
      'companyType': instance.companyType,
      'companyName': instance.companyName,
      'employeeName': instance.employeeName,
      'employeeId': instance.employeeId,
      'email': instance.email,
      'host': instance.host,
      'hostEmployeeId': instance.hostEmployeeId,
      'department': instance.department,
      'dayPassReason': instance.dayPassReason,
      'exceptionalApproval': instance.exceptionalApproval,
      'passInfo': instance.passInfo,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'returnedTime': instance.returnedTime,
      'evidenceDocuments': instance.evidenceDocuments,
      'contactNo': instance.contactNo,
      'vendorPassReason': instance.vendorPassReason,
      'escortedByHost': instance.escortedByHost,
      'escortedBy': instance.escortedBy,
      'escortedEmployeeId': instance.escortedEmployeeId,
      'visitorComingFrom': instance.visitorComingFrom,
      'idValidated': instance.idValidated,
      'idValidationType': instance.idValidationType,
      'visitingPurpose': instance.visitingPurpose,
      'category': instance.category,
      'passIssuedOn': instance.passIssuedOn,
      'hostName': instance.hostName,
      'handOverSecurityName': instance.handOverSecurityName,
      'mifareNo': instance.mifareNo,
      'passNo': instance.passNo,
      'escortedByName': instance.escortedByName,
      'entrySecurityName': instance.entrySecurityName,
    };
