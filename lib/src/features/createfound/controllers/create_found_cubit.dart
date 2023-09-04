import 'dart:js';

import 'package:db_atom/main_DEV.dart';
import 'dart:math';
import 'package:db_atom/src/common_widgets/cubits.dart';
import 'package:db_atom/src/common_widgets/spinnerdialog.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/createfound/controllers/create_found_state.dart';
import 'package:db_atom/src/features/createfound/models/attachment_model.dart';
import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/create_found_submit_model.dart';
import 'package:db_atom/src/features/createfound/models/create_organisation_model.dart';
import 'package:db_atom/src/features/createfound/models/create_user_model.dart';
import 'package:db_atom/src/features/createfound/models/emplyee_departments_model.dart';
import 'package:db_atom/src/features/createfound/models/get_articletype_model.dart';
import 'package:db_atom/src/features/createfound/models/get_depositor_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/get_user_model.dart';
import 'package:db_atom/src/features/createfound/models/serial_number_model.dart';
import 'package:db_atom/src/features/createfound/services/create_found_services.dart';
import 'package:db_atom/src/utils/customalert.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateFoundArticleCubit extends Cubit<CreateFoundState> {
  final CreateFoundServices createFoundServices;
  List<CreateImage>? loadAttachments;

  CreateFoundArticleCubit({
    required this.createFoundServices,
    this.loadAttachments,
  }) : super(
          CreateFoundState(
            createFoundResponse: SubmitCreateFoundModel(),
            stateType: CreateFoundStateType.initial,
          ),
        );

  // Create new Found Article successfully API call
  Future<void> createNewFoundArticle(CreateFoundRequestBody bodyRequest,
      bool isSubmit, BuildContext context, String username, String title) async {
    try {
      SubmitCreateFoundModel createFoundResponse =
          await createFoundServices.createFoundArticle(bodyRequest, isSubmit,
              username,context); //replace empty model with bodyRequest
      emit(
        state.copyWith(
          createFoundResponse: createFoundResponse,
          stateType: CreateFoundStateType.success,
        ),
      );

      if (createFoundResponse.message != null) {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          dismissLoadingDialog(context);
          Utils.dynamicAlert(
              context, createFoundResponse.message ?? '',title , '');
        });
      }
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreateFoundStateType.failure,
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
  Future<void> createFoundArticleHandle(Map<String, dynamic> bodyRequest,
      bool isSubmit, BuildContext context, String username, String title) async {
    try {
      SubmitCreateFoundModel createFoundResponse =
          await createFoundServices.createFoundArticleHandle(bodyRequest, isSubmit,
              username,context); //replace empty model with bodyRequest
      emit(
        state.copyWith(
          createFoundResponse: createFoundResponse,
          stateType: CreateFoundStateType.success,
        ),
      );

      if (createFoundResponse.message != null) {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          dismissLoadingDialog(context);
          Utils.dynamicAlert(
              context, createFoundResponse.message ?? '', title, '');
        });
      }
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreateFoundStateType.failure,
        ),
      );

      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        dismissLoadingDialog(context);
        Utils.dynamicAlert(
            context, Constants.errorText, title, Constants.errorText);
      });
    }
  }


  Future<void> addAttchment(List<CreateImage>? data) async {
    // List<CreateImage> value = createFoundArticleCubit.loadAttachments ?? [];
    // loadAttachments ??= [];
    // loadAttachments?.add(data);
    // print(loadAttachments);
    int eventIds = Random.secure().nextInt(5);
    
    emit(state.copyWith(
      eventId:eventIds ,
        loadAttachments: data,
        stateType: CreateFoundStateType.addattachment));
  }

  

  // get depositor user by role API call
  Future<void> getUserByRoleDepositor(String userRole,BuildContext context) async {
    try {
      GetDepositor getDepositorData =
          await createFoundServices.getUserByRoleDepositor(userRole,context);
      emit(
        state.copyWith(
          getDepositorResponse: getDepositorData,
          stateType: CreateFoundStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreateFoundStateType.failure,
        ),
      );
    }
  }

  // Get locations api call
  Future<void> getLocations(String locationsStr,BuildContext context) async {
    try {
      GetLocations getLocationsData =
          await createFoundServices.getLocations(locationsStr,context);
      emit(
        state.copyWith(
          getLocationsResponse: getLocationsData,
          stateType: CreateFoundStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreateFoundStateType.failure,
        ),
      );
    }
  }

  // Get employee departments
  Future<void> getEmployeeDepartments(String departmentStr,BuildContext context) async {
    try {
      EmployeeDepartments getEmployeeDepartments =
          await createFoundServices.getEmployeeDepartments(departmentStr,context);
      emit(
        state.copyWith(
          getEmployeeDepartmentsResponse: getEmployeeDepartments,
          stateType: CreateFoundStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreateFoundStateType.failure,
        ),
      );
    }
  }

  // Get Article type employee Api call
  Future<void> getArticleType(String articleTypeStr,BuildContext context) async {
    try {
      GetArticleType getArticleTypeData =
          await createFoundServices.getArticleType(articleTypeStr,context);
      emit(
        state.copyWith(
          getArticleTypeResponse: getArticleTypeData,
          stateType: CreateFoundStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreateFoundStateType.failure,
        ),
      );
    }
  }

  // Create organisation call
  Future<void> createOrganisation(
      String name, String orgName, BuildContext context) async {
    try {
      CreateOrganisation createOrganisationData =
          await createFoundServices.createOrganisation(name, orgName,context);
      emit(
        state.copyWith(
          createOrganisationResponse: createOrganisationData,
          stateType: CreateFoundStateType.success,
        ),
      );
       await createFoundArticleCubit.getArticleType('ARTICLE_LIST',context);
      dismissLoadingDialog(context);
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Utils.dynamicAlert(
            context, 'Added sucessfully', Constants.addarticletype, '');
      });
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreateFoundStateType.failure,
        ),
      );
      dismissLoadingDialog(context);
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Utils.dynamicAlert(context, Constants.errorText,
            Constants.addarticletype, Constants.errorText);
      });
    }
  }

  // Create organisation call
  Future<void> createEmplyeeDepartments(
      String name, String orgName, BuildContext context) async {
        
        
    try {
      CreateOrganisation createEmployeeDeptData =
          await createFoundServices.createOrganisation(name, orgName,context);
      emit(
        state.copyWith(
          createEmployeeDepartments: createEmployeeDeptData,
          stateType: CreateFoundStateType.success,
        ),
      );
      await createFoundArticleCubit
        .getEmployeeDepartments('EMPLOYEE_DEPARTMENTS',context);
      dismissLoadingDialog(context);
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Utils.dynamicAlert(
            context, 'Added sucessfully', Constants.addarticletype, '');
      });
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreateFoundStateType.failure,
        ),
      );
      dismissLoadingDialog(context);
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Utils.dynamicAlert(context, Constants.errorText,
            Constants.addemployeedepartment, Constants.errorText);
      });
    }
  }

  // Create user call
  Future<void> createUser(String firstName, String lastName, String email,
      String role, BuildContext context) async {
    try {
      CreateUserModel createUserData = await createFoundServices.createUser(
          firstName, lastName, email, role,context);
      emit(
        state.copyWith(
          createUserResponse: createUserData,
          stateType: CreateFoundStateType.success,
        ),
      );
      dismissLoadingDialog(context);
       await createFoundArticleCubit.getUserByRoleDepositor('ATOM_STATIC_USER',context);
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Utils.dynamicAlert(context, 'Added sucessfully', Constants.newuser, '');
      });
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreateFoundStateType.failure,
        ),
      );
      dismissLoadingDialog(context);
     
    }
  }

  // Get user details call
  Future<void> getUserDetails(String userId,BuildContext context) async {
    try {
      GetUserDetails getUserData =
          await createFoundServices.getUserDetails(userId,context);
      emit(
        state.copyWith(
          getUserDetailsResponse: getUserData,
          stateType: CreateFoundStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreateFoundStateType.failure,
        ),
      );
    }
  }

  // Serialnumber api  call
  Future<void> getSerialnumberDetails(
      String locationid, String modulecode,BuildContext context) async {
    try {
      SerialNumberModel getserialnumberResponse = await createFoundServices
          .getSerialnumberDetails(locationid, modulecode,context);
      emit(
        state.copyWith(
          getSerialnumberResponse: getserialnumberResponse,
          stateType: CreateFoundStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: CreateFoundStateType.failure,
        ),
      );
    }
  }
}
