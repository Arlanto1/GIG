import '../../../../models/entity.dart';
import '../../../../models/entry_security.dart';
import '../../../../models/location.dart';
import '../../../../models/location_region.dart';

class GuardingMasterDataResponse {
  List<GuardingMastersDataModel>? items;
  int? totalCount;
  int? currentPageNo;
  int? totalPageCount;

  GuardingMasterDataResponse({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  GuardingMasterDataResponse.fromJson(Map<String, dynamic> json)
      : items = (json['data'] as List?)?.map((dynamic e) => GuardingMastersDataModel.fromJson(e as Map<String,dynamic>)).toList(),
        totalCount = json['totalCount'] as int?,
        currentPageNo = json['currentPageNo'] as int?,
        totalPageCount = json['totalPageCount'] as int?;

  Map<String, dynamic> toJson() => {
    'data' : items?.map((e) => e.toJson()).toList(),
    'totalCount' : totalCount,
    'currentPageNo' : currentPageNo,
    'totalPageCount' : totalPageCount
  };
}

class GuardingMastersDataModel {
  int? id;
  String? slNo;
  Location? location;
  LocationRegion? locationRegion;
  EntrySecurity? entrySecurity;
  List<Entity>? entities;
  String? inputDate;
  String? covidFirstDoseDate;
  int? status;
  int? guardRank;
  String? employeeCode;
  String? guardingPoc;
  String? dbEmployeeId;
  int? dutyType;
  int? gender;
  String? contactNo;
  int? maritalStatus;
  int? typeOfDeployment;
  bool? deploymentOrderSubmitted;
  List<dynamic>? deploymentOrders;
  bool? physicallyFit;
  String? localLanguage;
  bool? localLangProficiencyR;
  bool? hindiLangProficiencyR;
  bool? englishLangProficiencyR;
  bool? localLangProficiencyW;
  bool? hindiLangProficiencyW;
  bool? englishLangProficiencyW;
  bool? localLangProficiencyS;
  bool? hindiLangProficiencyS;
  bool? englishLangProficiencyS;
  String? securityExperience;
  String? permanentAddress;
  String? localAddress;
  List<dynamic>? qualifications;
  List<dynamic>? pvc;
  bool? trainingCertificateProvided;
  List<dynamic>? trainingCertificates;
  List<dynamic>? medicalCertificates;
  int? systemAccess;
  bool? onboarded;
  String? esicNo;
  String? uanNo;
  bool? msgbExempted;
  int? msgbFormBSubmitted;
  int? staffMsgbCompliant;
  bool? csrParticipation;
  bool? specialAchievement;
  String? specialAchievementText;
  String? additionalInitiatives;
  List<dynamic>? history;
  String? guardingPOC;

  GuardingMastersDataModel({
    this.id,
    this.slNo,
    this.location,
    this.locationRegion,
    this.entrySecurity,
    this.inputDate,
    this.covidFirstDoseDate,
    this.status,
    this.guardRank,
    this.employeeCode,
    this.dbEmployeeId,
    this.guardingPoc,
    this.entities,
    this.dutyType,
    this.gender,
    this.contactNo,
    this.maritalStatus,
    this.typeOfDeployment,
    this.deploymentOrderSubmitted,
    this.deploymentOrders,
    this.physicallyFit,
    this.localLanguage,
    this.localLangProficiencyR,
    this.hindiLangProficiencyR,
    this.englishLangProficiencyR,
    this.localLangProficiencyW,
    this.hindiLangProficiencyW,
    this.englishLangProficiencyW,
    this.localLangProficiencyS,
    this.hindiLangProficiencyS,
    this.englishLangProficiencyS,
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
    this.history,
    this.guardingPOC,
  });

  GuardingMastersDataModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        slNo = json['slNo'] as String?,
        location = (json['location'] as Map<String,dynamic>?) != null ? Location.fromJson(json['location'] as Map<String,dynamic>) : null,
        locationRegion = (json['locationRegion'] as Map<String,dynamic>?) != null ? LocationRegion.fromJson(json['locationRegion'] as Map<String,dynamic>) : null,
        entrySecurity = (json['entrySecurity'] as Map<String,dynamic>?) != null ? EntrySecurity.fromJson(json['entrySecurity'] as Map<String,dynamic>) : null,
        inputDate = json['inputDate'] as String?,
        covidFirstDoseDate = json['covidFirstDoseDate'] as String?,
        guardingPoc = json['guardingPoc'] as String?,
        status = json['status'] as int?,
        guardRank = json['guardRank'] as int?,
        entities = (json['entities'] as List?)
            ?.map((dynamic e) => Entity.fromJson(e as Map<String, dynamic>))
            .toList(),   employeeCode = json['employeeCode'] as String?,
        dbEmployeeId = json['dbEmployeeId'] as String?,
        dutyType = json['dutyType'] as int?,
        gender = json['gender'] as int?,
        contactNo = json['contactNo'] as String?,
        maritalStatus = json['maritalStatus'] as int?,
        typeOfDeployment = json['typeOfDeployment'] as int?,
        deploymentOrderSubmitted = json['deploymentOrderSubmitted'] as bool?,
        deploymentOrders = json['deploymentOrders'] as List?,
        physicallyFit = json['physicallyFit'] as bool?,
        localLanguage = json['localLanguage'] as String?,
        localLangProficiencyR = json['localLangProficiencyR'] as bool?,
        hindiLangProficiencyR = json['hindiLangProficiencyR'] as bool?,
        englishLangProficiencyR = json['englishLangProficiencyR'] as bool?,
        localLangProficiencyW = json['localLangProficiencyW'] as bool?,
        hindiLangProficiencyW = json['hindiLangProficiencyW'] as bool?,
        englishLangProficiencyW = json['englishLangProficiencyW'] as bool?,
        localLangProficiencyS = json['localLangProficiencyS'] as bool?,
        hindiLangProficiencyS = json['hindiLangProficiencyS'] as bool?,
        englishLangProficiencyS = json['englishLangProficiencyS'] as bool?,
        securityExperience = json['securityExperience'] as String?,
        permanentAddress = json['permanentAddress'] as String?,
        localAddress = json['localAddress'] as String?,
        qualifications = json['qualifications'] as List?,
        pvc = json['pvc'] as List?,
        trainingCertificateProvided = json['trainingCertificateProvided'] as bool?,
        trainingCertificates = json['trainingCertificates'] as List?,
        medicalCertificates = json['medicalCertificates'] as List?,
        systemAccess = json['systemAccess'] as int?,
        onboarded = json['onboarded'] as bool?,
        esicNo = json['esicNo'] as String?,
        uanNo = json['uanNo'] as String?,
        msgbExempted = json['msgbExempted'] as bool?,
        msgbFormBSubmitted = json['msgbFormBSubmitted'] as int?,
        staffMsgbCompliant = json['staffMsgbCompliant'] as int?,
        csrParticipation = json['csrParticipation'] as bool?,
        specialAchievement = json['specialAchievement'] as bool?,
        specialAchievementText = json['specialAchievementText'] as String?,
        additionalInitiatives = json['additionalInitiatives'] as String?,
        history = json['history'] as List?,
        guardingPOC = json['guardingPOC'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'slNo' : slNo,
    'location' : location?.toJson(),
    'locationRegion' : locationRegion?.toJson(),
    'entrySecurity' : entrySecurity?.toJson(),
    'inputDate' : inputDate,
    'covidFirstDoseDate' : covidFirstDoseDate,
    'status' : status,
    'guardRank' : guardRank,
    'employeeCode' : employeeCode,
    'dbEmployeeId' : dbEmployeeId,
    'dutyType' : dutyType,
    'gender' : gender,
    'guardingPoc' : guardingPoc,
    'entities': entities,
    'contactNo' : contactNo,
    'maritalStatus' : maritalStatus,
    'typeOfDeployment' : typeOfDeployment,
    'deploymentOrderSubmitted' : deploymentOrderSubmitted,
    'deploymentOrders' : deploymentOrders,
    'physicallyFit' : physicallyFit,
    'localLanguage' : localLanguage,
    'localLangProficiencyR' : localLangProficiencyR,
    'hindiLangProficiencyR' : hindiLangProficiencyR,
    'englishLangProficiencyR' : englishLangProficiencyR,
    'localLangProficiencyW' : localLangProficiencyW,
    'hindiLangProficiencyW' : hindiLangProficiencyW,
    'englishLangProficiencyW' : englishLangProficiencyW,
    'localLangProficiencyS' : localLangProficiencyS,
    'hindiLangProficiencyS' : hindiLangProficiencyS,
    'englishLangProficiencyS' : englishLangProficiencyS,
    'securityExperience' : securityExperience,
    'permanentAddress' : permanentAddress,
    'localAddress' : localAddress,
    'qualifications' : qualifications,
    'pvc' : pvc,
    'trainingCertificateProvided' : trainingCertificateProvided,
    'trainingCertificates' : trainingCertificates,
    'medicalCertificates' : medicalCertificates,
    'systemAccess' : systemAccess,
    'onboarded' : onboarded,
    'esicNo' : esicNo,
    'uanNo' : uanNo,
    'msgbExempted' : msgbExempted,
    'msgbFormBSubmitted' : msgbFormBSubmitted,
    'staffMsgbCompliant' : staffMsgbCompliant,
    'csrParticipation' : csrParticipation,
    'specialAchievement' : specialAchievement,
    'specialAchievementText' : specialAchievementText,
    'additionalInitiatives' : additionalInitiatives,
    'history' : history,
    'guardingPOC' : guardingPOC
  };
}