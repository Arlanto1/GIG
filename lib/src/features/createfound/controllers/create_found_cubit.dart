import 'dart:developer';
import 'dart:math' as math;

import 'package:db_atom/src/common_widgets/cubits.dart';
import 'package:db_atom/src/common_widgets/spinnerdialog.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/createfound/controllers/create_found_state.dart';
import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/create_found_submit_model.dart';
import 'package:db_atom/src/features/createfound/models/create_user_model.dart';
import 'package:db_atom/src/features/createfound/models/emplyee_departments_model.dart';
import 'package:db_atom/src/features/createfound/models/get_articletype_model.dart';
import 'package:db_atom/src/features/createfound/models/get_depositor_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/serial_number_model.dart';
import 'package:db_atom/src/features/createfound/services/create_found_services.dart';
import 'package:db_atom/src/models/image_content.dart';
import 'package:db_atom/src/services/CommonServices.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/organisation.dart';
import '../../../utils/shared_preferences.dart';
import '../models/user.dart';

class CreateFoundArticleCubit extends Cubit<CreateFoundState> {
  final CreateFoundServices createFoundServices;
  List<ImageContent>? loadAttachments;

  CreateFoundArticleCubit({
    required this.createFoundServices,
    this.loadAttachments,
  }) : super(
          CreateFoundState(
            createFoundResponse: SubmitCreateFoundModel(),
            stateType: CreateFoundStateType.initial,
          ),
        );
  CommonServices commonServices = CommonServices();

