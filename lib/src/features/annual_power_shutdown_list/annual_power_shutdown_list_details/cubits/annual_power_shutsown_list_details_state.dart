part of 'annual_power_shutdown_list_details_cubit.dart';

class AnnualPowerShutdownListDetailsState extends Equatable {
  final FormStatus status;
  final AnnualPowerShutdownListModel model;
  final Locations? locations;
  final User? loggedInUserDetails;
  final List<BaseUser>? users;
  final List<BaseUser>? emailUsers;
  final List<BaseUser>? epOfficers;
  final List<Organisation>? listOfEntities;
  final List<Organisation> departments;
  final List<Organisation> vendors;
  final List<Organisation>? getEntitiesResponse;
  final List<String>? participationDates;
  final int? eventId;
  final String? message;
  final List<User>? entrySecurities;
  final BudgetCostModel? budgetCost;

  //final EpUiLabels? labels;

  factory AnnualPowerShutdownListDetailsState.initial({
    required AnnualPowerShutdownListModel model,
    required Locations locations,
    required List<BaseUser>? users,
    required User? loggedInUserDetails,
    final List<BaseUser>? emailUsers,
    final List<BaseUser>? epOfficers,
    required final List<Organisation>? listOfEntities,
    required final List<Organisation>? getEntitiesResponse,
    required final List<Organisation> departments,
    required final List<Organisation> vendors,
    required String errorMessage,
    required List<ImageContent> loadAttachments,
    List<User>? entrySecurities,
    required int? eventId,
    List<String>? participationDate,
  }) {
    return AnnualPowerShutdownListDetailsState(
      status: FormStatus.initial,
      model: model,
      locations: locations,
      listOfEntities: listOfEntities,
      departments: departments,
      vendors: vendors,
      getEntitiesResponse: getEntitiesResponse,
      users: users,
      emailUsers: emailUsers,
      epOfficers: epOfficers,
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

    if (model.createdBy == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Created By.');
    }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  ErrorResponse get isValid {
    if (model.status == null) {
      return const ErrorResponse(status: false, message: 'Please enter Status');
    }
    if (model.entities == null || model.entities!.isEmpty) {
      return const ErrorResponse(status: false, message: 'Please add Entities');
    }

    if (model.eventStartDate == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Event Start Date');
    }

    if (model.eventEndDate == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Event End Date');
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

  const AnnualPowerShutdownListDetailsState({
    required this.status,
    required this.model,
    this.locations,
    this.users,
    this.emailUsers,
    this.epOfficers,
    this.listOfEntities,
    required this.departments,
    required this.vendors,
    this.getEntitiesResponse,
    this.participationDates,
    this.eventId,
    this.message,
    this.entrySecurities,
    this.loggedInUserDetails,
    this.budgetCost,
    //this.labels,
  });

  AnnualPowerShutdownListDetailsState copyWith({
    FormStatus? status,
    AnnualPowerShutdownListModel? model,
    Locations? locations,
    User? loggedInUserDetails,
    List<BaseUser>? users,
    List<BaseUser>? emailUsers,
    List<BaseUser>? epOfficers,
    List<Organisation>? listOfEntities,
    List<Organisation>? departments,
    List<Organisation>? vendors,
    List<Organisation>? getEntitiesResponse,
    List<String>? participationDates,
    int? eventId,
    String? message,
    List<User>? entrySecurities,
    BudgetCostModel? budgetCost,
    // final EpUiLabels? labels,
  }) {
    return AnnualPowerShutdownListDetailsState(
      status: status ?? this.status,
      model: model ?? this.model,
      locations: locations ?? this.locations,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      users: users ?? this.users,
      emailUsers: emailUsers ?? this.emailUsers,
      epOfficers: epOfficers ?? this.epOfficers,
      listOfEntities: listOfEntities ?? this.listOfEntities,
      departments: departments ?? this.departments,
      vendors: vendors ?? this.vendors,
      getEntitiesResponse: getEntitiesResponse ?? this.getEntitiesResponse,
      participationDates: participationDates ?? this.participationDates,
      eventId: eventId ?? this.eventId,
      message: message ?? this.message,
      entrySecurities: entrySecurities ?? this.entrySecurities,
      budgetCost: budgetCost ?? this.budgetCost,
      //labels: labels ?? this.labels,
    );
  }
}
