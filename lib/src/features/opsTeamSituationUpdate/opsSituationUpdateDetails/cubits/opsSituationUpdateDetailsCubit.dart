import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:intl/intl.dart';
import '../../model/opsTeamSitutationModel.dart';
import '../../model/requestmodel/opsTeamSituationRequestModel.dart';
import '../../services/opsSituationUpdateService.dart';

part 'opsSituationUpdateDetailsState.dart';

class OpsSituationUpdateDetailsCubit
    extends Cubit<OpsSituationUpdateDetailsState> {
  final OpsSituationUpdateServices services;
  final LsmSituationalModel? model;
  final CommonServices commonServices;

  OpsSituationUpdateDetailsCubit({
    required this.services,
    required this.commonServices,
    this.model,
  }) : super(
    OpsSituationUpdateDetailsState.initial(
      model: model ?? LsmSituationalModel(),
      locations: Locations(),
      loggedInUserDetails: User(),
      users: const [],
      emailUsers: const [],
      listOfEntities: const [],
      vendors: const [],
      typeOfServices: const [],
      errorMessage: '',
      getEntitiesResponse: const [], mailTo: const [], mailCc: const [],
    ),
  );

  void onModelValueChange(LsmSituationalModel model) {
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  Future<void> refreshList() async {
    emit(state.copyWith(status: FormStatus.loading));

    DistributionGroupModel distributionGroup =
    await commonServices.getLeoDistributionGroup();
    emit(
      state.copyWith(
        status: FormStatus.initial,
        mailTo: distributionGroup.distributionGroups,
        mailCc: distributionGroup.distributionGroups,
      ),
    );
  }

  Future<void> initializeValues() async {
    log('-status-1-${state.status}--');

    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    var userId = await SharedPrefs.getUserId();

    if (state.model.location == null) {
      Organisation? defaultLocation = await SharedPrefs.getDefaultLocation();
      if (defaultLocation != null) {
        SerialNumberModel slNo = await commonServices.getSlNo(
          locationId: defaultLocation.id.toString(),
          moduleCode: Constants.slaViolationPenaltyDetailsModuleCode,
        );
        state.model.location = defaultLocation;
        state.model.slNo = slNo.serialNo;
      }
    }

    try {
      Locations getLocationsData =
      await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');

      User loggedInUserDetails =
      await commonServices.getUserDetails(userId: userId);

      List<BaseUser> emailUsers = await commonServices.getBaseUsers(
        roleName: ConstantUserRoles.atomAssistantSecurityLead,
        locationId: state.model.location?.id,
        isDbUser: true,
      );


      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.inputDate ?? '0'),
          Constants.fulldateFormat);
      state.model.modifiedDate = state.model.modifiedDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.modifiedDate ?? '0'),
          Constants.fulldateFormat);
      // Get Date of Creation
      // state.model.inputDate = state.model.inputDate == null
      //     ? Utils().getCurrentDate()
      //     : Utils().formatUnixTimestamp(state.model.inputDate ?? '');
      // state.model.inputDate =
      //     (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

      DistributionGroupModel distributionGroup =
      await commonServices.getLeoDistributionGroup();
      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(),
          moduleCode: Constants.slaViolationPenaltyDetailsModuleCode);
      SlaUiLabels labels = SlaUiLabels.fromJson(responseLabels);



      state.model.entrySecurity ??= loggedInUserDetails;
      emit(
        state.copyWith(
          locations: getLocationsData,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          model: state.model,
          emailUsers: emailUsers,
          mailTo: distributionGroup.distributionGroups,
          mailCc: distributionGroup.distributionGroups,
          labels: labels,
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
    List<Organisation> dutyPostNames = [];

    /// Get Sl No from API
    if (location != null) {
      SerialNumberModel slNo = await commonServices.getSlNo(
        locationId: location.id.toString(),
        moduleCode: Constants.slaViolationPenaltyDetailsModuleCode,
      );

      state.model.location = location;
      state.model.slNo = slNo.serialNo ?? '';

      emailUsers = await commonServices.getBaseUsers(
        roleName: ConstantUserRoles.atomAssistantSecurityLead,
        locationId: location.id,
        isDbUser: true,
      );

      dutyPostNames = await commonServices
          .getDutyPostsByLocation(
          locationId: location.id.toString());
    }


    emit(state.copyWith(
      model: state.model,
      emailUsers: emailUsers,
      dutyPosts: dutyPostNames,
      status: FormStatus.initial,
    ));
  }

  Future<void> getLSMById(int id) async {
    emit(state.copyWith(status: FormStatus.loading));

    final response = await services.getLSMById('${model?.id}');

    emit(
      state.copyWith(
        model: response, // 🔥 NEW object from API
        status: FormStatus.initial,
      ),
    );
  }

  Future<void> deleteDBLocationUpdate({
    required int deleteId,
    required int parentId,
  }) async {
    emit(state.copyWith(status: FormStatus.loading));

    try {
      final success =
      await services.dltDBLocUpdateById(deleteId.toString());

      // 🔁 Reload updated LSM
      final updatedModel = await services.getLSMById('${model?.id}');

      emit(
        state.copyWith(
          model: updatedModel,
          status: FormStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: FormStatus.error,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> deleteBuildingOccReport({
    required int deleteId,
    required int parentId,
  }) async {
    emit(state.copyWith(status: FormStatus.loading));

    try {
      final success =
      await services.dltBuildingReportById(deleteId.toString());

      // 🔁 Reload updated LSM
      final updatedModel = await services.getLSMById('${model?.id}');

      emit(
        state.copyWith(
          model: updatedModel,
          status: FormStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: FormStatus.error,
          message: e.toString(),
        ),
      );
    }
  }

  //
  // Future<void> _deleteRecord(
  //     DeleteRecord event, Emitter<KeyIssuanceProcessRecordState> emit) async {
  //   emit(
  //     state.copyWith(
  //       status: FormStatus.loading,
  //     ),
  //   );
  //   try {
  //     await KeyManagementIssuanceServices().deleteVpById(event.id);
  //     List<KeyIssuanceProcessRecord> response =
  //     await services.getIssuanceProcessList(
  //       id: '${event.parentId}',
  //     );
  //     return emit(
  //       state.copyWith(items: response, status: FormStatus.success),
  //     );
  //   } on GenericResponse catch (e) {
  //     emit(
  //       state.copyWith(
  //         message: e.message,
  //         status: FormStatus.formError,
  //       ),
  //     );
  //     return;
  //   } on Exception catch (e) {
  //     return UtilsCommon().exceptionHandling(e, emit, state);
  //   }
  // }



  Future<void> updateDropdownValues({
    List<Organisation>? entities,
    List<Organisation>? vendors,
    List<Organisation>? typeOfServices,
    Organisation? dutyPostName,
    BaseUser? user,
    BaseUser? approver,
    int? status,
    BaseUser? receiverEmailUser,
    List<Organisation>? mailTo,
    List<Organisation>? mailCc,

  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    // List<BaseUser> emailUsers = [];
    // // Get Sl No from API
    // if (location != null) {
    //   SerialNumberModel slNo = await commonServices.getSlNo(
    //     locationId: location.id.toString(),
    //     moduleCode: Constants.slaViolationPenaltyDetailsModuleCode,
    //   );
    //   state.model.location = location;
    //   state.model.slNo = slNo.serialNo;
    //   emailUsers = await commonServices.getBaseUsers(
    //       roleName: ConstantUserRoles.atomStaticUser, locationId: location.id);
    // }
    state.model.status = status ?? state.model.status;
    // if (location != null) {
    //   SerialNumberModel slNo = await commonServices.getSlNo(
    //       locationId: location.id.toString(),
    //       moduleCode: Constants.slaViolationPenaltyDetailsModuleCode);
    //   state.model.location = location;
    //   state.model.slNo = slNo.serialNo;
    // }\
    if (mailTo != null) {
      state.model.mailListTo = mailTo;
    }

    if (mailCc != null) {
      state.model.mailListCc = mailCc;
    }

    emit(state.copyWith(
      model: state.model,
      // emailUsers: emailUsers,
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

    // Setting time in milliseconds
    // state.model.inputDate =
    //     (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

    DateTime dateTime;
    if (!Utils().isTimestamp(state.model.inputDate!)) {
      dateTime =
          DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.inputDate!);
      int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
      state.model.inputDate = inputDate.toString();
    }


    // Create/Update API Call
    LsmSituationModelRequest request =
    LsmSituationModelRequest(lsmSituationalModel:state.model,);

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
        response = await services.createLSM(
            body: request, isSubmit: false);
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
        response = await services.createLSM(
            body: request, isSubmit: false);
      }
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.inputDate ?? '0'),
          Constants.fulldateFormat);
      state.model.modifiedDate = state.model.modifiedDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.modifiedDate ?? '0'),
          Constants.fulldateFormat);
      log('---response--msg--${response.message}---');

      if (response.id != null) {
        int? id = int.tryParse(response.id!);
        if (id != null) {
          state.model.id = id;
        }
      }

       FormStatus status;
        status = FormStatus.success;

      emit(
        state.copyWith(
          model: state.model,
          message: response.message,
          status: status,
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

  void updateStatus({required String id}) {
    commonServices.updateRecordStatus(
      id: id,
      module: Constants.slaViolationPenaltyDetailsModuleCode,
    );
  }
}
