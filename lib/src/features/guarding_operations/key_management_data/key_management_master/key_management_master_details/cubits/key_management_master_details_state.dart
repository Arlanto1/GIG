part of 'key_management_master_details_cubit.dart';

class KeyManagementMasterDetailsState extends Equatable {
  final FormStatus status;
  final KeyManagementMasterModel model;
  final Locations? locations;
  final User? loggedInUserDetails;
  final List<BaseUser>? users;
  final List<BaseUser>? emailUsers;
  final List<Organisation>? listOfEntities;
  final List<Organisation>? listOfQualifications;
  final List<Organisation> departments;
  final AddQualifications? getQualificationsResponse;
  final List<Organisation>? getEntitiesResponse;
  final List<String>? participationDates;
  final String? message;
  final User? createdBy;
  final KMUiLabels? labels;

  factory KeyManagementMasterDetailsState.initial({
    required KeyManagementMasterModel model,
    required Locations locations,
    required User loggedInUserDetails,
    required List<BaseUser>? users,
    final List<BaseUser>? emailUsers,
    required final List<Organisation>? listOfEntities,
    required final List<Organisation>? getEntitiesResponse,
    required final AddQualifications? getQualificationsResponse,
    required final List<Organisation> departments,
    required String errorMessage,
    User? createdBy,
    List<String>? participationDate,
  }) {
    return KeyManagementMasterDetailsState(
      status: FormStatus.initial,
      model: model,
      locations: locations,
      loggedInUserDetails: loggedInUserDetails,
      listOfEntities: listOfEntities,
      departments: departments,
      getEntitiesResponse: getEntitiesResponse,
      getQualificationsResponse: getQualificationsResponse,
      users: users,
      emailUsers: emailUsers,
      message: errorMessage,
      createdBy: createdBy,
    );
  }

  ErrorResponse get isValidDraft {
    log('-model.status---${model.status}--');

    // if (model.location == null) {
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
    if (model.location == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Location');
    }
    if (model.createdDate == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Date of Creation');
    }
    if (model.createdBy == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Created By');
    }
    if (model.entities == null) {
      return const ErrorResponse(status: false, message: 'Please enter Entity');
    }
    if (model.floor == null) {
      return const ErrorResponse(status: false, message: 'Please enter Floor');
    }
    // if (model.doorType == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter KeyType');
    // }
    if (model.doorName == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Key Description');
    }

    if (model.keyNo == null) {
      return const ErrorResponse(status: false, message: 'Please enter Key No');
    }
    if (model.keyTagging == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Key Tagging Done');
    }
    // if (model.noOfKeys == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Number of Master Keys');
    // }
    if (model.keysStored == null) {
      return const ErrorResponse(
          status: false,
          message: 'Please enter How and Where The Keys are Stored');
    }
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  @override
  List<Object?> get props => [model, status];

  const KeyManagementMasterDetailsState({
    required this.status,
    required this.model,
    this.locations,
    this.loggedInUserDetails,
    this.users,
    this.emailUsers,
    this.listOfEntities,
    this.listOfQualifications,
    required this.departments,
    this.getQualificationsResponse,
    this.getEntitiesResponse,
    this.participationDates,
    this.message,
    this.createdBy,
    this.labels,
  });

  KeyManagementMasterDetailsState copyWith({
    FormStatus? status,
    KeyManagementMasterModel? model,
    Locations? locations,
    User? loggedInUserDetails,
    List<BaseUser>? users,
    List<BaseUser>? emailUsers,
    List<Organisation>? listOfEntities,
    List<Organisation>? departments,
    List<Organisation>? getEntitiesResponse,
    List<String>? participationDates,
    String? message,
    User? createdBy,
    final KMUiLabels? labels,
  }) {
    return KeyManagementMasterDetailsState(
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
      departments: departments ?? this.departments,
    );
  }
}
