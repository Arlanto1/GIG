import 'package:db_atom/src/models/base_object.dart';

import 'package:db_atom/src/models/image_content.dart';

import '../../../../models/organisation.dart';
import '../../../createfound/models/user.dart';
import 'package:json_annotation/json_annotation.dart';


part 'guarding_master_data_model_g.dart';
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
class GuardingMastersDataModel extends BaseObject{
  int? id;
  String? slNo;
  Organisation? location;
  Organisation? locationRegion;
  Organisation? vendor;
  User? entrySecurity;
  User? guard;
  ImageContent? localAddressProof;
  ImageContent? permanentAddressProof;
  ImageContent? bopData;
  ImageContent? photoGraph;
  Organisation? entity;
  String? inputDate;
  String? msgbExemptionDate;
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
  List<ImageContent>? deploymentOrders;
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
  List<ImageContent>? pvc;
  bool trainingCertificateProvided;
  List<ImageContent>? trainingCertificates;
  List<ImageContent>? medicalCertificates;
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


  factory GuardingMastersDataModel.fromJson(Map<String, dynamic> json) =>
      _$GuardingMastersDataModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GuardingMastersDataModelToJson(this);



}
