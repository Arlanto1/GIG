import '../../../../../index.dart';

class VVIPVisitorResponseModel {
  final List<VIVPVisitorModel>? items;
  final int? totalCount;
  final int? currentPageNo;
  final int? totalPageCount;

  VVIPVisitorResponseModel({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  VVIPVisitorResponseModel.fromJson(Map<String, dynamic> json)
      : items = (json['data'] as List?)?.map((dynamic e) => VIVPVisitorModel.fromJson(e as Map<String,dynamic>)).toList(),
        totalCount = json['totalCount'] as int?,
        currentPageNo = json['currentPageNo'] as int?,
        totalPageCount = json['totalPageCount'] as int?;

  Map<String, dynamic> toJson() => {
    'data' : items?.map((e) => e.toJson()).toList(),
    'totalCount' : totalCount,
    'currentPageNo' : currentPageNo,
    'totalPageCount' : totalPageCount
  };
}

class VIVPVisitorModel {
   int? id;
   int? status;
   String? slNo;
   User? entrySecurity;
   String? inputDate;
   Organisation? location;
   String? modifiedBy;
   String? modifiedDate;

  VIVPVisitorModel({
    this.id,
    this.status,
    this.slNo,
    this.entrySecurity,
    this.inputDate,
    this.location,
    this.modifiedBy,
    this.modifiedDate,
  });

  VIVPVisitorModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        status = json['status'] as int?,
        slNo = json['slNo'] as String?,
        entrySecurity = (json['entrySecurity'] as Map<String,dynamic>?) != null ? User.fromJson(json['entrySecurity'] as Map<String,dynamic>) : null,
        inputDate = json['inputDate'] as String?,
        location = (json['location'] as Map<String,dynamic>?) != null ? Organisation.fromJson(json['location'] as Map<String,dynamic>) : null,
        modifiedBy = json['modifiedBy'] as String?,
        modifiedDate = json['modifiedDate'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'status' : status,
    'slNo' : slNo,
    'entrySecurity' : entrySecurity?.toJson(),
    'inputDate' : inputDate,
    'location' : location?.toJson(),
    'modifiedBy' : modifiedBy,
    'modifiedDate' : modifiedDate
  };
}
