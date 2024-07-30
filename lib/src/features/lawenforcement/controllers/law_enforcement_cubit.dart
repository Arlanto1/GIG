import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/lawenforcement/controllers/law_enforcement_state.dart';
import 'package:db_atom/src/features/lawenforcement/models/distribution_model.dart';
import 'package:db_atom/src/features/lawenforcement/models/dropdown_object.dart';
import 'package:db_atom/src/features/lawenforcement/models/law_enforement_request.dart';
import 'package:db_atom/src/features/lawenforcement/models/leopurposevisit.dart';
import 'package:db_atom/src/features/lawenforcement/services/law_enforcement_services.dart';

class LawEnforcementCubit extends Cubit<LawEnforcementState> {
  LawEnforcementServices services;
  List<ImageContent>? loadAttachments;
  LawEnforcementDetailsModel? model;

  LawEnforcementCubit({required this.services, this.loadAttachments})
      : super(
          LawEnforcementState(
            model: LawEnforcementDetailsModel(),
            status: FormStatus.initial,
          ),
        );

  CommonServices commonServices = CommonServices();

//
//law organisation call
  Future<void> createOrganisation(
      String name, String orgName, BuildContext context, String title) async {
    try {
      Organisation createOrganisationData = await services.createOrganisation(
        name,
        orgName,
      );
      emit(
        state.copyWith(
          model: model,
          createOrganisationResponse: createOrganisationData,
          status: FormStatus.success,
        ),
      );
      if (Constants.addentitytype == title) {
        await lawEnforcementCubit.getEntities('ATOM_ENTITIES');
      } else if (Constants.addpurposeofvisittype == title) {
        await lawEnforcementCubit.getLeoPurposeOfVisits(
          'ATOM_LEO_PURPOSE_VISIT',
        );
      } else if (Constants.addleoofficialtype == title) {
        await lawEnforcementCubit.getLeoDepartments('ATOM_LEO_DEPARTMENTS');
      }

      dismissLoadingDialog(context);

      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Utils.dynamicAlert(context, 'Added sucessfully', title, '');
      });
    } on GenericResponse catch (e) {
      // emit(
      //   state.copyWith(
      //     model: model,
      //     message: e.message,
      //     status: FormStatus.failure,
      //   ),
      // );
      dismissLoadingDialog(context);
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Utils.dynamicAlert(context, e.message ?? '', Constants.addarticletype,
            Constants.errorText);
      });
    } on Exception catch (e) {
      emit(
        state.copyWith(
          message: e.toString(),
          status: FormStatus.error,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          model: model,
          message: e.toString(),
          status: FormStatus.failure,
        ),
      );
      dismissLoadingDialog(context);
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Utils.dynamicAlert(context, Constants.errorText,
            Constants.addarticletype, Constants.errorText);
      });
    }
  }

  // law organisation call
  Future<void> createEmployeeDepartments(
      String name, String orgName, BuildContext context) async {
    try {
      Organisation createEmployeeDeptData = await services.createOrganisation(
        name,
        orgName,
      );
      emit(
        state.copyWith(
          createEmployeeDepartments: createEmployeeDeptData,
          status: FormStatus.success,
        ),
      );
      dismissLoadingDialog(context);
      await lawEnforcementCubit.getEmployeeDepartments(
        'EMPLOYEE_DEPARTMENTS',
      );
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Utils.dynamicAlert(
            context, 'Added successfully', Constants.addemployeedepartment, '');
      });
    } on GenericResponse catch (e) {
      Utils().emitErrorState(e, emit, state);
      return;
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          status: FormStatus.failure,
        ),
      );
      dismissLoadingDialog(context);
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Utils.dynamicAlert(context, Constants.errorText,
            Constants.addemployeedepartment, Constants.errorText);
      });
    }
  }

  // Create new Found Article successfully API call
  FutureOr<bool> submitForm({
    required LawEnforcementRequestBody bodyRequest,
    required bool isSubmit,
    required String title,
    required bool navigateToNextScreen,
  }) async {
    emit(state.copyWith(status: FormStatus.loading));
    try {
      SubmitLawEnforcementResponse? response =
          await services.createLawFoundArticle(
        body: bodyRequest,
        isSubmit: isSubmit,
      ); //replace empty model with bodyRequest

      state.model?.id = int.tryParse(response.lawEnforcementId!);
      emit(
        state.copyWith(
          model: state.model,
        ),
      );

      emit(
        state.copyWith(
          submitResponse: response,
          status: navigateToNextScreen
              ? FormStatus.navigateToNextScreen
              : FormStatus.successFormSubmit,
          message: response.message ?? '',
          model: state.model,
        ),
      );
      return true;
    } on GenericResponse catch (e) {
      Utils().emitErrorState(e, emit, state);
      return false;
    } on Exception catch (e) {
      emit(
        state.copyWith(
          message: e.toString(),
          status: FormStatus.failure,
        ),
      );
      return false;
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          status: FormStatus.failure,
        ),
      );
      return false;
    }
  }

  // Get locations api call
  Future<void> getLocations(String name, BuildContext context) async {
    try {
      Locations getLocationsData =
          await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');
      emit(
        state.copyWith(
          getLocationsResponse: getLocationsData,
          status: FormStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          status: FormStatus.failure,
        ),
      );
    }
  }

  // Serialnumber api  call
  Future<void> getSerialnumberDetails(
    String locationId,
    String moduleCode,
  ) async {
    log('----Generate Serial Number-----------');
    try {
      SerialNumberModel response = await services.getSerialnumberDetails(
        locationId,
        moduleCode,
      );

      getDBofficialByRoleDepositor(ConstantUserRoles.atomStaticUser);
      emit(
        state.copyWith(
          slno: response.serialNo,
          status: FormStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          status: FormStatus.failure,
        ),
      );
    }
  }

  // Distribution groups api  call
  Future<void> getDistributionGroupsDetails() async {
    try {
      DistributionGroupModel getResponse =
          await services.getDistributionGroupDetails();
      emit(
        state.copyWith(
          groups: getResponse,
          status: FormStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          status: FormStatus.failure,
        ),
      );
    }
  }

  // Get employee departments
  Future<void> getEmployeeDepartments(
    String departmentStr,
  ) async {
    try {
      EmployeeDepartments getEmployeeDepartments =
          await services.getEmployeeDepartments(
        departmentStr,
      );
      emit(
        state.copyWith(
          employeeDepartment: getEmployeeDepartments,
          status: FormStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          status: FormStatus.failure,
        ),
      );
    }
  }

  // Get compant types departments
  Future<void> getCompanytypes(
    String departmentStr,
  ) async {
    try {
      EmployeeDepartments getEmployeeDepartments =
          await services.getEmployeeDepartments(
        departmentStr,
      );
      emit(
        state.copyWith(
          employeeDepartment: getEmployeeDepartments,
          status: FormStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          status: FormStatus.failure,
        ),
      );
    }
  }

