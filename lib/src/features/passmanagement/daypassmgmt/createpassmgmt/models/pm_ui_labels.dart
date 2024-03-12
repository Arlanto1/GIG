import 'package:db_atom/index.dart';

part 'pm_ui_labels.g.dart';

@JsonSerializable()
class PMUiLabels {
  PMUiLabels({
    required this.defaultLocale,
    required this.locale,
  });

  factory PMUiLabels.fromJson(Map<String, dynamic> json) =>
      _$PMUiLabelsFromJson(json);

  Map<String, dynamic> toJson() => _$PMUiLabelsToJson(this);

  @JsonKey(name: 'locale')
  final PMUiLabelsLocale locale;
  @JsonKey(name: 'default')
  final PMUiLabelsLocale defaultLocale;
}

@JsonSerializable()
class PMUiLabelsLocale {
  @JsonKey(name: 'com.arlanto.atom.passManagement.status')
  final String? status;
  @JsonKey(name: 'com.arlanto.atom.passManagement.visitorImage')
  final String? visitorImage;
  @JsonKey(name: 'com.arlanto.atom.passManagement.dayPassReason')
  final String? dayPassReason;
  @JsonKey(name: 'com.arlanto.atom.passManagement.sezPassInfo')
  final String? sezPassInfo;
  @JsonKey(name: 'com.arlanto.atom.passManagement.status.returnedDamaged')
  final String? returnedDamagedStatus;
  @JsonKey(name: 'com.arlanto.atom.passManagement.idValidationType.other')
  final String? idValidationTypeOther;
  @JsonKey(name: 'com.arlanto.atom.passManagement.updateStatus')
  final String? updateStatus;
  @JsonKey(name: 'com.arlanto.atom.passManagement.dayPassInfo')
  final String? dayPassInfo;
  @JsonKey(name: 'com.arlanto.atom.passManagement.visitingDepartment')
  final String? visitingDepartment;
  @JsonKey(name: 'com.arlanto.atom.passManagement.idValidationType')
  final String? idValidationType;
  @JsonKey(name: 'com.arlanto.atom.passManagement.category')
  final String? category;
  @JsonKey(name: 'com.arlanto.atom.passManagement.cwrSponsor')
  final String? cwrSponsor;
  @JsonKey(name: 'com.arlanto.atom.passManagement.receivedFromCustomOn')
  final String? receivedFromCustomOn;
  @JsonKey(name: 'com.arlanto.atom.passManagement.passType')
  final String? passType;
  @JsonKey(name: 'com.arlanto.atom.passManagement.visitingPurpose')
  final String? visitingPurpose;
  @JsonKey(name: 'com.arlanto.atom.passManagement.idValidationType.pan')
  final String? idValidationTypePan;
  @JsonKey(name: 'com.arlanto.atom.passManagement.startTime')
  final String? startTime;
  @JsonKey(name: 'com.arlanto.atom.passManagement.email')
  final String? email;
  @JsonKey(name: 'com.arlanto.atom.passManagement.escortedByHost')
  final String? escortedByHost;
  @JsonKey(name: 'com.arlanto.atom.passManagement.category.permanent')
  final String? categoryPermanent;
  @JsonKey(name: 'com.arlanto.atom.passManagement.status.returnedDefaced')
  final String? returnedDefacedStatus;
  @JsonKey(name: 'com.arlanto.atom.passManagement.status.defaced')
  final String? defacedStatus;
  @JsonKey(name: 'com.arlanto.atom.passManagement.idValidationType.drivingLicense')
  final String? idValidationTypeDrivingLicense;
  @JsonKey(name: 'com.arlanto.atom.passManagement.companyType')
  final String? companyType;
  @JsonKey(name: 'com.arlanto.atom.passManagement.passType.dwsVendorPass')
  final String? passTypeDwsVendorPass;
  @JsonKey(name: 'com.arlanto.atom.passManagement.idValidationType.aadhar')
  final String? idValidationTypeAadhar;
  @JsonKey(name: 'com.arlanto.atom.passManagement.hostEmployeeId')
  final String? hostEmployeeId;
  @JsonKey(name: 'com.arlanto.atom.passManagement.passType.sezPass')
  final String? passTypeSezPass;
  @JsonKey(name: 'com.arlanto.atom.passManagement.sentToCustomOn')
  final String? sentToCustomOn;
  @JsonKey(name: 'com.arlanto.atom.passManagement.passType.dwsVisitorPass')
  final String? passTypeDwsVisitorPass;
  @JsonKey(name: 'com.arlanto.atom.passManagement.slNo')
  final String? slNo;
  @JsonKey(name: 'com.arlanto.atom.passManagement.vendorPassInfo')
  final String? vendorPassInfo;
  @JsonKey(name: 'com.arlanto.atom.passManagement.mtpPassNo')
  final String? mtpPassNo;
  @JsonKey(name: 'com.arlanto.atom.passManagement.idValidationType.passport')
  final String? idValidationTypePassport;
  @JsonKey(name: 'com.arlanto.atom.passManagement.visitorComingFrom')
  final String? visitorComingFrom;
  @JsonKey(name: 'com.arlanto.atom.passManagement.status.created')
  final String? statusCreated;
  @JsonKey(name: 'com.arlanto.atom.passManagement.employee')
  final String? employee;
  @JsonKey(name: 'com.arlanto.atom.passManagement.endTime')
  final String? endTime;
  @JsonKey(name: 'com.arlanto.atom.passManagement.exceptionalApproval')
  final String? exceptionalApproval;
  @JsonKey(name: 'com.arlanto.atom.passManagement.escortedBy')
  final String? escortedBy;
  @JsonKey(name: 'com.arlanto.atom.passManagement.status.cancelled')
  final String? statusCancelled;
  @JsonKey(name: 'com.arlanto.atom.passManagement.handoverSecurity')
  final String? handoverSecurity;
  @JsonKey(name: 'com.arlanto.atom.passManagement.companyName')
  final String? companyName;
  @JsonKey(name: 'com.arlanto.atom.passManagement.status.lost')
  final String? statusLost;
  @JsonKey(name: 'com.arlanto.atom.passManagement.inputDate')
  final String? inputDate;
  @JsonKey(name: 'com.arlanto.atom.passManagement.passIssuedOn')
  final String? passIssuedOn;
  @JsonKey(name: 'com.arlanto.atom.passManagement.passType.vendorPass')
  final String? passTypeVendorPass;
  @JsonKey(name: 'com.arlanto.atom.passManagement.locationRegion')
  final String? locationRegion;
  @JsonKey(name: 'com.arlanto.atom.passManagement.cwrSponsorEmployeeId')
  final String? cwrSponsorEmployeeId;
  @JsonKey(name: 'com.arlanto.atom.passManagement.idValidationType.voter')
  final String? idValidationTypeVoter;
  @JsonKey(name: 'com.arlanto.atom.passManagement.status.damaged')
  final String? statusDamaged;
  @JsonKey(name: 'com.arlanto.atom.passManagement.customPassNo')
  final String? customPassNo;
  @JsonKey(name: 'com.arlanto.atom.passManagement.vendorName')
  final String? vendorName;
  @JsonKey(name: 'com.arlanto.atom.passManagement.passType.visitorPass')
  final String? passTypeVisitorPass;
  @JsonKey(name: 'com.arlanto.atom.passManagement.idValidated')
  final String? idValidated;
  @JsonKey(name: 'com.arlanto.atom.passManagement.status.returned')
  final String? statusReturned;
  @JsonKey(name: 'com.arlanto.atom.passManagement.status.nonReturned')
  final String? statusNonReturned;
  @JsonKey(name: 'com.arlanto.atom.passManagement.location')
  final String? location;
  @JsonKey(name: 'com.arlanto.atom.passManagement.passType.dwsDayPass')
  final String? passTypeDwsDayPass;
  @JsonKey(name: 'com.arlanto.atom.passManagement.employeeId')
  final String? employeeId;
  @JsonKey(name: 'com.arlanto.atom.passManagement.entity')
  final String? entity;
  @JsonKey(name: 'com.arlanto.atom.passManagement.employeeName')
  final String? employeeName;
  @JsonKey(name: 'com.arlanto.atom.passManagement.passType.dayPass')
  final String? passTypeDayPass;
  @JsonKey(name: 'com.arlanto.atom.passManagement.category.temporary')
  final String? categoryTemporary;
  @JsonKey(name: 'com.arlanto.atom.passManagement.identifiedEmployeeId')
  final String? identifiedEmployeeId;
  @JsonKey(name: 'com.arlanto.atom.passManagement.returnedTime')
  final String? returnedTime;
  @JsonKey(name: 'com.arlanto.atom.passManagement.evidenceInfo')
  final String? evidenceInfo;
  @JsonKey(name: 'com.arlanto.atom.passManagement.contactNo')
  final String? contactNo;
  @JsonKey(name: 'com.arlanto.atom.passManagement.vendorPassReason')
  final String? vendorPassReason;
  @JsonKey(name: 'com.arlanto.atom.passManagement.entrySecurity')
  final String? entrySecurity;
  @JsonKey(name: 'com.arlanto.atom.passManagement.visitorPassInfo')
  final String? visitorPassInfo;
  @JsonKey(name: 'com.arlanto.atom.passManagement.status.handedOver')
  final String? statusHandedOver;
  @JsonKey(name: 'com.arlanto.atom.passManagement.escortedEmployeeId')
  final String? escortedEmployeeId;
  @JsonKey(name: 'com.arlanto.atom.passManagement.otherIdInfo')
  final String? otherIdInfo;
  @JsonKey(name: 'com.arlanto.atom.passManagement.department')
  final String? department;
  @JsonKey(name: 'com.arlanto.atom.passManagement.visitorName')
  final String? visitorName;
  @JsonKey(name: 'com.arlanto.atom.passManagement.identifiedBy')
  final String? identifiedBy;
  @JsonKey(name: 'com.arlanto.atom.passManagement.host')
  final String? host;

