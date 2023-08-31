import '../../../../models/entity.dart';
import '../../../../models/entry_security.dart';
import '../../../../models/history.dart';

class GuardingMasterDataResponse {
  GuardingMasterDataResponse({
     required this.items,
     this.totalCount,
     this.currentPageNo,
     this.totalPageCount,
  });

   List<GuardingMastersDataModel> items;
   int? totalCount;
   int? currentPageNo;
   int? totalPageCount;

  factory GuardingMasterDataResponse.fromJson(Map<String, dynamic> json) {
    return GuardingMasterDataResponse(
      items: json["data"] == null
          ? []
          : List<GuardingMastersDataModel>.from(
              json["data"]!.map((x) => GuardingMastersDataModel.fromJson(x))),
      totalCount: json["totalCount"],
      currentPageNo: json["currentPageNo"],
      totalPageCount: json["totalPageCount"],
    );
  }

  Map<String, dynamic> toJson() => {
        "data": items.map((x) => x.toJson()).toList(),
        "totalCount": totalCount,
        "currentPageNo": currentPageNo,
        "totalPageCount": totalPageCount,
      };
}

class GuardingMastersDataModel {
  GuardingMastersDataModel({
    this.id,
    this.slNo,
    this.location,
    this.locationRegion,
    this.entity,
    this.entrySecurity,
    this.inputDate,
    this.status,
    this.vendor,
    this.guard,
    this.guardRank,
    this.employeeCode,
    this.dbEmployeeId,
    this.dutyType,
    this.gender,
    this.contactNo,
    this.dateOfBirth,
    this.maritalStatus,
    this.dependentsNo,
    this.typeOfDeployment,
    required this.deploymentOrderSubmitted,
    required this.deploymentOrders,
    this.dateOfJoining,
    this.height,
    this.weight,
    this.chest,
    required this.physicallyFit,
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
    this.bioData,
    this.photoGraph,
    this.permanentAddress,
    this.permanentAddressProof,
    this.localAddress,
    this.localAddressProof,
    required this.qualifications,
    this.pvcIssuedDate,
    this.pvcExpiryDate,
    required this.pvc,
    this.trainingCertificateProvided,
    required this.trainingCertificates,
    this.medicalCertificateValidUntil,
    required this.medicalCertificates,
    this.systemAccess,
    this.onboarded,
    this.esicNo,
    this.uanNo,
    this.msgbExempted,
    this.msgbExemptionDate,
    this.msgbFormBSubmitted,
    this.staffMsgbCompliant,
    this.csrParticipation,
    this.specialAchievement,
    this.specialAchievementText,
    this.additionalInitiatives,
    required this.history,
    this.guardingPoc,
    this.csrParticipationDates,
    this.modifiedDate,
    this.modifiedBy,
    this.covidFirstDoseDate,
    this.covidSecondDoseDate,
    this.covidPrecautionaryDoseDate,
    this.ertCertificationDate,
    this.firstAidTrainingCompletionDate,
  });

