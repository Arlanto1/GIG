import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/createfound/models/create_found_submit_model.dart';
import 'package:db_atom/src/features/createfound/models/create_user_model.dart';
import 'package:db_atom/src/features/createfound/models/get_articletype_model.dart';

class CreateFoundState extends Equatable {
  GetDepositor? getDepositorResponse;
  Locations? getLocationsResponse;
  EmployeeDepartments? getEmployeeDepartmentsResponse;
  GetArticleType? getArticleTypeResponse;
  Organisation? createOrganisationResponse;
  Organisation? createEmployeeDepartments;
  CreateUserModel? createUserResponse;
  User? loggedInUser;
  User? handedOverUser;
  SubmitCreateFoundModel? createFoundResponse;
  SerialNumberModel? getSerialnumberResponse;
  final String? message;
  final FormStatus status;
  List<ImageContent>? loadAttachments = [];
  final int? eventId;

  CreateFoundState(
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
      this.eventId});

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
        handedOverUser:handedOverUser??this.handedOverUser,
        loggedInUser: loggedInUser ?? this.loggedInUser,
        createFoundResponse: createFoundResponse ?? this.createFoundResponse,
        getSerialnumberResponse:
            getSerialnumberResponse ?? this.getSerialnumberResponse,
        message: message ?? this.message,
        status: status ?? this.status,
        loadAttachments: loadAttachments ?? this.loadAttachments,
        eventId: eventId ?? this.eventId);
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
        eventId
      ];
}
