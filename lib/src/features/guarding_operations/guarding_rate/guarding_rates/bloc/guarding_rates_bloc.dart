import 'dart:async';
import 'dart:developer';

import 'package:db_atom/src/features/guarding_operations/guarding_rate/models/gr_ui_labels.dart';

import '../../../../../../index.dart';
import '../../services/guarding_services.dart';

part 'guarding_rates_event.dart';
part 'guarding_rates_state.dart';

class GuardingRatesBloc extends Bloc<GuardingRatesEvent, GuardingRatesState> {
  GuardingRatesBloc() : super(const GuardingRatesState()) {
    on<InitializeValuesGR>(_initializeValues);
    on<FetchData>(
      _fetchList,
      transformer: droppable(),
    );
    on<RefreshList>(
      _refreshList,
      transformer: droppable(),
    );
  }

  final GuardingServices _services = GuardingServices();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _refreshList(
      RefreshList event, Emitter<GuardingRatesState> emit) async {
    log('--_refreshList---');
    try {
      RatesResponse response;

      response = await _services.getRates(
        startPosition: '0',
        maximumRecords: '20',
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

  FutureOr<void> _initializeValues(
      InitializeValuesGR event, Emitter<GuardingRatesState> emit) async {
    log('--_initializeValues---');
    try {
      emit(state.copyWith(status: FormStatus.loading));

      ExtraProperties extraProperties =
          await UtilsCommon().checkWritePermission(
        moduleCode: Constants.guardingRatesModule,
        commonServices: commonServices,
      );

      List<Organisation> statuses = await commonServices.getStatusesByModuleId(
          module: Constants.guardingRatesModule);

      List<Organisation> regions =
          await commonServices.getRegionsOrLocationsByRegionId();

      CommonFilters commonFilters =
          CommonFilters(regions: regions, statuses: statuses);

      Locations locations =
          await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');

      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(),
          moduleCode: Constants.guardingRatesModule);

      GRUiLabels labels = GRUiLabels.fromJson(responseLabels);
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
          status: FormStatus.formError,
        ),
      );
      return;
    } on Exception catch (e) {
      return UtilsCommon().exceptionHandling(e, emit, state);
    }
  }

  FutureOr<void> _fetchList(
      FetchData event, Emitter<GuardingRatesState> emit) async {
    log('--_fetchList---');
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    try {
      if (state.status == FormStatus.initial || event.newSearch) {
        RatesResponse response;
        response = await _services.getRates(
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
      log('--after if---');

      RatesResponse response;
      response = await _services.getRates(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
        filters: event.filters,
      );

      if (response.items?.isEmpty == true) {
        return emit(state.copyWith(
          hasReachedMax: true,
          status: FormStatus.success,
        ));
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
