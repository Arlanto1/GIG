import '../../../models/department.dart';
import '../../../models/entity.dart';
import '../../../models/location.dart';
import '../../../models/location_region.dart';
import '../../createfound/models/user.dart';

class EventProtectionResponse {
  List<EventProtectionModel>? items;
  int? totalCount;
  int? currentPageNo;
  int? totalPageCount;

  EventProtectionResponse({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  EventProtectionResponse.fromJson(Map<String, dynamic> json)
      : items = (json['data'] as List?)
            ?.map((dynamic e) =>
                EventProtectionModel.fromJson(e as Map<String, dynamic>))
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

class EventProtectionModel {
  int? id;
  String? slNo;
  String? inputDate;
  List<Entity>? entities;
  Location? location;
  LocationRegion? locationRegion;
  User? epManager1;
  User? epManager2;
  String? lsm1ContactNo;
  String? lsm2ContactNo;
  String? epOfficers;
  bool? annualPowerShutdown;
  bool? eventType;
  String? eventName;
  String? eventLocation;
  String? eventStartDate;
  String? eventEndDate;
  bool? specialPersonAttending;
  int? countryRiskRating;
  int? locationParticipants;
  int? mediaExposure;
  int? externalVipAttendance;
  int? sensitiveInfoRisk;
  int? dbSpecificReputationRisk;
  int? totalScore;
  bool? liquorServed;
  bool? hardDrinks;
  bool? wine;
  bool? beer;
  bool? vendorEngaged;
  String? vendorCompanyName;
  String? vendorPocName;
  String? vendorContactNo;
  String? vendorStaffList;
  bool? controlChecks;
  int? cctvRetention;
  bool? accessControl;
  bool? idCardCheck;
  bool? physicalSecurityDeploy;
  bool? baggageScan;
  bool? vehicleCheck;
  bool? bouncersDeploy;
  bool? wristBandRegistered;
  bool? validDocumentsCheck;
  bool? detailedAttendants;
  bool? smokingZone;
  bool? emergencyExits;
  String? bu1ContactNo;
  String? bu2ContactNo;
  String? systemVendor1;
  String? systemVendor2;
  String? systemVendor3;
  String? systemVendor1ContactNo;
  String? systemVendor2ContactNo;
  String? systemVendor3ContactNo;
  String? eepAssessment;
  String? eepRecommendation;
  bool? tiAssessment;
  bool? tiAssessmentOngoing;
  bool? eventStaffDiscussion;
  bool? venueReview;
  bool? eepAwareness;
  bool? eepOversight;
  bool? epOnsite;
  bool? extraSecurityDeployed;
  String? vendorId;
  String? securityEquipmentCount;
  String? guardingVendorPoc;
  String? poNumber;
  bool? opsOrderAccepted;
  bool? securityVendorResponded;
  String? ground;
  int? politicalSituation;
  int? terrorism;
  int? organizedCrime;
  int? threatToDB;
  String? task;
  bool? eventManagement;
  String? mission;
  String? situationEventName;
  String? eventSummary;
  String? eventServiceImpact;
  String? eventRiskThreat;
  String? generalOutline;
  String? securityPosture;
  String? coordination;
  String? additionalInfo4;
  String? actionsOn;
  String? preOperationPlanning;
  String? securityDeployment;
  String? safetyAndSecurity;
  String? monitorAndControl;
  String? conclusion;
  String? beforeEventEmails;
  String? duringEventEmails;
  String? addEventEmails;
  int? fireP;
  int? fireH;
  int? fireR;
  String? fireComment;
  int? autoFireDetectP;
  int? autoFireDetectH;
  int? autoFireDetectR;
  String? autoFireDetectComment;
  int? healthSafetyP;
  int? healthSafetyH;
  int? healthSafetyR;
  String? healthSafetyComment;
  int? emergencyFailureP;
  int? emergencyFailureH;
  int? emergencyFailureR;
  String? emergencyFailureComment;
  int? securityBreachP;
  int? securityBreachH;
  int? securityBreachR;
  String? securityComment;
  int? theftP;
  int? theftH;
  int? theftR;
  String? theftComment;
  int? accessControlFailP;
  int? accessControlFailH;
  int? accessControlFailR;
  String? accessControlComment;
  int? cctvSystemFailP;
  int? cctvSystemFailH;
  int? cctvSystemFailR;
  String? cctvSystemFailComment;
  String? preEventEmail;
  String? duringEventEmail;
  String? afterEventEmail;
  String? lessonLearnt;
  int? aarGrade;
  int? aarRating1;
  String? aarPositive1;
  String? aarLessPositive1;
  String? aarRemedy1;
  int? aarRating2;
  String? aarPositive2;
  String? aarLessPositive2;
  String? aarRemedy2;
  int? aarRating3;
  String? aarPositive3;
  String? aarLessPositive3;
  String? aarRemedy3;
  int? aarRating4;
  String? aarPositive4;
  String? aarLessPositive4;
  String? aarRemedy4;
  int? qmrGrade;
  int? preOpPoints1;
  String? preOpPoints1Comment;
  int? preOpPoints2;
  String? preOpPoints2Comment;
  int? preOpPoints3;
  String? preOpPoints3Comment;
  int? preOpPoints4;
  String? preOpPoints4Comment;
  int? preOpPoints5;
  String? preOpPoints5Comment;
  int? opPlanPoints1;
  String? opPlanPoints1Comment;
  int? opPlanPoints2;
  String? opPlanPoints2Comment;
  int? opPlanPoints3;
  String? opPlanPoints3Comment;
  int? opPlanPoints4;
  String? opPlanPoints4Comment;
  int? opPlanPoints5;
  String? opPlanPoints5Comment;
  int? opPlanPoints6;
  String? opPlanPoints6Comment;
  int? opExecPoints1;
  String? opExecPoints1Comment;
  int? opExecPoints2;
  String? opExecPoints2Comment;
  int? opExecPoints3;
  String? opExecPoints3Comment;
  int? opExecPoints4;
  String? opExecPoints4Comment;
  int? opExecPoints5;
  String? opExecPoints5Comment;
  int? opExecPoints6;
  String? opExecPoints6Comment;
  int? opExecPoints7;
  String? opExecPoints7Comment;
  int? postOpPoints1;
  String? postOpPoints1Comment;
  int? postOpPoints2;
  String? postOpPoints2Comment;
  int? postOpPoints3;
  String? postOpPoints3Comment;
  int? postOpPoints4;
  String? postOpPoints4Comment;
  int? postOpPoints5;
  String? postOpPoints5Comment;
  String? qmrSecOpsComments;
  String? qmrVendorComments;
  int? status;
  bool? paymentProcessed;
  int? modifiedDate;
  String? modifiedBy;
  String? lsm1Name;
  String? lsm2Name;
  String? epManager1Name;
  String? epManager2Name;
  String? bu1Name;
  String? bu2Name;
  String? submittedByName;
  String? authorizedByName;
  String? qmrSubmittedByName;
  String? qmrAuthorizedByName;
  String? preOpPoints1DoneByName;
  String? opExecPoints1DoneByName;
  String? postOpPoints1DoneByName;
  String? srh1Name;
  String? srh2Name;
  Department? bu1Dept;
  Department? bu2Dept;
  Department? requesterDepartment;
  String? vendor1Primary;
  String? vendor1PrimaryContact;
  String? vendor1Secondary;
  String? vendor1SecondaryContact;
  String? vendor2Primary;
  String? vendor2PrimaryContact;
  String? vendor2Secondary;
  String? vendor2SecondaryContact;
  String? vendor3Primary;
  String? vendor3PrimaryContact;
  String? vendor3Secondary;
  String? vendor3SecondaryContact;
  int? securityOfficerCount;
  int? securityOfficerCountHrs;
  int? securitySupervisorCount;
  int? securitySupervisorCountHrs;
  int? securityGuardCount;
  int? securityGuardCountHrs;
  int? securityFacilitatorCount;
  int? securityFacilitatorCountHrs;
  double? budget;
  Department? proposedVendors;

  EventProtectionModel(
      {this.id,
      this.slNo,
      this.inputDate,
      this.location,
      this.locationRegion,
      this.epManager1,
      this.epManager2,
      this.lsm1ContactNo,
      this.lsm2ContactNo,
      this.epOfficers,
      this.annualPowerShutdown,
      this.eventType,
      this.eventName,
      this.eventLocation,
      this.eventStartDate,
      this.eventEndDate,
      this.specialPersonAttending,
      this.countryRiskRating,
      this.locationParticipants,
      this.mediaExposure,
      this.externalVipAttendance,
      this.sensitiveInfoRisk,
      this.dbSpecificReputationRisk,
      this.totalScore,
      this.entities,
      this.liquorServed,
      this.hardDrinks,
      this.wine,
      this.beer,
      this.vendorEngaged,
      this.vendorCompanyName,
      this.vendorPocName,
      this.vendorContactNo,
      this.vendorStaffList,
      this.controlChecks,
      this.cctvRetention,
      this.accessControl,
      this.idCardCheck,
      this.physicalSecurityDeploy,
      this.baggageScan,
      this.vehicleCheck,
      this.bouncersDeploy,
      this.wristBandRegistered,
      this.validDocumentsCheck,
      this.detailedAttendants,
      this.smokingZone,
      this.emergencyExits,
      this.bu1ContactNo,
      this.bu2ContactNo,
      this.systemVendor1,
      this.systemVendor2,
      this.systemVendor3,
      this.systemVendor1ContactNo,
      this.systemVendor2ContactNo,
      this.systemVendor3ContactNo,
      this.eepAssessment,
      this.eepRecommendation,
      this.tiAssessment,
      this.tiAssessmentOngoing,
      this.eventStaffDiscussion,
      this.venueReview,
      this.eepAwareness,
      this.eepOversight,
      this.epOnsite,
      this.extraSecurityDeployed,
      this.vendorId,
      this.securityEquipmentCount,
      this.guardingVendorPoc,
      this.poNumber,
      this.opsOrderAccepted,
      this.securityVendorResponded,
      this.ground,
      this.politicalSituation,
      this.terrorism,
      this.organizedCrime,
      this.threatToDB,
      this.task,
      this.eventManagement,
      this.mission,
      this.situationEventName,
      this.eventSummary,
      this.eventServiceImpact,
      this.eventRiskThreat,
      this.generalOutline,
      this.securityPosture,
      this.coordination,
      this.additionalInfo4,
      this.actionsOn,
      this.preOperationPlanning,
      this.securityDeployment,
      this.safetyAndSecurity,
      this.monitorAndControl,
      this.conclusion,
      this.beforeEventEmails,
      this.duringEventEmails,
      this.addEventEmails,
      this.fireP,
      this.fireH,
      this.fireR,
      this.fireComment,
      this.autoFireDetectP,
      this.autoFireDetectH,
      this.autoFireDetectR,
      this.autoFireDetectComment,
      this.healthSafetyP,
      this.healthSafetyH,
      this.healthSafetyR,
      this.healthSafetyComment,
      this.emergencyFailureP,
      this.emergencyFailureH,
      this.emergencyFailureR,
      this.emergencyFailureComment,
      this.securityBreachP,
      this.securityBreachH,
      this.securityBreachR,
      this.securityComment,
      this.theftP,
      this.theftH,
      this.theftR,
      this.theftComment,
      this.accessControlFailP,
      this.accessControlFailH,
      this.accessControlFailR,
      this.accessControlComment,
      this.cctvSystemFailP,
      this.cctvSystemFailH,
      this.cctvSystemFailR,
      this.cctvSystemFailComment,
      this.preEventEmail,
      this.duringEventEmail,
      this.afterEventEmail,
      this.lessonLearnt,
      this.aarGrade,
      this.aarRating1,
      this.aarPositive1,
      this.aarLessPositive1,
      this.aarRemedy1,
      this.aarRating2,
      this.aarPositive2,
      this.aarLessPositive2,
      this.aarRemedy2,
      this.aarRating3,
      this.aarPositive3,
      this.aarLessPositive3,
      this.aarRemedy3,
      this.aarRating4,
      this.aarPositive4,
      this.aarLessPositive4,
      this.aarRemedy4,
      this.qmrGrade,
      this.preOpPoints1,
      this.preOpPoints1Comment,
      this.preOpPoints2,
      this.preOpPoints2Comment,
      this.preOpPoints3,
      this.preOpPoints3Comment,
      this.preOpPoints4,
      this.preOpPoints4Comment,
      this.preOpPoints5,
      this.preOpPoints5Comment,
      this.opPlanPoints1,
      this.opPlanPoints1Comment,
      this.opPlanPoints2,
      this.opPlanPoints2Comment,
      this.opPlanPoints3,
      this.opPlanPoints3Comment,
      this.opPlanPoints4,
      this.opPlanPoints4Comment,
      this.opPlanPoints5,
      this.opPlanPoints5Comment,
      this.opPlanPoints6,
      this.opPlanPoints6Comment,
      this.opExecPoints1,
      this.opExecPoints1Comment,
      this.opExecPoints2,
      this.opExecPoints2Comment,
      this.opExecPoints3,
      this.opExecPoints3Comment,
      this.opExecPoints4,
      this.opExecPoints4Comment,
      this.opExecPoints5,
      this.opExecPoints5Comment,
      this.opExecPoints6,
      this.opExecPoints6Comment,
      this.opExecPoints7,
      this.opExecPoints7Comment,
      this.postOpPoints1,
      this.postOpPoints1Comment,
      this.postOpPoints2,
      this.postOpPoints2Comment,
      this.postOpPoints3,
      this.postOpPoints3Comment,
      this.postOpPoints4,
      this.postOpPoints4Comment,
      this.postOpPoints5,
      this.postOpPoints5Comment,
      this.qmrSecOpsComments,
      this.qmrVendorComments,
      this.status,
      this.paymentProcessed,
      this.modifiedDate,
      this.modifiedBy,
      this.lsm1Name,
      this.lsm2Name,
      this.epManager1Name,
      this.epManager2Name,
      this.bu1Name,
      this.bu2Name,
      this.submittedByName,
      this.authorizedByName,
      this.qmrSubmittedByName,
      this.qmrAuthorizedByName,
      this.preOpPoints1DoneByName,
      this.opExecPoints1DoneByName,
      this.postOpPoints1DoneByName,
      this.srh1Name,
      this.srh2Name,
      this.bu1Dept,
      this.bu2Dept,
      this.requesterDepartment,
      this.vendor1Primary,
      this.vendor1Secondary,
      this.vendor1SecondaryContact,
      this.vendor1PrimaryContact,
      this.vendor2Primary,
      this.vendor2Secondary,
      this.vendor2SecondaryContact,
      this.vendor2PrimaryContact,
      this.vendor3Primary,
      this.vendor3Secondary,
      this.vendor3SecondaryContact,
      this.vendor3PrimaryContact,
      this.securityOfficerCount,
      this.securityOfficerCountHrs,
      this.securitySupervisorCount,
      this.securitySupervisorCountHrs,
      this.securityGuardCount,
      this.securityGuardCountHrs,
      this.securityFacilitatorCount,
      this.securityFacilitatorCountHrs,
      this.budget,
      this.proposedVendors});

  EventProtectionModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        slNo = json['slNo'] as String?,
        inputDate = json['inputDate'] as String?,
        location = (json['location'] as Map<String, dynamic>?) != null
            ? Location.fromJson(json['location'] as Map<String, dynamic>)
            : null,
        locationRegion =
            (json['locationRegion'] as Map<String, dynamic>?) != null
                ? LocationRegion.fromJson(
                    json['locationRegion'] as Map<String, dynamic>)
                : null,
        epManager1 = (json['epManager1'] as Map<String, dynamic>?) != null
            ? User.fromJson(
                json['epManager1'] as Map<String, dynamic>)
            : null,
        epManager2 = (json['epManager2'] as Map<String, dynamic>?) != null
            ? User.fromJson(
                json['epManager2'] as Map<String, dynamic>)
            : null,
        lsm1ContactNo = json['lsm1ContactNo'] as String?,
        lsm2ContactNo = json['lsm2ContactNo'] as String?,
        entities = (json['entities'] as List?)
            ?.map((dynamic e) => Entity.fromJson(e as Map<String, dynamic>))
            .toList(),
        epOfficers = json['epOfficers'] as String?,
        annualPowerShutdown = json['annualPowerShutdown'] as bool?,
        eventType = json['eventType'] as bool?,
        eventName = json['eventName'] as String?,
        eventLocation = json['eventLocation'] as String?,
        eventStartDate = json['eventStartDate'] as String?,
        eventEndDate = json['eventEndDate'] as String?,
        specialPersonAttending = json['specialPersonAttending'] as bool?,
        countryRiskRating = json['countryRiskRating'] as int?,
        locationParticipants = json['locationParticipants'] as int?,
        mediaExposure = json['mediaExposure'] as int?,
        externalVipAttendance = json['externalVipAttendance'] as int?,
        sensitiveInfoRisk = json['sensitiveInfoRisk'] as int?,
        dbSpecificReputationRisk = json['dbSpecificReputationRisk'] as int?,
        totalScore = json['totalScore'] as int?,
        liquorServed = json['liquorServed'] as bool?,
        hardDrinks = json['hardDrinks'] as bool?,
        wine = json['wine'] as bool?,
        beer = json['beer'] as bool?,
        vendorEngaged = json['vendorEngaged'] as bool?,
        vendorCompanyName = json['vendorCompanyName'] as String?,
        vendorPocName = json['vendorPocName'] as String?,
        vendorContactNo = json['vendorContactNo'] as String?,
        vendorStaffList = json['vendorStaffList'] as String?,
        controlChecks = json['controlChecks'] as bool?,
        cctvRetention = json['cctvRetention'] as int?,
        accessControl = json['accessControl'] as bool?,
        idCardCheck = json['idCardCheck'] as bool?,
        physicalSecurityDeploy = json['physicalSecurityDeploy'] as bool?,
        baggageScan = json['baggageScan'] as bool?,
        vehicleCheck = json['vehicleCheck'] as bool?,
        bouncersDeploy = json['bouncersDeploy'] as bool?,
        wristBandRegistered = json['wristBandRegistered'] as bool?,
        validDocumentsCheck = json['validDocumentsCheck'] as bool?,
        detailedAttendants = json['detailedAttendants'] as bool?,
        smokingZone = json['smokingZone'] as bool?,
        emergencyExits = json['emergencyExits'] as bool?,
        bu1ContactNo = json['bu1ContactNo'] as String?,
        bu2ContactNo = json['bu2ContactNo'] as String?,
        systemVendor1 = json['systemVendor1'] as String?,
        systemVendor2 = json['systemVendor2'] as String?,
        systemVendor3 = json['systemVendor3'] as String?,
        systemVendor1ContactNo = json['systemVendor1ContactNo'] as String?,
        systemVendor2ContactNo = json['systemVendor2ContactNo'] as String?,
        systemVendor3ContactNo = json['systemVendor3ContactNo'] as String?,
        eepAssessment = json['eepAssessment'] as String?,
        eepRecommendation = json['eepRecommendation'] as String?,
        tiAssessment = json['tiAssessment'] as bool?,
        tiAssessmentOngoing = json['tiAssessmentOngoing'] as bool?,
        eventStaffDiscussion = json['eventStaffDiscussion'] as bool?,
        venueReview = json['venueReview'] as bool?,
        eepAwareness = json['eepAwareness'] as bool?,
        eepOversight = json['eepOversight'] as bool?,
        epOnsite = json['epOnsite'] as bool?,
        extraSecurityDeployed = json['extraSecurityDeployed'] as bool?,
        vendorId = json['vendorId'] as String?,
        securityEquipmentCount = json['securityEquipmentCount'] as String?,
        guardingVendorPoc = json['guardingVendorPoc'] as String?,
        poNumber = json['poNumber'] as String?,
        opsOrderAccepted = json['opsOrderAccepted'] as bool?,
        securityVendorResponded = json['securityVendorResponded'] as bool?,
        ground = json['ground'] as String?,
        politicalSituation = json['politicalSituation'] as int?,
        terrorism = json['terrorism'] as int?,
        organizedCrime = json['organizedCrime'] as int?,
        threatToDB = json['threatToDB'] as int?,
        task = json['task'] as String?,
        eventManagement = json['eventManagement'] as bool?,
        mission = json['mission'] as String?,
        situationEventName = json['situationEventName'] as String?,
        eventSummary = json['eventSummary'] as String?,
        eventServiceImpact = json['eventServiceImpact'] as String?,
        eventRiskThreat = json['eventRiskThreat'] as String?,
        generalOutline = json['generalOutline'] as String?,
        securityPosture = json['securityPosture'] as String?,
        coordination = json['coordination'] as String?,
        additionalInfo4 = json['additionalInfo4'] as String?,
        actionsOn = json['actionsOn'] as String?,
        preOperationPlanning = json['preOperationPlanning'] as String?,
        securityDeployment = json['securityDeployment'] as String?,
        safetyAndSecurity = json['safetyAndSecurity'] as String?,
        monitorAndControl = json['monitorAndControl'] as String?,
        conclusion = json['conclusion'] as String?,
        beforeEventEmails = json['beforeEventEmails'] as String?,
        duringEventEmails = json['duringEventEmails'] as String?,
        addEventEmails = json['addEventEmails'] as String?,
        fireP = json['fireP'] as int?,
        fireH = json['fireH'] as int?,
        fireR = json['fireR'] as int?,
        fireComment = json['fireComment'] as String?,
        autoFireDetectP = json['autoFireDetectP'] as int?,
        autoFireDetectH = json['autoFireDetectH'] as int?,
        autoFireDetectR = json['autoFireDetectR'] as int?,
        autoFireDetectComment = json['autoFireDetectComment'] as String?,
        healthSafetyP = json['healthSafetyP'] as int?,
        healthSafetyH = json['healthSafetyH'] as int?,
        healthSafetyR = json['healthSafetyR'] as int?,
        healthSafetyComment = json['healthSafetyComment'] as String?,
        emergencyFailureP = json['emergencyFailureP'] as int?,
        emergencyFailureH = json['emergencyFailureH'] as int?,
        emergencyFailureR = json['emergencyFailureR'] as int?,
        emergencyFailureComment = json['emergencyFailureComment'] as String?,
        securityBreachP = json['securityBreachP'] as int?,
        securityBreachH = json['securityBreachH'] as int?,
        securityBreachR = json['securityBreachR'] as int?,
        securityComment = json['securityComment'] as String?,
        theftP = json['theftP'] as int?,
        theftH = json['theftH'] as int?,
        theftR = json['theftR'] as int?,
        theftComment = json['theftComment'] as String?,
        accessControlFailP = json['accessControlFailP'] as int?,
        accessControlFailH = json['accessControlFailH'] as int?,
        accessControlFailR = json['accessControlFailR'] as int?,
        accessControlComment = json['accessControlComment'] as String?,
        cctvSystemFailP = json['cctvSystemFailP'] as int?,
        cctvSystemFailH = json['cctvSystemFailH'] as int?,
        cctvSystemFailR = json['cctvSystemFailR'] as int?,
        cctvSystemFailComment = json['cctvSystemFailComment'] as String?,
        preEventEmail = json['preEventEmail'] as String?,
        duringEventEmail = json['duringEventEmail'] as String?,
        afterEventEmail = json['afterEventEmail'] as String?,
        lessonLearnt = json['lessonLearnt'] as String?,
        aarGrade = json['aarGrade'] as int?,
        aarRating1 = json['aarRating1'] as int?,
        aarPositive1 = json['aarPositive1'] as String?,
        aarLessPositive1 = json['aarLessPositive1'] as String?,
        aarRemedy1 = json['aarRemedy1'] as String?,
        aarRating2 = json['aarRating2'] as int?,
        aarPositive2 = json['aarPositive2'] as String?,
        aarLessPositive2 = json['aarLessPositive2'] as String?,
        aarRemedy2 = json['aarRemedy2'] as String?,
        aarRating3 = json['aarRating3'] as int?,
        aarPositive3 = json['aarPositive3'] as String?,
        aarLessPositive3 = json['aarLessPositive3'] as String?,
        aarRemedy3 = json['aarRemedy3'] as String?,
        aarRating4 = json['aarRating4'] as int?,
        aarPositive4 = json['aarPositive4'] as String?,
        aarLessPositive4 = json['aarLessPositive4'] as String?,
        aarRemedy4 = json['aarRemedy4'] as String?,
        qmrGrade = json['qmrGrade'] as int?,
        preOpPoints1 = json['preOpPoints1'] as int?,
        preOpPoints1Comment = json['preOpPoints1Comment'] as String?,
        preOpPoints2 = json['preOpPoints2'] as int?,
        preOpPoints2Comment = json['preOpPoints2Comment'] as String?,
        preOpPoints3 = json['preOpPoints3'] as int?,
        preOpPoints3Comment = json['preOpPoints3Comment'] as String?,
        preOpPoints4 = json['preOpPoints4'] as int?,
        preOpPoints4Comment = json['preOpPoints4Comment'] as String?,
        preOpPoints5 = json['preOpPoints5'] as int?,
        preOpPoints5Comment = json['preOpPoints5Comment'] as String?,
        opPlanPoints1 = json['opPlanPoints1'] as int?,
        opPlanPoints1Comment = json['opPlanPoints1Comment'] as String?,
        opPlanPoints2 = json['opPlanPoints2'] as int?,
        opPlanPoints2Comment = json['opPlanPoints2Comment'] as String?,
        opPlanPoints3 = json['opPlanPoints3'] as int?,
        opPlanPoints3Comment = json['opPlanPoints3Comment'] as String?,
        opPlanPoints4 = json['opPlanPoints4'] as int?,
        opPlanPoints4Comment = json['opPlanPoints4Comment'] as String?,
        opPlanPoints5 = json['opPlanPoints5'] as int?,
        opPlanPoints5Comment = json['opPlanPoints5Comment'] as String?,
        opPlanPoints6 = json['opPlanPoints6'] as int?,
        opPlanPoints6Comment = json['opPlanPoints6Comment'] as String?,
        opExecPoints1 = json['opExecPoints1'] as int?,
        opExecPoints1Comment = json['opExecPoints1Comment'] as String?,
        opExecPoints2 = json['opExecPoints2'] as int?,
        opExecPoints2Comment = json['opExecPoints2Comment'] as String?,
        opExecPoints3 = json['opExecPoints3'] as int?,
        opExecPoints3Comment = json['opExecPoints3Comment'] as String?,
        opExecPoints4 = json['opExecPoints4'] as int?,
        opExecPoints4Comment = json['opExecPoints4Comment'] as String?,
        opExecPoints5 = json['opExecPoints5'] as int?,
        opExecPoints5Comment = json['opExecPoints5Comment'] as String?,
        opExecPoints6 = json['opExecPoints6'] as int?,
        opExecPoints6Comment = json['opExecPoints6Comment'] as String?,
        opExecPoints7 = json['opExecPoints7'] as int?,
        opExecPoints7Comment = json['opExecPoints7Comment'] as String?,
        postOpPoints1 = json['postOpPoints1'] as int?,
        postOpPoints1Comment = json['postOpPoints1Comment'] as String?,
        postOpPoints2 = json['postOpPoints2'] as int?,
        postOpPoints2Comment = json['postOpPoints2Comment'] as String?,
        postOpPoints3 = json['postOpPoints3'] as int?,
        postOpPoints3Comment = json['postOpPoints3Comment'] as String?,
        postOpPoints4 = json['postOpPoints4'] as int?,
        postOpPoints4Comment = json['postOpPoints4Comment'] as String?,
        postOpPoints5 = json['postOpPoints5'] as int?,
        postOpPoints5Comment = json['postOpPoints5Comment'] as String?,
        qmrSecOpsComments = json['qmrSecOpsComments'] as String?,
        qmrVendorComments = json['qmrVendorComments'] as String?,
        status = json['status'] as int?,
        paymentProcessed = json['paymentProcessed'] as bool?,
        modifiedDate = json['modifiedDate'] as int?,
        modifiedBy = json['modifiedBy'] as String?,
        lsm1Name = json['lsm1Name'] as String?,
        lsm2Name = json['lsm2Name'] as String?,
        epManager1Name = json['epManager1Name'] as String?,
        epManager2Name = json['epManager2Name'] as String?,
        bu1Name = json['bu1Name'] as String?,
        bu2Name = json['bu2Name'] as String?,
        submittedByName = json['submittedByName'] as String?,
        authorizedByName = json['authorizedByName'] as String?,
        qmrSubmittedByName = json['qmrSubmittedByName'] as String?,
        qmrAuthorizedByName = json['qmrAuthorizedByName'] as String?,
        preOpPoints1DoneByName = json['preOpPoints1DoneByName'] as String?,
        opExecPoints1DoneByName = json['opExecPoints1DoneByName'] as String?,
        postOpPoints1DoneByName = json['postOpPoints1DoneByName'] as String?,
        srh1Name = json['srh1Name'] as String?,
        budget = json['budget'] as double?,
        bu1Dept = (json['bu1Dept'] as Map<String, dynamic>?) != null
            ? Department.fromJson(json['bu1Dept'] as Map<String, dynamic>)
            : null,
        bu2Dept = (json['bu2Dept'] as Map<String, dynamic>?) != null
            ? Department.fromJson(json['bu2Dept'] as Map<String, dynamic>)
            : null,
        requesterDepartment =
            (json['requesterDepartment'] as Map<String, dynamic>?) != null
                ? Department.fromJson(
                    json['requesterDepartment'] as Map<String, dynamic>)
                : null,
        vendor1Primary = json['vendor1Primary'] as String?,
        vendor1PrimaryContact = json['vendor1Primary'] as String?,
        vendor1Secondary = json['vendor1Secondary'] as String?,
        vendor1SecondaryContact = json['vendor1SecondaryContact'] as String?,
        vendor2Primary = json['vendor2Primary'] as String?,
        vendor2PrimaryContact = json['vendor2PrimaryContact'] as String?,
        vendor2Secondary = json['vendor2Secondary'] as String?,
        vendor2SecondaryContact = json['vendor2SecondaryContact'] as String?,
        vendor3Primary = json['vendor3Primary'] as String?,
        vendor3PrimaryContact = json['vendor3PrimaryContact'] as String?,
        vendor3Secondary = json['vendor3Secondary'] as String?,
        vendor3SecondaryContact = json['vendor3SecondaryContact'] as String?,
        securityOfficerCount = json['securityOfficerCount'] as int?,
        securityOfficerCountHrs = json['securityOfficerCountHrs'] as int?,
        securitySupervisorCount = json['securitySupervisorCount'] as int?,
        securitySupervisorCountHrs = json['securitySupervisorCountHrs'] as int?,
        securityGuardCount = json['securityGuardCount'] as int?,
        securityGuardCountHrs = json['securityGuardCountHrs'] as int?,
        securityFacilitatorCount = json['securityFacilitatorCount'] as int?,
        securityFacilitatorCountHrs =
            json['securityFacilitatorCountHrs'] as int?,
        srh2Name = json['srh2Name'] as String?,
        proposedVendors =
            (json['proposedVendors'] as Map<String, dynamic>?) != null
                ? Department.fromJson(
                    json['proposedVendors'] as Map<String, dynamic>)
                : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'slNo': slNo,
        'bu1Dept': bu1Dept,
        'bu2Dept': bu2Dept,
        'requesterDepartment': requesterDepartment,
        'vendor1Primary': vendor1Primary,
        'vendor1PrimaryContact': vendor1PrimaryContact,
        'vendor1Secondary': vendor1Secondary,
        'vendor1SecondaryContact': vendor1SecondaryContact,
        'vendor2Primary': vendor2Primary,
        'vendor2PrimaryContact': vendor2PrimaryContact,
        'vendor2Secondary': vendor2Secondary,
        'vendor2SecondaryContact': vendor2SecondaryContact,
        'vendor3Primary': vendor3Primary,
        'vendor3PrimaryContact': vendor3PrimaryContact,
        'vendor3Secondary': vendor3Secondary,
        'vendor3SecondaryContact': vendor3SecondaryContact,
        'inputDate': inputDate,
        'location': location?.toJson(),
        'locationRegion': locationRegion?.toJson(),
        'epManager1': epManager1?.toJson(),
        'epManager2': epManager2?.toJson(),
        'lsm1ContactNo': lsm1ContactNo,
        'lsm2ContactNo': lsm2ContactNo,
        'epOfficers': epOfficers,
        'annualPowerShutdown': annualPowerShutdown,
        'eventType': eventType,
        'eventName': eventName,
        'eventLocation': eventLocation,
        'eventStartDate': eventStartDate,
        'eventEndDate': eventEndDate,
        'specialPersonAttending': specialPersonAttending,
        'countryRiskRating': countryRiskRating,
        'locationParticipants': locationParticipants,
        'mediaExposure': mediaExposure,
        'externalVipAttendance': externalVipAttendance,
        'sensitiveInfoRisk': sensitiveInfoRisk,
        'dbSpecificReputationRisk': dbSpecificReputationRisk,
        'totalScore': totalScore,
        'liquorServed': liquorServed,
        'hardDrinks': hardDrinks,
        'wine': wine,
        'beer': beer,
        'entities': entities,
        'vendorEngaged': vendorEngaged,
        'vendorCompanyName': vendorCompanyName,
        'vendorPocName': vendorPocName,
        'vendorContactNo': vendorContactNo,
        'vendorStaffList': vendorStaffList,
        'controlChecks': controlChecks,
        'cctvRetention': cctvRetention,
        'accessControl': accessControl,
        'idCardCheck': idCardCheck,
        'physicalSecurityDeploy': physicalSecurityDeploy,
        'baggageScan': baggageScan,
        'vehicleCheck': vehicleCheck,
        'bouncersDeploy': bouncersDeploy,
        'wristBandRegistered': wristBandRegistered,
        'validDocumentsCheck': validDocumentsCheck,
        'detailedAttendants': detailedAttendants,
        'smokingZone': smokingZone,
        'emergencyExits': emergencyExits,
        'bu1ContactNo': bu1ContactNo,
        'bu2ContactNo': bu2ContactNo,
        'systemVendor1': systemVendor1,
        'systemVendor2': systemVendor2,
        'systemVendor3': systemVendor3,
        'systemVendor1ContactNo': systemVendor1ContactNo,
        'systemVendor2ContactNo': systemVendor2ContactNo,
        'systemVendor3ContactNo': systemVendor3ContactNo,
        'eepAssessment': eepAssessment,
        'eepRecommendation': eepRecommendation,
        'tiAssessment': tiAssessment,
        'tiAssessmentOngoing': tiAssessmentOngoing,
        'eventStaffDiscussion': eventStaffDiscussion,
        'venueReview': venueReview,
        'eepAwareness': eepAwareness,
        'eepOversight': eepOversight,
        'epOnsite': epOnsite,
        'extraSecurityDeployed': extraSecurityDeployed,
        'vendorId': vendorId,
        'securityEquipmentCount': securityEquipmentCount,
        'guardingVendorPoc': guardingVendorPoc,
        'poNumber': poNumber,
        'opsOrderAccepted': opsOrderAccepted,
        'securityVendorResponded': securityVendorResponded,
        'ground': ground,
        'politicalSituation': politicalSituation,
        'terrorism': terrorism,
        'organizedCrime': organizedCrime,
        'threatToDB': threatToDB,
        'task': task,
        'eventManagement': eventManagement,
        'mission': mission,
        'situationEventName': situationEventName,
        'eventSummary': eventSummary,
        'eventServiceImpact': eventServiceImpact,
        'eventRiskThreat': eventRiskThreat,
        'generalOutline': generalOutline,
        'securityPosture': securityPosture,
        'coordination': coordination,
        'additionalInfo4': additionalInfo4,
        'actionsOn': actionsOn,
        'preOperationPlanning': preOperationPlanning,
        'securityDeployment': securityDeployment,
        'safetyAndSecurity': safetyAndSecurity,
        'monitorAndControl': monitorAndControl,
        'conclusion': conclusion,
        'beforeEventEmails': beforeEventEmails,
        'duringEventEmails': duringEventEmails,
        'addEventEmails': addEventEmails,
        'fireP': fireP,
        'fireH': fireH,
        'fireR': fireR,
        'fireComment': fireComment,
        'autoFireDetectP': autoFireDetectP,
        'autoFireDetectH': autoFireDetectH,
        'autoFireDetectR': autoFireDetectR,
        'autoFireDetectComment': autoFireDetectComment,
        'healthSafetyP': healthSafetyP,
        'healthSafetyH': healthSafetyH,
        'healthSafetyR': healthSafetyR,
        'healthSafetyComment': healthSafetyComment,
        'emergencyFailureP': emergencyFailureP,
        'emergencyFailureH': emergencyFailureH,
        'emergencyFailureR': emergencyFailureR,
        'emergencyFailureComment': emergencyFailureComment,
        'securityBreachP': securityBreachP,
        'securityBreachH': securityBreachH,
        'securityBreachR': securityBreachR,
        'securityComment': securityComment,
        'theftP': theftP,
        'theftH': theftH,
        'theftR': theftR,
        'theftComment': theftComment,
        'accessControlFailP': accessControlFailP,
        'accessControlFailH': accessControlFailH,
        'accessControlFailR': accessControlFailR,
        'accessControlComment': accessControlComment,
        'cctvSystemFailP': cctvSystemFailP,
        'cctvSystemFailH': cctvSystemFailH,
        'cctvSystemFailR': cctvSystemFailR,
        'cctvSystemFailComment': cctvSystemFailComment,
        'preEventEmail': preEventEmail,
        'duringEventEmail': duringEventEmail,
        'afterEventEmail': afterEventEmail,
        'lessonLearnt': lessonLearnt,
        'aarGrade': aarGrade,
        'aarRating1': aarRating1,
        'aarPositive1': aarPositive1,
        'aarLessPositive1': aarLessPositive1,
        'aarRemedy1': aarRemedy1,
        'aarRating2': aarRating2,
        'aarPositive2': aarPositive2,
        'aarLessPositive2': aarLessPositive2,
        'aarRemedy2': aarRemedy2,
        'aarRating3': aarRating3,
        'aarPositive3': aarPositive3,
        'aarLessPositive3': aarLessPositive3,
        'aarRemedy3': aarRemedy3,
        'aarRating4': aarRating4,
        'aarPositive4': aarPositive4,
        'aarLessPositive4': aarLessPositive4,
        'aarRemedy4': aarRemedy4,
        'qmrGrade': qmrGrade,
        'preOpPoints1': preOpPoints1,
        'preOpPoints1Comment': preOpPoints1Comment,
        'preOpPoints2': preOpPoints2,
        'preOpPoints2Comment': preOpPoints2Comment,
        'preOpPoints3': preOpPoints3,
        'preOpPoints3Comment': preOpPoints3Comment,
        'preOpPoints4': preOpPoints4,
        'preOpPoints4Comment': preOpPoints4Comment,
        'preOpPoints5': preOpPoints5,
        'preOpPoints5Comment': preOpPoints5Comment,
        'opPlanPoints1': opPlanPoints1,
        'opPlanPoints1Comment': opPlanPoints1Comment,
        'opPlanPoints2': opPlanPoints2,
        'opPlanPoints2Comment': opPlanPoints2Comment,
        'opPlanPoints3': opPlanPoints3,
        'opPlanPoints3Comment': opPlanPoints3Comment,
        'opPlanPoints4': opPlanPoints4,
        'opPlanPoints4Comment': opPlanPoints4Comment,
        'opPlanPoints5': opPlanPoints5,
        'opPlanPoints5Comment': opPlanPoints5Comment,
        'opPlanPoints6': opPlanPoints6,
        'opPlanPoints6Comment': opPlanPoints6Comment,
        'opExecPoints1': opExecPoints1,
        'opExecPoints1Comment': opExecPoints1Comment,
        'opExecPoints2': opExecPoints2,
        'opExecPoints2Comment': opExecPoints2Comment,
        'opExecPoints3': opExecPoints3,
        'opExecPoints3Comment': opExecPoints3Comment,
        'opExecPoints4': opExecPoints4,
        'opExecPoints4Comment': opExecPoints4Comment,
        'opExecPoints5': opExecPoints5,
        'opExecPoints5Comment': opExecPoints5Comment,
        'opExecPoints6': opExecPoints6,
        'opExecPoints6Comment': opExecPoints6Comment,
        'opExecPoints7': opExecPoints7,
        'opExecPoints7Comment': opExecPoints7Comment,
        'postOpPoints1': postOpPoints1,
        'postOpPoints1Comment': postOpPoints1Comment,
        'postOpPoints2': postOpPoints2,
        'postOpPoints2Comment': postOpPoints2Comment,
        'postOpPoints3': postOpPoints3,
        'postOpPoints3Comment': postOpPoints3Comment,
        'postOpPoints4': postOpPoints4,
        'postOpPoints4Comment': postOpPoints4Comment,
        'postOpPoints5': postOpPoints5,
        'postOpPoints5Comment': postOpPoints5Comment,
        'qmrSecOpsComments': qmrSecOpsComments,
        'qmrVendorComments': qmrVendorComments,
        'status': status,
        'paymentProcessed': paymentProcessed,
        'modifiedDate': modifiedDate,
        'modifiedBy': modifiedBy,
        'lsm1Name': lsm1Name,
        'lsm2Name': lsm2Name,
        'epManager1Name': epManager1Name,
        'epManager2Name': epManager2Name,
        'bu1Name': bu1Name,
        'bu2Name': bu2Name,
        'submittedByName': submittedByName,
        'authorizedByName': authorizedByName,
        'qmrSubmittedByName': qmrSubmittedByName,
        'qmrAuthorizedByName': qmrAuthorizedByName,
        'preOpPoints1DoneByName': preOpPoints1DoneByName,
        'opExecPoints1DoneByName': opExecPoints1DoneByName,
        'postOpPoints1DoneByName': postOpPoints1DoneByName,
        'srh1Name': srh1Name,
        'srh2Name': srh2Name,
        'securityOfficerCount': securityOfficerCount,
        'securityOfficerCountHrs': securityOfficerCountHrs,
        'securitySupervisorCount': securitySupervisorCount,
        'securitySupervisorCountHrs': securitySupervisorCountHrs,
        'securityGuardCount': securityGuardCount,
        'securityGuardCountHrs': securityGuardCountHrs,
        'securityFacilitatorCount': securityFacilitatorCount,
        'securityFacilitatorCountHrs': securityFacilitatorCountHrs,
        'budget': budget,
        'proposedVendors': proposedVendors,
      };
}
