import 'package:db_atom/index.dart';

class AnnualPowerShutDownResponse {
  final List<AnnualPowerShutDownModel>? items;
  final int? totalCount;
  final int? currentPageNo;
  final int? totalPageCount;

  AnnualPowerShutDownResponse({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  AnnualPowerShutDownResponse.fromJson(Map<String, dynamic> json)
      : items = (json['data'] as List?)
            ?.map((dynamic e) =>
                AnnualPowerShutDownModel.fromJson(e as Map<String, dynamic>))
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

class AnnualPowerShutDownModel {
  final int? id;
  final String? slNo;
  final User? createdBy;
  final String? inputDate;
  final Organisation? location;
  final Organisation? locationRegion;
  final List<dynamic>? entities;
  final String? lsm1ContactNo;
  final String? lsm2ContactNo;
  final String? epOfficers;
  final bool? annualPowerShutdown;
  final bool? eventType;
  final bool? specialPersonAttending;
  final bool? liquorServed;
  final bool? hardDrinks;
  final bool? wine;
  final bool? beer;
  final bool? vendorEngaged;
  final bool? controlChecks;
  final bool? accessControl;
  final bool? idCardCheck;
  final bool? physicalSecurityDeploy;
  final bool? baggageScan;
  final bool? vehicleCheck;
  final bool? bouncersDeploy;
  final bool? wristBandRegistered;
  final bool? validDocumentsCheck;
  final bool? detailedAttendants;
  final bool? smokingZone;
  final bool? emergencyExits;
  final String? bu1ContactNo;
  final String? bu2ContactNo;
  final String? systemVendor1;
  final String? systemVendor2;
  final String? systemVendor3;
  final String? systemVendor1ContactNo;
  final String? systemVendor2ContactNo;
  final String? systemVendor3ContactNo;
  final bool? tiAssessment;
  final bool? tiAssessmentOngoing;
  final bool? eventStaffDiscussion;
  final bool? venueReview;
  final bool? eepAwareness;
  final bool? eepOversight;
  final bool? epOnsite;
  final bool? extraSecurityDeployed;
  final String? vendorId;
  final int? securityOfficerCount;
  final int? securityOfficerCountHrs;
  final int? securitySupervisorCount;
  final int? securitySupervisorCountHrs;
  final int? securityGuardCount;
  final int? securityGuardCountHrs;
  final int? securityFacilitatorCount;
  final int? securityFacilitatorCountHrs;
  final List<dynamic>? proposedVendors;
  final String? guardingVendorPoc;
  final String? poNumber;
  final bool? opsOrderAccepted;
  final bool? securityVendorResponded;
  final bool? eventManagement;
  final List<dynamic>? images1;
  final List<dynamic>? images2;
  final List<dynamic>? foundItems;
  final List<dynamic>? images3;
  final int? status;
  final bool? paymentProcessed;
  final String? modifiedBy;
  final String? lsm1Name;
  final String? lsm2Name;
  final String? bu1Name;
  final String? bu2Name;
  final String? epManager1Name;
  final String? epManager2Name;
  final String? srh1Name;
  final String? srh2Name;
  final String? submittedByName;
  final String? authorizedByName;
  final String? qmrSubmittedByName;
  final String? qmrAuthorizedByName;
  final String? preOpPoints1DoneByName;
  final String? opExecPoints1DoneByName;
  final String? postOpPoints1DoneByName;

  AnnualPowerShutDownModel({
    this.id,
    this.slNo,
    this.createdBy,
    this.inputDate,
    this.location,
    this.locationRegion,
    this.entities,
    this.lsm1ContactNo,
    this.lsm2ContactNo,
    this.epOfficers,
    this.annualPowerShutdown,
    this.eventType,
    this.specialPersonAttending,
    this.liquorServed,
    this.hardDrinks,
    this.wine,
    this.beer,
    this.vendorEngaged,
    this.controlChecks,
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
    this.tiAssessment,
    this.tiAssessmentOngoing,
    this.eventStaffDiscussion,
    this.venueReview,
    this.eepAwareness,
    this.eepOversight,
    this.epOnsite,
    this.extraSecurityDeployed,
    this.vendorId,
    this.securityOfficerCount,
    this.securityOfficerCountHrs,
    this.securitySupervisorCount,
    this.securitySupervisorCountHrs,
    this.securityGuardCount,
    this.securityGuardCountHrs,
    this.securityFacilitatorCount,
    this.securityFacilitatorCountHrs,
    this.proposedVendors,
    this.guardingVendorPoc,
    this.poNumber,
    this.opsOrderAccepted,
    this.securityVendorResponded,
    this.eventManagement,
    this.images1,
    this.images2,
    this.foundItems,
    this.images3,
    this.status,
    this.paymentProcessed,
    this.modifiedBy,
    this.lsm1Name,
    this.lsm2Name,
    this.bu1Name,
    this.bu2Name,
    this.epManager1Name,
    this.epManager2Name,
    this.srh1Name,
    this.srh2Name,
    this.submittedByName,
    this.authorizedByName,
    this.qmrSubmittedByName,
    this.qmrAuthorizedByName,
    this.preOpPoints1DoneByName,
    this.opExecPoints1DoneByName,
    this.postOpPoints1DoneByName,
  });

  AnnualPowerShutDownModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        slNo = json['slNo'] as String?,
        createdBy = (json['createdBy'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['createdBy'] as Map<String, dynamic>)
            : null,
        inputDate = json['inputDate'] as String?,
        location = (json['location'] as Map<String, dynamic>?) != null
            ? Organisation.fromJson(json['location'] as Map<String, dynamic>)
            : null,
        locationRegion =
            (json['locationRegion'] as Map<String, dynamic>?) != null
                ? Organisation.fromJson(
                    json['locationRegion'] as Map<String, dynamic>)
                : null,
        entities = json['entities'] as List?,
        lsm1ContactNo = json['lsm1ContactNo'] as String?,
        lsm2ContactNo = json['lsm2ContactNo'] as String?,
        epOfficers = json['epOfficers'] as String?,
        annualPowerShutdown = json['annualPowerShutdown'] as bool?,
        eventType = json['eventType'] as bool?,
        specialPersonAttending = json['specialPersonAttending'] as bool?,
        liquorServed = json['liquorServed'] as bool?,
        hardDrinks = json['hardDrinks'] as bool?,
        wine = json['wine'] as bool?,
        beer = json['beer'] as bool?,
        vendorEngaged = json['vendorEngaged'] as bool?,
        controlChecks = json['controlChecks'] as bool?,
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
        tiAssessment = json['tiAssessment'] as bool?,
        tiAssessmentOngoing = json['tiAssessmentOngoing'] as bool?,
        eventStaffDiscussion = json['eventStaffDiscussion'] as bool?,
        venueReview = json['venueReview'] as bool?,
        eepAwareness = json['eepAwareness'] as bool?,
        eepOversight = json['eepOversight'] as bool?,
        epOnsite = json['epOnsite'] as bool?,
        extraSecurityDeployed = json['extraSecurityDeployed'] as bool?,
        vendorId = json['vendorId'] as String?,
        securityOfficerCount = json['securityOfficerCount'] as int?,
        securityOfficerCountHrs = json['securityOfficerCountHrs'] as int?,
        securitySupervisorCount = json['securitySupervisorCount'] as int?,
        securitySupervisorCountHrs = json['securitySupervisorCountHrs'] as int?,
        securityGuardCount = json['securityGuardCount'] as int?,
        securityGuardCountHrs = json['securityGuardCountHrs'] as int?,
        securityFacilitatorCount = json['securityFacilitatorCount'] as int?,
        securityFacilitatorCountHrs =
            json['securityFacilitatorCountHrs'] as int?,
        proposedVendors = json['proposedVendors'] as List?,
        guardingVendorPoc = json['guardingVendorPoc'] as String?,
        poNumber = json['poNumber'] as String?,
        opsOrderAccepted = json['opsOrderAccepted'] as bool?,
        securityVendorResponded = json['securityVendorResponded'] as bool?,
        eventManagement = json['eventManagement'] as bool?,
        images1 = json['images1'] as List?,
        images2 = json['images2'] as List?,
        foundItems = json['foundItems'] as List?,
        images3 = json['images3'] as List?,
        status = json['status'] as int?,
        paymentProcessed = json['paymentProcessed'] as bool?,
        modifiedBy = json['modifiedBy'] as String?,
        lsm1Name = json['lsm1Name'] as String?,
        lsm2Name = json['lsm2Name'] as String?,
        bu1Name = json['bu1Name'] as String?,
        bu2Name = json['bu2Name'] as String?,
        epManager1Name = json['epManager1Name'] as String?,
        epManager2Name = json['epManager2Name'] as String?,
        srh1Name = json['srh1Name'] as String?,
        srh2Name = json['srh2Name'] as String?,
        submittedByName = json['submittedByName'] as String?,
        authorizedByName = json['authorizedByName'] as String?,
        qmrSubmittedByName = json['qmrSubmittedByName'] as String?,
        qmrAuthorizedByName = json['qmrAuthorizedByName'] as String?,
        preOpPoints1DoneByName = json['preOpPoints1DoneByName'] as String?,
        opExecPoints1DoneByName = json['opExecPoints1DoneByName'] as String?,
        postOpPoints1DoneByName = json['postOpPoints1DoneByName'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'slNo': slNo,
        'createdBy': createdBy?.toJson(),
        'inputDate': inputDate,
        'location': location?.toJson(),
        'locationRegion': locationRegion?.toJson(),
        'entities': entities,
        'lsm1ContactNo': lsm1ContactNo,
        'lsm2ContactNo': lsm2ContactNo,
        'epOfficers': epOfficers,
        'annualPowerShutdown': annualPowerShutdown,
        'eventType': eventType,
        'specialPersonAttending': specialPersonAttending,
        'liquorServed': liquorServed,
        'hardDrinks': hardDrinks,
        'wine': wine,
        'beer': beer,
        'vendorEngaged': vendorEngaged,
        'controlChecks': controlChecks,
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
        'tiAssessment': tiAssessment,
        'tiAssessmentOngoing': tiAssessmentOngoing,
        'eventStaffDiscussion': eventStaffDiscussion,
        'venueReview': venueReview,
        'eepAwareness': eepAwareness,
        'eepOversight': eepOversight,
        'epOnsite': epOnsite,
        'extraSecurityDeployed': extraSecurityDeployed,
        'vendorId': vendorId,
        'securityOfficerCount': securityOfficerCount,
        'securityOfficerCountHrs': securityOfficerCountHrs,
        'securitySupervisorCount': securitySupervisorCount,
        'securitySupervisorCountHrs': securitySupervisorCountHrs,
        'securityGuardCount': securityGuardCount,
        'securityGuardCountHrs': securityGuardCountHrs,
        'securityFacilitatorCount': securityFacilitatorCount,
        'securityFacilitatorCountHrs': securityFacilitatorCountHrs,
        'proposedVendors': proposedVendors,
        'guardingVendorPoc': guardingVendorPoc,
        'poNumber': poNumber,
        'opsOrderAccepted': opsOrderAccepted,
        'securityVendorResponded': securityVendorResponded,
        'eventManagement': eventManagement,
        'images1': images1,
        'images2': images2,
        'foundItems': foundItems,
        'images3': images3,
        'status': status,
        'paymentProcessed': paymentProcessed,
        'modifiedBy': modifiedBy,
        'lsm1Name': lsm1Name,
        'lsm2Name': lsm2Name,
        'bu1Name': bu1Name,
        'bu2Name': bu2Name,
        'epManager1Name': epManager1Name,
        'epManager2Name': epManager2Name,
        'srh1Name': srh1Name,
        'srh2Name': srh2Name,
        'submittedByName': submittedByName,
        'authorizedByName': authorizedByName,
        'qmrSubmittedByName': qmrSubmittedByName,
        'qmrAuthorizedByName': qmrAuthorizedByName,
        'preOpPoints1DoneByName': preOpPoints1DoneByName,
        'opExecPoints1DoneByName': opExecPoints1DoneByName,
        'postOpPoints1DoneByName': postOpPoints1DoneByName
      };
}
