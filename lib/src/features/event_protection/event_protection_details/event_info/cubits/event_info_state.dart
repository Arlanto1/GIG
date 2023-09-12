part of 'event_info_cubit.dart';

class EventInfoState extends Equatable {
  final FormStatus status;
  final EventProtectionModel model;
  final GetLocations? locations;
  final EntrySecurity? loggedInUserDetails;
  final List<BaseUser>? users;
  final List<BaseUser>? emailUsers;
  final List<CreateImage>? loadAttachments;

  final List<String>? additionalEmails;
  final int? eventId;
  final String? message;

  factory EventInfoState.initial({
    required EventProtectionModel model,
    required GetLocations locations,
    required EntrySecurity loggedInUserDetails,
    required List<BaseUser>? users,
    final List<BaseUser>? emailUsers,
    required final List<Entity>? listOfEntities,
    required final List<Entity>? listOfQualifications,
    required final AddEntities? getEntitiesResponse,
    required final AddQualifications? getQualificationsResponse,
    required final List<Department> departments,
    required String errorMessage,
    required List<CreateImage> loadAttachments,
    List<CreateImage>? bioDataAttachments,
    List<CreateImage>? guardAttachments,
    List<CreateImage>? deploymentAttachments,
    List<CreateImage>? permanentAddressAttachments,
    List<CreateImage>? localAddressAttachments,
    List<CreateImage>? pVCAttachments,
    List<CreateImage>? trainingAttachments,
    List<CreateImage>? mSGBAttachments,
    List<CreateImage>? medicalAttachments,
    List<GetUserDetails>? entrySecurities,
    required int? eventId,
    List<String>? additionalEmails,
  }) {
    return EventInfoState(
      status: FormStatus.initial,
      model: model,
      locations: locations,
      loggedInUserDetails: loggedInUserDetails,
      users: users,
      emailUsers: emailUsers,
      message: errorMessage,
      loadAttachments: loadAttachments,
      eventId: eventId,
      additionalEmails: additionalEmails,
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

  const EventInfoState({
    required this.status,
    required this.model,
    this.locations,
    this.loggedInUserDetails,
    this.users,
    this.emailUsers,
    this.loadAttachments,
    this.additionalEmails,
    this.eventId,
    this.message,
  });

  EventInfoState copyWith({
    FormStatus? status,
    EventProtectionModel? model,
    GetLocations? locations,
    EntrySecurity? loggedInUserDetails,
    List<BaseUser>? users,
    List<BaseUser>? emailUsers,
    List<CreateImage>? loadAttachments,
    List<String>? additionalEmails,
    int? eventId,
    String? message,
  }) {
    return EventInfoState(
      status: status ?? this.status,
      model: model ?? this.model,
      locations: locations ?? this.locations,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      users: users ?? this.users,
      emailUsers: emailUsers ?? this.emailUsers,
      loadAttachments: loadAttachments ?? this.loadAttachments,
      additionalEmails: additionalEmails ?? this.additionalEmails,
      eventId: eventId ?? this.eventId,
      message: message ?? this.message,
    );
  }
}
