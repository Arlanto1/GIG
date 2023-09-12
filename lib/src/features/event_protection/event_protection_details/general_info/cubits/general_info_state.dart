part of 'general_info_cubit.dart';

class GeneralInfoState extends Equatable {
  final FormStatus status;
  final GiModel model;
  final GetLocations? locations;
  final EntrySecurity? loggedInUserDetails;
  final List<BaseUser>? users;
  final List<BaseUser>? emailUsers;
  final List<Entity>? listOfEntities;
  final List<Department> departments;
  final AddEntities? getEntitiesResponse;
  final List<String>? participationDates;
  final int? eventId;
  final String? message;
  final List<GetUserDetails>? entrySecurities;

  factory GeneralInfoState.initial({
    required GiModel model,
    required GetLocations locations,
    required List<BaseUser>? users,
    required EntrySecurity? loggedInUserDetails,
    final List<BaseUser>? emailUsers,
    required final List<Entity>? listOfEntities,
    required final AddEntities? getEntitiesResponse,
    required final List<Department> departments,
    required String errorMessage,
    required List<CreateImage> loadAttachments,
    List<GetUserDetails>? entrySecurities,
    required int? eventId,
    List<String>? participationDate,
  }) {
    return GeneralInfoState(
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

  ErrorResponse get isValid {
    if (model.status == null) {
      return const ErrorResponse(status: false, message: 'Please enter Status');
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
    this.getEntitiesResponse,
    this.participationDates,
    this.eventId,
    this.message,
    this.entrySecurities,
    this.loggedInUserDetails,
  });

  GeneralInfoState copyWith({
    FormStatus? status,
    GiModel? model,
    GetLocations? locations,
    EntrySecurity? loggedInUserDetails,
    List<BaseUser>? users,
    List<BaseUser>? emailUsers,
    List<Entity>? listOfEntities,
    List<Department>? departments,
    AddEntities? getEntitiesResponse,
    List<String>? participationDates,
    int? eventId,
    String? message,
    List<GetUserDetails>? entrySecurities,
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
      getEntitiesResponse: getEntitiesResponse ?? this.getEntitiesResponse,
      participationDates: participationDates ?? this.participationDates,
      eventId: eventId ?? this.eventId,
      message: message ?? this.message,
      entrySecurities: entrySecurities ?? this.entrySecurities,
    );
  }
}
