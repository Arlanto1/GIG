
import 'dart:async';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/incident_management/models/im_ui_labels.dart';
import 'package:db_atom/src/features/patrolling/models/patrolling_model.dart';
import 'package:db_atom/src/features/patrolling/services/patrolling_service.dart';
part 'patrolling_list_event.dart';
part 'patrolling_list_state.dart';

class PatrollingListBloc
    extends Bloc<PatrollingListEvent, PatrollingListState> {
  PatrollingListBloc(
      ) : super(const PatrollingListState()) {
    on<InitializeValuesPatrolling>(_initializeValues);
    on<FetchPatrolData>(
      _fetchList,
      transformer: droppable(),
    );
    on<RefreshList>(
      _refreshList,
      transformer: droppable(),
    );
  }

  final PatrollingService _services = PatrollingService();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeValuesPatrolling event, Emitter<PatrollingListState> emit) async {


    try {
      emit(state.copyWith(status: FormStatus.loading));

      ExtraProperties extraProperties =
      await UtilsCommon().checkWritePermission(
        moduleCode: Constants.patrollingModule,
        commonServices: commonServices,
      );

      List<Organisation> statuses = await commonServices.getStatusesByModuleId(
          module: Constants.patrollingModule);

      List<Organisation> regions =
      await commonServices.getRegionsOrLocationsByRegionId();

      CommonFilters commonFilters =
      CommonFilters(regions: regions, statuses: statuses);

      Locations locations =
      await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');

      // dynamic responseLabels = await commonServices.getUiLabels(
      //     language: await SharedPrefs.getLanguageCode(),
      //     moduleCode: Constants.patrollingModule);

      // IMUiLabels labels = IMUiLabels.fromJson(responseLabels);
      return emit(
        state.copyWith(
          locations: locations,
          regions: regions,
          statuses: statuses,
          commonFilters: commonFilters,
          hasReachedMax: false,
          status: FormStatus.initial,
          // labels: labels,
          extraProperties: extraProperties,
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
      RefreshList event, Emitter<PatrollingListState> emit) async {
    try {
      PatrollingModelResponse response;

      response = await _services.getPatrollingList(
        startPosition: '0',
        maximumRecords: '20',
        // userId: '7',
        filters: BaseFilterModel(),

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
      FetchPatrolData event, Emitter<PatrollingListState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    try {
      if (state.status == FormStatus.initial || event.newSearch) {
        PatrollingModelResponse response;
        response = await _services.getPatrollingList(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          filters: event.filters,
        );

        return emit(
          state.copyWith(
            items: response.items,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );
      }

      PatrollingModelResponse response;
      response = await _services.getPatrollingList(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
        // userId: '7',
        filters: event.filters,
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
