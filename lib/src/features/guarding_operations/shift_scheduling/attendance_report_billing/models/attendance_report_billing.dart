import 'package:db_atom/index.dart';

class AttendanceReportBillingResponse {
  final List<AttendanceReportBillingModel>? items;
  final int? totalCount;
  final int? currentPageNo;
  final int? totalPageCount;

  AttendanceReportBillingResponse({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  AttendanceReportBillingResponse.fromJson(Map<String, dynamic> json)
      : items = (json['data'] as List?)?.map((dynamic e) => AttendanceReportBillingModel.fromJson(e as Map<String,dynamic>)).toList(),
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

class AttendanceReportBillingModel {
  final int? id;
  final Organisation? location;
  final Organisation? locationRegion;
  final String? inputDate;
  final int? month;
  final int? year;

  AttendanceReportBillingModel({
    this.id,
    this.location,
    this.locationRegion,
    this.inputDate,
    this.month,
    this.year,
  });

  AttendanceReportBillingModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        location = (json['location'] as Map<String,dynamic>?) != null ? Organisation.fromJson(json['location'] as Map<String,dynamic>) : null,
        locationRegion = (json['locationRegion'] as Map<String,dynamic>?) != null ? Organisation.fromJson(json['locationRegion'] as Map<String,dynamic>) : null,
        inputDate = json['inputDate'] as String?,
        month = json['month'] as int?,
        year = json['year'] as int?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'location' : location?.toJson(),
    'locationRegion' : locationRegion?.toJson(),
    'inputDate' : inputDate,
    'month' : month,
    'year' : year
  };
}
