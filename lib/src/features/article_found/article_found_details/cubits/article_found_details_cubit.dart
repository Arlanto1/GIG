import 'dart:developer';
import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/article_found/models/article_found_model.dart';
import 'package:db_atom/src/features/article_found/models/requestModels/article_found_request.dart';
import 'package:db_atom/src/features/article_found/services/article_found_service.dart';
import 'package:intl/intl.dart';


part 'article_found_details_state.dart';

class ArticleFoundDetailsCubit extends Cubit<ArticleFoundDetailsState> {
  final ArticleFoundServices articleFoundServices;
  final ArticleFoundModel? model;
  final CommonServices commonServices;
  final String? eventProtectionId;

  ArticleFoundDetailsCubit({
    required this.articleFoundServices,
    required this.commonServices,
    this.model,
    required this.eventProtectionId

  }) : super(
    ArticleFoundDetailsState.initial(
      model: model ?? ArticleFoundModel(),
      locations: Locations(),
      users: const [],
      emailUsers: const [],
      errorMessage: '',
      departments: const [],
      claimantDepartments: const [],
      articleType: const [], uploadAttachments: const [], articleCategory: const [],
    ),
  );

  Future<void> refreshList() async {
    emit(state.copyWith(status: FormStatus.loading));

    EmployeeDepartments departments =
    await commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS');
    List<BaseUser> emailUsers = await commonServices.getBaseUsers(
        roleName: ConstantUserRoles.atomStaticUser,
        locationId: state.model.location!.id!);
    List<BaseUser> onlyDBUsers = await commonServices.getBaseUsers(
      roleName: ConstantUserRoles.atomStaticUser,
      locationId: state.model.location!.id!,
      isDbUser: true,
    );

    emit(
      state.copyWith(
        status: FormStatus.initial,
        emailUsers: emailUsers,
        departments: departments.employeeDepartments,
        receiverEmailUsers: onlyDBUsers,
        employee: onlyDBUsers,
        host: onlyDBUsers,
        claimant: onlyDBUsers,
      ),
    );
  }

  void onModelValueChange(ArticleFoundModel model) {
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onCheckBoxChange(ArticleFoundModel model) {
    emit(state.copyWith(model: model, status: FormStatus.loading));

    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  Future<void> initializeValues() async {

    // Show Loader and emit loading state
    emit(
      state.copyWith(status: FormStatus.loading),
    );

    var userId = await SharedPrefs.getUserId();

    Organisation? defaultLocation = await SharedPrefs.getDefaultLocation();

    if (state.model.location == null && defaultLocation != null) {
      String moduleCode = Constants.articleFoundModuleCode;
      SerialNumberModel slNo = await commonServices.getSlNo(
        locationId: defaultLocation.id.toString(),
        moduleCode: moduleCode,
      );
      state.model.location = defaultLocation;
      state.model.slNo = slNo.serialNo;
    }

    try {
      // Use Future.wait to call API functions concurrently
      final futures = await Future.wait([
        commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS'),
        commonServices.getUserDetails(userId: userId),
        commonServices.getUiLabels(
            language: await SharedPrefs.getLanguageCode(),
            moduleCode: Constants.articleFoundModuleCode),
        SharedPrefs.getDefaultLocation(),
        commonServices.getBaseUsers(
            roleName: ConstantUserRoles.atomStaticUser,
            isDbUser: true,
            locationId: state.model.location!.id!),
        commonServices.getOrganisations(name: 'ARTICLE_LIST'),
        commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS'),
        commonServices.getOrganisations(name: 'ARTICLE_CATEGORY'),
      ]);
      Locations locations = futures[0];
      User loggedInUserDetails = futures[1];
      dynamic responseLabels = futures[2];
      Organisation? defaultLocation = futures[3];
      List<BaseUser> emailUsers = futures[4];
      List<Organisation> articleType = futures[5];
      EmployeeDepartments departments = futures[6];
      List<Organisation> articleCategory = futures[7];

      // Get Date of Creation
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.inputDate ?? '0'),
          Constants.fulldateFormat);


      state.model.handoverDate = state.model.handoverDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.handoverDate ?? '0'),
          Constants.fulldateFormat);

      AFUiLabels labels = AFUiLabels.fromJson(responseLabels);


      state.model.entrySecurity ??= loggedInUserDetails;
      // if(state.model.updatedStatus == 2  || state.model.updatedStatus == 8  || state.model.updatedStatus == 9 ){
        state.model.handoverSecurity ??= loggedInUserDetails;
      // }

      List<BaseUser> onlyDBUsers = await commonServices.getBaseUsers(
        roleName: ConstantUserRoles.atomStaticUser,
        locationId: state.model.location!.id!,
        isDbUser: true,
      );

