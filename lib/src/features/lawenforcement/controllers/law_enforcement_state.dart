import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/create_user_model.dart';
import 'package:db_atom/src/features/createfound/models/emplyee_departments_model.dart';
import 'package:db_atom/src/features/createfound/models/get_depositor_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/serial_number_model.dart';
import 'package:db_atom/src/features/lawenforcement/models/addentities.dart';
import 'package:db_atom/src/features/lawenforcement/models/distribution_model.dart';
import 'package:db_atom/src/features/lawenforcement/models/dropdown_object.dart';
import 'package:db_atom/src/features/lawenforcement/models/leodepartments.dart';
import 'package:db_atom/src/features/lawenforcement/models/leopurposevisit.dart';
import 'package:db_atom/src/features/lawenforcement/models/submit_law_enforcement_response.dart';
import 'package:equatable/equatable.dart';

import '../../../models/base_user.dart';
import '../../../models/organisation.dart';
import '../../createfound/models/user.dart';

enum LawEnforcementStateType {
  initial,
  loading,
  success,
  failure,
  addattachment
}

class LawEnforcementState extends Equatable {
  GetDepositor? getDepositorResponse;
  AddEntities? getEntitiesResponse;
  LeoDepartments? getLeodepartmentsResponse;
  LeoPurposeVisit? getLeopurposeResponse;
  late final int? eventId;
  final LawEnforcementStateType stateType;
  String? errorMessage;
  GetLocations? getLocationsResponse;
  SerialNumberModel? getSerialnumberResponse;
  List<Organisation>? listOfEntities;
  Organisation? locationSelectedlist;
  Organisation? leoPurposeVisitResponse;
  Organisation? leoDepartmentsResponse;
  SerialNumberModel? serialnumberResponse;
  String? radioButtonItem = '';
  int? isOfficialIdcardSelected;

  int? isDocumentifanySelected;

  int? isIncaseofpoliceSelected;

  BaseUser? getuserResponse;
  EmployeeDepartments? employeeDepartment;
  Organisation? selectedemployeeDepartmentResponse;
  List<CreateImage>? loadAttachments = [];
  List<VisitingOfficialsModel>? getVisits = [];
  int getVisitsCount = 0;
  User? getUserDetailsResponse;
  SubmitLawEnforcementResponse? lawcreateFoundresponse;
  List<Organisation>? loadGroups = [];
  DistributionGroupModel? groups;
  Organisation? listIndividualdept;
  Organisation? createOrganisationResponse;
  Organisation? createEmployeeDepartments;
  CreateUserModel? createUserResponse;
  bool? isDistributed;

  LawEnforcementState({
    this.getEntitiesResponse,
    this.getLeodepartmentsResponse,
    this.getLeopurposeResponse,
    this.eventId,
    required this.stateType,
    this.errorMessage,
    this.getLocationsResponse,
    this.getSerialnumberResponse,
    this.listOfEntities,
    this.locationSelectedlist,
    this.leoDepartmentsResponse,
    this.leoPurposeVisitResponse,
    this.serialnumberResponse,
    this.isDocumentifanySelected,
    this.radioButtonItem,
    this.isIncaseofpoliceSelected,
    this.isOfficialIdcardSelected,
    this.getDepositorResponse,
    this.getuserResponse,
    this.employeeDepartment,
    this.selectedemployeeDepartmentResponse,
    this.loadAttachments,
    this.getVisits,
    this.getVisitsCount = 0,
    this.getUserDetailsResponse,
    this.lawcreateFoundresponse,
    this.loadGroups,
    this.groups,
    this.listIndividualdept,
    this.createEmployeeDepartments,
    this.createOrganisationResponse,
    this.createUserResponse,
    this.isDistributed,
  });

