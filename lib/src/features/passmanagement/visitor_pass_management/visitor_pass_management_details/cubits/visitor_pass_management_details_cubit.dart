import 'dart:developer';
import 'dart:math' as math;

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/passmanagement/visitor_pass_management/models/requestModels/visitor_pass_management_request.dart';
import 'package:db_atom/src/features/passmanagement/visitor_pass_management/models/visitor_pass_management_model.dart';
import 'package:db_atom/src/features/passmanagement/visitor_pass_management/services/visitor_pass_management_service.dart';
import 'package:intl/intl.dart';

part 'visitor_pass_management_details_state.dart';

class VisitorPassManagementDetailsCubit extends Cubit<VisitorPassManagementDetailsState> {
  final VisitorPassManagementServices visitorPassManagementServices;
  final VisitorPassManagementModel? model;
  final CommonServices commonServices;

  VisitorPassManagementDetailsCubit({
    required this.visitorPassManagementServices,
    required this.commonServices,
    this.model,

  }) : super(
    VisitorPassManagementDetailsState.initial(
      model: model ?? VisitorPassManagementModel(),
      locations: Locations(),
      users: const [],
      emailUsers: const [],
      errorMessage: '',
      departments: const [],
      loadAttachments: const [], listOfEntities: const [], getCompanyTypeResponse: const [], dayPassReason:const [], passNo: const [], passType: const [], getStatus: const [],
    ),
  );