      emit(
        state.copyWith(
          locations: locations,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          model: state.model,
          employee: onlyDBUsers,
          claimant: onlyDBUsers,
          host: onlyDBUsers,
          idCardManger: onlyDBUsers,
          idCardEmployee: onlyDBUsers,
          departments: departments.employeeDepartments,
          labels: labels,
          articleType: articleType,
            articleCategory:articleCategory,
        ),
      );
    } catch (e) {
      log('Initialization issue',
          error: e, name: 'Article Found Details Cubit');
      emit(
        state.copyWith(
          message: Constants.errorText,
          status: FormStatus.error,
        ),
      );
    }
  }

  Future<void> updateLocationDropdownValue({
    Organisation? location,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    List<BaseUser> emailUsers = [];

    // Get Sl No from API
    if (location != null) {
      SerialNumberModel slNo = await commonServices.getSlNo(
        locationId: location.id.toString(),
        moduleCode: Constants.dayPassManagementModule,
      );
      state.model.location = location;
      state.model.slNo = slNo.serialNo;

      // state.model.host?.employeeId = null;
      // state.model.host?.firstName = null;
      // state.model.host?.lastName = null;
      // state.model.host = null;
      // state.model.hostEmployeeId = null;

      // state.model.employee?.employeeId = null;
      // state.model.employee?.firstName = null;
      // state.model.employee?.lastName = null;
      // state.model.employee = null;
      // state.model.employeeId = null;
      emailUsers = await commonServices.getBaseUsers(
          roleName: ConstantUserRoles.atomStaticUser,
          isDbUser: true,
          locationId: state.model.location!.id!);
    }

    emit(state.copyWith(
      model: state.model,
      employee: emailUsers,
      host: emailUsers,
      claimant: emailUsers,
      idCardEmployee: emailUsers,
      idCardManger: emailUsers,
      status: FormStatus.initial,
    ));
  }

  Future<void> updateDropdownValues({
    List<Organisation>? entities,
    Organisation? passType,
    Organisation? articleType,
    Organisation? articleCategory,
    BaseUser? user,
    BaseUser? claimant,
    BaseUser? employee,
    BaseUser? receiverByEmail,
    Organisation? department,
    Organisation? claimantDepartment,
    Organisation? passNo,
    Organisation? passNos,
    Organisation? dayPassReason,
    BaseUser? idCardManager,
    BaseUser? idCardEmployee,
    int? assetType,

    int? status,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    state.model.status = status ?? state.model.status;

    if (assetType != null) {
      state.model.typeOfAsset = assetType;
    }

    if (articleType != null) {
      state.model.typeOfArticle = articleType;
    }


    if(articleCategory !=null){
      state.model.articleCategory = articleCategory;
    }
    if ( employee!= null) {
      state.model.depositor?.employeeId = employee.employeeId;
      state.model.employeeId = employee.employeeId;
      String name = employee.name ?? '';
      String email = employee.email ?? '';
      List<String> nameParts = employee.name!.split(' '); // Split by space
      String? firstName = nameParts.isNotEmpty ? nameParts.first : null;
      String? lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : null;
      User userDetails = User(
        name:name,
        userId : employee.id,
        email: email,
        employeeId: employee.employeeId,
        firstName: firstName,
        lastName: lastName,
      );
      state.model.depositor = userDetails;
      emit(
        state.copyWith(
          model: state.model,
          status: FormStatus.initial,
        ),
      );
    }

    if ( claimant!= null) {
      state.model.claimant?.employeeId = claimant.employeeId;
      state.model.claimantEmployeeId = claimant.employeeId;
      String name = claimant.name ?? '';
      String email = claimant.email ?? '';
      List<String> nameParts = claimant.name!.split(' '); // Split by space
      String? firstName = nameParts.isNotEmpty ? nameParts.first : null;
      String? lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : null;
      User userDetails = User(
        name:name,
        userId : claimant.id,
        email: email,
        employeeId: claimant.employeeId,
        firstName: firstName,
        lastName: lastName,
      );
      state.model.claimant = userDetails;
      emit(
        state.copyWith(
          model: state.model,
          status: FormStatus.initial,
        ),
      );
    }
    if (department != null) {
      state.model.depositorDepartment = department;
    }

    if(claimantDepartment !=null){
      state.model.claimantDepartment = claimantDepartment;
    }

    if ( idCardManager!= null) {
      state.model.idCardManager?.employeeId = idCardManager.employeeId;
      String name = idCardManager.name ?? '';
      String email = idCardManager.email ?? '';
      List<String> nameParts = idCardManager.name!.split(' '); // Split by space
      String? firstName = nameParts.isNotEmpty ? nameParts.first : null;
      String? lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : null;
      User userDetails = User(
        name:name,
        userId : idCardManager.id,
        email: email,
        employeeId: idCardManager.employeeId,
        firstName: firstName,
        lastName: lastName,
      );
      state.model.idCardManager = userDetails;
      emit(
        state.copyWith(
          model: state.model,
          status: FormStatus.initial,
        ),
      );
    }

    if ( idCardEmployee!= null) {
      state.model.idCardEmployee?.employeeId = idCardEmployee.employeeId;
      String name = idCardEmployee.name ?? '';
      String email = idCardEmployee.email ?? '';
      List<String> nameParts = idCardEmployee.name!.split(' '); // Split by space
      String? firstName = nameParts.isNotEmpty ? nameParts.first : null;
      String? lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : null;
      User userDetails = User(
        name:name,
        userId : idCardEmployee.id,
        email: email,
        employeeId: idCardEmployee.employeeId,
        firstName: firstName,
        lastName: lastName,
      );
      state.model.idCardEmployee = userDetails;
      emit(
        state.copyWith(
          model: state.model,
          status: FormStatus.initial,
        ),
      );
    }

    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
    ));
  }

  void addAttachment({
    List<ImageContent>? data,
    List<ImageContent>? images,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    if (data != null) {
      for (ImageContent image in data) {
        image.type = 1;
      }
      log('--data----${data.length}----');

      state.model.images = data;
      emit(
        state.copyWith(
          // eventId: eventIds,
          model: state.model,
          uploadAttachments: data,
          status: FormStatus.initial,
        ),
      );
    }

    emit(
      state.copyWith(
        // eventId: eventIds,
        model: state.model,
        status: FormStatus.initial,
      ),
    );

  }

  // void makeSignEditable(
  //     {bool? receiverSign, bool? securitySignatureSignEditable}) {
  //   emit(
  //     state.copyWith(
  //       status: FormStatus.loading,
  //     ),
  //   );
  //   emit(
  //     state.copyWith(
  //       isReceiverSignEditable: receiverSign,
  //       status: FormStatus.initial,
  //     ),
  //   );
  // }

  Future<void> pushSignature({
    required SignatureController controller,
    required bool isReceiverSignature,
  }) async {
    String imageBytes = await SignatureController().exportSignature(controller);

    // Check for null explicitly
    if (imageBytes.isEmpty) {
      return;
    }

    ImageContent imageContent = ImageContent();
    imageContent.imageContent = imageBytes;

    log('--imageBytes--$imageBytes--');
    // if (isReceiverSignature) {
      imageContent.type =
          ConstantsIntValue.keyIssuanceReceiverSignImageContentType;
      state.model.claimantSign = imageContent;
      emit(state.copyWith(
        model: state.model,
      ));
  }

  void clearSign() {
    emit(state.copyWith(status: FormStatus.loading));

    state.model.claimantSign = null;

    emit(
      state.copyWith(
        model: state.model,
        isReceiverSignEditable: true, // let the UI show the blank pad again
        status: FormStatus.initial,
      ),
    );
  }
  void makeSignEditable() {
    emit(state.copyWith(status: FormStatus.loading));
    emit(
      state.copyWith(
        isReceiverSignEditable: true,
        status: FormStatus.initial,
      ),
    );
  }
  void submitForm({bool isSaveOnly = false, required SignatureController claimantSignatureController,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    state.model.status ??= 0;

    DateTime dateTime;
    if (!Utils().isTimestamp(state.model.inputDate!)) {
      dateTime =
          DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.inputDate!);
      int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
      state.model.inputDate = inputDate.toString();
    }


    state.model.eventProtection ??= EventInfoResponse();
    state.model.eventProtection?.id = eventProtectionId.toIntOrNull();

    await pushSignature(controller: claimantSignatureController, isReceiverSignature: true);

    ArticleFoundRequest request =
    ArticleFoundRequest(articleFoundModel: state.model);
    GenericResponse response = GenericResponse();
    try {
      if (isSaveOnly) {
        if (!state.isValidDraft.status) {
          emit(
            state.copyWith(
              status: FormStatus.formError,
              message: state.isValidDraft.message,
            ),
          );
          state.model.inputDate = state.model.inputDate == null
              ? Utils().getCurrentDate()
              : Utils.timestampToDateConversion(
              int.tryParse(state.model.inputDate ?? '0'),
              Constants.fulldateFormat);
          return;
        }
        response = (await articleFoundServices.createArticleFound(
            body: request, isSubmit: false,eventId: eventProtectionId));
      } else {
        //Validating Fields
        if (!state.isValid.status) {
          emit(
            state.copyWith(
              status: FormStatus.formError,
              message: state.isValid.message,
            ),
          );
          state.model.inputDate = state.model.inputDate == null
              ? Utils().getCurrentDate()
              : Utils.timestampToDateConversion(
              int.tryParse(state.model.inputDate ?? '0'),
              Constants.fulldateFormat);
          return;
        }
        response = (await articleFoundServices.createArticleFound(
            body: request, isSubmit: true, eventId: eventProtectionId));
      }
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.inputDate ?? '0'),
          Constants.fulldateFormat);
    } on GenericResponse catch (e) {
      Utils().emitErrorState(e, emit, state);
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.inputDate ?? '0'),
          Constants.fulldateFormat);
      return;
    } on Exception catch (e) {
      emit(
        state.copyWith(
          message: e.toString(),
          status: FormStatus.error,
        ),
      );
    }

    log('---response--msg--${response.message}---');
    emit(
      state.copyWith(
        message:response.Message,
        status: FormStatus.success,
      ),
    );
  }
}
