import 'dart:developer';

import 'package:db_atom/src/features/guarding_operations/key_management_data/key_loss_destruction_list/models/kld_ui_labels.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/services/key_management_master_services.dart';
import 'package:db_atom/src/services/common_services.dart';
import 'package:intl/intl.dart';

import '../../../../../../../index.dart';
import '../../models/requestModels/key_history_record_request.dart';

part 'key_history_records_details_state.dart';

class KeyHistoryRecordsDetailsCubit
    extends Cubit<KeyHistoryRecordsDetailsState> {
  final KeyManagementMasterServices services;
  final KeyManagementMasterModel? model;
  final CommonServices commonServices;
  final int parentId;
  final int type;

  KeyHistoryRecordsDetailsCubit({
    required this.services,
    required this.parentId,
    required this.type,
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
        commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS'),
        commonServices.getUserDetails(userId: userId),
        commonServices.getUsersByRole(roleName: 'T1_Analyst'),
        commonServices.getEntities(name: 'ATOM_ENTITIES'),
        commonServices.getUsers(),
        commonServices.getQualification(name: 'GUARD_QUALIFICATIONS'),
        commonServices.getAtomStaticUsers(roleName: 'ATOM_STATIC_USER'),
        commonServices.getOrganisations(
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
      List<Organisation> destructionReasons = futures[7];
      dynamic responseLabels = futures[9];
      Organisation? defaultLocation = futures[10];
      if (state.model.location == null && defaultLocation != null) {
        SerialNumberModel slNo = await commonServices.getKLDSlNo(
            locationId: defaultLocation.id.toString(),
            moduleCode: Constants.keyLossDestructionModule,
            type: type,
            kmId: parentId);
        state.model.location = defaultLocation;
        state.model.slNo = slNo.serialNo;
      }
      state.model.createdBy ??= loggedInUserDetails;
      state.model.modifiedBy ??= loggedInUserDetails;
      state.model.type = type;
      // Get Date of Creation
      state.model.createdDate = Utils().getCurrentDate();
      state.model.modifiedDate = Utils().getCurrentDate();

      KLDUiLabels labels = KLDUiLabels.fromJson(responseLabels);

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
          destructionReasons: destructionReasons,
          labels: labels,
        ),
      );
    } catch (e) {
      log('Initialization issue',
          error: e, name: 'Key Management History Details Cubit');
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
    BaseUser? securityManager,
    List<Organisation>? doorType,
    List<Organisation>? entities,
    int? status,
    int? systemAccess,
    int? dutyType,
    int? keyType,
    int? type,
    Organisation? destructionReason,
    BaseUser? srh,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    ////Get Sl No from API
    if (location != null) {
      SerialNumberModel slNo = await commonServices.getKLDSlNo(
          locationId: location.id.toString(),
          moduleCode: Constants.keyLossDestructionModule,
          type: type,
          kmId: parentId);

      state.model.location = location;
      state.model.slNo = slNo.serialNo;
    }
    if (destructionReason != null) {
      state.model.destructionReason = destructionReason;
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
    state.model.destructionReason =
        destructionReason ?? state.model.destructionReason;
    state.model.keyType = keyType ?? state.model.keyType;
    state.model.type = type ?? state.model.type;
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
      state.model.status = 0;
    }
    // Setting time in milliseconds
    state.model.createdDate =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
    state.model.modifiedDate =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
    // Create/Update API Call
    KeyHistoryRecordRequest request =
        KeyHistoryRecordRequest(keyLossGi: state.model);
    state.model.keyManagementId = parentId.toString();

    GenericResponse response = GenericResponse();
    try {
      if (isSaveOnly) {
        if (!state.isValidDraft.status) {
          state.model.createdDate = Utils().getCurrentDate();
          emit(
            state.copyWith(
              status: FormStatus.error,
              message: state.isValidDraft.message,
            ),
          );
          return false;
        }
        response = (await services.createKeyHistoryRecord(
          body: request,
          isSubmit: false,
          kmId: parentId.toString(),
        ));
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
        if (isRejectOnly) {
          //Validating Fields
          if (!state.isValidDraft.status) {
            emit(
              state.copyWith(
                status: FormStatus.error,
                message: state.isValidDraft.message,
              ),
            );
            return false;
          }
          response = await services.createKeyHistoryRecord(
            body: request,
            isSubmit: true,
            kmId: parentId.toString(),
          );
        }
        if (isApprovedOnly) {
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
          response = await services.createKeyHistoryRecord(
            body: request,
            isSubmit: true,
            kmId: parentId.toString(),
          );
        }
        response = (await services.createKeyHistoryRecord(
          body: request,
          isSubmit: true,
          kmId: parentId.toString(),
        ));
      }
      state.model.createdDate = Utils().getCurrentDate();
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
  void updateStatus({required String id,required int type}) {
    commonServices.updateRecordStatus(
        id: id, module: Constants.keyLossDestructionModule,status: 11,type:type);
  }
}
