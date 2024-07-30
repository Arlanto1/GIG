part of 'incident_general_info_cubit.dart';

class IncidentGeneralInfoState extends Equatable {
  final FormStatus status;
  final IncidentModel model;
  final Locations? locations;
  final User? loggedInUserDetails;
  final List<BaseUser>? complainant;
  final List<BaseUser>? complainantHr;
  final List<BaseUser>? incidentManager;
  final List<BaseUser>? incidentOwner;
  final List<BaseUser>? emailUsers;
  final List<Organisation>? listOfEntities;
  final List<Organisation> departments;
  final List<Organisation>? getEntitiesResponse;
  final List<Organisation> getArticleTypeResponse;
  final List<String>? participationDates;
  final int? eventId;
  final String? message;
  final List<User>? entrySecurities;
  final IMUiLabels? labels;

  factory IncidentGeneralInfoState.initial({
    required IncidentModel model,
    required Locations locations,
    required User? loggedInUserDetails,
    final List<BaseUser>? emailUsers,
    final List<BaseUser>? complainant,
    final List<BaseUser>? complainantHr,
    final List<BaseUser>? incidentManager,
    final List<BaseUser>? incidentOwner,
    required final List<Organisation>? listOfEntities,
    required final List<Organisation>? getEntitiesResponse,
    required final List<Organisation> getArticleTypeResponse,
    required final List<Organisation> departments,
    required String errorMessage,
    required List<ImageContent> loadAttachments,
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
      complainant: complainant,
      complainantHr: complainantHr,
      incidentManager: incidentManager,
      incidentOwner: incidentOwner,
      emailUsers: emailUsers,
      message: errorMessage,
      eventId: eventId,
      participationDates: participationDate,
      entrySecurities: entrySecurities,
    );
  }

  ErrorResponse get isValidDraft {
    if (model.location == null) {
      return const ErrorResponse(status: false, message: 'Please add Location');
    }
    if (model.slNo == null) {
      return const ErrorResponse(status: false, message: 'Please enter SL No.');
    }

    if (model.entrySecurity == null) {
      return const ErrorResponse(
          status: false, message: 'Created By is Mandatory.');
    }
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  ErrorResponse get isValid {
    log('---isValid--1--');
    if (model.status == null) {
      return const ErrorResponse(status: false, message: 'Please enter Status');
    }

    if (model.location == null) {
      return const ErrorResponse(status: false, message: 'Please add Location');
    }

    if (model.entities == null || model.entities!.isEmpty) {
      return const ErrorResponse(status: false, message: 'Please add Entities');
    }
    // if (model.incidentType == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please add Incident Type');
    // }

    if ((model.incidentType == 0 || model.incidentType == 1) &&
        model.typeOfAsset == null) {
      return const ErrorResponse(
          status: false, message: 'Please add Asset Type');
    }
    if ((model.incidentType == 0 || model.incidentType == 1) &&
        model.color == null) {
      return const ErrorResponse(
          status: false, message: 'Please add Colour/Make/Model');
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
    if (model.complainantDbEmp == true && model.employeeId == null) {
      return const ErrorResponse(
          status: false, message: 'Please add Complainant Employee Id');
    }

    if (model.complainantDepartment == null && model.complainantDbEmp == true) {
      return const ErrorResponse(
          status: false, message: 'Please add Complainant Department');
    }
    // if (model.typeOfArticle == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please Article Type');
    // }
    if (model.complainantHr == null) {
      return const ErrorResponse(
          status: false, message: 'Please add Complainant Manager');
    }
    if (model.incidentDate == null || model.incidentDate!.isEmpty) {
      return const ErrorResponse(
          status: false, message: 'Please add Incident Date and Time');
    }

    if (model.incidentLocation == null) {
      return const ErrorResponse(
          status: false, message: 'Please add Incident Location');
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
    this.emailUsers,
    this.complainant,
    this.complainantHr,
    this.incidentManager,
    this.incidentOwner,
    this.listOfEntities,
    required this.departments,
    this.getEntitiesResponse,
    required this.getArticleTypeResponse,
    this.participationDates,
    this.eventId,
    this.message,
    this.entrySecurities,
    this.loggedInUserDetails,
    this.labels,
  });

  IncidentGeneralInfoState copyWith({
    FormStatus? status,
    IncidentModel? model,
    Locations? locations,
    List<Organisation>? articleType,
    User? loggedInUserDetails,
    List<BaseUser>? emailUsers,
    List<BaseUser>? complainant,
    List<BaseUser>? complainantHr,
    List<BaseUser>? incidentManager,
    List<BaseUser>? incidentOwner,
    List<Organisation>? listOfEntities,
    List<Organisation>? departments,
    List<Organisation>? getEntitiesResponse,
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
      incidentManager: incidentManager ?? this.incidentManager,
      complainant: complainant ?? this.complainant,
      complainantHr: complainantHr ?? this.complainantHr,
      incidentOwner: incidentOwner ?? this.incidentOwner,
      emailUsers: emailUsers ?? this.emailUsers,
      listOfEntities: listOfEntities ?? this.listOfEntities,
      departments: departments ?? this.departments,
      getArticleTypeResponse: articleType ?? getArticleTypeResponse,
      getEntitiesResponse: getEntitiesResponse ?? this.getEntitiesResponse,
      participationDates: participationDates ?? this.participationDates,
      eventId: eventId ?? this.eventId,
      message: message ?? this.message,
      entrySecurities: entrySecurities ?? this.entrySecurities,
    );
  }
}
