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
import 'package:db_atom/src/services/common_services.dart';

class LawEnforcementCubit extends Cubit<LawEnforcementState> {
  LawEnforcementServices services;
  List<ImageContent>? loadAttachments;

  LawEnforcementCubit({required this.services, this.loadAttachments})
      : super(
          LawEnforcementState(
            model: LawEnforcementDetailsModel(),
            status: FormStatus.initial,
          ),
        );

//
//law organisation call
  Future<void> createOrganisation(
      String name, String orgName, BuildContext context, String title) async {
    try {
      Organisation createOrganisationData =
          await services.createOrganisation(name, orgName, context);
      emit(
        state.copyWith(
          createOrganisationResponse: createOrganisationData,
          status: FormStatus.success,
        ),
      );
      if (Constants.addentitytype == title) {
        await lawEnforcementCubit.getEntities('ATOM_ENTITIES');
      } else if (Constants.addpurposeofvisittype == title) {
        await lawEnforcementCubit.getLeopurposeofvisit(
            'ATOM_LEO_PURPOSE_VISIT', context);
      } else if (Constants.addleoofficialtype == title) {
        await lawEnforcementCubit.getLeodepartments('ATOM_LEO_DEPARTMENTS');
      }

      dismissLoadingDialog(context);

      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Utils.dynamicAlert(context, 'Added sucessfully', title, '');
      });
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
            Constants.addarticletype, Constants.errorText);
      });
    }
  }

  // law organisation call
  Future<void> createEmplyeeDepartments(
      String name, String orgName, BuildContext context) async {
    try {
      Organisation createEmployeeDeptData =
          await services.createOrganisation(name, orgName, context);
      emit(
        state.copyWith(
          createEmployeeDepartments: createEmployeeDeptData,
          status: FormStatus.success,
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

      log('---response.lawEnforcementId-----${response.lawEnforcementId}');

      state.model?.id = int.tryParse(response.lawEnforcementId!);
      emit(
        state.copyWith(
          model: state.model,
        ),
      );

      log('---state.model?.id-----${state.model?.id}');

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
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.failure,
        ),
      );
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
      Locations getLocationsData = await services.getLocations(name, context);
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
      String locationid, String modulecode, BuildContext context) async {
    try {
      SerialNumberModel getserialnumberResponse = await services
          .getSerialnumberDetails(locationid, modulecode, context);
      emit(
        state.copyWith(
          getSerialnumberResponse: getserialnumberResponse,
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
  Future<void> getDistributionGroupsDetails(BuildContext context) async {
    try {
      DistributionGroupModel getResponse =
          await services.getDistributiongroupDetails(context);
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
      String departmentStr, BuildContext context) async {
    try {
      EmployeeDepartments getEmployeeDepartments =
          await services.getEmployeeDepartments(departmentStr, context);
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
      String departmentStr, BuildContext context) async {
    try {
      EmployeeDepartments getEmployeeDepartments =
          await services.getEmployeeDepartments(departmentStr, context);
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
  Future<void> getUserDetails(String userId, BuildContext context) async {
    try {
      User getUserData = await services.getUserDetails(userId, context);
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

  initalization() {
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
    state.getuserResponse = BaseUser();
    state.serialnumberResponse?.serialNo = '';
    state.getSerialnumberResponse = SerialNumberModel();
  }

  // Get leodepartments api call
  Future<void> getLeodepartments(String name) async {
    try {
      LeoDepartments leodepartments = await services.getLeodepartments(name);
      emit(
        state.copyWith(
          getLeodepartmentsResponse: leodepartments,
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
      String role, BuildContext context) async {
    try {
      CreateUserModel createUserData =
          await services.createUser(firstName, lastName, email, role, context);
      emit(
        state.copyWith(
          createUserResponse: createUserData,
          status: FormStatus.success,
        ),
      );
      dismissLoadingDialog(context);
      await lawEnforcementCubit.getDBofficialByRoleDepositor(
          'ATOM_STATIC_USER', context);
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Utils.dynamicAlert(context, 'Added sucessfully', Constants.newuser, '');
      });
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
  Future<void> getLeopurposeofvisit(String name, BuildContext context) async {
    try {
      LeoPurposeVisit leorespnose =
          await services.getLeopurposeofvisit(name, context);
      emit(
        state.copyWith(
          getLeopurposeResponse: leorespnose,
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
  Future<void> getDBofficialByRoleDepositor(
      String roleName, BuildContext context) async {
    try {
      GetDepositor getDepositorData =
          await services.getDBOfficialdepartments(roleName, context);
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

  geDBOfficialyData(BaseUser listOfdept) async {
    try {
      emit(
        state.copyWith(
          getuserResponse: listOfdept,
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

  getlocationsResponseData(Organisation? locationSelectedlist) async {
    try {
      emit(
        state.copyWith(
          locationSelectedlist: locationSelectedlist,
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

  getSerialnumberResponse(SerialNumberModel? serialnumberResponse) async {
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
