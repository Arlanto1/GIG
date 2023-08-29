class GuardingMasterDataModel {
  List<GuardingMastersDataModel>? data;
  int? totalCount;
  int? currentPageNo;
  int? totalPageCount;

  GuardingMasterDataModel(
      {this.data, this.totalCount, this.currentPageNo, this.totalPageCount});

  GuardingMasterDataModel.fromJson(Map<String, dynamic> json) {
    data = json["data"] == null
        ? null
        : (json["data"] as List)
            .map((e) => GuardingMastersDataModel.fromJson(e))
            .toList();
    totalCount = json["totalCount"];
    currentPageNo = json["currentPageNo"];
    totalPageCount = json["totalPageCount"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    _data["totalCount"] = totalCount;
    _data["currentPageNo"] = currentPageNo;
    _data["totalPageCount"] = totalPageCount;
    return _data;
  }
}

class GuardingMastersDataModel {
  int? id;
  String? slNo;
  Location? location;
  LocationRegion? locationRegion;
  EntrySecurity? entrySecurity;
  String? inputDate;
  int? status;
  int? guardRank;
  String? employeeCode;
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
  String? guardingPoc;

  GuardingMastersDataModel(
      {this.id,
      this.slNo,
      this.location,
      this.locationRegion,
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
      this.history,
      this.guardingPoc});

  GuardingMastersDataModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    slNo = json["slNo"];
    location =
        json["location"] == null ? null : Location.fromJson(json["location"]);
    locationRegion = json["locationRegion"] == null
        ? null
        : LocationRegion.fromJson(json["locationRegion"]);
    entrySecurity = json["entrySecurity"] == null
        ? null
        : EntrySecurity.fromJson(json["entrySecurity"]);
    inputDate = json["inputDate"];
    status = json["status"];
    guardRank = json["guardRank"];
    employeeCode = json["employeeCode"];
    dbEmployeeId = json["dbEmployeeId"];
    dutyType = json["dutyType"];
    gender = json["gender"];
    contactNo = json["contactNo"];
    maritalStatus = json["maritalStatus"];
    typeOfDeployment = json["typeOfDeployment"];
    deploymentOrderSubmitted = json["deploymentOrderSubmitted"];
    deploymentOrders = json["deploymentOrders"] ?? [];
    physicallyFit = json["physicallyFit"];
    localLanguage = json["localLanguage"];
    localLangProficiencyR = json["localLangProficiencyR"];
    hindiLangProficiencyR = json["hindiLangProficiencyR"];
    englishLangProficiencyR = json["englishLangProficiencyR"];
    localLangProficiencyW = json["localLangProficiencyW"];
    hindiLangProficiencyW = json["hindiLangProficiencyW"];
    englishLangProficiencyW = json["englishLangProficiencyW"];
    localLangProficiencyS = json["localLangProficiencyS"];
    hindiLangProficiencyS = json["hindiLangProficiencyS"];
    englishLangProficiencyS = json["englishLangProficiencyS"];
    securityExperience = json["securityExperience"];
    permanentAddress = json["permanentAddress"];
    localAddress = json["localAddress"];
    qualifications = json["qualifications"] ?? [];
    pvc = json["pvc"] ?? [];
    trainingCertificateProvided = json["trainingCertificateProvided"];
    trainingCertificates = json["trainingCertificates"] ?? [];
    medicalCertificates = json["medicalCertificates"] ?? [];
    systemAccess = json["systemAccess"];
    onboarded = json["onboarded"];
    esicNo = json["esicNo"];
    uanNo = json["uanNo"];
    msgbExempted = json["msgbExempted"];
    msgbFormBSubmitted = json["msgbFormBSubmitted"];
    staffMsgbCompliant = json["staffMsgbCompliant"];
    csrParticipation = json["csrParticipation"];
    specialAchievement = json["specialAchievement"];
    specialAchievementText = json["specialAchievementText"];
    additionalInitiatives = json["additionalInitiatives"];
    history = json["history"] ?? [];
    guardingPoc = json["guardingPOC"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["slNo"] = slNo;
    if (location != null) {
      _data["location"] = location?.toJson();
    }
    if (locationRegion != null) {
      _data["locationRegion"] = locationRegion?.toJson();
    }
    if (entrySecurity != null) {
      _data["entrySecurity"] = entrySecurity?.toJson();
    }
    _data["inputDate"] = inputDate;
    _data["status"] = status;
    _data["guardRank"] = guardRank;
    _data["employeeCode"] = employeeCode;
    _data["dbEmployeeId"] = dbEmployeeId;
    _data["dutyType"] = dutyType;
    _data["gender"] = gender;
    _data["contactNo"] = contactNo;
    _data["maritalStatus"] = maritalStatus;
    _data["typeOfDeployment"] = typeOfDeployment;
    _data["deploymentOrderSubmitted"] = deploymentOrderSubmitted;
    if (deploymentOrders != null) {
      _data["deploymentOrders"] = deploymentOrders;
    }
    _data["physicallyFit"] = physicallyFit;
    _data["localLanguage"] = localLanguage;
    _data["localLangProficiencyR"] = localLangProficiencyR;
    _data["hindiLangProficiencyR"] = hindiLangProficiencyR;
    _data["englishLangProficiencyR"] = englishLangProficiencyR;
    _data["localLangProficiencyW"] = localLangProficiencyW;
    _data["hindiLangProficiencyW"] = hindiLangProficiencyW;
    _data["englishLangProficiencyW"] = englishLangProficiencyW;
    _data["localLangProficiencyS"] = localLangProficiencyS;
    _data["hindiLangProficiencyS"] = hindiLangProficiencyS;
    _data["englishLangProficiencyS"] = englishLangProficiencyS;
    _data["securityExperience"] = securityExperience;
    _data["permanentAddress"] = permanentAddress;
    _data["localAddress"] = localAddress;
    if (qualifications != null) {
      _data["qualifications"] = qualifications;
    }
    if (pvc != null) {
      _data["pvc"] = pvc;
    }
    _data["trainingCertificateProvided"] = trainingCertificateProvided;
    if (trainingCertificates != null) {
      _data["trainingCertificates"] = trainingCertificates;
    }
    if (medicalCertificates != null) {
      _data["medicalCertificates"] = medicalCertificates;
    }
    _data["systemAccess"] = systemAccess;
    _data["onboarded"] = onboarded;
    _data["esicNo"] = esicNo;
    _data["uanNo"] = uanNo;
    _data["msgbExempted"] = msgbExempted;
    _data["msgbFormBSubmitted"] = msgbFormBSubmitted;
    _data["staffMsgbCompliant"] = staffMsgbCompliant;
    _data["csrParticipation"] = csrParticipation;
    _data["specialAchievement"] = specialAchievement;
    _data["specialAchievementText"] = specialAchievementText;
    _data["additionalInitiatives"] = additionalInitiatives;
    if (history != null) {
      _data["history"] = history;
    }
    _data["guardingPOC"] = guardingPoc;
    return _data;
  }
}

class EntrySecurity {
  int? userId;
  String? userName;
  String? email;
  String? firstName;
  String? lastName;
  String? phone;
  List<Roles>? roles;
  List<RoleExtensions1>? roleExtensions;
  List<dynamic>? notApprovedRoles;
  List<dynamic>? notApprovedRoleExtensions;
  String? name;
  String? userStatus;

  EntrySecurity(
      {this.userId,
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
      this.userStatus});

  EntrySecurity.fromJson(Map<String, dynamic> json) {
    userId = json["userId"];
    userName = json["userName"];
    email = json["email"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    phone = json["phone"];
    roles = json["roles"] == null
        ? null
        : (json["roles"] as List).map((e) => Roles.fromJson(e)).toList();
    roleExtensions = json["roleExtensions"] == null
        ? null
        : (json["roleExtensions"] as List)
            .map((e) => RoleExtensions1.fromJson(e))
            .toList();
    notApprovedRoles = json["notApprovedRoles"] ?? [];
    notApprovedRoleExtensions = json["notApprovedRoleExtensions"] ?? [];
    name = json["name"];
    userStatus = json["userStatus"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["userId"] = userId;
    _data["userName"] = userName;
    _data["email"] = email;
    _data["firstName"] = firstName;
    _data["lastName"] = lastName;
    _data["phone"] = phone;
    if (roles != null) {
      _data["roles"] = roles?.map((e) => e.toJson()).toList();
    }
    if (roleExtensions != null) {
      _data["roleExtensions"] = roleExtensions?.map((e) => e.toJson()).toList();
    }
    if (notApprovedRoles != null) {
      _data["notApprovedRoles"] = notApprovedRoles;
    }
    if (notApprovedRoleExtensions != null) {
      _data["notApprovedRoleExtensions"] = notApprovedRoleExtensions;
    }
    _data["name"] = name;
    _data["userStatus"] = userStatus;
    return _data;
  }
}

class RoleExtensions1 {
  int? roleExtensionId;
  int? roleId;
  String? displayName;
  String? area;
  String? filter;
  dynamic rootNodeId;
  dynamic nodeId;
  dynamic accessRight;

  RoleExtensions1(
      {this.roleExtensionId,
      this.roleId,
      this.displayName,
      this.area,
      this.filter,
      this.rootNodeId,
      this.nodeId,
      this.accessRight});

  RoleExtensions1.fromJson(Map<String, dynamic> json) {
    roleExtensionId = json["roleExtensionId"];
    roleId = json["roleId"];
    displayName = json["displayName"];
    area = json["area"];
    filter = json["filter"];
    rootNodeId = json["rootNodeId"];
    nodeId = json["nodeId"];
    accessRight = json["accessRight"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["roleExtensionId"] = roleExtensionId;
    _data["roleId"] = roleId;
    _data["displayName"] = displayName;
    _data["area"] = area;
    _data["filter"] = filter;
    _data["rootNodeId"] = rootNodeId;
    _data["nodeId"] = nodeId;
    _data["accessRight"] = accessRight;
    return _data;
  }
}

class Roles {
  int? roleId;
  String? application;
  String? roleName;
  List<RoleExtensions>? roleExtensions;
  String? name;

  Roles(
      {this.roleId,
      this.application,
      this.roleName,
      this.roleExtensions,
      this.name});

  Roles.fromJson(Map<String, dynamic> json) {
    roleId = json["roleId"];
    application = json["application"];
    roleName = json["roleName"];
    roleExtensions = json["roleExtensions"] == null
        ? null
        : (json["roleExtensions"] as List)
            .map((e) => RoleExtensions.fromJson(e))
            .toList();
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["roleId"] = roleId;
    _data["application"] = application;
    _data["roleName"] = roleName;
    if (roleExtensions != null) {
      _data["roleExtensions"] = roleExtensions?.map((e) => e.toJson()).toList();
    }
    _data["name"] = name;
    return _data;
  }
}

class RoleExtensions {
  int? roleExtensionId;
  int? roleId;
  String? displayName;
  String? area;
  String? filter;
  dynamic rootNodeId;
  dynamic nodeId;
  dynamic accessRight;

  RoleExtensions(
      {this.roleExtensionId,
      this.roleId,
      this.displayName,
      this.area,
      this.filter,
      this.rootNodeId,
      this.nodeId,
      this.accessRight});

  RoleExtensions.fromJson(Map<String, dynamic> json) {
    roleExtensionId = json["roleExtensionId"];
    roleId = json["roleId"];
    displayName = json["displayName"];
    area = json["area"];
    filter = json["filter"];
    rootNodeId = json["rootNodeId"];
    nodeId = json["nodeId"];
    accessRight = json["accessRight"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["roleExtensionId"] = roleExtensionId;
    _data["roleId"] = roleId;
    _data["displayName"] = displayName;
    _data["area"] = area;
    _data["filter"] = filter;
    _data["rootNodeId"] = rootNodeId;
    _data["nodeId"] = nodeId;
    _data["accessRight"] = accessRight;
    return _data;
  }
}

class LocationRegion {
  int? id;
  String? name;

  LocationRegion({this.id, this.name});

  LocationRegion.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    return _data;
  }
}

class Location {
  int? id;
  String? name;

  Location({this.id, this.name});

  Location.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    return _data;
  }
}
