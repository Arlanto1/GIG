part of 'event_info_cubit.dart';

class EventInfoState extends Equatable {
  final FormStatus status;
  final EventInfoResponse model;
  final GetLocations? locations;
  final User? loggedInUserDetails;
  final List<BaseUser>? users;
  final List<BaseUser>? emailUsers;
  final List<ImageContent>? loadAttachments;
  final List<ImageContent>? guardAttachments;

  final List<String>? additionalEmails;
  final int? eventId;
  final int? eventDuration;
  final String? message;
  final List<FoundModel>? foundArticles;

  factory EventInfoState.initial({
    required EventInfoResponse model,
    required GetLocations locations,
    required User loggedInUserDetails,
    required List<BaseUser>? users,
    final List<BaseUser>? emailUsers,
    required final List<Organisation>? listOfEntities,
    required final List<Organisation>? listOfQualifications,
    required final AddEntities? getEntitiesResponse,
    required final AddQualifications? getQualificationsResponse,
    required final List<Organisation> departments,
    required String errorMessage,
    required List<ImageContent> loadAttachments,
    List<ImageContent>? bioDataAttachments,
    List<ImageContent>? guardAttachments,
    List<ImageContent>? deploymentAttachments,
    List<ImageContent>? permanentAddressAttachments,
    List<ImageContent>? localAddressAttachments,
    List<ImageContent>? pVCAttachments,
    List<ImageContent>? trainingAttachments,
    List<ImageContent>? mSGBAttachments,
    List<ImageContent>? medicalAttachments,
    List<User>? entrySecurities,
    required int? eventId,
    List<String>? additionalEmails,
    List<FoundModel>? foundArticles,
    required int eventDuration,
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
      eventDuration: eventDuration,
      foundArticles: foundArticles,
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
    this.guardAttachments,
    this.additionalEmails,
    this.eventId,
    this.eventDuration,
    this.message,
    this.foundArticles,
  });

  EventInfoState copyWith({
    FormStatus? status,
    EventInfoResponse? model,
    GetLocations? locations,
    User? loggedInUserDetails,
    List<BaseUser>? users,
    List<BaseUser>? emailUsers,
    List<ImageContent>? loadAttachments,
    List<ImageContent>? guardAttachments,
    List<String>? additionalEmails,
    int? eventId,
    int? eventDuration,
    String? message,
    List<FoundModel>? foundArticles,
  }) {
    return EventInfoState(
      status: status ?? this.status,
      model: model ?? this.model,
      locations: locations ?? this.locations,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      users: users ?? this.users,
      emailUsers: emailUsers ?? this.emailUsers,
      loadAttachments: loadAttachments ?? this.loadAttachments,
      guardAttachments: guardAttachments ?? this.guardAttachments,
      additionalEmails: additionalEmails ?? this.additionalEmails,
      eventId: eventId ?? this.eventId,
      eventDuration: eventDuration ?? this.eventDuration,
      message: message ?? this.message,
      foundArticles: foundArticles ?? this.foundArticles,
    );
  }
}
