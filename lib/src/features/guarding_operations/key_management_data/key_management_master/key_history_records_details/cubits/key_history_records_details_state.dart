part of 'key_history_records_details_cubit.dart';

class KeyHistoryRecordsDetailsState extends Equatable {
  final FormStatus status;
  final KeyManagementMasterModel model;
  final Locations? locations;
  final User? loggedInUserDetails;
  final List<BaseUser>? users;
  final List<BaseUser>? emailUsers;
  final List<Organisation>? listOfEntities;
  final List<Organisation>? listOfQualifications;
  final List<Organisation> destructionReasons;
  final AddEntities? getEntitiesResponse;
  final List<String>? participationDates;
  final String? message;
  final User? createdBy;
  final KLDUiLabels? labels;
  final bool? isReadOnly;

  factory KeyHistoryRecordsDetailsState.initial({
    required KeyManagementMasterModel model,
    required Locations locations,
    required User loggedInUserDetails,
    required List<BaseUser>? users,
    final List<BaseUser>? emailUsers,
    required final List<Organisation>? listOfEntities,
    required final AddEntities? getEntitiesResponse,
    required final List<Organisation> departments,
    required String errorMessage,
    User? createdBy,
    List<String>? participationDate,
  }) {
    return KeyHistoryRecordsDetailsState(
      status: FormStatus.initial,
      model: model,
      locations: locations,
      loggedInUserDetails: loggedInUserDetails,
      listOfEntities: listOfEntities,
      destructionReasons: departments,
      getEntitiesResponse: getEntitiesResponse,
      users: users,
      emailUsers: emailUsers,
      message: errorMessage,
      createdBy: createdBy,
    );
  }

  ErrorResponse get isValidDraft {
    log('-model.status---${model.status}--');

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
    // if (model.noOfKeys != null && model.keyType == 1 && model.noOfKeys != (model.noKeys??0) && model.noOfKeys! > (model.noKeys??0)) {
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
    this.locations,
    this.loggedInUserDetails,
    this.users,
    this.emailUsers,
    this.listOfEntities,
    this.listOfQualifications,
    required this.destructionReasons,
    this.getEntitiesResponse,
    this.participationDates,
    this.message,
    this.createdBy,
    this.labels,
    this.isReadOnly,
  });

  KeyHistoryRecordsDetailsState copyWith({
    FormStatus? status,
    KeyManagementMasterModel? model,
    Locations? locations,
    User? loggedInUserDetails,
    List<BaseUser>? users,
    List<BaseUser>? emailUsers,
    List<Organisation>? listOfEntities,
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
      locations: locations ?? this.locations,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      users: users ?? this.users,
      emailUsers: emailUsers ?? this.emailUsers,
      listOfEntities: listOfEntities ?? this.listOfEntities,
      participationDates: participationDates ?? this.participationDates,
      message: message ?? this.message,
      createdBy: createdBy ?? this.createdBy,
      labels: labels ?? this.labels,
      destructionReasons: destructionReasons ?? this.destructionReasons,
      isReadOnly: isReadOnly ?? this.isReadOnly,
    );
  }
}
