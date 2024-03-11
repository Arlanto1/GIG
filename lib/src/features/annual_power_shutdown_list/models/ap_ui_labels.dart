
import '../../../../index.dart';

@JsonSerializable()
class ApUILabels {
  ApUILabels({
    required this.defaultLocale,
    required this.locale,
  });

  // factory ApUILabels.fromJson(Map<String, dynamic> json) =>
  //     _$ApUILabelsFromJson(json);
  //
  // Map<String, dynamic> toJson() => _$ApUILabelsToJson(this);

  @JsonKey(name: 'locale')
  final ApUILabelsLocale locale;
  @JsonKey(name: 'default')
  final ApUILabelsLocale defaultLocale;
}

@JsonSerializable()
class ApUILabelsLocale {
  @JsonKey(name: 'com.arlanto.atom.eventProtection.eventConcludedAt')
   String? eventConcludedAt;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.budget')
  final String? budget;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.controlChecks.cctvRetention')
  final String? cctvRetention;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.situation.eventDetail')
  final String? eventDetail;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status.epPreReview')
  final String? epPreReview;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.bu1')
  final String? bu1;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.bu2')
  final String? bu2;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityOfficerCount')
  final String? securityOfficerCount;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.controlChecks.accessControl')
  final String? accessControl;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.aarGrade.rating.lessPositive')
  final String? lessPositive;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.eepOversight')
  final String? eepOversight;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.important')
  final String? important;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.controlChecks.documents')
  final String? documents;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.medium.regulatory')
  final String? regulatory;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status.epPostApproved')
  final String? epPostApproved;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.dbStaffConcentrationRisk.high')
  final String? dbStaffConcentrationRiskHigh;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.serviceEngineerContactPrimary')
  final String? serviceEngineerContactPrimary;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.commandSupportCbre')
  final String? commandSupportCbre;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.vendorStaffDetails')
  final String? vendorStaffDetails;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.entity')
  final String? entity;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.sensitiveInfoRisk')
  final String? sensitiveInfoRisk;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.locationParticipants.external1')
  final String? locationParticipantsExternal1;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityDeployment')
  final String? securityDeployment;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityEquipmentCost')
  final String? securityEquipmentCost;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.qmrGrade')
  final String? qmrGrade;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.serious.reputation')
  final String? reputation;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.qmrGrade.qmrSecOpsComments')
  final String? qmrSecOpsComments;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.epOnsite')
  final String? epOnsite;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.conclusion')
  final String? conclusion;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.controlChecks.smokingZone')
  final String? smokingZone;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.totalAttendies')
  final String? totalAttendies;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.securitySupervisorCount')
  final String? securitySupervisorCount;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.low.reputation')
  final String? lowReputation;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status.epPostReview')
  final String? epPostReview;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.sensitivity')
  final String? sensitivity;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.situation')
  final String? situation;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.serious')
  final String? serious;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.high.reputation')
  final String? highReputation;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.locationParticipants.external')
  final String? locationParticipantsExternal;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.eventEndDate')
  final String? eventEndDate;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.aarGrade')
  final String? aarGrade;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.hotelSecurityPrimary')
  final String? hotelSecurityPrimary;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.invoice')
  final String? invoice;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.mediaExposure')
  final String? mediaExposure;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.unlikely.comment')
  final String? unlikelyComment;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.eventManagement.internal')
  final String? eventManagementInternal;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.commandAndSupportType')
  final String? commandAndSupportType;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.commandSupportScri')
  final String? commandSupportScri;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.additionalInfo5')
  final String? additionalInfo5;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status.closed')
  final String? closed;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.medium')
  final String? medium;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.hotelSecuritySecondary')
  final String? hotelSecuritySecondary;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status.epPreRejected')
  final String? epPreRejected;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityGuardCount')
  final String? securityGuardCount;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.managementCommitteeSecondary')
  final String? managementCommitteeSecondary;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.generalOutline')
  final String? generalOutline;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.threatToDB')
  final String? threatToDB;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.additionalInfo4')
  final String? additionalInfo4;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status.open')
  final String? open;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.qmrGrade.qmrOpsComments')
  final String? qmrOpsComments;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.controlChecks.audits')
  final String? audits;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.commandSupportPrimary')
  final String? commandSupportPrimary;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.sensitivityScale')
  final String? sensitivityScale;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.eventId')
  final String? eventId;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.dbPassAggSecurityRisk')
  final String? dbPassAggSecurityRisk;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.low.reputationComment')
  final String? lowReputationComment;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.eventName')
  final String? eventName;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.managementCommitteePrimary')
  final String? managementCommitteePrimary;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status.epPreApproved')
  final String? epPreApproved;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.high.reputationComment')
  final String? highReputationComment;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.eventStartDate')
  final String? eventStartDate;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.serviceEngineerContactSecondary')
  final String? serviceEngineerContactSecondary;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status.escalated')
  final String? escalated;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.controlChecks.incidentReport')
  final String? incidentReport;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.important.comment')
  final String? importantComment;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.incidentReport')
  final String? incidentReport;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.vendorDetails')
  final String? vendorDetails;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.additionalInfo1')
  final String? additionalInfo1;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.additionalInfo2')
  final String? additionalInfo2;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.additionalInfo3')
  final String? additionalInfo3;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.situationalOverview')
  final String? situationalOverview;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.controlChecks.backgroundChecks')
  final String? backgroundChecks;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.entityType')
  final String? entityType;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status')
  final String? status;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.country')
  final String? country;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.threatToIP')
  final String? threatToIP;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.eventProtectionType')
  final String? eventProtectionType;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityGrade')
  final String? securityGrade;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status.epPreEscalated')
  final String? epPreEscalated;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.medium.external')
  final String? mediumExternal;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.managementCommitteeOther')
  final String? managementCommitteeOther;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.dbPassAggSecurityRisk.low')
  final String? dbPassAggSecurityRiskLow;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.additionalInfo')
  final String? additionalInfo;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.low.reputation.rating')
  final String? lowReputationRating;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.eventType')
  final String? eventType;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.threatToIP.internal')
  final String? threatToIPInternal;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status.epPostEscalated')
  final String? epPostEscalated;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.epPreApprovalRequested')
  final String? epPreApprovalRequested;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.epPostReview')
  final String? epPostReview;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.medium.internal')
  final String? mediumInternal;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.medium.none')
  final String? mediumNone;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.sensitivityScale.rating')
  final String? sensitivityScaleRating;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.managementCommitteeChair')
  final String? managementCommitteeChair;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.epPreReview')
  final String? epPreReview;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.likely.comment')
  final String? likelyComment;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.eventManagement.external')
  final String? eventManagementExternal;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityOfficerCountRounding')
  final String? securityOfficerCountRounding;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.securitySupervisorCountRounding')
  final String? securitySupervisorCountRounding;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.locationParticipants.internal')
  final String? locationParticipantsInternal;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.serious.reputation.rating')
  final String? seriousReputationRating;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.medium.sensitivity')
  final String? mediumSensitivity;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.controlChecks.bagSearches')
  final String? bagSearches;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.dbPassAggSecurityRisk.high')
  final String? dbPassAggSecurityRiskHigh;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status.epPostRejected')
  final String? epPostRejected;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.commandAndSupportDetails')
  final String? commandAndSupportDetails;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.qmrGrade.rating.likely')
  final String? likely;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.serviceEngineerDetails')
  final String? serviceEngineerDetails;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.commandSupportOther')
  final String? commandSupportOther;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.medium.reputation')
  final String? mediumReputation;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityGuardCountRounding')
  final String? securityGuardCountRounding;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status.epPostApproved')
  final String? epPostApproved;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.commandSupportType')
  final String? commandSupportType;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.sensitivityScale.low')
  final String? sensitivityScaleLow;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.important')
  final String? important;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityOfficerCount')
  final String? securityOfficerCount;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityGuardCount')
  final String? securityGuardCount;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.locationParticipants.external')
  final String? locationParticipantsExternal;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status.epPostReview')
  final String? epPostReview;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status.epPreRejected')
  final String? epPreRejected;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.dbPassAggSecurityRisk.medium')
  final String? dbPassAggSecurityRiskMedium;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.securitySupervisorCount')
  final String? securitySupervisorCount;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.sensitivityScale.high')
  final String? sensitivityScaleHigh;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.managementCommittee')
  final String? managementCommittee;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.epPostApprovalRequested')
  final String? epPostApprovalRequested;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status.epPreRejected')
  final String? epPreRejected;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.urgent.reputation.rating')
  final String? urgentReputationRating;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.epPostEscalationRequested')
  final String? epPostEscalationRequested;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status.epPostEscalationRequested')
  final String? epPostEscalationRequested;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.sensitivityScale.urgent')
  final String? sensitivityScaleUrgent;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.dbPassAggSecurityRisk.urgent')
  final String? dbPassAggSecurityRiskUrgent;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.sensitivityScale.serious')
  final String? sensitivityScaleSerious;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.dbPassAggSecurityRisk.serious')
  final String? dbPassAggSecurityRiskSerious;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status.epPreEscalationRequested')
  final String? epPreEscalationRequested;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.sensitivityScale.medium')
  final String? sensitivityScaleMedium;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status.epPreEscalationRequested')
  final String? epPreEscalationRequested;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.dbPassAggSecurityRisk.rating')
  final String? dbPassAggSecurityRiskRating;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.entityOwner')
  final String? entityOwner;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.securitySupervisorCountRating')
  final String? securitySupervisorCountRating;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.epPostApproval')
  final String? epPostApproval;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status.epPreApproved')
  final String? epPreApproved;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.epPostEscalated')
  final String? epPostEscalated;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.sensitivityScale.likely')
  final String? sensitivityScaleLikely;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.dbPassAggSecurityRisk.likely')
  final String? dbPassAggSecurityRiskLikely;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status.epPostRejected')
  final String? epPostRejected;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status.epPreRejected')
  final String? epPreRejected;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.status.epPostReview')
  final String? epPostReview;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.managementCommitteeRating')
  final String? managementCommitteeRating;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.important.rating')
  final String? importantRating;
  @JsonKey(name: 'com.arlanto.atom.eventProtection.epPostApprovalRequested')
  final String? epPostApprovalRequested;

//
  ApUiLabelsLocale(
  this.slNo,
  this.eventConcludedAt,
  this.budget,
  this.cctvRetention,
  this.eventDetail,
  this.epPreReview,
  this.bu1,
  this.bu2,
  this.securityOfficerCount,
  this.accessControl,
  this.lessPositive,
  this.eepOversight,
  this.important,
  this.documents,
  this.regulatory,
  this.epPostApproved,
  this.high,
  this.serviceEngineerContactPrimary,
  this.commandSupportCbre,
  this.vendorStaffDetails,
  this.entity,
  this.sensitiveInfoRisk,
  this.external1,
  this.securityDeployment,
  this.securityEquipmentCost,
  this.qmrGrade,
  this.reputation,
  this.qmrSecOpsComments,
  this.epOnsite,
  this.conclusion,
  this.smokingZone,
  this.totalAttendies,
  this.securitySupervisorCount,
  this.external,
  this.eventEndDate,
  this.aarGrade,
  this.hotelSecurityPrimary,
  this.invoice,
  this.mediaExposure,
  this.unlikely,
  this.internal,
  this.commandSupportType,
  this.commandSupportScri,
  this.additionalInfo5,
  this.closed,
  this.medium,
  this.hotelSecuritySecondary,
  this.epPreRejected,
  this.securityGuardCount,
  this.managementCommitteeSecondary,
  this.generalOutline,
  this.threatToDB,
  this.situation,
  this.serious,
  this.eventLocation,
  this.eventProtection,
  this.eventStartDate,
  this.additionalInfo4,
  this.additionalEmails,
  this.totalScore,
  this.commandSupportBackUpContactNo,
  this.organizedCrime,
  this.commandAndSupportType,
  this.commandSupport,
  this.qmrAveragePoints,
  this.poi,
  this.securityRisk,
  this.status,
  this.srh1,
  this.srh2,
  this.pocSecondary,
  this.eventType,
  this.qmr,
  this.dbHrPocPrimary,
  this.vendorReview,
  this.epOfficers,
  this.qmrAuthorizedBy,
  this.vendorStaffList,
  this.autoFireDetect,
  this.managementCommitteePrimary,
  this.dbStaffConcentrationRisk,
  this.eepRecommendation,
  this.mediaExposure2,
  this.situationEventDate,
  this.greEngineeringSDM,
  this.systemVendor3,
  this.corporateSecInPrimary,
  this.systemVendor1,
  this.systemVendor2,
  this.status2,
  this.commandSupportContactNo,
  this.dbSpecificReputationRisk2,
  this.qmrTypeOfService,
  this.poRequired,
  this.bu1Dept,
  this.aarExcellent,
  this.invoiceSubmissionDate,
  this.serviceEngineerContactSecondary,
  this.significant,
  this.map,
  this.wine,
  this.epPostRejected,
  this.dbSpecificReputationRisk3,
  this.commandSupportDept,
  this.crisisManagementSecondary,
  this.vendorApprove,
  this.poNumber,
  this.aarGood,
  this.invoiceRaised,
  this.bu2ContactNo,
  this.offsite,
  this.sensitiveInfoRisk2,
  this.controlChecks,
  this.representativeImage,
  this.unlikely2,
  this.controlChecks2,
  this.locationRegion,
  this.lsm2ContactNo,
  this.tiAssessmentOngoing,
  this.duringEvent,
  this.invoiceRequested,
  this.entrySecurity,
  this.totalPoints,
  this.controlChecks3,
  this.aarRating,
  this.lsmRejected,
  this.overAllRisk,
  this.locationParticipants,
  this.invoiceNumber,
  this.medicalEmergenciesSecondary,
  this.specialPersonAttending,
  this.sensitiveInfoRisk3,
  this.vendorId,
  this.low,
  this.mediaExposure3,
  this.opPlanPoints6,
  this.opPlanPoints2,
  this.opPlanPoints3,
  this.opPlanPoints4,
  this.vendorRating,
  this.opPlanPoints5,
  this.invoiceSubmitted,
  this.bu2Dept,
  this.aarSatisfactory,
  this.systemVendor3ContactNo,
  this.controlChecks4,
  this.actionsOn,
  this.moderate,
  this.eepAwareness,
  this.rejectionComment,
  this.buReview,
  this.countryRiskRating,
  this.hospitalsSecondary,
  this.serviceEngineerNamePrimary,
  this.vendorReject,
  this.politicalSituation,
  this.commandSupportGovernance,
  this.medicalSupportCount,
  this.commandSupportDept2,
  this.buPocApprove,
  this.dbStaffConcentrationRisk2,
  this.onsite,
  this.executivesAttendingNo,
  this.systemVendor1ContactNo,
  this.securityFacilitatorCount,
  this.controlChecks5,
  this.vendorComments,
  this.ground,
  this.corporateSecInSecondary,
  this.vendorEngaged,
  this.controlChecks6,
  this.externalVipAttendance,
  this.eepAssessment2,
  this.eventName,
  this.hardDrinks,
  this.securityRisk2,
  this.epManager1,
  this.likely,
  this.controlChecks7,
  this.serious2,
  this.barCounterCloseTime,
  this.possible,
  this.healthSafety,
  this.eventStaffDiscussion,
  this.securitySupervisorCount2,
  this.systemVendor2ContactNo,
  this.securityFacilitatorCount2,
  this.controlChecks8,
  this.ground2,
  this.corporateSecPrimary,
  this.corporateSecSecondary,
  this.probability,
  this.foundItems,
  this.tiAssessment2,
  this.eventServiceImpact,
  this.barCounterOpenTime,
  this.aarSubmittedBy,
  this.opExecPoints7,
  this.opExecPoints6,
  this.opExecPoints5,
  this.opExecPoints4,
  this.opExecPoints3,
  this.opExecPoints2,
  this.locationParticipants2,
  this.opExecPoints1,
  this.medicalEmergenciesPrimary,
  this.beer,
  this.securityRisk3,
  this.fire,
  this.epManager2,
  this.likely2,
  this.controlChecks9,
  this.controlChecks10,
  this.serious3,
  this.barCounterCloseTime2,
  this.possible2,
  this.healthSafety2,
  this.eventStaffDiscussion2,
  this.securitySupervisorCount3,
  this.systemVendor2ContactNo2,
  this.securityFacilitatorCount3,
  this.controlChecks11,
  this.ground3,
  this.corporateSecPrimary2,
  this.corporateSecSecondary2,
  this.probability2,
  this.foundItems2,
  this.tiAssessment3,
  this.eventServiceImpact2,
  this.barCounterOpenTime2,
  this.ratingSubmittedBy,
  this.opExecPoints7b,
  this.opExecPoints6b,
  this.opExecPoints5b,
  this.opExecPoints4b,
  this.opExecPoints3b,
  this.opExecPoints2b,
  this.locationParticipants3,
  this.opExecPoints1b,
  this.medicalEmergenciesPrimary2,
  this.beer2,
  this.securityRisk4,
  this.fire2,
  this.likely3,
  this.controlChecks12,
  this.controlChecks13,
  this.serious4,
  this.possible3,
  this.healthSafety3,
  this.eventStaffDiscussion3,
  this.securitySupervisorCount4,
  this.systemVendor2ContactNo3,
  this.securityFacilitatorCount4,
  this.controlChecks14,
  this.ground4,
  this.corporateSecPrimary3,
  this.corporateSecSecondary3,
  this.probability3,
  this.foundItems3,
  this.tiAssessment4,
  this.eventServiceImpact3,
  this.barCounterOpenTime3,
  this.opExecPoints7c,
  this.opExecPoints6c,
  this.opExecPoints5c,
  this.opExecPoints4c,
  this.opExecPoints3c,
  this.opExecPoints2c,
  this.locationParticipants4,
  this.opExecPoints1c,
  this.medicalEmergenciesPrimary3,
  this.beer3,
  this.securityRisk5,
  this.fire3,
  this.epManager3,
  this.likely4,
  this.controlChecks15,
  this.controlChecks16,
  this.serious5);

  factory GmUiLabelsLocale.fromJson(Map<String, dynamic> json) =>
      _$GmUiLabelsLocaleFromJson(json);

  Map<String, dynamic> toJson() => _$GmUiLabelsLocaleToJson(this);
}