  LawEnforcementState copyWith({
    AddEntities? getEntitiesResponse,
    LeoDepartments? getLeodepartmentsResponse,
    LeoPurposeVisit? getLeopurposeResponse,
    final int? eventId,
    LawEnforcementStateType? stateType,
    String? errorMessage,
    GetLocations? getLocationsResponse,
    SerialNumberModel? getSerialnumberResponse,
    List<Organisation>? listOfEntities,
    Organisation? locationSelectedlist,
    Organisation? leoPurposeVisitResponse,
    Organisation? leoDepartmentsResponse,
    SerialNumberModel? serialnumberResponse,
    String? radioButtonItem = '',
    int? isOfficialIdcardSelected,
    int? isDocumentifanySelected,
    int? isIncaseofpoliceSelected,
    GetDepositor? getDepositorResponse,
    BaseUser? getuserResponse,
    EmployeeDepartments? employeeDepartment,
    Organisation? selectedemployeeDepartmentResponse,
    List<CreateImage>? loadAttachments,
    int? getVisitsCount,
    List<VisitingOfficialsModel>? getVisits,
    User? getUserDetailsResponse,
    SubmitLawEnforcementResponse? lawcreateFoundresponse,
    List<Organisation>? loadGroups,
    DistributionGroupModel? groups,
    Organisation? listIndividualdept,
    Organisation? createOrganisationResponse,
    Organisation? createEmployeeDepartments,
    CreateUserModel? createUserResponse,
    bool? isDistributed,
  }) {
    return LawEnforcementState(
      getEntitiesResponse: getEntitiesResponse ?? this.getEntitiesResponse,
      getLeodepartmentsResponse:
          getLeodepartmentsResponse ?? this.getLeodepartmentsResponse,
      getLeopurposeResponse:
          getLeopurposeResponse ?? this.getLeopurposeResponse,
      eventId: eventId ?? this.eventId,
      stateType: stateType ?? this.stateType,
      errorMessage: errorMessage ?? this.errorMessage,
      getLocationsResponse: getLocationsResponse ?? this.getLocationsResponse,
      getSerialnumberResponse:
          getSerialnumberResponse ?? this.getSerialnumberResponse,
      listOfEntities: listOfEntities ?? this.listOfEntities,
      locationSelectedlist: locationSelectedlist ?? this.locationSelectedlist,
      leoPurposeVisitResponse:
          leoPurposeVisitResponse ?? this.leoPurposeVisitResponse,
      leoDepartmentsResponse:
          leoDepartmentsResponse ?? this.leoDepartmentsResponse,
      serialnumberResponse: serialnumberResponse ?? this.serialnumberResponse,
      radioButtonItem: radioButtonItem ?? this.radioButtonItem,
      isOfficialIdcardSelected:
          isOfficialIdcardSelected ?? this.isOfficialIdcardSelected,
      isDocumentifanySelected:
          isDocumentifanySelected ?? this.isDocumentifanySelected,
      isIncaseofpoliceSelected:
          isIncaseofpoliceSelected ?? this.isIncaseofpoliceSelected,
      getDepositorResponse: getDepositorResponse ?? this.getDepositorResponse,
      getuserResponse: getuserResponse ?? this.getuserResponse,
      employeeDepartment: employeeDepartment ?? this.employeeDepartment,
      selectedemployeeDepartmentResponse: selectedemployeeDepartmentResponse ??
          this.selectedemployeeDepartmentResponse,
      loadAttachments: loadAttachments ?? this.loadAttachments,
      getVisits: getVisits ?? this.getVisits,
      getVisitsCount: getVisitsCount ?? this.getVisitsCount,
      getUserDetailsResponse:
          getUserDetailsResponse ?? this.getUserDetailsResponse,
      lawcreateFoundresponse:
          lawcreateFoundresponse ?? this.lawcreateFoundresponse,
      loadGroups: loadGroups ?? this.loadGroups,
      groups: groups ?? this.groups,
      listIndividualdept: listIndividualdept ?? this.listIndividualdept,
      createEmployeeDepartments:
          createEmployeeDepartments ?? this.createEmployeeDepartments,
      createOrganisationResponse:
          createOrganisationResponse ?? this.createOrganisationResponse,
      createUserResponse: createUserResponse ?? this.createUserResponse,
      isDistributed: isDistributed ?? this.isDistributed,
    );
  }

  @override
  List<Object?> get props => [
        getEntitiesResponse,
        getLeodepartmentsResponse,
        getLeopurposeResponse,
        eventId,
        stateType,
        errorMessage,
        getLocationsResponse,
        getSerialnumberResponse,
        listOfEntities,
        locationSelectedlist,
        leoDepartmentsResponse,
        leoPurposeVisitResponse,
        serialnumberResponse,
        radioButtonItem,
        isOfficialIdcardSelected,
        isIncaseofpoliceSelected,
        isDocumentifanySelected,
        getDepositorResponse,
        getuserResponse,
        employeeDepartment,
        selectedemployeeDepartmentResponse,
        loadAttachments,
        getVisits,
        getVisitsCount,
        getUserDetailsResponse,
        lawcreateFoundresponse,
        loadGroups,
        groups,
        listIndividualdept,
        createEmployeeDepartments,
        createOrganisationResponse,
        createUserResponse,
        isDistributed,
      ];
}
