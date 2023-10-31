import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/create_user_model.dart';
import 'package:db_atom/src/features/createfound/models/emplyee_departments_model.dart';
import 'package:db_atom/src/features/createfound/models/get_depositor_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/serial_number_model.dart';
import 'package:db_atom/src/features/lawenforcement/models/addentities.dart';
import 'package:db_atom/src/features/lawenforcement/models/submit_law_enforcement_response.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/analyst_model.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/company_type_model.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/create_pass_mgmt_response.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/day_pass_numbers_list.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/day_pass_reason_model.dart';
import 'package:equatable/equatable.dart';

import '../../../../../models/base_user.dart';
import '../../../../../models/organisation.dart';
import '../../../../createfound/models/user.dart';

enum CreatePassMgmtStateType {
  initial,
  loading,
  success,
  failure,
  addattachment,
  photoattachment
}

class CreatePassMgmtState extends Equatable {
  GetDepositor? getDepositorResponse;
  AddEntities? getEntitiesResponse;
  late final int? eventId;
  final CreatePassMgmtStateType stateType;
  String? errorMessage;
  GetLocations? getLocationsResponse;
  SerialNumberModel? getSerialnumberResponse;
  List<Organisation>? listOfEntities;
  Organisation? location;
  Organisation? locationRegion;
  SerialNumberModel? serialnumberResponse;
  BaseUser? getuserResponse;
  EmployeeDepartments? employeeDepartment;
  Organisation? selectedemployeeDepartmentResponse;
  List<CreateImage>? loadAttachments = [];
  List<CreateImage>? photoAttachments = [];
  User? getUserDetailsResponse;
  SubmitLawEnforcementResponse? lawcreateFoundresponse;
  Organisation? createOrganisationResponse;
  Organisation? createEmployeeDepartments;
  CompanyTypes? companyTypes;
  Organisation? atomCompanyType;
  CreatePassMgmtResponse? createpassFoundresponse;
  Organisation? dayPasselementReason;
  DayPassReason? dayPassReason;
  BaseUser? t1nameanalyst;
  Analyst? analyst;
  BaseUser? t1hostanalyst;
  BaseUser? t1dbsponsoranalyst;
  Organisation? vendorPassInfo;
  DayPassNumberLists? passnumbelistresponse;
  String? radioButtonItem = '';
  int? escortedbyhost;

  CreateUserModel? createUserResponse;
  BaseUser? hostResponse;
  BaseUser? dbsponsorResponse;
  BaseUser? nameResponse;

  CreatePassMgmtState({
    this.getEntitiesResponse,
    this.eventId,
    required this.stateType,
    this.errorMessage,
    this.getLocationsResponse,
    this.getSerialnumberResponse,
    this.listOfEntities,
    this.location,
    this.locationRegion,
    this.serialnumberResponse,
    this.getDepositorResponse,
    this.getuserResponse,
    this.employeeDepartment,
    this.selectedemployeeDepartmentResponse,
    this.loadAttachments,
    this.getUserDetailsResponse,
    this.lawcreateFoundresponse,
    this.createEmployeeDepartments,
    this.createOrganisationResponse,
    this.companyTypes,
    this.atomCompanyType,
    this.createpassFoundresponse,
    this.dayPassReason,
    this.dayPasselementReason,
    this.t1nameanalyst,
    this.analyst,
    this.t1hostanalyst,
    this.t1dbsponsoranalyst,
    this.vendorPassInfo,
    this.passnumbelistresponse,
    this.escortedbyhost,
    this.radioButtonItem,
    this.photoAttachments,
    this.createUserResponse,
    this.hostResponse,
    this.dbsponsorResponse,
    this.nameResponse,
  });

