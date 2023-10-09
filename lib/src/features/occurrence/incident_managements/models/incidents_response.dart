import '../../../../models/entity.dart';
import '../../../../models/entry_security.dart';
import '../../../../models/history.dart';
import '../../../../models/organisation.dart';
import '../../../createfound/models/user.dart';

class IncidentsResponse {
  final List<Incident>? items;
  final int? totalCount;
  final int? currentPageNo;
  final int? totalPageCount;

  IncidentsResponse({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  IncidentsResponse.fromJson(Map<String, dynamic> json)
      : items = (json['list'] as List?)
            ?.map((dynamic e) => Incident.fromJson(e as Map<String, dynamic>))
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

class Incident {
  final int? id;
  final String? slNo;
  final String? inputDate;
  final Organisation? location;
  final Organisation? locationRegion;
  final int? workflowId;
  final List<Entity>? entities;
  final int? status;
  final int? incidentType;
  final int? typeOfAsset;
  final Organisation? typeOfArticle;
  final String? color;
  final String? modifiedDate;
  final String? modifiedBy;
  final List<History>? history;
  final EntrySecurity? entrySecurity;
  final bool? complainantDbEmp;
  final User? complainant;
  final String? employeeId;
  final String? complainantName;
  final Organisation? complainantDepartment;
  final User? complainantHr;
  final String? incidentDate;
  final String? incidentOrganisation;
  final String? description;
  final User? incidentManager;
  final User? incidentOwner;
  final bool? ioRoleAccepted;
  final String? closureTargetDate;
  final String? incidentAnalysis;
  final int? severity;
  final String? incidentImpact;
  final String? initialInvestigation;
  final bool? passOfficeApprovalRequired;
  final String? passOfficeRequest;
  final String? passOfficeResponse;
  final String? logicalDevices;
  final List<dynamic>? passOfficeData;
  final bool? passOfficeResponseAccepted;
  final String? rcaRequest;
  final bool? externalRcaRequired;
  final String? rcaResponse;
  final bool? rcaResponseAccepted;
  final List<dynamic>? rcaData;
  final bool? systemReviewRequired;
  final List<dynamic>? incidentActionPlans;
  final String? furtherInvestigation;
  final String? cctvFindings;
  final bool? dataLossIdentified;
  final String? dataLossRequest;
  final String? dataLossResponse;
  final List<dynamic>? dataLossInfo;
  final bool? dataLossResponseAccepted;
  final bool? fteInvolved;
  final String? fteCwrEmployeeId;
  final String? hrEmployeeId;
  final bool? cwrInvolved;
  final String? cwrName;
  final String? companyName;
  final bool? slaViolated;
  final bool? readAcrossRequired;
  final bool? fteCwrTriggerRequired;
  final String? interviewInfo;
  final String? staffStatement;
  final String? interviewedByHrId;
  final bool? passOfficeResponded;
  final bool? rcaVendorResponded;
  final bool? dataLossVendorResponded;
  final bool? postInvestigationDone;
  final List<dynamic>? incidentWitness;
  final List<dynamic>? incidentReadAcross;
  final List<dynamic>? images;
  final int? occType;
  final String? entrySecurityName;
  final String? systemReviewerName;
  final String? incidentManagerName;
  final String? incidentOwnerName;
  final String? fteCwrName;
  final String? hrBusinessPartnerName;
  final String? intervieweeName;
  final String? interviewedByName;
  final String? complainantHrName;

  Incident({
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
    this.complainantDbEmp,
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
    this.entrySecurityName,
    this.systemReviewerName,
    this.incidentManagerName,
    this.incidentOwnerName,
    this.fteCwrName,
    this.hrBusinessPartnerName,
    this.intervieweeName,
    this.interviewedByName,
    this.complainantHrName,
  });

  Incident.fromJson(Map<String, dynamic> json)
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
            ?.map((dynamic e) => Entity.fromJson(e as Map<String, dynamic>))
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
            ? EntrySecurity.fromJson(
                json['entrySecurity'] as Map<String, dynamic>)
            : null,
        complainantDbEmp = json['complainantDbEmp'] as bool?,
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
        entrySecurityName = json['entrySecurityName'] as String?,
        systemReviewerName = json['systemReviewerName'] as String?,
        incidentManagerName = json['incidentManagerName'] as String?,
        incidentOwnerName = json['incidentOwnerName'] as String?,
        fteCwrName = json['fteCwrName'] as String?,
        hrBusinessPartnerName = json['hrBusinessPartnerName'] as String?,
        intervieweeName = json['intervieweeName'] as String?,
        interviewedByName = json['interviewedByName'] as String?,
        complainantHrName = json['complainantHrName'] as String?;

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
        'entrySecurityName': entrySecurityName,
        'systemReviewerName': systemReviewerName,
        'incidentManagerName': incidentManagerName,
        'incidentOwnerName': incidentOwnerName,
        'fteCwrName': fteCwrName,
        'hrBusinessPartnerName': hrBusinessPartnerName,
        'intervieweeName': intervieweeName,
        'interviewedByName': interviewedByName,
        'complainantHrName': complainantHrName
      };
}
