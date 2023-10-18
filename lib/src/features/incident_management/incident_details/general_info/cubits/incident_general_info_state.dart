part of 'incident_general_info_cubit.dart';

class IncidentGeneralInfoState extends Equatable {
  final FormStatus status;
  final Incident model;
  final GetLocations? locations;
  final User? loggedInUserDetails;
  final List<BaseUser>? users;
  final List<BaseUser>? emailUsers;
  final List<Entity>? listOfEntities;
  final List<Organisation> departments;
  final AddEntities? getEntitiesResponse;
  final GetArticleType? getArticleTypeResponse;
  final List<String>? participationDates;
  final int? eventId;
  final String? message;
  final List<User>? entrySecurities;

  factory IncidentGeneralInfoState.initial({
    required Incident model,
    required GetLocations locations,
    required List<BaseUser>? users,
    required User? loggedInUserDetails,
    final List<BaseUser>? emailUsers,
    required final List<Entity>? listOfEntities,
    required final AddEntities? getEntitiesResponse,
    required final GetArticleType? getArticleTypeResponse,
    required final List<Organisation> departments,
    required String errorMessage,
    required List<CreateImage> loadAttachments,
    List<User>? entrySecurities,
    required int? eventId,
    List<String>? participationDate,
  }) {
    return IncidentGeneralInfoState(
      status: FormStatus.initial,
      model: model,
      locations: locations,
      listOfEntities: listOfEntities,
      departments: departments,
      getEntitiesResponse: getEntitiesResponse,
      getArticleTypeResponse: getArticleTypeResponse,
      users: users,
      emailUsers: emailUsers,
      message: errorMessage,
      eventId: eventId,
      participationDates: participationDate,
      entrySecurities: entrySecurities,
    );
  }

  ErrorResponse get isValidDraft {
    log('---isValidDraft-1---');
    if (model.location == null) {
      log('---isValidDraft-1-w--');
      return const ErrorResponse(status: false, message: 'Please add Location');
    }
    log('---isValidDraft--2--');
    if (model.slNo == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter SL No.');
    }

    if (model.entrySecurity == null) {
      return const ErrorResponse(
          status: false, message: 'Created By is Mandatory.');
    }

    log('---isValidDraft--3--');

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  ErrorResponse get isValid {
    log('---isValid--1--');
    if (model.status == null) {
      return const ErrorResponse(status: false, message: 'Please enter Status');
    }
    if (model.entities == null || model.entities!.isEmpty) {
      return const ErrorResponse(status: false, message: 'Please add Entities');
    }
    if (model.location == null) {
      return const ErrorResponse(status: false, message: 'Please add Location');
    }
    if (model.incidentType == null) {
      return const ErrorResponse(
          status: false, message: 'Please add Incident Type');
    }
    if (model.complainantName == null && model.complainantDbEmp == false) {
      return const ErrorResponse(
          status: false, message: 'Please add Complainant Name');
    }

    if (model.complainantDbEmp && model.complainant == null) {
      return const ErrorResponse(
          status: false, message: 'Please add Complainant');
    }

    if (!model.complainantDbEmp && model.complainantName == null) {
      return const ErrorResponse(
          status: false, message: 'Please add Complainant Name');
    }
    if (model.complainantDbEmp == true) {
      return const ErrorResponse(
          status: false, message: 'Please add Complainant Employee Id');
    }

    if (model.complainantDepartment == null && model.complainantDbEmp == true) {
      return const ErrorResponse(
          status: false, message: 'Please add Complainant Department');
    }
    if (model.complainant == null && model.complainantDbEmp == true) {
      return const ErrorResponse(
          status: false, message: 'Please add Complainant');
    }
    if (model.complainantHr == null) {
      return const ErrorResponse(
          status: false, message: 'Please add Complainant Manager');
    }
    if (model.incidentDate == null || model.incidentDate!.isEmpty) {
      return const ErrorResponse(
          status: false, message: 'Please add Incident Date and Time');
    }

    if (model.incidentManager == null) {
      return const ErrorResponse(
          status: false, message: 'Please add Incident Manager');
    }
    if (model.incidentOwner == null) {
      return const ErrorResponse(
          status: false, message: 'Please add Incident Owner');
    }

    if (model.description == null) {
      return const ErrorResponse(
          status: false, message: 'Please add Incident Description');
    }

    if (model.closureTargetDate == null) {
      return const ErrorResponse(
          status: false, message: 'Please add Target Date of Closure');
    }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  @override
  List<Object?> get props => [model, status];

  const IncidentGeneralInfoState({
    required this.status,
    required this.model,
    this.locations,
    this.users,
    this.emailUsers,
    this.listOfEntities,
    required this.departments,
    this.getEntitiesResponse,
    this.getArticleTypeResponse,
    this.participationDates,
    this.eventId,
    this.message,
    this.entrySecurities,
    this.loggedInUserDetails,
  });

  IncidentGeneralInfoState copyWith({
    FormStatus? status,
    Incident? model,
    GetLocations? locations,
    GetArticleType? articleType,
    User? loggedInUserDetails,
    List<BaseUser>? users,
    List<BaseUser>? emailUsers,
    List<Entity>? listOfEntities,
    List<Organisation>? departments,
    AddEntities? getEntitiesResponse,
    List<String>? participationDates,
    int? eventId,
    String? message,
    List<User>? entrySecurities,
  }) {
    return IncidentGeneralInfoState(
      status: status ?? this.status,
      model: model ?? this.model,
      locations: locations ?? this.locations,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      users: users ?? this.users,
      emailUsers: emailUsers ?? this.emailUsers,
      listOfEntities: listOfEntities ?? this.listOfEntities,
      departments: departments ?? this.departments,
      getEntitiesResponse: getEntitiesResponse ?? this.getEntitiesResponse,
      participationDates: participationDates ?? this.participationDates,
      eventId: eventId ?? this.eventId,
      message: message ?? this.message,
      entrySecurities: entrySecurities ?? this.entrySecurities,
    );
  }
}
