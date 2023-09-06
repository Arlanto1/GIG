import 'package:db_atom/src/models/proof.dart';

import '../../../../models/department.dart';
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
      : items = (json['data'] as List?)
            ?.map((dynamic e) =>
                GuardingMastersDataModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        totalCount = json['totalCount'] as int?,
        currentPageNo = json['currentPageNo'] as int?,
        totalPageCount = json['totalPageCount'] as int?;

  Map<String, dynamic> toJson() => {
        'data': items?.map((e) => e.toJson()).toList(),
        'totalCount': totalCount,
        'currentPageNo': currentPageNo,
        'totalPageCount': totalPageCount
      };
}

class GuardingMastersDataModel {
  int? id;
  String? slNo;
  Location? location;
  LocationRegion? locationRegion;
  Department? vendor;
  EntrySecurity? entrySecurity;
  EntrySecurity? guard;
  Proof? localAddressProof;
  Proof? permanentAddressProof;
  Proof? bopData;
  List<Entity>? entities;
  String? inputDate;
  String? csrParticipationDates;
  String? medicalCertificateValidUntil;
  String? covidFirstDoseDate;
  String? covidSecondDoseDate;
  String? covidPrecautionaryDoseDate;
  String? ertCertificationDate;
  String? firstAidTrainingCompletionDate;
  String? pvcIssuedDate;
  String? pvcExpiryDate;
  String? dateOfBirth;
  String? dateOfJoining;
  int? status;
  num? height;
  num? weight;
  num? chest;
  int? guardRank;
  String? employeeCode;
  String? dbEmployeeId;
  int? dutyType;
  int? gender;
  String? contactNo;
  int? dependentsNo;
  int? maritalStatus;
  int? typeOfDeployment;
  bool deploymentOrderSubmitted;
  List<Proof>? deploymentOrders;
  bool physicallyFit;
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
  List<Entity>? qualifications;
  List<Proof>? pvc;
  bool trainingCertificateProvided;
  List<Proof>? trainingCertificates;
  List<Proof>? medicalCertificates;
  int? systemAccess;
  bool onboarded;
  String? esicNo;
  String? uanNo;
  bool msgbExempted;
  int? msgbFormBSubmitted;
  int? staffMsgbCompliant;
  bool csrParticipation;
  bool specialAchievement;
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
    this.guard,
    this.localAddressProof,
    this.permanentAddressProof,
    this.bopData,
    this.inputDate,
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
    this.entities,
    this.dutyType,
    this.gender,
    this.contactNo,
    this.dependentsNo,
    this.maritalStatus,
    this.typeOfDeployment,
    this.deploymentOrderSubmitted = false,
    this.deploymentOrders,
    this.physicallyFit = false,
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
    this.trainingCertificateProvided = false,
    this.trainingCertificates,
    this.medicalCertificates,
    this.systemAccess,
    this.onboarded = false,
    this.esicNo,
    this.uanNo,
    this.msgbExempted = false,
    this.msgbFormBSubmitted,
    this.staffMsgbCompliant,
    this.csrParticipation = false,
    this.specialAchievement = false,
    this.specialAchievementText,
    this.additionalInitiatives,
    this.history,
    this.guardingPOC,
  });

  GuardingMastersDataModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        slNo = json['slNo'] as String?,
        location = (json['location'] as Map<String, dynamic>?) != null
            ? Location.fromJson(json['location'] as Map<String, dynamic>)
            : null,
        locationRegion =
            (json['locationRegion'] as Map<String, dynamic>?) != null
                ? LocationRegion.fromJson(
                    json['locationRegion'] as Map<String, dynamic>)
                : null,
        entrySecurity = (json['entrySecurity'] as Map<String, dynamic>?) != null
            ? EntrySecurity.fromJson(
                json['entrySecurity'] as Map<String, dynamic>)
            : null,
        guard = (json['guard'] as Map<String, dynamic>?) != null
            ? EntrySecurity.fromJson(json['guard'] as Map<String, dynamic>)
            : null,
        localAddressProof = (json['localAddressProof']
                    as Map<String, dynamic>?) !=
                null
            ? Proof.fromJson(json['localAddressProof'] as Map<String, dynamic>)
            : null,
        permanentAddressProof =
            (json['permanentAddressProof'] as Map<String, dynamic>?) != null
                ? Proof.fromJson(
                    json['permanentAddressProof'] as Map<String, dynamic>)
                : null,
        bopData = (json['bopData'] as Map<String, dynamic>?) != null
            ? Proof.fromJson(json['bopData'] as Map<String, dynamic>)
            : null,
        inputDate = json['inputDate'] as String?,
        csrParticipationDates = json['csrParticipationDates'] as String?,
        medicalCertificateValidUntil =
            json['medicalCertificateValidUntil'] as String?,
        covidFirstDoseDate = json['covidFirstDoseDate'] as String?,
        covidSecondDoseDate = json['covidSecondDoseDate'] as String?,
        covidPrecautionaryDoseDate =
            json['covidPrecautionaryDoseDate'] as String?,
        ertCertificationDate = json['ertCertificationDate'] as String?,
        firstAidTrainingCompletionDate =
            json['firstAidTrainingCompletionDate'] as String?,
        pvcIssuedDate = json['pvcIssuedDate'] as String?,
        pvcExpiryDate = json['pvcExpiryDate'] as String?,
        dateOfBirth = json['dateOfBirth'] as String?,
        dateOfJoining = json['dateOfJoining'] as String?,
        vendor = (json['vendor'] as Map<String, dynamic>?) != null
            ? Department.fromJson(json['vendor'] as Map<String, dynamic>)
            : null,
        status = json['status'] as int?,
        guardRank = json['guardRank'] as int?,
        entities = (json['entities'] as List?)
            ?.map((dynamic e) => Entity.fromJson(e as Map<String, dynamic>))
            .toList(),
        employeeCode = json['employeeCode'] as String?,
        dbEmployeeId = json['dbEmployeeId'] as String?,
        height = json['height'] as num?,
        weight = json['weight'] as num?,
        chest = json['chest'] as num?,
        dutyType = json['dutyType'] as int?,
        gender = json['gender'] as int?,
        contactNo = json['contactNo'] as String?,
        dependentsNo = json['dependentsNo'] as int?,
        maritalStatus = json['maritalStatus'] as int?,
        typeOfDeployment = json['typeOfDeployment'] as int?,
        deploymentOrderSubmitted = json['deploymentOrderSubmitted'],
        deploymentOrders = (json['deploymentOrders'] as List?)
            ?.map((dynamic e) => Proof.fromJson(e as Map<String, dynamic>))
            .toList(),
        physicallyFit = json['physicallyFit'],
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
        qualifications = (json['qualifications'] as List?)
            ?.map((dynamic e) => Entity.fromJson(e as Map<String, dynamic>))
            .toList(),
        pvc = (json['pvc'] as List?)
            ?.map((dynamic e) => Proof.fromJson(e as Map<String, dynamic>))
            .toList(),
        trainingCertificateProvided = json['trainingCertificateProvided'],
        trainingCertificates = (json['trainingCertificates'] as List?)
            ?.map((dynamic e) => Proof.fromJson(e as Map<String, dynamic>))
            .toList(),
        medicalCertificates = (json['medicalCertificates'] as List?)
            ?.map((dynamic e) => Proof.fromJson(e as Map<String, dynamic>))
            .toList(),
        systemAccess = json['systemAccess'] as int?,
        onboarded = json['onboarded'],
        esicNo = json['esicNo'] as String?,
        uanNo = json['uanNo'] as String?,
        msgbExempted = json['msgbExempted'] as bool,
        msgbFormBSubmitted = json['msgbFormBSubmitted'] as int?,
        staffMsgbCompliant = json['staffMsgbCompliant'] as int?,
        csrParticipation = json['csrParticipation'],
        specialAchievement = json['specialAchievement'],
        specialAchievementText = json['specialAchievementText'] as String?,
        additionalInitiatives = json['additionalInitiatives'] as String?,
        history = json['history'] as List?,
        guardingPOC = json['guardingPOC'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'slNo': slNo,
        'location': location?.toJson(),
        'locationRegion': locationRegion?.toJson(),
        'entrySecurity': entrySecurity?.toJson(),
        'guard': guard?.toJson(),
        'inputDate': inputDate,
        'vendor': vendor?.toJson(),
        'csrParticipationDates': csrParticipationDates,
        'medicalCertificateValidUntil': medicalCertificateValidUntil,
        'covidFirstDoseDate': covidFirstDoseDate,
        'covidSecondDoseDate': covidSecondDoseDate,
        'covidPrecautionaryDoseDate': covidPrecautionaryDoseDate,
        'ertCertificationDate': ertCertificationDate,
        'firstAidTrainingCompletionDate': firstAidTrainingCompletionDate,
        'pvcExpiryDate': pvcExpiryDate,
        'pvcIssuedDate': pvcIssuedDate,
        'dateOfBirth': dateOfBirth,
        'dateOfJoining': dateOfJoining,
        'status': status,
        'height': height,
        'weight': weight,
        'chest': chest,
        'guardRank': guardRank,
        'employeeCode': employeeCode,
        'dbEmployeeId': dbEmployeeId,
        'dutyType': dutyType,
        'gender': gender,
        'entities': entities,
        'contactNo': contactNo,
        'dependentsNo': dependentsNo,
        'maritalStatus': maritalStatus,
        'typeOfDeployment': typeOfDeployment,
        'deploymentOrderSubmitted': deploymentOrderSubmitted,
        'deploymentOrders': deploymentOrders,
        'physicallyFit': physicallyFit,
        'localLanguage': localLanguage,
        'localLangProficiencyR': localLangProficiencyR,
        'hindiLangProficiencyR': hindiLangProficiencyR,
        'englishLangProficiencyR': englishLangProficiencyR,
        'localLangProficiencyW': localLangProficiencyW,
        'hindiLangProficiencyW': hindiLangProficiencyW,
        'englishLangProficiencyW': englishLangProficiencyW,
        'localLangProficiencyS': localLangProficiencyS,
        'hindiLangProficiencyS': hindiLangProficiencyS,
        'englishLangProficiencyS': englishLangProficiencyS,
        'securityExperience': securityExperience,
        'permanentAddress': permanentAddress,
        'localAddress': localAddress,
        'qualifications': qualifications,
        'pvc': pvc,
        'trainingCertificateProvided': trainingCertificateProvided,
        'trainingCertificates': trainingCertificates,
        'medicalCertificates': medicalCertificates,
        'systemAccess': systemAccess,
        'onboarded': onboarded,
        'esicNo': esicNo,
        'uanNo': uanNo,
        'msgbExempted': msgbExempted,
        'msgbFormBSubmitted': msgbFormBSubmitted,
        'staffMsgbCompliant': staffMsgbCompliant,
        'csrParticipation': csrParticipation,
        'specialAchievement': specialAchievement,
        'specialAchievementText': specialAchievementText,
        'additionalInitiatives': additionalInitiatives,
        'history': history,
        'guardingPOC': guardingPOC
      };
}