// Get entities api call
  Future<void> getEntities(String name) async {
    try {
      AddEntities entities = await services.getEntities(name);
      emit(
        state.copyWith(
          getEntitiesResponse: entities,
          status: FormStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          status: FormStatus.failure,
        ),
      );
    }
  }

  Future<void> addAttchment(List<ImageContent>? data) async {
    int eventIds = math.Random.secure().nextInt(5);

    emit(state.copyWith(
        eventId: eventIds,
        loadAttachments: data,
        status: FormStatus.addAttachment));
  }

  Future<void> addingVisits({
    required int visitCount,
    List<VisitingOfficialsModel>? getVisits,
  }) async {
    //int eventIds = Random.secure().nextInt(5);
    emit(
      state.copyWith(
        visitingOfficials: getVisits,
        getVisitsCount: visitCount,
        status: FormStatus.success,
      ),
    );
  }

  // Get user details call
  Future<void> getUserDetails(
    String userId,
  ) async {
    try {
      User getUserData = await services.getUserDetails(
        userId,
      );
      emit(
        state.copyWith(
          getUserDetailsResponse: getUserData,
          status: FormStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          status: FormStatus.failure,
        ),
      );
    }
  }

  initializeValuesForExistingRecord(
      {required LawEnforcementDetailsModel model}) async {
    emit(state.copyWith(
      slno: model.slNo,
    ));
  }

  initializeValuesForNewRecord() async {
    log('---initializeValues--');
    lawEnforcementCubit.state.visitingOfficials = [];
    state.getVisitsCount = 0;
    state.selectedemployeeDepartmentResponse = Organisation();
    state.loadAttachments = [];
    //state.getUserDetailsResponse =  GetUserDetails();
    state.listOfEntities = [];
    state.locationSelectedlist = Organisation();
    state.leoDepartmentsResponse = Organisation();
    state.leoPurposeVisitResponse = Organisation();
    state.loadAttachments = [];
    state.isDocumentifanySelected = 1;
    state.isIncaseofpoliceSelected = 1;
    state.isOfficialIdcardSelected = 1;
    state.dBOfficialEmailIdAccompaniedLeoOfficial = BaseUser();
    state.serialnumberResponse?.serialNo = '';
    state.slno = '';

    Organisation? defaultLocation = await SharedPrefs.getDefaultLocation();

    SerialNumberModel serialNumberResponse;
    serialNumberResponse = await commonServices.getSlNo(
      locationId: defaultLocation!.id.toString(),
      moduleCode: Constants.leoModuleCode,
    );

    log('---initializeValues---${serialNumberResponse.serialNo}-');

    emit(state.copyWith(
      locationSelectedlist: defaultLocation,
      slno: serialNumberResponse.serialNo,
    ));
  }

  // Get leodepartments api call
  Future<void> getLeoDepartments(String name) async {
    try {
      LeoDepartments departments = await services.getLeodepartments(name);
      emit(
        state.copyWith(
          getLeodepartmentsResponse: departments,
          status: FormStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          status: FormStatus.failure,
        ),
      );
    }
  }

  // Create user call
  Future<void> createUser(String firstName, String lastName, String email,
      String role, int locationId, BuildContext context) async {
    try {
      CreateUserModel createUserData = await services.createUser(
          firstName, lastName, email, role, locationId);
      emit(
        state.copyWith(
          createUserResponse: createUserData,
          status: FormStatus.success,
        ),
      );
      dismissLoadingDialog(context);
      await lawEnforcementCubit
          .getDBofficialByRoleDepositor(ConstantUserRoles.atomStaticUser);
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Utils.dynamicAlert(
            context, 'Added successfully', Constants.newuser, '');
      });
    } on GenericResponse catch (e) {
      emit(
        state.copyWith(
          model: model,
          message: Constants.errorText,
          status: FormStatus.failure,
        ),
      );
      dismissLoadingDialog(context);
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Utils.dynamicAlert(context, e.message ?? '', Constants.addarticletype,
            Constants.errorText);
      });
    } on Exception catch (e) {
      emit(
        state.copyWith(
          message: e.toString(),
          status: FormStatus.error,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          status: FormStatus.failure,
        ),
      );
      dismissLoadingDialog(context);
    }
  }

  // Get leopurposeofvisit api call
  Future<void> getLeoPurposeOfVisits(
    String name,
  ) async {
    try {
      LeoPurposeVisit response = await services.getLeoPurposeOfVisits(
        name,
      );
      emit(
        state.copyWith(
          purposeList: response,
          status: FormStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          status: FormStatus.failure,
        ),
      );
    }
  }

  // get DB Official email ID Accompanied LEO official API call
  Future<void> getDBofficialByRoleDepositor(String roleName) async {
    try {
      List<BaseUser>? getDepositorData = await commonServices.getBaseUsers(
        roleName: roleName,
        locationId: state.locationSelectedlist?.id,
      );
      emit(
        state.copyWith(
          getDepositorResponse: getDepositorData,
          status: FormStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          status: FormStatus.failure,
        ),
      );
    }
  }

  getDBOfficialEmailIdAccompaniedLeoOfficial(BaseUser user) async {
    try {
      emit(
        state.copyWith(
          dBOfficialEmailIdAccompaniedLeoOfficial: user,
          status: FormStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          status: FormStatus.failure,
        ),
      );
    }
  }

  getEntityData(List<Organisation> listOfEntities) async {
    try {
      int eventIds = math.Random.secure().nextInt(5);
      emit(
        state.copyWith(
          eventId: eventIds,
          listOfEntities: listOfEntities,
          status: FormStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          status: FormStatus.failure,
        ),
      );
    }
  }

  getleoDepartmentsResponseData(Organisation leoDepartmentsResponse) async {
    try {
      emit(
        state.copyWith(
          leoDepartmentsResponse: leoDepartmentsResponse,
          status: FormStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          status: FormStatus.failure,
        ),
      );
    }
  }

  getemployeeDepartmentsResponseData(Organisation employeedepartment) async {
    try {
      emit(
        state.copyWith(
          selectedemployeeDepartmentResponse: employeedepartment,
          status: FormStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          status: FormStatus.failure,
        ),
      );
    }
  }

  getleopurposeResponseData(Organisation? leoPurposeVisitResponse) async {
    try {
      emit(
        state.copyWith(
          leoPurposeVisitResponse: leoPurposeVisitResponse,
          status: FormStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          status: FormStatus.failure,
        ),
      );
    }
  }

  getlocationsResponseData(Organisation? org) async {
    try {
      emit(
        state.copyWith(
          locationSelectedlist: org,
          status: FormStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          status: FormStatus.failure,
        ),
      );
    }
  }

  setSerialnumberResponse(SerialNumberModel? serialnumberResponse) async {
    try {
      emit(
        state.copyWith(
          serialnumberResponse: serialnumberResponse,
          status: FormStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          status: FormStatus.failure,
        ),
      );
    }
  }

  getRadioButtonSelected(String name, int value, String radio) async {
    try {
      if (name == Constants.officialsidcardverified) {
        emit(
          state.copyWith(
            isOfficialIdcardSelected: value,
            radioButtonItem: radio,
            status: FormStatus.success,
          ),
        );
      } else if (name == Constants.documentifanytoconfirmpurpose) {
        emit(
          state.copyWith(
            isDocumentifanySelected: value,
            radioButtonItem: radio,
            status: FormStatus.success,
          ),
        );
      } else if (name == Constants.incaseofpolicewasofficialinuniform) {
        emit(
          state.copyWith(
            isIncaseofpoliceSelected: value,
            radioButtonItem: radio,
            status: FormStatus.success,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          status: FormStatus.failure,
        ),
      );
    }
  }

  getDistributed(bool isDistributed) async {
    try {
      emit(
        state.copyWith(
          isDistributed: isDistributed,
          status: FormStatus.success,
        ),
      );
    } catch (e) {
      // emit(
      //   state.copyWith(
      //     errorMessage: Constants.errorText,
      //     stateType: LawEnforcementStateType.failure,
      //   ),
      // );
    }
  }

  Future<void> updateStatus({required String id}) async {
    await CommonServices()
        .updateRecordStatus(id: id, module: Constants.leoModuleCode);
  }
// void onModelValueChange(LawEnforcementDetails model) {
//   log('-onModelValueChange---');
//   emit(state.copyWith(model: model, status: FormStatus.initial));
// }
}
