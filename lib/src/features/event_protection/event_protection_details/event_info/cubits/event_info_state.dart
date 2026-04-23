part of 'event_info_cubit.dart';

class EventInfoState extends Equatable {
  final FormStatus status;
  final EventInfoResponse model;
  final Locations? locations;
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
  final List<Map<String, dynamic>>? emailTemplates;
  final bool? isTemplateLoading ;
  final String? draftTemplateHtml;

  factory EventInfoState.initial({
    required EventInfoResponse model,
    required Locations locations,
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
    List<Map<String, dynamic>>? emailTemplates,
    bool? isTemplateLoading,
  required String? draftTemplateHtml,
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
        emailTemplates:emailTemplates,
        isTemplateLoading:isTemplateLoading,
    );
  }

  ErrorResponse get isValid {
    // if (model.eventStartedAt == null && model.eventStartedAt.isEmptyOrNull) {
    //   return const ErrorResponse(status: false, message: 'Please enter Event Started at');
    // }

    if (model.emails == null) {
      return const ErrorResponse(status: false, message: 'Please enter additional emails');
    }
    // if (model.email == []) {
    //   return const ErrorResponse(status: false, message: 'Please enter atleast one email notification');
    // }
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  // @override
  // List<Object?> get props => [model, status, ];

  const EventInfoState({
    required this.status,
    required this.model,
    this.locations,
    this.loggedInUserDetails,
    this.users,
    this.emailUsers,
    this.loadAttachments = const [],
    this.guardAttachments,
    this.additionalEmails,
    this.eventId,
    this.eventDuration,
    this.message,
    this.foundArticles,
    this.emailTemplates,
    this.isTemplateLoading,
    this.draftTemplateHtml,
  });

  EventInfoState copyWith({
    FormStatus? status,
    EventInfoResponse? model,
    Locations? locations,
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
    List<Map<String, dynamic>>? emailTemplates,
    bool? isTemplateLoading,
     String? draftTemplateHtml,
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
      emailTemplates: emailTemplates ?? this.emailTemplates,
      isTemplateLoading: isTemplateLoading ?? this.isTemplateLoading,
      draftTemplateHtml:draftTemplateHtml?? this.draftTemplateHtml,
    );
  }

  @override
  List<Object?> get props => [
    model,
    status,
    loadAttachments,
    guardAttachments,
    locations,
    loggedInUserDetails,
    users,
    emailUsers,
    additionalEmails,
    eventId,
    eventDuration,
    message,
    foundArticles,
    emailTemplates,
    isTemplateLoading,
    draftTemplateHtml,
  ];

}
