part of 'key_history_records_details_cubit.dart';

class KeyHistoryRecordsDetailsState extends Equatable {
  final FormStatus status;
  final KeyHistoryModel model;
  final KeyManagementMasterModel? keyManagementMasterModel;
  final KeyIssuanceProcessRecord? keyIssuanceProcessRecord;
  final User? loggedInUserDetails;
  final List<BaseUser>? users;
  final List<BaseUser>? securityManagers;
  final List<BaseUser>? sRHs;
  final List<Organisation>? departments;
  final List<Organisation> destructionReasons;
  final String? message;
  final User? createdBy;
  final KLDUiLabels? labels;
  final bool? isReadOnly;
  final KeyManagementIssuanceModel? keyManagementIssuanceModel;

  factory KeyHistoryRecordsDetailsState.initial({
    required KeyHistoryModel model,
    required User loggedInUserDetails,
    required List<BaseUser>? users,
    final List<BaseUser>? securityManagers,
    final List<BaseUser>? sRHs,
    required final List<Organisation> departments,
    required String errorMessage,
    User? createdBy,
    List<String>? participationDate,
    KeyManagementMasterModel? keyManagementMasterModel,
    KeyIssuanceProcessRecord? keyIssuanceProcessRecord,
    KeyManagementIssuanceModel? keyManagementIssuanceModel,
  }) {
    return KeyHistoryRecordsDetailsState(
      status: FormStatus.initial,
      model: model,
      loggedInUserDetails: loggedInUserDetails,
      departments: departments,
      destructionReasons: departments,
      users: users,
      securityManagers: securityManagers,
      sRHs: sRHs,
      message: errorMessage,
      createdBy: createdBy,
    );
  }

  ErrorResponse get isValidDraft {
    log('-noOfKeys---${(model.noOfKeys ?? 0)}--');
    log('-keyManagementMasterModel?.noKeys---${(keyManagementMasterModel?.noKeys)}--');
    log('-greater---${((model.noOfKeys ?? 0) > (keyManagementMasterModel?.noKeys ?? 0))}--');
    // if (model.location == null) {
    //   log('-model.location-----isValidDraft-');
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Location');
    // }
    if (model.createdBy == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Created By');
    }
    if (model.status == null) {
      return const ErrorResponse(status: false, message: 'Please enter Status');
    }
    if (model.keyType == 1 &&
        ((model.noOfKeys!) > (keyManagementMasterModel?.noKeys ?? 0))) {
      return const ErrorResponse(
          status: false, message: 'Please enter Valid No.of Keys');
    }

    if (model.keyType == 2 &&
        ((model.noOfKeys!) > (keyManagementMasterModel?.noMasterKey ?? 0))) {
      return const ErrorResponse(
          status: false, message: 'Please enter Valid No.of Keys');
    }
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  ErrorResponse get isValid {
    if (model.status == null) {
      return const ErrorResponse(status: false, message: 'Please enter Status');
    }
    if (model.keyType == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Key Type');
    }
    if (model.type == ConstantsIntValue.keyDestroyHistoryInt &&
        model.securityManager == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Security Manager');
    }
    if (model.type == ConstantsIntValue.keyDestroyHistoryInt &&
        model.destructionReason == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Reason for Key Destruction');
    }

    if ((model.type == ConstantsIntValue.keyLostHistoryInt ||
            model.type == ConstantsIntValue.keyDamageHistoryInt) &&
        model.srh == null) {
      return const ErrorResponse(status: false, message: 'Please enter SRH');
    }

    if ((model.type == ConstantsIntValue.keyLostHistoryInt ||
            model.type == ConstantsIntValue.keyDamageHistoryInt) &&
        model.lostKeyDetails == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Details of Lost key');
    }
    if (model.noOfKeys == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter No.of Keys');
    }
    if (model.keyType == 1 &&
        ((model.noOfKeys!) > (keyManagementMasterModel?.noKeys ?? 0))) {
      return const ErrorResponse(
          status: false, message: 'Please enter Valid No.of Keys');
    }

    if (model.keyType == 2 &&
        ((model.noOfKeys!) > (keyManagementMasterModel!.noMasterKey!))) {
      return const ErrorResponse(
          status: false, message: 'Please enter Valid No.of Keys');
    }
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  @override
  List<Object?> get props => [model, status];

  const KeyHistoryRecordsDetailsState({
    required this.status,
    required this.model,
    this.keyManagementMasterModel,
    this.loggedInUserDetails,
    this.users,
    this.sRHs,
    this.securityManagers,
    this.departments,
    required this.destructionReasons,
    this.message,
    this.createdBy,
    this.labels,
    this.isReadOnly,
    this.keyIssuanceProcessRecord,
    this.keyManagementIssuanceModel,
  });

  KeyHistoryRecordsDetailsState copyWith({
    FormStatus? status,
    KeyHistoryModel? model,
    Locations? locations,
    User? loggedInUserDetails,
    List<BaseUser>? users,
    List<BaseUser>? securityManagers,
    List<BaseUser>? sRHs,
    List<Organisation>? departments,
    List<Organisation>? destructionReasons,
    AddEntities? getEntitiesResponse,
    List<String>? participationDates,
    String? message,
    User? createdBy,
    final KLDUiLabels? labels,
    bool? isReadOnly,
    keyManagementMasterModel,
    keyIssuanceProcessRecord,
    keyManagementIssuanceModel,
  }) {
    return KeyHistoryRecordsDetailsState(
      status: status ?? this.status,
      model: model ?? this.model,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      users: users ?? this.users,
      securityManagers: securityManagers ?? this.securityManagers,
      sRHs: sRHs ?? this.sRHs,
      departments: departments ?? this.departments,
      message: message ?? this.message,
      createdBy: createdBy ?? this.createdBy,
      labels: labels ?? this.labels,
      destructionReasons: destructionReasons ?? this.destructionReasons,
      isReadOnly: isReadOnly ?? this.isReadOnly,
      keyManagementMasterModel:
          keyManagementMasterModel ?? this.keyManagementMasterModel,
      keyIssuanceProcessRecord:
          keyIssuanceProcessRecord ?? this.keyIssuanceProcessRecord,
      keyManagementIssuanceModel: keyManagementIssuanceModel ?? this.keyManagementIssuanceModel,
    );
  }
}
