import 'dart:developer';

import 'package:db_atom/src/features/guarding_operations/key_management_data/key_loss_destruction_list/models/key_loss_destruction_list_model.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_loss_destruction_list/models/requestModels/key_loss_destruction_request.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_loss_destruction_list/services/key_loss_destruction_list_services.dart';
import 'package:intl/intl.dart';

import '../../../../../../../index.dart';

part 'key_loss_destruction_details_state.dart';

class KeyLossDestructionDetailsCubit
    extends Cubit<KeyLossDestructionDetailsState> {
  final KeyLossDestructionListServices services;
  final KeyLossDestructionListModel? model;
  final CommonServices commonServices;

  KeyLossDestructionDetailsCubit({
    required this.services,
    required this.commonServices,
    required this.model,
  }) : super(
          KeyLossDestructionDetailsState.initial(
              model: model ?? KeyLossDestructionListModel(),
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
    EmployeeDepartments departments =
        await commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS');
    List<BaseUser> emailUsers =
        await commonServices.getBaseUsersByRoles(roleNames: 'ATOM_STATIC_USER');
    List<BaseUser> securityManager = await commonServices.getBaseUsersByRoles(
        roleNames: 'ATOM_Security_Manager');
    List<BaseUser> srh = await commonServices.getBaseUsersByRoles(
        roleNames: 'ATOM_Sub_Regional_Head');
    emit(
      state.copyWith(
        getEntitiesResponse: entities,
        listOfEntities: entities,
        status: FormStatus.initial,
        users: users.t1Analyst,
        securityManager: securityManager,
        srh: srh,
        emailUsers: emailUsers,
        departments: departments.employeeDepartments,
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
        commonServices.getBaseUsersByRoles(roleNames: 'ATOM_STATIC_USER'),
        commonServices.getKeyType(name: 'KEY_MANAGEMENT_DOOR_TYPE'),
        commonServices.getVendors(name: 'ATOM_VENDORS'),
        commonServices.getUiLabels(
            language: await SharedPrefs.getLanguageCode(),
            moduleCode: Constants.keyManagementMasterModule),
        SharedPrefs.getDefaultLocation(),
        commonServices.getBaseUsersByRoles(roleNames: 'ATOM_Security_Manager'),
        commonServices.getBaseUsersByRoles(roleNames: 'ATOM_Sub_Regional_Head'),
      ]);

      Locations getLocationsData = futures[0];
      User loggedInUserDetails = futures[1];
      Analyst users = futures[2];
      List<Organisation>? entities = futures[3];
      // List<User> createdBy = futures[4];
      List<BaseUser> emailUsers = futures[6];
      KeyType departments = futures[7];
      dynamic responseLabels = futures[9];
      // Organisation? defaultLocation = futures[10];
      List<BaseUser> securityManager = futures[11];
      List<BaseUser> srh = futures[12];

      state.model.createdBy ??= loggedInUserDetails;
      state.model.modifiedBy ??= loggedInUserDetails.userName;

      // Get Date of Creation
      // state.model.createdDate = Utils().getCurrentDate();
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
      GmUiLabels labels = GmUiLabels.fromJson(responseLabels);

      emit(
        state.copyWith(
          locations: getLocationsData,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          model: state.model,
          users: users.t1Analyst,
          //createdBy: createdBy,
          securityManager: securityManager,
          srh: srh,
          emailUsers: emailUsers,
          listOfEntities: entities,
          getEntitiesResponse: entities,
          departments: departments.items,
          labels: labels,
        ),
      );
      isFormReadable();
    } catch (e) {
      log('Initialization issue',
          error: e, name: 'Key Loss Destruction Details Cubit');
      emit(
        state.copyWith(
          message: Constants.errorText,
          status: FormStatus.error,
        ),
      );
    }
  }

  Future<void> isFormReadable() async {
    emit(state.copyWith(status: FormStatus.loading));
    // if (state.model.status != ConstantsIntValue.submitted) {
    //   emit(state.copyWith(
    //     status: FormStatus.initial,
    //   ));
    //   return;
    // }
    bool isReadOnly;
    if ((state.model.securityManager != null &&state.model.securityManager!.name
            .equalsIgnoreCase(state.loggedInUserDetails?.name))) {
      isReadOnly = false;
    } else {
      isReadOnly = true;
    }

    emit(state.copyWith(
      isReadOnly: isReadOnly,
      status: FormStatus.initial,
    ));
  }

  void onModelValueChange(KeyLossDestructionListModel model) {
    log('-onModelValueChange---');
    emit(state.copyWith(model: model, status: FormStatus.loading));
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onCheckBoxChange(KeyLossDestructionListModel model) {
    emit(state.copyWith(model: model, status: FormStatus.loading));

    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  Future<void> updateDropdownValues({
    Organisation? location,
    BaseUser? user,
    Organisation? doorType,
    BaseUser? srh,
    BaseUser? securityManager,
    List<Organisation>? entities,
    int? status,
    int? keyType,
    int? type,
    int? maritalStatus,
    int? typeOfDeployment,
    int? msgbFormBSubmitted,
    Organisation? destructionReason,
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
        moduleCode: Constants.keyLossDestructionModule,
      );
      state.model.slNo = slNo.serialNo;
    }

    if (srh != null) {
      User userDetails = User(
        name: srh.name,
        userId: srh.id,
        userName: srh.name,
      );
      state.model.srh = userDetails;
    }
    if (securityManager != null) {
      User userDetails = User(
        name: securityManager.name,
        userId: securityManager.id,
        userName: securityManager.email,
      );
      state.model.securityManager = userDetails;
    }
    if (destructionReason != null) {
      state.model.destructionReason = destructionReason;
    }
    state.model.keyType = keyType ?? state.model.keyType;
    // if (entities != null) {
    //   state.model.entities = entities;
    // }
    // state.model.keyTagging = keyTagging ?? state.model.keyTagging;
    state.model.status = status ?? state.model.status;
    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
    ));
  }

  Future<bool> submitForm({
    bool isSaveOnly = false,
    bool isRejectOnly = false,
    bool isApprovedOnly = false,
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
    DateTime dateTime;
    if (!Utils().isTimestamp(state.model.createdDate!)) {
      dateTime =
          DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.createdDate!);
      int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
      state.model.createdDate = inputDate.toString();
    }
    // Create/Update API Call
    KeyLossDestructionRequest request =
        KeyLossDestructionRequest(keyLossGi: state.model);

    GenericResponse response = GenericResponse();
    try {
      if (isSaveOnly) {
        if (!state.isValidDraft.status) {
          state.model.createdDate = state.model.createdDate == null
              ? Utils().getCurrentDate()
              : Utils.timestampToDateConversion(
                  int.tryParse(state.model.createdDate ?? '0'),
                  Constants.fulldateFormat);
          emit(
            state.copyWith(
              status: FormStatus.formError,
              message: state.isValidDraft.message,
            ),
          );
          return false;
        }
        response = (await services.createKeyLossDestruction(
          body: request,
          isSubmit: false,
          kmId: state.model.keyManagementId,
        ));
      } else {
        //Validating Fields
        if (!state.isValid.status) {
          state.model.createdDate = state.model.createdDate == null
              ? Utils().getCurrentDate()
              : Utils.timestampToDateConversion(
                  int.tryParse(state.model.createdDate ?? '0'),
                  Constants.fulldateFormat);
          emit(
            state.copyWith(
              status: FormStatus.formError,
              message: state.isValid.message,
            ),
          );
          return false;
        }
        response = (await services.createKeyLossDestruction(
          body: request,
          isSubmit: true,
          kmId: state.model.keyManagementId,
        ));
      }
      if (isRejectOnly) {
        //Validating Fields
        if (!state.isValidDraft.status) {
          emit(
            state.copyWith(
              status: FormStatus.formError,
              message: state.isValidDraft.message,
            ),
          );
          return false;
        }
        response = await services.createKeyLossDestruction(
          body: request,
          isSubmit: true,
          kmId: state.model.keyManagementId,
        );
      }
      if (isApprovedOnly) {
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
        response = await services.createKeyLossDestruction(
          body: request,
          isSubmit: true,
          kmId: state.model.keyManagementId,
        );
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
        id: id, module: Constants.keyLossDestructionModule);
  }
}
