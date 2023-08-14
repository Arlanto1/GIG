import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/create_organisation_model.dart';
import 'package:db_atom/src/features/createfound/models/create_user_model.dart';
import 'package:db_atom/src/features/createfound/models/emplyee_departments_model.dart';
import 'package:db_atom/src/features/createfound/models/get_depositor_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/get_user_model.dart';
import 'package:db_atom/src/features/createfound/models/serial_number_model.dart';
import 'package:db_atom/src/features/lawenforcement/controllers/law_enforcement_state.dart';
import 'package:db_atom/src/features/lawenforcement/models/addentities.dart';
import 'package:db_atom/src/features/lawenforcement/models/distribution_model.dart';
import 'package:db_atom/src/features/lawenforcement/models/dropdown_object.dart';
import 'package:db_atom/src/features/lawenforcement/models/leodepartments.dart';
import 'package:db_atom/src/features/lawenforcement/models/leopurposevisit.dart';
import 'package:db_atom/src/features/lawenforcement/models/submit_law_enforcement_response.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/analyst_model.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/company_type_model.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/create_pass_mgmt_response.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/day_pass_numbers_list.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/day_pass_reason_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum CreatePassMgmtStateType { initial, loading, success, failure, addattachment, photoattachment }

 class CreatePassMgmtState extends Equatable {
  GetDepositor? getDepositorResponse;
  AddEntities? getEntitiesResponse;
  late final int? eventId;
  final CreatePassMgmtStateType stateType;
  String? errorMessage;
  GetLocations? getLocationsResponse;
  SerialNumberModel? getSerialnumberResponse;
 List<AtomEntity>?  listOfEntities;
  Mumbai? locationSelectedlist;
  SerialNumberModel? serialnumberResponse;
  AtomStaticUser? getuserResponse;
  EmployeeDepartments? employeeDepartment;
  EmployeeDepartment? selectedemployeeDepartmentResponse;
  List<CreateImage>? loadAttachments = [];
   List<CreateImage>? photoAttachments = [];
  GetUserDetails? getUserDetailsResponse;
  SubmitLawEnforcementResponse? lawcreateFoundresponse;
  CreateOrganisation? createOrganisationResponse;
  CreateOrganisation? createEmployeeDepartments;
  CompanyTypes? companyTypes;
  AtomCompanyType? atomCompanyType;
  CreatePassMgmtResponse? createpassFoundresponse;
  DayPassReasonElement? dayPasselementReason;
  DayPassReason? dayPassReason;
  T1Analyst? t1nameanalyst;
  Analyst? analyst;
  T1Analyst? t1hostanalyst;
  T1Analyst? t1dbsponsoranalyst;
  ActivePassInfoList? activePassInfoList;
  DayPassNumberLists? passnumbelistresponse;
  String? radioButtonItem = '';
  int? escortedbyhost ;
   CreateUserModel? createUserResponse;

  CreatePassMgmtState({
    this.getEntitiesResponse,
    this.eventId, 
    required this.stateType,
    this.errorMessage,
    this.getLocationsResponse,
    this.getSerialnumberResponse,
    this.listOfEntities,
    this.locationSelectedlist,
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
    this.activePassInfoList,
    this.passnumbelistresponse,
    this.escortedbyhost,
    this.radioButtonItem,
    this.photoAttachments,
    this.createUserResponse
  });
  CreatePassMgmtState copyWith({
  AddEntities? getEntitiesResponse,
  final int? eventId,
  CreatePassMgmtStateType? stateType,
  String? errorMessage,
  GetLocations? getLocationsResponse,
  SerialNumberModel? getSerialnumberResponse,
 List<AtomEntity>?  listOfEntities,
  Mumbai? locationSelectedlist,
  SerialNumberModel? serialnumberResponse,
  GetDepositor? getDepositorResponse,
  AtomStaticUser? getuserResponse,
  EmployeeDepartments? employeeDepartment,
  EmployeeDepartment? selectedemployeeDepartmentResponse,
  List<CreateImage>? loadAttachments,
  GetUserDetails? getUserDetailsResponse,
  SubmitLawEnforcementResponse? lawcreateFoundresponse,
  CreateOrganisation? createOrganisationResponse,
  CreateOrganisation? createEmployeeDepartments,
  CompanyTypes? companyTypes,
  AtomCompanyType? atomCompanyType,
  CreatePassMgmtResponse? createpassFoundresponse,
  DayPassReasonElement? dayPasselementReason,
  DayPassReason? dayPassReason,
  T1Analyst? t1nameanalyst,
  Analyst? analyst,
  T1Analyst? t1hostanalyst,
  T1Analyst? t1dbsponsoranalyst,
  ActivePassInfoList? activePassInfoList,
  DayPassNumberLists? passnumbelistresponse,
  String? radioButtonItem = '',
  int? escortedbyhost,
  List<CreateImage>? photoAttachments,
   CreateUserModel? createUserResponse,


  
  
  }) {
    return  CreatePassMgmtState(
      getEntitiesResponse : getEntitiesResponse ?? this.getEntitiesResponse,
      eventId : eventId ?? this.eventId,
      stateType  : stateType ?? this.stateType,
      errorMessage : errorMessage ?? this.errorMessage,
      getLocationsResponse:  getLocationsResponse ?? this.getLocationsResponse,
      getSerialnumberResponse: getSerialnumberResponse ?? this.getSerialnumberResponse,
      listOfEntities: listOfEntities ?? this.listOfEntities,
      locationSelectedlist:  locationSelectedlist ?? this.locationSelectedlist,
      serialnumberResponse: serialnumberResponse ?? this.serialnumberResponse,
      getDepositorResponse: getDepositorResponse ?? this.getDepositorResponse,
      getuserResponse: getuserResponse ?? this.getuserResponse,
      employeeDepartment: employeeDepartment ?? this.employeeDepartment,
      selectedemployeeDepartmentResponse: selectedemployeeDepartmentResponse ?? this.selectedemployeeDepartmentResponse,
      loadAttachments: loadAttachments ?? this.loadAttachments,
      getUserDetailsResponse: getUserDetailsResponse ?? this.getUserDetailsResponse,
      lawcreateFoundresponse: lawcreateFoundresponse ?? this.lawcreateFoundresponse,
      createEmployeeDepartments: createEmployeeDepartments ?? this.createEmployeeDepartments,
      createOrganisationResponse: createOrganisationResponse ?? this.createOrganisationResponse,
      companyTypes: companyTypes ?? this.companyTypes,
      atomCompanyType: atomCompanyType ?? this.atomCompanyType,
      createpassFoundresponse: createpassFoundresponse ?? this.createpassFoundresponse,
      dayPassReason: dayPassReason ?? this.dayPassReason,
      dayPasselementReason: dayPasselementReason ?? this.dayPasselementReason,
      t1nameanalyst: t1nameanalyst ?? this.t1nameanalyst,
      t1hostanalyst: t1hostanalyst ?? this.t1hostanalyst,
      analyst: analyst ?? this.analyst,
      t1dbsponsoranalyst: t1dbsponsoranalyst ?? this.t1dbsponsoranalyst,
      activePassInfoList: activePassInfoList ?? this.activePassInfoList,
      passnumbelistresponse: passnumbelistresponse ?? this.passnumbelistresponse,
      escortedbyhost: escortedbyhost ?? this.escortedbyhost,
      radioButtonItem: radioButtonItem ?? this.radioButtonItem,
      photoAttachments: photoAttachments ?? this.photoAttachments,
      createUserResponse: createUserResponse ?? this.createUserResponse,
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
        locationSelectedlist,
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
        activePassInfoList,
        passnumbelistresponse,
        escortedbyhost,
        radioButtonItem,
        photoAttachments,
        createUserResponse,
      ];

}