  // Create new Found Article successfully API call
  Future<void> createNewFoundArticle(
    CreateFoundRequestBody bodyRequest,
    bool isSubmit,
    BuildContext context,
    String username,
    String title,
  ) async {
    try {
      SubmitCreateFoundModel createFoundResponse =
          await createFoundServices.createFoundArticle(
        body: bodyRequest,
        isSubmit: isSubmit,
        username: username,
        context: context,
      ); //replace empty model with bodyRequest
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
            context,
            createFoundResponse.message ?? '',
            title,
            '',
          );
        });
      }
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
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
  Future<void> createFoundArticleHandle(
      Map<String, dynamic> bodyRequest,
      bool isSubmit,
      BuildContext context,
      String username,
      String title) async {
    try {
      SubmitCreateFoundModel createFoundResponse =
          await createFoundServices.createFoundArticleHandle(
              bodyRequest,
              isSubmit,
              username,
              context); //replace empty model with bodyRequest
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
          message: Constants.errorText,
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

  Future<void> addAttchment(List<ImageContent>? data) async {
    // List<CreateImage> value = createFoundArticleCubit.loadAttachments ?? [];
    // loadAttachments ??= [];
    // loadAttachments?.add(data);
    int eventIds = math.Random.secure().nextInt(5);

    log('--data---${data?.length}');
    emit(
      state.copyWith(
          eventId: eventIds,
          loadAttachments: data,
          stateType: CreateFoundStateType.addattachment),
    );
  }

  // get depositor user by role API call
  Future<void> getUserByRoleDepositor(
      String userRole, BuildContext context) async {
    try {
      // GetDepositor getDepositorData =
      //     await createFoundServices.getUserByRoleDepositor(userRole, context);

      GetDepositor getDepositorData = await commonServices.getAtomStaticUsers(
          roleName: userRole, context: context);

      emit(
        state.copyWith(
          getDepositorResponse: getDepositorData,
          stateType: CreateFoundStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          stateType: CreateFoundStateType.failure,
        ),
      );
    }
  }

  // Get locations api call
  Future<void> getLocations(String locationsStr, BuildContext context) async {
    try {
      // GetLocations getLocationsData =
      //     await createFoundServices.getLocations(locationsStr, context);
      Locations getLocationsData = await commonServices.getLocations(
          name: locationsStr, context: context);

      emit(
        state.copyWith(
          getLocationsResponse: getLocationsData,
          stateType: CreateFoundStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          stateType: CreateFoundStateType.failure,
        ),
      );
    }
  }

  // Get employee departments
  Future<void> getEmployeeDepartments(
      String departmentStr, BuildContext context) async {
    try {
      // EmployeeDepartments getEmployeeDepartments = await createFoundServices
      //     .getEmployeeDepartments(departmentStr, context);
      EmployeeDepartments getEmployeeDepartments = await commonServices
          .getDepartments(name: departmentStr, context: context);
      emit(
        state.copyWith(
          getEmployeeDepartmentsResponse: getEmployeeDepartments,
          stateType: CreateFoundStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          stateType: CreateFoundStateType.failure,
        ),
      );
    }
  }

  // Get Article type employee Api call
  Future<void> getArticleType(
      String articleTypeStr, BuildContext context) async {
    try {
      // GetArticleType getArticleTypeData =
      //     await createFoundServices.getArticleType(articleTypeStr, context);

      GetArticleType getArticleTypeData = await commonServices.getArticleType(
          name: articleTypeStr, context: context);
      emit(
        state.copyWith(
          getArticleTypeResponse: getArticleTypeData,
          stateType: CreateFoundStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          stateType: CreateFoundStateType.failure,
        ),
      );
    }
  }

  // Create organisation call
  Future<void> createOrganisation(
      String name, String orgName, BuildContext context) async {
    try {
      // Organisation createOrganisationData =
      //     await createFoundServices.createOrganisation(name, orgName, context);
      Organisation createOrganisationData =
          await commonServices.createOrganisation(
        name: name,
        orgName: orgName,
        context: context,
      );
      emit(
        state.copyWith(
          createOrganisationResponse: createOrganisationData,
          stateType: CreateFoundStateType.success,
        ),
      );
      await createFoundArticleCubit.getArticleType('ARTICLE_LIST', context);
      dismissLoadingDialog(context);
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Utils.dynamicAlert(
            context, 'Added sucessfully', Constants.addarticletype, '');
      });
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
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
      // Organisation createEmployeeDeptData =
      //     await createFoundServices.createOrganisation(name, orgName, context);
      Organisation createOrganisationData =
          await commonServices.createOrganisation(
        name: name,
        orgName: orgName,
        context: context,
      );
      emit(
        state.copyWith(
          createEmployeeDepartments: createOrganisationData,
          stateType: CreateFoundStateType.success,
        ),
      );
      await createFoundArticleCubit.getEmployeeDepartments(
          'EMPLOYEE_DEPARTMENTS', context);
      dismissLoadingDialog(context);
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Utils.dynamicAlert(
            context, 'Added sucessfully', Constants.addarticletype, '');
      });
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
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
      // CreateUserModel createUserData = await createFoundServices.createUser(
      //     firstName, lastName, email, role, context);

      CreateUserModel createUserData = await commonServices.createUser(
        firstName: firstName,
        lastName: lastName,
        email: email,
        role: role,
        context: context,
      );
      emit(
        state.copyWith(
          createUserResponse: createUserData,
          stateType: CreateFoundStateType.success,
        ),
      );
      dismissLoadingDialog(context);
      await createFoundArticleCubit.getUserByRoleDepositor(
          'ATOM_STATIC_USER', context);
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Utils.dynamicAlert(context, 'Added sucessfully', Constants.newuser, '');
      });
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          stateType: CreateFoundStateType.failure,
        ),
      );
      dismissLoadingDialog(context);
    }
  }

  Future<void> initializeValues() async {
    //Show Loader and emit loading state
    emit(
      state.copyWith(
        stateType: CreateFoundStateType.loading,
      ),
    );

    var userId = await SharedPrefs.getUserId();
    try {
      User loggedInUserDetails =
          await commonServices.getUserDetails(userId: userId);

      emit(
        state.copyWith(
          loggedInUser: loggedInUserDetails,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          // TODO: error message should be dynamic
          stateType: CreateFoundStateType.failure,
        ),
      );
    }
  }

  // Get user details call
  Future<void> getUserDetails(String userId, BuildContext context) async {
    try {
      User user =
          await commonServices.getUserDetails(userId: userId, context: context);

      emit(
        state.copyWith(
          loggedInUser: user,
          stateType: CreateFoundStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          stateType: CreateFoundStateType.failure,
        ),
      );
    }
  }

  // Serialnumber api  call
  Future<void> getSerialnumberDetails(
      String locationId, String moduleCode, BuildContext context) async {
    try {
      SerialNumberModel response = await commonServices.getSlNo(
          locationId: locationId, moduleCode: moduleCode, context: context);
      emit(
        state.copyWith(
          getSerialnumberResponse: response,
          stateType: CreateFoundStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          stateType: CreateFoundStateType.failure,
        ),
      );
    }
  }
}
