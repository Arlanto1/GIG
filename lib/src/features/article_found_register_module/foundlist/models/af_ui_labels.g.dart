// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'af_ui_labels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AFUiLabels _$AFUiLabelsFromJson(Map<String, dynamic> json) => AFUiLabels(
      defaultLocale:
          AFUiLabelsLocale.fromJson(json['default'] as Map<String, dynamic>),
      locale: AFUiLabelsLocale.fromJson(json['locale'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AFUiLabelsToJson(AFUiLabels instance) =>
    <String, dynamic>{
      'locale': instance.locale,
      'default': instance.defaultLocale,
    };

AFUiLabelsLocale _$AFUiLabelsLocaleFromJson(Map<String, dynamic> json) =>
    AFUiLabelsLocale(
      json['com.arlanto.atom.found.additionalInformation'] as String?,
      json['com.arlanto.atom.found.locationRegion'] as String?,
      json['com.arlanto.atom.found.quantity'] as String?,
      json['com.arlanto.atom.found.entrySecurity'] as String?,
      json['com.arlanto.atom.found.location'] as String?,
      json['com.arlanto.atom.found.depositorDepartment'] as String?,
      json['com.arlanto.atom.found.department'] as String?,
      json['com.arlanto.atom.found.handoverSecurity'] as String?,
      json['com.arlanto.atom.found.status.handover'] as String?,
      json['com.arlanto.atom.found.handoverDate'] as String?,
      json['com.arlanto.atom.found.typeOfAsset.personal'] as String?,
      json['com.arlanto.atom.found.claimantEmployeeId'] as String?,
      json['com.arlanto.atom.found.claimantName'] as String?,
      json['com.arlanto.atom.found.depositor'] as String?,
      json['com.arlanto.atom.found.foundLocation'] as String?,
      json['com.arlanto.atom.found.typeOfArticle'] as String?,
      json['com.arlanto.atom.found.depositorName'] as String?,
      json['com.arlanto.atom.found.claimant'] as String?,
      json['com.arlanto.atom.found.color'] as String?,
      json['com.arlanto.atom.found.eventProtection'] as String?,
      json['com.arlanto.atom.found.inputDate'] as String?,
      json['com.arlanto.atom.found.depositorEmail'] as String?,
      json['com.arlanto.atom.found.claimantSign'] as String?,
      json['com.arlanto.atom.found.status.found'] as String?,
      json['com.arlanto.atom.found.foundDate'] as String?,
      json['com.arlanto.atom.found.employeeId'] as String?,
      json['com.arlanto.atom.found.depositorDbEmp'] as String?,
      json['com.arlanto.atom.found.slNo'] as String?,
      json['com.arlanto.atom.found.typeOfAsset.company'] as String?,
      json['com.arlanto.atom.found.claimantDbEmp'] as String?,
      json['com.arlanto.atom.found.claimantNoSign'] as String?,
      json['com.arlanto.atom.found.status'] as String?,
      json['com.arlanto.atom.found.rejectionComment'] as String?,
      json['com.arlanto.atom.found.entity'] as String?,
      json['com.arlanto.atom.found.typeOfAsset'] as String?,
      json['com.arlanto.atom.found.claimantEmail'] as String?,
      json['com.arlanto.atom.found.claimantDepartment'] as String?,
      json['com.arlanto.atom.found.status.securityCustody'] as String?,
      json['com.arlanto.atom.found.claimantConfirmByEmail'] as String?,
    );

Map<String, dynamic> _$AFUiLabelsLocaleToJson(AFUiLabelsLocale instance) =>
    <String, dynamic>{
      'com.arlanto.atom.found.additionalInformation':
          instance.foundAdditionalInformation,
      'com.arlanto.atom.found.locationRegion': instance.foundLocationRegion,
      'com.arlanto.atom.found.quantity': instance.foundQuantity,
      'com.arlanto.atom.found.entrySecurity': instance.foundEntrySecurity,
      'com.arlanto.atom.found.location': instance.foundLocation,
      'com.arlanto.atom.found.depositorDepartment':
          instance.foundDepositorDepartment,
      'com.arlanto.atom.found.department': instance.foundEmployeeDepartment,
      'com.arlanto.atom.found.handoverSecurity': instance.foundHandoverSecurity,
      'com.arlanto.atom.found.status.handover': instance.foundStatusHandover,
      'com.arlanto.atom.found.handoverDate': instance.foundHandoverDate,
      'com.arlanto.atom.found.typeOfAsset.personal':
          instance.foundTypeOfAssetPersonal,
      'com.arlanto.atom.found.claimantEmployeeId':
          instance.foundClaimantEmployeeId,
      'com.arlanto.atom.found.claimantName': instance.foundClaimantName,
      'com.arlanto.atom.found.depositor': instance.foundDepositor,
      'com.arlanto.atom.found.foundLocation': instance.foundFoundLocation,
      'com.arlanto.atom.found.typeOfArticle': instance.foundTypeOfArticle,
      'com.arlanto.atom.found.depositorName': instance.foundDepositorName,
      'com.arlanto.atom.found.claimant': instance.foundClaimant,
      'com.arlanto.atom.found.color': instance.foundColor,
      'com.arlanto.atom.found.eventProtection': instance.foundEventProtection,
      'com.arlanto.atom.found.inputDate': instance.foundInputDate,
      'com.arlanto.atom.found.depositorEmail': instance.foundDepositorEmail,
      'com.arlanto.atom.found.claimantSign': instance.foundClaimantSign,
      'com.arlanto.atom.found.status.found': instance.foundStatusFound,
      'com.arlanto.atom.found.foundDate': instance.foundFoundDate,
      'com.arlanto.atom.found.employeeId': instance.foundEmployeeId,
      'com.arlanto.atom.found.depositorDbEmp': instance.foundDepositorDbEmp,
      'com.arlanto.atom.found.slNo': instance.foundSlNo,
      'com.arlanto.atom.found.typeOfAsset.company':
          instance.foundTypeOfAssetCompany,
      'com.arlanto.atom.found.claimantDbEmp': instance.foundClaimantDbEmp,
      'com.arlanto.atom.found.claimantNoSign': instance.foundClaimantNoSign,
      'com.arlanto.atom.found.status': instance.foundStatus,
      'com.arlanto.atom.found.rejectionComment': instance.foundRejectionComment,
      'com.arlanto.atom.found.entity': instance.foundEntity,
      'com.arlanto.atom.found.typeOfAsset': instance.foundTypeOfAsset,
      'com.arlanto.atom.found.claimantEmail': instance.foundClaimantEmail,
      'com.arlanto.atom.found.claimantDepartment':
          instance.foundClaimantDepartment,
      'com.arlanto.atom.found.status.securityCustody':
          instance.foundStatusSecurityCustody,
      'com.arlanto.atom.found.claimantConfirmByEmail':
          instance.foundClaimantConfirmByEmail,
    };
