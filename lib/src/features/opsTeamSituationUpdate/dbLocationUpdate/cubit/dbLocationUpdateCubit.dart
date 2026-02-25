import 'dart:developer';
import 'dart:math' as math;

import 'package:db_atom/index.dart';
import '../../model/opsTeamSitutationModel.dart';
import '../../model/requestmodel/lsmLocUpdateRequestModel.dart';
import '../../services/opsSituationUpdateService.dart';

part 'dbLocationUpdateState.dart';

class DbLocationUpdateCubit
    extends Cubit<DbLocationUpdateState> {
  final OpsSituationUpdateServices services;
  final LsmLocationUpdate? model;
  final CommonServices commonServices;
  final int parentId;
  DbLocationUpdateCubit({
    required this.services,
    required this.commonServices,
    this.model, required this.parentId,
  }) : super(
    DbLocationUpdateState.initial(
      model: model ?? LsmLocationUpdate(),
      locations: Locations(),
      loggedInUserDetails: User(),
      users: const [],
      emailUsers: const [],
      listOfEntities: const [],
      vendors: const [],
      typeOfServices: const [],
      errorMessage: '',
      getEntitiesResponse: const [], uploadAttachments: const [],
    ),
  );

  void onModelValueChange(LsmLocationUpdate model) {
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  // void onCheckBoxChange(LsmSituationalModel model) {
  //   emit(state.copyWith(model: model, status: FormStatus.loading));
  //
  //   emit(state.copyWith(model: model, status: FormStatus.initial));
  // }


  Future<void> refreshList() async {
    emit(state.copyWith(status: FormStatus.loading));
    emit(
      state.copyWith(
        status: FormStatus.initial,
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
      User loggedInUserDetails =
      await commonServices.getUserDetails(userId: userId);

      emit(
        state.copyWith(
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



  Future<bool> submitForm({
    bool isSaveOnly = false,
    bool navigateToNextScreen = false,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    LsmLocUpdateModelRequest request = LsmLocUpdateModelRequest();

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
        response = await services.createLocUpdate(
          body: request,
          id: parentId,
        );
      } else {
        // ✅ PASS opsSituationId HERE
        response = await services.createLocUpdate(
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

      state.model.images = data;
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


  void updateStatus({required String id}) {
    commonServices.updateRecordStatus(
      id: id,
      module: Constants.slaViolationPenaltyDetailsModuleCode,
    );
  }
}
