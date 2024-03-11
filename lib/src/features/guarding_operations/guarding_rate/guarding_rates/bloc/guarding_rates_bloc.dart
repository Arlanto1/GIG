import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/models/gr_ui_labels.dart';
import 'package:db_atom/src/models/base_filter_model.dart';
import 'package:db_atom/src/models/organisation.dart';
import 'package:db_atom/src/models/responseModels/token_expired.dart';
import 'package:db_atom/src/services/common_services.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:equatable/equatable.dart';

import '../../../../../enums/form_status.dart';
import '../../models/rates_response.dart';
import '../../services/guarding_services.dart';

part 'guarding_rates_event.dart';
part 'guarding_rates_state.dart';

class GuardingRatesBloc extends Bloc<GuardingRatesEvent, GuardingRatesState> {
  GuardingRatesBloc() : super(const GuardingRatesState()) {
    on<InitializeValuesGR>(_initializeValues);
    on<FetchList>(
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

  FutureOr<void> _initializeValues(
      InitializeValuesGR event, Emitter<GuardingRatesState> emit) async {
    try {
      emit(state.copyWith(status: FormStatus.loading));
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
        ),
      );
    } on Exception {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }

  FutureOr<void> _refreshList(
      RefreshList event, Emitter<GuardingRatesState> emit) async {
    try {
      RatesResponse response;

      response = await _services.getRates(
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
    } on Exception {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }

  // FutureOr<void> _fetchList(
  //     FetchList event, Emitter<GuardingRatesState> emit) async {
  //   try {
  //     if (state.hasReachedMax) return;
  //
  //     if (state.status == FormStatus.initial) {
  //       RatesResponse response = await _services.getRates(
  //           startPosition: '${event.startPos}',
  //           maximumRecords: '${event.maxPos}',
  //           filters: event.filters);
  //
  //       return emit(
  //         state.copyWith(
  //           items: response.items,
  //           hasReachedMax: response.items!.length < event.maxPos ? true : false,
  //           status: FormStatus.success,
  //         ),
  //       );
  //     }
  //
  //     RatesResponse response = await _services.getRates(
  //         startPosition: '${event.startPos}',
  //         maximumRecords: '${event.maxPos}',
  //         filters: event.filters);
  //
  //     log('-response----2-----$response----');
  //
  //     if (response.items?.isEmpty == true) {
  //       return emit(state.copyWith(hasReachedMax: true));
  //     }
  //     return emit(
  //       state.copyWith(
  //         items: List.of(state.items)..addAll(response.items ?? []),
  //         hasReachedMax: false,
  //       ),
  //     );
  //   } catch (e) {
  //     return emit(state.copyWith(status: FormStatus.failure));
  //   }
  // }

  FutureOr<void> _fetchList(
      FetchList event, Emitter<GuardingRatesState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    try {
      // if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial || event.newSearch) {
        log('-_fetchMaterialMovements--initial--');
        RatesResponse response;
        // response = await services.getMaterialMovements(
        //   startPosition: '${event.startPos}',
        //   maximumRecords: '${event.maxPos}',
        //   mmType: isInward ? 1 : 0,
        // );

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

      log('-_fetchMaterialMovements------##--');
      RatesResponse response;
      response = await _services.getRates(
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
    } catch (e) {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }
}
