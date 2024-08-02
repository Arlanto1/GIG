import '../../../../index.dart';
import '../../../models/history.dart';

class IncidentsResponse {
  List<IncidentModel>? items;
  int? totalCount;
  int? currentPageNo;
  int? totalPageCount;

  IncidentsResponse({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  IncidentsResponse.fromJson(Map<String, dynamic> json)
      : items = (json['data'] as List?)
            ?.map((dynamic e) =>
                IncidentModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        totalCount = json['totalCount'] as int?,
        currentPageNo = json['currentPageNo'] as int?,
        totalPageCount = json['totalPageCount'] as int?;

  Map<String, dynamic> toJson() => {
        'list': items?.map((e) => e.toJson()).toList(),
        'totalCount': totalCount,
        'currentPageNo': currentPageNo,
        'totalPageCount': totalPageCount
      };
}

class IncidentModel {
  int? id;
  String? slNo;
  String? inputDate;
  Organisation? location;
  Organisation? locationRegion;
  int? workflowId;
  List<Organisation>? entities;
  int? status;
  int? incidentType;
  int? typeOfAsset;
  Organisation? typeOfArticle;
  String? color;
  String? modifiedDate;
  String? modifiedBy;
  List<History>? history;
  User? entrySecurity;
  bool complainantDbEmp;
  User? complainant;
  String? employeeId;
  String? complainantName;
  Organisation? complainantDepartment;
  User? complainantHr;
  String? incidentDate;
  String? incidentOrganisation;
  String? description;
  User? incidentManager;
  User? incidentOwner;
  bool? ioRoleAccepted;
  String? closureTargetDate;
  String? incidentLocation;
  String? incidentAnalysis;
  int? severity;
  String? incidentImpact;
  String? initialInvestigation;
  bool? passOfficeApprovalRequired;
  String? passOfficeRequest;
  String? passOfficeResponse;
  String? logicalDevices;
  List<dynamic>? passOfficeData;
  bool? passOfficeResponseAccepted;
  String? rcaRequest;
  bool? externalRcaRequired;
  String? rcaResponse;
  bool? rcaResponseAccepted;
  List<dynamic>? rcaData;
  bool? systemReviewRequired;
  List<dynamic>? incidentActionPlans;
  String? furtherInvestigation;
  String? cctvFindings;
  bool? dataLossIdentified;
  String? dataLossRequest;
  String? dataLossResponse;
  List<dynamic>? dataLossInfo;
  bool? dataLossResponseAccepted;
  bool? fteInvolved;
  String? fteCwrEmployeeId;
  String? hrEmployeeId;
  bool? cwrInvolved;
  String? cwrName;
  String? companyName;
  bool? slaViolated;
  bool? readAcrossRequired;
  bool? fteCwrTriggerRequired;
  String? interviewInfo;
  String? staffStatement;
  String? interviewedByHrId;
  bool? passOfficeResponded;
  bool? rcaVendorResponded;
  bool? dataLossVendorResponded;
  bool? postInvestigationDone;
  List<dynamic>? incidentWitness;
  List<dynamic>? incidentReadAcross;
  List<dynamic>? images;
  OccurrenceModel? occurrence;
  KeyHistoryModel? keyLossGi;
  int? occType;
  String? entrySecurityName;
  String? systemReviewerName;
  String? incidentManagerName;
  String? incidentOwnerName;
  String? fteCwrName;
  String? hrBusinessPartnerName;
  String? intervieweeName;
  String? interviewedByName;
  String? complainantHrName;
  String? lock;

  IncidentModel({
    this.id,
    this.slNo,
    this.inputDate,
    this.location,
    this.locationRegion,
    this.workflowId,
    this.entities,
    this.status,
    this.incidentType,
    this.typeOfAsset,
    this.typeOfArticle,
    this.color,
    this.modifiedDate,
    this.modifiedBy,
    this.history,
    this.entrySecurity,
    this.complainantDbEmp = false,
    this.complainant,
    this.employeeId,
    this.complainantName,
    this.complainantDepartment,
    this.complainantHr,
    this.incidentDate,
    this.incidentOrganisation,
    this.description,
    this.incidentManager,
    this.incidentOwner,
    this.ioRoleAccepted,
    this.closureTargetDate,
    this.incidentLocation,
    this.incidentAnalysis,
    this.severity,
    this.incidentImpact,
    this.initialInvestigation,
    this.passOfficeApprovalRequired,
    this.passOfficeRequest,
    this.passOfficeResponse,
    this.logicalDevices,
    this.passOfficeData,
    this.passOfficeResponseAccepted,
    this.rcaRequest,
    this.externalRcaRequired,
    this.rcaResponse,
    this.rcaResponseAccepted,
    this.rcaData,
    this.systemReviewRequired,
    this.incidentActionPlans,
    this.furtherInvestigation,
    this.cctvFindings,
    this.dataLossIdentified,
    this.dataLossRequest,
    this.dataLossResponse,
    this.dataLossInfo,
    this.dataLossResponseAccepted,
    this.fteInvolved,
    this.fteCwrEmployeeId,
    this.hrEmployeeId,
    this.cwrInvolved,
    this.cwrName,
    this.companyName,
    this.slaViolated,
    this.readAcrossRequired,
    this.fteCwrTriggerRequired,
    this.interviewInfo,
    this.staffStatement,
    this.interviewedByHrId,
    this.passOfficeResponded,
    this.rcaVendorResponded,
    this.dataLossVendorResponded,
    this.postInvestigationDone,
    this.incidentWitness,
    this.incidentReadAcross,
    this.images,
    this.occType,
    this.occurrence,
    this.keyLossGi,
    this.entrySecurityName,
    this.systemReviewerName,
    this.incidentManagerName,
    this.incidentOwnerName,
    this.fteCwrName,
    this.hrBusinessPartnerName,
    this.intervieweeName,
    this.interviewedByName,
    this.complainantHrName,
    this.lock,
  });

  IncidentModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        slNo = json['slNo'] as String?,
        inputDate = json['inputDate'] as String?,
        location = (json['location'] as Map<String, dynamic>?) != null
            ? Organisation.fromJson(json['location'] as Map<String, dynamic>)
            : null,
        locationRegion =
            (json['locationRegion'] as Map<String, dynamic>?) != null
                ? Organisation.fromJson(
                    json['locationRegion'] as Map<String, dynamic>)
                : null,
        workflowId = json['workflowId'] as int?,
        entities = (json['entities'] as List?)
            ?.map(
                (dynamic e) => Organisation.fromJson(e as Map<String, dynamic>))
            .toList(),
        status = json['status'] as int?,
        incidentType = json['incidentType'] as int?,
        typeOfAsset = json['typeOfAsset'] as int?,
        typeOfArticle = (json['typeOfArticle'] as Map<String, dynamic>?) != null
            ? Organisation.fromJson(
                json['typeOfArticle'] as Map<String, dynamic>)
            : null,
        color = json['color'] as String?,
        modifiedDate = json['modifiedDate'] as String?,
        modifiedBy = json['modifiedBy'] as String?,
        history = (json['history'] as List?)
            ?.map((dynamic e) => History.fromJson(e as Map<String, dynamic>))
            .toList(),
        entrySecurity = (json['entrySecurity'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['entrySecurity'] as Map<String, dynamic>)
            : null,
        complainantDbEmp = json['complainantDbEmp'] as bool,
        complainant = (json['complainant'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['complainant'] as Map<String, dynamic>)
            : null,
        employeeId = json['employeeId'] as String?,
        complainantName = json['complainantName'] as String?,
        complainantDepartment =
            (json['complainantDepartment'] as Map<String, dynamic>?) != null
                ? Organisation.fromJson(
                    json['complainantDepartment'] as Map<String, dynamic>)
                : null,
        complainantHr = (json['complainantHr'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['complainantHr'] as Map<String, dynamic>)
            : null,
        incidentDate = json['incidentDate'] as String?,
        incidentOrganisation = json['incidentOrganisation'] as String?,
        description = json['description'] as String?,
        incidentManager =
            (json['incidentManager'] as Map<String, dynamic>?) != null
                ? User.fromJson(json['incidentManager'] as Map<String, dynamic>)
                : null,
        incidentOwner = (json['incidentOwner'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['incidentOwner'] as Map<String, dynamic>)
            : null,
        ioRoleAccepted = json['ioRoleAccepted'] as bool?,
        closureTargetDate = json['closureTargetDate'] as String?,
        incidentLocation = json['incidentLocation'] as String?,
        incidentAnalysis = json['incidentAnalysis'] as String?,
        severity = json['severity'] as int?,
        incidentImpact = json['incidentImpact'] as String?,
        initialInvestigation = json['initialInvestigation'] as String?,
        passOfficeApprovalRequired =
            json['passOfficeApprovalRequired'] as bool?,
        passOfficeRequest = json['passOfficeRequest'] as String?,
        passOfficeResponse = json['passOfficeResponse'] as String?,
        logicalDevices = json['logicalDevices'] as String?,
        passOfficeData = json['passOfficeData'] as List?,
        passOfficeResponseAccepted =
            json['passOfficeResponseAccepted'] as bool?,
        rcaRequest = json['rcaRequest'] as String?,
        externalRcaRequired = json['externalRcaRequired'] as bool?,
        rcaResponse = json['rcaResponse'] as String?,
        rcaResponseAccepted = json['rcaResponseAccepted'] as bool?,
        rcaData = json['rcaData'] as List?,
        systemReviewRequired = json['systemReviewRequired'] as bool?,
        incidentActionPlans = json['incidentActionPlans'] as List?,
        furtherInvestigation = json['furtherInvestigation'] as String?,
        cctvFindings = json['cctvFindings'] as String?,
        dataLossIdentified = json['dataLossIdentified'] as bool?,
        dataLossRequest = json['dataLossRequest'] as String?,
        dataLossResponse = json['dataLossResponse'] as String?,
        dataLossInfo = json['dataLossInfo'] as List?,
        dataLossResponseAccepted = json['dataLossResponseAccepted'] as bool?,
        fteInvolved = json['fteInvolved'] as bool?,
        fteCwrEmployeeId = json['fteCwrEmployeeId'] as String?,
        hrEmployeeId = json['hrEmployeeId'] as String?,
        cwrInvolved = json['cwrInvolved'] as bool?,
        cwrName = json['cwrName'] as String?,
        companyName = json['companyName'] as String?,
        slaViolated = json['slaViolated'] as bool?,
        readAcrossRequired = json['readAcrossRequired'] as bool?,
        fteCwrTriggerRequired = json['fteCwrTriggerRequired'] as bool?,
        interviewInfo = json['interviewInfo'] as String?,
        staffStatement = json['staffStatement'] as String?,
        interviewedByHrId = json['interviewedByHrId'] as String?,
        passOfficeResponded = json['passOfficeResponded'] as bool?,
        rcaVendorResponded = json['rcaVendorResponded'] as bool?,
        dataLossVendorResponded = json['dataLossVendorResponded'] as bool?,
        postInvestigationDone = json['postInvestigationDone'] as bool?,
        incidentWitness = json['incidentWitness'] as List?,
        incidentReadAcross = json['incidentReadAcross'] as List?,
        images = json['images'] as List?,
        occType = json['occType'] as int?,
        occurrence = (json['occurrence'] as Map<String, dynamic>?) != null
            ? OccurrenceModel.fromJson(
                json['occurrence'] as Map<String, dynamic>)
            : null,
        keyLossGi = (json['keyLossGi'] as Map<String, dynamic>?) != null
            ? KeyHistoryModel.fromJson(
                json['keyLossGi'] as Map<String, dynamic>)
            : null,
        entrySecurityName = json['entrySecurityName'] as String?,
        systemReviewerName = json['systemReviewerName'] as String?,
        incidentManagerName = json['incidentManagerName'] as String?,
        incidentOwnerName = json['incidentOwnerName'] as String?,
        fteCwrName = json['fteCwrName'] as String?,
        hrBusinessPartnerName = json['hrBusinessPartnerName'] as String?,
        intervieweeName = json['intervieweeName'] as String?,
        interviewedByName = json['interviewedByName'] as String?,
        complainantHrName = json['complainantHrName'] as String?,
        lock = json['lock'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'slNo': slNo,
        'inputDate': inputDate,
        'location': location?.toJson(),
        'locationRegion': locationRegion?.toJson(),
        'workflowId': workflowId,
        'entities': entities?.map((e) => e.toJson()).toList(),
        'status': status,
        'incidentType': incidentType,
        'typeOfAsset': typeOfAsset,
        'typeOfArticle': typeOfArticle?.toJson(),
        'color': color,
        'modifiedDate': modifiedDate,
        'modifiedBy': modifiedBy,
        'history': history?.map((e) => e.toJson()).toList(),
        'entrySecurity': entrySecurity?.toJson(),
        'complainantDbEmp': complainantDbEmp,
        'complainant': complainant?.toJson(),
        'employeeId': employeeId,
        'complainantName': complainantName,
        'complainantDepartment': complainantDepartment?.toJson(),
        'complainantHr': complainantHr?.toJson(),
        'incidentDate': incidentDate,
        'incidentOrganisation': incidentOrganisation,
        'description': description,
        'incidentManager': incidentManager?.toJson(),
        'incidentOwner': incidentOwner?.toJson(),
        'ioRoleAccepted': ioRoleAccepted,
        'closureTargetDate': closureTargetDate,
        'incidentLocation': incidentLocation,
        'incidentAnalysis': incidentAnalysis,
        'severity': severity,
        'incidentImpact': incidentImpact,
        'initialInvestigation': initialInvestigation,
        'passOfficeApprovalRequired': passOfficeApprovalRequired,
        'passOfficeRequest': passOfficeRequest,
        'passOfficeResponse': passOfficeResponse,
        'logicalDevices': logicalDevices,
        'passOfficeData': passOfficeData,
        'passOfficeResponseAccepted': passOfficeResponseAccepted,
        'rcaRequest': rcaRequest,
        'externalRcaRequired': externalRcaRequired,
        'rcaResponse': rcaResponse,
        'rcaResponseAccepted': rcaResponseAccepted,
        'rcaData': rcaData,
        'systemReviewRequired': systemReviewRequired,
        'incidentActionPlans': incidentActionPlans,
        'furtherInvestigation': furtherInvestigation,
        'cctvFindings': cctvFindings,
        'dataLossIdentified': dataLossIdentified,
        'dataLossRequest': dataLossRequest,
        'dataLossResponse': dataLossResponse,
        'dataLossInfo': dataLossInfo,
        'dataLossResponseAccepted': dataLossResponseAccepted,
        'fteInvolved': fteInvolved,
        'fteCwrEmployeeId': fteCwrEmployeeId,
        'hrEmployeeId': hrEmployeeId,
        'cwrInvolved': cwrInvolved,
        'cwrName': cwrName,
        'companyName': companyName,
        'slaViolated': slaViolated,
        'readAcrossRequired': readAcrossRequired,
        'fteCwrTriggerRequired': fteCwrTriggerRequired,
        'interviewInfo': interviewInfo,
        'staffStatement': staffStatement,
        'interviewedByHrId': interviewedByHrId,
        'passOfficeResponded': passOfficeResponded,
        'rcaVendorResponded': rcaVendorResponded,
        'dataLossVendorResponded': dataLossVendorResponded,
        'postInvestigationDone': postInvestigationDone,
        'incidentWitness': incidentWitness,
        'incidentReadAcross': incidentReadAcross,
        'images': images,
        'occType': occType,
        'occurrence': occurrence?.toJson(),
        'keyLossGi': keyLossGi?.toJson(),
        'entrySecurityName': entrySecurityName,
        'systemReviewerName': systemReviewerName,
        'incidentManagerName': incidentManagerName,
        'incidentOwnerName': incidentOwnerName,
        'fteCwrName': fteCwrName,
        'hrBusinessPartnerName': hrBusinessPartnerName,
        'intervieweeName': intervieweeName,
        'interviewedByName': interviewedByName,
        'complainantHrName': complainantHrName,
        'lock': lock
      };
}
