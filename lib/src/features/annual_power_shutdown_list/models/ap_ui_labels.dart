import 'package:db_atom/index.dart';

@JsonSerializable()
class ApUILabels {
  ApUILabels({
    required this.defaultLocale,
    required this.locale,
  });

  factory ApUILabels.fromJson(Map<String, dynamic> json) =>
      _$ApUILabelsFromJson(json);

  Map<String, dynamic> toJson() => _$ApUILabelsToJson(this);

  @JsonKey(name: 'locale')
  ApUILabelsLocale locale;
  @JsonKey(name: 'default')
  ApUILabelsLocale defaultLocale;
}

@JsonSerializable()
class ApUILabelsLocale {
  @JsonKey(name: 'com.arlanto.atom.eventProtection.eventConcludedAt')
  String? eventConcludedAt;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.budget')
  String? budget;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.controlChecks.cctvRetention')
  String? cctvRetention;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.situation.eventDetail')
  String? eventDetail;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status.epPreReview')
  String? epPreReview;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.bu1')
  String? bu1;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.bu2')
  String? bu2;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityOfficerCount')
  String? securityOfficerCount;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.controlChecks.accessControl')
  String? accessControl;
  @JsonKey(
      name: 'com.arlanto.atom.eventProtection.aarGrade.rating.lessPositive')
  String? lessPositive;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.eepOversight')
  String? eepOversight;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.important')
  String? important;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.controlChecks.documents')
  String? documents;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.medium.regulatory')
  String? regulatory;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status.epPostApproved')
  String? epPostApproved;
  @JsonKey(
      name: 'com.arlanto.atom.eventProtection.dbStaffConcentrationRisk.high')
  String? dbStaffConcentrationRiskHigh;
  @JsonKey(
      name: 'com.arlanto.atom.eventProtection.serviceEngineerContactPrimary')
  String? serviceEngineerContactPrimary;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.commandSupportCbre')
  String? commandSupportCbre;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.vendorStaffDetails')
  String? vendorStaffDetails;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.entity')
  String? entity;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.sensitiveInfoRisk')
  String? sensitiveInfoRisk;
  @JsonKey(
      name: 'com.arlanto.atom.eventProtection.locationParticipants.external1')
  String? locationParticipantsExternal1;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityDeployment')
  String? securityDeployment;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityEquipmentCost')
  String? securityEquipmentCost;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.qmrGrade')
  String? qmrGrade;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.serious.reputation')
  String? reputation;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.qmrGrade.qmrSecOpsComments')
  String? qmrSecOpsComments;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.epOnsite')
  String? epOnsite;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.conclusion')
  String? conclusion;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.controlChecks.smokingZone')
  String? smokingZone;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.totalAttendies')
  String? totalAttendies;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.securitySupervisorCount')
  String? securitySupervisorCount;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.low.reputation')
  String? lowReputation;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status.epPostReview')
  String? epPostReview;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.sensitivity')
  String? sensitivity;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.situation')
  String? situation;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.serious')
  String? serious;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.high.reputation')
  String? highReputation;
  @JsonKey(
      name: 'com.arlanto.atom.eventProtection.locationParticipants.external')
  String? locationParticipantsExternal;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.eventEndDate')
  String? eventEndDate;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.aarGrade')
  String? aarGrade;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.hotelSecurityPrimary')
  String? hotelSecurityPrimary;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.invoice')
  String? invoice;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.mediaExposure')
  String? mediaExposure;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.unlikely.comment')
  String? unlikelyComment;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.eventManagement.internal')
  String? eventManagementInternal;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.commandAndSupportType')
  String? commandAndSupportType;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.commandSupportScri')
  String? commandSupportScri;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.additionalInfo5')
  String? additionalInfo5;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status.closed')
  String? closed;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.medium')
  String? medium;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.hotelSecuritySecondary')
  String? hotelSecuritySecondary;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status.epPreRejected')
  String? epPreRejected;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityGuardCount')
  String? securityGuardCount;
  @JsonKey(
      name: 'com.arlanto.atom.eventProtection.managementCommitteeSecondary')
  String? managementCommitteeSecondary;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.generalOutline')
  String? generalOutline;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.threatToDB')
  String? threatToDB;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.additionalInfo4')
  String? additionalInfo4;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status.open')
  String? open;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.qmrGrade.qmrOpsComments')
  String? qmrOpsComments;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.controlChecks.audits')
  String? audits;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.commandSupportPrimary')
  String? commandSupportPrimary;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.sensitivityScale')
  String? sensitivityScale;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.eventId')
  String? eventId;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.dbPassAggSecurityRisk')
  String? dbPassAggSecurityRisk;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.low.reputationComment')
  String? lowReputationComment;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.eventName')
  String? eventName;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.managementCommitteePrimary')
  String? managementCommitteePrimary;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status.epPreApproved')
  String? epPreApproved;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.high.reputationComment')
  String? highReputationComment;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.eventStartDate')
  String? eventStartDate;
  @JsonKey(
      name: 'com.arlanto.atom.eventProtection.serviceEngineerContactSecondary')
  String? serviceEngineerContactSecondary;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status.escalated')
  String? escalated;
  @JsonKey(
      name: 'com.arlanto.atom.eventProtection.controlChecks.incidentReport')
  String? incidentReport;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.important.comment')
  String? importantComment;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.incidentReport')
  String? incidentReport;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.vendorDetails')
  String? vendorDetails;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.additionalInfo1')
  String? additionalInfo1;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.additionalInfo2')
  String? additionalInfo2;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.additionalInfo3')
  String? additionalInfo3;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.situationalOverview')
  String? situationalOverview;
  @JsonKey(
      name: 'com.arlanto.atom.eventProtection.controlChecks.backgroundChecks')
  String? backgroundChecks;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.entityType')
  String? entityType;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status')
  String? status;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.country')
  String? country;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.threatToIP')
  String? threatToIP;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.eventProtectionType')
  String? eventProtectionType;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityGrade')
  String? securityGrade;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status.epPreEscalated')
  String? epPreEscalated;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.medium.external')
  String? mediumExternal;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.managementCommitteeOther')
  String? managementCommitteeOther;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.dbPassAggSecurityRisk.low')
  String? dbPassAggSecurityRiskLow;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.additionalInfo')
  String? additionalInfo;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.low.reputation.rating')
  String? lowReputationRating;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.eventType')
  String? eventType;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.threatToIP.internal')
  String? threatToIPInternal;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status.epPostEscalated')
  String? epPostEscalated;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.epPreApprovalRequested')
  String? epPreApprovalRequested;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.epPostReview')
  String? epPostReview;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.medium.internal')
  String? mediumInternal;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.medium.none')
  String? mediumNone;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.sensitivityScale.rating')
  String? sensitivityScaleRating;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.managementCommitteeChair')
  String? managementCommitteeChair;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.epPreReview')
  String? epPreReview;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.likely.comment')
  String? likelyComment;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.eventManagement.external')
  String? eventManagementExternal;
  @JsonKey(
      name: 'com.arlanto.atom.eventProtection.securityOfficerCountRounding')
  String? securityOfficerCountRounding;
  @JsonKey(
      name: 'com.arlanto.atom.eventProtection.securitySupervisorCountRounding')
  String? securitySupervisorCountRounding;
  @JsonKey(
      name: 'com.arlanto.atom.eventProtection.locationParticipants.internal')
  String? locationParticipantsInternal;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.serious.reputation.rating')
  String? seriousReputationRating;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.medium.sensitivity')
  String? mediumSensitivity;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.controlChecks.bagSearches')
  String? bagSearches;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.dbPassAggSecurityRisk.high')
  String? dbPassAggSecurityRiskHigh;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status.epPostRejected')
  String? epPostRejected;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.commandAndSupportDetails')
  String? commandAndSupportDetails;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.qmrGrade.rating.likely')
  String? likely;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.serviceEngineerDetails')
  String? serviceEngineerDetails;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.commandSupportOther')
  String? commandSupportOther;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.medium.reputation')
  String? mediumReputation;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityGuardCountRounding')
  String? securityGuardCountRounding;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status.epPostApproved')
  String? epPostApproved;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.commandSupportType')
  String? commandSupportType;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.sensitivityScale.low')
  String? sensitivityScaleLow;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.important')
  String? important;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityOfficerCount')
  String? securityOfficerCount;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityGuardCount')
  String? securityGuardCount;
  @JsonKey(
      name: 'com.arlanto.atom.eventProtection.locationParticipants.external')
  String? locationParticipantsExternal;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status.epPostReview')
  String? epPostReview;
  @JsonKey(
      name: 'com.arlanto.atom.eventProtection.dbPassAggSecurityRisk.medium')
  String? dbPassAggSecurityRiskMedium;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.securitySupervisorCount')
  String? securitySupervisorCount;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.sensitivityScale.high')
  String? sensitivityScaleHigh;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.managementCommittee')
  String? managementCommittee;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.epPostApprovalRequested')
  String? epPostApprovalRequested;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.urgent.reputation.rating')
  String? urgentReputationRating;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.epPostEscalationRequested')
  String? epPostEscalationRequested;
  @JsonKey(
      name: 'com.arlanto.atom.eventProtection.status.epPostEscalationRequested')
  String? epPostEscalationRequested;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.sensitivityScale.urgent')
  String? sensitivityScaleUrgent;
  @JsonKey(
      name: 'com.arlanto.atom.eventProtection.dbPassAggSecurityRisk.urgent')
  String? dbPassAggSecurityRiskUrgent;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.sensitivityScale.serious')
  String? sensitivityScaleSerious;
  @JsonKey(
      name: 'com.arlanto.atom.eventProtection.dbPassAggSecurityRisk.serious')
  String? dbPassAggSecurityRiskSerious;
  @JsonKey(
      name: 'com.arlanto.atom.eventProtection.status.epPreEscalationRequested')
  String? epPreEscalationRequested;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.sensitivityScale.medium')
  String? sensitivityScaleMedium;
  @JsonKey(
      name: 'com.arlanto.atom.eventProtection.status.epPreEscalationRequested')
  String? epPreEscalationRequested;
  @JsonKey(
      name: 'com.arlanto.atom.eventProtection.dbPassAggSecurityRisk.rating')
  String? dbPassAggSecurityRiskRating;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.entityOwner')
  String? entityOwner;
  @JsonKey(
      name: 'com.arlanto.atom.eventProtection.securitySupervisorCountRating')
  String? securitySupervisorCountRating;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.epPostApproval')
  String? epPostApproval;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status.epPreApproved')
  String? epPreApproved;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.epPostEscalated')
  String? epPostEscalated;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.sensitivityScale.likely')
  String? sensitivityScaleLikely;
  @JsonKey(
      name: 'com.arlanto.atom.eventProtection.dbPassAggSecurityRisk.likely')
  String? dbPassAggSecurityRiskLikely;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.managementCommitteeRating')
  String? managementCommitteeRating;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.important.rating')
  String? importantRating;

  factory ApUiLabelsLocale.fromJson(Map<String, dynamic> json) =>
      _$ApUiLabelsLocaleFromJson(json);

  Map<String, dynamic> toJson() => _$ApUiLabelsLocaleToJson(this);
}
