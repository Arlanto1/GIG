import 'package:db_atom/index.dart';

part 'vvip_ui_labels.g.dart';

@JsonSerializable()
class VVIPUiLabels {
  VVIPUiLabels({
    required this.defaultLocale,
    required this.locale,
  });

  factory VVIPUiLabels.fromJson(Map<String, dynamic> json) =>
      _$VVIPUiLabelsFromJson(json);

  Map<String, dynamic> toJson() => _$VVIPUiLabelsToJson(this);

  @JsonKey(name: 'locale')
  final VVIPUiLabelsLocale locale;
  @JsonKey(name: 'default')
  final VVIPUiLabelsLocale defaultLocale;
}

@JsonSerializable()
class VVIPUiLabelsLocale {
  @JsonKey(name: 'com.arlanto.atom.incidentManagement.fteCwrInvolved')
  final String? fteCwrInvolved;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.imRejectionComment')
  final String? imRejectionComment;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.systemReviewer')
  final String? systemReviewer;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.ioRoleReview')
  final String? ioRoleReview;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.closureTargetDate')
  final String? closureTargetDate;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.created')
  final String? created;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.passOfficeRequest')
  final String? passOfficeRequest;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.furtherInvestigation')
  final String? furtherInvestigation;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.incidentAnalysis')
  final String? incidentAnalysis;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.ioReview')
  final String? ioReview;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.dataLossRejectionComment')
  final String? dataLossRejectionComment;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.imApprove')
  final String? imApprove;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.incidentDate')
  final String? incidentDate;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.dataLossReview')
  final String? dataLossReview;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.interviewedByHrId')
  final String? interviewedByHrId;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.passRCA')
  final String? passRCA;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.ioApprove')
  final String? ioApprove;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.color')
  final String? color;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.complainantDbEmp')
  final String? complainantDbEmp;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.systemReviewRequired')
  final String? systemReviewRequired;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.incidentManager')
  final String? incidentManager;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.incidentType.damage')
  final String? incidentTypeDamage;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.slNo')
  final String? slNo;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.passOfficeResponse.data')
  final String? passOfficeResponseData;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.closed')
  final String? closed;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.cwrSponsorEmployeeId')
  final String? cwrSponsorEmployeeId;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.cwrName')
  final String? cwrName;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.fteCWRInvolved')
  final String? fteCWRInvolved;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.intervieweeSign')
  final String? intervieweeSign;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status')
  final String? status;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.externalRcaRequired')
  final String? externalRcaRequired;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.complainantHr')
  final String? complainantHr;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.complainantName')
  final String? complainantName;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.inputDate')
  final String? inputDate;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.ioReject')
  final String? ioReject;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.dataLossReject')
  final String? dataLossReject;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.locationRegion')
  final String? locationRegion;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.passInfoReview')
  final String? passInfoReview;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.passRCAReject')
  final String? passRCAReject;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.hrBusinessPartner')
  final String? hrBusinessPartner;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.passOfficeRejectionComment')
  final String? passOfficeRejectionComment;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.cctvFindings')
  final String? cctvFindings;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.accessRequestStart')
  final String? accessRequestStart;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.imFinalReview')
  final String? imFinalReview;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.systemReject')
  final String? systemReject;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.noneInvolved')
  final String? noneInvolved;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.companyName')
  final String? companyName;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.readAcrossReview')
  final String? readAcrossReview;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.interviewerSign')
  final String? interviewerSign;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.entrySecurity')
  final String? entrySecurity;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.employeeName')
  final String? employeeName;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.staffStatement')
  final String? staffStatement;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.incidentType.negligence')
  final String? incidentTypeNegligence;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.interviewConductedOn')
  final String? interviewConductedOn;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.rcaReject')
  final String? rcaReject;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.interviewedBy')
  final String? interviewedBy;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.fteEmployeeId')
  final String? fteEmployeeId;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.typeOfAsset.company')
  final String? typeOfAssetCompany;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.fteCwrEmployeeId')
  final String? fteCwrEmployeeId;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.location')
  final String? location;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.interview.witness')
  final String? interviewWitness;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.initialInvestigation')
  final String? initialInvestigation;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.incidentType.workplaceViolence')
  final String? incidentTypeWorkplaceViolence;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.entityName')
  final String? entityName;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.furtherInvestigation')
  final String? statusFurtherInvestigation;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.cwrSponsor')
  final String? cwrSponsor;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.involvement')
  final String? involvement;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.imReject')
  final String? imReject;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.incidentType.loss')
  final String? incidentTypeLoss;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.interview.department')
  final String? interviewDepartment;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.passOfficeResponse')
  final String? passOfficeResponse;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.ioRoleRejected')
  final String? ioRoleRejected;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.incidentOwner')
  final String? incidentOwner;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.dataLossVendor')
  final String? dataLossVendor;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.rcaReview')
  final String? rcaReview;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.rcaActionPlanReview')
  final String? rcaActionPlanReview;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.dataLossResponse')
  final String? dataLossResponse;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.employeeId')
  final String? employeeId;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.complainantDepartment')
  final String? complainantDepartment;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.typeOfAsset.personal')
  final String? typeOfAssetPersonal;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.imReview')
  final String? imReview;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.ioRoleApproved')
  final String? ioRoleApproved;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.hrEmployeeId')
  final String? hrEmployeeId;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.readAcrossApproved')
  final String? readAcrossApproved;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.severity.medium')
  final String? severityMedium;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.fteInvolved')
  final String? fteInvolved;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.interview.signature')
  final String? interviewSignature;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.dataLossApprove')
  final String? dataLossApprove;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.complainantHost')
  final String? complainantHost;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.readAcross')
  final String? readAcross;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.investigationDone')
  final String? investigationDone;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.dataLossInfo')
  final String? dataLossInfo;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.typeOfAsset')
  final String? typeOfAsset;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.passInfo')
  final String? passInfo;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.investigation')
  final String? investigation;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.incidentType.general')
  final String? incidentTypeGeneral;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.accessRequestEnd')
  final String? accessRequestEnd;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.rcaActionPlanApproved')
  final String? rcaActionPlanApproved;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.incidentLocation')
  final String? incidentLocation;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.rcaApprove')
  final String? rcaApprove;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.complainant')
  final String? complainant;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.rcaActionPlanRejected')
  final String? rcaActionPlanRejected;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.passOfficeApprovalRequired')
  final String? passOfficeApprovalRequired;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.rcaActionPlan')
  final String? rcaActionPlan;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.cwrInvolved')
  final String? cwrInvolved;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.readAcrossRejected')
  final String? readAcrossRejected;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.rcaVendor')
  final String? rcaVendor;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.entity')
  final String? entity;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.typeOfArticle')
  final String? typeOfArticle;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.passInfoReject')
  final String? passInfoReject;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.rcaRejectionComment')
  final String? rcaRejectionComment;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.incidentType')
  final String? incidentType;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.status.passReject')
  final String? passReject;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.rcaRequest')
  final String? rcaRequest;

  @JsonKey(name: 'com.arlanto.atom.incidentManagement.fteDepartment')
  final String? fteDepartment;
  @JsonKey(name: 'com.arlanto.atom.incidentManagement.description')
  final String? description;


  factory VVIPUiLabelsLocale.fromJson(Map<String, dynamic> json) =>
      _$VVIPUiLabelsLocaleFromJson(json);

  Map<String, dynamic> toJson() => _$VVIPUiLabelsLocaleToJson(this);
}
