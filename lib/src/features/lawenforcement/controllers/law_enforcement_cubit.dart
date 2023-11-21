import 'dart:math';

import 'package:db_atom/src/common_widgets/cubits.dart';
import 'package:db_atom/src/common_widgets/spinnerdialog.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/enums/form_status.dart';
import 'package:db_atom/src/features/createfound/models/create_user_model.dart';
import 'package:db_atom/src/features/createfound/models/emplyee_departments_model.dart';
import 'package:db_atom/src/features/createfound/models/get_depositor_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/serial_number_model.dart';
import 'package:db_atom/src/features/lawenforcement/controllers/law_enforcement_state.dart';
import 'package:db_atom/src/features/lawenforcement/models/addentities.dart';
import 'package:db_atom/src/features/lawenforcement/models/distribution_model.dart';
import 'package:db_atom/src/features/lawenforcement/models/dropdown_object.dart';
import 'package:db_atom/src/features/lawenforcement/models/law_enforement_request.dart';
import 'package:db_atom/src/features/lawenforcement/models/leodepartments.dart';
import 'package:db_atom/src/features/lawenforcement/models/leopurposevisit.dart';
import 'package:db_atom/src/features/lawenforcement/models/submit_law_enforcement_response.dart';
import 'package:db_atom/src/features/lawenforcement/services/law_enforcement_services.dart';
import 'package:db_atom/src/models/image_content.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/base_user.dart';
import '../../../models/organisation.dart';
import '../../createfound/models/user.dart';

class LawEnforcementCubit extends Cubit<LawEnforcementState> {
  LawEnforcementServices services;
  List<ImageContent>? loadAttachments;

  LawEnforcementCubit({required this.services, this.loadAttachments})
      : super(
          LawEnforcementState(
            //lawenforcementServices: SubmitCreateFoundModel(),
            stateType: FormStatus.initial,
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
          stateType: FormStatus.success,
        ),
      );
      if (Constants.addentitytype == title) {
        await lawEnforcementCubit.getEntities('ATOM_ENTITIES');
      } else if (Constants.addpurposeofvisittype == title) {
        await lawEnforcementCubit.getLeopurposeofvisit(
            'ATOM_LEO_PURPOSE_VISIT', context);
      } else if (Constants.addleoofficialtype == title) {
        await lawEnforcementCubit.getLeodepartments(
            'ATOM_LEO_DEPARTMENTS', context);
      }

