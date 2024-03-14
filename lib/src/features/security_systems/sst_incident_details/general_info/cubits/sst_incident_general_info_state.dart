part of 'sst_incident_general_info_cubit.dart';

class SstIncidentGeneralInfoState extends Equatable {
  final FormStatus status;
  final SstIncident model;
  final Locations? locations;
  final User? loggedInUserDetails;
  final List<BaseUser>? users;
  final List<BaseUser>? securityLeads;
  final List<BaseUser>? systemManagers;
  final List<BaseUser>? locationTeamUsers;
  final List<BaseUser>? securityManagers;
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
  final SSLAUiLabels? labels;

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
      securityLeads: asl,
      systemManagers: systemManager,
      locationTeamUsers: lt,
      securityManagers: lsm,
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
    if (model.systemSLA == null) {
      return const ErrorResponse(status: false, message: 'Please enter System');
    }
    if (model.vendor == null) {
      return const ErrorResponse(status: false, message: 'Please enter Vendor');
    }
    if (model.vendorPoc == null) {
      return const ErrorResponse(status: false, message: 'Please enter Vendor POC');
    }
    if (model.vendorPoc != null &&  !Validator.isValidEmail(model.vendorPoc)) {
      return const ErrorResponse(status: false, message: 'Please enter valid Vendor POC email');
    }
    if (model.escalation1Poc == null) {
      return const ErrorResponse(status: false, message: 'Please enter Escalation 1 POC');
    }
    if (model.escalation1Poc != null &&  !Validator.isValidEmail(model.escalation1Poc)) {
      return const ErrorResponse(status: false, message: 'Please enter valid Escalation 1 POC email');
    }
    if (model.escalation2Poc == null) {
      return const ErrorResponse(status: false, message: 'Please enter Escalation 2 POC');
    }
    if (model.escalation2Poc != null &&  !Validator.isValidEmail(model.escalation2Poc)) {
      return const ErrorResponse(status: false, message: 'Please enter valid Escalation 2 POC email');
    }
    if (model.escalation3Poc == null) {
      return const ErrorResponse(status: false, message: 'Please enter Escalation 3 POC');
    }
    if (model.escalation3Poc != null &&  !Validator.isValidEmail(model.escalation3Poc)) {
      return const ErrorResponse(status: false, message: 'Please enter valid Escalation 3 POC email');
    }
    if (model.systemManager == null) {
      return const ErrorResponse(status: false, message: 'Please enter System Manager');
    }
    if (model.lsm == null) {
      return const ErrorResponse(status: false, message: 'Please enter Security Manager');
    }
    if (model.asl == null) {
      return const ErrorResponse(status: false, message: 'Please enter Security Lead');
    }
    if (model.lt == null) {
      return const ErrorResponse(status: false, message: 'Please enter Location Team');
    }
    if (model.shortDescription == null) {
      return const ErrorResponse(status: false, message: 'Please enter Short Description of Incident');
    }
    if (model.detailDescription == null) {
      return const ErrorResponse(status: false, message: 'Please enter Detail Description');
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
    this.securityLeads,
    this.locationTeamUsers,
    this.securityManagers,
    this.labels,
  });

  SstIncidentGeneralInfoState copyWith({
    FormStatus? status,
    SstIncident? model,
    Locations? locations,
    User? loggedInUserDetails,
    List<BaseUser>? users,
    List<BaseUser>? securityLeads,
    List<BaseUser>? systemManagers,
    List<BaseUser>? locationTeamUsers,
    List<BaseUser>? securityManagers,
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
      securityManagers: securityManagers ?? this.securityManagers,
      systemManagers: systemManagers ?? this.systemManagers,
      uploadAttachments: uploadAttachments ?? this.uploadAttachments,
      securityLeads: securityLeads ?? this.securityLeads,
      vendors: vendors ?? this.vendors,
      getEntitiesResponse: getEntitiesResponse ?? this.getEntitiesResponse,
      participationDates: participationDates ?? this.participationDates,
      eventId: eventId ?? this.eventId,
      message: message ?? this.message,
      entrySecurities: entrySecurities ?? this.entrySecurities,
    );
  }
}
