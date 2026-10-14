import 'dart:developer';
import 'dart:math' as math;

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/passmanagement/day_pass_mangement/services/day_passmanagement_service.dart';
import 'package:db_atom/src/features/passmanagement/models/day_pass_reason_model.dart';
import 'package:db_atom/src/features/passmanagement/models/pm_ui_labels.dart';
import 'package:intl/intl.dart';

import '../../../../../models/location_Type_Model.dart';
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
        getLocationType: GetLocationType(),

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
    final Locations locations =
    await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');
    final int? locationId =state.model.location?.id;

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
        commonServices.getPassNo(passType: 0, locationId: state.model.location!.id!, isDwsPass: state.model.passTypeName == 'DWS Temporary Card' ? true : false),
        commonServices.getOrganisations(name: 'ATOM_COMPANY_TYPES'),
        commonServices.getPassType(passType: 0, locationId: state.model.location!.id!,),
        commonServices.getStatusesByModuleId(
          module: Constants.dayPassManagementModule, filter: state.model.status == 0 ? 0 : 1),
        commonServices.getLocationType(locId: locationId!),

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
      GetLocationType? getLocationType = futures[12];


      state.model.passType ??= 0;
      state.model.passInfo?.passType ??= 0;

      if (getPassType.isNotEmpty && state.model.passTypeName == null) {
        Organisation defaultPassType = getPassType.first;
        state.model.passTypeName = defaultPassType.name;
      }
      // Get Date of Creation
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.inputDate ?? '0'),
          Constants.fulldateFormat);

      PMUiLabels labels = PMUiLabels.fromJson(responseLabels);


      state.model.entrySecurity ??= loggedInUserDetails;
      if(state.model.updatedStatus == 2  || state.model.updatedStatus == 8  || state.model.updatedStatus == 9 ){
        state.model.handoverSecurity ??= loggedInUserDetails;
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
          dayPassReason :dayPassReason.dayPassReasonElement,
          passNo: passNo.activePassInfoList,
          companyType: companyType,
          passType: getPassType,
          getStatus:getStatus,
            getLocationType: getLocationType),

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
    GetLocationType? locType = state.getLocationType;


    // Get Sl No from API
    if (location != null) {
      SerialNumberModel slNo = await commonServices.getSlNo(
        locationId: location.id.toString(),
        moduleCode: Constants.dayPassManagementModule,
      );
      final int? locationId = location.id;


      state.model.location = location;
      state.model.slNo = slNo.serialNo;
      state.model.host?.employeeId = null;
      state.model.host?.firstName = null;
      state.model.host?.lastName = null;
      state.model.host = null;
      state.model.hostEmployeeId = null;
      state.model.hostName = null;

      state.model.employeeName = null;
      state.model.employee?.employeeId = null;
      state.model.employee?.firstName = null;
      state.model.employee?.lastName = null;
      state.model.employee = null;
      state.model.employeeId = null;
      state.model.entities = null;
      emailUsers = await commonServices.getBaseUsers(
          roleName: ConstantUserRoles.atomStaticUser,
          isDbUser: true,
          locationId: state.model.location!.id!);
      passNo = await commonServices.getPassNo(
          passType: 0,
          locationId: state.model.location!.id!, isDwsPass:  state.model.passTypeName == 'DWS Temporary Card' ? true : false);

      getPassType = await commonServices.getPassType(
          passType: 0,
          locationId: state.model.location!.id!);
      locType = await commonServices.getLocationType(locId: locationId!);


    }
    if (getPassType.isNotEmpty) {
      Organisation defaultPassType = getPassType.first;
      state.model.passTypeName = defaultPassType.name;
    }
    state.model.passNo = null;

    emit(state.copyWith(
      model: state.model,
      employee: emailUsers,
      host: emailUsers,
      dbSponsor: emailUsers,
      passNo: passNo.activePassInfoList,
      passType: getPassType,
      status: FormStatus.initial,
      getLocationType: locType,

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
    Organisation? locationType,

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
    if (locationType != null) {
      state.model.locationType = locationType;
    }

    if (companyType != null) {
      state.model.companyType = companyType;
      state.model.companyName =null;
      state.model.employeeId = null;
      state.model.host?.employeeId = null;
      state.model.host?.firstName = null;
      state.model.host?.lastName = null;
      state.model.host = null;
      state.model.hostEmployeeId = null;
      state.model.employee?.employeeId = null;
      state.model.employee?.firstName = null;
      state.model.employee?.lastName = null;
      state.model.employeeName = null;
      state.model.employee = null;
      state.model.employeeId = null;
      state.model.companyName = state.model.companyType?.name == 'FTE' ?'GIG Gulf': state.model.companyName;
    }

    if ( employee!= null) {
      state.model.employeeId = employee.employeeId;
      state.model.employeeName = employee.name;
      state.model.email = employee.email;
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

    DayPassNumberLists passTypeNo = DayPassNumberLists(activePassInfoList: []); // Initialize with default value
    if (passType != null) {
      state.model.passType = passType.id;
      state.model.passTypeName = passType.name;
      passTypeNo = await commonServices.getPassNo(
          passType: 0,
          locationId: state.model.location!.id!,
          isDwsPass: state.model.passTypeName == 'DWS Temporary Card' ? true : false);
      emit(
        state.copyWith(
          passNo: passTypeNo.activePassInfoList,
          model: state.model,
          status: FormStatus.initial,
        ),
      );
    }

    if (updatedStatus != null) {
      state.model.updatedStatus = updatedStatus.id;
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
    math.Random.secure().nextInt(5);
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

  }


  void submitForm({bool isSaveOnly = false}) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    state.model.status ??= 0;
    state.model.passInfo?.passType ??= 0;

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
          state.model.inputDate = state.model.inputDate == null
              ? Utils().getCurrentDate()
              : Utils.timestampToDateConversion(
              int.tryParse(state.model.inputDate ?? '0'),
              Constants.fulldateFormat);
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
          state.model.inputDate = state.model.inputDate == null
              ? Utils().getCurrentDate()
              : Utils.timestampToDateConversion(
              int.tryParse(state.model.inputDate ?? '0'),
              Constants.fulldateFormat);
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