  PMUiLabelsLocale(
      this.status,
      this.visitorImage,
      this.dayPassReason,
      this.sezPassInfo,
      this.returnedDamagedStatus,
      this.idValidationTypeOther,
      this.updateStatus,
      this.dayPassInfo,
      this.visitingDepartment,
      this.idValidationType,
      this.category,
      this.cwrSponsor,
      this.receivedFromCustomOn,
      this.passType,
      this.visitingPurpose,
      this.idValidationTypePan,
      this.startTime,
      this.email,
      this.escortedByHost,
      this.categoryPermanent,
      this.returnedDefacedStatus,
      this.defacedStatus,
      this.idValidationTypeDrivingLicense,
      this.companyType,
      this.passTypeDwsVendorPass,
      this.idValidationTypeAadhar,
      this.hostEmployeeId,
      this.passTypeSezPass,
      this.sentToCustomOn,
      this.passTypeDwsVisitorPass,
      this.slNo,
      this.vendorPassInfo,
      this.mtpPassNo,
      this.idValidationTypePassport,
      this.visitorComingFrom,
      this.statusCreated,
      this.employee,
      this.endTime,
      this.exceptionalApproval,
      this.escortedBy,
      this.statusCancelled,
      this.handoverSecurity,
      this.companyName,
      this.statusLost,
      this.inputDate,
      this.passIssuedOn,
      this.passTypeVendorPass,
      this.locationRegion,
      this.cwrSponsorEmployeeId,
      this.idValidationTypeVoter,
      this.statusDamaged,
      this.customPassNo,
      this.vendorName,
      this.passTypeVisitorPass,
      this.idValidated,
      this.statusReturned,
      this.statusNonReturned,
      this.location,
      this.passTypeDwsDayPass,
      this.employeeId,
      this.entity,
      this.employeeName,
      this.passTypeDayPass,
      this.categoryTemporary,
      this.identifiedEmployeeId,
      this.returnedTime,
      this.evidenceInfo,
      this.contactNo,
      this.vendorPassReason,
      this.entrySecurity,
      this.visitorPassInfo,
      this.statusHandedOver,
      this.escortedEmployeeId,
      this.otherIdInfo,
      this.department,
      this.visitorName,
      this.identifiedBy,this.host);

  factory PMUiLabelsLocale.fromJson(Map<String, dynamic> json) =>
      _$PMUiLabelsLocaleFromJson(json);

  Map<String, dynamic> toJson() => _$PMUiLabelsLocaleToJson(this);
}
