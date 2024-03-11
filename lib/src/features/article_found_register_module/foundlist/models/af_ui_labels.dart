import 'package:db_atom/index.dart';
part 'af_ui_labels.g.dart';

@JsonSerializable()
class AFUiLabels {
  AFUiLabels({
    required this.defaultLocale,
    required this.locale,
  });

  factory AFUiLabels.fromJson(Map<String, dynamic> json) =>
      _$AFUiLabelsFromJson(json);

  Map<String, dynamic> toJson() => _$AFUiLabelsToJson(this);

  @JsonKey(name: 'locale')
  final AFUiLabelsLocale locale;
  @JsonKey(name: 'default')
  final AFUiLabelsLocale defaultLocale;
}

@JsonSerializable()
class AFUiLabelsLocale {
  @JsonKey(name: 'com.arlanto.atom.found.additionalInformation')
  String? foundAdditionalInformation;

  @JsonKey(name: 'com.arlanto.atom.found.locationRegion')
  String? foundLocationRegion;

  @JsonKey(name: 'com.arlanto.atom.found.quantity')
  String? foundQuantity;

  @JsonKey(name: 'com.arlanto.atom.found.entrySecurity')
  String? foundEntrySecurity;

  @JsonKey(name: 'com.arlanto.atom.found.location')
  String? foundLocation;

  @JsonKey(name: 'com.arlanto.atom.found.depositorDepartment')
  String? foundDepositorDepartment;

  @JsonKey(name: 'com.arlanto.atom.found.department')
  String? foundEmployeeDepartment;

  @JsonKey(name: 'com.arlanto.atom.found.handoverSecurity')
  String? foundHandoverSecurity;

  @JsonKey(name: 'com.arlanto.atom.found.status.handover')
  String? foundStatusHandover;

  @JsonKey(name: 'com.arlanto.atom.found.handoverDate')
  String? foundHandoverDate;

  @JsonKey(name: 'com.arlanto.atom.found.typeOfAsset.personal')
  String? foundTypeOfAssetPersonal;

  @JsonKey(name: 'com.arlanto.atom.found.claimantEmployeeId')
  String? foundClaimantEmployeeId;

  @JsonKey(name: 'com.arlanto.atom.found.claimantName')
  String? foundClaimantName;

  @JsonKey(name: 'com.arlanto.atom.found.depositor')
  String? foundDepositor;

  @JsonKey(name: 'com.arlanto.atom.found.foundLocation')
  String? foundFoundLocation;

  @JsonKey(name: 'com.arlanto.atom.found.typeOfArticle')
  String? foundTypeOfArticle;

  @JsonKey(name: 'com.arlanto.atom.found.depositorName')
  String? foundDepositorName;

  @JsonKey(name: 'com.arlanto.atom.found.claimant')
  String? foundClaimant;

  @JsonKey(name: 'com.arlanto.atom.found.color')
  String? foundColor;

  @JsonKey(name: 'com.arlanto.atom.found.eventProtection')
  String? foundEventProtection;

  @JsonKey(name: 'com.arlanto.atom.found.inputDate')
  String? foundInputDate;

  @JsonKey(name: 'com.arlanto.atom.found.depositorEmail')
  String? foundDepositorEmail;

  @JsonKey(name: 'com.arlanto.atom.found.claimantSign')
  String? foundClaimantSign;

  @JsonKey(name: 'com.arlanto.atom.found.status.found')
  String? foundStatusFound;

  @JsonKey(name: 'com.arlanto.atom.found.foundDate')
  String? foundFoundDate;

  @JsonKey(name: 'com.arlanto.atom.found.employeeId')
  String? foundEmployeeId;

  @JsonKey(name: 'com.arlanto.atom.found.depositorDbEmp')
  String? foundDepositorDbEmp;

  @JsonKey(name: 'com.arlanto.atom.found.slNo')
  String? foundSlNo;

  @JsonKey(name: 'com.arlanto.atom.found.typeOfAsset.company')
  String? foundTypeOfAssetCompany;

  @JsonKey(name: 'com.arlanto.atom.found.claimantDbEmp')
  String? foundClaimantDbEmp;

  @JsonKey(name: 'com.arlanto.atom.found.claimantNoSign')
  String? foundClaimantNoSign;

  @JsonKey(name: 'com.arlanto.atom.found.status')
  String? foundStatus;

  @JsonKey(name: 'com.arlanto.atom.found.rejectionComment')
  String? foundRejectionComment;

  @JsonKey(name: 'com.arlanto.atom.found.entity')
  String? foundEntity;

  @JsonKey(name: 'com.arlanto.atom.found.typeOfAsset')
  String? foundTypeOfAsset;

  @JsonKey(name: 'com.arlanto.atom.found.claimantEmail')
  String? foundClaimantEmail;

  @JsonKey(name: 'com.arlanto.atom.found.claimantDepartment')
  String? foundClaimantDepartment;

  @JsonKey(name: 'com.arlanto.atom.found.status.securityCustody')
  String? foundStatusSecurityCustody;

  @JsonKey(name: 'com.arlanto.atom.found.claimantConfirmByEmail')
  String? foundClaimantConfirmByEmail;


  AFUiLabelsLocale(
      this.foundAdditionalInformation,
      this.foundLocationRegion,
      this.foundQuantity,
      this.foundEntrySecurity,
      this.foundLocation,
      this.foundDepositorDepartment,
      this.foundEmployeeDepartment,
      this.foundHandoverSecurity,
      this.foundStatusHandover,
      this.foundHandoverDate,
      this.foundTypeOfAssetPersonal,
      this.foundClaimantEmployeeId,
      this.foundClaimantName,
      this.foundDepositor,
      this.foundFoundLocation,
      this.foundTypeOfArticle,
      this.foundDepositorName,
      this.foundClaimant,
      this.foundColor,
      this.foundEventProtection,
      this.foundInputDate,
      this.foundDepositorEmail,
      this.foundClaimantSign,
      this.foundStatusFound,
      this.foundFoundDate,
      this.foundEmployeeId,
      this.foundDepositorDbEmp,
      this.foundSlNo,
      this.foundTypeOfAssetCompany,
      this.foundClaimantDbEmp,
      this.foundClaimantNoSign,
      this.foundStatus,
      this.foundRejectionComment,
      this.foundEntity,
      this.foundTypeOfAsset,
      this.foundClaimantEmail,
      this.foundClaimantDepartment,
      this.foundStatusSecurityCustody,
      this.foundClaimantConfirmByEmail);

  factory AFUiLabelsLocale.fromJson(Map<String, dynamic> json) =>
      _$AFUiLabelsLocaleFromJson(json);

  Map<String, dynamic> toJson() => _$AFUiLabelsLocaleToJson(this);
}
