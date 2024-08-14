import 'dart:developer';
import 'dart:math' as math;

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/createfound/services/create_found_services.dart';

class CreateFoundArticleCubit extends Cubit<CreateFoundState> {
  final CreateFoundServices createFoundServices;
  List<ImageContent>? loadAttachments;
  FoundListArticleDetails? model;

  CreateFoundArticleCubit({
    required this.createFoundServices,
    this.loadAttachments,
    this.model,
  }) : super(
          CreateFoundState(
            model: FoundListArticleDetails(),
            createFoundResponse: SubmitCreateFoundModel(),
            status: FormStatus.initial,
          ),
        );
  CommonServices commonServices = CommonServices();

  void initializeValuesForExistingRecord(
      {required FoundListArticleDetails model}) {
    log('--initializeValuesForExistingRecord----');
    emit(state.copyWith(
      slno: model.slNo,
    ));
  }

  Future<void> initializeValues({
    FoundListArticleDetails? model,
    Organisation? eventProtectionLocation,
  }) async {
    log('----initializeValues-----');
    //Show Loader and emit loading state
    emit(
      state.copyWith(
        status: FormStatus.loading,
        model: model,
      ),
    );

    var userId = await SharedPrefs.getUserId();
    try {
      model ??= FoundListArticleDetails();

      User loggedInUserDetails =
          await commonServices.getUserDetails(userId: userId);
      Organisation? defaultLocation = await SharedPrefs.getDefaultLocation();

      if (eventProtectionLocation != null) {
        defaultLocation = eventProtectionLocation;
      }
      SerialNumberModel? serialNumberResponse;
      log('---defaultLocation--${defaultLocation?.name}----');
      if (model.slNo.isEmptyOrNull) {
        log('----model.slNo.isEmptyOrNull-----');
        serialNumberResponse = await commonServices.getSlNo(
          locationId: defaultLocation!.id.toString(),
          moduleCode: Constants.articleFoundModuleCode,
        );
        model.slNo = serialNumberResponse.serialNo;
        model.location = defaultLocation;
      }

      emit(
        state.copyWith(
          model: model,
          location: model.location,
          slno: serialNumberResponse?.serialNo,
          loggedInUser: loggedInUserDetails,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          model: model,
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
    String username,
    String title,
    int? eventId,
  ) async {
    emit(
      state.copyWith(
        model: model,
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
        eventId: eventId,
      );

      log('--createFoundResponse--${createFoundResponse.message}--');
      emit(
        state.copyWith(
          model: model,
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
      Utils().emitErrorState(e, emit, state);
      return;
    } on Exception catch (e) {
      log('--e.eeee--${e.toString()}--');
      emit(
        state.copyWith(
          model: model,
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
          model: model,
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
      Utils().emitErrorState(e, emit, state);
      return;
    } on Exception catch (e) {
      emit(
        state.copyWith(
          model: model,
          message: e.toString(),
          status: FormStatus.error,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          model: model,
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

  Future<void> addAttachment(List<ImageContent>? data) async {
    // List<CreateImage> value = createFoundArticleCubit.loadAttachments ?? [];
    // loadAttachments ??= [];
    // loadAttachments?.add(data);
    int eventIds = math.Random.secure().nextInt(5);

    log('--data---${data?.length}');
    emit(
      state.copyWith(
          model: model,
          eventId: eventIds,
          loadAttachments: data,
          status: FormStatus.addAttachment),
    );
  }

  // get depositor user by role API call
  Future<void> getUserByRoleDepositor(String userRole) async {
    try {
      // GetDepositor getDepositorData =
      //     await createFoundServices.getUserByRoleDepositor(userRole, context);
      // log('--getUserByRoleDepositor-locationId-${locationId}--');

      GetDepositor getDepositorData = await commonServices.getAtomStaticUsers(
          roleName: userRole, locationId: state.model.location?.id);

      emit(
        state.copyWith(
          getDepositorResponse: getDepositorData,
          status: FormStatus.initial,
          model: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          model: model,
          message: Constants.errorText,
          status: FormStatus.failure,
        ),
      );
    }
  }

  // Get locations api call
  Future<void> getLocations(String locationsStr) async {
    try {
      Locations getLocationsData =
          await commonServices.getRegionsWithLocations(name: locationsStr);

      emit(
        state.copyWith(
          model: model,
          locations: getLocationsData,
          status: FormStatus.initial,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          model: model,
          message: Constants.errorText,
          status: FormStatus.failure,
        ),
      );
    }
  }

  // Get employee departments
  Future<void> getEmployeeDepartments(String departmentStr) async {
    try {
      // EmployeeDepartments getEmployeeDepartments = await createFoundServices
      //     .getEmployeeDepartments(departmentStr, context);
      EmployeeDepartments getEmployeeDepartments =
          await commonServices.getDepartments(name: departmentStr);
      emit(
        state.copyWith(
          model: model,
          getEmployeeDepartmentsResponse: getEmployeeDepartments,
          status: FormStatus.initial,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          model: model,
          message: Constants.errorText,
          status: FormStatus.failure,
        ),
      );
    }
  }

  // Get Article type employee Api call
  Future<void> getArticleType(String articleTypeStr) async {
    try {
      // GetArticleType getArticleTypeData =
      //     await createFoundServices.getArticleType(articleTypeStr, context);

      GetArticleType getArticleTypeData = await commonServices.getArticleType(
        name: articleTypeStr,
      );
      emit(
        state.copyWith(
          model: model,
          getArticleTypeResponse: getArticleTypeData,
          status: FormStatus.initial,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          model: model,
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
          model: model,
          createOrganisationResponse: createOrganisationData,
          status: FormStatus.initial,
        ),
      );
      await createFoundArticleCubit.getArticleType(
        'ARTICLE_LIST',
      );
      dismissLoadingDialog(context);
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Utils.dynamicAlert(
            context, Constants.addedSuccessfully, Constants.addarticletype, '');
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
    }
  }

  // Create organisation call
  Future<void> createEmployeeDepartments(
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
          model: model,
          createEmployeeDepartments: createOrganisationData,
          status: FormStatus.initial,
        ),
      );
      await createFoundArticleCubit
          .getEmployeeDepartments('EMPLOYEE_DEPARTMENTS');
      dismissLoadingDialog(context);
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Utils.dynamicAlert(context, Constants.addedSuccessfully,
            Constants.addEmpDepartment, '');
      });
    } on GenericResponse catch (e) {
      emit(
        state.copyWith(
          model: model,
          message: e.message,
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
          model: model,
          message: Constants.errorText,
          status: FormStatus.failure,
        ),
      );
      dismissLoadingDialog(context);
      // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      //   Utils.dynamicAlert(context, Constants.errorText,
      //       Constants.addemployeedepartment, Constants.errorText);
      // }
      // );
    }
  }

  // Create user call
  Future<void> createUser(String firstName, String lastName, String email,
      String role, int locationId, BuildContext context) async {
    try {
      // CreateUserModel createUserData = await createFoundServices.createUser(
      //     firstName, lastName, email, role, context);

      User createUserData = await commonServices.createUser(
        firstName: firstName,
        lastName: lastName,
        email: email,
        role: role,
        locationId: locationId,
        context: context,
      );
      emit(
        state.copyWith(
          model: model,
          createUserResponse: createUserData,
          status: FormStatus.initial,
        ),
      );
      dismissLoadingDialog(context);
      await createFoundArticleCubit
          .getUserByRoleDepositor(ConstantUserRoles.atomStaticUser);
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Utils.dynamicAlert(context, Constants.userAddedUpdatedSuccessfully,
            Constants.newuser, '');
      });
    } on GenericResponse catch (e) {
      emit(
        state.copyWith(
          model: model,
          message: e.message,
          status: FormStatus.failure,
        ),
      );
      dismissLoadingDialog(context);
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Utils.dynamicAlert(
            context, e.message ?? '', Constants.newuser, Constants.errorText);
      });
    } on Exception catch (e) {
      emit(
        state.copyWith(
          message: e.toString(),
          status: FormStatus.error,
        ),
      );
    }
  }

  // Get user details call
  Future<void> getUserDetails(String userId) async {
    try {
      User user = await commonServices.getUserDetails(userId: userId);
      emit(
        state.copyWith(
          model: model,
          loggedInUser: user,
          status: FormStatus.initial,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          model: model,
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
    Organisation location,
  ) async {
    log('Will Generate New Serial Number.');
    try {
      SerialNumberModel response = await commonServices.getSlNo(
          locationId: locationId, moduleCode: moduleCode);

      GetDepositor getDepositorData = await commonServices.getAtomStaticUsers(
          roleName: ConstantUserRoles.atomStaticUser, locationId: location.id);

      emit(
        state.copyWith(
          // model: model,
          getDepositorResponse: getDepositorData,
          location: location,
          slno: response.serialNo,
          status: FormStatus.initial,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          model: model,
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
