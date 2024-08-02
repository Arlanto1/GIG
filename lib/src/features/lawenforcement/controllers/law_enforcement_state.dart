import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/lawenforcement/models/distribution_model.dart';
import 'package:db_atom/src/features/lawenforcement/models/dropdown_object.dart';
import 'package:db_atom/src/features/lawenforcement/models/leopurposevisit.dart';

class LawEnforcementState extends Equatable {
  final LawEnforcementDetailsModel? model;
  List<BaseUser>? getDepositorResponse;
  AddEntities? getEntitiesResponse;
  LeoDepartments? departmentResponse;
  LeoPurposeVisit? purposeList;
  late final int? eventId;
  final FormStatus status;
  String? message;
  Locations? getLocationsResponse;
  String? slno;
  List<Organisation>? listOfEntities;
  Organisation? locationSelectedlist;
  Organisation? leoPurposeVisitResponse;
  Organisation? leoDepartmentsResponse;
  SerialNumberModel? serialnumberResponse;
  String? radioButtonItem = '';
  int? isOfficialIdcardSelected;
  int? isDocumentifanySelected;
  int? isIncaseofpoliceSelected;
  BaseUser? dBOfficialEmailIdAccompaniedLeoOfficial;
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
    this.model,
    this.getEntitiesResponse,
    this.departmentResponse,
    this.purposeList,
    this.eventId,
    required this.status,
    this.message,
    this.getLocationsResponse,
    this.slno,
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
    this.dBOfficialEmailIdAccompaniedLeoOfficial,
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
    LeoPurposeVisit? purposeList,
    final int? eventId,
    FormStatus? status,
    String? message,
    Locations? getLocationsResponse,
    String? slno,
    List<Organisation>? listOfEntities,
    Organisation? locationSelectedlist,
    Organisation? leoPurposeVisitResponse,
    Organisation? leoDepartmentsResponse,
    SerialNumberModel? serialnumberResponse,
    String? radioButtonItem = '',
    int? isOfficialIdcardSelected,
    int? isDocumentifanySelected,
    int? isIncaseofpoliceSelected,
    List<BaseUser>? getDepositorResponse,
    BaseUser? dBOfficialEmailIdAccompaniedLeoOfficial,
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
      purposeList: purposeList ?? this.purposeList,
      eventId: eventId ?? this.eventId,
      status: status ?? this.status,
      message: message ?? this.message,
      getLocationsResponse: getLocationsResponse ?? this.getLocationsResponse,
      slno: slno ?? this.slno,
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
      dBOfficialEmailIdAccompaniedLeoOfficial:
          dBOfficialEmailIdAccompaniedLeoOfficial ??
              this.dBOfficialEmailIdAccompaniedLeoOfficial,
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
        purposeList,
        eventId,
        status,
        message,
        getLocationsResponse,
        slno,
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
        dBOfficialEmailIdAccompaniedLeoOfficial,
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
