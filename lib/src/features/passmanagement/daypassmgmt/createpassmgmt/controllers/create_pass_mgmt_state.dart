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
import 'package:db_atom/src/models/image_content.dart';
import 'package:equatable/equatable.dart';

import '../../../../../models/base_user.dart';
import '../../../../../models/organisation.dart';
import '../../../../createfound/models/user.dart';
import '../models/vendor_pass_reason_model.dart';

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
  Locations? getLocationsResponse;
  SerialNumberModel? getSerialnumberResponse;
  List<Organisation>? selectedEntities;
  Organisation? location;
  Organisation? locationRegion;
  SerialNumberModel? serialnumberResponse;
  BaseUser? getuserResponse;
  EmployeeDepartments? employeeDepartment;
  Organisation? selectedDepartment;
  List<ImageContent>? loadAttachments = [];
  List<ImageContent>? photoAttachments = [];
  User? getUserDetailsResponse;
  User? getHandOverDetailsResponse;
  SubmitLawEnforcementResponse? lawcreateFoundresponse;
  Organisation? createOrganisationResponse;
  Organisation? createEmployeeDepartments;
  CompanyTypes? companyTypes;
  Organisation? selectedCompanyType;
  CreatePassMgmtResponse? createpassFoundresponse;
  Organisation? dayPasselementReason;
  Organisation? vendorPasselementReason;
  DayPassReason? dayPassReason;
  VendorPassReason? vendorPassReason;
  BaseUser? t1nameanalyst;
  Analyst? analyst;
  User? t1hostanalyst;
  User? t1dbsponsoranalyst;
  Organisation? vendorPassInfo;
  DayPassNumberLists? passnumbelistresponse;
  String? radioButtonItem = '';
  int? escortedbyhost;
  int? exceptionalApproval;


  CreateUserModel? createUserResponse;
  User? hostResponse;
  User? dbsponsorResponse;
  BaseUser? nameResponse;
  bool showIdentifiedFields;

  CreatePassMgmtState({
    this.getEntitiesResponse,
    this.eventId,
    required this.stateType,
    this.errorMessage,
    this.getLocationsResponse,
    this.getSerialnumberResponse,
    this.selectedEntities,
    this.location,
    this.locationRegion,
    this.serialnumberResponse,
    this.getDepositorResponse,
    this.getuserResponse,
    this.employeeDepartment,
    this.selectedDepartment,
    this.loadAttachments,
    this.getUserDetailsResponse,
    this.getHandOverDetailsResponse,
    this.lawcreateFoundresponse,
    this.createEmployeeDepartments,
    this.createOrganisationResponse,
    this.companyTypes,
    this.selectedCompanyType,
    this.showIdentifiedFields = false,
    this.createpassFoundresponse,
    this.dayPassReason,
    this.vendorPassReason,
    this.dayPasselementReason,
    this.vendorPasselementReason,
    this.t1nameanalyst,
    this.analyst,
    this.t1hostanalyst,
    this.t1dbsponsoranalyst,
    this.vendorPassInfo,
    this.passnumbelistresponse,
    this.escortedbyhost,
    this.exceptionalApproval,
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
    Locations? getLocationsResponse,
    SerialNumberModel? getSerialnumberResponse,
    List<Organisation>? selectedEntities,
    Organisation? location,
    Organisation? locationRegion,
    SerialNumberModel? serialnumberResponse,
    GetDepositor? getDepositorResponse,
    BaseUser? getuserResponse,
    bool? showIdentifiedFields,
    EmployeeDepartments? employeeDepartment,
    Organisation? selectedEmployeeDepartment,
    List<ImageContent>? loadAttachments,
    User? getUserDetailsResponse,
    User? getHandOverDetailsResponse,
    SubmitLawEnforcementResponse? lawcreateFoundresponse,
    Organisation? createOrganisationResponse,
    Organisation? createEmployeeDepartments,
    CompanyTypes? companyTypes,
    Organisation? selectedCompanyType,
    CreatePassMgmtResponse? createpassFoundresponse,
    Organisation? dayPasselementReason,
    Organisation? vendorPasselementReason,
    DayPassReason? dayPassReason,
    VendorPassReason? vendorPassReason,
    BaseUser? t1nameanalyst,
    Analyst? analyst,
    User? t1hostanalyst,
    User? t1dbsponsoranalyst,
    Organisation? activePassInfoList,
    DayPassNumberLists? passnumbelistresponse,
    String? radioButtonItem = '',
    int? escortedbyhost,
    int? exceptionalApproval,
    List<ImageContent>? photoAttachments,
    CreateUserModel? createUserResponse,
    User? hostResponse,
    User? dbsponsorResponse,
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
      selectedEntities: selectedEntities ?? this.selectedEntities,
      location: location ?? this.location,
      locationRegion: locationRegion ?? this.locationRegion,
      serialnumberResponse: serialnumberResponse ?? this.serialnumberResponse,
      getDepositorResponse: getDepositorResponse ?? this.getDepositorResponse,
      getuserResponse: getuserResponse ?? this.getuserResponse,
      employeeDepartment: employeeDepartment ?? this.employeeDepartment,
      selectedDepartment: selectedEmployeeDepartment ?? selectedDepartment,
      showIdentifiedFields: showIdentifiedFields ?? this.showIdentifiedFields,
      loadAttachments: loadAttachments ?? this.loadAttachments,
      getUserDetailsResponse:
          getUserDetailsResponse ?? this.getUserDetailsResponse,
      getHandOverDetailsResponse:getHandOverDetailsResponse??this.getHandOverDetailsResponse,
      lawcreateFoundresponse:
          lawcreateFoundresponse ?? this.lawcreateFoundresponse,
      createEmployeeDepartments:
          createEmployeeDepartments ?? this.createEmployeeDepartments,
      createOrganisationResponse:
          createOrganisationResponse ?? this.createOrganisationResponse,
      companyTypes: companyTypes ?? this.companyTypes,
      selectedCompanyType: selectedCompanyType ?? this.selectedCompanyType,
      createpassFoundresponse:
          createpassFoundresponse ?? this.createpassFoundresponse,
      dayPassReason: dayPassReason ?? this.dayPassReason,
      vendorPassReason: vendorPassReason ?? this.vendorPassReason,
      dayPasselementReason: dayPasselementReason ?? this.dayPasselementReason,
      vendorPasselementReason:
          vendorPasselementReason ?? this.vendorPasselementReason,
      t1nameanalyst: t1nameanalyst ?? this.t1nameanalyst,
      t1hostanalyst: t1hostanalyst ?? this.t1hostanalyst,
      analyst: analyst ?? this.analyst,
      t1dbsponsoranalyst: t1dbsponsoranalyst ?? this.t1dbsponsoranalyst,
      vendorPassInfo: activePassInfoList ?? vendorPassInfo,
      passnumbelistresponse:
          passnumbelistresponse ?? this.passnumbelistresponse,
      escortedbyhost: escortedbyhost ?? this.escortedbyhost,
      exceptionalApproval: exceptionalApproval ?? this.exceptionalApproval,
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
        selectedEntities,
        location,
        locationRegion,
        serialnumberResponse,
        getDepositorResponse,
        getuserResponse,
        employeeDepartment,
        selectedDepartment,
        loadAttachments,
        getUserDetailsResponse,
    getHandOverDetailsResponse,
        lawcreateFoundresponse,
        createEmployeeDepartments,
        createOrganisationResponse,
        companyTypes,
        selectedCompanyType,
        createpassFoundresponse,
        dayPassReason,
        vendorPassReason,
        dayPasselementReason,
        vendorPasselementReason,
        t1nameanalyst,
        t1hostanalyst,
        analyst,
        t1dbsponsoranalyst,
        vendorPassInfo,
        passnumbelistresponse,
        escortedbyhost,
        exceptionalApproval,
        radioButtonItem,
        photoAttachments,
        createUserResponse,
        hostResponse,
        dbsponsorResponse,
        nameResponse,
      ];
}
