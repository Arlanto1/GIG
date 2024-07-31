import 'package:db_atom/index.dart';

class CreateFoundState extends Equatable {
  final FoundListArticleDetails model;
  final GetDepositor? getDepositorResponse;
  final Locations? locations;
  final Organisation? location;
  final EmployeeDepartments? getEmployeeDepartmentsResponse;
  final GetArticleType? getArticleTypeResponse;
  final Organisation? createOrganisationResponse;
  final Organisation? createEmployeeDepartments;
  final CreateUserModel? createUserResponse;
  final User? loggedInUser;
  final User? handedOverUser;
  final SubmitCreateFoundModel? createFoundResponse;
  final String? slno;
  final String? message;
  final FormStatus status;
  final List<ImageContent>? loadAttachments;
  final int? eventId;
  final AFUiLabels? labels;

  const CreateFoundState({
    required this.model,
    this.getDepositorResponse,
    this.locations,
    this.location,
    this.getEmployeeDepartmentsResponse,
    this.getArticleTypeResponse,
    this.createOrganisationResponse,
    this.createEmployeeDepartments,
    this.createUserResponse,
    this.loggedInUser,
    this.handedOverUser,
    this.createFoundResponse,
    this.slno,
    required this.status,
    this.message,
    this.loadAttachments,
    this.eventId,
    this.labels,
  });

  @override
  List<Object?> get props => [
        getDepositorResponse,
        locations,
        location,
        getEmployeeDepartmentsResponse,
        getArticleTypeResponse,
        createOrganisationResponse,
        createEmployeeDepartments,
        createUserResponse,
        loggedInUser,
        handedOverUser,
        createFoundResponse,
        slno,
        message,
        status,
        loadAttachments,
        eventId,
        labels
      ];

  CreateFoundState copyWith({
    FoundListArticleDetails? model,
    GetDepositor? getDepositorResponse,
    Locations? locations,
    Organisation? location,
    EmployeeDepartments? getEmployeeDepartmentsResponse,
    GetArticleType? getArticleTypeResponse,
    Organisation? createOrganisationResponse,
    Organisation? createEmployeeDepartments,
    CreateUserModel? createUserResponse,
    User? loggedInUser,
    User? handedOverUser,
    SubmitCreateFoundModel? createFoundResponse,
    String? slno,
    String? message,
    FormStatus? status,
    List<ImageContent>? loadAttachments,
    int? eventId,
    AFUiLabels? labels,
  }) {
    return CreateFoundState(
      model: model ?? this.model,
      getDepositorResponse: getDepositorResponse ?? this.getDepositorResponse,
      locations: locations ?? this.locations,
      location: location ?? this.location,
      getEmployeeDepartmentsResponse:
          getEmployeeDepartmentsResponse ?? this.getEmployeeDepartmentsResponse,
      getArticleTypeResponse:
          getArticleTypeResponse ?? this.getArticleTypeResponse,
      createOrganisationResponse:
          createOrganisationResponse ?? this.createOrganisationResponse,
      createEmployeeDepartments:
          createEmployeeDepartments ?? this.createEmployeeDepartments,
      createUserResponse: createUserResponse ?? this.createUserResponse,
      loggedInUser: loggedInUser ?? this.loggedInUser,
      handedOverUser: handedOverUser ?? this.handedOverUser,
      createFoundResponse: createFoundResponse ?? this.createFoundResponse,
      slno:
          slno ?? this.slno,
      message: message ?? this.message,
      status: status ?? this.status,
      loadAttachments: loadAttachments ?? this.loadAttachments,
      eventId: eventId ?? this.eventId,
      labels: labels ?? this.labels,
    );
  }
}
