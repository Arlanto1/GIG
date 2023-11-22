part of 'occurrence_general_info_cubit.dart';

class OccurrenceGeneralInfoState extends Equatable {
  final FormStatus status;
  final OccurrenceModel model;
  final Locations? locations;
  final User? loggedInUserDetails;
  final List<BaseUser>? users;
  final List<BaseUser>? emailUsers;
  final List<Organisation>? listOfEntities;
  final List<Organisation> departments;
  final AddEntities? getEntitiesResponse;
  final List<String>? participationDates;
  final int? eventId;
  final String? message;
  final List<User>? entrySecurities;

  factory OccurrenceGeneralInfoState.initial({
    required OccurrenceModel model,
    required Locations locations,
    required List<BaseUser>? users,
    required User? loggedInUserDetails,
    final List<BaseUser>? emailUsers,
    required final List<Organisation>? listOfEntities,
    required final AddEntities? getEntitiesResponse,
    required final List<Organisation> departments,
    required String errorMessage,
    required List<ImageContent> loadAttachments,
    List<User>? entrySecurities,
    required int? eventId,
    List<String>? participationDate,
  }) {
    return OccurrenceGeneralInfoState(
      status: FormStatus.initial,
      model: model,
      locations: locations,
      listOfEntities: listOfEntities,
      departments: departments,
      getEntitiesResponse: getEntitiesResponse,
      users: users,
      emailUsers: emailUsers,
      message: errorMessage,
      eventId: eventId,
      participationDates: participationDate,
      entrySecurities: entrySecurities,
    );
  }

  ErrorResponse get isValidDraft {
    log('-model.status---${model.status}--');

    if (model.location == null) {
      log('-model.location-----isValidDraft-');
      return const ErrorResponse(
          status: false, message: 'Please enter Location');
    }
    if (model.status == null) {
      return const ErrorResponse(status: false, message: 'Please enter Status');
    }

    if (model.handoverSecurity == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Shift Taken Over By.');
    }
    if (model.medicalEmrgncy && model.medicalEmrgncyComments == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Medical Emergency Comments');
    }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  ErrorResponse get isValid {
    if (model.location == null) {
      log('-model.location-----isValid-');
      return const ErrorResponse(
          status: false, message: 'Please enter Location');
    }
    if (model.status == null) {
      return const ErrorResponse(status: false, message: 'Please enter Status');
    }

    if (model.handoverSecurity == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Shift Taken Over By.');
    }

    if (model.medicalEmrgncy && model.medicalEmrgncyComments == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Medical Emergency Comments');
    }

    if (model.socialEnggIncdnt && model.socialEnggIncdntComments == null) {
      return const ErrorResponse(
          status: false,
          message: 'Please enter Social Engineering Incidents Comments');
    }

    if (model.infraIssue && model.infraIssueComments == null) {
      return const ErrorResponse(
          status: false,
          message: 'Please enter Any Infrastructural Issue Comments');
    }

    if (model.fireAlarmEmrgncy && model.fireAlarmEmrgncyComments == null) {
      return const ErrorResponse(
          status: false,
          message: 'Please enter Fire alarm emergency Occurred Comments');
    }

    if (model.landlordIssue && model.landlordIssueComments == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Landlord Issue Comments');
    }

    if (model.sysAlarmRcvd && model.sysAlarmRcvdComments == null) {
      return const ErrorResponse(
          status: false,
          message: 'Please enter Any system alarm received Comments');
    }

    if (model.transportIncdnt && model.transportIncdntComments == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Transport Incident Comments');
    }

    if (model.anyEvent && model.notifyScri == null) {
      return const ErrorResponse(
          status: false, message: 'Notify SCRI is Mandatory');
    }

    if (model.powerFailure && model.powerFailureStartDate == null) {
      return const ErrorResponse(
          status: false, message: 'Power Failure Start Date is Mandatory');
    }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  @override
  List<Object?> get props => [model, status];

  const OccurrenceGeneralInfoState({
    required this.status,
    required this.model,
    this.locations,
    this.users,
    this.emailUsers,
    this.listOfEntities,
    required this.departments,
    this.getEntitiesResponse,
    this.participationDates,
    this.eventId,
    this.message,
    this.entrySecurities,
    this.loggedInUserDetails,
  });

  OccurrenceGeneralInfoState copyWith({
    FormStatus? status,
    OccurrenceModel? model,
    Locations? locations,
    User? loggedInUserDetails,
    List<BaseUser>? users,
    List<BaseUser>? emailUsers,
    List<Organisation>? listOfEntities,
    List<Organisation>? departments,
    AddEntities? getEntitiesResponse,
    List<String>? participationDates,
    int? eventId,
    String? message,
    List<User>? entrySecurities,
  }) {
    return OccurrenceGeneralInfoState(
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
