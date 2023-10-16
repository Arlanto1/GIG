part of 'general_info_cubit.dart';

class GeneralInfoState extends Equatable {
  final FormStatus status;
  final EventProtectionGi model;
  final GetLocations? locations;
  final User? loggedInUserDetails;
  final List<BaseUser>? users;
  final List<BaseUser>? emailUsers;
  final List<Entity>? listOfEntities;
  final List<Organisation> departments;
  final List<Organisation> proposedVendors;
  final AddEntities? getEntitiesResponse;
  final List<String>? participationDates;
  final int? eventId;
  final String? message;
  final List<User>? entrySecurities;

  factory GeneralInfoState.initial({
    required EventProtectionGi model,
    required GetLocations locations,
    required List<BaseUser>? users,
    required User? loggedInUserDetails,
    final List<BaseUser>? emailUsers,
    required final List<Entity>? listOfEntities,
    required final AddEntities? getEntitiesResponse,
    required final List<Organisation> departments,
    required final List<Organisation> proposedVendors,
    required String errorMessage,
    required List<CreateImage> loadAttachments,
    List<User>? entrySecurities,
    required int? eventId,
    List<String>? participationDate,
  }) {
    return GeneralInfoState(
      status: FormStatus.initial,
      model: model,
      locations: locations,
      listOfEntities: listOfEntities,
      departments: departments,
      proposedVendors: proposedVendors,
      getEntitiesResponse: getEntitiesResponse,
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
    if (model.entities == null || model.entities!.isEmpty) {
      return const ErrorResponse(status: false, message: 'Please add Entities');
    }

    if (model.eventStartDate == null) {
      return const ErrorResponse(status: false, message: 'Please enter Event Start Date');
    }

    if (model.eventEndDate == null) {
      return const ErrorResponse(status: false, message: 'Please enter Event End Date');
    }

    if (model.lsm1 == null) {
      return const ErrorResponse(
          status: false, message: 'Event Location Security Manager 1');
    }

    if (model.lsm2 == null) {
      return const ErrorResponse(
          status: false, message: 'Event Location Security Manager 2');
    }

    if (model.bu1 == null) {
      return const ErrorResponse(
          status: false, message: 'Enter Event Business POC 1');
    }

    if (model.bu2 == null) {
      return const ErrorResponse(
          status: false, message: 'Enter Event Business POC 2');
    }

    if (model.requesterDepartment == null) {
      return const ErrorResponse(
          status: false, message: 'Enter Requester Department');
    }


    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  @override
  List<Object?> get props => [model, status];

  const GeneralInfoState({
    required this.status,
    required this.model,
    this.locations,
    this.users,
    this.emailUsers,
    this.listOfEntities,
    required this.departments,
    required this.proposedVendors,
    this.getEntitiesResponse,
    this.participationDates,
    this.eventId,
    this.message,
    this.entrySecurities,
    this.loggedInUserDetails,
  });

  GeneralInfoState copyWith({
    FormStatus? status,
    EventProtectionGi? model,
    GetLocations? locations,
    User? loggedInUserDetails,
    List<BaseUser>? users,
    List<BaseUser>? emailUsers,
    List<Entity>? listOfEntities,
    List<Organisation>? departments,
    List<Organisation>? proposedVendors,
    AddEntities? getEntitiesResponse,
    List<String>? participationDates,
    int? eventId,
    String? message,
    List<User>? entrySecurities,
  }) {
    return GeneralInfoState(
      status: status ?? this.status,
      model: model ?? this.model,
      locations: locations ?? this.locations,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      users: users ?? this.users,
      emailUsers: emailUsers ?? this.emailUsers,
      listOfEntities: listOfEntities ?? this.listOfEntities,
      departments: departments ?? this.departments,
      proposedVendors: proposedVendors?? this.proposedVendors,
      getEntitiesResponse: getEntitiesResponse ?? this.getEntitiesResponse,
      participationDates: participationDates ?? this.participationDates,
      eventId: eventId ?? this.eventId,
      message: message ?? this.message,
      entrySecurities: entrySecurities ?? this.entrySecurities,
    );
  }
}
