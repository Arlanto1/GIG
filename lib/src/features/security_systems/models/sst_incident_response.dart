import 'package:db_atom/index.dart';

class SstIncidentResponse {
  final List<SstIncident>? items;
  final int? totalCount;
  final int? currentPageNo;
  final int? totalPageCount;

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
  int? id;
  String? slNo;
  Organisation? location;
  Organisation? region;
  Organisation? vendor;
  OccurrenceModel? occurrence;
  String? vendorTicketNo;
  int? ticketType;
  int? staffType;
  bool? ipbArea;
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
  bool? costInvolved;
  String? invoiceNo;
  String? emailList;
  String? poNo;
  List<dynamic>? entities;
  List<ImageContent>? attachments;
  List<ImageContent>? dataLossDocs;
  List<dynamic>? quotes;
  List<ImageContent>? additionalDocs;
  String? modifiedBy;
  int? occType;
  List<ActivityNotes>? activityNotes;
  User? lsm;
  User? asl;
  User? lt;
  User? systemManager;
  String? vendorPoc;
  String? escalation1Poc;
  String? escalation2Poc;
  String? escalation3Poc;
  String? lock;
  String? acknowledgeDate;
  String? escalation1;
  String? escalation2;
  String? escalation3;
  String? rejectionComment;
  double? slaOnsiteRes;
  String? solvedProposed;
  String? reworkDate;
  String? closedActivityNotes;
  num? workFlowId;
  String? onsiteVisitDate;
  String? solvedComplete;
  double? downTime;
  double? slaResolutionDate;

  SstIncident({
    this.id,
    this.slNo,
    this.location,
    this.region,
    this.vendor,
    this.vendorTicketNo,
    this.ticketType,
    this.staffType,
    this.ipbArea,
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
    this.costInvolved,
    this.invoiceNo,
    this.emailList,
    this.poNo,
    this.entities,
    this.attachments = const [],
    this.dataLossDocs,
    this.quotes,
    this.additionalDocs,
    this.modifiedBy,
    this.occType,
    this.activityNotes,
    this.lsm,
    this.asl,
    this.lt,
    this.systemManager,
    this.vendorPoc,
    this.escalation1Poc,
    this.escalation2Poc,
    this.escalation3Poc,
    this.occurrence,
    this.lock,
    this.acknowledgeDate,
    this.escalation1,
    this.escalation2,
    this.escalation3,
    this.rejectionComment,
    this.slaOnsiteRes,
    this.solvedProposed,
    this.reworkDate,
    this.closedActivityNotes,
    this.workFlowId,
    this.onsiteVisitDate,
    this.solvedComplete,
  });

