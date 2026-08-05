
import 'dart:async';
import 'dart:developer';

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
        startPosition: '0',
        maximumRecords: '20',
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
      FetchSelfPacedTrainingData event, Emitter<SelfPacedTrainingListState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    log('response.111');
    try {
      log('response.222');
      if (state.status == FormStatus.initial) {
        SelfPacedTrainingModuleResponseModel response;
        response = await _services.getSelfPacedTrainingList(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
        );
        log('response.items ${response.items}');

        return emit(
          state.copyWith(
            items: response.items,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );
      }

      SelfPacedTrainingModuleResponseModel response;
      response = await _services.getSelfPacedTrainingList(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
      );
      log('response.333 ${response.items}');

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
