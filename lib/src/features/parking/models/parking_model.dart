import '../../../../index.dart';

class ParkingResponse {
  List<ParkingModel>? items;
  int? totalCount;
  int? currentPageNo;
  int? totalPageCount;

  ParkingResponse({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  ParkingResponse.fromJson(Map<String, dynamic> json)
      : items = ((json['list'] ?? json['data']) as List?)
      ?.map((dynamic e) =>
      ParkingModel.fromJson(e as Map<String, dynamic>))
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

class ParkingModel {
  int? id;
  int? status;
  String? inputDate;
  Organisation? locationRegion;
  Organisation? location;
  Organisation? locationType;
  int? customerVisitors;
  int? employeeVisitors;
  int? totalVisitors;
  int? employeeHeadCount;
  int? totalParkingSlots;
  int? occupiedParkingSlots;
  int? availableParkingSlots;
  double? parkingUtilizationPercent;
  int? externalParkingRequired;
  int? parkingDemandStatus;
  String? remarks;
  List<ParkingLevelModel>? parkingLevels;
  User? entrySecurity;

  ParkingModel({
    this.id,
    this.status,
    this.inputDate,
    this.locationRegion,
    this.location,
    this.locationType,
    this.customerVisitors,
    this.employeeVisitors,
    this.totalVisitors,
    this.employeeHeadCount,
    this.totalParkingSlots,
    this.occupiedParkingSlots,
    this.availableParkingSlots,
    this.parkingUtilizationPercent,
    this.externalParkingRequired,
    this.parkingDemandStatus,
    this.remarks,
    this.parkingLevels,
    this.entrySecurity,
  });

  ParkingModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        status = json['status'] as int?,
        inputDate = json['inputDate'] as String?,
        locationRegion =
        (json['locationRegion'] as Map<String, dynamic>?) != null
            ? Organisation.fromJson(
            json['locationRegion'] as Map<String, dynamic>)
            : null,
        location = (json['location'] as Map<String, dynamic>?) != null
            ? Organisation.fromJson(json['location'] as Map<String, dynamic>)
            : null,
        locationType = (json['locationType'] as Map<String, dynamic>?) != null
            ? Organisation.fromJson(json['locationType'] as Map<String, dynamic>)
            : null,
        customerVisitors = json['customerVisitors'] as int?,
        employeeVisitors = json['employeeVisitors'] as int?,
        totalVisitors = json['totalVisitors'] as int?,
        employeeHeadCount = json['employeeHeadCount'] as int?,
        totalParkingSlots = json['totalParkingSlots'] as int?,
        occupiedParkingSlots = json['occupiedParkingSlots'] as int?,
        availableParkingSlots = json['availableParkingSlots'] as int?,
        parkingUtilizationPercent =
        (json['parkingUtilizationPercent'] as num?)?.toDouble(),
        externalParkingRequired = json['externalParkingRequired'] as int?,
        parkingDemandStatus = json['parkingDemandStatus'] as int?,
        remarks = json['remarks'] as String?,
        parkingLevels = (json['parkingLevels'] as List?)
            ?.map((dynamic e) =>
            ParkingLevelModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        entrySecurity = (json['entrySecurity'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['entrySecurity'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {
    'id': id,
    'status': status,
    'inputDate': inputDate,
    'locationRegion': locationRegion?.toJson(),
    'location': location?.toJson(),
    'locationType':locationType?.toJson(),
    'customerVisitors': customerVisitors,
    'employeeVisitors': employeeVisitors,
    'totalVisitors': totalVisitors,
    'employeeHeadCount': employeeHeadCount,
    'totalParkingSlots': totalParkingSlots,
    'occupiedParkingSlots': occupiedParkingSlots,
    'availableParkingSlots': availableParkingSlots,
    'parkingUtilizationPercent': parkingUtilizationPercent,
    'externalParkingRequired': externalParkingRequired,
    'parkingDemandStatus': parkingDemandStatus,
    'parkingLevels': parkingLevels?.map((e) => e.toJson()).toList(),
    'remarks': remarks,
    'entrySecurity': entrySecurity?.toJson()
  };
}

class ParkingLevelModel {
  int? id;
  String? parkingLevel;
  int? totalSlots;
  int? occupiedSlots;
  int? availableSlots;
  double? utilizationPercent;
  String? remarks;

  ParkingLevelModel({
    this.id,
    this.parkingLevel,
    this.totalSlots,
    this.occupiedSlots,
    this.availableSlots,
    this.utilizationPercent,
    this.remarks,
  });

  ParkingLevelModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        parkingLevel = json['parkingLevel'] as String?,
        totalSlots = json['totalSlots'] as int?,
        occupiedSlots = json['occupiedSlots'] as int?,
        availableSlots = json['availableSlots'] as int?,
        utilizationPercent = (json['utilizationPercent'] as num?)?.toDouble(),
        remarks = json['remarks'] as String?;

  Map<String, dynamic> toJson() => {
    'id': id,
    'parkingLevel': parkingLevel,
    'totalSlots': totalSlots,
    'occupiedSlots': occupiedSlots,
    'availableSlots': availableSlots,
    'utilizationPercent': utilizationPercent,
    'remarks': remarks
  };
}