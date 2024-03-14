import 'package:db_atom/index.dart';

part 'ssla_ui_labels.g.dart';

@JsonSerializable()
class SSLAUiLabels {
  SSLAUiLabels({
    required this.defaultLocale,
    required this.locale,
  });

  factory SSLAUiLabels.fromJson(Map<String, dynamic> json) =>
      _$SSLAUiLabelsFromJson(json);

  Map<String, dynamic> toJson() => _$SSLAUiLabelsToJson(this);

  @JsonKey(name: 'locale')
  final SSLAUiLabelsLocale locale;
  @JsonKey(name: 'default')
  final SSLAUiLabelsLocale defaultLocale;
}

@JsonSerializable()
class SSLAUiLabelsLocale {
  @JsonKey(name: 'com.arlanto.atom.securitySystem.selectVendor')
  final String? selectVendor;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.sendReview')
  final String? sendReview;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.downtime')
  final String? downtime;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.incidentDes')
  final String? incidentDes;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.siteVisitDate')
  final String? siteVisitDate;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.issueType.networkIssue')
  final String? networkIssue;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.asl')
  final String? asl;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.dataLoss')
  final String? dataLoss;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.criticalSpareUsed.yes')
  final String? criticalSpareUsedYes;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.siteVisitTime')
  final String? siteVisitTime;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.costInvolved.yes')
  final String? costInvolvedYes;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.solvedProposed')
  final String? solvedProposed;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.ticketCDT')
  final String? ticketCDT;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.descService')
  final String? descService;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.system')
  final String? system;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.status')
  final String? status;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.invoiceRequest')
  final String? invoiceRequest;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.poNo')
  final String? poNo;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.escalation3Poc')
  final String? escalation3Poc;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.location')
  final String? location;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.costInvolved')
  final String? costInvolved;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.slaResolutionDate')
  final String? slaResolutionDate;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.criticalSpareUsed')
  final String? criticalSpareUsed;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.lt')
  final String? lt;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.ticketType')
  final String? ticketType;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.attachment.mandatory')
  final String? attachmentMandatory;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.status.onHold')
  final String? statusOnHold;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.activityLog')
  final String? activityLog;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.rootCauseAnalysis')
  final String? rootCauseAnalysis;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.status.poRaised')
  final String? statusPoRaised;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.vendorPoc')
  final String? vendorPoc;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.status.reWork')
  final String? statusReWork;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.status.quotesApproved')
  final String? statusQuotesApproved;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.vendor')
  final String? vendor;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.solvedComplete')
  final String? solvedComplete;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.system.idsCCTV')
  final String? systemIdsCCTV;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.acknowledgeTicket')
  final String? acknowledgeTicket;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.quotesApproved')
  final String? quotesApproved;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.vendorTNo')
  final String? vendorTNo;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.status.submit')
  final String? statusSubmit;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.generateReminder')
  final String? generateReminder;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.issueType.hardware')
  final String? issueTypeHardware;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.dataLoss.yes')
  final String? dataLossYes;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.invoiceNo')
  final String? invoiceNo;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.criticalSpareUsed.no')
  final String? criticalSpareUsedNo;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.workCompCSM')
  final String? workCompCSM;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.attachDocuments')
  final String? attachDocuments;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.ticketType.incident')
  final String? ticketTypeIncident;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.status.acknowledge')
  final String? statusAcknowledge;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.escalation1Poc')
  final String? escalation1Poc;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.createdBy')
  final String? createdBy;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.staffType.external')
  final String? staffTypeExternal;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.ticketCreatedOn')
  final String? ticketCreatedOn;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.serviceRC')
  final String? serviceRC;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.ticketType.serviceRequest')
  final String? ticketTypeServiceRequest;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.attachmentIA')
  final String? attachmentIA;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.staffType')
  final String? staffType;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.ipbArea.yes')
  final String? ipbAreaYes;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.provideEmailList')
  final String? provideEmailList;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.sendForRework')
  final String? sendForRework;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.status.solveProposed')
  final String? statusSolveProposed;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.system.vms')
  final String? systemVms;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.closure')
  final String? closure;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.attachment')
  final String? attachment;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.system.acs')
  final String? systemAcs;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.acknowledgeTicket.yes')
  final String? acknowledgeTicketYes;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.status.workCompleted')
  final String? statusWorkCompleted;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.ticketAcknowledge')
  final String? ticketAcknowledge;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.status.approve')
  final String? statusApprove;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.ssm')
  final String? ssm;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.status.invoiceRequest')
  final String? statusInvoiceRequest;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.status.open')
  final String? statusOpen;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.costInvolved.no')
  final String? costInvolvedNo;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.sendRework')
  final String? sendRework;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.dataLoss.no')
  final String? dataLossNo;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.onsiteVisitDT')
  final String? onsiteVisitDT;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.status.quotesRejected')
  final String? statusQuotesRejected;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.generateQAN')
  final String? generateQAN;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.system.ids')
  final String? systemIds;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.status.create')
  final String? statusCreate;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.system.acsCCTV')
  final String? systemAcsCCTV;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.solvedProposedDT')
  final String? solvedProposedDT;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.onHoldReason')
  final String? onHoldReason;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.ipbArea.no')
  final String? ipbAreaNo;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.onHold')
  final String? onHold;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.acknowledgeTicket.no')
  final String? acknowledgeTicketNo;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.detailDes')
  final String? detailDes;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.poRaised')
  final String? poRaised;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.closureTime')
  final String? closureTime;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.invoiceSubmit')
  final String? invoiceSubmit;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.escalation.1')
  final String? escalation1;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.escalation2Poc')
  final String? escalation2Poc;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.closureDate')
  final String? closureDate;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.escalation.2')
  final String? escalation2;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.issueType')
  final String? issueType;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.reworkDate')
  final String? reworkDate;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.escalation.3')
  final String? escalation3;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.region')
  final String? region;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.createTime')
  final String? createTime;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.shortDecIncident')
  final String? shortDecIncident;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.slNo')
  final String? slNo;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.status.review')
  final String? statusReview;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.system.acsCCTVIDS')
  final String? systemAcsCCTVIDS;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.vendorTicketNo')
  final String? vendorTicketNo;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.activityNotes')
  final String? activityNotes;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.status.invoiceSubmitted')
  final String? statusInvoiceSubmitted;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.incidentReportedIPBArea')
  final String? incidentReportedIPBArea;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.sm')
  final String? sm;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.createDate')
  final String? createDate;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.staffType.internal')
  final String? staffTypeInternal;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.status.closed')
  final String? statusClosed;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.issueType.software')
  final String? issueTypeSoftware;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.accessTicket')
  final String? accessTicket;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.actionTakenMA')
  final String? actionTakenMA;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.ipbArea')
  final String? ipbArea;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.acknowledgeDateTime')
  final String? acknowledgeDateTime;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.quotesApproved.yes')
  final String? quotesApprovedYes;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.slaOnsiteResponse')
  final String? slaOnsiteResponse;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.attachDocumentsDesc')
  final String? attachDocumentsDesc;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.quotesApproved.no')
  final String? quotesApprovedNo;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.rework')
  final String? rework;

