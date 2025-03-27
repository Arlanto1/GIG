import 'package:db_atom/index.dart';

class ArticleFoundResponseModel {
  final List<ArticleFoundModel>? list;
  final int? totalCount;
  final int? currentPageNo;
  final int? totalPageCount;

  ArticleFoundResponseModel({
    this.list,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  ArticleFoundResponseModel.fromJson(Map<String, dynamic> json)
      : list = (json['list'] as List?)?.map((dynamic e) => ArticleFoundModel.fromJson(e as Map<String,dynamic>)).toList(),
        totalCount = json['totalCount'] as int?,
        currentPageNo = json['currentPageNo'] as int?,
        totalPageCount = json['totalPageCount'] as int?;

  Map<String, dynamic> toJson() => {
    'list' : list?.map((e) => e.toJson()).toList(),
    'totalCount' : totalCount,
    'currentPageNo' : currentPageNo,
    'totalPageCount' : totalPageCount
  };
}

class ArticleFoundModel {
  final int? id;
  final String? slNo;
  final String? inputDate;
  final Organisation? locationRegion;
  final int? typeOfAsset;
  final Organisation? typeOfArticle;
  final String? foundDate;
  final String? foundLocation;
  final String? additionalInformation;
  final int? quantity;
  final String? color;
  final List<ImageContent>? images;
  final bool? depositorDbEmp;
  final User? depositor;
  final String? employeeId;
  final Organisation? depositorDepartment;
  final bool? claimantDbEmp;
  final bool? claimantConfirmByEmail;
  final User? claimant;
  final bool? claimantNoSign;
  final ImageContent? claimantSign;
  final String? claimantEmployeeId;
  final Organisation? claimantDepartment;
  final String? handoverDate;
  final User? entrySecurity;
  final User? handoverSecurity;
  final int? status;
  final String? modifiedBy;
  final String? depositorName;
  final String? claimantName;
  final String? locationName;
  final String? entrySecurityName;
  final String? handOverSecurityName;
  final String? depositorDepartmentName;
  final String? claimantDepartmentName;
  final Organisation? location;

  ArticleFoundModel({
    this.id,
    this.slNo,
    this.inputDate,
    this.locationRegion,
    this.typeOfAsset,
    this.typeOfArticle,
    this.foundDate,
    this.foundLocation,
    this.additionalInformation,
    this.quantity,
    this.color,
    this.images,
    this.depositorDbEmp,
    this.depositor,
    this.employeeId,
    this.depositorDepartment,
    this.claimantDbEmp,
    this.claimantConfirmByEmail,
    this.claimant,
    this.claimantNoSign,
    this.claimantSign,
    this.claimantEmployeeId,
    this.claimantDepartment,
    this.handoverDate,
    this.entrySecurity,
    this.handoverSecurity,
    this.status,
    this.modifiedBy,
    this.depositorName,
    this.claimantName,
    this.locationName,
    this.entrySecurityName,
    this.handOverSecurityName,
    this.depositorDepartmentName,
    this.claimantDepartmentName,
    this.location,
  });

  ArticleFoundModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        slNo = json['slNo'] as String?,
        inputDate = json['inputDate'] as String?,
        locationRegion = (json['locationRegion'] as Map<String,dynamic>?) != null ? Organisation.fromJson(json['locationRegion'] as Map<String,dynamic>) : null,
        typeOfAsset = json['typeOfAsset'] as int?,
        typeOfArticle = (json['typeOfArticle'] as Map<String,dynamic>?) != null ? Organisation.fromJson(json['typeOfArticle'] as Map<String,dynamic>) : null,
        foundDate = json['foundDate'] as String?,
        foundLocation = json['foundLocation'] as String?,
        additionalInformation = json['additionalInformation'] as String?,
        quantity = json['quantity'] as int?,
        color = json['color'] as String?,
        images = (json['images'] as List?)?.map((dynamic e) => ImageContent.fromJson(e as Map<String,dynamic>)).toList(),
        depositorDbEmp = json['depositorDbEmp'] as bool?,
        depositor = (json['depositor'] as Map<String,dynamic>?) != null ? User.fromJson(json['depositor'] as Map<String,dynamic>) : null,
        employeeId = json['employeeId'] as String?,
        depositorDepartment = (json['depositorDepartment'] as Map<String,dynamic>?) != null ? Organisation.fromJson(json['depositorDepartment'] as Map<String,dynamic>) : null,
        claimantDbEmp = json['claimantDbEmp'] as bool?,
        claimantConfirmByEmail = json['claimantConfirmByEmail'] as bool?,
        claimant = (json['claimant'] as Map<String,dynamic>?) != null ? User.fromJson(json['claimant'] as Map<String,dynamic>) : null,
        claimantNoSign = json['claimantNoSign'] as bool?,
        claimantSign = (json['claimantSign'] as Map<String,dynamic>?) != null ? ImageContent.fromJson(json['claimantSign'] as Map<String,dynamic>) : null,
        claimantEmployeeId = json['claimantEmployeeId'] as String?,
        claimantDepartment = (json['claimantDepartment'] as Map<String,dynamic>?) != null ? Organisation.fromJson(json['claimantDepartment'] as Map<String,dynamic>) : null,
        handoverDate = json['handoverDate'] as String?,
        entrySecurity = (json['entrySecurity'] as Map<String,dynamic>?) != null ? User.fromJson(json['entrySecurity'] as Map<String,dynamic>) : null,
        handoverSecurity = (json['handoverSecurity'] as Map<String,dynamic>?) != null ? User.fromJson(json['handoverSecurity'] as Map<String,dynamic>) : null,
        status = json['status'] as int?,
        modifiedBy = json['modifiedBy'] as String?,
        depositorName = json['depositorName'] as String?,
        claimantName = json['claimantName'] as String?,
        locationName = json['locationName'] as String?,
        entrySecurityName = json['entrySecurityName'] as String?,
        handOverSecurityName = json['handOverSecurityName'] as String?,
        depositorDepartmentName = json['depositorDepartmentName'] as String?,
        claimantDepartmentName = json['claimantDepartmentName'] as String?,
        location = (json['location'] as Map<String,dynamic>?) != null ? Organisation.fromJson(json['location'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'slNo' : slNo,
    'inputDate' : inputDate,
    'locationRegion' : locationRegion?.toJson(),
    'typeOfAsset' : typeOfAsset,
    'typeOfArticle' : typeOfArticle?.toJson(),
    'foundDate' : foundDate,
    'foundLocation' : foundLocation,
    'additionalInformation' : additionalInformation,
    'quantity' : quantity,
    'color' : color,
    'images' : images?.map((e) => e.toJson()).toList(),
    'depositorDbEmp' : depositorDbEmp,
    'depositor' : depositor?.toJson(),
    'employeeId' : employeeId,
    'depositorDepartment' : depositorDepartment?.toJson(),
    'claimantDbEmp' : claimantDbEmp,
    'claimantConfirmByEmail' : claimantConfirmByEmail,
    'claimant' : claimant?.toJson(),
    'claimantNoSign' : claimantNoSign,
    'claimantSign' : claimantSign?.toJson(),
    'claimantEmployeeId' : claimantEmployeeId,
    'claimantDepartment' : claimantDepartment?.toJson(),
    'handoverDate' : handoverDate,
    'entrySecurity' : entrySecurity?.toJson(),
    'handoverSecurity' : handoverSecurity?.toJson(),
    'status' : status,
    'modifiedBy' : modifiedBy,
    'depositorName' : depositorName,
    'claimantName' : claimantName,
    'locationName' : locationName,
    'entrySecurityName' : entrySecurityName,
    'handOverSecurityName' : handOverSecurityName,
    'depositorDepartmentName' : depositorDepartmentName,
    'claimantDepartmentName' : claimantDepartmentName,
    'location' : location?.toJson()
  };
}


