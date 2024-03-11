import 'package:db_atom/index.dart';

@JsonSerializable()
class APSUILabels {
  APSUILabels({
    required this.defaultLocale,
    required this.locale,
  });

  factory APSUILabels.fromJson(Map<String, dynamic> json) =>
      _$APSUILabelsFromJson(json);

  Map<String, dynamic> toJson() => _$APSUILabelsToJson(this);

  @JsonKey(name: 'locale')
  APSUILabelsLocale locale;
  @JsonKey(name: 'default')
  APSUILabelsLocale defaultLocale;
}

@JsonSerializable()
class APSUILabelsLocale {
  @JsonKey(name: 'com.arlanto.atom.eventProtection.vendorDetails')
  String? vendorDetails;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.eventLocation')
  String? eventLocation;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.eventName')
  String? eventName;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.eventConcludedAt')
  String? eventConcludedAt;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.budget')
  String? budget;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.controlChecks.cctvRetention')
  String? cctvRetention;

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

  @JsonKey(name: 'com.arlanto.atom.eventProtection.aarGrade.rating.lessPositive')
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

  @JsonKey(name: 'com.arlanto.atom.eventProtection.dbStaffConcentrationRisk.high')
  String? dbStaffConcentrationRiskHigh;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.serviceEngineerContactPrimary')
  String? serviceEngineerContactPrimary;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.commandSupportCbre')
  String? commandSupportCbre;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.vendorStaffDetails')
  String? vendorStaffDetails;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.entity')
  String? entity;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.entityType')
  String? entityType;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.entityOwner')
  String? entityOwner;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.important.comment')
   String? importantComment;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.sensitiveInfoRisk')
  String? sensitiveInfoRisk;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.locationParticipants.external1')
  String? locationParticipantsExternal1;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityDeployment')
  String? securityDeployment;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityEquipmentCost')
  String? securityEquipmentCost;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.qmrGrade')
  String? qmrGrade;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.qmrGrade.qmrSecOpsComments')
  String? qmrSecOpsComments;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.epOnsite')
  String? epOnsite;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.conclusion')
  String? conclusion;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.serious.reputation')
  String? seriousReputation;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.controlChecks.smokingZone')
  String? smokingZone;

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

  @JsonKey(name: 'com.arlanto.atom.eventProtection.locationParticipants.external')
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

  @JsonKey(name: 'com.arlanto.atom.eventProtection.controlChecks.locksKeys')
  String? locksKeys;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.situation.actionPlan')
  String? actionPlan;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.epPostGrade')
  String? epPostGrade;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.safetyGrade')
  String? safetyGrade;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.important.persons')
  String? importantPersons;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.bu3')
  String? bu3;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.accessControlCount')
  String? accessControlCount;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.dbStaffConcentrationRisk.low')
  String? dbStaffConcentrationRiskLow;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.dbStaffConcentrationRisk.med')
  String? dbStaffConcentrationRiskMed;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.commandSupport')
  String? commandSupport;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.eventStartDate')
  String? eventStartDate;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.externalStaffAccessControl')
  String? externalStaffAccessControl;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.situation.riskDetail')
  String? riskDetail;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.controlChecks.barriers')
  String? barriers;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.controlChecks.bodyguards')
  String? bodyguards;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.controlChecks.cctvCoverage')
  String? cctvCoverage;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.controlChecks.entryExitPoints')
  String? entryExitPoints;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.controlChecks.lockers')
  String? lockers;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.controlChecks.manTraps')
  String? manTraps;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.controlChecks.metalDetectors')
  String? metalDetectors;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.controlChecks.snifferDogs')
  String? snifferDogs;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.controlChecks.turnstiles')
  String? turnstiles;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.eventStartedAt')
  String? eventStartedAt;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.eventType')
  String? eventType;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.eventManagement')
  String? eventManagement;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.eventManagement.external')
  String? eventManagementExternal;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.eventManagement.internal')
  String? eventManagementInternal;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.requesterDepartment')
  String? requesterDepartment;
  @JsonKey(
      name: 'com.arlanto.atom.eventProtection.dbPassAggSecurityRisk.rating')
  String? dbPassAggSecurityRiskRating;

