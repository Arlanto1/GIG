import 'dart:developer';

import 'package:db_atom/index.dart';

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

  GuardingMasterDataResponse.fromJson(Map<String, dynamic> json) {
    List data = json['data'] as List;
    List<GuardingMastersDataModel> modellist = data.map((e) {
      try {
        return GuardingMastersDataModel.fromJson(e as Map<String, dynamic>);
      } catch (e) {
        // Handle the exception, you can log it or take any appropriate action.
        // For example, you can log the error and return a default value.
        log('Error parsing Guarding Master Data: $e');
        return GuardingMastersDataModel(); // Return a default instance of MaterialMovementModel.
      }
    }).toList();

    log('--modellist---${modellist.length}');

    try {
      if (json['data'] is List) {
        items = (json['data'] as List)
            .map((dynamic e) =>
                GuardingMastersDataModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        // Handle the case where 'list' is not a List
        items = [];
      }
      totalCount = json['totalCount'] as int?;
      currentPageNo = json['currentPageNo'] as int?;
      totalPageCount = json['totalPageCount'] as int?;
    } catch (e) {
      // Print debug information
      log('Error parsing Guarding Master Data: $e');
      log('json: $json');
    }
  }

  Map<String, dynamic> toJson() => {
        'data': items?.map((e) => e.toJson()).toList(),
        'totalCount': totalCount,
        'currentPageNo': currentPageNo,
        'totalPageCount': totalPageCount
      };
}

class GuardingMastersDataModel extends BaseObject {
  int? id;
  String? slNo;
  Organisation? location;
  Organisation? locationRegion;
  Organisation? vendor;
  User? entrySecurity;
  User? guard;
  Organisation? entity;
  String? inputDate;
  int? status;
  int? guardRank;
  ImageContent? localAddressProof;
  ImageContent? permanentAddressProof;
  ImageContent? bioData;
  ImageContent? photoGraph;
  String? employeeCode;
  String? dbEmployeeId;
  int? dutyType;
  int? gender;
  num? height;
  num? weight;
  num? chest;
  String? contactNo;
  String? dateOfBirth;
  int? maritalStatus;
  int? typeOfDeployment;
  bool deploymentOrderSubmitted;
  List<ImageContent>? deploymentOrders;
  String? dateOfJoining;
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
  List<Organisation>? qualifications;
  String? pvcIssuedDate;
  String? pvcExpiryDate;
  List<ImageContent>? pvc;
  bool trainingCertificateProvided;
  List<ImageContent>? trainingCertificates;
  String? medicalCertificateValidUntil;
  List<ImageContent>? medicalCertificates;
  String? covidFirstDoseDate;
  String? covidSecondDoseDate;
  String? covidPrecautionaryDoseDate;
  String? ertCertificationDate;
  String? firstAidTrainingCompletionDate;
  int? systemAccess;
  bool onboarded;
  String? esicNo;
  String? uanNo;
  bool msgbExempted;
  int? msgbFormBSubmitted;
  int? staffMsgbCompliant;
  String? guardingPOC;
  List<GuardingMasterDataExtraDetails>? csrParticipations;
  List<GuardingMasterDataExtraDetails>? additionalInitiatives;
  List<GuardingMasterDataExtraDetails>? additionalQualifications;
  List<GuardingMasterDataExtraDetails>? specialAchievements;
  String? entrySecurityName;
  String? guardName;
  int? dependentsNo;
  String? msgbExemptionDate;
  bool? showMsgbData;
  String? modifiedBy;
  String? modifiedDate;
  String? greenBgvDate;

  GuardingMastersDataModel({
    this.id,
    this.slNo,
    this.location,
    this.locationRegion,
    this.vendor,
    this.guard,
    this.entity,
    this.entrySecurity,
    this.inputDate,
    this.status,
    this.guardRank,
    this.localAddressProof,
    this.permanentAddressProof,
    this.bioData,
    this.photoGraph,
    this.employeeCode,
    this.dbEmployeeId,
    this.dutyType,
    this.gender,
    this.contactNo,
    this.dateOfBirth,
    this.maritalStatus,
    this.typeOfDeployment,
    this.deploymentOrderSubmitted = false,
    this.deploymentOrders,
    this.dateOfJoining,
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
    this.pvcIssuedDate,
    this.pvcExpiryDate,
    this.pvc,
    this.trainingCertificateProvided = false,
    this.showMsgbData,
    this.trainingCertificates,
    this.medicalCertificateValidUntil,
    this.medicalCertificates,
    this.systemAccess,
    this.onboarded = false,
    this.esicNo,
    this.uanNo,
    this.msgbExempted = false,
    this.msgbFormBSubmitted,
    this.staffMsgbCompliant,
    this.guardingPOC,
    this.csrParticipations,
    this.additionalInitiatives,
    this.additionalQualifications,
    this.specialAchievements,
    this.entrySecurityName,
    this.guardName,
    this.covidFirstDoseDate,
    this.covidSecondDoseDate,
    this.covidPrecautionaryDoseDate,
    this.ertCertificationDate,
    this.firstAidTrainingCompletionDate,
    this.height,
    this.weight,
    this.chest,
    this.dependentsNo,
    this.msgbExemptionDate,
    this.modifiedBy,
    this.modifiedDate,
    this.greenBgvDate,
  });

