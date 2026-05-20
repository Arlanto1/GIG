
import 'dart:async';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/incident_management/models/im_ui_labels.dart';
import 'package:db_atom/src/features/patrolling/models/patrolling_model.dart';
import 'package:db_atom/src/features/patrolling/services/patrolling_service.dart';
import 'package:db_atom/src/features/training_module/models/requestModel/training_module_request.dart';
import 'package:db_atom/src/features/training_module/services/training_module_service.dart';
part 'training_module_list_event.dart';
part 'training_module_list_state.dart';

class TrainingModuleListBloc
    extends Bloc<TrainingModuleListEvent, TrainingModuleListState> {
  TrainingModuleListBloc(
      ) : super(const TrainingModuleListState(items: [])) {
    on<InitializeValuesTraining>(_initializeValues);
    on<FetchTrainingData>(
      _fetchList,
      transformer: droppable(),
    );
    on<RefreshTrainingList>(
      _refreshList,
      transformer: droppable(),
    );
  }

  final TrainingModuleServices _services = TrainingModuleServices();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeValuesTraining event, Emitter<TrainingModuleListState> emit) async {


    try {
      emit(state.copyWith(status: FormStatus.loading));

      // ExtraProperties extraProperties =
      // await UtilsCommon().checkWritePermission(
      //   moduleCode: Constants.patrollingModule,
      //   commonServices: commonServices,
      // );

 // dynamic responseLabels = await commonServices.getUiLabels(
      //     language: await SharedPrefs.getLanguageCode(),
      //     moduleCode: Constants.patrollingModule);

      // IMUiLabels labels = IMUiLabels.fromJson(responseLabels);
      return emit(
        state.copyWith(
          hasReachedMax: false,
          status: FormStatus.initial,
          // labels: labels,
          // extraProperties: extraProperties,
        ),
      );
    } on GenericResponse catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.formError,
        ),
      );
      return;
    } on Exception catch (e) {
      return UtilsCommon().exceptionHandling(e, emit, state);
    }
  }

  FutureOr<void> _refreshList(
      RefreshTrainingList event, Emitter<TrainingModuleListState> emit) async {
    try {
      TrainingModuleResponseModel response;

      response = await _services.getClassRoomTrainingList(
      );

      return emit(
        state.copyWith(
          items: response.items,
          hasReachedMax: false,
          status: FormStatus.success,
        ),
      );
    } on Exception catch (e) {
      return UtilsCommon().exceptionHandling(e, emit, state);
    }
  }


  FutureOr<void> _fetchList(
      FetchTrainingData event, Emitter<TrainingModuleListState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    try {
      if (state.status == FormStatus.initial) {
        TrainingModuleResponseModel response;
        response = await _services.getClassRoomTrainingList(
        );

        return emit(
          state.copyWith(
            items: response.items,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );
      }

      TrainingModuleResponseModel response;
      response = await _services.getClassRoomTrainingList(
      );

      if (response.items?.isEmpty == true) {
        return emit(state.copyWith(hasReachedMax: true));
      }
      return emit(
        state.copyWith(
          items: List.of(state.items)..addAll(response.items ?? []),
          hasReachedMax: false,
          status: FormStatus.success,
        ),
      );
    } on TokenExpiredException catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.sessionExpired,
        ),
      );
      return;
    } catch (e) {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }
}
