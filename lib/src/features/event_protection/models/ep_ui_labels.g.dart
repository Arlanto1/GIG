// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ep_ui_labels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EPUiLabels _$EPUiLabelsFromJson(Map<String, dynamic> json) => EPUiLabels(
      defaultLocale:
          EPUiLabelsLocale.fromJson(json['default'] as Map<String, dynamic>),
      locale: EPUiLabelsLocale.fromJson(json['locale'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EPUiLabelsToJson(EPUiLabels instance) =>
    <String, dynamic>{
      'locale': instance.locale,
      'default': instance.defaultLocale,
    };

EPUiLabelsLocale _$EPUiLabelsLocaleFromJson(Map<String, dynamic> json) =>
    EPUiLabelsLocale(
      json['com.arlanto.atom.eventProtection.vendorDetails'] as String?,
      json['com.arlanto.atom.eventProtection.eventLocation'] as String?,
      json['com.arlanto.atom.eventProtection.inputDate'] as String?,
      json['com.arlanto.atom.eventProtection.slNo'] as String?,
      json['com.arlanto.atom.eventProtection.status'] as String?,
      json['com.arlanto.atom.eventProtection.entrySecurity'] as String?,
      json['com.arlanto.atom.eventProtection.srh1'] as String?,
      json['com.arlanto.atom.eventProtection.srh2'] as String?,
      json['com.arlanto.atom.eventProtection.lsm1'] as String?,
      json['com.arlanto.atom.eventProtection.lsm2'] as String?,
      json['com.arlanto.atom.eventProtection.lsm1ContactNo'] as String?,
      json['com.arlanto.atom.eventProtection.lsm2ContactNo'] as String?,
      json['com.arlanto.atom.eventProtection.bu1Dept'] as String?,
      json['com.arlanto.atom.eventProtection.bu2Dept'] as String?,
      json['com.arlanto.atom.eventProtection.bu1ContactNo'] as String?,
      json['com.arlanto.atom.eventProtection.bu2ContactNo'] as String?,
      json['com.arlanto.atom.eventProtection.systemVendor1'] as String?,
      json['com.arlanto.atom.eventProtection.systemVendor1ContactNo']
          as String?,
      json['com.arlanto.atom.eventProtection.systemVendor2'] as String?,
      json['com.arlanto.atom.eventProtection.systemVendor2ContactNo']
          as String?,
      json['com.arlanto.atom.eventProtection.systemVendor3'] as String?,
      json['com.arlanto.atom.eventProtection.systemVendor3ContactNo']
          as String?,
      json['com.arlanto.atom.eventProtection.epOfficers'] as String?,
      json['com.arlanto.atom.eventProtection.extraSecurityDeployed'] as String?,
      json['com.arlanto.atom.eventProtection.vendorId'] as String?,
      json['com.arlanto.atom.eventProtection.guardingVendorPoc'] as String?,
      json['com.arlanto.atom.eventProtection.securityOfficerCountHrs']
          as String?,
      json['com.arlanto.atom.eventProtection.securitySupervisorCountHrs']
          as String?,
      json['com.arlanto.atom.eventProtection.securityGuardCount'] as String?,
      json['com.arlanto.atom.eventProtection.securityGuardCountHrs'] as String?,
      json['com.arlanto.atom.eventProtection.securityFacilitatorCount']
          as String?,
      json['com.arlanto.atom.eventProtection.securityFacilitatorCountHrs']
          as String?,
      json['com.arlanto.atom.eventProtection.proposedVendors'] as String?,
      json['com.arlanto.atom.eventProtection.eventName'] as String?,
      json['com.arlanto.atom.eventProtection.eventConcludedAt'] as String?,
      json['com.arlanto.atom.eventProtection.budget'] as String?,
      json['com.arlanto.atom.eventProtection.controlChecks.cctvRetention']
          as String?,
      json['com.arlanto.atom.eventProtection.status.epPreReview'] as String?,
      json['com.arlanto.atom.eventProtection.bu1'] as String?,
      json['com.arlanto.atom.eventProtection.bu2'] as String?,
      json['com.arlanto.atom.eventProtection.securityOfficerCount'] as String?,
      json['com.arlanto.atom.eventProtection.controlChecks.accessControl']
          as String?,
      json['com.arlanto.atom.eventProtection.aarGrade.rating.lessPositive']
          as String?,
      json['com.arlanto.atom.eventProtection.eepOversight'] as String?,
      json['com.arlanto.atom.eventProtection.important'] as String?,
      json['com.arlanto.atom.eventProtection.controlChecks.documents']
          as String?,
      json['com.arlanto.atom.eventProtection.medium.regulatory'] as String?,
      json['com.arlanto.atom.eventProtection.status.epPostApproved'] as String?,
      json['com.arlanto.atom.eventProtection.dbStaffConcentrationRisk.high']
          as String?,
      json['com.arlanto.atom.eventProtection.serviceEngineerContactPrimary']
          as String?,
      json['com.arlanto.atom.eventProtection.commandSupportCbre'] as String?,
      json['com.arlanto.atom.eventProtection.vendorStaffDetails'] as String?,
      json['com.arlanto.atom.eventProtection.entity'] as String?,
      json['com.arlanto.atom.eventProtection.entityType'] as String?,
      json['com.arlanto.atom.eventProtection.entityOwner'] as String?,
      json['com.arlanto.atom.eventProtection.important.comment'] as String?,
      json['com.arlanto.atom.eventProtection.sensitiveInfoRisk'] as String?,
      json['com.arlanto.atom.eventProtection.locationParticipants.external1']
          as String?,
      json['com.arlanto.atom.eventProtection.securityDeployment'] as String?,
      json['com.arlanto.atom.eventProtection.securityEquipmentCost'] as String?,
      json['com.arlanto.atom.eventProtection.qmrGrade'] as String?,
      json['com.arlanto.atom.eventProtection.qmrGrade.qmrSecOpsComments']
          as String?,
      json['com.arlanto.atom.eventProtection.epOnsite'] as String?,
      json['com.arlanto.atom.eventProtection.conclusion'] as String?,
      json['com.arlanto.atom.eventProtection.serious.reputation'] as String?,
      json['com.arlanto.atom.eventProtection.controlChecks.smokingZone']
          as String?,
      json['com.arlanto.atom.eventProtection.dbPassAggSecurityRisk.high']
          as String?,
      json['com.arlanto.atom.eventProtection.status.epPostRejected'] as String?,
      json['com.arlanto.atom.eventProtection.commandAndSupportDetails']
          as String?,
      json['com.arlanto.atom.eventProtection.qmrGrade.rating.likely']
          as String?,
      json['com.arlanto.atom.eventProtection.serviceEngineerDetails']
          as String?,
      json['com.arlanto.atom.eventProtection.commandSupportOther'] as String?,
      json['com.arlanto.atom.eventProtection.medium.reputation'] as String?,
      json['com.arlanto.atom.eventProtection.securityGuardCountRounding']
          as String?,
      json['com.arlanto.atom.eventProtection.totalAttendies'] as String?,
      json['com.arlanto.atom.eventProtection.securitySupervisorCount']
          as String?,
      json['com.arlanto.atom.eventProtection.low.reputation'] as String?,
      json['com.arlanto.atom.eventProtection.status.epPostReview'] as String?,
      json['com.arlanto.atom.eventProtection.sensitivity'] as String?,
      json['com.arlanto.atom.eventProtection.situation'] as String?,
      json['com.arlanto.atom.eventProtection.serious'] as String?,
      json['com.arlanto.atom.eventProtection.high.reputation'] as String?,
      json['com.arlanto.atom.eventProtection.locationParticipants.external']
          as String?,
      json['com.arlanto.atom.eventProtection.eventEndDate'] as String?,
      json['com.arlanto.atom.eventProtection.aarGrade'] as String?,
      json['com.arlanto.atom.eventProtection.hotelSecurityPrimary'] as String?,
      json['com.arlanto.atom.eventProtection.invoice'] as String?,
      json['com.arlanto.atom.eventProtection.mediaExposure'] as String?,
      json['com.arlanto.atom.eventProtection.controlChecks.locksKeys']
          as String?,
      json['com.arlanto.atom.eventProtection.situation.actionPlan'] as String?,
      json['com.arlanto.atom.eventProtection.epPostGrade'] as String?,
      json['com.arlanto.atom.eventProtection.safetyGrade'] as String?,
      json['com.arlanto.atom.eventProtection.important.persons'] as String?,
      json['com.arlanto.atom.eventProtection.bu3'] as String?,
      json['com.arlanto.atom.eventProtection.accessControlCount'] as String?,
      json['com.arlanto.atom.eventProtection.dbStaffConcentrationRisk.low']
          as String?,
      json['com.arlanto.atom.eventProtection.dbStaffConcentrationRisk.med']
          as String?,
      json['com.arlanto.atom.eventProtection.commandSupport'] as String?,
      json['com.arlanto.atom.eventProtection.eventStartDate'] as String?,
      json['com.arlanto.atom.eventProtection.externalStaffAccessControl']
          as String?,
      json['com.arlanto.atom.eventProtection.situation.riskDetail'] as String?,
      json['com.arlanto.atom.eventProtection.controlChecks.barriers']
          as String?,
      json['com.arlanto.atom.eventProtection.controlChecks.bodyguards']
          as String?,
      json['com.arlanto.atom.eventProtection.controlChecks.cctvCoverage']
          as String?,
      json['com.arlanto.atom.eventProtection.controlChecks.entryExitPoints']
          as String?,
      json['com.arlanto.atom.eventProtection.controlChecks.lockers'] as String?,
      json['com.arlanto.atom.eventProtection.controlChecks.manTraps']
          as String?,
      json['com.arlanto.atom.eventProtection.controlChecks.metalDetectors']
          as String?,
      json['com.arlanto.atom.eventProtection.controlChecks.snifferDogs']
          as String?,
      json['com.arlanto.atom.eventProtection.controlChecks.turnstiles']
          as String?,
      json['com.arlanto.atom.eventProtection.eventStartedAt'] as String?,
      json['com.arlanto.atom.eventProtection.eventType'] as String?,
      json['com.arlanto.atom.eventProtection.eventManagement'] as String?,
      json['com.arlanto.atom.eventProtection.eventManagement.external']
          as String?,
      json['com.arlanto.atom.eventProtection.eventManagement.internal']
          as String?,
      json['com.arlanto.atom.eventProtection.requesterDepartment'] as String?,
      json['com.arlanto.atom.eventProtection.dbPassAggSecurityRisk.rating']
          as String?,
      json['com.arlanto.atom.eventProtection.dbPassAggSecurityRisk.medium']
          as String?,
      json['com.arlanto.atom.eventProtection.sensitivityScale.high'] as String?,
      json['com.arlanto.atom.eventProtection.managementCommittee'] as String?,
      json['com.arlanto.atom.eventProtection.epPostApprovalRequested']
          as String?,
      json['com.arlanto.atom.eventProtection.urgent.reputation.rating']
          as String?,
      json['com.arlanto.atom.eventProtection.epPostEscalationRequested']
          as String?,
      json['com.arlanto.atom.eventProtection.sensitivityScale.urgent']
          as String?,
      json['com.arlanto.atom.eventProtection.dbPassAggSecurityRisk.urgent']
          as String?,
      json['com.arlanto.atom.eventProtection.sensitivityScale.serious']
          as String?,
      json['com.arlanto.atom.eventProtection.dbPassAggSecurityRisk.serious']
          as String?,
      json['com.arlanto.atom.eventProtection.status.epPreEscalationRequested']
          as String?,
      json['com.arlanto.atom.eventProtection.sensitivityScale.medium']
          as String?,
      json['com.arlanto.atom.eventProtection.securitySupervisorCountRating']
          as String?,
      json['com.arlanto.atom.eventProtection.epPostApproval'] as String?,
      json['com.arlanto.atom.eventProtection.status.epPreApproved'] as String?,
      json['com.arlanto.atom.eventProtection.location'] as String?,
      json['com.arlanto.atom.eventProtection.locationRegion'] as String?,
      json['com.arlanto.atom.eventProtection.locationParticipants'] as String?,
      json['com.arlanto.atom.eventProtection.locationParticipants.internal']
          as String?,
      json['com.arlanto.atom.eventProtection.locationParticipants.internal1']
          as String?,
      json['com.arlanto.atom.eventProtection.locationParticipants.external2']
          as String?,
      json['com.arlanto.atom.eventProtection.locationParticipants.internal2']
          as String?,
      json['com.arlanto.atom.eventProtection.eventStaffDiscussion'] as String?,
      json['com.arlanto.atom.eventProtection.generalOutline'] as String?,
      json['com.arlanto.atom.eventProtection.situation.eventDetail'] as String?,
      json['com.arlanto.atom.eventProtection.situation.situationEventName']
          as String?,
      json['com.arlanto.atom.eventProtection.situation.situationEventDate']
          as String?,
      json['com.arlanto.atom.eventProtection.situation.eventRiskThreat']
          as String?,
      json['com.arlanto.atom.eventProtection.situation.eventServiceImpact']
          as String?,
      json['com.arlanto.atom.eventProtection.situation.eventSummary']
          as String?,
      json['com.arlanto.atom.eventProtection.healthSafety'] as String?,
      json['com.arlanto.atom.eventProtection.healthSafety.incident'] as String?,
      json['com.arlanto.atom.eventProtection.healthSafety.incidentType']
          as String?,
      json['com.arlanto.atom.eventProtection.healthSafety.comment'] as String?,
      json['com.arlanto.atom.eventProtection.securityPosture'] as String?,
      json['com.arlanto.atom.eventProtection.securityPosture.securityEquipmentCount']
          as String?,
      json['com.arlanto.atom.eventProtection.securityPosture.securityEquipmentCost']
          as String?,
      json['com.arlanto.atom.eventProtection.securityPosture.securityGuardCount']
          as String?,
      json['com.arlanto.atom.eventProtection.securityPosture.securitySupervisorCount']
          as String?,
      json['com.arlanto.atom.eventProtection.securityPosture.securityOfficerCount']
          as String?,
      json['com.arlanto.atom.eventProtection.securityPosture.securityFacilitatorCount']
          as String?,
      json['com.arlanto.atom.eventProtection.securityPosture.guardingVendorPoc']
          as String?,
      json['com.arlanto.atom.eventProtection.securityPosture.vendorId']
          as String?,
      json['com.arlanto.atom.eventProtection.securityPosture.extraSecurityDeployed']
          as String?,
      json['com.arlanto.atom.eventProtection.securityPosture.securityDeployment']
          as String?,
      json['com.arlanto.atom.eventProtection.securityPosture.securityBreach']
          as String?,
      json['com.arlanto.atom.eventProtection.securityPosture.accessControlFail']
          as String?,
      json['com.arlanto.atom.eventProtection.securityPosture.cctvSystemFail']
          as String?,
      json['com.arlanto.atom.eventProtection.securityPosture.autoFireDetect']
          as String?,
      json['com.arlanto.atom.eventProtection.securityPosture.ambulanceCost']
          as String?,
      json['com.arlanto.atom.eventProtection.securityPosture.emergencyFailure']
          as String?,
      json['com.arlanto.atom.eventProtection.securityPosture.annualPowerShutdown']
          as String?,
      json['com.arlanto.atom.eventProtection.securityPosture.compoundEntryFail']
          as String?,
      json['com.arlanto.atom.eventProtection.securityPosture.extinguisherInspection']
          as String?,
      json['com.arlanto.atom.eventProtection.securityPosture.securityTraining']
          as String?,
      json['com.arlanto.atom.eventProtection.securityPosture.oddIncident']
          as String?,
      json['com.arlanto.atom.eventProtection.epPostEscalated'] as String?,
      json['com.arlanto.atom.eventProtection.sensitivityScale.likely']
          as String?,
      json['com.arlanto.atom.eventProtection.dbPassAggSecurityRisk.likely']
          as String?,
      json['com.arlanto.atom.eventProtection.managementCommitteeRating']
          as String?,
      json['com.arlanto.atom.eventProtection.important.rating'] as String?,
    );

Map<String, dynamic> _$EPUiLabelsLocaleToJson(EPUiLabelsLocale instance) =>
    <String, dynamic>{
      'com.arlanto.atom.eventProtection.vendorDetails': instance.vendorDetails,
      'com.arlanto.atom.eventProtection.eventLocation': instance.eventLocation,
      'com.arlanto.atom.eventProtection.inputDate': instance.inputDate,
      'com.arlanto.atom.eventProtection.slNo': instance.slNo,
      'com.arlanto.atom.eventProtection.status': instance.status,
      'com.arlanto.atom.eventProtection.entrySecurity': instance.entrySecurity,
      'com.arlanto.atom.eventProtection.srh1': instance.srh1,
      'com.arlanto.atom.eventProtection.srh2': instance.srh2,
      'com.arlanto.atom.eventProtection.lsm1': instance.lsm1,
      'com.arlanto.atom.eventProtection.lsm2': instance.lsm2,
      'com.arlanto.atom.eventProtection.lsm1ContactNo': instance.lsm1ContactNo,
      'com.arlanto.atom.eventProtection.lsm2ContactNo': instance.lsm2ContactNo,
      'com.arlanto.atom.eventProtection.bu1Dept': instance.bu1Dept,
      'com.arlanto.atom.eventProtection.bu2Dept': instance.bu2Dept,
      'com.arlanto.atom.eventProtection.bu1ContactNo': instance.bu1ContactNo,
      'com.arlanto.atom.eventProtection.bu2ContactNo': instance.bu2ContactNo,
      'com.arlanto.atom.eventProtection.systemVendor1': instance.systemVendor1,
      'com.arlanto.atom.eventProtection.systemVendor1ContactNo':
          instance.systemVendor1ContactNo,
      'com.arlanto.atom.eventProtection.systemVendor2': instance.systemVendor2,
      'com.arlanto.atom.eventProtection.systemVendor2ContactNo':
          instance.systemVendor2ContactNo,
      'com.arlanto.atom.eventProtection.systemVendor3': instance.systemVendor3,
      'com.arlanto.atom.eventProtection.systemVendor3ContactNo':
          instance.systemVendor3ContactNo,
      'com.arlanto.atom.eventProtection.epOfficers': instance.epOfficers,
      'com.arlanto.atom.eventProtection.extraSecurityDeployed':
          instance.extraSecurityDeployed,
      'com.arlanto.atom.eventProtection.vendorId': instance.vendorId,
      'com.arlanto.atom.eventProtection.guardingVendorPoc':
          instance.guardingVendorPoc,
      'com.arlanto.atom.eventProtection.securityOfficerCountHrs':
          instance.securityOfficerCountHrs,
      'com.arlanto.atom.eventProtection.securitySupervisorCountHrs':
          instance.securitySupervisorCountHrs,
      'com.arlanto.atom.eventProtection.securityGuardCount':
          instance.securityGuardCount,
      'com.arlanto.atom.eventProtection.securityGuardCountHrs':
          instance.securityGuardCountHrs,
      'com.arlanto.atom.eventProtection.securityFacilitatorCount':
          instance.securityFacilitatorCount,
      'com.arlanto.atom.eventProtection.securityFacilitatorCountHrs':
          instance.securityFacilitatorCountHrs,
      'com.arlanto.atom.eventProtection.proposedVendors':
          instance.proposedVendors,
      'com.arlanto.atom.eventProtection.eventName': instance.eventName,
      'com.arlanto.atom.eventProtection.eventConcludedAt':
          instance.eventConcludedAt,
      'com.arlanto.atom.eventProtection.budget': instance.budget,
      'com.arlanto.atom.eventProtection.controlChecks.cctvRetention':
          instance.cctvRetention,
      'com.arlanto.atom.eventProtection.status.epPreReview':
          instance.epPreReview,
      'com.arlanto.atom.eventProtection.bu1': instance.bu1,
      'com.arlanto.atom.eventProtection.bu2': instance.bu2,
      'com.arlanto.atom.eventProtection.securityOfficerCount':
          instance.securityOfficerCount,
      'com.arlanto.atom.eventProtection.controlChecks.accessControl':
          instance.accessControl,
      'com.arlanto.atom.eventProtection.aarGrade.rating.lessPositive':
          instance.lessPositive,
      'com.arlanto.atom.eventProtection.eepOversight': instance.eepOversight,
      'com.arlanto.atom.eventProtection.important': instance.important,
      'com.arlanto.atom.eventProtection.controlChecks.documents':
          instance.documents,
      'com.arlanto.atom.eventProtection.medium.regulatory': instance.regulatory,
      'com.arlanto.atom.eventProtection.status.epPostApproved':
          instance.epPostApproved,
      'com.arlanto.atom.eventProtection.dbStaffConcentrationRisk.high':
          instance.dbStaffConcentrationRiskHigh,
      'com.arlanto.atom.eventProtection.serviceEngineerContactPrimary':
          instance.serviceEngineerContactPrimary,
      'com.arlanto.atom.eventProtection.commandSupportCbre':
          instance.commandSupportCbre,
      'com.arlanto.atom.eventProtection.vendorStaffDetails':
          instance.vendorStaffDetails,
      'com.arlanto.atom.eventProtection.entity': instance.entity,
      'com.arlanto.atom.eventProtection.entityType': instance.entityType,
      'com.arlanto.atom.eventProtection.entityOwner': instance.entityOwner,
      'com.arlanto.atom.eventProtection.important.comment':
          instance.importantComment,
      'com.arlanto.atom.eventProtection.sensitiveInfoRisk':
          instance.sensitiveInfoRisk,
      'com.arlanto.atom.eventProtection.locationParticipants.external1':
          instance.locationParticipantsExternal1,
      'com.arlanto.atom.eventProtection.securityDeployment':
          instance.securityDeployment,
      'com.arlanto.atom.eventProtection.securityEquipmentCost':
          instance.securityEquipmentCost,
      'com.arlanto.atom.eventProtection.qmrGrade': instance.qmrGrade,
      'com.arlanto.atom.eventProtection.qmrGrade.qmrSecOpsComments':
          instance.qmrSecOpsComments,
      'com.arlanto.atom.eventProtection.epOnsite': instance.epOnsite,
      'com.arlanto.atom.eventProtection.conclusion': instance.conclusion,
      'com.arlanto.atom.eventProtection.serious.reputation':
          instance.seriousReputation,
      'com.arlanto.atom.eventProtection.controlChecks.smokingZone':
          instance.smokingZone,
      'com.arlanto.atom.eventProtection.dbPassAggSecurityRisk.high':
          instance.dbPassAggSecurityRiskHigh,
      'com.arlanto.atom.eventProtection.status.epPostRejected':
          instance.epPostRejected,
      'com.arlanto.atom.eventProtection.commandAndSupportDetails':
          instance.commandAndSupportDetails,
      'com.arlanto.atom.eventProtection.qmrGrade.rating.likely':
          instance.likely,
      'com.arlanto.atom.eventProtection.serviceEngineerDetails':
          instance.serviceEngineerDetails,
      'com.arlanto.atom.eventProtection.commandSupportOther':
          instance.commandSupportOther,
      'com.arlanto.atom.eventProtection.medium.reputation':
          instance.mediumReputation,
      'com.arlanto.atom.eventProtection.securityGuardCountRounding':
          instance.securityGuardCountRounding,
      'com.arlanto.atom.eventProtection.totalAttendies':
          instance.totalAttendies,
      'com.arlanto.atom.eventProtection.securitySupervisorCount':
          instance.securitySupervisorCount,
      'com.arlanto.atom.eventProtection.low.reputation': instance.lowReputation,
      'com.arlanto.atom.eventProtection.status.epPostReview':
          instance.epPostReview,
      'com.arlanto.atom.eventProtection.sensitivity': instance.sensitivity,
      'com.arlanto.atom.eventProtection.situation': instance.situation,
      'com.arlanto.atom.eventProtection.serious': instance.serious,
      'com.arlanto.atom.eventProtection.high.reputation':
          instance.highReputation,
      'com.arlanto.atom.eventProtection.locationParticipants.external':
          instance.locationParticipantsExternal,
      'com.arlanto.atom.eventProtection.eventEndDate': instance.eventEndDate,
      'com.arlanto.atom.eventProtection.aarGrade': instance.aarGrade,
      'com.arlanto.atom.eventProtection.hotelSecurityPrimary':
          instance.hotelSecurityPrimary,
      'com.arlanto.atom.eventProtection.invoice': instance.invoice,
      'com.arlanto.atom.eventProtection.mediaExposure': instance.mediaExposure,
      'com.arlanto.atom.eventProtection.controlChecks.locksKeys':
          instance.locksKeys,
      'com.arlanto.atom.eventProtection.situation.actionPlan':
          instance.actionPlan,
      'com.arlanto.atom.eventProtection.epPostGrade': instance.epPostGrade,
      'com.arlanto.atom.eventProtection.safetyGrade': instance.safetyGrade,
      'com.arlanto.atom.eventProtection.important.persons':
          instance.importantPersons,
      'com.arlanto.atom.eventProtection.bu3': instance.bu3,
      'com.arlanto.atom.eventProtection.accessControlCount':
          instance.accessControlCount,
      'com.arlanto.atom.eventProtection.dbStaffConcentrationRisk.low':
          instance.dbStaffConcentrationRiskLow,
      'com.arlanto.atom.eventProtection.dbStaffConcentrationRisk.med':
          instance.dbStaffConcentrationRiskMed,
      'com.arlanto.atom.eventProtection.commandSupport':
          instance.commandSupport,
      'com.arlanto.atom.eventProtection.eventStartDate':
          instance.eventStartDate,
      'com.arlanto.atom.eventProtection.externalStaffAccessControl':
          instance.externalStaffAccessControl,
      'com.arlanto.atom.eventProtection.situation.riskDetail':
          instance.riskDetail,
      'com.arlanto.atom.eventProtection.controlChecks.barriers':
          instance.barriers,
      'com.arlanto.atom.eventProtection.controlChecks.bodyguards':
          instance.bodyguards,
      'com.arlanto.atom.eventProtection.controlChecks.cctvCoverage':
          instance.cctvCoverage,
      'com.arlanto.atom.eventProtection.controlChecks.entryExitPoints':
          instance.entryExitPoints,
      'com.arlanto.atom.eventProtection.controlChecks.lockers':
          instance.lockers,
      'com.arlanto.atom.eventProtection.controlChecks.manTraps':
          instance.manTraps,
      'com.arlanto.atom.eventProtection.controlChecks.metalDetectors':
          instance.metalDetectors,
      'com.arlanto.atom.eventProtection.controlChecks.snifferDogs':
          instance.snifferDogs,
      'com.arlanto.atom.eventProtection.controlChecks.turnstiles':
          instance.turnstiles,
      'com.arlanto.atom.eventProtection.eventStartedAt':
          instance.eventStartedAt,
      'com.arlanto.atom.eventProtection.eventType': instance.eventType,
      'com.arlanto.atom.eventProtection.eventManagement':
          instance.eventManagement,
      'com.arlanto.atom.eventProtection.eventManagement.external':
          instance.eventManagementExternal,
      'com.arlanto.atom.eventProtection.eventManagement.internal':
          instance.eventManagementInternal,
      'com.arlanto.atom.eventProtection.requesterDepartment':
          instance.requesterDepartment,
      'com.arlanto.atom.eventProtection.dbPassAggSecurityRisk.rating':
          instance.dbPassAggSecurityRiskRating,
      'com.arlanto.atom.eventProtection.dbPassAggSecurityRisk.medium':
          instance.dbPassAggSecurityRiskMedium,
      'com.arlanto.atom.eventProtection.sensitivityScale.high':
          instance.sensitivityScaleHigh,
      'com.arlanto.atom.eventProtection.managementCommittee':
          instance.managementCommittee,
      'com.arlanto.atom.eventProtection.epPostApprovalRequested':
          instance.epPostApprovalRequested,
      'com.arlanto.atom.eventProtection.urgent.reputation.rating':
          instance.urgentReputationRating,
      'com.arlanto.atom.eventProtection.epPostEscalationRequested':
          instance.epPostEscalationRequested,
      'com.arlanto.atom.eventProtection.sensitivityScale.urgent':
          instance.sensitivityScaleUrgent,
      'com.arlanto.atom.eventProtection.dbPassAggSecurityRisk.urgent':
          instance.dbPassAggSecurityRiskUrgent,
      'com.arlanto.atom.eventProtection.sensitivityScale.serious':
          instance.sensitivityScaleSerious,
      'com.arlanto.atom.eventProtection.dbPassAggSecurityRisk.serious':
          instance.dbPassAggSecurityRiskSerious,
      'com.arlanto.atom.eventProtection.status.epPreEscalationRequested':
          instance.epPreEscalationRequested,
      'com.arlanto.atom.eventProtection.sensitivityScale.medium':
          instance.sensitivityScaleMedium,
      'com.arlanto.atom.eventProtection.securitySupervisorCountRating':
          instance.securitySupervisorCountRating,
      'com.arlanto.atom.eventProtection.epPostApproval':
          instance.epPostApproval,
      'com.arlanto.atom.eventProtection.status.epPreApproved':
          instance.epPreApproved,
      'com.arlanto.atom.eventProtection.location': instance.location,
      'com.arlanto.atom.eventProtection.locationRegion':
          instance.locationRegion,
      'com.arlanto.atom.eventProtection.locationParticipants':
          instance.locationParticipants,
      'com.arlanto.atom.eventProtection.locationParticipants.internal':
          instance.locationParticipantsInternal,
      'com.arlanto.atom.eventProtection.locationParticipants.internal1':
          instance.locationParticipantsInternal1,
      'com.arlanto.atom.eventProtection.locationParticipants.external2':
          instance.locationParticipantsExternal2,
      'com.arlanto.atom.eventProtection.locationParticipants.internal2':
          instance.locationParticipantsInternal2,
      'com.arlanto.atom.eventProtection.eventStaffDiscussion':
          instance.eventStaffDiscussion,
      'com.arlanto.atom.eventProtection.generalOutline':
          instance.generalOutline,
      'com.arlanto.atom.eventProtection.situation.eventDetail':
          instance.situationEventDetail,
      'com.arlanto.atom.eventProtection.situation.situationEventName':
          instance.situationEventName,
      'com.arlanto.atom.eventProtection.situation.situationEventDate':
          instance.situationEventDate,
      'com.arlanto.atom.eventProtection.situation.eventRiskThreat':
          instance.situationEventRiskThreat,
      'com.arlanto.atom.eventProtection.situation.eventServiceImpact':
          instance.situationEventServiceImpact,
      'com.arlanto.atom.eventProtection.situation.eventSummary':
          instance.situationEventSummary,
      'com.arlanto.atom.eventProtection.healthSafety': instance.healthSafety,
      'com.arlanto.atom.eventProtection.healthSafety.incident':
          instance.healthSafetyIncident,
      'com.arlanto.atom.eventProtection.healthSafety.incidentType':
          instance.healthSafetyIncidentType,
      'com.arlanto.atom.eventProtection.healthSafety.comment':
          instance.healthSafetyComment,
      'com.arlanto.atom.eventProtection.securityPosture':
          instance.securityPosture,
      'com.arlanto.atom.eventProtection.securityPosture.securityEquipmentCount':
          instance.securityPostureSecurityEquipmentCount,
      'com.arlanto.atom.eventProtection.securityPosture.securityEquipmentCost':
          instance.securityPostureSecurityEquipmentCost,
      'com.arlanto.atom.eventProtection.securityPosture.securityGuardCount':
          instance.securityPostureSecurityGuardCount,
      'com.arlanto.atom.eventProtection.securityPosture.securitySupervisorCount':
          instance.securityPostureSecuritySupervisorCount,
      'com.arlanto.atom.eventProtection.securityPosture.securityOfficerCount':
          instance.securityPostureSecurityOfficerCount,
      'com.arlanto.atom.eventProtection.securityPosture.securityFacilitatorCount':
          instance.securityPostureSecurityFacilitatorCount,
      'com.arlanto.atom.eventProtection.securityPosture.guardingVendorPoc':
          instance.securityPostureGuardingVendorPoc,
      'com.arlanto.atom.eventProtection.securityPosture.vendorId':
          instance.securityPostureVendorId,
      'com.arlanto.atom.eventProtection.securityPosture.extraSecurityDeployed':
          instance.securityPostureExtraSecurityDeployed,
      'com.arlanto.atom.eventProtection.securityPosture.securityDeployment':
          instance.securityPostureSecurityDeployment,
      'com.arlanto.atom.eventProtection.securityPosture.securityBreach':
          instance.securityPostureSecurityBreach,
      'com.arlanto.atom.eventProtection.securityPosture.accessControlFail':
          instance.securityPostureAccessControlFail,
      'com.arlanto.atom.eventProtection.securityPosture.cctvSystemFail':
          instance.securityPostureCctvSystemFail,
      'com.arlanto.atom.eventProtection.securityPosture.autoFireDetect':
          instance.securityPostureAutoFireDetect,
      'com.arlanto.atom.eventProtection.securityPosture.ambulanceCost':
          instance.securityPostureAmbulanceCost,
      'com.arlanto.atom.eventProtection.securityPosture.emergencyFailure':
          instance.securityPostureEmergencyFailure,
      'com.arlanto.atom.eventProtection.securityPosture.annualPowerShutdown':
          instance.securityPostureAnnualPowerShutdown,
      'com.arlanto.atom.eventProtection.securityPosture.compoundEntryFail':
          instance.securityPostureCompoundEntryFail,
      'com.arlanto.atom.eventProtection.securityPosture.extinguisherInspection':
          instance.securityPostureExtinguisherInspection,
      'com.arlanto.atom.eventProtection.securityPosture.securityTraining':
          instance.securityPostureSecurityTraining,
      'com.arlanto.atom.eventProtection.securityPosture.oddIncident':
          instance.securityPostureOddIncident,
      'com.arlanto.atom.eventProtection.epPostEscalated':
          instance.epPostEscalated,
      'com.arlanto.atom.eventProtection.sensitivityScale.likely':
          instance.sensitivityScaleLikely,
      'com.arlanto.atom.eventProtection.dbPassAggSecurityRisk.likely':
          instance.dbPassAggSecurityRiskLikely,
      'com.arlanto.atom.eventProtection.managementCommitteeRating':
          instance.managementCommitteeRating,
      'com.arlanto.atom.eventProtection.important.rating':
          instance.importantRating,
    };
