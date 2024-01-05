import 'dart:developer';

import 'package:db_atom/src/features/createfound/models/get_depositor_model.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_master_data/models/gm_ui_labels.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/models/keyType_model.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/models/requestModels/key_management_master_request.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/services/key_management_master_services.dart';
import 'package:db_atom/src/features/lawenforcement/models/addentities.dart';
import 'package:db_atom/src/services/CommonServices.dart';
import 'package:intl/intl.dart';

import '../../../../../../../index.dart';
import '../../../../../createfound/models/emplyee_departments_model.dart';
import '../../../../../passmanagement/daypassmgmt/createpassmgmt/models/analyst_model.dart';

part 'key_history_records_details_state.dart';

class KeyHistoryRecordsDetailsCubit
    extends Cubit<KeyHistoryRecordsDetailsState> {
  final KeyManagementMasterServices services;
  final KeyManagementMasterModel? model;
  final CommonServices commonServices;

  KeyHistoryRecordsDetailsCubit({
    required this.services,
    required this.commonServices,
    required this.model,
  }) : super(
          KeyHistoryRecordsDetailsState.initial(
            model: model ?? KeyManagementMasterModel(),
            locations: Locations(),
            loggedInUserDetails: User(),
            users: const [],
            emailUsers: const [],
            errorMessage: '',
            listOfEntities: const [],
            getEntitiesResponse: null,
            departments: const [],
          ),
        );

  void onModelValueChange(KeyManagementMasterModel model) {
    log('-onModelValueChange---');
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onCheckBoxChange(KeyManagementMasterModel model) {
    emit(state.copyWith(model: model, status: FormStatus.loading));

    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onAddParticipationDate(String participationDate) {
    emit(state.copyWith(model: model, status: FormStatus.loading));
    List<String>? dates = state.participationDates ?? [];
    dates.add(participationDate);

    state.copyWith(
      participationDates: dates,
    );
  }

  String _getCurrentDate() {
    return DateFormat(Constants.fulldateFormat).format(DateTime.now());
  }

  Future<void> initializeValues() async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    var userId = await SharedPrefs.getUserId();
    try {
      // Use Future.wait to call API functions concurrently
      final futures = await Future.wait([
        commonServices.getLocations(name: 'ATOM_LOCATIONS'),
        commonServices.getUserDetails(userId: userId),
        commonServices.getUsersByRole(roleName: 'T1_Analyst'),
        commonServices.getEntities(name: 'ATOM_ENTITIES'),
        commonServices.getUsers(),
        commonServices.getQualification(name: 'GUARD_QUALIFICATIONS'),
        commonServices.getAtomStaticUsers(roleName: 'ATOM_STATIC_USER'),
        commonServices.getDepartments(
            name: 'KEY_MANAGEMENT_DESTRUCTION_REASON'),
        commonServices.getVendors(name: 'ATOM_VENDORS'),
        commonServices.getUiLabels(
            language: await SharedPrefs.getLanguageCode(),
            moduleCode: Constants.keyManagementMasterModule),
        SharedPrefs.getDefaultLocation(),
      ]);

      Locations getLocationsData = futures[0];
      User loggedInUserDetails = futures[1];
      Analyst users = futures[2];
      AddEntities entities = futures[3];
      List<User> createdBy = futures[4];
      GetDepositor emailUsers = futures[6];
      EmployeeDepartments departments = futures[7];
      dynamic responseLabels = futures[9];
      Organisation? defaultLocation = futures[10];
      if (state.model.location == null && defaultLocation != null) {
        SerialNumberModel slNo = await commonServices.getSlNo(
          locationId: defaultLocation.id.toString(),
          moduleCode: Constants.keyManagementMasterModule,
        );
        state.model.location = defaultLocation;
        state.model.slNo = slNo.serialNo;
      }
      state.model.createdBy = loggedInUserDetails;

      // Get Date of Creation
      // state.model.createdDate =  DateTime.now().millisecondsSinceEpoch ~/ 1000;

      GmUiLabels labels = GmUiLabels.fromJson(responseLabels);

      emit(
        state.copyWith(
          locations: getLocationsData,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          model: state.model,
          users: users.t1Analyst,
          //createdBy: createdBy,
          emailUsers: emailUsers.atomStaticUser,
          listOfEntities: entities.atomEntities,
          getEntitiesResponse: entities,
          departments: departments.employeeDepartments,
          labels: labels,
        ),
      );
    } catch (e) {
      log('Initialization issue',
          error: e, name: 'Key Management Master Details Cubit');
      emit(
        state.copyWith(
          message: Constants.errorText,
          status: FormStatus.error,
        ),
      );
    }
  }

  Future<void> updateDropdownValues({
    Organisation? location,
    BaseUser? user,
    List<Organisation>? doorType,
    BaseUser? guard,
    List<Organisation>? entities,
    int? status,
    int? systemAccess,
    int? guardRank,
    int? dutyType,
    int? keyType,
    int? type,
    int? maritalStatus,
    int? typeOfDeployment,
    int? msgbFormBSubmitted,
    Organisation? destructionReason,
    User? srh,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    ////Get Sl No from API
    if (location != null) {
      SerialNumberModel slNo = await commonServices.getSlNo(
        locationId: location.id.toString(),
        moduleCode: Constants.keyManagementMasterModule,
      );
      if (user != null) {
        User userDetails = User(
          name: user.name,
          userId: user.id,
          userName: user.name,
        );
        state.model.srh = userDetails;
      }
      if (user != null) {
        User userDetails = User(
          name: user.name,
          userId: user.id,
          userName: user.name,
        );
        state.model.securityManager = userDetails;
      }
      state.model.location = location;
      state.model.slNo = slNo.serialNo;
    }
    if (destructionReason != null) {
      state.model.destructionReason = destructionReason;
    }
    state.model.destructionReason =
        destructionReason ?? state.model.destructionReason;
    state.model.keyType = keyType ?? state.model.keyType;
    state.model.type = type ?? state.model.type;
    state.model.status = status ?? state.model.status;
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

    if (state.model.status == 0 || state.model.status == null) {
      state.model.status = 1;
    }
    // Setting time in milliseconds
    // state.model.createdDate =
    //     (DateTime.now().millisecondsSinceEpoch ~/ 1000);

    // Create/Update API Call
    KeyManagementMasterRequest request =
        KeyManagementMasterRequest(keyMgmtGi: state.model);

    GenericResponse response = GenericResponse();
    try {
      if (isSaveOnly) {
        if (!state.isValidDraft.status) {
          emit(
            state.copyWith(
              status: FormStatus.error,
              message: state.isValidDraft.message,
            ),
          );
          return false;
        }
        response = (await services.createKeyManagementMaster(
            body: request, isSubmit: false));
      } else {
        //Validating Fields
        if (!state.isValid.status) {
          emit(
            state.copyWith(
              status: FormStatus.error,
              message: state.isValid.message,
            ),
          );
          return false;
        }
        response = (await services.createKeyManagementMaster(
            body: request, isSubmit: true));
      }
      return true;
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
  }
}
