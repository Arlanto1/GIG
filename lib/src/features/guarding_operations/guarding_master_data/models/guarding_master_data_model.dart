class GuardingMasterDataModel {
  final List<GuardingMastersDataModel>? data;
  final int? totalCount;
  final int? currentPageNo;
  final int? totalPageCount;

  GuardingMasterDataModel({
    this.data,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  GuardingMasterDataModel.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as List?)?.map((dynamic e) => GuardingMastersDataModel.fromJson(e as Map<String,dynamic>)).toList(),
        totalCount = json['totalCount'] as int?,
        currentPageNo = json['currentPageNo'] as int?,
        totalPageCount = json['totalPageCount'] as int?;

  Map<String, dynamic> toJson() => {
    'data' : data?.map((e) => e.toJson()).toList(),
    'totalCount' : totalCount,
    'currentPageNo' : currentPageNo,
    'totalPageCount' : totalPageCount
  };
}

class GuardingMastersDataModel {
  final String? guardingMasterId;
  final int? id;
  final String? slNo;
  final EntrySecurity? entrySecurity;
  final String? inputDate;
  final int? status;
  final int? guardRank;
  final String? employeeCode;
  final String? dbEmployeeId;
  final int? dutyType;
  final int? gender;
  final String? contactNo;
  final int? maritalStatus;
  final int? typeOfDeployment;
  final bool? deploymentOrderSubmitted;
  final List<dynamic>? deploymentOrders;
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
  final String? permanentAddress;
  final String? localAddress;
  final List<dynamic>? qualifications;
  final List<dynamic>? pvc;
  final bool? trainingCertificateProvided;
  final List<dynamic>? trainingCertificates;
  final List<dynamic>? medicalCertificates;
  final int? systemAccess;
  final bool? onboarded;
  final String? esicNo;
  final String? uanNo;
  final bool? msgbExempted;
  final int? msgbFormBSubmitted;
  final int? staffMsgbCompliant;
  final bool? csrParticipation;
  final bool? specialAchievement;
  final String? specialAchievementText;
  final String? additionalInitiatives;
  final String? guardingPOC;

  GuardingMastersDataModel({
    this.guardingMasterId,
    this.id,
    this.slNo,
    this.entrySecurity,
    this.inputDate,
    this.status,
    this.guardRank,
    this.employeeCode,
    this.dbEmployeeId,
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
    this.guardingPOC,
  });

  GuardingMastersDataModel.fromJson(Map<String, dynamic> json)
      : guardingMasterId = json['guardingMasterId'] as String?,
        id = json['id'] as int?,
        slNo = json['slNo'] as String?,
        entrySecurity = (json['entrySecurity'] as Map<String,dynamic>?) != null ? EntrySecurity.fromJson(json['entrySecurity'] as Map<String,dynamic>) : null,
        inputDate = json['inputDate'] as String?,
        status = json['status'] as int?,
        guardRank = json['guardRank'] as int?,
        employeeCode = json['employeeCode'] as String?,
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
        guardingPOC = json['guardingPOC'] as String?;

  Map<String, dynamic> toJson() => {
    'guardingMasterId' : guardingMasterId,
    'id' : id,
    'slNo' : slNo,
    'entrySecurity' : entrySecurity?.toJson(),
    'inputDate' : inputDate,
    'status' : status,
    'guardRank' : guardRank,
    'employeeCode' : employeeCode,
    'dbEmployeeId' : dbEmployeeId,
    'dutyType' : dutyType,
    'gender' : gender,
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
    'guardingPOC' : guardingPOC
  };
}

class EntrySecurity {
  final int? userId;
  final String? userName;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final List<Roles>? roles;
  final List<RoleExtensions>? roleExtensions;
  final List<dynamic>? notApprovedRoles;
  final List<dynamic>? notApprovedRoleExtensions;
  final String? name;
  final String? userStatus;

  EntrySecurity({
    this.userId,
    this.userName,
    this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.roles,
    this.roleExtensions,
    this.notApprovedRoles,
    this.notApprovedRoleExtensions,
    this.name,
    this.userStatus,
  });

  EntrySecurity.fromJson(Map<String, dynamic> json)
      : userId = json['userId'] as int?,
        userName = json['userName'] as String?,
        email = json['email'] as String?,
        firstName = json['firstName'] as String?,
        lastName = json['lastName'] as String?,
        phone = json['phone'] as String?,
        roles = (json['roles'] as List?)?.map((dynamic e) => Roles.fromJson(e as Map<String,dynamic>)).toList(),
        roleExtensions = (json['roleExtensions'] as List?)?.map((dynamic e) => RoleExtensions.fromJson(e as Map<String,dynamic>)).toList(),
        notApprovedRoles = json['notApprovedRoles'] as List?,
        notApprovedRoleExtensions = json['notApprovedRoleExtensions'] as List?,
        name = json['name'] as String?,
        userStatus = json['userStatus'] as String?;

  Map<String, dynamic> toJson() => {
    'userId' : userId,
    'userName' : userName,
    'email' : email,
    'firstName' : firstName,
    'lastName' : lastName,
    'phone' : phone,
    'roles' : roles?.map((e) => e.toJson()).toList(),
    'roleExtensions' : roleExtensions?.map((e) => e.toJson()).toList(),
    'notApprovedRoles' : notApprovedRoles,
    'notApprovedRoleExtensions' : notApprovedRoleExtensions,
    'name' : name,
    'userStatus' : userStatus
  };
}

class Roles {
  final int? roleId;
  final String? application;
  final String? roleName;
  final List<RoleExtensions>? roleExtensions;
  final String? name;

  Roles({
    this.roleId,
    this.application,
    this.roleName,
    this.roleExtensions,
    this.name,
  });

  Roles.fromJson(Map<String, dynamic> json)
      : roleId = json['roleId'] as int?,
        application = json['application'] as String?,
        roleName = json['roleName'] as String?,
        roleExtensions = (json['roleExtensions'] as List?)?.map((dynamic e) => RoleExtensions.fromJson(e as Map<String,dynamic>)).toList(),
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {
    'roleId' : roleId,
    'application' : application,
    'roleName' : roleName,
    'roleExtensions' : roleExtensions?.map((e) => e.toJson()).toList(),
    'name' : name
  };
}

class RoleExtensions {
  final int? roleExtensionId;
  final int? roleId;
  final String? displayName;
  final String? area;
  final String? filter;
  final dynamic rootNodeId;
  final dynamic nodeId;
  final dynamic accessRight;

  RoleExtensions({
    this.roleExtensionId,
    this.roleId,
    this.displayName,
    this.area,
    this.filter,
    this.rootNodeId,
    this.nodeId,
    this.accessRight,
  });

  RoleExtensions.fromJson(Map<String, dynamic> json)
      : roleExtensionId = json['roleExtensionId'] as int?,
        roleId = json['roleId'] as int?,
        displayName = json['displayName'] as String?,
        area = json['area'] as String?,
        filter = json['filter'] as String?,
        rootNodeId = json['rootNodeId'],
        nodeId = json['nodeId'],
        accessRight = json['accessRight'];

  Map<String, dynamic> toJson() => {
    'roleExtensionId' : roleExtensionId,
    'roleId' : roleId,
    'displayName' : displayName,
    'area' : area,
    'filter' : filter,
    'rootNodeId' : rootNodeId,
    'nodeId' : nodeId,
    'accessRight' : accessRight
  };
}
