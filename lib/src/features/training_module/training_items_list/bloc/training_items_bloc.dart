
import 'dart:async';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/training_module/services/training_module_service.dart';

import '../../models/requestModel/training_items_model_request.dart';
part 'training_items_event.dart';
part 'training_items_state.dart';

class TrainingItemsBloc
    extends Bloc<TrainingItemsEvent, TrainingItemsState> {
  TrainingItemsBloc(
      ) : super(const TrainingItemsState(items: [])) {
    on<InitializeValuesTrainingItems>(_initializeValues);
    on<FetchTrainingItemsData>(
      _fetchList,
      transformer: droppable(),
    );
    on<RefreshTrainingItemsList>(
      _refreshList,
      transformer: droppable(),
    );
  }

  final TrainingModuleServices _services = TrainingModuleServices();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeValuesTrainingItems event, Emitter<TrainingItemsState> emit) async {


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
      RefreshTrainingItemsList event, Emitter<TrainingItemsState> emit) async {
    try {
      TrainingItemsResponseModel response;

      response = await _services.getTrainingItemsById(event.id
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
      FetchTrainingItemsData event, Emitter<TrainingItemsState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    try {
      if (state.status == FormStatus.initial) {
        TrainingItemsResponseModel response;
        response = await _services.getTrainingItemsById(event.id
        );

        return emit(
          state.copyWith(
            items: response.items,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );
      }

      TrainingItemsResponseModel response;
      response = await _services.getTrainingItemsById(event.id
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
