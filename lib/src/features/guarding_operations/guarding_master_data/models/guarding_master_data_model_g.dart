part of 'guarding_master_data_model.dart';

GuardingMastersDataModel _$GuardingMastersDataModelFromJson(
        Map<String, dynamic> json) =>
    GuardingMastersDataModel(
      id: json['id'] as int?,
      slNo: json['slNo'] as String?,
      location: (json['location'] as Map<String, dynamic>?) != null
          ? Organisation.fromJson(json['location'] as Map<String, dynamic>)
          : null,
      locationRegion: (json['locationRegion'] as Map<String, dynamic>?) != null
          ? Organisation.fromJson(
              json['locationRegion'] as Map<String, dynamic>)
          : null,
      entrySecurity: (json['entrySecurity'] as Map<String, dynamic>?) != null
          ? User.fromJson(json['entrySecurity'] as Map<String, dynamic>)
          : null,
      guard: (json['guard'] as Map<String, dynamic>?) != null
          ? User.fromJson(json['guard'] as Map<String, dynamic>)
          : null,
      localAddressProof:
          (json['localAddressProof'] as Map<String, dynamic>?) != null
              ? ImageContent.fromJson(
                  json['localAddressProof'] as Map<String, dynamic>)
              : null,
      permanentAddressProof:
          (json['permanentAddressProof'] as Map<String, dynamic>?) != null
              ? ImageContent.fromJson(
                  json['permanentAddressProof'] as Map<String, dynamic>)
              : null,
      bopData: (json['bopData'] as Map<String, dynamic>?) != null
          ? ImageContent.fromJson(json['bopData'] as Map<String, dynamic>)
          : null,
      photoGraph: (json['photoGraph'] as Map<String, dynamic>?) != null
          ? ImageContent.fromJson(json['photoGraph'] as Map<String, dynamic>)
          : null,
      entity: (json['entity'] as Map<String, dynamic>?) != null
          ? Organisation.fromJson(json['entity'] as Map<String, dynamic>)
          : null,
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
      pvcIssuedDate: json['pvcIssuedDate'] as String?,
      pvcExpiryDate: json['pvcExpiryDate'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      dateOfJoining: json['dateOfJoining'] as String?,
      vendor: (json['vendor'] as Map<String, dynamic>?) != null
          ? Organisation.fromJson(json['vendor'] as Map<String, dynamic>)
          : null,
      status: json['status'] as int?,
      guardRank: json['guardRank'] as int?,
      employeeCode: json['employeeCode'] as String?,
      dbEmployeeId: json['dbEmployeeId'] as String?,
      height: json['height'] as num?,
      weight: json['weight'] as num?,
      chest: json['chest'] as num?,
      dutyType: json['dutyType'] as int?,
      gender: json['gender'] as int?,
      contactNo: json['contactNo'] as String?,
      dependentsNo: json['dependentsNo'] as int?,
      maritalStatus: json['maritalStatus'] as int?,
      typeOfDeployment: json['typeOfDeployment'] as int?,
      deploymentOrderSubmitted: json['deploymentOrderSubmitted'],
      deploymentOrders: (json['deploymentOrders'] as List?)
          ?.map((dynamic e) => ImageContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      physicallyFit: json['physicallyFit'],
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
      qualifications: (json['qualifications'] as List?)
          ?.map((dynamic e) => Organisation.fromJson(e as Map<String, dynamic>))
          .toList(),
      pvc: (json['pvc'] as List?)
          ?.map((dynamic e) => ImageContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      trainingCertificateProvided: json['trainingCertificateProvided'],
      trainingCertificates: (json['trainingCertificates'] as List?)
          ?.map((dynamic e) => ImageContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      medicalCertificates: (json['medicalCertificates'] as List?)
          ?.map((dynamic e) => ImageContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      systemAccess: json['systemAccess'] as int?,
      onboarded: json['onboarded'],
      esicNo: json['esicNo'] as String?,
      uanNo: json['uanNo'] as String?,
      msgbExempted: json['msgbExempted'] as bool,
      msgbFormBSubmitted: json['msgbFormBSubmitted'] as int?,
      staffMsgbCompliant: json['staffMsgbCompliant'] as int?,
      csrParticipation: json['csrParticipation'],
      specialAchievement: json['specialAchievement'],
      specialAchievementText: json['specialAchievementText'] as String?,
      additionalInitiatives: json['additionalInitiatives'] as String?,
      history: json['history'] as List?,
      guardingPOC: json['guardingPOC'] as String?,
    )..lock = json['lock'] as String?;

Map<String, dynamic> _$GuardingMastersDataModelToJson(
        GuardingMastersDataModel instance) =>
    <String, dynamic>{
      'lock': instance.lock,
      'id': instance.id,
      'slNo': instance.slNo,
      'location': instance.location?.toJson(),
      'locationRegion': instance.locationRegion?.toJson(),
      'entrySecurity': instance.entrySecurity?.toJson(),
      'guard': instance.guard?.toJson(),
      'inputDate': instance.inputDate,
      'msgbExemptionDate': instance.msgbExemptionDate,
      'vendor': instance.vendor?.toJson(),
      'qualifications': instance.qualifications,
      'bopData': instance.bopData?.toJson(),
      'localAddressProof': instance.localAddressProof?.toJson(),
      'permanentAddressProof': instance.permanentAddressProof?.toJson(),
      'photoGraph': instance.photoGraph?.toJson(),
      'entity': instance.entity?.toJson(),
      'csrParticipationDates': instance.csrParticipationDates,
      'medicalCertificateValidUntil': instance.medicalCertificateValidUntil,
      'covidFirstDoseDate': instance.covidFirstDoseDate,
      'covidSecondDoseDate': instance.covidSecondDoseDate,
      'covidPrecautionaryDoseDate': instance.covidPrecautionaryDoseDate,
      'ertCertificationDate': instance.ertCertificationDate,
      'firstAidTrainingCompletionDate': instance.firstAidTrainingCompletionDate,
      'pvcExpiryDate': instance.pvcExpiryDate,
      'pvcIssuedDate': instance.pvcIssuedDate,
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
      'guardingPOC': instance.guardingPOC
    };
