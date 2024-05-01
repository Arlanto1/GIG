import 'dart:developer';
import 'dart:math' as math;

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/services/create_pass_mgmt_services.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/passmgmtlist/models/day_passlist_model.dart';
import 'package:db_atom/src/services/common_services.dart';

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
            model: PassManagementModel(),
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
        await createPassMgmtCubit.companyTypes(
            name: 'ATOM_COMPANY_TYPES', context: context);
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
          message: Constants.errorText,
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
          getDepositorResponse: getDepositorData.atomStaticUser,
          // stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
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
          message: Constants.errorText,
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
          message: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  getNameUsersResponseData(BaseUser? baseUser) async {
    try {
      emit(
        state.copyWith(
          nameResponse: baseUser,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  // Create user call
  Future<void> createUser(String firstName, String lastName, String email,
      String role, BuildContext context) async {
    try {
      CreateUserModel createUserData = await CommonServices().createUser(
        firstName: firstName,
        lastName: lastName,
        email: email,
        role: role,
        context: context,
      );
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
          message: Constants.errorText,
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
          message: Constants.errorText,
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
  Future<void> getLocations(
      String locationsStr, int? filter, BuildContext context) async {
    try {
      Locations getLocationsData = await commonServices.getRegionsWithLocations(
          name: locationsStr, filter: filter);
      emit(
        state.copyWith(
          getLocationsResponse: getLocationsData,
          // stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  CommonServices commonServices = CommonServices();

  // Serialnumber api  call
  Future<void> getSerialnumberDetails(
    String locationId,
    int passId,
  ) async {
    String moduleCode = Constants.passManagementModule;
    if (passId == ConstantsIntValue.passIdDayPass) {
      moduleCode = Constants.passManagementModule;
    } else if (passId == ConstantsIntValue.passIdVisitor) {
      moduleCode = Constants.visitorManagementModule;
    } else if (passId == ConstantsIntValue.passIdVendor) {
      moduleCode = Constants.vendorPassManagementModule;
    } else if (passId == ConstantsIntValue.passIdSez) {
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
          message: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  Future<void> getPassTypes({
    required int passId,
    required int locationId,
  }) async {
    emit(
      state.copyWith(
        stateType: CreatePassMgmtStateType.loading,
      ),
    );

    log('---passId---$passId--');
    log('---passId--locationId-$locationId--');
    try {
      List<Organisation> passTypes = await createpassmgmtServices.getPassTypes(
          passId: passId, locationId: locationId);
      log('----passTypes.length----${passTypes.length}----'); // it has value

      final updatedState = state.copyWith(
        passTypes: passTypes,
        stateType: CreatePassMgmtStateType.initial,
      );

      emit(updatedState);

      log('----passTypes.length--22222--${updatedState.passTypes?.length}----'); // Should not be null now
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
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
          // stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  // Get pass number call
  Future<void> getPassNumber(
    int passType,
    int locationId,
  ) async {
    try {
      DayPassNumberLists companyTypes = await createpassmgmtServices.getPassNo(
          passType: passType, locationId: locationId);
      emit(
        state.copyWith(
          passnumbelistresponse: companyTypes,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  getPassListResponseData(Organisation org) async {
    log('-org---${org.name}--');

    try {
      emit(
        state.copyWith(
          selectedPassInfo: org,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  // Get employee departments
  Future<List<Organisation>> companyTypes({
    required String name,
    int? filter,
    BuildContext? context,
  }) async {
    List<Organisation> companyTypes = [];
    try {
      companyTypes = await commonServices.getOrganisations(
        name: name,
        filter: filter,
        context: context,
      );
      emit(
        state.copyWith(
          companyTypes: companyTypes,
          // stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
    return companyTypes;
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
          message: Constants.errorText,
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
          // stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
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
          message: Constants.errorText,
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
          // stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
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
          message: Constants.errorText,
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
          message: Constants.errorText,
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
          message: Constants.errorText,
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
          message: Constants.errorText,
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
          message: Constants.errorText,
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
          // stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  Future<void> addAttchment(List<ImageContent>? data) async {
    int eventIds = math.Random.secure().nextInt(5);
    if (data != null) {
      for (var image in data) {
        image.type = 1;
      }
      emit(state.copyWith(
          eventId: eventIds,
          loadAttachments: data,
          stateType: CreatePassMgmtStateType.addattachment));
    }
  }

  Future<void> photoAttchment(List<ImageContent>? data) async {
    int eventIds = math.Random.secure().nextInt(5);
    if (data != null) {
      for (var image in data) {
        image.type = 2;
      }
      emit(state.copyWith(
          eventId: eventIds,
          photoAttachments: data,
          stateType: CreatePassMgmtStateType.photoattachment));
    }
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
          // stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  initialization() {
    state.passTypes = [];
    state.showIdentifiedFields = false;
    state.selectedDepartment = null;
    state.employeeDepartment = null;
    state.companyTypes = [];
    state.selectedPassInfo = Organisation();
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

  initializeValues({
    required PassManagementModel model,
    required int passId,
  }) async {
    log('---initializeValues----');

    emit(
      state.copyWith(
        model: PassManagementModel(),
        selectedEntities: model.entities,
        stateType: CreatePassMgmtStateType.loading,
      ),
    );

    try {
      Organisation? defaultLocation;
      SerialNumberModel serialNumberResponse = SerialNumberModel();
      List<Organisation> passTypes = [];
      DayPassNumberLists companyTypes = DayPassNumberLists();
      if (passId != ConstantsIntValue.passIdSez) {
        if (model.location == null) {
          defaultLocation = await SharedPrefs.getDefaultLocation();
        } else {
          defaultLocation = model.location;
        }

        String moduleCode = Constants.passManagementModule;
        if (passId == ConstantsIntValue.passIdDayPass) {
          moduleCode = Constants.passManagementModule;
        } else if (passId == ConstantsIntValue.passIdVisitor) {
          moduleCode = Constants.visitorManagementModule;
        } else if (passId == ConstantsIntValue.passIdVendor) {
          moduleCode = Constants.vendorPassManagementModule;
        } else if (passId == ConstantsIntValue.passIdSez) {
          moduleCode = Constants.passManagementSEZModule;
        }

        if (model.slNo.isEmptyOrNull) {
          serialNumberResponse = await commonServices.getSlNo(
            locationId: defaultLocation!.id.toString(),
            moduleCode: moduleCode,
          );
        }

        // await getSerialnumberDetails(defaultLocation.id.toString(), passId);

        passTypes = await createpassmgmtServices.getPassTypes(
            passId: passId, locationId: defaultLocation!.id!);
        // await getPassTypes(passId: passId, locationId: defaultLocation.id!);

        companyTypes = await createpassmgmtServices.getPassNo(
            passType: passId, locationId: defaultLocation.id!);
      }

      List<Organisation> updateStatuses = [];
      if (model.status != null && (model.status == 0 || model.status == 1)) {
        updateStatuses = await commonServices.getStatusesByModuleId(
            module: Constants.passManagementModuleCode, filter: model.status);
      }

      emit(state.copyWith(
        location: defaultLocation,
        updateStatuses: updateStatuses,
        passnumbelistresponse: companyTypes,
        passTypes: passTypes,
        getSerialnumberResponse: serialNumberResponse,
        stateType: CreatePassMgmtStateType.success,
      ));

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
            selectedEntities: model.entities,
            showIdentifiedFields: false,
            stateType: CreatePassMgmtStateType.success,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  getEntityData(List<Organisation> selectedEntities) async {
    try {
      int eventIds = math.Random.secure().nextInt(5);
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
          message: Constants.errorText,
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
          message: Constants.errorText,
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
          message: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  Future<String> getPassValidUntil({required int passCategory}) async {
    String passValidUntilDate = '';
    try {
      passValidUntilDate = await createpassmgmtServices.getPassValidUntil(
          passCategory: passCategory);
      log('-111--getPassValidUntil---$passValidUntilDate---');

      List<Organisation> updatedCompanyTypes = await companyTypes(
          name: 'ATOM_SEZ_COMPANY_TYPES', filter: passCategory);

      if (passCategory == ConstantsIntValue.passCategoryPermanent) {
        state.selectedCompanyType = state.companyTypes?.first;
      } else {
        state.selectedCompanyType = null;
      }

      emit(
        state.copyWith(
          passValidUntilDate: passValidUntilDate,
          companyTypes: updatedCompanyTypes,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
    return passValidUntilDate;
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
          message: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  // Create new Found Article successfully API call
  Future<void> createPass({
    required CreatePassMgmtBody bodyRequest,
    required bool isSubmit,
    required String username,
    required String title,
  }) async {
    emit(
      state.copyWith(
        stateType: CreatePassMgmtStateType.loading,
      ),
    );
    try {
      CreatePassMgmtResponse? response =
          await createpassmgmtServices.createPass(
        requestBody: bodyRequest,
        isSubmit: isSubmit,
      ); //replace empty model with bodyRequest
      emit(
        state.copyWith(
          createpassFoundresponse: response,
          stateType: CreatePassMgmtStateType.successFormSubmit,
          message: response.message ?? '',
        ),
      );
    } on GenericResponse catch (e) {
      Utils().emitErrorState(e, emit, state);
      return;
    } on Exception catch (e) {
      emit(
        state.copyWith(
          message: e.toString(),
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );

      // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      //   dismissLoadingDialog(context);
      //   Utils.dynamicAlert(
      //       context, Constants.errorText, title, Constants.errorText);
      // });
    }
  }

  getRadioButtonSelected(String name, int value, String radio) async {
    try {
      emit(
        state.copyWith(
          escortedbyhost: value,
          exceptionalApproval: value,
          radioButtonItem: radio,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          stateType: CreatePassMgmtStateType.failure,
        ),
      );
    }
  }

  Future<void> updateStatus({required String id}) async {
    String module = '';
    PassMngArguments? passMngArguments;
    if (passMngArguments?.passType == 0) {
      module = Constants.passManagementModule;
    } else if (passMngArguments?.passType == 1) {
      module = Constants.visitorManagementModule;
    } else if (passMngArguments?.passType == 2) {
      module = Constants.vendorPassManagementModule;
    } else if (passMngArguments?.passType == 3) {
      module = Constants.passManagementSEZModule;
    }
    await commonServices.updateRecordStatus(id: id, module: module);
  }

  Future<void> updateDropdownValues({
    Organisation? updateStatus,
  }) async {
    emit(
      state.copyWith(
        stateType: CreatePassMgmtStateType.loading,
      ),
    );

    if (updateStatus != null) {
      state.model.updatedStatus = updateStatus.id;
    }

    emit(state.copyWith(
      model: state.model,
      stateType: CreatePassMgmtStateType.initial,
    ));
  }

  Future<void> refreshList() async {
    emit(state.copyWith(stateType: CreatePassMgmtStateType.loading));
    List<Organisation>? entities =
        await commonServices.getOrganisations(name: 'ATOM_ENTITIES');
    EmployeeDepartments departments =
        await commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS');
    List<BaseUser> emailUsers =
        await commonServices.getBaseUsersByRoles(roleNames: 'ATOM_STATIC_USER');
    emit(
      state.copyWith(
        // getEntitiesResponse: entities,
        // listOfEntities: entities,
        stateType: CreatePassMgmtStateType.initial,
        // users: users.t1Analyst,
        emailUsers: emailUsers,
        getDepositorResponse: emailUsers,
        // departments: departments.employeeDepartments,
      ),
    );
  }
}
