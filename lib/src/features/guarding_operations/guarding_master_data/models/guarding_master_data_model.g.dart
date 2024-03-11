// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guarding_master_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuardingMastersDataModel _$GuardingMastersDataModelFromJson(
        Map<String, dynamic> json) =>
    GuardingMastersDataModel(
      id: json['id'] as int?,
      slNo: json['slNo'] as String?,
      location: json['location'] == null
          ? null
          : Organisation.fromJson(json['location'] as Map<String, dynamic>),
      locationRegion: json['locationRegion'] == null
          ? null
          : Organisation.fromJson(
              json['locationRegion'] as Map<String, dynamic>),
      vendor: json['vendor'] == null
          ? null
          : Organisation.fromJson(json['vendor'] as Map<String, dynamic>),
      guard: json['guard'] == null
          ? null
          : User.fromJson(json['guard'] as Map<String, dynamic>),
      entity: json['entity'] == null
          ? null
          : Organisation.fromJson(json['entity'] as Map<String, dynamic>),
      entrySecurity: json['entrySecurity'] == null
          ? null
          : User.fromJson(json['entrySecurity'] as Map<String, dynamic>),
      inputDate: json['inputDate'] as String?,
      status: json['status'] as int?,
      guardRank: json['guardRank'] as int?,
      localAddressProof: json['localAddressProof'] == null
          ? null
          : ImageContent.fromJson(
              json['localAddressProof'] as Map<String, dynamic>),
      permanentAddressProof: json['permanentAddressProof'] == null
          ? null
          : ImageContent.fromJson(
              json['permanentAddressProof'] as Map<String, dynamic>),
      bioData: json['bioData'] == null
          ? null
          : ImageContent.fromJson(json['bioData'] as Map<String, dynamic>),
      photoGraph: json['photoGraph'] == null
          ? null
          : ImageContent.fromJson(json['photoGraph'] as Map<String, dynamic>),
      employeeCode: json['employeeCode'] as String?,
      dbEmployeeId: json['dbEmployeeId'] as String?,
      dutyType: json['dutyType'] as int?,
      gender: json['gender'] as int?,
      contactNo: json['contactNo'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      maritalStatus: json['maritalStatus'] as int?,
      typeOfDeployment: json['typeOfDeployment'] as int?,
      deploymentOrderSubmitted:
          json['deploymentOrderSubmitted'] as bool? ?? false,
      deploymentOrders: (json['deploymentOrders'] as List<dynamic>?)
          ?.map((e) => ImageContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      dateOfJoining: json['dateOfJoining'] as String?,
      physicallyFit: json['physicallyFit'] as bool? ?? false,
      localLanguage: json['localLanguage'] as String?,
      localLangProficiencyR: json['localLangProficiencyR'] as bool?,
      hindiLangProficiencyR: json['hindiLangProficiencyR'] as bool?,
      englishLangProficiencyR: json['englishLangProficiencyR'] as bool?,
      localLangProficiencyW: json['localLangProficiencyW'] as bool?,
      hindiLangProficiencyW: json['hindiLangProficiencyW'] as bool?,
      englishLangProficiencyW: json['englishLangProficiencyW'] as bool?,
      localLangProficiencyS: json['localLangProficiencyS'] as bool?,
      hindiLangProficiencyS: json['hindiLangProficiencyS'] as bool?,
      englishLangProficiencyS: json['englishLangProficiencyS'] as bool?,
      securityExperience: json['securityExperience'] as String?,
      permanentAddress: json['permanentAddress'] as String?,
      localAddress: json['localAddress'] as String?,
      qualifications: (json['qualifications'] as List<dynamic>?)
          ?.map((e) => Organisation.fromJson(e as Map<String, dynamic>))
          .toList(),
      pvcIssuedDate: json['pvcIssuedDate'] as String?,
      pvcExpiryDate: json['pvcExpiryDate'] as String?,
      pvc: (json['pvc'] as List<dynamic>?)
          ?.map((e) => ImageContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      trainingCertificateProvided:
          json['trainingCertificateProvided'] as bool? ?? false,
      trainingCertificates: (json['trainingCertificates'] as List<dynamic>?)
          ?.map((e) => ImageContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      medicalCertificateValidUntil:
          json['medicalCertificateValidUntil'] as String?,
      medicalCertificates: (json['medicalCertificates'] as List<dynamic>?)
          ?.map((e) => ImageContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      systemAccess: json['systemAccess'] as int?,
      onboarded: json['onboarded'] as bool? ?? false,
      esicNo: json['esicNo'] as String?,
      uanNo: json['uanNo'] as String?,
      msgbExempted: json['msgbExempted'] as bool? ?? false,
      msgbFormBSubmitted: json['msgbFormBSubmitted'] as int?,
      staffMsgbCompliant: json['staffMsgbCompliant'] as int?,
      guardingPOC: json['guardingPOC'] as String?,
      csrParticipations: (json['csrParticipations'] as List<dynamic>?)
          ?.map((e) => GuardingMasterDataExtraDetails.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      additionalInitiatives: (json['additionalInitiatives'] as List<dynamic>?)
          ?.map((e) => GuardingMasterDataExtraDetails.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      additionalQualifications:
          (json['additionalQualifications'] as List<dynamic>?)
              ?.map((e) => GuardingMasterDataExtraDetails.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
      specialAchievements: (json['specialAchievements'] as List<dynamic>?)
          ?.map((e) => GuardingMasterDataExtraDetails.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      entrySecurityName: json['entrySecurityName'] as String?,
      guardName: json['guardName'] as String?,
      covidFirstDoseDate: json['covidFirstDoseDate'] as String?,
      covidSecondDoseDate: json['covidSecondDoseDate'] as String?,
      covidPrecautionaryDoseDate: json['covidPrecautionaryDoseDate'] as String?,
      ertCertificationDate: json['ertCertificationDate'] as String?,
      firstAidTrainingCompletionDate:
          json['firstAidTrainingCompletionDate'] as String?,
      height: json['height'] as num?,
      weight: json['weight'] as num?,
      chest: json['chest'] as num?,
      dependentsNo: json['dependentsNo'] as int?,
      msgbExemptionDate: json['msgbExemptionDate'] as String?,
    )..lock = json['lock'] as String?;

Map<String, dynamic> _$GuardingMastersDataModelToJson(
        GuardingMastersDataModel instance) =>
    <String, dynamic>{
      'lock': instance.lock,
      'id': instance.id,
      'slNo': instance.slNo,
      'location': instance.location,
      'locationRegion': instance.locationRegion,
      'vendor': instance.vendor,
      'entrySecurity': instance.entrySecurity,
      'guard': instance.guard,
      'entity': instance.entity,
      'inputDate': instance.inputDate,
      'status': instance.status,
      'guardRank': instance.guardRank,
      'localAddressProof': instance.localAddressProof,
      'permanentAddressProof': instance.permanentAddressProof,
      'bioData': instance.bioData,
      'photoGraph': instance.photoGraph,
      'employeeCode': instance.employeeCode,
      'dbEmployeeId': instance.dbEmployeeId,
      'dutyType': instance.dutyType,
      'gender': instance.gender,
      'height': instance.height,
      'weight': instance.weight,
      'chest': instance.chest,
      'contactNo': instance.contactNo,
      'dateOfBirth': instance.dateOfBirth,
      'maritalStatus': instance.maritalStatus,
      'typeOfDeployment': instance.typeOfDeployment,
      'deploymentOrderSubmitted': instance.deploymentOrderSubmitted,
      'deploymentOrders': instance.deploymentOrders,
      'dateOfJoining': instance.dateOfJoining,
      'physicallyFit': instance.physicallyFit,
      'localLanguage': instance.localLanguage,
      'localLangProficiencyR': instance.localLangProficiencyR,
      'hindiLangProficiencyR': instance.hindiLangProficiencyR,
      'englishLangProficiencyR': instance.englishLangProficiencyR,
      'localLangProficiencyW': instance.localLangProficiencyW,
      'hindiLangProficiencyW': instance.hindiLangProficiencyW,
      'englishLangProficiencyW': instance.englishLangProficiencyW,
      'localLangProficiencyS': instance.localLangProficiencyS,
      'hindiLangProficiencyS': instance.hindiLangProficiencyS,
      'englishLangProficiencyS': instance.englishLangProficiencyS,
      'securityExperience': instance.securityExperience,
      'permanentAddress': instance.permanentAddress,
      'localAddress': instance.localAddress,
      'qualifications': instance.qualifications,
      'pvcIssuedDate': instance.pvcIssuedDate,
      'pvcExpiryDate': instance.pvcExpiryDate,
      'pvc': instance.pvc,
      'trainingCertificateProvided': instance.trainingCertificateProvided,
      'trainingCertificates': instance.trainingCertificates,
      'medicalCertificateValidUntil': instance.medicalCertificateValidUntil,
      'medicalCertificates': instance.medicalCertificates,
      'covidFirstDoseDate': instance.covidFirstDoseDate,
      'covidSecondDoseDate': instance.covidSecondDoseDate,
      'covidPrecautionaryDoseDate': instance.covidPrecautionaryDoseDate,
      'ertCertificationDate': instance.ertCertificationDate,
      'firstAidTrainingCompletionDate': instance.firstAidTrainingCompletionDate,
      'systemAccess': instance.systemAccess,
      'onboarded': instance.onboarded,
      'esicNo': instance.esicNo,
      'uanNo': instance.uanNo,
      'msgbExempted': instance.msgbExempted,
      'msgbFormBSubmitted': instance.msgbFormBSubmitted,
      'staffMsgbCompliant': instance.staffMsgbCompliant,
      'guardingPOC': instance.guardingPOC,
      'csrParticipations': instance.csrParticipations,
      'additionalInitiatives': instance.additionalInitiatives,
      'additionalQualifications': instance.additionalQualifications,
      'specialAchievements': instance.specialAchievements,
      'entrySecurityName': instance.entrySecurityName,
      'guardName': instance.guardName,
      'dependentsNo': instance.dependentsNo,
      'msgbExemptionDate': instance.msgbExemptionDate,
    };
