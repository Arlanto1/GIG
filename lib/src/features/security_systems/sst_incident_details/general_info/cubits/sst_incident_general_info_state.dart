part of 'sst_incident_general_info_cubit.dart';

class SstIncidentGeneralInfoState extends Equatable {
  final FormStatus status;
  final SstIncident model;
  final Locations? locations;
  final User? loggedInUserDetails;
  final List<BaseUser>? users;
  final List<BaseUser>? asl;
  final List<BaseUser>? systemManagers;
  final List<BaseUser>? locationTeamUsers;
  final List<BaseUser>? lsms;
  final List<BaseUser>? emailUsers;
  final List<Organisation>? listOfEntities;
  final List<ImageContent>? uploadAttachments;
  //final List<Organisation> departments;
  final List<Organisation> vendors;
  final List<Organisation>? getEntitiesResponse;
  final List<String>? participationDates;
  final int? eventId;
  final String? message;
  final List<User>? entrySecurities;

  factory SstIncidentGeneralInfoState.initial({
    required SstIncident model,
    required Locations locations,
    required List<BaseUser>? users,
    required User? loggedInUserDetails,
    final List<BaseUser>? emailUsers,
    List<BaseUser>? asl,
    List<BaseUser>? systemManager,
    List<BaseUser>? lt,
    List<BaseUser>? lsm,
    required final List<Organisation>? listOfEntities,
    required final List<Organisation>? getEntitiesResponse,
     List<ImageContent>? uploadAttachments,
    required final List<Organisation> vendors,
    required String errorMessage,
    required List<ImageContent> loadAttachments,
    List<User>? entrySecurities,
    required int? eventId,
    List<String>? participationDate,
  }) {
    return SstIncidentGeneralInfoState(
      status: FormStatus.initial,
      model: model,
      locations: locations,
      listOfEntities: listOfEntities,
      asl: asl,
      systemManagers: systemManager,
      locationTeamUsers: lt,
      lsms: lsm,
      vendors: vendors,
      getEntitiesResponse: getEntitiesResponse,
      uploadAttachments:uploadAttachments,
      users: users,
      emailUsers: emailUsers,
      message: errorMessage,
      eventId: eventId,
      participationDates: participationDate,
      entrySecurities: entrySecurities,
    );
  }

  ErrorResponse get isValid {
    if (model.status == null) {
      return const ErrorResponse(status: false, message: 'Please enter Status');
    }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  @override
  List<Object?> get props => [model, status];

  const SstIncidentGeneralInfoState({
    required this.status,
    required this.model,
    this.locations,
    this.users,
    this.emailUsers,
    this.listOfEntities,
    this.uploadAttachments,
    required this.vendors,
    this.getEntitiesResponse,
    this.participationDates,
    this.eventId,
    this.message,
    this.entrySecurities,
    this.loggedInUserDetails,
    this.systemManagers,
    this.asl,
    this.locationTeamUsers,
    this.lsms,
  });

  SstIncidentGeneralInfoState copyWith({
    FormStatus? status,
    SstIncident? model,
    Locations? locations,
    User? loggedInUserDetails,
    List<BaseUser>? users,
    List<BaseUser>? asl,
    List<BaseUser>? systemManagers,
    List<BaseUser>? locationTeamUsers,
    List<BaseUser>? lsms,
    List<BaseUser>? emailUsers,
    List<Organisation>? listOfEntities,
    List<Organisation>? departments,
    List<Organisation>? vendors,
    List<Organisation>? getEntitiesResponse,
    List<String>? participationDates,
    List<ImageContent>? uploadAttachments,
    int? eventId,
    String? message,
    List<User>? entrySecurities,
  }) {
    return SstIncidentGeneralInfoState(
      status: status ?? this.status,
      model: model ?? this.model,
      locations: locations ?? this.locations,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      users: users ?? this.users,
      emailUsers: emailUsers ?? this.emailUsers,
      listOfEntities: listOfEntities ?? this.listOfEntities,
      locationTeamUsers: locationTeamUsers ?? this.locationTeamUsers,
      lsms: lsms ?? this.lsms,
      systemManagers: systemManagers ?? this.systemManagers,
      uploadAttachments: uploadAttachments ?? this.uploadAttachments,
      asl: asl ?? this.asl,
      vendors: vendors ?? this.vendors,
      getEntitiesResponse: getEntitiesResponse ?? this.getEntitiesResponse,
      participationDates: participationDates ?? this.participationDates,
      eventId: eventId ?? this.eventId,
      message: message ?? this.message,
      entrySecurities: entrySecurities ?? this.entrySecurities,
    );
  }
}