  factory GuardingMastersDataModel.fromJson(Map<String, dynamic> json) {
    return GuardingMastersDataModel(
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
      entrySecurity: json['entrySecurity'] == null
          ? null
          : User.fromJson(json['entrySecurity'] as Map<String, dynamic>),
      guard: json['guard'] == null
          ? null
          : User.fromJson(json['guard'] as Map<String, dynamic>),
      entity: json['entity'] == null
          ? null
          : Organisation.fromJson(json['entity'] as Map<String, dynamic>),
      inputDate: json['inputDate'] as String?,
      status: json['status'] as int?,
      guardRank: json['guardRank'] as int?,
      localAddressProof: json['localAddressProof'] is Map<String, dynamic>
          ? ImageContent.fromJson(json['localAddressProof'])
          : null,
      permanentAddressProof:
          json['permanentAddressProof'] is Map<String, dynamic>
              ? ImageContent.fromJson(json['permanentAddressProof'])
              : null,
      bioData: json['bioData'] is Map<String, dynamic>
          ? ImageContent.fromJson(json['bioData'])
          : null,
      photoGraph: json['photoGraph'] is Map<String, dynamic>
          ? ImageContent.fromJson(json['photoGraph'])
          : null,
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
      showMsgbData: json['showMsgbData'] as bool?,
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
      modifiedBy: json['modifiedBy'] as String?,
      modifiedDate: json['modifiedDate'] as String?,
      greenBgvDate: json['greenBgvDate'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slNo': slNo,
      'location': location?.toJson(),
      'locationRegion': locationRegion?.toJson(),
      'vendor': vendor?.toJson(),
      'entrySecurity': entrySecurity?.toJson(),
      'guard': guard?.toJson(),
      'entity': entity?.toJson(),
      'inputDate': inputDate,
      'status': status,
      'guardRank': guardRank,
      'localAddressProof': localAddressProof?.toJson(),
      'permanentAddressProof': permanentAddressProof?.toJson(),
      'bioData': bioData?.toJson(),
      'photoGraph': photoGraph?.toJson(),
      'employeeCode': employeeCode,
      'dbEmployeeId': dbEmployeeId,
      'dutyType': dutyType,
      'gender': gender,
      'contactNo': contactNo,
      'dateOfBirth': dateOfBirth,
      'maritalStatus': maritalStatus,
      'typeOfDeployment': typeOfDeployment,
      'deploymentOrderSubmitted': deploymentOrderSubmitted,
      'deploymentOrders': deploymentOrders?.map((e) => e.toJson()).toList(),
      'dateOfJoining': dateOfJoining,
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
      'qualifications': qualifications?.map((e) => e.toJson()).toList(),
      'pvcIssuedDate': pvcIssuedDate,
      'pvcExpiryDate': pvcExpiryDate,
      'pvc': pvc?.map((e) => e.toJson()).toList(),
      'trainingCertificateProvided': trainingCertificateProvided,
      'trainingCertificates':
          trainingCertificates?.map((e) => e.toJson()).toList(),
      'medicalCertificateValidUntil': medicalCertificateValidUntil,
      'medicalCertificates':
          medicalCertificates?.map((e) => e.toJson()).toList(),
      'systemAccess': systemAccess,
      'onboarded': onboarded,
      'esicNo': esicNo,
      'uanNo': uanNo,
      'msgbExempted': msgbExempted,
      'msgbFormBSubmitted': msgbFormBSubmitted,
      'staffMsgbCompliant': staffMsgbCompliant,
      'guardingPOC': guardingPOC,
      'csrParticipations': csrParticipations?.map((e) => e.toJson()).toList(),
      'additionalInitiatives':
          additionalInitiatives?.map((e) => e.toJson()).toList(),
      'additionalQualifications':
          additionalQualifications?.map((e) => e.toJson()).toList(),
      'specialAchievements':
          specialAchievements?.map((e) => e.toJson()).toList(),
      'entrySecurityName': entrySecurityName,
      'guardName': guardName,
      'dependentsNo': dependentsNo,
      'msgbExemptionDate': msgbExemptionDate,
      'modifiedBy': modifiedBy,
      'modifiedDate': modifiedDate,
      'greenBgvDate': greenBgvDate
    };
  }
}

class GuardingMasterDataExtraDetails {
  final int? id;
  final String? description;
  final String? date;
  final int? type;

  GuardingMasterDataExtraDetails({
    this.id,
    this.description,
    this.date,
    this.type,
  });

  GuardingMasterDataExtraDetails.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        description = json['description'] as String?,
        date = json['date'] as String?,
        type = json['type'] as int?;

  Map<String, dynamic> toJson() =>
      {'id': id, 'description': description, 'date': date, 'type': type};
}
