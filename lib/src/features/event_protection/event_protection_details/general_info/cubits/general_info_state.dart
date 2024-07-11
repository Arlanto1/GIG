part of 'general_info_cubit.dart';

class GeneralInfoState extends Equatable {
  final FormStatus status;
  final EventProtectionGi model;
  final Locations? locations;
  final User? loggedInUserDetails;
  final List<BaseUser>? users;
  final List<BaseUser>? epm;
  final List<BaseUser>? lsm;
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
  final EpUiLabels? labels;

  factory GeneralInfoState.initial({
    required EventProtectionGi model,
    required Locations locations,
    required List<BaseUser>? users,
    required User? loggedInUserDetails,
    final List<BaseUser>? emailUsers,
    final List<BaseUser>? epm,
    final List<BaseUser>? lsm,
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
    return GeneralInfoState(
      status: FormStatus.initial,
      model: model,
      locations: locations,
      listOfEntities: listOfEntities,
      departments: departments,
      vendors: vendors,
      getEntitiesResponse: getEntitiesResponse,
      epm: epm,
      lsm: lsm,
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

    // if (model.handOverSecurity == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Shift Taken Over By.');
    // }
    // if (model.medicalEmrgncy && model.medicalEmrgncyComments == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Medical Emergency Comments');
    // }

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
    if (model.epManager1 == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Event Protection Manager 1');
    }
    if (model.epManager2 == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Event Protection Manager 2');
    }

    if (model.lsm1 == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Location Security Manager 1');
    }
    if (model.lsm1ContactNo == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter LSM 1 Contact No');
    }

    if (!model.lsm1ContactNo.isEmptyOrNull &&
        (!Utils().isNumeric(model.lsm1ContactNo!) ||
            model.lsm1ContactNo!.length > 17 ||
            model.lsm1ContactNo!.length < 10)) {
      return const ErrorResponse(
        status: false,
        message: 'Please enter a valid LSM 1 Contact No',
      );
    }
    if (model.lsm2 == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Location Security Manager 2');
    }

    if (model.lsm2ContactNo == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter LSM 2 Contact No');
    }

    if (!model.lsm2ContactNo.isEmptyOrNull &&
        (!Utils().isNumeric(model.lsm2ContactNo!) ||
            model.lsm2ContactNo!.length > 17 ||
            model.lsm2ContactNo!.length < 10)) {
      return const ErrorResponse(
        status: false,
        message: 'Please enter a valid LSM 2 Contact No',
      );
    }
    if (model.bu1 == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Business POC');
    }

    if (model.bu1ContactNo == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Business POC Contact No');
    }

    if (!model.bu1ContactNo.isEmptyOrNull &&
        (!Utils().isNumeric(model.bu1ContactNo!) ||
            model.bu1ContactNo!.length > 17 ||
            model.bu1ContactNo!.length < 10)) {
      return const ErrorResponse(
        status: false,
        message: 'Please enter a valid Business POC Contact No',
      );
    }
    if (model.bu2 == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Business POC Escalation');
    }

    if (model.bu2ContactNo == null) {
      return const ErrorResponse(
          status: false,
          message: 'Please enter Business POC Escalation Contact No');
    }

    if (!model.bu2ContactNo.isEmptyOrNull &&
        (!Utils().isNumeric(model.bu2ContactNo!) ||
            model.bu2ContactNo!.length > 17 ||
            model.bu2ContactNo!.length < 10)) {
      return const ErrorResponse(
        status: false,
        message: 'Please enter a valid Business POC Escalation Contact No',
      );
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
    this.epm,
    this.lsm,
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
    this.labels,
  });

  GeneralInfoState copyWith({
    FormStatus? status,
    EventProtectionGi? model,
    Locations? locations,
    User? loggedInUserDetails,
    List<BaseUser>? users,
    List<BaseUser>? epm,
    List<BaseUser>? lsm,
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
    final EpUiLabels? labels,
  }) {
    return GeneralInfoState(
      status: status ?? this.status,
      model: model ?? this.model,
      locations: locations ?? this.locations,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      users: users ?? this.users,
      epm: epm ?? this.epm,
      lsm: lsm ?? this.lsm,
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
      labels: labels ?? this.labels,
    );
  }
}
