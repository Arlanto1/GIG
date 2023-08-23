class GuardingMasterReportModel {
  final dynamic list;
  final List<GuardingMasterReportsModel>? data;
  final int? totalCount;
  final int? currentPageNo;
  final int? totalPageCount;

  GuardingMasterReportModel({
    this.list,
    this.data,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  GuardingMasterReportModel.fromJson(Map<String, dynamic> json)
      : list = json['list'],
        data = (json['data'] as List?)?.map((dynamic e) => GuardingMasterReportsModel.fromJson(e as Map<String,dynamic>)).toList(),
        totalCount = json['totalCount'] as int?,
        currentPageNo = json['currentPageNo'] as int?,
        totalPageCount = json['totalPageCount'] as int?;

  Map<String, dynamic> toJson() => {
    'list' : list,
    'data' : data?.map((e) => e.toJson()).toList(),
    'totalCount' : totalCount,
    'currentPageNo' : currentPageNo,
    'totalPageCount' : totalPageCount
  };
}

class GuardingMasterReportsModel {
  final int? id;
  final String? region;
  final String? locationRegionId;
  final String? location;
  final String? locationId;
  final String? vendorId;
  final String? vendor;
  final int? guardCount;
  final int? mcNotSubmitted;
  final dynamic mcExpired;
  final int? photoNotSubmitted;
  final int? deploymentOrderPending;
  final int? pvcExpired;
  final int? msgbExempted;
  final int? msgbNotExempted;
  final dynamic msgbFormBNotSubmitted;
  final dynamic msgbFormBUnderProcess;
  final int? systemAccess;
  final int? trainingCertPending;
  final int? precPending;
  final int? precDoseCount;
  final int? ertCertified;
  final int? ertPending;
  final int? esicPending;
  final int? uanNoPending;
  final int? firstAidCertified;
  final int? firstAidNotCertified;

  GuardingMasterReportsModel({
    this.id,
    this.region,
    this.locationRegionId,
    this.location,
    this.locationId,
    this.vendorId,
    this.vendor,
    this.guardCount,
    this.mcNotSubmitted,
    this.mcExpired,
    this.photoNotSubmitted,
    this.deploymentOrderPending,
    this.pvcExpired,
    this.msgbExempted,
    this.msgbNotExempted,
    this.msgbFormBNotSubmitted,
    this.msgbFormBUnderProcess,
    this.systemAccess,
    this.trainingCertPending,
    this.precPending,
    this.precDoseCount,
    this.ertCertified,
    this.ertPending,
    this.esicPending,
    this.uanNoPending,
    this.firstAidCertified,
    this.firstAidNotCertified,
  });

  GuardingMasterReportsModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        region = json['region'] as String?,
        locationRegionId = json['locationRegionId'] as String?,
        location = json['location'] as String?,
        locationId = json['locationId'] as String?,
        vendorId = json['vendorId'] as String?,
        vendor = json['vendor'] as String?,
        guardCount = json['guardCount'] as int?,
        mcNotSubmitted = json['mcNotSubmitted'] as int?,
        mcExpired = json['mcExpired'],
        photoNotSubmitted = json['photoNotSubmitted'] as int?,
        deploymentOrderPending = json['deploymentOrderPending'] as int?,
        pvcExpired = json['pvcExpired'] as int?,
        msgbExempted = json['msgbExempted'] as int?,
        msgbNotExempted = json['msgbNotExempted'] as int?,
        msgbFormBNotSubmitted = json['msgbFormBNotSubmitted'],
        msgbFormBUnderProcess = json['msgbFormBUnderProcess'],
        systemAccess = json['systemAccess'] as int?,
        trainingCertPending = json['trainingCertPending'] as int?,
        precPending = json['precPending'] as int?,
        precDoseCount = json['precDoseCount'] as int?,
        ertCertified = json['ertCertified'] as int?,
        ertPending = json['ertPending'] as int?,
        esicPending = json['esicPending'] as int?,
        uanNoPending = json['uanNoPending'] as int?,
        firstAidCertified = json['firstAidCertified'] as int?,
        firstAidNotCertified = json['firstAidNotCertified'] as int?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'region' : region,
    'locationRegionId' : locationRegionId,
    'location' : location,
    'locationId' : locationId,
    'vendorId' : vendorId,
    'vendor' : vendor,
    'guardCount' : guardCount,
    'mcNotSubmitted' : mcNotSubmitted,
    'mcExpired' : mcExpired,
    'photoNotSubmitted' : photoNotSubmitted,
    'deploymentOrderPending' : deploymentOrderPending,
    'pvcExpired' : pvcExpired,
    'msgbExempted' : msgbExempted,
    'msgbNotExempted' : msgbNotExempted,
    'msgbFormBNotSubmitted' : msgbFormBNotSubmitted,
    'msgbFormBUnderProcess' : msgbFormBUnderProcess,
    'systemAccess' : systemAccess,
    'trainingCertPending' : trainingCertPending,
    'precPending' : precPending,
    'precDoseCount' : precDoseCount,
    'ertCertified' : ertCertified,
    'ertPending' : ertPending,
    'esicPending' : esicPending,
    'uanNoPending' : uanNoPending,
    'firstAidCertified' : firstAidCertified,
    'firstAidNotCertified' : firstAidNotCertified
  };
}