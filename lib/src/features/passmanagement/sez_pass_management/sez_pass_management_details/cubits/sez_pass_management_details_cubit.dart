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
      loadAttachments: const [], listOfEntities: const [], getCompanyTypeResponse: const [], dayPassReason:const [], passNo: const [], passType: const [], getStatus: const [],passValidUntil:'',
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

  void onModelValueChange(SezPassManagementModel model) {
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onCheckBoxChange(SezPassManagementModel model) {
    emit(state.copyWith(model: model, status: FormStatus.loading));

    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  Future<void> initializeValues() async {

    //Show Loader and emit loading state
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    var userId = await SharedPrefs.getUserId();

    try {
      Locations locations =
     await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS', isSezLocations: true);

      AddEntities entities =
      await commonServices.getEntities(name: 'ATOM_ENTITIES');

      EmployeeDepartments departments = await commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS');


      List<Organisation> companyType = await commonServices.getOrganisations(name: 'ATOM_SEZ_COMPANY_TYPES', filter: state.model.category == 1 ? 2 : 1);


      List<Organisation> getStatus  = await commonServices.getStatusesByModuleId(
                  module: Constants.passManagementModuleCode, filter: state.model.status == 0 ? 0 : 1);

      User loggedInUserDetails =
      await commonServices.getUserDetails(userId: userId);


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
      state.model.startTime = state.model.startTime == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.startTime ?? '0'),
          Constants.fulldateFormat);

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

      if(state.model.updatedStatus == 2  || state.model.updatedStatus == 8  || state.model.updatedStatus == 9 ){
        state.model.handoverSecurity ??= loggedInUserDetails;
      }

      // state.model.passType ??= 3;
      state.model.passInfo?.passType ??= 3;

      emit(
        state.copyWith(
          locations: locations,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          model: state.model,
          departments: departments.employeeDepartments,
          labels: labels,
          listOfEntities: entities.atomEntities,
          companyType: companyType,
          getStatus:getStatus,
        ),
      );
    } catch (e) {
      log('initialization issue',
          error: e, name: 'Sez Pass Management Details Cubit');
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
    if (getPassType.isNotEmpty) {
      Organisation defaultPassType = getPassType.first;
      state.model.passTypeName = defaultPassType.name;
    }

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
    int? status,
    int? passCategory,
    Organisation? selectedCompanyType,

  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    state.model.status = status ?? state.model.status;

    state.model.category = passCategory ?? state.model.category;


    state.model.companyName = state.model.companyType?.name == 'FTE' ?'Deutsche Bank': state.model.companyName;

    List<Organisation> companyTypeList = [];
    String passValidUntilDate = '';
// Fetch organisations and set the list
      if (passCategory != null && state.model.category == 2) {
        state.model.companyType = null;
        state.model.employee?.employeeId = null;
        state.model.employee?.name = null;
        state.model.employeeName = null;
        state.model.companyName = null;
        state.model.employee= null;
        state.model.employeeId = null;

        companyTypeList = await commonServices.getOrganisations(
          name: 'ATOM_SEZ_COMPANY_TYPES',
          filter: 2,
        );
        // state.model.companyType = companyTypeList.first;
        state.model.companyName = state.model.companyType?.name == 'FTE' ?'Deutsche Bank': state.model.companyName;

         passValidUntilDate = await commonServices.getPassValidUntil(passCategory: 2);
        state.model.endTime =passValidUntilDate ;
         log('passValidUntilDate ${passValidUntilDate}');
        emit(
          state.copyWith(
            model: state.model,
            companyType: companyTypeList,
            passValidUntil :passValidUntilDate,
            status: FormStatus.initial,
          ),
        );

      }
    if (passCategory != null && state.model.category == 1) {
      state.model.companyType = null;
      state.model.employee?.employeeId = null;
      state.model.employee?.name = null;
      state.model.employee= null;
      state.model.employeeName = null;
      state.model.companyName = null;
      state.model.employeeId = null;

      companyTypeList = await commonServices.getOrganisations(
        name: 'ATOM_SEZ_COMPANY_TYPES',
        filter: 1,
      );
      // state.model.companyType = companyTypeList.first;
      passValidUntilDate = await commonServices.getPassValidUntil(passCategory: 1);

      state.model.endTime =passValidUntilDate ;

      emit(
        state.copyWith(
          model: state.model,
          companyType: companyTypeList,
          passValidUntil:passValidUntilDate,
          status: FormStatus.initial,
        ),
      );
    }

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
      state.model.employee?.name = employee.name;
      // state.model.employee?.firstName = employee.name;
      List<String> nameParts = employee.name!.split(' '); // Split by space
      String? firstName = nameParts.isNotEmpty ? nameParts.first : null;
      String? lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : null;
      // state.model.email = employee.email;
      String name = employee.name ?? '';
      String email = employee.email ?? '';
      User userDetails = User(
          name:name,
          userId: employee.id,
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

      state.model.passInfo?.passNo =state.model.passNo;

      PassInfo userDetails = PassInfo(
          passNo:state.model.passNo,
          mifareNo :state.model.mifareNo,
          id: null,
          passType: 1
      );
      state.model.passInfo = userDetails;
      emit(
        state.copyWith(
          model: state.model,
          status: FormStatus.initial,
        ),
      );

    if (department != null) {
      state.model.department = department;
    }

    if (passType != null) {
      state.model.passTypeName = passType.name;
      state.model.passType = passType.id;
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

    state.model.passInfo?.passType ??= 3;

    DateTime dateTime;
    if (!Utils().isTimestamp(state.model.inputDate!)) {
      dateTime =
          DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.inputDate!);
      int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
      state.model.inputDate = inputDate.toString();
    }

    if (!Utils().isTimestamp(state.model.startTime!)) {
      dateTime =
          DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.startTime!);
      int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
      state.model.startTime = inputDate.toString();
    }
    if(state.model.status == 1 && (state.model.updatedStatus == 2||state.model.updatedStatus == 8 || state.model.updatedStatus == 9)){
      state.model.returnedTime = state.model.returnedTime != null
          ? ((int.tryParse(state.model.returnedTime ?? '') ?? DateTime.now().millisecondsSinceEpoch)).toString()
          : (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
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
