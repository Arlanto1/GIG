import 'dart:developer';

import 'package:db_atom/index.dart';

part 'guarding_master_data_model.g.dart';

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

@JsonSerializable()
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
  });

  factory GuardingMastersDataModel.fromJson(Map<String, dynamic> json) {
    try {
      return _$GuardingMastersDataModelFromJson(json);
    } catch (e) {
      if (e is CheckedFromJsonException) {
        // Access the information about the error
        log('Error during deserialization: ${e.message}, path: ${e.key}');
      } else {
        // Handle other types of exceptions if needed
        log('Unexpected error during deserialization: $e');
      }

      // Return a default instance or handle differently based on your needs.
      return GuardingMastersDataModel();
    }
  }

  @override
  Map<String, dynamic> toJson() => _$GuardingMastersDataModelToJson(this);
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
