import '../../../../models/location.dart';
import '../../../../models/location_region.dart';

class DropPickUpResponse {
  final List<DropPickUpModel>? data;
  final int? totalCount;
  final int? currentPageNo;
  final int? totalPageCount;

  DropPickUpResponse({
    this.data,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  DropPickUpResponse.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as List?)?.map((dynamic e) => DropPickUpModel.fromJson(e as Map<String,dynamic>)).toList(),
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

class DropPickUpModel {
  final int? id;
  final String? slNo;
  final int? inputDate;
  final int? status;
  final int? modifiedDate;
  final String? modifiedBy;
  final List<DropPickUp>? dropPickUp;
  final List<dynamic>? history;

  DropPickUpModel({
    this.id,
    this.slNo,
    this.inputDate,
    this.status,
    this.modifiedDate,
    this.modifiedBy,
    this.dropPickUp,
    this.history,
  });

  DropPickUpModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        slNo = json['slNo'] as String?,
        inputDate = json['inputDate'] as int?,
        status = json['status'] as int?,
        modifiedDate = json['modifiedDate'] as int?,
        modifiedBy = json['modifiedBy'] as String?,
        dropPickUp = (json['dropPickUp'] as List?)?.map((dynamic e) => DropPickUp.fromJson(e as Map<String,dynamic>)).toList(),
        history = json['history'] as List?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'slNo' : slNo,
    'inputDate' : inputDate,
    'status' : status,
    'modifiedDate' : modifiedDate,
    'modifiedBy' : modifiedBy,
    'dropPickUp' : dropPickUp?.map((e) => e.toJson()).toList(),
    'history' : history
  };
}

class DropPickUp {
  final int? id;
  final Location? location;
  final LocationRegion? locationRegion;
  final int? status;
  final int? apprvdEscrtStrngth;
  final bool? complntAgnstEscrtGuard;

  DropPickUp({
    this.id,
    this.location,
    this.locationRegion,
    this.status,
    this.apprvdEscrtStrngth,
    this.complntAgnstEscrtGuard,
  });

  DropPickUp.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        location = (json['location'] as Map<String,dynamic>?) != null ? Location.fromJson(json['location'] as Map<String,dynamic>) : null,
        locationRegion = (json['locationRegion'] as Map<String,dynamic>?) != null ? LocationRegion.fromJson(json['locationRegion'] as Map<String,dynamic>) : null,
        status = json['status'] as int?,
        apprvdEscrtStrngth = json['apprvdEscrtStrngth'] as int?,
        complntAgnstEscrtGuard = json['complntAgnstEscrtGuard'] as bool?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'location' : location?.toJson(),
    'locationRegion' : locationRegion?.toJson(),
    'status' : status,
    'apprvdEscrtStrngth' : apprvdEscrtStrngth,
    'complntAgnstEscrtGuard' : complntAgnstEscrtGuard
  };
}
