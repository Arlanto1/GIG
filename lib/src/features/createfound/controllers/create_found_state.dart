import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/af_ui_labels.dart';

class CreateFoundState extends Equatable {
  final GetDepositor? getDepositorResponse;
  final Locations? getLocationsResponse;
  final EmployeeDepartments? getEmployeeDepartmentsResponse;
  final GetArticleType? getArticleTypeResponse;
  final Organisation? createOrganisationResponse;
  final Organisation? createEmployeeDepartments;
  final CreateUserModel? createUserResponse;
  final User? loggedInUser;
  final User? handedOverUser;
  final SubmitCreateFoundModel? createFoundResponse;
  final SerialNumberModel? getSerialnumberResponse;
  final String? message;
  final FormStatus status;
  final List<ImageContent>? loadAttachments;
  final int? eventId;
  final AFUiLabels? labels;

  const CreateFoundState(
      {this.getDepositorResponse,
      this.getLocationsResponse,
      this.getEmployeeDepartmentsResponse,
      this.getArticleTypeResponse,
      this.createOrganisationResponse,
      this.createEmployeeDepartments,
      this.createUserResponse,
      this.loggedInUser,
      this.handedOverUser,
      this.createFoundResponse,
      this.getSerialnumberResponse,
      required this.status,
      this.message,
      this.loadAttachments,
      this.eventId,
      this.labels});

  CreateFoundState copyWith({
    GetDepositor? getDepositorResponse,
    Locations? getLocationsResponse,
    EmployeeDepartments? getEmployeeDepartmentsResponse,
    GetArticleType? getArticleTypeResponse,
    Organisation? createOrganisationResponse,
    Organisation? createEmployeeDepartments,
    CreateUserModel? createUserResponse,
    User? loggedInUser,
    User? handedOverUser,
    SubmitCreateFoundModel? createFoundResponse,
    SerialNumberModel? getSerialnumberResponse,
    String? message,
    FormStatus? status,
    List<ImageContent>? loadAttachments,
    final int? eventId,
  }) {
    return CreateFoundState(
        getDepositorResponse: getDepositorResponse ?? this.getDepositorResponse,
        getLocationsResponse: getLocationsResponse ?? this.getLocationsResponse,
        getEmployeeDepartmentsResponse: getEmployeeDepartmentsResponse ??
            this.getEmployeeDepartmentsResponse,
        getArticleTypeResponse:
            getArticleTypeResponse ?? this.getArticleTypeResponse,
        createOrganisationResponse:
            createOrganisationResponse ?? this.createOrganisationResponse,
        createEmployeeDepartments:
            createEmployeeDepartments ?? this.createEmployeeDepartments,
        createUserResponse: createUserResponse ?? this.createUserResponse,
        handedOverUser: handedOverUser ?? this.handedOverUser,
        loggedInUser: loggedInUser ?? this.loggedInUser,
        createFoundResponse: createFoundResponse ?? this.createFoundResponse,
        getSerialnumberResponse:
            getSerialnumberResponse ?? this.getSerialnumberResponse,
        message: message ?? this.message,
        status: status ?? this.status,
        loadAttachments: loadAttachments ?? this.loadAttachments,
        eventId: eventId ?? this.eventId,
      labels: labels ?? labels,
    );
  }

  @override
  List<Object?> get props => [
        getDepositorResponse,
        getLocationsResponse,
        getEmployeeDepartmentsResponse,
        getArticleTypeResponse,
        createOrganisationResponse,
        createEmployeeDepartments,
        createUserResponse,
        loggedInUser,
        handedOverUser,
        createFoundResponse,
        getSerialnumberResponse,
        message,
        status,
        loadAttachments,
        eventId,
        labels
      ];
}
