import '../../../models/organisation.dart';
import '../../createfound/models/user.dart';

class SstIncidentResponse {
  List<SstIncident>? items;
  int? totalCount;
  int? currentPageNo;
  int? totalPageCount;

  SstIncidentResponse({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  SstIncidentResponse.fromJson(Map<String, dynamic> json)
      : items = (json['data'] as List?)
            ?.map(
                (dynamic e) => SstIncident.fromJson(e as Map<String, dynamic>))
            .toList(),
        totalCount = json['totalCount'] as int?,
        currentPageNo = json['currentPageNo'] as int?,
        totalPageCount = json['totalPageCount'] as int?;

  Map<String, dynamic> toJson() => {
        'data': items?.map((e) => e.toJson()).toList(),
        'totalCount': totalCount,
        'currentPageNo': currentPageNo,
        'totalPageCount': totalPageCount
      };
}

class SstIncident {
  String? securitySystemSLAId;
  int? id;
  String? slNo;
  Organisation? location;
  Organisation? region;
  Organisation? vendor;
  String? vendorTicketNo;
  int? ticketType;
  int? staffType;
  bool ipbArea;
  int? systemSLA;
  User? createdBy;
  String? createdDate;
  bool? criticalSpare;
  int? issueType;
  bool? dataLoss;
  int? status;
  String? shortDescription;
  String? detailDescription;
  String? rootCauseAnalysis;
  String? actionTaken;
  String? escalation2;
  bool? costInvolved;
  String? invoiceNo;
  String? emailList;
  String? poNo;
  List<dynamic>? entities;
  List<dynamic>? attachments;
  List<dynamic>? dataLossDocs;
  List<dynamic>? quotes;
  List<dynamic>? additionalDocs;
  int? modifiedDate;
  String? modifiedBy;
  int? occType;
  List<ActivityNotes>? activityNotes;
  User? lsm;
  User? asl;
  User? lt;
  User? systemManager;
  String? vendorPoc;

  SstIncident({
    this.securitySystemSLAId,
    this.id,
    this.slNo,
    this.location,
    this.region,
    this.vendor,
    this.vendorTicketNo,
    this.ticketType,
    this.staffType,
    this.ipbArea = false,
    this.systemSLA,
    this.createdBy,
    this.createdDate,
    this.criticalSpare,
    this.issueType,
    this.dataLoss,
    this.status,
    this.shortDescription,
    this.detailDescription,
    this.rootCauseAnalysis,
    this.actionTaken,
    this.escalation2,
    this.costInvolved,
    this.invoiceNo,
    this.emailList,
    this.poNo,
    this.entities,
    this.attachments,
    this.dataLossDocs,
    this.quotes,
    this.additionalDocs,
    this.modifiedDate,
    this.modifiedBy,
    this.occType,
    this.activityNotes,
    this.lsm,
    this.asl,
    this.lt,
    this.systemManager,
    this.vendorPoc,
  });

  SstIncident.fromJson(Map<String, dynamic> json)
      : securitySystemSLAId = json['securitySystemSLAId'] as String?,
        id = json['id'] as int?,
        slNo = json['slNo'] as String?,
        location = (json['location'] as Map<String,dynamic>?) != null ? Organisation.fromJson(json['location'] as Map<String,dynamic>) : null,
        region = (json['region'] as Map<String,dynamic>?) != null ? Organisation.fromJson(json['region'] as Map<String,dynamic>) : null,
        vendor = (json['vendor'] as Map<String,dynamic>?) != null ? Organisation.fromJson(json['vendor'] as Map<String,dynamic>) : null,
        vendorTicketNo = json['vendorTicketNo'] as String?,
        ticketType = json['ticketType'] as int?,
        staffType = json['staffType'] as int?,
        ipbArea = json['ipbArea'] as bool,
        systemSLA = json['systemSLA'] as int?,
        createdBy = (json['createdBy'] as Map<String,dynamic>?) != null ? User.fromJson(json['createdBy'] as Map<String,dynamic>) : null,
        createdDate = json['createdDate'] as String?,
        criticalSpare = json['criticalSpare'] as bool?,
        issueType = json['issueType'] as int?,
        dataLoss = json['dataLoss'] as bool?,
        status = json['status'] as int?,
        shortDescription = json['shortDescription'] as String?,
        detailDescription = json['detailDescription'] as String?,
        rootCauseAnalysis = json['rootCauseAnalysis'] as String?,
        actionTaken = json['actionTaken'] as String?,
        escalation2 = json['escalation2'] as String?,
        costInvolved = json['costInvolved'] as bool?,
        invoiceNo = json['invoiceNo'] as String?,
        emailList = json['emailList'] as String?,
        poNo = json['poNo'] as String?,
        entities = json['entities'] as List?,
        attachments = json['attachments'] as List?,
        dataLossDocs = json['dataLossDocs'] as List?,
        quotes = json['quotes'] as List?,
        additionalDocs = json['additionalDocs'] as List?,
        modifiedDate = json['modifiedDate'] as int?,
        modifiedBy = json['modifiedBy'] as String?,
        occType = json['occType'] as int?,
        activityNotes = (json['activityNotes'] as List?)?.map((dynamic e) => ActivityNotes.fromJson(e as Map<String,dynamic>)).toList(),
        lsm = (json['lsm'] as Map<String,dynamic>?) != null ? User.fromJson(json['lsm'] as Map<String,dynamic>) : null,
        asl = (json['asl'] as Map<String,dynamic>?) != null ? User.fromJson(json['asl'] as Map<String,dynamic>) : null,
        lt = (json['lt'] as Map<String,dynamic>?) != null ? User.fromJson(json['lt'] as Map<String,dynamic>) : null,
        systemManager = (json['systemManager'] as Map<String,dynamic>?) != null ? User.fromJson(json['systemManager'] as Map<String,dynamic>) : null,
        vendorPoc = json['vendorPoc'] as String?;

  Map<String, dynamic> toJson() => {
    'securitySystemSLAId' : securitySystemSLAId,
    'id' : id,
    'slNo' : slNo,
    'location' : location?.toJson(),
    'region' : region?.toJson(),
    'vendor' : vendor?.toJson(),
    'vendorTicketNo' : vendorTicketNo,
    'ticketType' : ticketType,
    'staffType' : staffType,
    'ipbArea' : ipbArea,
    'systemSLA' : systemSLA,
    'createdBy' : createdBy?.toJson(),
    'createdDate' : createdDate,
    'criticalSpare' : criticalSpare,
    'issueType' : issueType,
    'dataLoss' : dataLoss,
    'status' : status,
    'shortDescription' : shortDescription,
    'detailDescription' : detailDescription,
    'rootCauseAnalysis' : rootCauseAnalysis,
    'actionTaken' : actionTaken,
    'escalation2' : escalation2,
    'costInvolved' : costInvolved,
    'invoiceNo' : invoiceNo,
    'emailList' : emailList,
    'poNo' : poNo,
    'entities' : entities,
    'attachments' : attachments,
    'dataLossDocs' : dataLossDocs,
    'quotes' : quotes,
    'additionalDocs' : additionalDocs,
    'modifiedDate' : modifiedDate,
    'modifiedBy' : modifiedBy,
    'occType' : occType,
    'activityNotes' : activityNotes?.map((e) => e.toJson()).toList(),
    'lsm' : lsm?.toJson(),
    'asl' : asl?.toJson(),
    'lt' : lt?.toJson(),
    'systemManager' : systemManager?.toJson(),
    'vendorPoc' : vendorPoc
  };
}


class ActivityNotes {
  int? id;
  dynamic activityNotes;
  int? submittedDate;
  bool? submitted;

  ActivityNotes({
    this.id,
    this.activityNotes,
    this.submittedDate,
    this.submitted,
  });

  ActivityNotes.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        activityNotes = json['activityNotes'],
        submittedDate = json['submittedDate'] as int?,
        submitted = json['submitted'] as bool?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'activityNotes' : activityNotes,
    'submittedDate' : submittedDate,
    'submitted' : submitted
  };
}
