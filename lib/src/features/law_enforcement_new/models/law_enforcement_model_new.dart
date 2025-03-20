import 'package:db_atom/index.dart';

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
   int? id;
   String? slNo;
   String? inputDate;
   Organisation? location;
   Organisation? locationRegion;
   String? timeOfVisit;
   bool officialCardVerified;
   Organisation? visitPurpose;
   bool documentVerified;
   List<ImageContent>? images;
   List<Organisation>? entities;
   bool visitorInUniform;
   String? dbOfficialEmail;
   Organisation? dbOfficialEmailDepartment;
   String? dbOfficialAccompaniedEmail;
   User? entrySecurity;
   String? additionalInformation;
   int? status;
   String? modifiedDate;
   String? modifiedBy;
   // List<MailList>? mailList;
   String? entityDesc;
   String? entrySecurityName;
   String? lock;
   bool? isEligibleToEdit;
   bool? isEligibleToCancel;


  LawEnforcementModelNew({
    this.id,
    this.slNo,
    this.inputDate,
    this.location,
    this.locationRegion,
    this.timeOfVisit,
    this.officialCardVerified = false,
    this.visitPurpose,
    this.documentVerified = false,
    this.images,
    this.entities,
    this.visitorInUniform = false,
    this.dbOfficialEmail,
    this.dbOfficialEmailDepartment,
    this.dbOfficialAccompaniedEmail,
    this.entrySecurity,
    this.additionalInformation,
    this.status,
    this.modifiedDate,
    this.modifiedBy,
    // this.mailList,
    this.entityDesc,
    this.entrySecurityName,
    this.lock,
    this.isEligibleToEdit,
    this.isEligibleToCancel,
  });

  LawEnforcementModelNew.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        slNo = json['slNo'] as String?,
        inputDate = json['inputDate'] as String?,
        location = (json['location'] as Map<String,dynamic>?) != null ? Organisation.fromJson(json['location'] as Map<String,dynamic>) : null,
        locationRegion = (json['locationRegion'] as Map<String,dynamic>?) != null ? Organisation.fromJson(json['locationRegion'] as Map<String,dynamic>) : null,
        timeOfVisit = json['timeOfVisit'] as String?,
        officialCardVerified = json['officialCardVerified'] as bool,
        visitPurpose = (json['visitPurpose'] as Map<String,dynamic>?) != null ? Organisation.fromJson(json['visitPurpose'] as Map<String,dynamic>) : null,
        documentVerified = json['documentVerified'] as bool,
        images = (json['images'] as List<dynamic>?)
            ?.map((e) => ImageContent.fromJson(e as Map<String, dynamic>))
            .toList(),
        entities = (json['entities'] as List?)?.map((dynamic e) => Organisation.fromJson(e as Map<String,dynamic>)).toList(),
        visitorInUniform = json['visitorInUniform'] as bool,
        dbOfficialEmail = json['dbOfficialEmail'] as String?,
        dbOfficialEmailDepartment = (json['dbOfficialEmailDepartment'] as Map<String,dynamic>?) != null ? Organisation.fromJson(json['dbOfficialEmailDepartment'] as Map<String,dynamic>) : null,
        dbOfficialAccompaniedEmail = json['dbOfficialAccompaniedEmail'] as String?,
        entrySecurity = (json['entrySecurity'] as Map<String,dynamic>?) != null ? User.fromJson(json['entrySecurity'] as Map<String,dynamic>) : null,
        additionalInformation = json['additionalInformation'] as String?,
        status = json['status'] as int?,
        modifiedDate = json['modifiedDate'] as String?,
        modifiedBy = json['modifiedBy'] as String?,
        // mailList = (json['mailList'] as List?)?.map((dynamic e) => MailList.fromJson(e as Map<String,dynamic>)).toList(),
        entityDesc = json['entityDesc'] as String?,
        entrySecurityName = json['entrySecurityName'] as String?,
        lock = json['lock'] as String?,
        isEligibleToEdit = json['isEligibleToEdit'] as bool?,
        isEligibleToCancel = json['isEligibleToCancel'] as bool?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'slNo' : slNo,
    'inputDate' : inputDate,
    'location' : location?.toJson(),
    'locationRegion' : locationRegion?.toJson(),
    'timeOfVisit' : timeOfVisit,
    'officialCardVerified' : officialCardVerified,
    'visitPurpose' : visitPurpose?.toJson(),
    'documentVerified' : documentVerified,
    'images' : images,
    'entities' : entities?.map((e) => e.toJson()).toList(),
    'visitorInUniform' : visitorInUniform,
    'dbOfficialEmail' : dbOfficialEmail,
    'dbOfficialEmailDepartment' : dbOfficialEmailDepartment?.toJson(),
    'dbOfficialAccompaniedEmail' : dbOfficialAccompaniedEmail,
    'entrySecurity' : entrySecurity?.toJson(),
    'additionalInformation' : additionalInformation,
    'status' : status,
    'modifiedDate' : modifiedDate,
    'modifiedBy' : modifiedBy,
    // 'mailList' : mailList?.map((e) => e.toJson()).toList(),
    'entityDesc' : entityDesc,
    'entrySecurityName' : entrySecurityName,
    'lock' : lock,
    'isEligibleToEdit' : isEligibleToEdit,
    'isEligibleToCancel' : isEligibleToCancel
  };
}


