// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'foundlist_article_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoundListArticleDetails _$FoundListArticleDetailsFromJson(
        Map<String, dynamic> json) =>
    FoundListArticleDetails(
      id: json['id'] as int?,
      slNo: json['slNo'] as String?,
      inputDate: json['inputDate'] as String?,
      locationRegion: json['locationRegion'] == null
          ? null
          : Organisation.fromJson(
              json['locationRegion'] as Map<String, dynamic>),
      typeOfAsset: json['typeOfAsset'] as int?,
      typeOfArticle: json['typeOfArticle'] == null
          ? null
          : Organisation.fromJson(
              json['typeOfArticle'] as Map<String, dynamic>),
      foundDate: json['foundDate'] as String?,
      foundLocation: json['foundLocation'] as String?,
      additionalInformation: json['additionalInformation'] as String?,
      quantity: json['quantity'] as int?,
      color: json['color'] as String?,
      claimantSign: json['claimantSign'] == null
          ? null
          : ImageContent.fromJson(json['claimantSign'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ImageContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      depositorDbEmp: json['depositorDbEmp'] as bool?,
      depositor: json['depositor'] == null
          ? null
          : User.fromJson(json['depositor'] as Map<String, dynamic>),
      employeeId: json['employeeId'] as String?,
      depositorDepartment: json['depositorDepartment'] == null
          ? null
          : Organisation.fromJson(
              json['depositorDepartment'] as Map<String, dynamic>),
      claimantDbEmp: json['claimantDbEmp'] as bool?,
      claimantConfirmByEmail: json['claimantConfirmByEmail'] as bool?,
      claimant: json['claimant'] == null
          ? null
          : User.fromJson(json['claimant'] as Map<String, dynamic>),
      claimantNoSign: json['claimantNoSign'] as bool?,
      claimantEmployeeId: json['claimantEmployeeId'] as String?,
      claimantDepartment: json['claimantDepartment'] == null
          ? null
          : Organisation.fromJson(
              json['claimantDepartment'] as Map<String, dynamic>),
      handoverDate: json['handoverDate'] as String?,
      entrySecurity: json['entrySecurity'] == null
          ? null
          : User.fromJson(json['entrySecurity'] as Map<String, dynamic>),
      handoverSecurity: json['handoverSecurity'] == null
          ? null
          : User.fromJson(json['handoverSecurity'] as Map<String, dynamic>),
      status: json['status'] as int?,
      modifiedDate: json['modifiedDate'] as String?,
      modifiedBy: json['modifiedBy'] as String?,
      depositorName: json['depositorName'] as String?,
      claimantName: json['claimantName'] as String?,
      locationName: json['locationName'] as String?,
      entrySecurityName: json['entrySecurityName'] as String?,
      handOverSecurityName: json['handOverSecurityName'] as String?,
      depositorDepartmentName: json['depositorDepartmentName'] as String?,
      claimantDepartmentName: json['claimantDepartmentName'] as String?,
      location: json['location'] == null
          ? null
          : Organisation.fromJson(json['location'] as Map<String, dynamic>),
      lock: json['lock'] as String?,
    )..eventProtection = json['eventProtection'] as int?;

Map<String, dynamic> _$FoundListArticleDetailsToJson(
        FoundListArticleDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slNo': instance.slNo,
      'eventProtection': instance.eventProtection,
      'inputDate': instance.inputDate,
      'locationRegion': instance.locationRegion,
      'typeOfAsset': instance.typeOfAsset,
      'typeOfArticle': instance.typeOfArticle,
      'foundDate': instance.foundDate,
      'foundLocation': instance.foundLocation,
      'additionalInformation': instance.additionalInformation,
      'quantity': instance.quantity,
      'color': instance.color,
      'images': instance.images,
      'depositorDbEmp': instance.depositorDbEmp,
      'depositor': instance.depositor,
      'employeeId': instance.employeeId,
      'depositorDepartment': instance.depositorDepartment,
      'claimantDbEmp': instance.claimantDbEmp,
      'claimantConfirmByEmail': instance.claimantConfirmByEmail,
      'claimant': instance.claimant,
      'claimantNoSign': instance.claimantNoSign,
      'claimantSign': instance.claimantSign,
      'claimantEmployeeId': instance.claimantEmployeeId,
      'claimantDepartment': instance.claimantDepartment,
      'handoverDate': instance.handoverDate,
      'entrySecurity': instance.entrySecurity,
      'handoverSecurity': instance.handoverSecurity,
      'status': instance.status,
      'modifiedDate': instance.modifiedDate,
      'modifiedBy': instance.modifiedBy,
      'depositorName': instance.depositorName,
      'claimantName': instance.claimantName,
      'locationName': instance.locationName,
      'entrySecurityName': instance.entrySecurityName,
      'handOverSecurityName': instance.handOverSecurityName,
      'depositorDepartmentName': instance.depositorDepartmentName,
      'claimantDepartmentName': instance.claimantDepartmentName,
      'location': instance.location,
      'lock': instance.lock,
    };
