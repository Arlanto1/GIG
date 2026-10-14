import 'package:db_atom/index.dart';

class VendorPassManagementResponse {
  List<VendorPassManagementModel>? items;
  int? totalCount;
  int? currentPageNo;
  int? totalPageCount;

  VendorPassManagementResponse({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  VendorPassManagementResponse.fromJson(Map<String, dynamic> json)
      : items = (json['list'] as List?)
      ?.map((dynamic e) =>
      VendorPassManagementModel.fromJson(e as Map<String, dynamic>))
      .toList(),
        totalCount = json['totalCount'] as int?,
        currentPageNo = json['currentPageNo'] as int?,
        totalPageCount = json['totalPageCount'] as int?;

  Map<String, dynamic> toJson() => {
    'list': items?.map((e) => e.toJson()).toList(),
    'totalCount': totalCount,
    'currentPageNo': currentPageNo,
    'totalPageCount': totalPageCount
  };
}

class VendorPassManagementModel {
  int? id;
  String? slNo;
  String? inputDate;
  Organisation? location;
  Organisation? locationRegion;
  Organisation? locationType;
  List<Organisation>? entities;
  int? status;
  User? entrySecurity;
  User? host;
  User? employee;
  User? handoverSecurity;
  int? passType;
  int? updatedStatus;
  Organisation? companyType;
  Organisation? vendorPassReason;
  Organisation? department;
  String? contactNo;
  String? visitorName;
  String? companyName;
  String? employeeName;
  String? email;
  String? employeeId;
  String? hostEmployeeId;
  bool escortedByHost;
  PassInfo? passInfo;
  String? startTime;
  String? endTime;
  List<ImageContent>? evidenceDocuments;
  bool? idValidated;
  String? hostName;
  String? mifareNo;
  String? passNo;
  String? passTypeName;
  String? entrySecurityName;
  String? handOverSecurityName;
  String? visitorComingFrom;
  String? visitingPurpose;
  int? idValidationType;
  String? escortedBy;
  String? escortedEmployeeId;
  String? returnedTime;
  String? lock;


  VendorPassManagementModel({
    this.id,
    this.slNo,
    this.inputDate,
    this.location,
    this.locationRegion,
    this.locationType,
    this.entities,
    this.status,
    this.entrySecurity,
    this.host,
    this.employee,
    this.handoverSecurity,
    this.passType,
    this.updatedStatus,
    this.companyType,
    this.vendorPassReason,
    this.department,
    this.contactNo,
    this.visitorName,
    this.companyName,
    this.employeeName,
    this.employeeId,
    this.email,
    this.hostEmployeeId,
    this.escortedByHost = false,
    this.passInfo,
    this.startTime,
    this.endTime,
    this.evidenceDocuments,
    this.idValidated,
    this.hostName,
    this.mifareNo,
    this.passNo,
    this.passTypeName,
    this.entrySecurityName,
    this.handOverSecurityName,
    this.visitorComingFrom,
    this.visitingPurpose,
    this.idValidationType,
    this.escortedBy,
    this.escortedEmployeeId,
    this.returnedTime,
    this.lock,
  });

  VendorPassManagementModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        slNo = json['slNo'] as String?,
        inputDate = json['inputDate'] as String?,
        location = (json['location'] as Map<String,dynamic>?) != null ? Organisation.fromJson(json['location'] as Map<String,dynamic>) : null,
        locationRegion = (json['locationRegion'] as Map<String,dynamic>?) != null ? Organisation.fromJson(json['locationRegion'] as Map<String,dynamic>) : null,
        locationType = (json['locationType'] as Map<String,dynamic>?) != null ? Organisation.fromJson(json['locationType'] as Map<String,dynamic>) : null,
      entities = (json['entities'] as List?)
            ?.map(
                (dynamic e) => Organisation.fromJson(e as Map<String, dynamic>))
            .toList(),
        status = json['status'] as int?,
        entrySecurity = (json['entrySecurity'] as Map<String,dynamic>?) != null ? User.fromJson(json['entrySecurity'] as Map<String,dynamic>) : null,
        host = (json['host'] as Map<String,dynamic>?) != null ? User.fromJson(json['host'] as Map<String,dynamic>) : null,
        employee = (json['employee'] as Map<String,dynamic>?) != null ? User.fromJson(json['employee'] as Map<String,dynamic>) : null,
        handoverSecurity = (json['handoverSecurity'] as Map<String,dynamic>?) != null ? User.fromJson(json['handoverSecurity'] as Map<String,dynamic>) : null,
      passType = json['passType'] as int?,
        updatedStatus= json['updatedStatus'] as int?,
        vendorPassReason = (json['vendorPassReason'] as Map<String,dynamic>?) != null ? Organisation.fromJson(json['vendorPassReason'] as Map<String,dynamic>) : null,
        department = (json['department'] as Map<String,dynamic>?) != null ? Organisation.fromJson(json['department'] as Map<String,dynamic>) : null,
        companyType = (json['companyType'] as Map<String,dynamic>?) != null ? Organisation.fromJson(json['companyType'] as Map<String,dynamic>) : null,
        employeeId = json['employeeId'] as String?,
        email= json['email'] as String?,
        hostEmployeeId = json['hostEmployeeId'] as String?,
        contactNo= json['contactNo'] as String?,
        visitorName = json['visitorName'] as String?,
        companyName=json['companyName'] as String?,
        employeeName = json['employeeName'] as String?,
        escortedByHost = json['escortedByHost'] as bool,
        passInfo = (json['passInfo'] as Map<String,dynamic>?) != null ? PassInfo.fromJson(json['passInfo'] as Map<String,dynamic>) : null,
        startTime = json['startTime'] as String?,
        endTime = json['endTime'] as String?,
        evidenceDocuments = (json['evidenceDocuments'] as List<dynamic>?)
            ?.map((e) => ImageContent.fromJson(e as Map<String, dynamic>))
            .toList(),
        hostName = json['hostName'] as String?,
        mifareNo = json['mifareNo'] as String?,
        passNo = json['passNo'] as String?,
        passTypeName= json['passTypeName'] as String?,
        entrySecurityName = json['entrySecurityName'] as String?,
        handOverSecurityName = json['handOverSecurityName'] as String?,
        visitorComingFrom= json['visitorComingFrom'] as String?,
        visitingPurpose = json['visitingPurpose'] as String?,
        idValidationType=json['idValidationType'] as int?,
        escortedBy=json['escortedBy'] as String?,
        escortedEmployeeId=json['escortedEmployeeId'] as String?,
        returnedTime= json['returnedTime'] as String?,
        lock = json['lock'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'slNo' : slNo,
    'inputDate' : inputDate,
    'location' : location?.toJson(),
    'locationRegion' : locationRegion?.toJson(),
    'locationType':locationType?.toJson(),
    'vendorPassReason':vendorPassReason?.toJson(),
    'department':department?.toJson(),
    'entities': entities?.map((e) => e.toJson()).toList(),
    'status' : status,
    'entrySecurity' : entrySecurity?.toJson(),
    'host':host?.toJson(),
    'employee':employee?.toJson(),
    'handoverSecurity':handoverSecurity?.toJson(),
    'passType' : passType,
    'updatedStatus':updatedStatus,
    'companyType' : companyType?.toJson(),
    'contactNo':contactNo,
    'visitorName' : visitorName,
    'companyName':companyName,
    'employeeName':employeeName,
    'employeeId': employeeId,
    'email':email,
    'hostEmployeeId':hostEmployeeId,
    'escortedByHost' : escortedByHost,
    'passInfo' : passInfo?.toJson(),
    'startTime' : startTime,
    'endTime' : endTime,
    'evidenceDocuments' : evidenceDocuments,
    'idValidated' : idValidated,
    'hostName' : hostName,
    'mifareNo' : mifareNo,
    'passNo' : passNo,
    'passTypeName':passTypeName,
    'entrySecurityName' : entrySecurityName,
    'handOverSecurityName' : handOverSecurityName,
    'visitorComingFrom':visitorComingFrom,
    'visitingPurpose':visitingPurpose,
    'idValidationType':idValidationType,
    'escortedBy':escortedBy,
    'escortedEmployeeId':escortedEmployeeId,
    'returnedTime':returnedTime,
    'lock':lock
  };
}


class PassInfo {
   int? id;
   int? passType;
   String? passNo;
   String? mifareNo;
   Organisation? location;
   Organisation? region;
   bool? dws;
   int? status;

  PassInfo({
    this.id,
    this.passType,
    this.passNo,
    this.mifareNo,
    this.location,
    this.region,
    this.dws,
    this.status,
  });

  PassInfo.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        passType = json['passType'] as int?,
        passNo = json['passNo'] as String?,
        mifareNo = json['mifareNo'] as String?,
        location = (json['location'] as Map<String,dynamic>?) != null ? Organisation.fromJson(json['location'] as Map<String,dynamic>) : null,
        region = (json['region'] as Map<String,dynamic>?) != null ? Organisation.fromJson(json['region'] as Map<String,dynamic>) : null,
        dws = json['dws'] as bool?,
        status = json['status'] as int?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'passType' : passType,
    'passNo' : passNo,
    'mifareNo' : mifareNo,
    'location' : location?.toJson(),
    'region' : region?.toJson(),
    'dws' : dws,
    'status' : status
  };
}
