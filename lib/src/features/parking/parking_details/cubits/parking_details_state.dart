part of 'parking_details_cubit.dart';

class ParkingDetailsState extends Equatable {
  final FormStatus status;
  final ParkingModel model;
  final Locations? locations;
  final User? loggedInUserDetails;
  final List<BaseUser>? complainant;
  final List<Organisation>? listOfEntities;
  final List<Organisation> departments;
  final int? eventId;
  final String? message;
  final List<User>? entrySecurities;
  final GetLocationType  getLocationType;

  factory ParkingDetailsState.initial({
    required ParkingModel model,
    required Locations locations,
    required User? loggedInUserDetails,
    final List<BaseUser>? emailUsers,
    final List<BaseUser>? complainant,
    required final List<Organisation>? listOfEntities,
    required final List<Organisation> departments,
    required String errorMessage,
    List<User>? entrySecurities,
    required int? eventId,
    required GetLocationType getLocationType,

  }) {
    return ParkingDetailsState(
      status: FormStatus.initial,
      model: model,
      locations: locations,
      listOfEntities: listOfEntities,
      departments: departments,
      complainant: complainant,
      eventId: eventId,
      entrySecurities: entrySecurities,
      getLocationType:getLocationType,

    );
  }

  ErrorResponse get isValidDraft {
    if (model.location == null) {
      return const ErrorResponse(status: false, message: 'Please add Location');
    }

    if (model.entrySecurity == null) {
      return const ErrorResponse(
          status: false, message: 'Created By is Mandatory.');
    }
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  ErrorResponse get isValid {

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  @override
  List<Object?> get props => [model, status];

  const ParkingDetailsState({
    required this.status,
    required this.model,
    this.locations,
    this.complainant,
    this.listOfEntities,
    required this.departments,
    this.eventId,
    this.message,
    this.entrySecurities,
    this.loggedInUserDetails,
    required this.getLocationType,

  });

  ParkingDetailsState copyWith({
    FormStatus? status,
    ParkingModel? model,
    Locations? locations,
    User? loggedInUserDetails,
    List<BaseUser>? complainant,
    List<Organisation>? listOfEntities,
    List<Organisation>? departments,
    int? eventId,
    String? message,
    GetLocationType? getLocationType,

  }) {
    return ParkingDetailsState(
      status: status ?? this.status,
      model: model ?? this.model,
      locations: locations ?? this.locations,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      complainant: complainant ?? this.complainant,
      listOfEntities: listOfEntities ?? this.listOfEntities,
      departments: departments ?? this.departments,
      eventId: eventId ?? this.eventId,
      message: message ?? this.message,
      getLocationType:getLocationType??this.getLocationType,
    );
  }
}