  @JsonKey(name: 'com.arlanto.atom.securitySystem.rejectionComment')
  final String? rejectionComment;


  SSLAUiLabelsLocale(
      this.selectVendor,
      this.sendReview,
      this.downtime,
      this.incidentDes,
      this.siteVisitDate,
      this.networkIssue,
      this.asl,
      this.dataLoss,
      this.criticalSpareUsedYes,
      this.siteVisitTime,
      this.costInvolvedYes,
      this.solvedProposed,
      this.ticketCDT,
      this.descService,
      this.system,
      this.status,
      this.invoiceRequest,
      this.poNo,
      this.escalation3Poc,
      this.location,
      this.costInvolved,
      this.slaResolutionDate,
      this.criticalSpareUsed,
      this.lt,
      this.ticketType,
      this.attachmentMandatory,
      this.statusOnHold,
      this.activityLog,
      this.rootCauseAnalysis,
      this.statusPoRaised,
      this.vendorPoc,
      this.statusReWork,
      this.statusQuotesApproved,
      this.vendor,
      this.solvedComplete,
      this.systemIdsCCTV,
      this.acknowledgeTicket,
      this.quotesApproved,
      this.vendorTNo,
      this.statusSubmit,
      this.generateReminder,
      this.issueTypeHardware,
      this.dataLossYes,
      this.invoiceNo,
      this.criticalSpareUsedNo,
      this.workCompCSM,
      this.attachDocuments,
      this.ticketTypeIncident,
      this.statusAcknowledge,
      this.escalation1Poc,
      this.createdBy,
      this.staffTypeExternal,
      this.ticketCreatedOn,
      this.serviceRC,
      this.ticketTypeServiceRequest,
      this.attachmentIA,
      this.staffType,
      this.ipbAreaYes,
      this.provideEmailList,
      this.sendForRework,
      this.statusSolveProposed,
      this.systemVms,
      this.closure,
      this.attachment,
      this.systemAcs,
      this.acknowledgeTicketYes,
      this.statusWorkCompleted,
      this.ticketAcknowledge,
      this.statusApprove,
      this.ssm,
      this.statusInvoiceRequest,
      this.statusOpen,
      this.costInvolvedNo,
      this.sendRework,
      this.dataLossNo,
      this.onsiteVisitDT,
      this.statusQuotesRejected,
      this.generateQAN,
      this.systemIds,
      this.statusCreate,
      this.systemAcsCCTV,
      this.solvedProposedDT,
      this.onHoldReason,
      this.ipbAreaNo,
      this.onHold,
      this.acknowledgeTicketNo,
      this.detailDes,
      this.poRaised,
      this.closureTime,
      this.invoiceSubmit,
      this.escalation1,
      this.escalation2Poc,
      this.closureDate,
      this.escalation2,
      this.issueType,
      this.reworkDate,
      this.escalation3,
      this.region,
      this.createTime,
      this.shortDecIncident,
      this.slNo,
      this.statusReview,
      this.systemAcsCCTVIDS,
      this.vendorTicketNo,
      this.activityNotes,
      this.statusInvoiceSubmitted,
      this.incidentReportedIPBArea,
      this.sm,
      this.createDate,
      this.staffTypeInternal,
      this.statusClosed,
      this.issueTypeSoftware,
      this.accessTicket,
      this.actionTakenMA,
      this.ipbArea,
      this.acknowledgeDateTime,
      this.quotesApprovedYes,
      this.slaOnsiteResponse,
      this.attachDocumentsDesc,
      this.quotesApprovedNo,
      this.rework,
      this.rejectionComment);

  factory SSLAUiLabelsLocale.fromJson(Map<String, dynamic> json) =>
      _$SSLAUiLabelsLocaleFromJson(json);

  Map<String, dynamic> toJson() => _$SSLAUiLabelsLocaleToJson(this);
}