  SstIncident.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        slNo = json['slNo'] as String?,
        location = (json['location'] as Map<String, dynamic>?) != null
            ? Organisation.fromJson(json['location'] as Map<String, dynamic>)
            : null,
        region = (json['region'] as Map<String, dynamic>?) != null
            ? Organisation.fromJson(json['region'] as Map<String, dynamic>)
            : null,
        vendor = (json['vendor'] as Map<String, dynamic>?) != null
            ? Organisation.fromJson(json['vendor'] as Map<String, dynamic>)
            : null,
        vendorTicketNo = json['vendorTicketNo'] as String?,
        ticketType = json['ticketType'] as int?,
        staffType = json['staffType'] as int?,
        ipbArea = json['ipbArea'] as bool,
        systemSLA = json['systemSLA'] as int?,
        createdBy = (json['createdBy'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['createdBy'] as Map<String, dynamic>)
            : null,
        createdDate = json['createdDate'] as String?,
        criticalSpare = json['criticalSpare'] as bool?,
        issueType = json['issueType'] as int?,
        dataLoss = json['dataLoss'] as bool?,
        status = json['status'] as int?,
        occurrence = (json['occurrence'] as Map<String, dynamic>?) != null
            ? OccurrenceModel.fromJson(
                json['occurrence'] as Map<String, dynamic>)
            : null,
        shortDescription = json['shortDescription'] as String?,
        detailDescription = json['detailDescription'] as String?,
        rootCauseAnalysis = json['rootCauseAnalysis'] as String?,
        actionTaken = json['actionTaken'] as String?,
        costInvolved = json['costInvolved'] as bool?,
        invoiceNo = json['invoiceNo'] as String?,
        emailList = json['emailList'] as String?,
        poNo = json['poNo'] as String?,
        entities = json['entities'] as List?,
        attachments = (json['attachments'] as List<dynamic>?)
                ?.map((e) => ImageContent.fromJson(e as Map<String, dynamic>))
                .toList() ??
            const [],
        dataLossDocs = (json['dataLossDocs'] as List<dynamic>?)
                ?.map((e) => ImageContent.fromJson(e as Map<String, dynamic>))
                .toList() ??
            const [],
        quotes = json['quotes'] as List?,
        additionalDocs = (json['additionalDocs'] as List<dynamic>?)
                ?.map((e) => ImageContent.fromJson(e as Map<String, dynamic>))
                .toList() ??
            const [],
        modifiedBy = json['modifiedBy'] as String?,
        occType = json['occType'] as int?,
        activityNotes = (json['activityNotes'] as List?)
            ?.map((dynamic e) =>
                ActivityNotes.fromJson(e as Map<String, dynamic>))
            .toList(),
        lsm = (json['lsm'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['lsm'] as Map<String, dynamic>)
            : null,
        asl = (json['asl'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['asl'] as Map<String, dynamic>)
            : null,
        lt = (json['lt'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['lt'] as Map<String, dynamic>)
            : null,
        systemManager = (json['systemManager'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['systemManager'] as Map<String, dynamic>)
            : null,
        vendorPoc = json['vendorPoc'] as String?,
        escalation1Poc = json['escalation1Poc'] as String?,
        escalation2Poc = json['escalation2Poc'] as String?,
        escalation3Poc = json['escalation3Poc'] as String?,
        acknowledgeDate = json['acknowledgeDate'] as String?,
        escalation1 = json['escalation1'] as String?,
        escalation2 = json['escalation2'] as String?,
        escalation3 = json['escalation3'] as String?,
        rejectionComment = json['rejectionComment'] as String?,
        solvedProposed = json['solvedProposed'] as String?,
        slaOnsiteRes = json['slaOnsiteRes'] as double?,
        reworkDate = json['reworkDate'] as String?,
        closedActivityNotes = json['closedActivityNotes'] as String?,
        workFlowId = json['workFlowId'] as num?,
        onsiteVisitDate = json['onsiteVisitDate'] as String?,
        solvedComplete = json['solvedComplete'] as String?,
        downTime = json['downTime'] as double?,
        slaResolutionDate = json['slaResolutionDate'] as double?,
        lock = json['lock'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'slNo': slNo,
        'location': location?.toJson(),
        'region': region?.toJson(),
        'vendor': vendor?.toJson(),
        'vendorTicketNo': vendorTicketNo,
        'ticketType': ticketType,
        'staffType': staffType,
        'ipbArea': ipbArea,
        'systemSLA': systemSLA,
        'createdBy': createdBy?.toJson(),
        'createdDate': createdDate,
        'criticalSpare': criticalSpare,
        'issueType': issueType,
        'dataLoss': dataLoss,
        'status': status,
        'shortDescription': shortDescription,
        'detailDescription': detailDescription,
        'rootCauseAnalysis': rootCauseAnalysis,
        'actionTaken': actionTaken,
        'costInvolved': costInvolved,
        'invoiceNo': invoiceNo,
        'emailList': emailList,
        'poNo': poNo,
        'entities': entities,
        'occurrence': occurrence?.toJson(),
        'attachments': attachments,
        'dataLossDocs': dataLossDocs,
        'quotes': quotes,
        'additionalDocs': additionalDocs,
        'modifiedBy': modifiedBy,
        'activityNotes': activityNotes?.map((e) => e.toJson()).toList(),
        'lsm': lsm?.toJson(),
        'asl': asl?.toJson(),
        'lt': lt?.toJson(),
        'systemManager': systemManager?.toJson(),
        'vendorPoc': vendorPoc,
        'escalation1Poc': escalation1Poc,
        'escalation2Poc': escalation2Poc,
        'escalation3Poc': escalation3Poc,
        'occType': occType,
        'acknowledgeDate': acknowledgeDate,
        'escalation1': escalation1,
        'escalation2': escalation2,
        'escalation3': escalation3,
        'rejectionComment': rejectionComment,
        'slaOnsiteResponse': slaOnsiteRes,
        'solvedProposed': solvedProposed,
        'reworkDate': reworkDate,
        'closedActivityNotes': closedActivityNotes,
        'workFlowId': workFlowId,
        'onsiteVisitDate': onsiteVisitDate,
        'solvedComplete': solvedComplete,
        'downTime': downTime,
        'slaResolutionDate': slaResolutionDate,
        'lock': lock,
      };
}

class ActivityNotes {
  final int? id;
  final String? activityNotes;
  final String? submittedDate;
  final bool? submitted;

  ActivityNotes({
    this.id,
    this.activityNotes,
    this.submittedDate,
    this.submitted,
  });

  ActivityNotes.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        activityNotes = json['activityNotes'] as String?,
        submittedDate = json['submittedDate'] as String?,
        submitted = json['submitted'] as bool?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'activityNotes': activityNotes,
        'submittedDate': submittedDate,
        'submitted': submitted
      };
}
