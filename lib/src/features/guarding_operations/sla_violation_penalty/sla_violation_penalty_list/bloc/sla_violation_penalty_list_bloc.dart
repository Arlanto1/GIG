import 'dart:async';
import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/sla_violation_penalty/services/sla_violation_penalty_services.dart';

part 'sla_violation_penalty_list_event.dart';
part 'sla_violation_penalty_list_state.dart';

class SLAViolationPenaltyListBloc
    extends Bloc<SLAViolationPenaltyListEvent, SLAViolationPenaltyListState> {
  SLAViolationPenaltyListBloc() : super(const SLAViolationPenaltyListState()) {
    on<InitializeValues>(_initializeValues);
    on<FetchData>(
      _fetchSLAViolationPenalty,
      transformer: droppable(),
    );
    on<RefreshList>(
      _refreshList,
      transformer: droppable(),
    );
  }

  final SLAViolationPenaltyServices services = SLAViolationPenaltyServices();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(InitializeValues event,
      Emitter<SLAViolationPenaltyListState> emit) async {
    try {
      emit(state.copyWith(status: FormStatus.loading));

      ExtraProperties extraProperties =
          await UtilsCommon().checkWritePermission(
        moduleCode: Constants.slaViolationPenaltyDetailsModuleCode,
        commonServices: commonServices,
      );

      List<Organisation> statuses = await commonServices.getStatusesByModuleId(
          module: Constants.slaViolationPenaltyDetailsModuleCode);

      List<Organisation> regions =
          await commonServices.getRegionsOrLocationsByRegionId();

      CommonFilters commonFilters =
          CommonFilters(regions: regions, statuses: statuses);

      Locations locations =
          await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');

      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(),
          moduleCode: Constants.slaViolationPenaltyDetailsModuleCode);

      SlaUiLabels labels = SlaUiLabels.fromJson(responseLabels);
      return emit(
        state.copyWith(
          locations: locations,
          regions: regions,
          statuses: statuses,
          commonFilters: commonFilters,
          hasReachedMax: false,
          status: FormStatus.success,
          labels: labels,
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
      RefreshList event, Emitter<SLAViolationPenaltyListState> emit) async {
    try {
      log('-----_refreshList--');

      SLAViolationPenaltyResponseModel response;

      response = await services.getGSvp(
        startPosition: '${0}',
        maximumRecords: '${20}',
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

  FutureOr<void> _fetchSLAViolationPenalty(
      FetchData event, Emitter<SLAViolationPenaltyListState> emit) async {
    log('-_state.status-11--${state.status}--');
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    try {
      // if (state.hasReachedMax) return;
      log('-_state.status--222-${state.status}--');

      if (state.status == FormStatus.initial || event.newSearch) {
        SLAViolationPenaltyResponseModel response;
        response = await services.getGSvp(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          filters: event.filters,
        );
        log('-_state.status--333-${state.status}--');

        return emit(
          state.copyWith(
            items: response.items,
            hasReachedMax: false,
            status: FormStatus.initial,
          ),
        );
      }

      log('-_fetchMaterialMovements------##--');
      SLAViolationPenaltyResponseModel response;
      response = await services.getGSvp(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
        filters: event.filters,
      );

      if (response.items?.isEmpty == true) {
        return emit(state.copyWith(hasReachedMax: true));
      }

      log('---state.items-----${state.items.length}--------');
      log('---response.length-----${response.items?.length}--------');
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
