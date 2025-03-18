import 'dart:developer';
import 'dart:math' as math;

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/passmanagement/day_pass_mangement/services/day_passmanagement_service.dart';
import 'package:db_atom/src/features/passmanagement/models/day_pass_reason_model.dart';
import 'package:intl/intl.dart';

import '../../models/day_pass_management_model.dart';
import '../../models/requestModels/day_pass_management_request.dart';

part 'day_passmanagement_details_state.dart';

class DayPassManagementDetailsCubit extends Cubit<DayPassManagementDetailsState> {
  final DayPassManagementServices dayPassManagementServices;
  final DayPassManagementModel? model;
  final CommonServices commonServices;

  DayPassManagementDetailsCubit({
    required this.dayPassManagementServices,
    required this.commonServices,
    this.model,

  }) : super(
    DayPassManagementDetailsState.initial(
      model: model ?? DayPassManagementModel(),
      locations: Locations(),
      users: const [],
      emailUsers: const [],
      errorMessage: '',
      departments: const [],
      listOfEntities: const [], getCompanyTypeResponse: const [], dayPassReason:const [], passNo: const [], passType: const [], getStatus: const [], uploadAttachments: [],
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

  void onModelValueChange(DayPassManagementModel model) {
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onCheckBoxChange(DayPassManagementModel model) {
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
      String moduleCode = Constants.dayPassManagementModule;
      SerialNumberModel slNo = await commonServices.getSlNo(
        locationId: defaultLocation.id.toString(),
        moduleCode: moduleCode,
      );
      state.model.location = defaultLocation;
      state.model.slNo = slNo.serialNo;
    }

    // if (state.model.status != null && state.model.status != 0) {
    //   String moduleCode = Constants.passManagementModule;
    //   // SerialNumberModel slNo = await commonServices.getSlNo(
    //   //   locationId: defaultLocation.id.toString(),
    //   //   moduleCode: moduleCode,
    //   // );
    //   Organisation updatedStatus = await commonServices.getStatusesByModuleId(
    //       module: Constants.passManagementModuleCode, filter: state.model.status == 0 || state.model.status == null ? 0 : 1);
    //   state.model.location = defaultLocation;
    //   state.model.updatedStatus = updatedStatus.id;
    // }
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
        commonServices.getDayPassreason(name: 'DAY_PASS_REASON'),
        commonServices.getPassNo(passType: 0, locationId: state.model.location!.id!,),
        commonServices.getOrganisations(name: 'ATOM_COMPANY_TYPES'),
        commonServices.getPassType(passType: 0, locationId: state.model.location!.id!,),
        commonServices.getStatusesByModuleId(
          module: Constants.dayPassManagementModule, filter: state.model.status == 0 ? 0 : 1),
      ]);
      Locations locations = futures[0];
      User loggedInUserDetails = futures[1];
      EmployeeDepartments departments = futures[2];
      dynamic responseLabels = futures[3];
      Organisation? defaultLocation = futures[4];
      List<BaseUser> emailUsers = futures[5];
      AddEntities entities = futures[6];
     DayPassReason dayPassReason = futures[7];
      DayPassNumberLists passNo = futures[8];
      List<Organisation> companyType = futures[9];
      List<Organisation> getPassType = futures[10];
      List<Organisation> getStatus = futures[11];


      if (getPassType.isNotEmpty && state.model.passTypeName == null) {
        Organisation defaultPassType = getPassType.first;
        state.model.passTypeName = defaultPassType.name;
      }
      log('--emailUsers--${emailUsers.length}---');
      // Get Date of Creation
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.inputDate ?? '0'),
          Constants.fulldateFormat);

      // state.model.startTime = state.model.startTime == null
      //     ? Utils().getCurrentDate()
      //     : Utils.timestampToDateConversion(
      //     int.tryParse(state.model.startTime ?? '0'),
      //     Constants.fulldateFormat);
      //
      // state.model.endTime =
      //     Utils.timestampToDateConversion(
      //     DateTime.now().add(const Duration(hours: 12)).millisecondsSinceEpoch,
      //     Constants.fulldateFormat);
      MmUiLabels labels = MmUiLabels.fromJson(responseLabels);

      log('--date---${Utils.timestampToDateConversion(
          int.tryParse(state.model.returnedTime ?? '0'),
          Constants.fulldateFormat)}----');

      state.model.entrySecurity ??= loggedInUserDetails;
      if((state.model.updatedStatus == 2 || state.model.updatedStatus == 8 || state.model.updatedStatus == 9)) {
        state.model.handoverSecurity ??= loggedInUserDetails;
      }
      log('111${(state.model.status == 2 || state.model.status == 8 || state.model.status == 9 || state.model.updatedStatus == 2 || state.model.updatedStatus == 8 || state.model.updatedStatus == 9)}----');

      // if((state.model.status == 2 || state.model.status == 8 || state.model.status == 9 || state.model.updatedStatus == 2 || state.model.updatedStatus == 8 || state.model.updatedStatus == 9)) {
      //
      //   log('222${(state.model.status == 2 || state.model.status == 8 || state.model.status == 9 || state.model.updatedStatus == 2 || state.model.updatedStatus == 8 || state.model.updatedStatus == 9)}----');
      //   state.model.returnedTime = state.model.returnedTime == null
      //       ? Utils().getCurrentDate()
      //       : Utils.timestampToDateConversion(
      //       int.tryParse(state.model.returnedTime ?? '0'),
      //       Constants.fulldateFormat);
      // }
      log('--status---${state.model.status == 1 && (state.model.status == 2 || state.model.status == 8 || state.model.status == 9)}----');
      //
      // if((state.model.status != 0 && state.model.updatedStatus != 3 && state.model.updatedStatus != 4 &&  state.model.status != 5 && state.model.status != 6 && state.model.status != 7) && state.model.status == 1) {
      //   state.model.returnedTime = state.model.returnedTime == null
      //       ? Utils().getCurrentDate()
      //       : Utils.timestampToDateConversion(
      //       int.tryParse(state.model.returnedTime ?? '0'),
      //       Constants.fulldateFormat);
      // }
      //
      // if((state.model.status != 0 && state.model.updatedStatus != 3 && state.model.updatedStatus != 4 &&  state.model.status != 5 && state.model.status != 6 && state.model.status != 7) && state.model.status == 1) {
      //   state.model.returnedTime = state.model.returnedTime != null
      //       ? Utils.timestampToDateConversion(
      //       int.tryParse(state.model.returnedTime ?? '0'),
      //       Constants.dateFormat)
      //       :Utils().getCurrentDate() ;
      // }
      // state.model.rejectedBy ??= loggedInUserDetails;
      log('--state.model.entrySecurity---${state.model.entrySecurity?.firstName}----');

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
          dayPassReason :dayPassReason.dayPassReasonElement,
          passNo: passNo.activePassInfoList,
          companyType: companyType,
          passType: getPassType,
          getStatus:getStatus,
        ),
      );
    } catch (e) {
      log('Initialization issue',
          error: e, name: 'Day Pass Management Details Cubit');
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
        moduleCode: Constants.dayPassManagementModule,
      );
      state.model.location = location;
      state.model.slNo = slNo.serialNo;

      emailUsers = await commonServices.getBaseUsers(
          roleName: ConstantUserRoles.atomStaticUser,
          isDbUser: true,
          locationId: state.model.location!.id!);
      passNo = await commonServices.getPassNo(
          passType: 0,
          locationId: state.model.location!.id!);

      getPassType = await commonServices.getPassType(
          passType: 0,
          locationId: state.model.location!.id!);

    }
    if (getPassType.isNotEmpty) {
      Organisation defaultPassType = getPassType.first;
      state.model.passTypeName = defaultPassType.name;
    }
      // state.model. = null;
     state.model.host = null;
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
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    state.model.status = status ?? state.model.status;

    if (entities != null) {
      state.model.entities = entities;
    }

    if (companyType != null) {
      state.model.companyType = companyType;
      state.model.companyName =null;
      state.model.employee?.employeeId = null;
      state.model.employee?.name = null;
      state.model.employeeName = null;
      state.model.host?.employeeId = null;
      state.model.hostEmployeeId = null;
      state.model.host?.name = null;
      state.model.companyName = state.model.companyType?.name == 'FTE' ?'Deutsche Bank': state.model.companyName;
    }

    if ( employee!= null) {
      state.model.employeeId = employee.employeeId;
      state.model.employeeName = employee.name;
      state.model.email = employee.email;
      String name = employee.name ?? '';
      String email = employee.email ?? '';
      User userDetails = User(
        name:name,
        userId : employee.id,
        email: email,
        employeeId: employee.employeeId,
      );
      state.model.employee = userDetails;
      emit(
        state.copyWith(
          model: state.model,
          status: FormStatus.initial,
        ),
      );
    }

    if (host != null) {
      // Ensure employeeId is explicitly assigned to receiverEmployeeId
      state.model.hostEmployeeId = host.employeeId;
       state.model.hostName = host.name;
      // Format the name and email for receiverEmail
      String name = host.name ?? '';
      String email = host.email ?? '';
      User userDetails = User(
        name:name,
        userId: host.id,
        email: email,
        employeeId: host.employeeId
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
      state.model.passTypeName = passType.name;
    }

    if (passType == null) {
      // state.model.passTypeName = passType?.first;
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
    if (data != null) {
      for (ImageContent image in data) {
        image.type = 1;
      }
      log('--data----${data.length}----');

      state.model.evidenceDocuments = data;
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

    log('--state.status--3--${state.status}----');
  }


  void submitForm({bool isSaveOnly = false}) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    state.model.status ??= 0;
    // Setting time in milliseconds
    // state.model.createdDate =
    //     (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

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
    // if(state.model.status == 1 && (state.model.updatedStatus ==2 || state.model.updatedStatus == 8 || state.model.updatedStatus == 9)){
    // if(state.model.returnedTime !=null) {
    //   if (!Utils().isTimestamp(state.model.returnedTime!)) {
    //     dateTime =
    //         DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.returnedTime!);
    //     int inputDate = dateTime
    //         .toUtc()
    //         .millisecondsSinceEpoch ~/ 1000;
    //     state.model.returnedTime = inputDate.toString();
    //   }
    // }
    // }

    DayPassManagementRequest request =
         DayPassManagementRequest(passManagement: state.model);
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
          return;
        }
        response = (await dayPassManagementServices.createPass(
            requestBody: request, isSubmit: false));
      } else {
        //Validating Fields
        if (!state.isValid.status) {
          emit(
            state.copyWith(
              status: FormStatus.formError,
              message: state.isValid.message,
            ),
          );
          return;
        }
        response = (await dayPassManagementServices.createPass(
            requestBody: request, isSubmit: true));
      }
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.inputDate ?? '0'),
          Constants.fulldateFormat);
      state.model.returnedTime = state.model.returnedTime == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.returnedTime ?? '0'),
          Constants.fulldateFormat);
    } on GenericResponse catch (e) {
      Utils().emitErrorState(e, emit, state);

      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.inputDate ?? '0'),
          Constants.fulldateFormat);
      state.model.returnedTime = state.model.returnedTime == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.returnedTime ?? '0'),
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
        message:response.message,
        status: FormStatus.success,
      ),
    );
  }
}
