import 'package:db_atom/index.dart';

class DayPassManagementResponseModel {
  List<DayPassManagementModel>? items;
  int? totalCount;
  int? currentPageNo;
  int? totalPageCount;

  DayPassManagementResponseModel({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  DayPassManagementResponseModel.fromJson(Map<String, dynamic> json)
      : items = (json['list'] as List?)
      ?.map((dynamic e) =>
      DayPassManagementModel.fromJson(e as Map<String, dynamic>))
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

class DayPassManagementModel {
   int? id;
   String? slNo;
   String? inputDate;
   Organisation? location;
   Organisation? locationRegion;
   int? status;
   User? entrySecurity;
   int? passType;
   Organisation? companyType;
   String? companyName;
   bool? exceptionalApproval;
   PassInfo? passInfo;
   String? startTime;
   String? endTime;
   List<dynamic>? evidenceDocuments;
   bool? escortedByHost;
   bool? idValidated;
   String? hostName;
   String? mifareNo;
   String? passNo;
   String? entrySecurityName;
   String? handOverSecurityName;
   String? lock;

  DayPassManagementModel({
    this.id,
    this.slNo,
    this.inputDate,
    this.location,
    this.locationRegion,
    this.status,
    this.entrySecurity,
    this.passType,
    this.companyType,
    this.companyName,
    this.exceptionalApproval,
    this.passInfo,
    this.startTime,
    this.endTime,
    this.evidenceDocuments,
    this.escortedByHost,
    this.idValidated,
    this.hostName,
    this.mifareNo,
    this.passNo,
    this.entrySecurityName,
    this.handOverSecurityName,
    this.lock,
  });

  DayPassManagementModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        slNo = json['slNo'] as String?,
        inputDate = json['inputDate'] as String?,
        location = (json['location'] as Map<String,dynamic>?) != null ? Organisation.fromJson(json['location'] as Map<String,dynamic>) : null,
        locationRegion = (json['locationRegion'] as Map<String,dynamic>?) != null ? Organisation.fromJson(json['locationRegion'] as Map<String,dynamic>) : null,
        status = json['status'] as int?,
        entrySecurity = (json['entrySecurity'] as Map<String,dynamic>?) != null ? User.fromJson(json['entrySecurity'] as Map<String,dynamic>) : null,
        passType = json['passType'] as int?,
        companyType = (json['companyType'] as Map<String,dynamic>?) != null ? Organisation.fromJson(json['companyType'] as Map<String,dynamic>) : null,
        companyName = json['companyName'] as String?,
        exceptionalApproval = json['exceptionalApproval'] as bool?,
        passInfo = (json['passInfo'] as Map<String,dynamic>?) != null ? PassInfo.fromJson(json['passInfo'] as Map<String,dynamic>) : null,
        startTime = json['startTime'] as String?,
        endTime = json['endTime'] as String?,
        evidenceDocuments = json['evidenceDocuments'] as List?,
        escortedByHost = json['escortedByHost'] as bool?,
        idValidated = json['idValidated'] as bool?,
        hostName = json['hostName'] as String?,
        mifareNo = json['mifareNo'] as String?,
        passNo = json['passNo'] as String?,
        entrySecurityName = json['entrySecurityName'] as String?,
        handOverSecurityName = json['handOverSecurityName'] as String?,
        lock = json['lock'] as String?;


      Map<String, dynamic> toJson() => {
    'id' : id,
    'slNo' : slNo,
    'inputDate' : inputDate,
    'location' : location?.toJson(),
    'locationRegion' : locationRegion?.toJson(),
    'status' : status,
    'entrySecurity' : entrySecurity?.toJson(),
    'passType' : passType,
    'companyType' : companyType?.toJson(),
    'companyName' : companyName,
    'exceptionalApproval' : exceptionalApproval,
    'passInfo' : passInfo?.toJson(),
    'startTime' : startTime,
    'endTime' : endTime,
    'evidenceDocuments' : evidenceDocuments,
    'escortedByHost' : escortedByHost,
    'idValidated' : idValidated,
    'hostName' : hostName,
    'mifareNo' : mifareNo,
    'passNo' : passNo,
    'entrySecurityName' : entrySecurityName,
    'handOverSecurityName' : handOverSecurityName,
        'lock':lock
  };
}

class PassInfo {
  final int? id;
  final int? passType;
  final String? passNo;
  final String? mifareNo;
  final String? expiryDate;
  final Organisation? location;
  final Organisation? region;
  final Organisation? entity;
  final bool? dws;
  final int? status;

  PassInfo({
    this.id,
    this.passType,
    this.passNo,
    this.mifareNo,
    this.expiryDate,
    this.location,
    this.region,
    this.entity,
    this.dws,
    this.status,
  });

  PassInfo.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        passType = json['passType'] as int?,
        passNo = json['passNo'] as String?,
        mifareNo = json['mifareNo'] as String?,
        expiryDate = json['expiryDate'] as String?,
        location = (json['location'] as Map<String,dynamic>?) != null ? Organisation.fromJson(json['location'] as Map<String,dynamic>) : null,
        region = (json['region'] as Map<String,dynamic>?) != null ? Organisation.fromJson(json['region'] as Map<String,dynamic>) : null,
        entity = (json['entity'] as Map<String,dynamic>?) != null ? Organisation.fromJson(json['entity'] as Map<String,dynamic>) : null,
        dws = json['dws'] as bool?,
        status = json['status'] as int?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'passType' : passType,
    'passNo' : passNo,
    'mifareNo' : mifareNo,
    'expiryDate' : expiryDate,
    'location' : location?.toJson(),
    'region' : region?.toJson(),
    'entity' : entity?.toJson(),
    'dws' : dws,
    'status' : status
  };
}