  int? id;
  String? slNo;
  Entity? location;
  Entity? locationRegion;
  Entity? entity;
  EntrySecurity? entrySecurity;
  String? inputDate;
  int? status;
  Entity? vendor;
  EntrySecurity? guard;
  int? guardRank;
  String? employeeCode;
  String? dbEmployeeId;
  int? dutyType;
  int? gender;
  String? contactNo;
  int? dateOfBirth;
  int? maritalStatus;
  int? dependentsNo;
  int? typeOfDeployment;
  bool deploymentOrderSubmitted;
  List<BioData> deploymentOrders;
  String? dateOfJoining;
  int? height;
  int? weight;
  int? chest;
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
  BioData? bioData;
  BioData? photoGraph;
  String? permanentAddress;
  BioData? permanentAddressProof;
  String? localAddress;
  BioData? localAddressProof;
  List<Entity> qualifications;
  int? pvcIssuedDate;
  int? pvcExpiryDate;
  List<BioData> pvc;
  bool? trainingCertificateProvided;
  List<BioData> trainingCertificates;
  int? medicalCertificateValidUntil;
  List<BioData> medicalCertificates;
  int? systemAccess;
  bool? onboarded;
  String? esicNo;
  String? uanNo;
  bool? msgbExempted;
  int? msgbExemptionDate;
  int? msgbFormBSubmitted;
  int? staffMsgbCompliant;
  bool? csrParticipation;
  bool? specialAchievement;
  String? specialAchievementText;
  String? additionalInitiatives;
  List<History> history;
  String? guardingPoc;
  String? csrParticipationDates;
  int? modifiedDate;
  String? modifiedBy;
  int? covidFirstDoseDate;
  int? covidSecondDoseDate;
  int? covidPrecautionaryDoseDate;
  int? ertCertificationDate;
  int? firstAidTrainingCompletionDate;

