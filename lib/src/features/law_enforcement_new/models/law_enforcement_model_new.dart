class LawEnforcementResponseModel {
  final List<LawEnforcementModelNew>? list;
  final List<dynamic>? data;
  final int? totalCount;
  final int? currentPageNo;
  final int? totalPageCount;

  LawEnforcementResponseModel({
    this.list,
    this.data,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  LawEnforcementResponseModel.fromJson(Map<String, dynamic> json)
      : list = (json['list'] as List?)?.map((dynamic e) => LawEnforcementModelNew.fromJson(e as Map<String,dynamic>)).toList(),
        data = json['data'] as List?,
        totalCount = json['totalCount'] as int?,
        currentPageNo = json['currentPageNo'] as int?,
        totalPageCount = json['totalPageCount'] as int?;

  Map<String, dynamic> toJson() => {
    'list' : list?.map((e) => e.toJson()).toList(),
    'data' : data,
    'totalCount' : totalCount,
    'currentPageNo' : currentPageNo,
    'totalPageCount' : totalPageCount
  };
}

class LawEnforcementModelNew {
  final int? id;
  final String? slNo;
  final String? inputDate;
  final Location? location;
  final LocationRegion? locationRegion;
  final String? timeOfVisit;
  final bool? officialCardVerified;
  final bool? documentVerified;
  final List<dynamic>? images;
  final bool? visitorInUniform;
  final String? dbOfficialEmail;
  final EntrySecurity? entrySecurity;
  final int? status;
  final List<dynamic>? visitingOfficials;
  final String? entityDesc;
  final String? entrySecurityName;

  LawEnforcementModelNew({
    this.id,
    this.slNo,
    this.inputDate,
    this.location,
    this.locationRegion,
    this.timeOfVisit,
    this.officialCardVerified,
    this.documentVerified,
    this.images,
    this.visitorInUniform,
    this.dbOfficialEmail,
    this.entrySecurity,
    this.status,
    this.visitingOfficials,
    this.entityDesc,
    this.entrySecurityName,
  });

  LawEnforcementModelNew.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        slNo = json['slNo'] as String?,
        inputDate = json['inputDate'] as String?,
        location = (json['location'] as Map<String,dynamic>?) != null ? Location.fromJson(json['location'] as Map<String,dynamic>) : null,
        locationRegion = (json['locationRegion'] as Map<String,dynamic>?) != null ? LocationRegion.fromJson(json['locationRegion'] as Map<String,dynamic>) : null,
        timeOfVisit = json['timeOfVisit'] as String?,
        officialCardVerified = json['officialCardVerified'] as bool?,
        documentVerified = json['documentVerified'] as bool?,
        images = json['images'] as List?,
        visitorInUniform = json['visitorInUniform'] as bool?,
        dbOfficialEmail = json['dbOfficialEmail'] as String?,
        entrySecurity = (json['entrySecurity'] as Map<String,dynamic>?) != null ? EntrySecurity.fromJson(json['entrySecurity'] as Map<String,dynamic>) : null,
        status = json['status'] as int?,
        visitingOfficials = json['visitingOfficials'] as List?,
        entityDesc = json['entityDesc'] as String?,
        entrySecurityName = json['entrySecurityName'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'slNo' : slNo,
    'inputDate' : inputDate,
    'location' : location?.toJson(),
    'locationRegion' : locationRegion?.toJson(),
    'timeOfVisit' : timeOfVisit,
    'officialCardVerified' : officialCardVerified,
    'documentVerified' : documentVerified,
    'images' : images,
    'visitorInUniform' : visitorInUniform,
    'dbOfficialEmail' : dbOfficialEmail,
    'entrySecurity' : entrySecurity?.toJson(),
    'status' : status,
    'visitingOfficials' : visitingOfficials,
    'entityDesc' : entityDesc,
    'entrySecurityName' : entrySecurityName
  };
}

class Location {
  final int? id;
  final String? name;
  final String? keyname;
  final String? description;

  Location({
    this.id,
    this.name,
    this.keyname,
    this.description,
  });

  Location.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        keyname = json['keyname'] as String?,
        description = json['description'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'keyname' : keyname,
    'description' : description
  };
}

class LocationRegion {
  final int? id;
  final String? name;
  final String? keyname;
  final String? description;

  LocationRegion({
    this.id,
    this.name,
    this.keyname,
    this.description,
  });

  LocationRegion.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        keyname = json['keyname'] as String?,
        description = json['description'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'keyname' : keyname,
    'description' : description
  };
}

class EntrySecurity {
  final int? userId;
  final String? userName;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final List<dynamic>? roles;
  final List<dynamic>? roleExtensions;
  final List<dynamic>? notApprovedRoles;
  final List<dynamic>? notApprovedRoleExtensions;
  final dynamic employeeId;
  final String? name;
  final String? userInfo;
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
    this.employeeId,
    this.name,
    this.userInfo,
    this.userStatus,
  });

  EntrySecurity.fromJson(Map<String, dynamic> json)
      : userId = json['userId'] as int?,
        userName = json['userName'] as String?,
        email = json['email'] as String?,
        firstName = json['firstName'] as String?,
        lastName = json['lastName'] as String?,
        phone = json['phone'] as String?,
        roles = json['roles'] as List?,
        roleExtensions = json['roleExtensions'] as List?,
        notApprovedRoles = json['notApprovedRoles'] as List?,
        notApprovedRoleExtensions = json['notApprovedRoleExtensions'] as List?,
        employeeId = json['employeeId'],
        name = json['name'] as String?,
        userInfo = json['userInfo'] as String?,
        userStatus = json['userStatus'] as String?;

  Map<String, dynamic> toJson() => {
    'userId' : userId,
    'userName' : userName,
    'email' : email,
    'firstName' : firstName,
    'lastName' : lastName,
    'phone' : phone,
    'roles' : roles,
    'roleExtensions' : roleExtensions,
    'notApprovedRoles' : notApprovedRoles,
    'notApprovedRoleExtensions' : notApprovedRoleExtensions,
    'employeeId' : employeeId,
    'name' : name,
    'userInfo' : userInfo,
    'userStatus' : userStatus
  };
}