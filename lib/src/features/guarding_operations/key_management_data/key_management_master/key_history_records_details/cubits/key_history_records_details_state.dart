part of 'key_history_records_details_cubit.dart';

class KeyHistoryRecordsDetailsState extends Equatable {
  final FormStatus status;
  final KeyHistoryModel model;
  final KeyManagementMasterModel? keyManagementMasterModel;
  final User? loggedInUserDetails;
  final List<BaseUser>? users;
  final List<BaseUser>? securityManager;
  final List<BaseUser>? srh;
  final List<Organisation>? departments;
  final List<Organisation> destructionReasons;
  final String? message;
  final User? createdBy;
  final KLDUiLabels? labels;
  final bool? isReadOnly;

  factory KeyHistoryRecordsDetailsState.initial({
    required KeyHistoryModel model,
    required User loggedInUserDetails,
    required List<BaseUser>? users,
    final List<BaseUser>? securityManager,
    final List<BaseUser>? srh,
    required final List<Organisation> departments,
    required String errorMessage,
    User? createdBy,
    List<String>? participationDate,
  }) {
    return KeyHistoryRecordsDetailsState(
      status: FormStatus.initial,
      model: model,
      loggedInUserDetails: loggedInUserDetails,
      departments: departments,
      destructionReasons: departments,
      users: users,
      securityManager: securityManager,
      srh: srh,
      message: errorMessage,
      createdBy: createdBy,
    );
  }

  ErrorResponse get isValidDraft {
    log('-model.status---${model.status}--');
    log('-Poooo---${model.noOfKeys != null &&
        model.keyType == 'Normal' &&
        ((model.noOfKeys!) !<= (keyManagementMasterModel?.noKeys ?? 0))}--');

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
    if (model.noOfKeys != null &&
        model.keyType == 'Normal' &&
        ((model.noOfKeys!) !<= (keyManagementMasterModel?.noKeys ?? 0))) {
      return const ErrorResponse(
          status: false, message: 'Please enter Valid No.of Keys');
    }

    // if (model.noOfKeys != null && model.keyType == 1 && model.noOfKeys! > (keyManagementMasterModel?.noKeys??0)) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Valid No.of Keys');
    // }
    // if (model.noOfKeys != null && model.keyType == 2 && model.noOfKeys! > (keyManagementMasterModel?.noMasterKey??0)) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Valid No.of Keys');
    // }
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
    // if (model.noOfKeys != null && model.keyType == 1 && model.noOfKeys! > (model.noKeys??0)) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Valid No.of Keys');
    // }
    // if (model.noOfKeys != null && model.keyType == 2 && model.noOfKeys! > (model.noMasterKey??0)) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Valid No.of Keys');
    // }
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
    this.srh,
    this.securityManager,
    this.departments,
    required this.destructionReasons,
    this.message,
    this.createdBy,
    this.labels,
    this.isReadOnly,
  });

  KeyHistoryRecordsDetailsState copyWith({
    FormStatus? status,
    KeyHistoryModel? model,
    Locations? locations,
    User? loggedInUserDetails,
    List<BaseUser>? users,
    List<BaseUser>? securityManager,
    List<BaseUser>? srh,
    List<Organisation>? departments,
    List<Organisation>? destructionReasons,
    AddEntities? getEntitiesResponse,
    List<String>? participationDates,
    String? message,
    User? createdBy,
    final KLDUiLabels? labels,
    bool? isReadOnly,
  }) {
    return KeyHistoryRecordsDetailsState(
      status: status ?? this.status,
      model: model ?? this.model,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      users: users ?? this.users,
      securityManager: securityManager ?? this.securityManager,
      srh: srh ?? this.srh,
      departments: departments ?? this.departments,
      message: message ?? this.message,
      createdBy: createdBy ?? this.createdBy,
      labels: labels ?? this.labels,
      destructionReasons: destructionReasons ?? this.destructionReasons,
      isReadOnly: isReadOnly ?? this.isReadOnly,
    );
  }
}