      dismissLoadingDialog(context);

      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Utils.dynamicAlert(context, 'Added sucessfully', title, '');
      });
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: FormStatus.failure,
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
          stateType: FormStatus.success,
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
          stateType: FormStatus.failure,
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
  Future<void> submitForm(
    LawEnforcementRequestBody bodyRequest,
    bool isSubmit,
    BuildContext context,
    String title,
  ) async {
    try {
      SubmitLawEnforcementResponse? response =
          await services.createLawFoundArticle(
        body: bodyRequest,
        isSubmit: isSubmit,
        context: context,
      ); //replace empty model with bodyRequest
      emit(
        state.copyWith(
          lawcreateFoundresponse: response,
          stateType: FormStatus.success,
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
          stateType: FormStatus.failure,
        ),
      );

      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        dismissLoadingDialog(context);
        Utils.dynamicAlert(
            context, Constants.errorText, title, Constants.errorText);
      });
    }
  }

  // Get locations api call
  Future<void> getLocations(String name, BuildContext context) async {
    try {
      Locations getLocationsData =
          await services.getLocations(name, context);
      emit(
        state.copyWith(
          getLocationsResponse: getLocationsData,
          stateType: FormStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: FormStatus.failure,
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
          stateType: FormStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: FormStatus.failure,
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
          stateType: FormStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: FormStatus.failure,
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
          stateType: FormStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: FormStatus.failure,
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
          stateType: FormStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: FormStatus.failure,
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
          stateType: FormStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: FormStatus.failure,
        ),
      );
    }
  }

  Future<void> addAttchment(List<ImageContent>? data) async {
    int eventIds = Random.secure().nextInt(5);

    emit(state.copyWith(
        eventId: eventIds,
        loadAttachments: data,
        stateType: FormStatus.addAttachment));
  }

  Future<void> addingVisits(
      {required int visitCount,
      List<VisitingOfficialsModel>? getVisits}) async {
    //int eventIds = Random.secure().nextInt(5);
    emit(
      state.copyWith(
        getVisits: getVisits,
        getVisitsCount: visitCount,
        stateType: FormStatus.success,
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
          stateType: FormStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: FormStatus.failure,
        ),
      );
    }
  }

  initalization() {
    lawEnforcementCubit.state.getVisits = [];
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
  Future<void> getLeodepartments(String name, BuildContext context) async {
    try {
      LeoDepartments leodepartments =
          await services.getLeodepartments(name, context);
      emit(
        state.copyWith(
          getLeodepartmentsResponse: leodepartments,
          stateType: FormStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: FormStatus.failure,
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
          stateType: FormStatus.success,
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
          errorMessage: Constants.errorText,
          stateType: FormStatus.failure,
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
          stateType: FormStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: FormStatus.failure,
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
          stateType: FormStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: FormStatus.failure,
        ),
      );
    }
  }

  geDBOfficialyData(BaseUser listOfdept) async {
    try {
      emit(
        state.copyWith(
          getuserResponse: listOfdept,
          stateType: FormStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: FormStatus.failure,
        ),
      );
    }
  }

  getEntityData(List<Organisation> listOfEntities) async {
    try {
      int eventIds = Random.secure().nextInt(5);
      emit(
        state.copyWith(
          eventId: eventIds,
          listOfEntities: listOfEntities,
          stateType: FormStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: FormStatus.failure,
        ),
      );
    }
  }

  getleoDepartmentsResponseData(Organisation leoDepartmentsResponse) async {
    try {
      emit(
        state.copyWith(
          leoDepartmentsResponse: leoDepartmentsResponse,
          stateType: FormStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: FormStatus.failure,
        ),
      );
    }
  }

  getemployeeDepartmentsResponseData(Organisation employeedepartment) async {
    try {
      emit(
        state.copyWith(
          selectedemployeeDepartmentResponse: employeedepartment,
          stateType: FormStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: FormStatus.failure,
        ),
      );
    }
  }

  getleopurposeResponseData(Organisation? leoPurposeVisitResponse) async {
    try {
      emit(
        state.copyWith(
          leoPurposeVisitResponse: leoPurposeVisitResponse,
          stateType: FormStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: FormStatus.failure,
        ),
      );
    }
  }

  getlocationsResponseData(Organisation? locationSelectedlist) async {
    try {
      emit(
        state.copyWith(
          locationSelectedlist: locationSelectedlist,
          stateType: FormStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: FormStatus.failure,
        ),
      );
    }
  }

  getSerialnumberResponse(SerialNumberModel? serialnumberResponse) async {
    try {
      emit(
        state.copyWith(
          serialnumberResponse: serialnumberResponse,
          stateType: FormStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: FormStatus.failure,
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
            stateType: FormStatus.success,
          ),
        );
      } else if (name == Constants.documentifanytoconfirmpurpose) {
        emit(
          state.copyWith(
            isDocumentifanySelected: value,
            radioButtonItem: radio,
            stateType: FormStatus.success,
          ),
        );
      } else if (name == Constants.incaseofpolicewasofficialinuniform) {
        emit(
          state.copyWith(
            isIncaseofpoliceSelected: value,
            radioButtonItem: radio,
            stateType: FormStatus.success,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: FormStatus.failure,
        ),
      );
    }
  }

  getDistributed(bool isDistributed) async {
    try {
      emit(
        state.copyWith(
          isDistributed: isDistributed,
          stateType: FormStatus.success,
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

// void onModelValueChange(LawEnforcementDetails model) {
//   log('-onModelValueChange---');
//   emit(state.copyWith(model: model, status: FormStatus.initial));
// }
}