  @JsonKey(
      name: 'com.arlanto.atom.eventProtection.dbPassAggSecurityRisk.medium')
  String? dbPassAggSecurityRiskMedium;

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
      name: 'com.arlanto.atom.eventProtection.securitySupervisorCountRating')
  String? securitySupervisorCountRating;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.epPostApproval')
  String? epPostApproval;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.status.epPreApproved')
  String? epPreApproved;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.locationRegion')
  String? locationRegion;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.locationParticipants')
  String? locationParticipants;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.locationParticipants.internal')
  String? locationParticipantsInternal;


  @JsonKey(name: 'com.arlanto.atom.eventProtection.locationParticipants.internal1')
  String? locationParticipantsInternal1;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.locationParticipants.external2')
  String? locationParticipantsExternal2;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.locationParticipants.internal2')
  String? locationParticipantsInternal2;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.eventStaffDiscussion')
  String? eventStaffDiscussion;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.generalOutline')
  String? generalOutline;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.situation.eventDetail')
  String? situationEventDetail;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.situation.situationEventName')
  String? situationEventName;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.situation.situationEventDate')
  String? situationEventDate;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.situation.eventRiskThreat')
  String? situationEventRiskThreat;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.situation.eventServiceImpact')
  String? situationEventServiceImpact;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.situation.eventSummary')
  String? situationEventSummary;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.healthSafety')
  String? healthSafety;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.healthSafety.incident')
  String? healthSafetyIncident;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.healthSafety.incidentType')
  String? healthSafetyIncidentType;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.healthSafety.comment')
  String? healthSafetyComment;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityPosture')
  String? securityPosture;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityPosture.securityEquipmentCount')
  String? securityPostureSecurityEquipmentCount;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityPosture.securityEquipmentCost')
  String? securityPostureSecurityEquipmentCost;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityPosture.securityGuardCount')
  String? securityPostureSecurityGuardCount;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityPosture.securitySupervisorCount')
  String? securityPostureSecuritySupervisorCount;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityPosture.securityOfficerCount')
  String? securityPostureSecurityOfficerCount;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityPosture.securityFacilitatorCount')
  String? securityPostureSecurityFacilitatorCount;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityPosture.guardingVendorPoc')
  String? securityPostureGuardingVendorPoc;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityPosture.vendorId')
  String? securityPostureVendorId;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityPosture.extraSecurityDeployed')
  String? securityPostureExtraSecurityDeployed;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityPosture.securityDeployment')
  String? securityPostureSecurityDeployment;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityPosture.securityBreach')
  String? securityPostureSecurityBreach;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityPosture.accessControlFail')
  String? securityPostureAccessControlFail;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityPosture.cctvSystemFail')
  String? securityPostureCctvSystemFail;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityPosture.autoFireDetect')
  String? securityPostureAutoFireDetect;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityPosture.ambulanceCost')
  String? securityPostureAmbulanceCost;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityPosture.emergencyFailure')
  String? securityPostureEmergencyFailure;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityPosture.annualPowerShutdown')
  String? securityPostureAnnualPowerShutdown;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityPosture.compoundEntryFail')
  String? securityPostureCompoundEntryFail;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityPosture.extinguisherInspection')
  String? securityPostureExtinguisherInspection;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityPosture.securityTraining')
  String? securityPostureSecurityTraining;

  @JsonKey(name: 'com.arlanto.atom.eventProtection.securityPosture.oddIncident')
  String? securityPostureOddIncident;
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


  APSUILabelsLocale(
      this.vendorDetails,
      this.eventLocation,
      this.eventName,
      this.eventConcludedAt,
      this.budget,
      this.cctvRetention,
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
      this.dbStaffConcentrationRiskHigh,
      this.serviceEngineerContactPrimary,
      this.commandSupportCbre,
      this.vendorStaffDetails,
      this.entity,
      this.entityType,
      this.entityOwner,
      this.importantComment,
      this.sensitiveInfoRisk,
      this.locationParticipantsExternal1,
      this.securityDeployment,
      this.securityEquipmentCost,
      this.qmrGrade,
      this.qmrSecOpsComments,
      this.epOnsite,
      this.conclusion,
      this.seriousReputation,
      this.smokingZone,
      this.dbPassAggSecurityRiskHigh,
      this.epPostRejected,
      this.commandAndSupportDetails,
      this.likely,
      this.serviceEngineerDetails,
      this.commandSupportOther,
      this.mediumReputation,
      this.securityGuardCountRounding,
      this.totalAttendies,
      this.securitySupervisorCount,
      this.lowReputation,
      this.epPostReview,
      this.sensitivity,
      this.situation,
      this.serious,
      this.highReputation,
      this.locationParticipantsExternal,
      this.eventEndDate,
      this.aarGrade,
      this.hotelSecurityPrimary,
      this.invoice,
      this.mediaExposure,
      this.locksKeys,
      this.actionPlan,
      this.epPostGrade,
      this.safetyGrade,
      this.importantPersons,
      this.bu3,
      this.accessControlCount,
      this.dbStaffConcentrationRiskLow,
      this.dbStaffConcentrationRiskMed,
      this.commandSupport,
      this.eventStartDate,
      this.externalStaffAccessControl,
      this.riskDetail,
      this.barriers,
      this.bodyguards,
      this.cctvCoverage,
      this.entryExitPoints,
      this.lockers,
      this.manTraps,
      this.metalDetectors,
      this.snifferDogs,
      this.turnstiles,
      this.eventStartedAt,
      this.eventType,
      this.eventManagement,
      this.eventManagementExternal,
      this.eventManagementInternal,
      this.requesterDepartment,
      this.dbPassAggSecurityRiskRating,
      this.dbPassAggSecurityRiskMedium,
      this.sensitivityScaleHigh,
      this.managementCommittee,
      this.epPostApprovalRequested,
      this.urgentReputationRating,
      this.epPostEscalationRequested,
      this.sensitivityScaleUrgent,
      this.dbPassAggSecurityRiskUrgent,
      this.sensitivityScaleSerious,
      this.dbPassAggSecurityRiskSerious,
      this.epPreEscalationRequested,
      this.sensitivityScaleMedium,
      this.securitySupervisorCountRating,
      this.epPostApproval,
      this.epPreApproved,
      this.locationRegion,
      this.locationParticipants,
      this.locationParticipantsInternal,
      this.locationParticipantsInternal1,
      this.locationParticipantsExternal2,
      this.locationParticipantsInternal2,
      this.eventStaffDiscussion,
      this.generalOutline,
      this.situationEventDetail,
      this.situationEventName,
      this.situationEventDate,
      this.situationEventRiskThreat,
      this.situationEventServiceImpact,
      this.situationEventSummary,
      this.healthSafety,
      this.healthSafetyIncident,
      this.healthSafetyIncidentType,
      this.healthSafetyComment,
      this.securityPosture,
      this.securityPostureSecurityEquipmentCount,
      this.securityPostureSecurityEquipmentCost,
      this.securityPostureSecurityGuardCount,
      this.securityPostureSecuritySupervisorCount,
      this.securityPostureSecurityOfficerCount,
      this.securityPostureSecurityFacilitatorCount,
      this.securityPostureGuardingVendorPoc,
      this.securityPostureVendorId,
      this.securityPostureExtraSecurityDeployed,
      this.securityPostureSecurityDeployment,
      this.securityPostureSecurityBreach,
      this.securityPostureAccessControlFail,
      this.securityPostureCctvSystemFail,
      this.securityPostureAutoFireDetect,
      this.securityPostureAmbulanceCost,
      this.securityPostureEmergencyFailure,
      this.securityPostureAnnualPowerShutdown,
      this.securityPostureCompoundEntryFail,
      this.securityPostureExtinguisherInspection,
      this.securityPostureSecurityTraining,
      this.securityPostureOddIncident,
      this.epPostEscalated,
      this.sensitivityScaleLikely,
      this.dbPassAggSecurityRiskLikely,
      this.managementCommitteeRating,
      this.importantRating);

  factory APSUiLabelsLocale.fromJson(Map<String, dynamic> json) =>
      _$APSUiLabelsLocaleFromJson(json);

  Map<String, dynamic> toJson() => _$APSUiLabelsLocaleToJson(this);
}