  CreatePassMgmtState copyWith({
    AddEntities? getEntitiesResponse,
    final int? eventId,
    CreatePassMgmtStateType? stateType,
    String? errorMessage,
    GetLocations? getLocationsResponse,
    SerialNumberModel? getSerialnumberResponse,
    List<Organisation>? listOfEntities,
    Organisation? location,
    Organisation? locationRegion,
    SerialNumberModel? serialnumberResponse,
    GetDepositor? getDepositorResponse,
    BaseUser? getuserResponse,
    EmployeeDepartments? employeeDepartment,
    Organisation? selectedemployeeDepartmentResponse,
    List<CreateImage>? loadAttachments,
    User? getUserDetailsResponse,
    SubmitLawEnforcementResponse? lawcreateFoundresponse,
    Organisation? createOrganisationResponse,
    Organisation? createEmployeeDepartments,
    CompanyTypes? companyTypes,
    Organisation? atomCompanyType,
    CreatePassMgmtResponse? createpassFoundresponse,
    Organisation? dayPasselementReason,
    DayPassReason? dayPassReason,
    BaseUser? t1nameanalyst,
    Analyst? analyst,
    BaseUser? t1hostanalyst,
    BaseUser? t1dbsponsoranalyst,
    Organisation? activePassInfoList,
    DayPassNumberLists? passnumbelistresponse,
    String? radioButtonItem = '',
    int? escortedbyhost,
    List<CreateImage>? photoAttachments,
    CreateUserModel? createUserResponse,
    BaseUser? hostResponse,
    BaseUser? dbsponsorResponse,
    BaseUser? nameResponse,
  }) {
    return CreatePassMgmtState(
      getEntitiesResponse: getEntitiesResponse ?? this.getEntitiesResponse,
      eventId: eventId ?? this.eventId,
      stateType: stateType ?? this.stateType,
      errorMessage: errorMessage ?? this.errorMessage,
      getLocationsResponse: getLocationsResponse ?? this.getLocationsResponse,
      getSerialnumberResponse:
          getSerialnumberResponse ?? this.getSerialnumberResponse,
      listOfEntities: listOfEntities ?? this.listOfEntities,
      location: location ?? this.location,
      locationRegion: locationRegion ?? this.locationRegion,
      serialnumberResponse: serialnumberResponse ?? this.serialnumberResponse,
      getDepositorResponse: getDepositorResponse ?? this.getDepositorResponse,
      getuserResponse: getuserResponse ?? this.getuserResponse,
      employeeDepartment: employeeDepartment ?? this.employeeDepartment,
      selectedemployeeDepartmentResponse: selectedemployeeDepartmentResponse ??
          this.selectedemployeeDepartmentResponse,
      loadAttachments: loadAttachments ?? this.loadAttachments,
      getUserDetailsResponse:
          getUserDetailsResponse ?? this.getUserDetailsResponse,
      lawcreateFoundresponse:
          lawcreateFoundresponse ?? this.lawcreateFoundresponse,
      createEmployeeDepartments:
          createEmployeeDepartments ?? this.createEmployeeDepartments,
      createOrganisationResponse:
          createOrganisationResponse ?? this.createOrganisationResponse,
      companyTypes: companyTypes ?? this.companyTypes,
      atomCompanyType: atomCompanyType ?? this.atomCompanyType,
      createpassFoundresponse:
          createpassFoundresponse ?? this.createpassFoundresponse,
      dayPassReason: dayPassReason ?? this.dayPassReason,
      dayPasselementReason: dayPasselementReason ?? this.dayPasselementReason,
      t1nameanalyst: t1nameanalyst ?? this.t1nameanalyst,
      t1hostanalyst: t1hostanalyst ?? this.t1hostanalyst,
      analyst: analyst ?? this.analyst,
      t1dbsponsoranalyst: t1dbsponsoranalyst ?? this.t1dbsponsoranalyst,
      vendorPassInfo: activePassInfoList ?? this.vendorPassInfo,
      passnumbelistresponse:
          passnumbelistresponse ?? this.passnumbelistresponse,
      escortedbyhost: escortedbyhost ?? this.escortedbyhost,
      radioButtonItem: radioButtonItem ?? this.radioButtonItem,
      photoAttachments: photoAttachments ?? this.photoAttachments,
      createUserResponse: createUserResponse ?? this.createUserResponse,
      hostResponse: hostResponse ?? this.hostResponse,
      dbsponsorResponse: dbsponsorResponse ?? this.dbsponsorResponse,
      nameResponse: nameResponse ?? this.nameResponse,
    );
  }

  @override
  List<Object?> get props => [
        getEntitiesResponse,
        eventId,
        stateType,
        errorMessage,
        getLocationsResponse,
        getSerialnumberResponse,
        listOfEntities,
        location,
        locationRegion,
        serialnumberResponse,
        getDepositorResponse,
        getuserResponse,
        employeeDepartment,
        selectedemployeeDepartmentResponse,
        loadAttachments,
        getUserDetailsResponse,
        lawcreateFoundresponse,
        createEmployeeDepartments,
        createOrganisationResponse,
        companyTypes,
        atomCompanyType,
        createpassFoundresponse,
        dayPassReason,
        dayPasselementReason,
        t1nameanalyst,
        t1hostanalyst,
        analyst,
        t1dbsponsoranalyst,
        vendorPassInfo,
        passnumbelistresponse,
        escortedbyhost,
        radioButtonItem,
        photoAttachments,
        createUserResponse,
        hostResponse,
        dbsponsorResponse,
        nameResponse,
      ];
}
