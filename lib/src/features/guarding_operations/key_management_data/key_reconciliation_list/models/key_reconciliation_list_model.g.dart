// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'key_reconciliation_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KeyReconciliationListModel _$KeyReconciliationListModelFromJson(
        Map<String, dynamic> json) =>
    KeyReconciliationListModel(
      id: (json['id'] as num?)?.toInt(),
      slNo: json['slNo'] as String?,
      location: json['location'] == null
          ? null
          : Organisation.fromJson(json['location'] as Map<String, dynamic>),
      locationRegion: json['locationRegion'] == null
          ? null
          : Organisation.fromJson(
              json['locationRegion'] as Map<String, dynamic>),
      entrySecurity: json['entrySecurity'] == null
          ? null
          : User.fromJson(json['entrySecurity'] as Map<String, dynamic>),
      guard: json['guard'] == null
          ? null
          : User.fromJson(json['guard'] as Map<String, dynamic>),
      localAddressProof: json['localAddressProof'] == null
          ? null
          : ImageContent.fromJson(
              json['localAddressProof'] as Map<String, dynamic>),
      permanentAddressProof: json['permanentAddressProof'] == null
          ? null
          : ImageContent.fromJson(
              json['permanentAddressProof'] as Map<String, dynamic>),
      bopData: json['bopData'] == null
          ? null
          : ImageContent.fromJson(json['bopData'] as Map<String, dynamic>),
      photoGraph: json['photoGraph'] == null
          ? null
          : ImageContent.fromJson(json['photoGraph'] as Map<String, dynamic>),
      entity: json['entity'] == null
          ? null
          : Organisation.fromJson(json['entity'] as Map<String, dynamic>),
      inputDate: json['inputDate'] as String?,
      msgbExemptionDate: json['msgbExemptionDate'] as String?,
      csrParticipationDates: json['csrParticipationDates'] as String?,
      medicalCertificateValidUntil:
          json['medicalCertificateValidUntil'] as String?,
      covidFirstDoseDate: json['covidFirstDoseDate'] as String?,
      covidSecondDoseDate: json['covidSecondDoseDate'] as String?,
      covidPrecautionaryDoseDate: json['covidPrecautionaryDoseDate'] as String?,
      ertCertificationDate: json['ertCertificationDate'] as String?,
      firstAidTrainingCompletionDate:
          json['firstAidTrainingCompletionDate'] as String?,
      pvcExpiryDate: json['pvcExpiryDate'] as String?,
      pvcIssuedDate: json['pvcIssuedDate'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      dateOfJoining: json['dateOfJoining'] as String?,
      status: (json['status'] as num?)?.toInt(),
      height: json['height'] as num?,
      weight: json['weight'] as num?,
      chest: json['chest'] as num?,
      guardRank: (json['guardRank'] as num?)?.toInt(),
      employeeCode: json['employeeCode'] as String?,
      dbEmployeeId: json['dbEmployeeId'] as String?,
      vendor: json['vendor'] == null
          ? null
          : Organisation.fromJson(json['vendor'] as Map<String, dynamic>),
      dutyType: (json['dutyType'] as num?)?.toInt(),
      gender: (json['gender'] as num?)?.toInt(),
      contactNo: json['contactNo'] as String?,
      dependentsNo: (json['dependentsNo'] as num?)?.toInt(),
      maritalStatus: (json['maritalStatus'] as num?)?.toInt(),
      typeOfDeployment: (json['typeOfDeployment'] as num?)?.toInt(),
      deploymentOrderSubmitted:
          json['deploymentOrderSubmitted'] as bool? ?? false,
      deploymentOrders: (json['deploymentOrders'] as List<dynamic>?)
          ?.map((e) => ImageContent.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      pvc: (json['pvc'] as List<dynamic>?)
          ?.map((e) => ImageContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      trainingCertificateProvided:
          json['trainingCertificateProvided'] as bool? ?? false,
      trainingCertificates: (json['trainingCertificates'] as List<dynamic>?)
          ?.map((e) => ImageContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      medicalCertificates: (json['medicalCertificates'] as List<dynamic>?)
          ?.map((e) => ImageContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      systemAccess: (json['systemAccess'] as num?)?.toInt(),
      onboarded: json['onboarded'] as bool? ?? false,
      esicNo: json['esicNo'] as String?,
      uanNo: json['uanNo'] as String?,
      msgbExempted: json['msgbExempted'] as bool? ?? false,
      msgbFormBSubmitted: (json['msgbFormBSubmitted'] as num?)?.toInt(),
      staffMsgbCompliant: (json['staffMsgbCompliant'] as num?)?.toInt(),
      csrParticipation: json['csrParticipation'] as bool? ?? false,
      specialAchievement: json['specialAchievement'] as bool? ?? false,
      specialAchievementText: json['specialAchievementText'] as String?,
      additionalInitiatives: json['additionalInitiatives'] as String?,
      history: json['history'] as List<dynamic>?,
      guardingPOC: json['guardingPOC'] as String?,
    )..lock = json['lock'] as String?;

Map<String, dynamic> _$KeyReconciliationListModelToJson(
        KeyReconciliationListModel instance) =>
    <String, dynamic>{
      'lock': instance.lock,
      'id': instance.id,
      'slNo': instance.slNo,
      'location': instance.location,
      'locationRegion': instance.locationRegion,
      'vendor': instance.vendor,
      'entrySecurity': instance.entrySecurity,
      'guard': instance.guard,
      'localAddressProof': instance.localAddressProof,
      'permanentAddressProof': instance.permanentAddressProof,
      'bopData': instance.bopData,
      'photoGraph': instance.photoGraph,
      'entity': instance.entity,
      'inputDate': instance.inputDate,
      'msgbExemptionDate': instance.msgbExemptionDate,
      'csrParticipationDates': instance.csrParticipationDates,
      'medicalCertificateValidUntil': instance.medicalCertificateValidUntil,
      'covidFirstDoseDate': instance.covidFirstDoseDate,
      'covidSecondDoseDate': instance.covidSecondDoseDate,
      'covidPrecautionaryDoseDate': instance.covidPrecautionaryDoseDate,
      'ertCertificationDate': instance.ertCertificationDate,
      'firstAidTrainingCompletionDate': instance.firstAidTrainingCompletionDate,
      'pvcIssuedDate': instance.pvcIssuedDate,
      'pvcExpiryDate': instance.pvcExpiryDate,
      'dateOfBirth': instance.dateOfBirth,
      'dateOfJoining': instance.dateOfJoining,
      'status': instance.status,
      'height': instance.height,
      'weight': instance.weight,
      'chest': instance.chest,
      'guardRank': instance.guardRank,
      'employeeCode': instance.employeeCode,
      'dbEmployeeId': instance.dbEmployeeId,
      'dutyType': instance.dutyType,
      'gender': instance.gender,
      'contactNo': instance.contactNo,
      'dependentsNo': instance.dependentsNo,
      'maritalStatus': instance.maritalStatus,
      'typeOfDeployment': instance.typeOfDeployment,
      'deploymentOrderSubmitted': instance.deploymentOrderSubmitted,
      'deploymentOrders': instance.deploymentOrders,
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
      'pvc': instance.pvc,
      'trainingCertificateProvided': instance.trainingCertificateProvided,
      'trainingCertificates': instance.trainingCertificates,
      'medicalCertificates': instance.medicalCertificates,
      'systemAccess': instance.systemAccess,
      'onboarded': instance.onboarded,
      'esicNo': instance.esicNo,
      'uanNo': instance.uanNo,
      'msgbExempted': instance.msgbExempted,
      'msgbFormBSubmitted': instance.msgbFormBSubmitted,
      'staffMsgbCompliant': instance.staffMsgbCompliant,
      'csrParticipation': instance.csrParticipation,
      'specialAchievement': instance.specialAchievement,
      'specialAchievementText': instance.specialAchievementText,
      'additionalInitiatives': instance.additionalInitiatives,
      'history': instance.history,
      'guardingPOC': instance.guardingPOC,
    };
