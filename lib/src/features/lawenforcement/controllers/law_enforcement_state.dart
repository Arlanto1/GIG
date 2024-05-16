import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/lawenforcement/models/distribution_model.dart';
import 'package:db_atom/src/features/lawenforcement/models/dropdown_object.dart';
import 'package:db_atom/src/features/lawenforcement/models/leopurposevisit.dart';

class LawEnforcementState extends Equatable {
  final LawEnforcementDetailsModel model;
  GetDepositor? getDepositorResponse;
  AddEntities? getEntitiesResponse;
  LeoDepartments? departmentResponse;
  LeoPurposeVisit? getLeopurposeResponse;
  late final int? eventId;
  final FormStatus status;
  String? message;
  Locations? getLocationsResponse;
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
  List<ImageContent>? loadAttachments = [];
  List<VisitingOfficialsModel>? visitingOfficials = [];
  int getVisitsCount = 0;
  User? getUserDetailsResponse;
  SubmitLawEnforcementResponse? submitResponse;
  List<Organisation>? loadGroups = [];
  DistributionGroupModel? groups;
  Organisation? listIndividualdept;
  Organisation? createOrganisationResponse;
  Organisation? createEmployeeDepartments;
  CreateUserModel? createUserResponse;
  bool? isDistributed;

  LawEnforcementState({
    required this.model,
    this.getEntitiesResponse,
    this.departmentResponse,
    this.getLeopurposeResponse,
    this.eventId,
    required this.status,
    this.message,
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
    this.visitingOfficials,
    this.getVisitsCount = 0,
    this.getUserDetailsResponse,
    this.submitResponse,
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
    FormStatus? status,
    String? message,
    Locations? getLocationsResponse,
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
    List<ImageContent>? loadAttachments,
    int? getVisitsCount,
    List<VisitingOfficialsModel>? visitingOfficials,
    User? getUserDetailsResponse,
    SubmitLawEnforcementResponse? submitResponse,
    List<Organisation>? loadGroups,
    DistributionGroupModel? groups,
    Organisation? listIndividualdept,
    Organisation? createOrganisationResponse,
    Organisation? createEmployeeDepartments,
    CreateUserModel? createUserResponse,
    bool? isDistributed,
     LawEnforcementDetailsModel? model,
  }) {
    return LawEnforcementState(
      model: model ?? this.model,
      getEntitiesResponse: getEntitiesResponse ?? this.getEntitiesResponse,
      departmentResponse: getLeodepartmentsResponse ?? departmentResponse,
      getLeopurposeResponse:
      getLeopurposeResponse ?? this.getLeopurposeResponse,
      eventId: eventId ?? this.eventId,
      status: status ?? this.status,
      message: message ?? this.message,
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
      visitingOfficials: visitingOfficials ?? this.visitingOfficials,
      getVisitsCount: getVisitsCount ?? this.getVisitsCount,
      getUserDetailsResponse:
      getUserDetailsResponse ?? this.getUserDetailsResponse,
      submitResponse: submitResponse ?? this.submitResponse,
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
    departmentResponse,
    getLeopurposeResponse,
    eventId,
    status,
    message,
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
    visitingOfficials,
    getVisitsCount,
    getUserDetailsResponse,
    submitResponse,
    loadGroups,
    groups,
    listIndividualdept,
    createEmployeeDepartments,
    createOrganisationResponse,
    createUserResponse,
    isDistributed,
  ];
}
