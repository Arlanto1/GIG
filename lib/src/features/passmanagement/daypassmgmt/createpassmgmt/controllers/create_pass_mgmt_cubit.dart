import 'dart:math';

import 'package:db_atom/src/common_widgets/cubits.dart';
import 'package:db_atom/src/common_widgets/spinnerdialog.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/createfound/models/create_user_model.dart';
import 'package:db_atom/src/features/createfound/models/emplyee_departments_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/serial_number_model.dart';
import 'package:db_atom/src/features/lawenforcement/models/addentities.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/controllers/create_pass_mgmt_state.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/analyst_model.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/company_type_model.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/create_pass_mgmt_request_body.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/create_pass_mgmt_response.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/day_pass_numbers_list.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/day_pass_reason_model.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/vendor_pass_reason_model.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/services/create_pass_mgmt_services.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/passmgmtlist/models/day_passlist_model.dart';
import 'package:db_atom/src/models/image_content.dart';
import 'package:db_atom/src/services/CommonServices.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/base_user.dart';
import '../../../../../models/organisation.dart';
import '../../../../createfound/models/get_depositor_model.dart';
import '../../../../createfound/models/user.dart';

class CreatePassMgmtCubit extends Cubit<CreatePassMgmtState> {
  CreatePassMgmtService createpassmgmtServices;
  List<ImageContent>? loadAttachments;
  List<ImageContent>? photoAttachments;

  CreatePassMgmtCubit({
    required this.createpassmgmtServices,
    this.loadAttachments,
    this.photoAttachments,
  }) : super(
          CreatePassMgmtState(
            //lawenforcementServices: SubmitCreateFoundModel(),
            stateType: CreatePassMgmtStateType.initial,
          ),
        );

