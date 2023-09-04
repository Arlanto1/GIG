import 'dart:math';

import 'package:db_atom/src/common_widgets/cubits.dart';
import 'package:db_atom/src/common_widgets/spinnerdialog.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/create_organisation_model.dart';
import 'package:db_atom/src/features/createfound/models/create_user_model.dart';
import 'package:db_atom/src/features/createfound/models/emplyee_departments_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/get_user_model.dart';
import 'package:db_atom/src/features/createfound/models/serial_number_model.dart';
import 'package:db_atom/src/features/lawenforcement/models/addentities.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/controllers/create_pass_mgmt_state.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/analyst_model.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/company_type_model.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/create_pass_mgmt_request_body.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/create_pass_mgmt_response.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/day_pass_numbers_list.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/day_pass_reason_model.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/services/create_pass_mgmt_services.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/base_user.dart';
import '../../../../../models/department.dart';
import '../../../../../models/entity.dart';
import '../../../../../models/entry_security.dart';
import '../../../../createfound/models/get_depositor_model.dart';

class CreatePassMgmtCubit extends Cubit<CreatePassMgmtState> {
  CreatePassMgmtService createpassmgmtServices;
  List<CreateImage>? loadAttachments;
  List<CreateImage>? photoAttachments;

  CreatePassMgmtCubit(
      {required this.createpassmgmtServices, this.loadAttachments,this.photoAttachments})
      : super(
          CreatePassMgmtState(
            //lawenforcementServices: SubmitCreateFoundModel(),
            stateType: CreatePassMgmtStateType.initial,
          ),
        );

//
//law organisation call
  Future<void> createOrganisation(
      String name, String orgName, BuildContext context,String title) async {
    try {
      CreateOrganisation createOrganisationData =
          await createpassmgmtServices.createOrganisation(name, orgName,context);
      emit(
        state.copyWith(
          createOrganisationResponse: createOrganisationData,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
      if (Constants.addcompanytype == title)
      {
        await createpassmgmtCubit.getCompanytypes('ATOM_COMPANY_TYPES',context);
      }
      else if (Constants.addreasonfordaypass == title || Constants.addreasonforvendorpass == title)
       {
       await createpassmgmtCubit.getDayPassreasons('DAY_PASS_REASON',context);
       }
       else if (Constants.addentitytype == title )
       {
        await createpassmgmtCubit.getEntities('ATOM_ENTITIES',context);
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
  Future<void> getUserByRoleDepositor(String userRole,BuildContext context) async {
    try {
      GetDepositor getDepositorData =
          await createpassmgmtServices.getUserByRoleDepositor(userRole,context);
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

  gethostUsersResponseData(
      BaseUser? hostResponse) async {
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

   getdbsponsorUsersResponseData(
      BaseUser? dbsponsorResponse) async {
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

   getnameUsersResponseData(
      BaseUser? userresponsedata) async {
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
          firstName, lastName, email, role,context);
      emit(
        state.copyWith(
          createUserResponse: createUserData,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
       await createpassmgmtCubit.getAnalysts('T1_Analyst',context);
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
  Future<void> createEmplyeeDepartments(
      String name, String orgName, BuildContext context) async {
    try {
      CreateOrganisation createEmployeeDeptData =
          await createpassmgmtServices.createOrganisation(name, orgName,context);
      emit(
        state.copyWith(
          createEmployeeDepartments: createEmployeeDeptData,
          stateType: CreatePassMgmtStateType.success,
        ),
      );
      dismissLoadingDialog(context);
      await createpassmgmtCubit.getEmployeeDepartments('EMPLOYEE_DEPARTMENTS',context);
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
  Future<void> getLocations(String locationsStr,BuildContext context) async {
    try {
      GetLocations getLocationsData =
          await createpassmgmtServices.getLocations(locationsStr,context);
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

  // Serialnumber api  call
  Future<void> getSerialnumberDetails(
      String locationid, String modulecode,BuildContext context) async {
    try {
      SerialNumberModel getserialnumberResponse = await createpassmgmtServices
          .getSerialnumberDetails(locationid, modulecode,context);
      emit(
        state.copyWith(
          getSerialnumberResponse: getserialnumberResponse,
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
  Future<void> getEmployeeDepartments(String departmentStr,BuildContext context) async {
    try {
      EmployeeDepartments getEmployeeDepartments =
          await createpassmgmtServices.getEmployeeDepartments(departmentStr,context);
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
Future<void> getPassnumber(String passtype, String locationid,BuildContext context) async {
    try {
      DayPassNumberLists companyTypes =
          await createpassmgmtServices.getPassno(passtype,locationid,context);
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

  getpassListResponseData(
      ActivePassInfoList? companytypeResponse) async {
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
  Future<void> getCompanytypes(String companyStr,BuildContext context) async {
    try {
      CompanyTypes companyTypes =
          await createpassmgmtServices.getCompanyTypes(companyStr,context);
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

  getatomCompanyTypeResponseData(
      AtomCompanyType? companytypeResponse) async {
    try {
      emit(
        state.copyWith(
          atomCompanyType: companytypeResponse,
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
  Future<void> getDayPassreasons(String companyStr,BuildContext context) async {
    try {
      DayPassReason companyTypes =
          await createpassmgmtServices.getDayPassreason(companyStr,context);
      emit(
        state.copyWith(
          dayPassReason: companyTypes,
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

  getdaypassreasonResponseData(
      DayPassReasonElement? companytypeResponse) async {
    try {
      emit(
        state.copyWith(
          dayPasselementReason: companytypeResponse,
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
  Future<void> getAnalysts(String companyStr,BuildContext context) async {
    try {
      Analyst companyTypes =
          await createpassmgmtServices.getAnalyst(companyStr,context);
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

  getnameanalystsResponseData(
      BaseUser? companytypeResponse) async {
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

  gethostanalystsResponseData(
      BaseUser? companytypeResponse) async {
    try {
      emit(
        state.copyWith(
          t1hostanalyst: companytypeResponse,
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
      BaseUser? companytypeResponse,) async {
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


// Get entities api call
  Future<void> getEntities(String name,BuildContext context) async {
    try {
      AddEntities entities = await createpassmgmtServices.getEntities(name,context);
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

  Future<void> addAttchment(List<CreateImage>? data) async {
    int eventIds = Random.secure().nextInt(5);

    emit(state.copyWith(
        eventId: eventIds,
        loadAttachments: data,
        stateType: CreatePassMgmtStateType.addattachment));
  }

   Future<void> photoAttchment(List<CreateImage>? data) async {
    int eventIds = Random.secure().nextInt(5);

    emit(state.copyWith(
        eventId: eventIds,
        photoAttachments: data,
        stateType: CreatePassMgmtStateType.photoattachment));
  }

  // Get user details call
  Future<void> getUserDetails(String userId,BuildContext context) async {
    try {
      EntrySecurity getUserData =
          await createpassmgmtServices.getUserDetails(userId,context);
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

  initalization() {
    state.selectedemployeeDepartmentResponse = Department();
    state.employeeDepartment = EmployeeDepartments();
    state.companyTypes = CompanyTypes();
    state.activePassInfoList = ActivePassInfoList();
    state.loadAttachments = [];
    state.atomCompanyType =  AtomCompanyType();
    state.listOfEntities = [];
    state.locationSelectedlist = Mumbai();
    state.photoAttachments = [];
    state.getuserResponse = BaseUser();
    state.serialnumberResponse?.serialNo = '';
    state.getSerialnumberResponse = SerialNumberModel();
    state.t1hostanalyst = BaseUser();
    state.t1nameanalyst = BaseUser();
    state.hostResponse = BaseUser();
    state.nameResponse = BaseUser();
    state.dbsponsorResponse = BaseUser();
    state.getUserDetailsResponse = EntrySecurity();
    state.dayPasselementReason = DayPassReasonElement();
  }

  getEntityData(List<Entity> listOfEntities) async {
    try {
        int eventIds = Random.secure().nextInt(5);
      emit(
        state.copyWith(
          eventId: eventIds,
          listOfEntities: listOfEntities,
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

  getemployeeDepartmentsResponseData(
      Department employeedepartment) async {
    try {
      emit(
        state.copyWith(
          selectedemployeeDepartmentResponse: employeedepartment,
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
  

  getlocationsResponseData(Mumbai? locationSelectedlist) async {
    try {
      emit(
        state.copyWith(
          locationSelectedlist: locationSelectedlist,
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
  Future<void> creatpasseNewFoundArticle(CreatePassMgmtBody bodyRequest,
      bool isSubmit, BuildContext context, String username, String title) async {
    try {
      CreatePassMgmtResponse? createpassFoundresponse  =
          await createpassmgmtServices.createLawFoundArticle(bodyRequest, isSubmit,
              username,context); //replace empty model with bodyRequest
      emit(
        state.copyWith(
          createpassFoundresponse: createpassFoundresponse,
          stateType: CreatePassMgmtStateType.success,
        ),
      );

      if (createpassFoundresponse.message != null) {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          dismissLoadingDialog(context);
          Utils.dynamicAlert(
              context, createpassFoundresponse.message ?? '',title , '');
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

  // Create new Found Article successfully API call
  Future<void> lawcreateFoundArticleHandle(Map<String, dynamic> bodyRequest,
      bool isSubmit, BuildContext context, String username, String title) async {
    try {
     CreatePassMgmtResponse? createpassFoundresponse  =
          await createpassmgmtServices.createLawFoundArticleHandle(bodyRequest, isSubmit,
              username,context); //replace empty model with bodyRequest
      emit(
        state.copyWith(
          createpassFoundresponse: createpassFoundresponse,
          stateType: CreatePassMgmtStateType.success,
        ),
      );

      if (createpassFoundresponse.message != null) {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          dismissLoadingDialog(context);
          Utils.dynamicAlert(
              context, createpassFoundresponse.message ?? '', title, '');
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
