import 'dart:developer';
import 'dart:math' as math;

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/passmanagement/sez_pass_management/models/requestModels/sez_pass_management_request.dart';
import 'package:db_atom/src/features/passmanagement/sez_pass_management/models/sez_pass_management_model.dart';
import 'package:db_atom/src/features/passmanagement/sez_pass_management/services/sez_pass_management_service.dart';
import 'package:intl/intl.dart';

part 'sez_pass_management_details_state.dart';

class SezPassManagementDetailsCubit extends Cubit<SezPassManagementDetailsState> {
  final SezPassManagementServices sezPassManagementServices;
  final SezPassManagementModel? model;
  final CommonServices commonServices;

  final Organisation? location;
  final Organisation? locationRegion;

  SezPassManagementDetailsCubit({
    required this.sezPassManagementServices,
    required this.commonServices,
    this.model,
    required this.location,
    required this.locationRegion,

  }) : super(
    SezPassManagementDetailsState.initial(
      model: model ?? SezPassManagementModel(),
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

  void onModelValueChange(SezPassManagementModel model) {
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onCheckBoxChange(SezPassManagementModel model) {
    emit(state.copyWith(model: model, status: FormStatus.loading));

    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  // Future<void> initializeValues() async {
  //
  //   // Show Loader and emit loading state
  //   emit(
  //     state.copyWith(status: FormStatus.loading),
  //   );
  //
  //   var userId = await SharedPrefs.getUserId();
  //   //
  //   Organisation? defaultLocation = await SharedPrefs.getDefaultLocation();
  //
  //   if (state.model.location == null && defaultLocation != null) {
  //     String moduleCode = Constants.passManagementModule;
  //     SerialNumberModel slNo = await commonServices.getSlNo(
  //       locationId: defaultLocation.id.toString(),
  //       moduleCode: moduleCode,
  //     );
  //     state.model.location = null;
  //     state.model.slNo = slNo.serialNo;
  //   }
  //
  //   try {
  //     // Use Future.wait to call API functions concurrently
  //     final futures = await Future.wait([
  //       commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS', isSezLocations: true),//0
  //       commonServices.getUserDetails(userId: userId),//1
  //       commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS'),//2
  //       commonServices.getUiLabels(
  //           language: await SharedPrefs.getLanguageCode(),
  //           moduleCode: Constants.passManagementSEZModule),//3
  //       commonServices.getBaseUsers(
  //           roleName: ConstantUserRoles.atomStaticUser,
  //           isDbUser: true,
  //           locationId: state.model.location!.id!),//4
  //       commonServices.getEntities(name: 'ATOM_ENTITIES'),//5
  //       commonServices.getPassNo(passType: 0, locationId: state.model.location!.id!,),//6
  //       commonServices.getOrganisations(name: 'ATOM_COMPANY_TYPES'),//7
  //       commonServices.getPassType(passType: 0, locationId: state.model.location!.id!,),//8
  //       commonServices.getStatusesByModuleId(
  //           module: Constants.passManagementModuleCode, filter: state.model.status == 0 ? 0 : 1),//9
  //     ]);
  //     Locations locations = futures[0];
  //     User loggedInUserDetails = futures[1];
  //     EmployeeDepartments departments = futures[2];
  //     dynamic responseLabels = futures[3];
  //     List<BaseUser> emailUsers = futures[4];
  //     AddEntities entities = futures[5];
  //     DayPassNumberLists passNo = futures[6];
  //     List<Organisation> companyType = futures[7];
  //     List<Organisation> getPassType = futures[8];
  //     List<Organisation> getStatus = futures[9];
  //
  //
  //     log('--emailUsers--${emailUsers.length}---');
  //     // Get Date of Creation
  //     state.model.inputDate = state.model.inputDate == null
  //         ? Utils().getCurrentDate()
  //         : Utils.timestampToDateConversion(
  //         int.tryParse(state.model.inputDate ?? '0'),
  //         Constants.fulldateFormat);
  //
  //     state.model.startTime = state.model.startTime == null ? ''
  //         : Utils.timestampToDateConversion(
  //         int.tryParse(state.model.startTime ?? '0'),
  //         Constants.fulldateFormat);
  //
  //     MmUiLabels labels = MmUiLabels.fromJson(responseLabels);
  //
  //     log('--loggedInUserDetails---${loggedInUserDetails.firstName}----');
  //
  //     state.model.entrySecurity ??= loggedInUserDetails;
  //     // state.model.rejectedBy ??= loggedInUserDetails;
  //     log('--state.model.entrySecurity---${state.model.entrySecurity?.firstName}----');
  //
  //     List<BaseUser> onlyDBUsers = await commonServices.getBaseUsers(
  //       roleName: ConstantUserRoles.atomStaticUser,
  //       locationId: state.model.location!.id!,
  //       isDbUser: true,
  //     );
  //
  //     emit(
  //       state.copyWith(
  //         locations: locations,
  //         loggedInUserDetails: loggedInUserDetails,
  //         status: FormStatus.initial,
  //         model: state.model,
  //         employee: onlyDBUsers,
  //         dbSponsor: onlyDBUsers,
  //         host: onlyDBUsers,
  //         departments: departments.employeeDepartments,
  //         labels: labels,
  //         listOfEntities: entities.atomEntities,
  //         passNo: passNo.activePassInfoList,
  //         companyType: companyType,
  //         passType: getPassType,
  //         getStatus:getStatus,
  //       ),
  //     );
  //   } catch (e) {
  //     log('Initialization issue',
  //         error: e, name: 'Sez Pass Management Details Cubit');
  //     emit(
  //       state.copyWith(
  //         message: Constants.errorText,
  //         // TODO: error message should be dynamic
  //         status: FormStatus.error,
  //       ),
  //     );
  //   }
  // }

  Future<void> initializeValues() async {

    //Show Loader and emit loading state
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    var userId = await SharedPrefs.getUserId();

    // if (state.model.location == null) {
    //   Organisation? defaultLocation = await SharedPrefs.getDefaultLocation();
    //   if (defaultLocation != null) {
    //     SerialNumberModel slNo = await commonServices.getSlNo(
    //       locationId: defaultLocation.id.toString(),
    //       moduleCode: Constants.slaViolationPenaltyDetailsModuleCode,
    //     );
    //     state.model.location = defaultLocation;
    //     state.model.slNo = slNo.serialNo;
    //   }
    // }

    try {
      Locations locations =
     await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS', isSezLocations: true);

      AddEntities entities =
      await commonServices.getEntities(name: 'ATOM_ENTITIES');

      EmployeeDepartments departments = await commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS');


      List<Organisation> companyType = await commonServices.getOrganisations(name: 'ATOM_COMPANY_TYPES');



      // List<Organisation> getPassType = await commonServices.getPassType(passType: 0, locationId: state.model.location!.id!,);


      List<Organisation> getStatus  = await commonServices.getStatusesByModuleId(
                  module: Constants.passManagementModuleCode, filter: state.model.status == 0 ? 0 : 1);

      User loggedInUserDetails =
      await commonServices.getUserDetails(userId: userId);

      // List<BaseUser> onlyDBUsers = await commonServices.getBaseUsers(
      //         roleName: ConstantUserRoles.atomStaticUser,
      //         locationId: state.model.location!.id!,
      //         isDbUser: true,
      //       );

      if (location != null) {
        state.model.location = location;
      }
      if (locationRegion != null) {
        state.model.locationRegion = locationRegion;
      }

      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.inputDate ?? '0'),
          Constants.fulldateFormat);
      // Get Date of Creation
      // state.model.inputDate = state.model.inputDate == null
      //     ? Utils().getCurrentDate()
      //     : Utils().formatUnixTimestamp(state.model.inputDate ?? '');
      // state.model.inputDate =
      //     (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(),
          moduleCode: Constants.passManagementModuleCode);
      MmUiLabels labels = MmUiLabels.fromJson(responseLabels);

      if (location != null) {
        SerialNumberModel slNo = await commonServices.getSlNo(
          locationId: location!.id.toString(),
          moduleCode: Constants.sezPassManagementModule,
        );
        state.model.location = location;
        state.model.slNo = slNo.serialNo;
      }

      state.model.entrySecurity ??= loggedInUserDetails;
      emit(
        state.copyWith(
          locations: locations,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          model: state.model,
          // employee: onlyDBUsers,
          // dbSponsor: onlyDBUsers,
          // host: onlyDBUsers,
          departments: departments.employeeDepartments,
          labels: labels,
          listOfEntities: entities.atomEntities,
          // passNo: passNo.activePassInfoList,
          companyType: companyType,
          // passType: getPassType,
          getStatus:getStatus,
        ),
      );
    } catch (e) {
      log('initialization issue',
          error: e, name: 'SLA Violation Penalty Details Cubit');
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
    List<Organisation> getPassType = [];


    // Get Sl No from API
    if (location != null) {
      SerialNumberModel slNo = await commonServices.getSlNo(
        locationId: location.id.toString(),
        moduleCode: Constants.sezPassManagementModule,
      );
      state.model.location = location;
      state.model.slNo = slNo.serialNo;

      emailUsers = await commonServices.getBaseUsers(
          roleName: ConstantUserRoles.atomStaticUser,
          isDbUser: true,
          locationId: state.model.location!.id!);

      getPassType = await commonServices.getPassType(
          passType: 3,
          locationId: state.model.location!.id!);

    }
    // state.model. = null;
    // state.model.host = null;
    // state.model.passTypeName = null;

    emit(state.copyWith(
      model: state.model,
      employee: emailUsers,
      host: emailUsers,
      dbSponsor: emailUsers,
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
    int? status,
    int? passCategory,

  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    state.model.status = status ?? state.model.status;

    state.model.category = passCategory ?? state.model.category;
    if (entities != null) {
      state.model.entities = entities;
    }

    if (companyType != null) {
      state.model.companyType = companyType;
      state.model.employee?.employeeId = null;
      state.model.employee?.name = null;
      state.model.host?.employeeId = null;
      state.model.host?.name = null;
    }

    if ( employee!= null) {
      state.model.employeeId = employee.employeeId;
      state.model.employeeName = employee.name;
      state.model.email = employee.email;
      String name = employee.name ?? '';
      String email = employee.email ?? '';
      User userDetails = User(
          name:name,
          userId: employee.id,
          email: email,
          employeeId: employee.employeeId
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

    if (updatedStatus != null) {
      state.model.updatedStatus = updatedStatus.id;
    }

    // if (isReturnable != null) {
    SerialNumberModel slNo = await commonServices.getSlNo(
        locationId: state.model.location!.id.toString(),
        moduleCode: Constants.passManagementModuleCode);
    state.model.slNo = slNo.serialNo;
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
        image.type = 0;
      }
      log('--data----${data.length}----');

      state.model.evidenceDocuments = data;
      emit(
        state.copyWith(
          model: state.model,
          loadAttachments: data,
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
    // Create/Update API Call
    SezPassManagementRequest request =
    SezPassManagementRequest(passManagement: state.model);
    // TODO: Need to change from Backend- Status should be handled from backend
    state.model.status ??= 0;
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
        response = await sezPassManagementServices.createSezPass(
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
        response = await sezPassManagementServices.createSezPass(
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
