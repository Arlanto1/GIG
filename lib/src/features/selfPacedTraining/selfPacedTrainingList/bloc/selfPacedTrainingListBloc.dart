
import 'dart:async';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/selfPacedTraining/models/selfPacedTrainingModel.dart';
import 'package:db_atom/src/features/selfPacedTraining/services/selfPacedTrainingService.dart';
part 'selfPacedTrainingListEvent.dart';
part 'selfPacedTrainingListState.dart';

class SelfPacedTrainingListBloc
    extends Bloc<SelfPacedTrainingListEvent, SelfPacedTrainingListState> {
  SelfPacedTrainingListBloc(
      ) : super(const SelfPacedTrainingListState(items: [])) {
    on<InitializeValuesSelfPacedTraining>(_initializeValues);
    on<FetchSelfPacedTrainingData>(
      _fetchList,
      transformer: droppable(),
    );
    on<RefreshSelfPacedTrainingList>(
      _refreshList,
      transformer: droppable(),
    );
  }

  final SelfPacedTrainingService _services = SelfPacedTrainingService();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeValuesSelfPacedTraining event, Emitter<SelfPacedTrainingListState> emit) async {


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
      RefreshSelfPacedTrainingList event, Emitter<SelfPacedTrainingListState> emit) async {
    try {
      SelfPacedTrainingModuleResponseModel response;

      response = await _services.getSelfPacedTrainingList(
      );

      return emit(
        state.copyWith(
          items: response.list,
          hasReachedMax: false,
          status: FormStatus.success,
        ),
      );
    } on Exception catch (e) {
      return UtilsCommon().exceptionHandling(e, emit, state);
    }
  }


  FutureOr<void> _fetchList(
      FetchSelfPacedTrainingData event, Emitter<SelfPacedTrainingListState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    try {
      if (state.status == FormStatus.initial) {
        SelfPacedTrainingModuleResponseModel response;
        response = await _services.getSelfPacedTrainingList(
        );

        return emit(
          state.copyWith(
            items: response.list,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );
      }

      SelfPacedTrainingModuleResponseModel response;
      response = await _services.getSelfPacedTrainingList(
      );

      if (response.list?.isEmpty == true) {
        return emit(state.copyWith(hasReachedMax: true));
      }
      return emit(
        state.copyWith(
          items: List.of(state.items)..addAll(response.list ?? []),
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
