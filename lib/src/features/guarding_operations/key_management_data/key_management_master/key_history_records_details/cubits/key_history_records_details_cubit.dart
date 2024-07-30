import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/services/key_management_master_services.dart';

part 'key_history_records_details_state.dart';

class KeyHistoryRecordsDetailsCubit
    extends Cubit<KeyHistoryRecordsDetailsState> {
  final KeyManagementMasterServices services;
  final KeyHistoryModel? model;
  final CommonServices commonServices;
  final int parentId;
  final int type;
  final int? kipId;

  KeyHistoryRecordsDetailsCubit({
    required this.services,
    required this.parentId,
    required this.type,
    required this.commonServices,
    required this.model,
    this.kipId,
  }) : super(
          KeyHistoryRecordsDetailsState.initial(
            model: model ?? KeyHistoryModel(),
            loggedInUserDetails: User(),
            users: const [],
            securityManager: const [],
            errorMessage: '',
            departments: const [],
          ),
        );

  void onModelValueChange(KeyHistoryModel model) {
    log('-onModelValueChange---');
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onCheckBoxChange(KeyHistoryModel model) {
    emit(state.copyWith(model: model, status: FormStatus.loading));

    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  Future<void> initializeValues() async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    KeyManagementMasterModel parentModel = await services.getById(parentId);

    // KeyIssuanceProcessRecord keyIssuanceProcessModel =
    // await KeyManagementIssuanceServices().getIssuanceProcessById(kipId ?? 0);

    var userId = await SharedPrefs.getUserId();
    try {
      // Use Future.wait to call API functions concurrently
      final futures = await Future.wait([
        commonServices.getUserDetails(userId: userId),
        commonServices.getBaseUsersByRoles(roleNames: 'ATOM_Security_Manager'),
        commonServices.getOrganisations(
            name: 'KEY_MANAGEMENT_DESTRUCTION_REASON'),
        commonServices.getUiLabels(
            language: await SharedPrefs.getLanguageCode(),
            moduleCode: Constants.keyManagementMasterModule),
        SharedPrefs.getDefaultLocation(),
        commonServices.getBaseUsersByRoles(roleNames: 'ATOM_Sub_Regional_Head'),
      ]);

      User loggedInUserDetails = futures[0];
      List<BaseUser> securityManager = futures[1];
      List<Organisation> destructionReasons = futures[2];
      dynamic responseLabels = futures[3];
      Organisation? defaultLocation = futures[4];
      List<BaseUser> srh = futures[5];

      if (defaultLocation != null && state.model.slNo == null) {
        SerialNumberModel slNo = await commonServices.getKLDSlNo(
          locationId: defaultLocation.id.toString(),
          moduleCode: Constants.keyLossDestructionModule,
          type: type,
          kmId: parentId,
        );
        state.model.slNo = slNo.serialNo;
      }
      state.model.createdBy ??= loggedInUserDetails;
      state.model.modifiedBy ??= loggedInUserDetails.email;
      state.model.type = type;
      // Get Date of Creation
      // state.model.createdDate = Utils().getCurrentDate();
      // state.model.modifiedDate = Utils().getCurrentDate();
      state.model.createdDate = state.model.createdDate == null
          ? Utils().getCurrentDate()
          : Utils().formatUnixTimestamp(state.model.createdDate ?? '');
      state.model.modifiedDate = state.model.modifiedDate == null
          ? Utils().getCurrentDate()
          : Utils().formatUnixTimestamp(state.model.modifiedDate ?? '');
      KLDUiLabels labels = KLDUiLabels.fromJson(responseLabels);

      emit(
        state.copyWith(
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          model: state.model,
          securityManager: securityManager,
          srh: srh,
          destructionReasons: destructionReasons,
          labels: labels,
          keyManagementMasterModel: parentModel,
          // keyIssuanceProcessRecord:keyIssuanceProcessModel
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

  Future<void> refreshList() async {
    emit(state.copyWith(status: FormStatus.loading));

    Analyst users = await commonServices.getUsersByRole(roleName: 'T1_Analyst');
    List<Organisation>? departments = await commonServices.getOrganisations(
        name: 'KEY_MANAGEMENT_DESTRUCTION_REASON');
    List<BaseUser> securityManager = await commonServices.getBaseUsersByRoles(
        roleNames: 'ATOM_Security_Manager');
    List<BaseUser> srh = await commonServices.getBaseUsersByRoles(
        roleNames: 'ATOM_Sub_Regional_Head');

    emit(
      state.copyWith(
        status: FormStatus.initial,
        users: users.t1Analyst,
        securityManager: securityManager,
        srh: srh,
        departments: departments,
      ),
    );
  }

  Future<void> updateDropdownValues({
    Organisation? location,
    BaseUser? securityManager,
    List<Organisation>? doorType,
    int? status,
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
      state.model.slNo = slNo.serialNo;
    }
    if (destructionReason != null) {
      state.model.destructionReason = destructionReason;
    }
    if (srh != null) {
      User userDetails = User(
        name: srh.name,
        userId: srh.id,
        userName: srh.email,
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

    if (isApprovedOnly == true) {
      state.model.comment == null;
    }
    if (state.model.status == 0 || state.model.status == null) {
      state.model.status = 0;
    }

    state.model.createdDate =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

    // Setting time in milliseconds
    // DateTime dateTime;
    // if (!Utils().isTimestamp(state.model.createdDate!)) {
    //   dateTime =
    //       DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.createdDate!);
    //   int inputDate = dateTime
    //       .toUtc()
    //       .millisecondsSinceEpoch ~/ 1000;
    //   state.model.createdDate = inputDate.toString();
    // }
    state.model.modifiedDate =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
    // Create/Update API Call
    KeyHistoryRecordRequest request =
        KeyHistoryRecordRequest(keyLossGi: state.model);
    // state.model.keyManagementId = parentId.toString();

    log('---state.keyManagementMasterModel?.noKeys----${state.keyManagementMasterModel?.noKeys}------');

    GenericResponse response = GenericResponse();
    try {
      if (isSaveOnly) {
        if (!state.isValidDraft.status) {
          state.model.createdDate = Utils().getCurrentDate();
          emit(
            state.copyWith(
              status: FormStatus.formError,
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
              status: FormStatus.formError,
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
                status: FormStatus.formError,
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
                status: FormStatus.formError,
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
      state.model.createdDate = state.model.createdDate == null
          ? Utils().getCurrentDate()
          : Utils().formatUnixTimestamp(state.model.createdDate ?? '');
      state.model.modifiedDate = state.model.modifiedDate == null
          ? Utils().getCurrentDate()
          : Utils().formatUnixTimestamp(state.model.modifiedDate ?? '');
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

  void updateStatus({required String id, required int type}) {
    commonServices.updateRecordStatus(
        id: id,
        module: Constants.keyLossDestructionModule,
        status: 11,
        type: type);
  }
}
