part of 'occurrence_general_info_cubit.dart';

class OccurrenceGeneralInfoState extends Equatable {
  final FormStatus status;
  final OccurrenceModel model;
  final Locations? locations;
  final User? loggedInUserDetails;
  final List<BaseUser>? users;
  final List<BaseUser>? shiftTakenOverBy;
  final List<Organisation>? listOfEntities;
  final List<Organisation> departments;
  final List<PowerFailureModel>? participationDates;
  final int? eventId;
  final String? message;
  final List<User>? entrySecurities;
  final bool? isReadOnly;
  final OCCUiLabels? labels;
  final bool? isOnGoingPowerFailure;
  final List<Organisation>? dutyPosts;
  final List<Organisation>? ipadSerialNum;


      factory OccurrenceGeneralInfoState.initial({
    required OccurrenceModel model,
    required Locations locations,
    required List<BaseUser>? users,
    required User? loggedInUserDetails,
    final List<BaseUser>? shiftTakenOverBy,
    required final List<Organisation> departments,
    required String errorMessage,
    required List<ImageContent> loadAttachments,
    List<User>? entrySecurities,
    required int? eventId,
    List<PowerFailureModel>? participationDate,
    required final List<Organisation>? ipadSerialNum,
  }) {
    return OccurrenceGeneralInfoState(
      status: FormStatus.initial,
      model: model,
      locations: locations,
      departments: departments,
      users: users,
      shiftTakenOverBy: shiftTakenOverBy,
      message: errorMessage,
      eventId: eventId,
      participationDates: participationDate,
      entrySecurities: entrySecurities,
      ipadSerialNum:ipadSerialNum,
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
    // if (model.handoverSecurity == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Shift Taken Over By.');
    // }
    if (model.medicalEmrgncy && model.medicalEmrgncyComments == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Medical Emergency Comments');
    }

    if (model.handoverSecurity != null && model.entrySecurity !=null && (model.entrySecurity?.email == model.handoverSecurity?.email)) {
      return const ErrorResponse(
          status: false, message: 'Please select other user, this user is already selected in Shift Handover By');
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

    if (model.premisesRoundTkn &&
        model.premisesRoundTknComments.isEmptyOrNull) {
      return const ErrorResponse(
          status: false, message: 'Please enter Premises Round Taken Comments');
    }

    if (model.medicalEmrgncy && model.medicalEmrgncyComments.isEmptyOrNull) {
      return const ErrorResponse(
          status: false, message: 'Please enter Medical Emergency Comments');
    }

    if (model.socialEnggIncdnt &&
        model.socialEnggIncdntComments.isEmptyOrNull) {
      return const ErrorResponse(
          status: false,
          message: 'Please enter Social Engineering Incidents Comments');
    }

    if (model.infraIssue == true && model.infraIssueComments.isEmptyOrNull) {
      return const ErrorResponse(
          status: false,
          message: 'Please enter Any Infrastructural Issue Comments');
    }

    if (model.fireAlarmEmrgncy &&
        model.fireAlarmEmrgncyComments.isEmptyOrNull) {
      return const ErrorResponse(
          status: false,
          message: 'Please enter Fire alarm emergency Occurred Comments');
    }

    log('model.landlordIssue---- ${model.landlordIssue}');
    log('model.landlordIssueComments---- ${model.landlordIssueComments}');
    if (model.landlordIssue && model.landlordIssueComments.isEmptyOrNull) {
      return const ErrorResponse(
          status: false, message: 'Please enter Landlord Issue Comments');
    }

    if (model.sysAlarmRcvd && model.sysAlarmRcvdComments.isEmptyOrNull) {
      return const ErrorResponse(
          status: false,
          message: 'Please enter Any system alarm received Comments');
    }

    if (model.transportIncdnt && model.transportIncdntComments.isEmptyOrNull) {
      return const ErrorResponse(
          status: false, message: 'Please enter Transport Incident Comments');
    }

    if (model.anyEvent && model.notifyScri.isEmptyOrNull) {
      return const ErrorResponse(
          status: false, message: 'Notify SCRI is Mandatory');
    }
    if (model.powerFailure && model.powerFailures.isEmptyOrNull) {
      return const ErrorResponse(
          status: false, message: 'Please add Power Failure Dates');
    }

    if (model.comments.isEmptyOrNull) {
      return const ErrorResponse(
          status: false,
          message: 'Please enter Follow Up Actions For Next Shift');
    }

    if (model.handoverSecurity != null && model.entrySecurity !=null && (model.entrySecurity?.email == model.handoverSecurity?.email)) {
      return const ErrorResponse(
          status: false, message: 'Please select other user, this user is already selected in Shift Handover By');
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
    this.shiftTakenOverBy,
    this.listOfEntities,
    required this.departments,
    this.participationDates,
    this.eventId,
    this.message,
    this.entrySecurities,
    this.loggedInUserDetails,
    this.isReadOnly,
    this.labels,
    this.isOnGoingPowerFailure,
    this.dutyPosts,
    this.ipadSerialNum,
  });

  OccurrenceGeneralInfoState copyWith({
    FormStatus? status,
    OccurrenceModel? model,
    Locations? locations,
    User? loggedInUserDetails,
    List<BaseUser>? users,
    List<BaseUser>? shiftTakenOverBy,
    List<Organisation>? departments,
    List<Organisation>? ipadSerialNum,
    List<PowerFailureModel>? participationDates,
    int? eventId,
    String? message,
    List<User>? entrySecurities,
    bool? isReadOnly,
    bool? isOnGoingPowerFailure,
    List<Organisation>? dutyPosts,
  }) {
    return OccurrenceGeneralInfoState(
      status: status ?? this.status,
      model: model ?? this.model,
      locations: locations ?? this.locations,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      users: users ?? this.users,
      shiftTakenOverBy: shiftTakenOverBy ?? this.shiftTakenOverBy,
      listOfEntities: listOfEntities ?? listOfEntities,
      departments: departments ?? this.departments,
      participationDates: participationDates ?? this.participationDates,
      eventId: eventId ?? this.eventId,
      message: message ?? this.message,
      entrySecurities: entrySecurities ?? this.entrySecurities,
      isReadOnly: isReadOnly ?? this.isReadOnly,
      isOnGoingPowerFailure:
          isOnGoingPowerFailure ?? this.isOnGoingPowerFailure,
      dutyPosts: dutyPosts ?? this.dutyPosts,
        ipadSerialNum:ipadSerialNum??this.ipadSerialNum,
    );
  }
}
