import 'dart:developer';
import 'dart:math' as math;

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/passmanagement/models/vendor_pass_reason_model.dart';
import 'package:db_atom/src/features/passmanagement/vendor_pass_management/models/requestModels/vendor_pass_management_request.dart';
import 'package:db_atom/src/features/passmanagement/vendor_pass_management/models/vendor_pass_management_model.dart';
import 'package:db_atom/src/features/passmanagement/vendor_pass_management/services/vendor_pass_management_service.dart';
import 'package:intl/intl.dart';

part 'vendor_pass_management_details_state.dart';

class VendorPassManagementDetailsCubit extends Cubit<VendorPassManagementDetailsState> {
  final VendorPassManagementServices vendorPassManagementServices;
  final VendorPassManagementModel? model;
  final CommonServices commonServices;

  VendorPassManagementDetailsCubit({
    required this.vendorPassManagementServices,
    required this.commonServices,
    this.model,

  }) : super(
    VendorPassManagementDetailsState.initial(
      model: model ?? VendorPassManagementModel(),
      locations: Locations(),
      users: const [],
      emailUsers: const [],
      errorMessage: '',
      departments: const [],
      loadAttachments: const [], listOfEntities: const [], getCompanyTypeResponse: const [], vendorPassReason:const [], passNo: const [], passType: const [], getStatus: const [],
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

  void onModelValueChange(VendorPassManagementModel model) {
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onCheckBoxChange(VendorPassManagementModel model) {
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
      String moduleCode = Constants.vendorPassManagementModule;
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
        commonServices.getVendorPassReason(name: 'VENDOR_PASS_REASON'),
        commonServices.getPassNo(passType: 2, locationId: state.model.location!.id!,),
        commonServices.getOrganisations(name: 'ATOM_COMPANY_TYPES'),
        commonServices.getPassType(passType: 2, locationId: state.model.location!.id!,),
        commonServices.getStatusesByModuleId(
            module: Constants.vendorPassManagementModule, filter: state.model.status == 0 ? 0 : 1),
      ]);
      Locations locations = futures[0];
      User loggedInUserDetails = futures[1];
      EmployeeDepartments departments = futures[2];
      dynamic responseLabels = futures[3];
      Organisation? defaultLocation = futures[4];
      List<BaseUser> emailUsers = futures[5];
      AddEntities entities = futures[6];
      VendorPassReason vendorPassReason = futures[7];
      DayPassNumberLists passNo = futures[8];
      List<Organisation> companyType = futures[9];
      List<Organisation> getPassType = futures[10];
      List<Organisation> getStatus = futures[11];


      log('--emailUsers--${emailUsers.length}---');
      // Get Date of Creation
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.inputDate ?? '0'),
          Constants.fulldateFormat);

      state.model.startTime = state.model.startTime == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.startTime ?? '0'),
          Constants.fulldateFormat);

      state.model.passType ??= 2;
      state.model.passInfo?.passType ??= 2;

      if(state.model.status == 1) {
        state.model.handOverSecurity ??= loggedInUserDetails;
        state.model.returnedTime = state.model.returnedTime == null
            ? Utils().getCurrentDate()
            : Utils.timestampToDateConversion(
            int.tryParse(state.model.returnedTime ?? '0'),
            Constants.fulldateFormat);
      }
      // state.model.endTime = state.model.endTime == null
      //     ? Utils.timestampToDateConversion(
      //     DateTime.now().add(const Duration(hours: 24)).millisecondsSinceEpoch,
      //     Constants.fulldateFormat)
      //     : Utils.timestampToDateConversion(
      //     int.tryParse(state.model.endTime ?? '0'),
      //     Constants.fulldateFormat);
      MmUiLabels labels = MmUiLabels.fromJson(responseLabels);

      log('--loggedInUserDetails---${loggedInUserDetails.firstName}----');

      state.model.entrySecurity ??= loggedInUserDetails;
      // state.model.rejectedBy ??= loggedInUserDetails;
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
          vendorPassReason :vendorPassReason.vendorPassReason,
          passNo: passNo.activePassInfoList,
          companyType: companyType,
          passType: getPassType,
          getStatus:getStatus,
        ),
      );
    } catch (e) {
      log('Initialization issue',
          error: e, name: 'Vendor Pass Management Details Cubit');
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
        moduleCode: Constants.vendorPassManagementModule,
      );
      state.model.location = location;
      state.model.slNo = slNo.serialNo;

      emailUsers = await commonServices.getBaseUsers(
          roleName: ConstantUserRoles.atomStaticUser,
          isDbUser: true,
          locationId: state.model.location!.id!);
      passNo = await commonServices.getPassNo(
          passType: 2,
          locationId: state.model.location!.id!);

      getPassType = await commonServices.getPassType(
          passType: 2,
          locationId: state.model.location!.id!);

    }

    if (getPassType.isNotEmpty) {
      Organisation defaultPassType = getPassType.first;
      state.model.passTypeName = defaultPassType.name;
    }
    // state.model. = null;
    // state.model.host = null;
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
    Organisation? vendorPassReason,
    int? status,
    int? validateType,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    state.model.status = status ?? state.model.status;

    // state.model.idValidationType = validateType??state.model.idValidationType;
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

    if (vendorPassReason != null) {
      state.model.vendorPassReason = vendorPassReason;
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
          loadAttachments: data,
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

    state.model.passType ??= 2;
    state.model.passInfo?.passType ??= 2;

    state.model.startTime = state.model.startTime != null
        ? ((int.tryParse(state.model.startTime ?? '') ?? DateTime.now().millisecondsSinceEpoch)).toString()
        : (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

    state.model.endTime = state.model.endTime != null
        ? ((int.tryParse(state.model.endTime ?? '') ?? DateTime.now().add(const Duration(hours: 12)).millisecondsSinceEpoch)).toString()
        : (DateTime.now().add(const Duration(hours: 12)).millisecondsSinceEpoch ~/ 1000).toString();

    // Create/Update API Call
    VendorPassManagementRequest request =
    VendorPassManagementRequest(passManagement: state.model);
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
        response = await vendorPassManagementServices.createVendorPass(
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
        response = await vendorPassManagementServices.createVendorPass(
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
