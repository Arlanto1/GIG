import '../../../../models/entity.dart';
import '../../../../models/entry_security.dart';
import '../../../../models/history.dart';

class GuardingMasterDataResponse {
  GuardingMasterDataResponse({
    required this.items,
    required this.totalCount,
    required this.currentPageNo,
    required this.totalPageCount,
  });

  final List<GuardingMastersDataModel> items;
  final int? totalCount;
  final int? currentPageNo;
  final int? totalPageCount;

  factory GuardingMasterDataResponse.fromJson(Map<String, dynamic> json){
    return GuardingMasterDataResponse(
      items: json["data"] == null ? [] : List<GuardingMastersDataModel>.from(json["data"]!.map((x) => GuardingMastersDataModel.fromJson(x))),
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
     this.deploymentOrderSubmitted,
     required this.deploymentOrders,
     this.dateOfJoining,
     this.height,
     this.weight,
     this.chest,
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

  final int? id;
  late final String? slNo;
  late final Entity? location;
  final Entity? locationRegion;
  late final Entity? entity;
  late final EntrySecurity? entrySecurity;
  late final String? inputDate;
  final int? status;
  final Entity? vendor;
  final EntrySecurity? guard;
  final int? guardRank;
  final String? employeeCode;
  final String? dbEmployeeId;
  final int? dutyType;
  final int? gender;
  final String? contactNo;
  final int? dateOfBirth;
  final int? maritalStatus;
  final int? dependentsNo;
  final int? typeOfDeployment;
  final bool? deploymentOrderSubmitted;
  final List<BioData> deploymentOrders;
  final String? dateOfJoining;
  final int? height;
  final int? weight;
  final int? chest;
  final bool? physicallyFit;
  final String? localLanguage;
  final bool? localLangProficiencyR;
  final bool? hindiLangProficiencyR;
  final bool? englishLangProficiencyR;
  final bool? localLangProficiencyW;
  final bool? hindiLangProficiencyW;
  final bool? englishLangProficiencyW;
  final bool? localLangProficiencyS;
  final bool? hindiLangProficiencyS;
  final bool? englishLangProficiencyS;
  final String? securityExperience;
  final BioData? bioData;
  final BioData? photoGraph;
  final String? permanentAddress;
  final BioData? permanentAddressProof;
  final String? localAddress;
  final BioData? localAddressProof;
  final List<Entity> qualifications;
  final int? pvcIssuedDate;
  final int? pvcExpiryDate;
  final List<BioData> pvc;
  final bool? trainingCertificateProvided;
  final List<BioData> trainingCertificates;
  final int? medicalCertificateValidUntil;
  final List<BioData> medicalCertificates;
  final int? systemAccess;
  final bool? onboarded;
  final String? esicNo;
  final String? uanNo;
  final bool? msgbExempted;
  final int? msgbExemptionDate;
  final int? msgbFormBSubmitted;
  final int? staffMsgbCompliant;
  final bool? csrParticipation;
  final bool? specialAchievement;
  final String? specialAchievementText;
  final String? additionalInitiatives;
  final List<History> history;
  final String? guardingPoc;
  final String? csrParticipationDates;
  final int? modifiedDate;
  final String? modifiedBy;
  final int? covidFirstDoseDate;
  final int? covidSecondDoseDate;
  final int? covidPrecautionaryDoseDate;
  final int? ertCertificationDate;
  final int? firstAidTrainingCompletionDate;

  factory GuardingMastersDataModel.fromJson(Map<String, dynamic> json){
    return GuardingMastersDataModel(
      id: json["id"],
      slNo: json["slNo"],
      location: json["location"] == null ? null : Entity.fromJson(json["location"]),
      locationRegion: json["locationRegion"] == null ? null : Entity.fromJson(json["locationRegion"]),
      entity: json["entity"] == null ? null : Entity.fromJson(json["entity"]),
      entrySecurity: json["entrySecurity"] == null ? null : EntrySecurity.fromJson(json["entrySecurity"]),
      inputDate: json["inputDate"],
      status: json["status"],
      vendor: json["vendor"] == null ? null : Entity.fromJson(json["vendor"]),
      guard: json["guard"] == null ? null : EntrySecurity.fromJson(json["guard"]),
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
      deploymentOrders: json["deploymentOrders"] == null ? [] : List<BioData>.from(json["deploymentOrders"]!.map((x) => BioData.fromJson(x))),
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
      bioData: json["bioData"] == null ? null : BioData.fromJson(json["bioData"]),
      photoGraph: json["photoGraph"] == null ? null : BioData.fromJson(json["photoGraph"]),
      permanentAddress: json["permanentAddress"],
      permanentAddressProof: json["permanentAddressProof"] == null ? null : BioData.fromJson(json["permanentAddressProof"]),
      localAddress: json["localAddress"],
      localAddressProof: json["localAddressProof"] == null ? null : BioData.fromJson(json["localAddressProof"]),
      qualifications: json["qualifications"] == null ? [] : List<Entity>.from(json["qualifications"]!.map((x) => Entity.fromJson(x))),
      pvcIssuedDate: json["pvcIssuedDate"],
      pvcExpiryDate: json["pvcExpiryDate"],
      pvc: json["pvc"] == null ? [] : List<BioData>.from(json["pvc"]!.map((x) => BioData.fromJson(x))),
      trainingCertificateProvided: json["trainingCertificateProvided"],
      trainingCertificates: json["trainingCertificates"] == null ? [] : List<BioData>.from(json["trainingCertificates"]!.map((x) => BioData.fromJson(x))),
      medicalCertificateValidUntil: json["medicalCertificateValidUntil"],
      medicalCertificates: json["medicalCertificates"] == null ? [] : List<BioData>.from(json["medicalCertificates"]!.map((x) => BioData.fromJson(x))),
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
      history: json["history"] == null ? [] : List<History>.from(json["history"]!.map((x) => History.fromJson(x))),
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
    "trainingCertificates": trainingCertificates.map((x) => x.toJson()).toList(),
    "medicalCertificateValidUntil": medicalCertificateValidUntil,
    "medicalCertificates": medicalCertificates.map((x) => x.toJson()).toList(),
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

  factory BioData.fromJson(Map<String, dynamic> json){
    return BioData(
      id: json["id"],
      ownerName: json["ownerName"],
      contentType: json["contentType"],
      uploadDate: json["uploadDate"],
      guardingMasterId: json["guardingMasterId"],
      type: json["type"],
      title: json["title"],
      deletable: json["deletable"],
      imageStreamData: json["imageStreamData"] == null ? null : ImageStreamData.fromJson(json["imageStreamData"]),
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
  final Map<String,dynamic> json;

  factory ImageStreamData.fromJson(Map<String, dynamic> json){
    return ImageStreamData(
        json: json
    );
  }

  Map<String, dynamic> toJson() => {
  };

}