  Future<void> createOrganisation(
      String name, String orgName, BuildContext context, String title) async {
    try {
      Organisation createOrganisationData = await commonServices
          .createOrganisation(name: name, orgName: orgName, context: context);
      emit(
        state.copyWith(
          createOrganisationResponse: createOrganisationData,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
      if (Constants.addcompanytype == title) {
        await createPassMgmtCubit.companyTypes('ATOM_COMPANY_TYPES', context);
      } else if (Constants.addreasonfordaypass == title ||
          Constants.addreasonforvendorpass == title) {
        await createPassMgmtCubit.getDayPassreasons('DAY_PASS_REASON', context);
      } else if (Constants.addreasonforvendorpass == title ||
          Constants.addreasonforvendorpass == title) {
        await createPassMgmtCubit.getVendorPassreasons(
            'VENDOR_PASS_REASON', context);
      } else if (Constants.addentitytype == title) {
        await createPassMgmtCubit.getEntities('ATOM_ENTITIES', context);
      }
      dismissLoadingDialog(context);
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Utils.dynamicAlert(context, 'Added sucessfully', title, '');
      });
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
      dismissLoadingDialog(context);
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Utils.dynamicAlert(context, Constants.errorText,
            Constants.addarticletype, Constants.errorText);
      });
    }
  }

  // get depositor user by role API call
  Future<void> getUserByRoleDepositor(
      String userRole, BuildContext context) async {
    try {
      GetDepositor getDepositorData = await createpassmgmtServices
          .getUserByRoleDepositor(roleName: userRole);

      emit(
        state.copyWith(
          getDepositorResponse: getDepositorData,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  gethostUsersResponseData(User? hostResponse) async {
    try {
      emit(
        state.copyWith(
          hostResponse: hostResponse,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  getdbsponsorUsersResponseData(User? dbsponsorResponse) async {
    try {
      emit(
        state.copyWith(
          dbsponsorResponse: dbsponsorResponse,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  getNameUsersResponseData(BaseUser? userresponsedata) async {
    try {
      emit(
        state.copyWith(
          nameResponse: userresponsedata,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  // Create user call
  Future<void> createUser(String firstName, String lastName, String email,
      String role, BuildContext context) async {
    try {
      CreateUserModel createUserData = await createpassmgmtServices.createUser(
          firstName, lastName, email, role, context);
      emit(
        state.copyWith(
          createUserResponse: createUserData,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
      await createPassMgmtCubit.getAnalysts('T1_Analyst', context);
      dismissLoadingDialog(context);
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Utils.dynamicAlert(context, 'Added sucessfully', Constants.newuser, '');
      });
    } catch (e) {
      dismissLoadingDialog(context);
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  // law organisation call
  Future<void> createEmployeeDepartments(
      String name, String orgName, BuildContext context) async {
    try {
      Organisation createEmployeeDeptData = await commonServices
          .createOrganisation(name: name, orgName: orgName, context: context);
      emit(
        state.copyWith(
          createEmployeeDepartments: createEmployeeDeptData,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
      dismissLoadingDialog(context);
      await lawEnforcementCubit.getEmployeeDepartments(
          'EMPLOYEE_DEPARTMENTS', context);
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Utils.dynamicAlert(
            context, 'Added sucessfully', Constants.addemployeedepartment, '');
      });
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
      dismissLoadingDialog(context);
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Utils.dynamicAlert(context, Constants.errorText,
            Constants.addemployeedepartment, Constants.errorText);
      });
    }
  }

  // Get locations api call
  Future<void> getLocations(String locationsStr, BuildContext context) async {
    try {
      GetLocations getLocationsData =
          await createpassmgmtServices.getLocations(name: locationsStr);
      emit(
        state.copyWith(
          getLocationsResponse: getLocationsData,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  CommonServices commonServices = CommonServices();

  // Serialnumber api  call
  Future<void> getSerialnumberDetails(
    String locationId,
    String passId,
    BuildContext context,
  ) async {
    String moduleCode = Constants.passManagementModule;
    if (passId == "0") {
      moduleCode = Constants.passManagementModule;
    } else if (passId == "1") {
      moduleCode = Constants.visitorManagementModule;
    } else if (passId == "2") {
      moduleCode = Constants.vendorPassManagementModule;
    } else if (passId == "3") {
      moduleCode = Constants.passManagementSEZModule;
    }
    try {
      SerialNumberModel serialNumberResponse = await commonServices.getSlNo(
        locationId: locationId,
        moduleCode: moduleCode,
      );
      emit(
        state.copyWith(
          getSerialnumberResponse: serialNumberResponse,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  // Get employee departments
  Future<void> getEmployeeDepartments(
      String departmentStr, BuildContext context) async {
    try {
      EmployeeDepartments getEmployeeDepartments = await commonServices
          .getDepartments(name: departmentStr, context: context);
      emit(
        state.copyWith(
          employeeDepartment: getEmployeeDepartments,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  // Get pass number call
  Future<void> getPassNumber(
    String passType,
    String locationId,
    BuildContext context,
  ) async {
    try {
      DayPassNumberLists companyTypes =
          await createpassmgmtServices.getPassNo(passType, locationId, context);
      emit(
        state.copyWith(
          passnumbelistresponse: companyTypes,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  getpassListResponseData(Organisation? companytypeResponse) async {
    try {
      emit(
        state.copyWith(
          activePassInfoList: companytypeResponse,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  // Get employee departments
  Future<void> companyTypes(String companyStr, BuildContext context) async {
    try {
      // CompanyTypes companyTypes =
      //     await createpassmgmtServices.getCompanyTypes(companyStr, context);

      CompanyTypes companyTypes = await commonServices.getCompanyTypes(
          name: companyStr, context: context);
      emit(
        state.copyWith(
          companyTypes: companyTypes,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  selectedCompanyType(Organisation companyType) async {
    if (companyType.name != null && companyType.name!.contains('CWR')) {
      emit(
        state.copyWith(
          showIdentifiedFields: true,
          selectedCompanyType: companyType,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
    } else {
      emit(
        state.copyWith(
          showIdentifiedFields: false,
          selectedCompanyType: companyType,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
    }

    try {
      emit(
        state.copyWith(
          selectedCompanyType: companyType,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  // Get day pass reasons
  Future<void> getDayPassreasons(
      String companyStr, BuildContext context) async {
    try {
      // DayPassReason dayPassreasons =
      //     await createpassmgmtServices.getDayPassreason(companyStr, context);

      DayPassReason dayPassreasons = await commonServices.getDayPassreason(
          name: companyStr, context: context);
      emit(
        state.copyWith(
          dayPassReason: dayPassreasons,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  getdaypassreasonResponseData(Organisation? passReasonResponse) async {
    try {
      emit(
        state.copyWith(
          dayPasselementReason: passReasonResponse,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  Future<void> getVendorPassreasons(
      String companyStr, BuildContext context) async {
    try {
      // DayPassReason dayPassreasons =
      //     await createpassmgmtServices.getDayPassreason(companyStr, context);

      VendorPassReason vendorPassreasons = await commonServices
          .getVendorPassReason(name: companyStr, context: context);
      emit(
        state.copyWith(
          vendorPassReason: vendorPassreasons,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  getVendorPassReasonResponseData(
      Organisation? vendorPassReasonResponse) async {
    try {
      emit(
        state.copyWith(
          vendorPasselementReason: vendorPassReasonResponse,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  // Get analysts response
  Future<void> getAnalysts(String companyStr, BuildContext context) async {
    try {
      // Analyst companyTypes =
      //     await createpassmgmtServices.getAnalyst(companyStr, context);

      Analyst companyTypes = await commonServices.getUsersByRole(
          roleName: companyStr, context: context);
      emit(
        state.copyWith(
          analyst: companyTypes,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  getnameanalystsResponseData(BaseUser? companytypeResponse) async {
    try {
      emit(
        state.copyWith(
          t1nameanalyst: companytypeResponse,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  gethostanalystsResponseData(User? host) async {
    try {
      emit(
        state.copyWith(
          t1hostanalyst: host,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  getdbsponsoranalystsResponseData(
    User? companytypeResponse,
  ) async {
    try {
      emit(
        state.copyWith(
          t1dbsponsoranalyst: companytypeResponse,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  /// Get entities api call
  Future<void> getEntities(String name, BuildContext context) async {
    try {
      AddEntities entities = await createpassmgmtServices.getEntities(
          name: name, context: context);
      emit(
        state.copyWith(
          getEntitiesResponse: entities,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  Future<void> addAttchment(List<ImageContent>? data) async {
    int eventIds = Random.secure().nextInt(5);

    emit(state.copyWith(
        eventId: eventIds,
        loadAttachments: data,
        stateType: CreatePassMgmtStateType.addattachment));
  }

  Future<void> photoAttchment(List<ImageContent>? data) async {
    int eventIds = Random.secure().nextInt(5);

    emit(state.copyWith(
        eventId: eventIds,
        photoAttachments: data,
        stateType: CreatePassMgmtStateType.photoattachment));
  }

  // Get user details call
  Future<void> getUserDetails(String userId, BuildContext context) async {
    try {
      // User getUserData =
      //     await createpassmgmtServices.getUserDetails(userId, context);

      User getUserData =
          await commonServices.getUserDetails(userId: userId, context: context);
      emit(
        state.copyWith(
          getUserDetailsResponse: getUserData,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  initialization() {
    state.showIdentifiedFields = false;
    state.selectedDepartment = null;
    state.employeeDepartment = null;
    state.companyTypes = CompanyTypes();
    state.vendorPassInfo = Organisation();
    state.loadAttachments = [];
    state.selectedCompanyType = null;
    state.selectedEntities = [];
    state.location = Organisation();
    state.photoAttachments = [];
    state.getuserResponse = BaseUser();
    state.serialnumberResponse?.serialNo = '';
    state.getSerialnumberResponse = SerialNumberModel();
    state.t1hostanalyst = User();
    state.t1nameanalyst = BaseUser();
    state.hostResponse = User();
    state.nameResponse = BaseUser();
    state.dbsponsorResponse = User();
    state.getUserDetailsResponse = User();
    state.dayPasselementReason = Organisation();
  }

  initializeValues(DayPassListElement model) async {
    emit(
      state.copyWith(
        selectedEntities: model.entities,
        stateType: CreatePassMgmtStateType.success,
      ),
    );
    try {
      if (model.companyType?.name != null &&
          model.companyType!.name!.contains('CWR')) {
        emit(
          state.copyWith(
            selectedEntities: model.entities,
            showIdentifiedFields: true,
            stateType: CreatePassMgmtStateType.success,
          ),
        );
      } else {
        emit(
          state.copyWith(
            showIdentifiedFields: false,
            stateType: CreatePassMgmtStateType.success,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  getEntityData(List<Organisation> selectedEntities) async {
    try {
      int eventIds = Random.secure().nextInt(5);
      emit(
        state.copyWith(
          eventId: eventIds,
          selectedEntities: selectedEntities,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  selectedEmployeeDepartment(Organisation employeeDepartment) async {
    try {
      emit(
        state.copyWith(
          selectedEmployeeDepartment: employeeDepartment,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  getlocationsResponseData(Organisation? location) async {
    try {
      emit(
        state.copyWith(
          location: location,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  getSerialnumberResponse(SerialNumberModel? serialnumberResponse) async {
    try {
      emit(
        state.copyWith(
          serialnumberResponse: serialnumberResponse,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  // Create new Found Article successfully API call
  Future<void> createPass(CreatePassMgmtBody bodyRequest, bool isSubmit,
      BuildContext context, String username, String title) async {
    try {
      CreatePassMgmtResponse? response =
          await createpassmgmtServices.createPass(
        requestBody: bodyRequest,
        isSubmit: isSubmit,
      ); //replace empty model with bodyRequest
      emit(
        state.copyWith(
          createpassFoundresponse: response,
          stateType: CreatePassMgmtStateType.success,
        ),
      );

      if (response.message != null) {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          dismissLoadingDialog(context);
          Utils.dynamicAlert(context, response.message ?? '', title, '');
        });
      }
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );

      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        dismissLoadingDialog(context);
        Utils.dynamicAlert(
            context, Constants.errorText, title, Constants.errorText);
      });
    }
  }

  getRadioButtonSelected(String name, int value, String radio) async {
    try {
      emit(
        state.copyWith(
          escortedbyhost: value,
          radioButtonItem: radio,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }
}
