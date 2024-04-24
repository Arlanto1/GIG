import 'dart:developer';

import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_issuance/models/km_ui_labels.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/models/requestModels/key_management_master_request.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/services/key_management_master_services.dart';
import 'package:db_atom/src/services/common_services.dart';
import 'package:intl/intl.dart';

import '../../../../../../../index.dart';

part 'key_management_master_details_state.dart';

class KeyManagementMasterDetailsCubit
    extends Cubit<KeyManagementMasterDetailsState> {
  final KeyManagementMasterServices services;
  final KeyManagementMasterModel? model;
  final CommonServices commonServices;

  KeyManagementMasterDetailsCubit({
    required this.services,
    required this.commonServices,
    required this.model,
  }) : super(
          KeyManagementMasterDetailsState.initial(
              model: model ?? KeyManagementMasterModel(),
              locations: Locations(),
              loggedInUserDetails: User(),
              users: const [],
              emailUsers: const [],
              errorMessage: '',
              listOfEntities: const [],
              getEntitiesResponse: null,
              departments: const [],
              getQualificationsResponse: null),
        );

  Future<void> refreshList() async {
    emit(state.copyWith(status: FormStatus.loading));
    List<Organisation>? entities =
        await commonServices.getOrganisations(name: 'ATOM_ENTITIES');

    Analyst users = await commonServices.getUsersByRole(roleName: 'T1_Analyst');
    List<Organisation>? departments =
        await commonServices.getOrganisations(name: 'KEY_MANAGEMENT_DOOR_TYPE');
    GetDepositor emailUsers =
        await commonServices.getAtomStaticUsers(roleName: 'ATOM_STATIC_USER');

    emit(
      state.copyWith(
        getEntitiesResponse: entities,
        listOfEntities: entities,
        status: FormStatus.initial,
        users: users.t1Analyst,
        emailUsers: emailUsers.atomStaticUser,
        departments: departments,
      ),
    );
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
        commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS'),
        commonServices.getUserDetails(userId: userId),
        commonServices.getUsersByRole(roleName: 'T1_Analyst'),
        commonServices.getOrganisations(name: 'ATOM_ENTITIES'),
        commonServices.getUsers(),
        commonServices.getQualification(name: 'GUARD_QUALIFICATIONS'),
        commonServices.getAtomStaticUsers(roleName: 'ATOM_STATIC_USER'),
        commonServices.getKeyType(name: 'KEY_MANAGEMENT_DOOR_TYPE'),
        commonServices.getVendors(name: 'ATOM_VENDORS'),
        commonServices.getUiLabels(
            language: await SharedPrefs.getLanguageCode(),
            moduleCode: Constants.keyManagementMasterModule),
        SharedPrefs.getDefaultLocation(),
      ]);

      Locations getLocationsData = futures[0];
      User loggedInUserDetails = futures[1];
      Analyst users = futures[2];
      List<Organisation>? entities = futures[3];
      List<User> createdBy = futures[4];
      GetDepositor emailUsers = futures[6];
      KeyType departments = futures[7];
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
      state.model.createdBy ??= loggedInUserDetails;
      state.model.modifiedBy ??= loggedInUserDetails;
      // state.model.createdDate = state.model.createdDate == null
      //     ? Utils().getCurrentDate()
      //     : Utils().formatUnixTimestamp(state.model.createdDate ?? '');
      state.model.createdDate = state.model.createdDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
              int.tryParse(state.model.createdDate ?? '0'),
              Constants.fulldateFormat);

      state.model.modifiedDate = state.model.modifiedDate == null
          ? Utils().getCurrentDate()
          : Utils().formatUnixTimestamp(state.model.modifiedDate ?? '');

      // Get Date of Creation
      // state.model.createdDate = Utils().getCurrentDate();
      // state.model.modifiedDate = Utils().getCurrentDate();
      KMUiLabels labels = KMUiLabels.fromJson(responseLabels);

      emit(
        state.copyWith(
          locations: getLocationsData,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          model: state.model,
          users: users.t1Analyst,
          //createdBy: createdBy,
          emailUsers: emailUsers.atomStaticUser,
          listOfEntities: entities,
          getEntitiesResponse: entities,
          departments: departments.items,
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

  void onModelValueChange(KeyManagementMasterModel model) {
    log('-onModelValueChange---');
    emit(state.copyWith(model: model, status: FormStatus.loading));
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onCheckBoxChange(KeyManagementMasterModel model) {
    emit(state.copyWith(model: model, status: FormStatus.loading));

    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  Future<void> updateDropdownValues({
    Organisation? location,
    BaseUser? user,
    Organisation? doorType,
    BaseUser? guard,
    List<Organisation>? entities,
    int? status,
    int? systemAccess,
    int? guardRank,
    int? dutyType,
    int? keyTagging,
    int? maritalStatus,
    int? typeOfDeployment,
    int? msgbFormBSubmitted,
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

      state.model.location = location;
      state.model.slNo = slNo.serialNo;
    }
    if (doorType != null) {
      state.model.doorType = doorType;
    }

    if (entities != null) {
      state.model.entities = entities;
    }
    state.model.keyTagging = keyTagging ?? state.model.keyTagging;
    state.model.status = status ?? state.model.status;
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

    state.model.status ??= 0;
    // Setting time in milliseconds
    // state.model.createdDate =
    //     (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

    DateTime dateTime;
    if (!Utils().isTimestamp(state.model.createdDate!)) {
      dateTime =
          DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.createdDate!);
      int inputDate = dateTime
          .toUtc()
          .millisecondsSinceEpoch ~/ 1000;
      state.model.createdDate = inputDate.toString();
    }

    // Create/Update API Call
    KeyManagementMasterRequest request =
        KeyManagementMasterRequest(keyMgmtGi: state.model);

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
          return false;
        }
        response = (await services.createKeyManagementMaster(
            body: request, isSubmit: false));
      } else {
        //Validating Fields
        if (!state.isValid.status) {
          emit(
            state.copyWith(
              status: FormStatus.formError,
              message: state.isValid.message,
            ),
          );
          return false;
        }
        response = (await services.createKeyManagementMaster(
            body: request, isSubmit: true));
      }
      state.model.createdDate = state.model.createdDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
              int.tryParse(state.model.createdDate ?? '0'),
              Constants.fulldateFormat);
    } on GenericResponse catch (e) {
      Utils().emitErrorState(e, emit, state);
      state.model.createdDate = state.model.createdDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.createdDate ?? '0'),
          Constants.fulldateFormat);
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
        id: id, module: Constants.keyManagementMasterModule);
  }
}
