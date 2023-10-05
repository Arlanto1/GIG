import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/create_found_submit_model.dart';
import 'package:db_atom/src/features/createfound/models/create_organisation_model.dart';
import 'package:db_atom/src/features/createfound/models/create_user_model.dart';
import 'package:db_atom/src/features/createfound/models/emplyee_departments_model.dart';
import 'package:db_atom/src/features/createfound/models/get_articletype_model.dart';
import 'package:db_atom/src/features/createfound/models/get_depositor_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/serial_number_model.dart';
import 'package:equatable/equatable.dart';

import '../../../models/entry_security.dart';
import '../../../models/organisation.dart';

enum CreateFoundStateType { initial, loading, success, failure, addattachment }

class CreateFoundState extends Equatable {
  GetDepositor? getDepositorResponse;
  GetLocations? getLocationsResponse;
  EmployeeDepartments? getEmployeeDepartmentsResponse;
  GetArticleType? getArticleTypeResponse;
  Organisation? createOrganisationResponse;
  Organisation? createEmployeeDepartments;
  CreateUserModel? createUserResponse;
  EntrySecurity? getUserDetailsResponse;
  SubmitCreateFoundModel? createFoundResponse;
  SerialNumberModel? getSerialnumberResponse;
  final String? errorMessage;
  final CreateFoundStateType stateType;
  List<CreateImage>? loadAttachments = [];
   final int? eventId;

  CreateFoundState({
    this.getDepositorResponse,
    this.getLocationsResponse,
    this.getEmployeeDepartmentsResponse,
    this.getArticleTypeResponse,
    this.createOrganisationResponse,
    this.createEmployeeDepartments,
    this.createUserResponse,
    this.getUserDetailsResponse,
    this.createFoundResponse,
    this.getSerialnumberResponse,
    required this.stateType,
    this.errorMessage,
    this.loadAttachments,
    this.eventId
  });

  CreateFoundState copyWith({
    GetDepositor? getDepositorResponse,
    GetLocations? getLocationsResponse,
    EmployeeDepartments? getEmployeeDepartmentsResponse,
    GetArticleType? getArticleTypeResponse,
    Organisation? createOrganisationResponse,
    Organisation? createEmployeeDepartments,
    CreateUserModel? createUserResponse,
    EntrySecurity? getUserDetailsResponse,
    SubmitCreateFoundModel? createFoundResponse,
    SerialNumberModel? getSerialnumberResponse,
    String? errorMessage,
    CreateFoundStateType? stateType,
    List<CreateImage>? loadAttachments,
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
        getUserDetailsResponse:
            getUserDetailsResponse ?? this.getUserDetailsResponse,
        createFoundResponse: createFoundResponse ?? this.createFoundResponse,
        getSerialnumberResponse:
            getSerialnumberResponse ?? this.getSerialnumberResponse,
        errorMessage: errorMessage ?? this.errorMessage,
        stateType: stateType ?? this.stateType,
        loadAttachments: loadAttachments ?? this.loadAttachments,
        eventId :   eventId ?? this.eventId);
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
        getUserDetailsResponse,
        createFoundResponse,
        getSerialnumberResponse,
        errorMessage,
        stateType,
        loadAttachments,
        eventId
      ];
}
