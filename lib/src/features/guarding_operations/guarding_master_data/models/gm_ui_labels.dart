import 'package:db_atom/index.dart';

part 'gm_ui_labels.g.dart';

@JsonSerializable()
class GmUiLabels {
  GmUiLabels({
    required this.defaultLocale,
    required this.locale,
  });

  factory GmUiLabels.fromJson(Map<String, dynamic> json) =>
      _$GmUiLabelsFromJson(json);

  Map<String, dynamic> toJson() => _$GmUiLabelsToJson(this);

  @JsonKey(name: 'locale')
  final GmUiLabelsLocale locale;
  @JsonKey(name: 'default')
  final GmUiLabelsLocale defaultLocale;
}

@JsonSerializable()
class GmUiLabelsLocale {
  @JsonKey(name: 'com.arlanto.atom.guardingMaster.slNo')
  final String? slNo;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.location')
  final String? location;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.locationRegion')
  final String? locationRegion;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.inputDate')
  final String? inputDate;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.dependentsNo')
  final String? dependentsNo;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.entrySecurity')
  final String? entrySecurity;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.guardId')
  final String? guard;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.localAddressProof')
  final String? localAddressProof;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.permanentAddressProof')
  final String? permanentAddressProof;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.bioData')
  final String? bopData;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.photoGraph')
  final String? photoGraph;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.entity')
  final String? entity;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.csrParticipationDates')
  final String? csrParticipationDates;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.medicalCertificateValidUntil')
  final String? medicalCertificateValidUntil;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.systemAccess')
  final String? systemAccess;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.hindiLangProficiency')
  final String? hindiLangProficiency;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.localLangProficiency')
  final String? localLangProficiency;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.englishLangProficiency')
  final String? englishLangProficiency;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.dutyType')
  final String? dutyType;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.covidFirstDoseDate')
  final String? covidFirstDoseDate;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.covidSecondDoseDate')
  final String? covidSecondDoseDate;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.covidPrecautionaryDoseDate')
  final String? covidPrecautionaryDoseDate;

  @JsonKey(
      name: 'com.arlanto.atom.guardingMaster.firstAidTrainingCompletionDate')
  final String? firstAidTrainingCompletionDate;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.ertCertificationDate')
  final String? ertCertificationDate;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.pvcExpiryDate')
  final String? pvcExpiryDate;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.pvcIssuedDate')
  final String? pvcIssuedDate;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.dateOfBirth')
  final String? dateOfBirth;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.dateOfJoining')
  final String? dateOfJoining;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.status')
  final String? status;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.height')
  final String? height;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.weight')
  final String? weight;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.chest')
  final String? chest;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.rank')
  final String? guardRank;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.employeeCode')
  final String? employeeCode;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.dbEmployeeId')
  final String? dbEmployeeId;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.vendor')
  final String? vendor;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.gender')
  final String? gender;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.contactNo')
  final String? contactNo;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.staffMsgbCompliant')
  final String? staffMsgbCompliant;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.medicalCertificates')
  final String? medicalCertificates;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.maritalStatus')
  final String? maritalStatus;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.typeOfDeployment')
  final String? typeOfDeployment;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.deploymentOrders')
  final String? deploymentOrders;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.physicallyFit')
  final String? physicallyFit;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.localLanguage')
  final String? localLanguage;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.securityExperience')
  final String? securityExperience;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.permanentAddress')
  final String? permanentAddress;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.localAddress')
  final String? localAddress;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.trainingCertificateProvided')
  final String? trainingCertificateProvided;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.pvc')
  final String? pvc;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.qualifications')
  final String? qualifications;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.deploymentOrderSubmitted')
  final String? deploymentOrderSubmitted;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.trainingCertificates')
  final String? trainingCertificates;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.onboarded')
  final String? onboarded;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.esicNo')
  final String? esicNo;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.uanNo')
  final String? uanNo;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.msgbExempted')
  final String? msgbExempted;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.msgbExemptionDate')
  final String? msgbExemptionDate;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.msgbFormBSubmitted')
  final String? msgbFormBSubmitted;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.specialAchievement')
  final String? specialAchievement;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.csrParticipation')
  final String? csrParticipation;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.specialAchievementText')
  final String? specialAchievementText;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.additionalInitiatives')
  final String? additionalInitiatives;

  @JsonKey(name: 'com.arlanto.atom.guardingMaster.guardingPOC')
  final String? guardingPOC;

  GmUiLabelsLocale(
    this.slNo,
    this.location,
    this.locationRegion,
    this.entrySecurity,
    this.guard,
    this.localAddressProof,
    this.permanentAddressProof,
    this.bopData,
    this.photoGraph,
    this.entity,
    this.inputDate,
    this.msgbExemptionDate,
    this.csrParticipationDates,
    this.medicalCertificateValidUntil,
    this.covidFirstDoseDate,
    this.covidSecondDoseDate,
    this.covidPrecautionaryDoseDate,
    this.ertCertificationDate,
    this.firstAidTrainingCompletionDate,
    this.pvcExpiryDate,
    this.pvcIssuedDate,
    this.dateOfBirth,
    this.dateOfJoining,
    this.status,
    this.height,
    this.weight,
    this.chest,
    this.guardRank,
    this.employeeCode,
    this.dbEmployeeId,
    this.vendor,
    this.dutyType,
    this.gender,
    this.contactNo,
    this.dependentsNo,
    this.maritalStatus,
    this.typeOfDeployment,
    this.deploymentOrderSubmitted,
    this.deploymentOrders,
    this.physicallyFit,
    this.localLanguage,
    this.localLangProficiency,
    this.hindiLangProficiency,
    this.englishLangProficiency,
    this.securityExperience,
    this.permanentAddress,
    this.localAddress,
    this.qualifications,
    this.pvc,
    this.trainingCertificateProvided,
    this.trainingCertificates,
    this.medicalCertificates,
    this.systemAccess,
    this.onboarded,
    this.esicNo,
    this.uanNo,
    this.msgbExempted,
    this.msgbFormBSubmitted,
    this.staffMsgbCompliant,
    this.csrParticipation,
    this.specialAchievement,
    this.specialAchievementText,
    this.additionalInitiatives,
    this.guardingPOC,
  );

  factory GmUiLabelsLocale.fromJson(Map<String, dynamic> json) =>
      _$GmUiLabelsLocaleFromJson(json);

  Map<String, dynamic> toJson() => _$GmUiLabelsLocaleToJson(this);
}
