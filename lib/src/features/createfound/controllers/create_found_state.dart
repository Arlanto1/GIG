// Created by Ramesh
import 'package:db_atom/src/features/createfound/models/attachment_model.dart';
import 'package:db_atom/src/features/createfound/models/create_found_submit_model.dart';
import 'package:db_atom/src/features/createfound/models/create_organisation_model.dart';
import 'package:db_atom/src/features/createfound/models/create_user_model.dart';
import 'package:db_atom/src/features/createfound/models/emplyee_departments_model.dart';
import 'package:db_atom/src/features/createfound/models/get_articletype_model.dart';
import 'package:db_atom/src/features/createfound/models/get_depositor_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/get_user_model.dart';
import 'package:db_atom/src/features/createfound/models/serial_number_model.dart';
import 'package:equatable/equatable.dart';

enum CreateFoundStateType {
  initial,
  loading,
  success,
  failure,
}

class CreateFoundState extends Equatable {
  GetDepositor? getDepositorResponse;
  GetLocations? getLocationsResponse;
  EmployeeDepartments? getEmployeeDepartmentsResponse;
  GetArticleType? getArticleTypeResponse;
  CreateOrganisation? createOrganisationResponse;
  CreateOrganisation? createEmployeeDepartments;
  CreateUserModel? createUserResponse;
  GetUserDetails? getUserDetailsResponse;
  SubmitCreateFoundModel? createFoundResponse;
  SerialNumberModel? getSerialnumberResponse;
  final String? errorMessage;
  final CreateFoundStateType stateType;
  final List<AttachmentModel>? loadAttachments;

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
  });

  CreateFoundState copyWith({
    GetDepositor? getDepositorResponse,
    GetLocations? getLocationsResponse,
    EmployeeDepartments? getEmployeeDepartmentsResponse,
    GetArticleType? getArticleTypeResponse,
    CreateOrganisation? createOrganisationResponse,
    CreateOrganisation? createEmployeeDepartments,
    CreateUserModel? createUserResponse,
    GetUserDetails? getUserDetailsResponse,
    SubmitCreateFoundModel? createFoundResponse,
    SerialNumberModel? getSerialnumberResponse,
    String? errorMessage,
    CreateFoundStateType? stateType,
    List<AttachmentModel>? loadAttachments,

  }) {
    return CreateFoundState(
      getDepositorResponse: getDepositorResponse ?? this.getDepositorResponse,
      getLocationsResponse: getLocationsResponse ?? this.getLocationsResponse,
      getEmployeeDepartmentsResponse:
          getEmployeeDepartmentsResponse ?? this.getEmployeeDepartmentsResponse,
      getArticleTypeResponse: getArticleTypeResponse ?? this.getArticleTypeResponse,
      createOrganisationResponse: createOrganisationResponse ?? this.createOrganisationResponse,
      createEmployeeDepartments: createEmployeeDepartments ?? this.createEmployeeDepartments,
      createUserResponse: createUserResponse ?? this.createUserResponse,
      getUserDetailsResponse: getUserDetailsResponse ?? this.getUserDetailsResponse,
      createFoundResponse: createFoundResponse ?? this.createFoundResponse,
      getSerialnumberResponse: getSerialnumberResponse ?? this.getSerialnumberResponse,
      errorMessage: errorMessage ?? this.errorMessage,
      stateType: stateType ?? this.stateType,
      loadAttachments: loadAttachments ?? this.loadAttachments
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
        getUserDetailsResponse,
        createFoundResponse,
        getSerialnumberResponse,
        errorMessage,
        stateType,
        loadAttachments,
      ];
}
