import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_issuance/models/km_ui_labels.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_issuance/services/key_management_issuance_services.dart';
import 'package:db_atom/src/services/common_services.dart';

part 'key_management_issuance_details_state.dart';

class KeyManagementIssuanceDetailsCubit
    extends Cubit<KeyManagementIssuanceDetailsState> {
  final KeyManagementIssuanceServices services;
  final KeyManagementIssuanceModel? model;
  final CommonServices commonServices;

  KeyManagementIssuanceDetailsCubit({
    required this.services,
    required this.commonServices,
    this.model,
  }) : super(
          KeyManagementIssuanceDetailsState.initial(
            model: model ?? KeyManagementIssuanceModel(),
            locations: Locations(),
            loggedInUserDetails: User(),
            users: const [],
            emailUsers: const [],
            listOfEntities: const [],
            departments: const [],
            typeOfServices: const [],
            errorMessage: '',
          ),
        );

  Future<void> refreshList() async {
    emit(state.copyWith(status: FormStatus.loading));
    Analyst users = await commonServices.getUsersByRole(roleName: 'T1_Analyst');
    List<BaseUser> emailUsers =
        await commonServices.getBaseUsersByRoles(roleNames: 'ATOM_STATIC_USER');
    EmployeeDepartments departments =
        await commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS');

    emit(
      state.copyWith(
        status: FormStatus.initial,
        users: users.t1Analyst,
        emailUsers: emailUsers,
        departments: departments.employeeDepartments,
      ),
    );
  }

  void onModelValueChange(KeyManagementIssuanceModel model) {
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onCheckBoxChange(KeyManagementIssuanceModel model) {
    emit(state.copyWith(model: model, status: FormStatus.loading));

    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  Future<void> initializeValues() async {
    log('-status-1-${state.status}--');
    //Show Loader and emit loading state
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    var userId = await SharedPrefs.getUserId();
    try {
      // Use Future.wait to call API functions concurrently
      final futures = await Future.wait([
        commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS'),
        commonServices.getUserDetails(userId: userId),
        commonServices.getUsersByRole(roleName: 'T1_Analyst'),
        commonServices.getEntities(name: 'ATOM_ENTITIES'),
        commonServices.getUsers(),
        commonServices.getBaseUsersByRoles(roleNames: 'ATOM_STATIC_USER'),
        commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS'),
        commonServices.getUiLabels(
            language: await SharedPrefs.getLanguageCode(),
            moduleCode: Constants.keyManagementIssuanceModule),
        SharedPrefs.getDefaultLocation(),
      ]);

      Locations getLocationsData = futures[0];
      User loggedInUserDetails = futures[1];
      Analyst users = futures[2];
      AddEntities entities = futures[3];
      List<User> entrySecurities = futures[4];
      List<BaseUser> emailUsers = futures[5];
      EmployeeDepartments departments = futures[6];
      dynamic responseLabels = futures[7];
      Organisation? defaultLocation = futures[8];
      if (state.model.location == null && defaultLocation != null) {
        SerialNumberModel slNo = await commonServices.getSlNo(
          locationId: defaultLocation.id.toString(),
          moduleCode: Constants.keyManagementIssuanceModule,
        );
        state.model.location = defaultLocation;
        state.model.slNo = slNo.serialNo;
      }
      state.model.createdBy ??= loggedInUserDetails;
      // Get Date of Creation
      // state.model.createdDate = Utils().getCurrentDate();
      state.model.createdDate = state.model.createdDate == null
          ? Utils().getCurrentDate()
          : Utils().formatUnixTimestamp(state.model.createdDate ?? '');
      state.model.keyHandOverDate = state.model.keyHandOverDate == null
          ? Utils().getCurrentDate()
          : Utils().formatUnixTimestamp(state.model.keyHandOverDate ?? '');

      // state.model.keyHandOverDate = Utils().getCurrentDate();
      // GmUiLabels labels = GmUiLabels.fromJson(responseLabels);

      emit(
        state.copyWith(
          locations: getLocationsData,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          model: state.model,
          users: users.t1Analyst,
          departments: departments.employeeDepartments,
          listOfEntities: entities.atomEntities,
          emailUsers: emailUsers,
          //labels: labels,
        ),
      );
    } catch (e) {
      log('Initialization issue',
          error: e, name: 'Key Management Issuance Details Cubit');
      emit(
        state.copyWith(
          message: Constants.errorText,
          status: FormStatus.error,
        ),
      );
    }
  }

  Future<void> updateDropdownValues({
    List<Organisation>? entities,
    Organisation? department,
    List<Organisation>? typeOfServices,
    Organisation? location,
    BaseUser? user,
    BaseUser? approver,
    BaseUser? handedOverTo,
    BaseUser? dbSponsorCwrT2,
    int? employeeType,
    int? keyHandingOverDuration,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    // Get Sl No from API
    if (location != null) {
      SerialNumberModel slNo = await commonServices.getSlNo(
        locationId: location.id.toString(),
        moduleCode: Constants.keyManagementIssuanceModule,
      );

      state.model.location = location;
      state.model.slNo = slNo.serialNo;
    }

    state.model.employeeType = employeeType ?? state.model.employeeType;
    state.model.keyHandingOverDuration =
        keyHandingOverDuration ?? state.model.keyHandingOverDuration;

    if (location != null) {
      SerialNumberModel slNo = await commonServices.getSlNo(
          locationId: location.id.toString(),
          moduleCode: Constants.keyManagementIssuanceModule);
      state.model.location = location;
      state.model.slNo = slNo.serialNo;
    }
    log('--entities--${entities?.length}-');
    if (!entities.isEmptyOrNull) {
      state.model.entities = entities;
    }
    if (department != null) {
      state.model.department = department;
    }

    if (user != null) {
      User userDetails = User(
        name: user.name,
        userId: user.id,
        userName: user.name,
      );
      state.model.createdBy = userDetails;
    }

    if (handedOverTo != null) {
      User userDetails = User(
        name: handedOverTo.name,
        userId: handedOverTo.id,
        userName: handedOverTo.name,
      );
      state.model.handedOverTo = userDetails;
    }
    if (dbSponsorCwrT2 != null) {
      User userDetails = User(
        name: dbSponsorCwrT2.name,
        userId: dbSponsorCwrT2.id,
        userName: dbSponsorCwrT2.name,
      );
      state.model.dbSponsorCwrT2 = userDetails;
    }
    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
    ));
  }

  Future<bool> submitForm({
    bool isSaveOnly = false,
    bool navigateToNextScreen = false,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    log('--state.model.entities?.length---${state.model.entities?.length}----');
    // Setting time in milliseconds
    state.model.createdDate =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
    state.model.keyHandOverDate =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
    state.model.keyReturnDateTime =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
    state.model.keyHandOverDue =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
    // Create/Update API Call
    KeyManagementIssuanceRequest request =
        KeyManagementIssuanceRequest(keyIssuanceGi: state.model);

    // TODO: Need to change from Backend- Status should be handled from backend
    state.model.status ??= 0;
    GenericResponse response = GenericResponse();
    try {
      if (isSaveOnly) {
        //Validating Fields
        if (!state.isValidDraft.status) {
          state.model.createdDate = state.model.createdDate == null
              ? Utils().getCurrentDate()
              : Utils().formatUnixTimestamp(state.model.createdDate ?? '');

          emit(
            state.copyWith(
              status: FormStatus.error,
              message: state.isValidDraft.message,
            ),
          );
          return false;
        }
        response = await services.createKeyManagementIssuanceGi(
            body: request, isSubmit: false);
      } else {
        //Validating Fields
        if (!state.isValid.status) {
          state.model.createdDate = state.model.createdDate == null
              ? Utils().getCurrentDate()
              : Utils().formatUnixTimestamp(state.model.createdDate ?? '');

          emit(
            state.copyWith(
              status: FormStatus.error,
              message: state.isValid.message,
            ),
          );
          return false;
        }
        response = await services.createKeyManagementIssuanceGi(
            body: request, isSubmit: true);
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
          status: navigateToNextScreen
              ? FormStatus.navigateToNextScreen
              : FormStatus.success,
        ),
      );
      state.model.createdDate = state.model.createdDate == null
          ? Utils().getCurrentDate()
          : Utils().formatUnixTimestamp(state.model.createdDate ?? '');
      state.model.keyHandOverDate = state.model.keyHandOverDate == null
          ? Utils().getCurrentDate()
          : Utils().formatUnixTimestamp(state.model.keyHandOverDate ?? '');
    } on GenericResponse catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.error,
        ),
      );
      return false;
    } on Exception catch (e) {
      emit(
        state.copyWith(
          message: e.toString(),
          status: FormStatus.error,
        ),
      );
      return false;
    }
    log('--response.id----${response.id}--');

    state.model.id = int.tryParse(response.id ?? '');
    emit(
      state.copyWith(
        message: response.message,
        status: navigateToNextScreen
            ? FormStatus.navigateToNextScreen
            : FormStatus.success,
      ),
    );
    return true;
  }

  void updateStatus({required String id}) {
    commonServices.updateRecordStatus(
        id: id, module: Constants.keyManagementIssuanceModule);
  }
}
