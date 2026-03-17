import 'dart:developer';

import 'package:db_atom/index.dart';
import '../../model/opsTeamSitutationModel.dart';
import '../../model/requestmodel/buildingRepRequestModel.dart';
import '../../services/opsSituationUpdateService.dart';

part 'buildingOccRepState.dart';

class BuildingOccRepCubit
    extends Cubit<BuildingOccRepState> {
  final OpsSituationUpdateServices services;
  final LsmOccupancyReport? model;
  final CommonServices commonServices;
  final int parentId;
  BuildingOccRepCubit({
    required this.services,
    required this.commonServices,
    this.model, required this.parentId,
  }) : super(
    BuildingOccRepState.initial(
      model: model ?? LsmOccupancyReport(),
      locations: Locations(),
      loggedInUserDetails: User(),
      users: const [],
      emailUsers: const [],
      listOfEntities: const [],
      vendors: const [],
      typeOfServices: const [],
      errorMessage: '',
      getEntitiesResponse: const [],
    ),
  );

  void onModelValueChange(LsmOccupancyReport model) {
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  // void onCheckBoxChange(LsmSituationalModel model) {
  //   emit(state.copyWith(model: model, status: FormStatus.loading));
  //
  //   emit(state.copyWith(model: model, status: FormStatus.initial));
  // }


  Future<void> refreshList() async {
    emit(state.copyWith(status: FormStatus.loading));
    List<BaseUser> emailUsers = await commonServices.getBaseUsers(
      roleName: ConstantUserRoles.atomAssistantSecurityLead,
      locationId: state.model.locationId?.id,
      isDbUser: true,
    );
    emit(
      state.copyWith(
        status: FormStatus.initial,
        emailUsers: emailUsers,
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

    try {
      Locations getLocationsData =
      await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');

      User loggedInUserDetails =
      await commonServices.getUserDetails(userId: userId);

      await commonServices.getBaseUsers(
        roleName: ConstantUserRoles.atomAssistantSecurityLead,
        locationId: state.model.locationId?.id,
        isDbUser: true,
      );
      emit(
        state.copyWith(
          locations: getLocationsData,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          model: state.model,
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


    /// Get Sl No from API
    if (location != null) {
      state.model.locationId = location;
    }
    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
    ));
  }


  // Future<bool> submitForm({
  //   bool isSaveOnly = false,
  //   bool navigateToNextScreen = false,
  // }) async {
  //   emit(
  //     state.copyWith(
  //       status: FormStatus.loading,
  //     ),
  //   );
  //
  //   BuildingRepModelRequest request =
  //   BuildingRepModelRequest();
  //
  //   // TODO: Need to change from Backend- Status should be handled from backend
  //   try {
  //     GenericResponse response = GenericResponse();
  //     if (isSaveOnly) {
  //       //Validating Fields
  //       if (!state.isValidDraft.status) {
  //         emit(
  //           state.copyWith(
  //             status: FormStatus.formError,
  //             message: state.isValidDraft.message,
  //           ),
  //         );
  //         return false;
  //       }
  //       response = await services.createBuildingRepo(
  //           body: request, id: parentId,);
  //     }
  //     else {
  //       response = await services.createBuildingRepo(
  //           body: request, id: parentId,);
  //     }
  //
  //     log('---response--msg--${response.message}---');
  //
  //     if (response.id != null) {
  //       int? id = int.tryParse(response.id!);
  //       if (id != null) {
  //         state.model.id = id;
  //       }
  //     }
  //
  //     FormStatus status;
  //     status = FormStatus.success;
  //
  //     emit(
  //       state.copyWith(
  //         model: state.model,
  //         message: response.message,
  //         status: status,
  //       ),
  //     );
  //
  //     return true;
  //   } on GenericResponse catch (e) {
  //     Utils().emitErrorState(e, emit, state);
  //     return false;
  //   } on Exception catch (e) {
  //     emit(
  //       state.copyWith(
  //         message: e.toString(),
  //         status: FormStatus.error,
  //       ),
  //     );
  //     return false;
  //   }
  // }

  Future<bool> submitForm({
    bool isSaveOnly = false,
    bool navigateToNextScreen = false,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    BuildingRepModelRequest request = BuildingRepModelRequest();

    // ✅ ADD THIS LINE
    request.items = state.model;

    try {
      GenericResponse response = GenericResponse();

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

        // ✅ PASS opsSituationId HERE
        response = await services.createBuildingRepo(
          body: request,
          id: parentId,
        );
      } else {
        // ✅ PASS opsSituationId HERE
        response = await services.createBuildingRepo(
          body: request,
          id: parentId,
        );
      }

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

      return true;
    } catch (e) {
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
