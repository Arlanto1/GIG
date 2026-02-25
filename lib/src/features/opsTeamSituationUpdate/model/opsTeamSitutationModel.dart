import '../../../../index.dart';

class LSMResponseModel {
  final List<LsmSituationalModel>? list;
  final int? totalCount;
  final int? currentPageNo;
  final int? totalPageCount;

  LSMResponseModel({
    this.list,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  LSMResponseModel.fromJson(Map<String, dynamic> json)
      : list = (json['list'] as List?)
            ?.map((dynamic e) =>
                LsmSituationalModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        totalCount = json['totalCount'] as int?,
        currentPageNo = json['currentPageNo'] as int?,
        totalPageCount = json['totalPageCount'] as int?;

  Map<String, dynamic> toJson() => {
        'list': list?.map((e) => e.toJson()).toList(),
        'totalCount': totalCount,
        'currentPageNo': currentPageNo,
        'totalPageCount': totalPageCount
      };
}

class LsmSituationalModel {
  int? id;
  String? slNo;
  int? alertType;
  int? forecastType;
  String? alertDetails;
  int? status;
  List<LsmLocationUpdate>? lsmLocationUpdate;
  List<LsmOccupancyReport>? lsmOccupancyReport;
  String? inputDate;
  String? modifiedDate;
  String? modifiedBy;
  String? cancelReason;
  User? entrySecurity;
  Organisation? location;
  Organisation? locationRegion;
  List<Organisation>? mailListTo;
  List<Organisation>? mailListCc;

  LsmSituationalModel({
    this.id,
    this.slNo,
    this.alertType,
    this.forecastType,
    this.alertDetails,
    this.status,
    this.lsmLocationUpdate,
    this.lsmOccupancyReport,
    this.inputDate,
    this.modifiedDate,
    this.modifiedBy,
    this.cancelReason,
    this.entrySecurity,
    this.location,
    this.locationRegion,
    this.mailListTo,
    this.mailListCc,
  });

  LsmSituationalModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        slNo = json['slNo'] as String?,
        inputDate = json['inputDate'] as String?,
        locationRegion =
            (json['locationRegion'] as Map<String, dynamic>?) != null
                ? Organisation.fromJson(
                    json['locationRegion'] as Map<String, dynamic>)
                : null,
        alertType = json['alertType'] as int?,
        alertDetails = json['alertDetails'] as String?,
        forecastType = json['forecastType'] as int?,
        entrySecurity = (json['entrySecurity'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['entrySecurity'] as Map<String, dynamic>)
            : null,
        status = json['status'] as int?,
        modifiedBy = json['modifiedBy'] as String?,
        location = (json['location'] as Map<String, dynamic>?) != null
            ? Organisation.fromJson(json['location'] as Map<String, dynamic>)
            : null,
        lsmOccupancyReport = (json['lsmOccupancyReport'] as List<dynamic>?)
            ?.map((e) => LsmOccupancyReport.fromJson(e as Map<String, dynamic>))
            .toList(),
        lsmLocationUpdate = (json['lsmLocationUpdate'] as List<dynamic>?)
            ?.map((e) => LsmLocationUpdate.fromJson(e as Map<String, dynamic>))
            .toList(),
        modifiedDate = json['modifiedDate'] as String?,
        mailListTo = (json['mailListTo'] as List<dynamic>?)
            ?.map((e) => Organisation.fromJson(e as Map<String, dynamic>))
            .toList(),
        mailListCc = (json['mailListCc'] as List<dynamic>?)
            ?.map((e) => Organisation.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'slNo': slNo,
        'inputDate': inputDate,
        'locationRegion': locationRegion?.toJson(),
        'entrySecurity': entrySecurity?.toJson(),
        'status': status,
        'modifiedBy': modifiedBy,
        'location': location?.toJson(),
        'modifiedDate': modifiedDate,
        'alertType': alertType,
        'alertDetails': alertDetails,
        'forecastType': forecastType,
        'lsmLocationUpdate': lsmLocationUpdate?.map((e) => e.toJson()).toList(),
        'lsmOccupancyReport':
            lsmOccupancyReport?.map((e) => e.toJson()).toList(),
        'mailListTo': mailListTo?.map((e) => e.toJson()).toList(),
        'mailListCc': mailListCc?.map((e) => e.toJson()).toList(),
      };
}

class LsmOccupancyReport {
  int? id;
  int? contingentWorker;
  int? supportStaff;
  int? total;
  Organisation? locationId;

  LsmOccupancyReport({
    this.id,
    this.locationId,
    this.contingentWorker,
    this.supportStaff,
    this.total,
  });

  LsmOccupancyReport.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        locationId = (json['locationId'] as Map<String, dynamic>?) != null
            ? Organisation.fromJson(json['locationId'] as Map<String, dynamic>)
            : null,
        contingentWorker = json['contingentWorker'] as int?,
        supportStaff = json['supportStaff'] as int?,
        total = json['total'] as int?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'locationId': locationId?.toJson(),
        'contingentWorker': contingentWorker,
        'supportStaff': supportStaff,
        'total': total,
      };
}

class LsmLocationUpdate {
  int? id;
  String? specificLocation;
  String? rainFallStatus;
  String? trafficStatus;
  String? impactOnDbTransport;
  String? overallImpact;
  String? incidentSite;
  String? distance;
  String? waterLogging;
  List<ImageContent>? images;

  LsmLocationUpdate({
    this.id,
    this.specificLocation,
    this.rainFallStatus,
    this.trafficStatus,
    this.impactOnDbTransport,
    this.overallImpact,
    this.incidentSite,
    this.distance,
    this.waterLogging,
    this.images,
  });

  LsmLocationUpdate.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        specificLocation = json['specificLocation'] as String?,
        rainFallStatus = json['rainFallStatus'] as String?,
        trafficStatus = json['trafficStatus'] as String?,
        impactOnDbTransport = json['impactOnDbTransport'] as String?,
        overallImpact = json['overallImpact'] as String?,
        incidentSite = json['incidentSite'] as String?,
        distance = json['distance'] as String?,
        waterLogging = json['waterLogging'] as String?,
        images = (json['images'] as List?)
            ?.map(
                (dynamic e) => ImageContent.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'specificLocation': specificLocation,
        'rainFallStatus': rainFallStatus,
        'trafficStatus': trafficStatus,
        'impactOnDbTransport': impactOnDbTransport,
        'overallImpact': overallImpact,
        'incidentSite': incidentSite,
        'distance': distance,
        'waterLogging': waterLogging,
        'images': images,
      };
}
