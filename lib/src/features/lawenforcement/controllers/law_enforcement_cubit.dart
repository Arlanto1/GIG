import 'dart:math';

import 'package:db_atom/src/common_widgets/cubits.dart';
import 'package:db_atom/src/common_widgets/spinnerdialog.dart';
import 'package:db_atom/src/constants/constants.dart';
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
import 'package:db_atom/src/features/lawenforcement/models/law_enforement_request.dart';
import 'package:db_atom/src/features/lawenforcement/models/leodepartments.dart';
import 'package:db_atom/src/features/lawenforcement/models/leopurposevisit.dart';
import 'package:db_atom/src/features/lawenforcement/models/submit_law_enforcement_response.dart';
import 'package:db_atom/src/features/lawenforcement/services/lawenforcementservice.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LawEnforcementCubit extends Cubit<LawEnforcementState> {
  LawEnforcementService lawenforcementServices;
  List<CreateImage>? loadAttachments;

  LawEnforcementCubit(
      {required this.lawenforcementServices, this.loadAttachments})
      : super(
          LawEnforcementState(
            //lawenforcementServices: SubmitCreateFoundModel(),
            stateType: LawEnforcementStateType.initial,
          ),
        );

// 
//law organisation call
  Future<void> createOrganisation(
      String name, String orgName, BuildContext context, String title) async {
    try {
      CreateOrganisation createOrganisationData =
          await lawenforcementServices.createOrganisation(name, orgName);
      emit(
        state.copyWith(
          createOrganisationResponse: createOrganisationData,
          stateType: LawEnforcementStateType.success,
        ),
      );
        if (Constants.addentitytype == title )
       {
        await lawenforcementCubit.getEntities('ATOM_ENTITIES');
       }
       else if (Constants.addpurposeofvisittype == title )
       {
        await lawenforcementCubit.getLeopurposeofvisit('ATOM_LEO_PURPOSE_VISIT');
       }
       else if (Constants.addleoofficialtype == title )
       {
          await lawenforcementCubit.getLeodepartments('ATOM_LEO_DEPARTMENTS');
       }
       
  
      dismissLoadingDialog(context);
     
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Utils.dynamicAlert(
            context, 'Added sucessfully', title, '');
      });
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: LawEnforcementStateType.failure,
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
      CreateOrganisation createEmployeeDeptData =
          await lawenforcementServices.createOrganisation(name, orgName);
      emit(
        state.copyWith(
          createEmployeeDepartments: createEmployeeDeptData,
          stateType: LawEnforcementStateType.success,
        ),
      );
      dismissLoadingDialog(context);
      await lawenforcementCubit.getEmployeeDepartments('EMPLOYEE_DEPARTMENTS');
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Utils.dynamicAlert(
            context, 'Added sucessfully', Constants.addemployeedepartment, '');
      });
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: LawEnforcementStateType.failure,
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
  Future<void> lawcreateNewFoundArticle(LawEnforcementRequestBody bodyRequest,
      bool isSubmit, BuildContext context, String username, String title) async {
    try {
      SubmitLawEnforcementResponse? lawcreateFoundresponse  =
          await lawenforcementServices.createLawFoundArticle(bodyRequest, isSubmit,
              username); //replace empty model with bodyRequest
      emit(
        state.copyWith(
          lawcreateFoundresponse: lawcreateFoundresponse,
          stateType: LawEnforcementStateType.success,
        ),
      );

      if (lawcreateFoundresponse.message != null) {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          dismissLoadingDialog(context);
          Utils.dynamicAlert(
              context, lawcreateFoundresponse.message ?? '',title , '');
        });
      }
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: LawEnforcementStateType.failure,
        ),
      );

      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        dismissLoadingDialog(context);
        Utils.dynamicAlert(
            context, Constants.errorText, title, Constants.errorText);
      });
    }
  }

  // Create new Found Article successfully API call
  Future<void> lawcreateFoundArticleHandle(Map<String, dynamic> bodyRequest,
      bool isSubmit, BuildContext context, String username, String title) async {
    try {
     SubmitLawEnforcementResponse? lawcreateFoundresponse  =
          await lawenforcementServices.createLawFoundArticleHandle(bodyRequest, isSubmit,
              username); //replace empty model with bodyRequest
      emit(
        state.copyWith(
          lawcreateFoundresponse: lawcreateFoundresponse,
          stateType: LawEnforcementStateType.success,
        ),
      );

      if (lawcreateFoundresponse.message != null) {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          dismissLoadingDialog(context);
          Utils.dynamicAlert(
              context, lawcreateFoundresponse.message ?? '', title, '');
        });
      }
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: LawEnforcementStateType.failure,
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
  Future<void> getLocations(String locationsStr) async {
    try {
      GetLocations getLocationsData =
          await lawenforcementServices.getLocations(locationsStr);
      emit(
        state.copyWith(
          getLocationsResponse: getLocationsData,
          stateType: LawEnforcementStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: LawEnforcementStateType.failure,
        ),
      );
    }
  }

  // Serialnumber api  call
  Future<void> getSerialnumberDetails(
      String locationid, String modulecode) async {
    try {
      SerialNumberModel getserialnumberResponse = await lawenforcementServices
          .getSerialnumberDetails(locationid, modulecode);
      emit(
        state.copyWith(
          getSerialnumberResponse: getserialnumberResponse,
          stateType: LawEnforcementStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: LawEnforcementStateType.failure,
        ),
      );
    }
  }

  // Distribution groups api  call
  Future<void> getDistributionGroupsDetails() async {
    try {
      DistributionGroupModel getResponse = await lawenforcementServices
          .getDistributiongroupDetails();
      emit(
        state.copyWith(
          groups: getResponse,
          stateType: LawEnforcementStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: LawEnforcementStateType.failure,
        ),
      );
    }
  }

  // Get employee departments
  Future<void> getEmployeeDepartments(String departmentStr) async {
    try {
      EmployeeDepartments getEmployeeDepartments =
          await lawenforcementServices.getEmployeeDepartments(departmentStr);
      emit(
        state.copyWith(
          employeeDepartment: getEmployeeDepartments,
          stateType: LawEnforcementStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: LawEnforcementStateType.failure,
        ),
      );
    }
  }

  // Get compant types departments
  Future<void> getCompanytypes(String departmentStr) async {
    try {
      EmployeeDepartments getEmployeeDepartments =
          await lawenforcementServices.getEmployeeDepartments(departmentStr);
      emit(
        state.copyWith(
          employeeDepartment: getEmployeeDepartments,
          stateType: LawEnforcementStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: LawEnforcementStateType.failure,
        ),
      );
    }
  }


