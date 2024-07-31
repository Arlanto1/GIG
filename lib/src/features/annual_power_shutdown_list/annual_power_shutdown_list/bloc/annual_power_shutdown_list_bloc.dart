import 'dart:async';

import 'package:db_atom/index.dart';

import '../../models/aps_ui_labels.dart';
import '../../services/annual_power_shutdown_services.dart';

part 'annual_power_shutdown_list_event.dart';

part 'annual_power_shutdown_list_state.dart';

class AnnualPowerShutdownListBloc
    extends Bloc<AnnualPowerShutdownListEvent, AnnualPowerShutdownListState> {
  AnnualPowerShutdownListBloc() : super(const AnnualPowerShutdownListState()) {
    on<InitializeValuesAPS>(_initializeValues);
    on<FetchData>(
      _fetchList,
      transformer: droppable(),
    );
    on<RefreshList>(
      _refreshList,
      transformer: droppable(),
    );
  }

  final AnnualPowerShutdownListServices _services =
      AnnualPowerShutdownListServices();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _refreshList(
      RefreshList event, Emitter<AnnualPowerShutdownListState> emit) async {
    try {
      AnnualPowerShutDownResponse response;

      response = await _services.getAnnualPowerShutdownListWithFilters(
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

  FutureOr<void> _initializeValues(InitializeValuesAPS event,
      Emitter<AnnualPowerShutdownListState> emit) async {
    try {
      emit(state.copyWith(status: FormStatus.loading));

      ExtraProperties extraProperties =
          await UtilsCommon().checkWritePermission(
        moduleCode: Constants.annualPowerShutDownModuleCode,
        commonServices: commonServices,
      );

      List<Organisation> statuses = await commonServices.getStatusesByModuleId(
          module: Constants.eventProtectionModule);

      List<Organisation> regions =
          await commonServices.getRegionsOrLocationsByRegionId();

      CommonFilters commonFilters =
          CommonFilters(regions: regions, statuses: statuses);

      Locations locations =
          await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');

      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(),
          moduleCode: Constants.annualPowerShutDownModuleCode);

      APSUILabels labels = APSUILabels.fromJson(responseLabels);
      return emit(
        state.copyWith(
          locations: locations,
          regions: regions,
          statuses: statuses,
          commonFilters: commonFilters,
          hasReachedMax: false,
          status: FormStatus.initial,
          labels: labels,
          extraProperties: extraProperties,
        ),
      );
    } on GenericResponse catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.error,
        ),
      );
      return;
    } on Exception catch (e) {
      return UtilsCommon().exceptionHandling(e, emit, state);
    }
  }

  FutureOr<void> _fetchList(
      FetchData event, Emitter<AnnualPowerShutdownListState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    try {
      if (state.status == FormStatus.initial || event.newSearch) {
        AnnualPowerShutDownResponse response;
        response = await _services.getAnnualPowerShutdownListWithFilters(
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

      AnnualPowerShutDownResponse response;
      response = await _services.getAnnualPowerShutdownListWithFilters(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
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
    } on Exception catch (e) {
      return UtilsCommon().exceptionHandling(e, emit, state);
    }
  }
}