  factory GuardingMastersDataModel.fromJson(Map<String, dynamic> json) {
    return GuardingMastersDataModel(
      id: json["id"],
      slNo: json["slNo"],
      location:
          json["location"] == null ? null : Entity.fromJson(json["location"]),
      locationRegion: json["locationRegion"] == null
          ? null
          : Entity.fromJson(json["locationRegion"]),
      entity: json["entity"] == null ? null : Entity.fromJson(json["entity"]),
      entrySecurity: json["entrySecurity"] == null
          ? null
          : EntrySecurity.fromJson(json["entrySecurity"]),
      inputDate: json["inputDate"],
      status: json["status"],
      vendor: json["vendor"] == null ? null : Entity.fromJson(json["vendor"]),
      guard:
          json["guard"] == null ? null : EntrySecurity.fromJson(json["guard"]),
      guardRank: json["guardRank"],
      employeeCode: json["employeeCode"],
      dbEmployeeId: json["dbEmployeeId"],
      dutyType: json["dutyType"],
      gender: json["gender"],
      contactNo: json["contactNo"],
      dateOfBirth: json["dateOfBirth"],
      maritalStatus: json["maritalStatus"],
      dependentsNo: json["dependentsNo"],
      typeOfDeployment: json["typeOfDeployment"],
      deploymentOrderSubmitted: json["deploymentOrderSubmitted"],
      deploymentOrders: json["deploymentOrders"] == null
          ? []
          : List<BioData>.from(
              json["deploymentOrders"]!.map((x) => BioData.fromJson(x))),
      dateOfJoining: json["dateOfJoining"],
      height: json["height"],
      weight: json["weight"],
      chest: json["chest"],
      physicallyFit: json["physicallyFit"],
      localLanguage: json["localLanguage"],
      localLangProficiencyR: json["localLangProficiencyR"],
      hindiLangProficiencyR: json["hindiLangProficiencyR"],
      englishLangProficiencyR: json["englishLangProficiencyR"],
      localLangProficiencyW: json["localLangProficiencyW"],
      hindiLangProficiencyW: json["hindiLangProficiencyW"],
      englishLangProficiencyW: json["englishLangProficiencyW"],
      localLangProficiencyS: json["localLangProficiencyS"],
      hindiLangProficiencyS: json["hindiLangProficiencyS"],
      englishLangProficiencyS: json["englishLangProficiencyS"],
      securityExperience: json["securityExperience"],
      bioData:
          json["bioData"] == null ? null : BioData.fromJson(json["bioData"]),
      photoGraph: json["photoGraph"] == null
          ? null
          : BioData.fromJson(json["photoGraph"]),
      permanentAddress: json["permanentAddress"],
      permanentAddressProof: json["permanentAddressProof"] == null
          ? null
          : BioData.fromJson(json["permanentAddressProof"]),
      localAddress: json["localAddress"],
      localAddressProof: json["localAddressProof"] == null
          ? null
          : BioData.fromJson(json["localAddressProof"]),
      qualifications: json["qualifications"] == null
          ? []
          : List<Entity>.from(
              json["qualifications"]!.map((x) => Entity.fromJson(x))),
      pvcIssuedDate: json["pvcIssuedDate"],
      pvcExpiryDate: json["pvcExpiryDate"],
      pvc: json["pvc"] == null
          ? []
          : List<BioData>.from(json["pvc"]!.map((x) => BioData.fromJson(x))),
      trainingCertificateProvided: json["trainingCertificateProvided"],
      trainingCertificates: json["trainingCertificates"] == null
          ? []
          : List<BioData>.from(
              json["trainingCertificates"]!.map((x) => BioData.fromJson(x))),
      medicalCertificateValidUntil: json["medicalCertificateValidUntil"],
      medicalCertificates: json["medicalCertificates"] == null
          ? []
          : List<BioData>.from(
              json["medicalCertificates"]!.map((x) => BioData.fromJson(x))),
      systemAccess: json["systemAccess"],
      onboarded: json["onboarded"],
      esicNo: json["esicNo"],
      uanNo: json["uanNo"],
      msgbExempted: json["msgbExempted"],
      msgbExemptionDate: json["msgbExemptionDate"],
      msgbFormBSubmitted: json["msgbFormBSubmitted"],
      staffMsgbCompliant: json["staffMsgbCompliant"],
      csrParticipation: json["csrParticipation"],
      specialAchievement: json["specialAchievement"],
      specialAchievementText: json["specialAchievementText"],
      additionalInitiatives: json["additionalInitiatives"],
      history: json["history"] == null
          ? []
          : List<History>.from(
              json["history"]!.map((x) => History.fromJson(x))),
      guardingPoc: json["guardingPOC"],
      csrParticipationDates: json["csrParticipationDates"],
      modifiedDate: json["modifiedDate"],
      modifiedBy: json["modifiedBy"],
      covidFirstDoseDate: json["covidFirstDoseDate"],
      covidSecondDoseDate: json["covidSecondDoseDate"],
      covidPrecautionaryDoseDate: json["covidPrecautionaryDoseDate"],
      ertCertificationDate: json["ertCertificationDate"],
      firstAidTrainingCompletionDate: json["firstAidTrainingCompletionDate"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "slNo": slNo,
        "location": location?.toJson(),
        "locationRegion": locationRegion?.toJson(),
        "entity": entity?.toJson(),
        "entrySecurity": entrySecurity?.toJson(),
        "inputDate": inputDate,
        "status": status,
        "vendor": vendor?.toJson(),
        "guard": guard?.toJson(),
        "guardRank": guardRank,
        "employeeCode": employeeCode,
        "dbEmployeeId": dbEmployeeId,
        "dutyType": dutyType,
        "gender": gender,
        "contactNo": contactNo,
        "dateOfBirth": dateOfBirth,
        "maritalStatus": maritalStatus,
        "dependentsNo": dependentsNo,
        "typeOfDeployment": typeOfDeployment,
        "deploymentOrderSubmitted": deploymentOrderSubmitted,
        "deploymentOrders": deploymentOrders.map((x) => x.toJson()).toList(),
        "dateOfJoining": dateOfJoining,
        "height": height,
        "weight": weight,
        "chest": chest,
        "physicallyFit": physicallyFit,
        "localLanguage": localLanguage,
        "localLangProficiencyR": localLangProficiencyR,
        "hindiLangProficiencyR": hindiLangProficiencyR,
        "englishLangProficiencyR": englishLangProficiencyR,
        "localLangProficiencyW": localLangProficiencyW,
        "hindiLangProficiencyW": hindiLangProficiencyW,
        "englishLangProficiencyW": englishLangProficiencyW,
        "localLangProficiencyS": localLangProficiencyS,
        "hindiLangProficiencyS": hindiLangProficiencyS,
        "englishLangProficiencyS": englishLangProficiencyS,
        "securityExperience": securityExperience,
        "bioData": bioData?.toJson(),
        "photoGraph": photoGraph?.toJson(),
        "permanentAddress": permanentAddress,
        "permanentAddressProof": permanentAddressProof?.toJson(),
        "localAddress": localAddress,
        "localAddressProof": localAddressProof?.toJson(),
        "qualifications": qualifications.map((x) => x.toJson()).toList(),
        "pvcIssuedDate": pvcIssuedDate,
        "pvcExpiryDate": pvcExpiryDate,
        "pvc": pvc.map((x) => x.toJson()).toList(),
        "trainingCertificateProvided": trainingCertificateProvided,
        "trainingCertificates":
            trainingCertificates.map((x) => x.toJson()).toList(),
        "medicalCertificateValidUntil": medicalCertificateValidUntil,
        "medicalCertificates":
            medicalCertificates.map((x) => x.toJson()).toList(),
        "systemAccess": systemAccess,
        "onboarded": onboarded,
        "esicNo": esicNo,
        "uanNo": uanNo,
        "msgbExempted": msgbExempted,
        "msgbExemptionDate": msgbExemptionDate,
        "msgbFormBSubmitted": msgbFormBSubmitted,
        "staffMsgbCompliant": staffMsgbCompliant,
        "csrParticipation": csrParticipation,
        "specialAchievement": specialAchievement,
        "specialAchievementText": specialAchievementText,
        "additionalInitiatives": additionalInitiatives,
        "history": history.map((x) => x.toJson()).toList(),
        "guardingPOC": guardingPoc,
        "csrParticipationDates": csrParticipationDates,
        "modifiedDate": modifiedDate,
        "modifiedBy": modifiedBy,
        "covidFirstDoseDate": covidFirstDoseDate,
        "covidSecondDoseDate": covidSecondDoseDate,
        "covidPrecautionaryDoseDate": covidPrecautionaryDoseDate,
        "ertCertificationDate": ertCertificationDate,
        "firstAidTrainingCompletionDate": firstAidTrainingCompletionDate,
      };
}

class BioData {
  BioData({
    required this.id,
    required this.ownerName,
    required this.contentType,
    required this.uploadDate,
    required this.guardingMasterId,
    required this.type,
    required this.title,
    required this.deletable,
    required this.imageStreamData,
    required this.fileSize,
    required this.imageContent,
  });

  final int? id;
  final String? ownerName;
  final String? contentType;
  final int? uploadDate;
  final int? guardingMasterId;
  final int? type;
  final String? title;
  final bool? deletable;
  final ImageStreamData? imageStreamData;
  final int? fileSize;
  final dynamic imageContent;

  factory BioData.fromJson(Map<String, dynamic> json) {
    return BioData(
      id: json["id"],
      ownerName: json["ownerName"],
      contentType: json["contentType"],
      uploadDate: json["uploadDate"],
      guardingMasterId: json["guardingMasterId"],
      type: json["type"],
      title: json["title"],
      deletable: json["deletable"],
      imageStreamData: json["imageStreamData"] == null
          ? null
          : ImageStreamData.fromJson(json["imageStreamData"]),
      fileSize: json["fileSize"],
      imageContent: json["imageContent"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "ownerName": ownerName,
        "contentType": contentType,
        "uploadDate": uploadDate,
        "guardingMasterId": guardingMasterId,
        "type": type,
        "title": title,
        "deletable": deletable,
        "imageStreamData": imageStreamData?.toJson(),
        "fileSize": fileSize,
        "imageContent": imageContent,
      };
}

class ImageStreamData {
  ImageStreamData({required this.json});

  final Map<String, dynamic> json;

  factory ImageStreamData.fromJson(Map<String, dynamic> json) {
    return ImageStreamData(json: json);
  }

  Map<String, dynamic> toJson() => {};
}
