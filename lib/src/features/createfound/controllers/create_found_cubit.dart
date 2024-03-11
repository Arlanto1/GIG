import 'dart:developer';
import 'dart:math' as math;

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/createfound/services/create_found_services.dart';
import 'package:db_atom/src/services/common_services.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/af_ui_labels.dart';


class CreateFoundArticleCubit extends Cubit<CreateFoundState> {
  final CreateFoundServices createFoundServices;
  List<ImageContent>? loadAttachments;

  CreateFoundArticleCubit({
    required this.createFoundServices,
    this.loadAttachments,
  }) : super(
          CreateFoundState(
            createFoundResponse: SubmitCreateFoundModel(),
            status: FormStatus.initial,
          ),
        );
  CommonServices commonServices = CommonServices();

  Future<void> initializeValues() async {
    //Show Loader and emit loading state
    emit(
      state.copyWith(
        status: FormStatus.loading,
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
          status: FormStatus.failure,
        ),
      );
    }
  }

  // Create new Found Article successfully API call
  Future<void> createNewFoundArticle(
    CreateFoundRequestBody bodyRequest,
    bool isSubmit,
    BuildContext context,
    String username,
    String title,
  ) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    log('---createNewFoundArticle--1111--');

    try {
      SubmitCreateFoundModel createFoundResponse =
          await createFoundServices.createFoundArticle(
        body: bodyRequest,
        isSubmit: isSubmit,
        username: username,
        context: context,
      );

      log('--createFoundResponse--${createFoundResponse.message}--');
      emit(
        state.copyWith(
          createFoundResponse: createFoundResponse,
          message: createFoundResponse.message,
          status: FormStatus.success,
        ),
      );

      // if (createFoundResponse.message != null) {
      //   SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      //     dismissLoadingDialog(context);
      //     Utils.dynamicAlert(
      //       context,
      //       createFoundResponse.message ?? '',
      //       title,
      //       '',
      //     );
      //   });
      // }
    } on GenericResponse catch (e) {
      log('--e.message--${e.message}--');
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.error,
        ),
      );
      return;
    } on Exception catch (e) {
      log('--e.eeee--${e.toString()}--');
      emit(
        state.copyWith(
          message: e.toString(),
          status: FormStatus.error,
        ),
      );
    }
  }

  // Create new Found Article successfully API call
  Future<void> createFoundArticleHandle(
      Map<String, dynamic> bodyRequest,
      bool isSubmit,
      BuildContext context,
      String username,
      String title) async {
    log('---createFoundArticleHandle--2222--');
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
          status: FormStatus.success,
        ),
      );

      if (createFoundResponse.message != null) {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          dismissLoadingDialog(context);
          Utils.dynamicAlert(
              context, createFoundResponse.message ?? '', title, '');
        });
      }
    } on GenericResponse catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.error,
        ),
      );
      return;
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
          status: FormStatus.addAttachment),
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
          status: FormStatus.initial,
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

  // Get locations api call
  Future<void> getLocations(String locationsStr, BuildContext context) async {
    try {
      // GetLocations getLocationsData =
      //     await createFoundServices.getLocations(locationsStr, context);
      Locations getLocationsData = await commonServices.getRegionsWithLocations(
          name: locationsStr, context: context);

      emit(
        state.copyWith(
          getLocationsResponse: getLocationsData,
          status: FormStatus.initial,
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
      // EmployeeDepartments getEmployeeDepartments = await createFoundServices
      //     .getEmployeeDepartments(departmentStr, context);
      EmployeeDepartments getEmployeeDepartments = await commonServices
          .getDepartments(name: departmentStr, context: context);
      emit(
        state.copyWith(
          getEmployeeDepartmentsResponse: getEmployeeDepartments,
          status: FormStatus.initial,
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
          status: FormStatus.initial,
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
          status: FormStatus.success,
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
          status: FormStatus.initial,
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
          status: FormStatus.initial,
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
          status: FormStatus.failure,
        ),
      );
      dismissLoadingDialog(context);
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
          status: FormStatus.initial,
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
      String locationId, String moduleCode, BuildContext context) async {
    try {
      SerialNumberModel response = await commonServices.getSlNo(
          locationId: locationId, moduleCode: moduleCode, context: context);
      emit(
        state.copyWith(
          getSerialnumberResponse: response,
          status: FormStatus.initial,
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

  Future<void> updateStatus({required String id}) async {
    await commonServices.updateRecordStatus(
        id: id, module: Constants.articleFoundModuleCode);
  }
}