// Get entities api call
  Future<void> getEntities(String name) async {
    try {
      AddEntities entities = await lawenforcementServices.getEntities(name);
      emit(
        state.copyWith(
          getEntitiesResponse: entities,
          stateType: LawEnforcementStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: LawEnforcementStateType.failure,
        ),
      );
    }
  }

   Future<void> addAttchment(List<CreateImage>? data) async {
    
    int eventIds = Random.secure().nextInt(5);
    
    emit(state.copyWith(
      eventId:eventIds ,
        loadAttachments: data,
        stateType: LawEnforcementStateType.addattachment));
  }

   Future<void> addingVisitis(int value, List<VistingOfficialsModel>? getVisits) async {
    //int eventIds = Random.secure().nextInt(5);
     emit(
        state.copyWith(
          getVisits: getVisits,
          getVisitsCount: value,
          stateType: LawEnforcementStateType.success,
        ),
      );
  }

   // Get user details call
  Future<void> getUserDetails(String userId) async {
    try {
      GetUserDetails getUserData =
          await lawenforcementServices.getUserDetails(userId);
      emit(
        state.copyWith(
          getUserDetailsResponse: getUserData,
          stateType: LawEnforcementStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: LawEnforcementStateType.failure,
        ),
      );
    }
  }
 
   initalization()
   {
     lawenforcementCubit.
     state.getVisits = [];
     state.getVisitsCount = 0;
     state.selectedemployeeDepartmentResponse = EmployeeDepartment();
     state.loadAttachments = [];
     //state.getUserDetailsResponse =  GetUserDetails();
     state.listOfEntities =[];
     state.locationSelectedlist = Mumbai();
     state.leoDepartmentsResponse = AtomLeoDepartment();
     state.leoPurposeVisitResponse = AtomLeoPurposeVisit();
     state.loadAttachments = [];
     state.isDocumentifanySelected = 1;
     state.isIncaseofpoliceSelected = 1;
     state.isOfficialIdcardSelected = 1;
    state.getuserResponse = AtomStaticUser();
     state.serialnumberResponse?.serialNo = '';
     state.getSerialnumberResponse = SerialNumberModel();

   }

  
  // Get leodepartments api call
  Future<void> getLeodepartments(String name) async {
    try {
      LeoDepartments leodepartments =
          await lawenforcementServices.getLeodepartments(name);
      emit(
        state.copyWith(
          getLeodepartmentsResponse: leodepartments,
          stateType: LawEnforcementStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: LawEnforcementStateType.failure,
        ),
      );
    }
  }

  // Create user call
  Future<void> createUser(String firstName, String lastName, String email,
      String role, BuildContext context) async {
    try {
      CreateUserModel createUserData = await lawenforcementServices.createUser(
          firstName, lastName, email, role);
      emit(
        state.copyWith(
          createUserResponse: createUserData,
          stateType: LawEnforcementStateType.success,
        ),
      );
      dismissLoadingDialog(context);
      await lawenforcementCubit.getDBofficialByRoleDepositor('ATOM_STATIC_USER');
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Utils.dynamicAlert(context, 'Added sucessfully', Constants.newuser, '');
      });
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: LawEnforcementStateType.failure,
        ),
      );
      dismissLoadingDialog(context);
    }
  }

  // Get leopurposeofvisit api call
  Future<void> getLeopurposeofvisit(String name) async {
    try {
      LeoPurposeVisit leorespnose =
          await lawenforcementServices.getLeopurposeofvisit(name);
      emit(
        state.copyWith(
          getLeopurposeResponse: leorespnose,
          stateType: LawEnforcementStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: LawEnforcementStateType.failure,
        ),
      );
    }
  }

  // get DB Official email ID Accompanied LEO official API call
  Future<void> getDBofficialByRoleDepositor(String userRole) async {
    try {
      GetDepositor getDepositorData =
          await lawenforcementServices.getDBOfficialdepartments(userRole);
      emit(
        state.copyWith(
          getDepositorResponse: getDepositorData,
          stateType: LawEnforcementStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: LawEnforcementStateType.failure,
        ),
      );
    }
  }

  geDBOfficialyData(AtomStaticUser listOfdept) async {
    try {
      emit(
        state.copyWith(
          getuserResponse: listOfdept,
          stateType: LawEnforcementStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: LawEnforcementStateType.failure,
        ),
      );
    }
  }

  geDistributonData(DistributionGroup listOfdept) async {
    try {
      emit(
        state.copyWith(
          listIndividualdept: listOfdept,
          stateType: LawEnforcementStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: LawEnforcementStateType.failure,
        ),
      );
    }
  }

  getEntityData(List<AtomEntity> listOfEntities) async {
    try {
      emit(
        state.copyWith(
          listOfEntities: listOfEntities,
          stateType: LawEnforcementStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: LawEnforcementStateType.failure,
        ),
      );
    }
  }

  getleoDepartmentsResponseData(
      AtomLeoDepartment leoDepartmentsResponse) async {
    try {
      emit(
        state.copyWith(
          leoDepartmentsResponse: leoDepartmentsResponse,
          stateType: LawEnforcementStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: LawEnforcementStateType.failure,
        ),
      );
    }
  }
  getemployeeDepartmentsResponseData(
      EmployeeDepartment employeedepartment) async {
    try {
      emit(
        state.copyWith(
          selectedemployeeDepartmentResponse: employeedepartment,
          stateType: LawEnforcementStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: LawEnforcementStateType.failure,
        ),
      );
    }
  }

  getleopurposeResponseData(
      AtomLeoPurposeVisit? leoPurposeVisitResponse) async {
    try {
      emit(
        state.copyWith(
          leoPurposeVisitResponse: leoPurposeVisitResponse,
          stateType: LawEnforcementStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: LawEnforcementStateType.failure,
        ),
      );
    }
  }

  getlocationsResponseData(Mumbai? locationSelectedlist) async {
    try {
      emit(
        state.copyWith(
          locationSelectedlist: locationSelectedlist,
          stateType: LawEnforcementStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: LawEnforcementStateType.failure,
        ),
      );
    }
  }

  getSerialnumberResponse(SerialNumberModel? serialnumberResponse) async {
    try {
      emit(
        state.copyWith(
          serialnumberResponse: serialnumberResponse,
          stateType: LawEnforcementStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: LawEnforcementStateType.failure,
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
            stateType: LawEnforcementStateType.success,
          ),
        );
      } else if (name == Constants.documentifanytoconfirmpurpose) {
        emit(
          state.copyWith(
            isDocumentifanySelected: value,
            radioButtonItem: radio,
            stateType: LawEnforcementStateType.success,
          ),
        );
      } else if (name == Constants.incaseofpolicewasofficialinuniform) {
        emit(
          state.copyWith(
            isIncaseofpoliceSelected: value,
            radioButtonItem: radio,
            stateType: LawEnforcementStateType.success,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: LawEnforcementStateType.failure,
        ),
      );
    }
  }
}