  Future<void> refreshList() async {
    emit(state.copyWith(status: FormStatus.loading));

    List<Organisation>? entities =
    await commonServices.getOrganisations(name: 'ATOM_ENTITIES');
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
        // getEntitiesResponse: entities,
        listOfEntities: entities,
        emailUsers: emailUsers,
        departments: departments.employeeDepartments,
        receiverEmailUsers: onlyDBUsers,
        employee: onlyDBUsers,
        host: onlyDBUsers,
        dbSponsor: onlyDBUsers,
      ),
    );
  }

  void onModelValueChange(VisitorPassManagementModel model) {
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onCheckBoxChange(VisitorPassManagementModel model) {
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
      String moduleCode = Constants.visitorPassManagementModule;
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
        commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS'),
        commonServices.getUiLabels(
            language: await SharedPrefs.getLanguageCode(),
            moduleCode: Constants.dayPassManagementModule),
        SharedPrefs.getDefaultLocation(),
        commonServices.getBaseUsers(
            roleName: ConstantUserRoles.atomStaticUser,
            isDbUser: true,
            locationId: state.model.location!.id!),
        commonServices.getEntities(name: 'ATOM_ENTITIES'),
        commonServices.getPassNo(passType: 1, locationId: state.model.location!.id!,isDwsPass: false),
        commonServices.getPassType(passType: 1, locationId: state.model.location!.id!,),
        commonServices.getStatusesByModuleId(
            module: Constants.passManagementModuleCode, filter: state.model.status == 0 ? 0 : 1),
      ]);
      Locations locations = futures[0];
      User loggedInUserDetails = futures[1];
      EmployeeDepartments departments = futures[2];
      dynamic responseLabels = futures[3];
      Organisation? defaultLocation = futures[4];
      List<BaseUser> emailUsers = futures[5];
      AddEntities entities = futures[6];
      DayPassNumberLists passNo = futures[7];
      List<Organisation> getPassType = futures[8];
      List<Organisation> getStatus = futures[9];


      log('--emailUsers--${emailUsers.length}---');
      // Get Date of Creation
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.inputDate ?? '0'),
          Constants.fulldateFormat);

      if(state.model.status !=null && state.model.status !=0) {
        state.model.returnedTime = state.model.returnedTime == null
            ? Utils().getCurrentDate()
            : Utils.timestampToDateConversion(
            int.tryParse(state.model.returnedTime ?? '0'),
            Constants.fulldateFormat);
      }
      // state.model.passType = 1;

      MmUiLabels labels = MmUiLabels.fromJson(responseLabels);

      log('--loggedInUserDetails---${loggedInUserDetails.firstName}----');

      state.model.entrySecurity ??= loggedInUserDetails;

      if(state.model.updatedStatus == 2  || state.model.updatedStatus == 8  || state.model.updatedStatus == 9 ){
        state.model.handoverSecurity ??= loggedInUserDetails;
      }

      log('--state.model.entrySecurity---${state.model.entrySecurity?.firstName}----');

      if (getPassType.isNotEmpty && state.model.passTypeName == null) {
        Organisation defaultPassType = getPassType.first;
        state.model.passTypeName = defaultPassType.name;
      }

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
          dbSponsor: onlyDBUsers,
          host: onlyDBUsers,
          departments: departments.employeeDepartments,
          labels: labels,
          listOfEntities: entities.atomEntities,
          passNo: passNo.activePassInfoList,
          passType: getPassType,
          getStatus:getStatus,
          loadAttachments: state.model.visitorImage != null
              ? [state.model.visitorImage ?? ImageContent()]
              : [],
        ),
      );
    } catch (e) {
      log('Initialization issue',
          error: e, name: 'Visitor Pass Management Details Cubit');
      emit(
        state.copyWith(
          message: Constants.errorText,
          // TODO: error message should be dynamic
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
    DayPassNumberLists passNo = DayPassNumberLists(activePassInfoList: []); // Initialize with default value
    List<Organisation> getPassType = [];


    // Get Sl No from API
    if (location != null) {
      SerialNumberModel slNo = await commonServices.getSlNo(
        locationId: location.id.toString(),
        moduleCode: Constants.visitorPassManagementModule,
      );
      state.model.location = location;
      state.model.slNo = slNo.serialNo;

      state.model.host?.employeeId = null;
      state.model.host?.firstName = null;
      state.model.host?.lastName = null;
      state.model.host = null;
      state.model.hostEmployeeId = null;

      emailUsers = await commonServices.getBaseUsers(
          roleName: ConstantUserRoles.atomStaticUser,
          isDbUser: true,
          locationId: state.model.location!.id!);
      passNo = await commonServices.getPassNo(
          passType: 1,
          locationId: state.model.location!.id!,
          isDwsPass: false);

      getPassType = await commonServices.getPassType(
          passType: 1,
          locationId: state.model.location!.id!);

    }


    if (getPassType.isNotEmpty) {
      Organisation defaultPassType = getPassType.first;
      state.model.passTypeName = defaultPassType.name;
    }
    // state.model. = null;
    // state.model.passTypeName = null;
    state.model.passNo = null;

    emit(state.copyWith(
      model: state.model,
      employee: emailUsers,
      host: emailUsers,
      dbSponsor: emailUsers,
      passNo: passNo.activePassInfoList,
      passType: getPassType,
      status: FormStatus.initial,
    ));
  }

  Future<void> updateDropdownValues({
    List<Organisation>? entities,
    Organisation? passType,
    Organisation? updatedStatus,
    Organisation? companyType,
    BaseUser? user,
    BaseUser? host,
    BaseUser? employee,
    BaseUser? receiverByEmail,
    Organisation? department,
    Organisation? passNo,
    Organisation? passNos,
    Organisation? dayPassReason,
    int? status,
    int? validateType,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    state.model.status = status ?? state.model.status;

    state.model.idValidationType = validateType??state.model.idValidationType;
    if (entities != null) {
      state.model.entities = entities;
    }


    if (host != null) {
      // Ensure employeeId is explicitly assigned to receiverEmployeeId
      state.model.hostEmployeeId = host.employeeId;
      state.model.hostName = host.name;
      // Format the name and email for receiverEmail
      String name = host.name ?? '';
      String email = host.email ?? '';
      List<String> nameParts = host.name!.split(' '); // Split by space
      String? firstName = nameParts.isNotEmpty ? nameParts.first : null;
      String? lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : null;
      User userDetails = User(
          name:name,
          userId: host.id,
          email: email,
          employeeId: host.employeeId,
        firstName: firstName,
        lastName: lastName,
      );
      state.model.host = userDetails;
      emit(
        state.copyWith(
          model: state.model,
          status: FormStatus.initial,
        ),
      );
    }
    if (department != null) {
      state.model.department = department;
    }

    if (dayPassReason != null) {
      state.model.dayPassReason = dayPassReason;
    }

    if (passNo != null) {
      // Ensure employeeId is explicitly assigned to receiverEmployeeId
      state.model.passInfo?.passNo = passNo.name;

      // Format the name and email for receiverEmail
      String name = passNo.name ?? '';
      int id = passNo.id ?? 0;
      PassInfo userDetails = PassInfo(
        passNo:name,
        id: passNo.id,
        passType: 1
      );
      state.model.passInfo = userDetails;
      emit(
        state.copyWith(
          model: state.model,
          status: FormStatus.initial,
        ),
      );
    }

    if (passType != null) {
      state.model.passType = passType.id;
      state.model.passTypeName = passType.name;
    }

    if (updatedStatus != null) {
      state.model.updatedStatus = updatedStatus.id;
    }

    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
    ));
  }

  Future<void> updateApproverEmailsValue({
    BaseUser? requesterEmailUser,
    BaseUser? approver1EmailUser,
    BaseUser? approver2EmailUser,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
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
    int eventIds = math.Random.secure().nextInt(5);

    if (data != null && images != null) {
      // for (var image in data) {
      //   image.type = 8;
      // }
      state.model.visitorImage = images.first;
      emit(
        state.copyWith(
          model: state.model,
          loadAttachments: images,
          status: FormStatus.initial,
        ),
      );
    }

    emit(
      state.copyWith(
        model: state.model,
        status: FormStatus.initial,
      ),
    );

    log('--state.status--3--${state.status}----');
  }

  Future<bool> submitForm({
    bool isSaveOnly = false,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    DateTime dateTime;
    if (!Utils().isTimestamp(state.model.inputDate!)) {
      dateTime =
          DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.inputDate!);
      int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
      state.model.inputDate = inputDate.toString();
    }

    state.model.startTime = state.model.startTime != null
        ? ((int.tryParse(state.model.startTime ?? '') ?? DateTime.now().millisecondsSinceEpoch)).toString()
        : (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

    state.model.endTime = state.model.endTime != null
        ? ((int.tryParse(state.model.endTime ?? '') ?? DateTime.now().add(const Duration(hours: 12)).millisecondsSinceEpoch)).toString()
        : (DateTime.now().add(const Duration(hours: 12)).millisecondsSinceEpoch ~/ 1000).toString();


    if(state.model.status == 1 && (state.model.updatedStatus == 2||state.model.updatedStatus == 8 || state.model.updatedStatus == 9)){
      state.model.returnedTime = state.model.returnedTime != null
          ? ((int.tryParse(state.model.returnedTime ?? '') ?? DateTime.now().millisecondsSinceEpoch)).toString()
          : (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
    }
    // Create/Update API Call
    VisitorPassManagementRequest request =
    VisitorPassManagementRequest(passManagement: state.model);
    // TODO: Need to change from Backend- Status should be handled from backend
    state.model.status ??= 0;

    state.model.passInfo?.passType ??= 1;
    try {
      GenericResponse response = GenericResponse();
      if (isSaveOnly) {
        //Validating Fields
        if (!state.isValidDraft.status) {
          state.model.inputDate = state.model.inputDate == null
              ? Utils().getCurrentDate()
              : Utils.timestampToDateConversion(
              int.tryParse(state.model.inputDate ?? '0'),
              Constants.fulldateFormat);
          emit(
            state.copyWith(
              status: FormStatus.formError,
              message: state.isValidDraft.message,
            ),
          );
          return false;
        }
        response = await visitorPassManagementServices.createVisitorPass(
            requestBody: request, isSubmit: false);
      } else {
        //Validating Fields
        if (!state.isValid.status) {
          state.model.inputDate = state.model.inputDate == null
              ? Utils().getCurrentDate()
              : Utils.timestampToDateConversion(
              int.tryParse(state.model.inputDate ?? '0'),
              Constants.fulldateFormat);
          emit(
            state.copyWith(
              status: FormStatus.formError,
              message: state.isValid.message,
            ),
          );
          return false;
        }
        response = await visitorPassManagementServices.createVisitorPass(
            requestBody: request, isSubmit: true);
      }

      log('---response--msg--${response.message}---');

      if (response.id != null) {
        int? id = int.tryParse(response.id!);
        if (id != null) {
          state.model.id = id;
        }
      }
      emit(
        state.copyWith(
          model: state.model,
          message: response.message,
          status: FormStatus.success,
        ),
      );
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.inputDate ?? '0'),
          Constants.fulldateFormat);
      return true;
    } on GenericResponse catch (e) {
      Utils().emitErrorState(e, emit, state);
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.inputDate ?? '0'),
          Constants.fulldateFormat);
      return false;
    } on Exception catch (e) {
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.inputDate ?? '0'),
          Constants.fulldateFormat);
      emit(
        state.copyWith(
          message: e.toString(),
          status: FormStatus.error,
        ),
      );
      return false;
    }
  }

}
