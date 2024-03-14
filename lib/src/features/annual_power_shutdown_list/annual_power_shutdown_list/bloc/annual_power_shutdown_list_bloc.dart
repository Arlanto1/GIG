import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/annual_power_shutdown_list/annual_power_shutdown_list/models/annual_power_shutdown_model.dart';
import 'package:db_atom/src/features/annual_power_shutdown_list/models/aps_ui_labels.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/models/base_filter_model.dart';
import 'package:db_atom/src/models/organisation.dart';
import 'package:db_atom/src/services/common_services.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:equatable/equatable.dart';

import '../../../../enums/form_status.dart';
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

  FutureOr<void> _initializeValues(InitializeValuesAPS event,
      Emitter<AnnualPowerShutdownListState> emit) async {
    try {
      emit(state.copyWith(status: FormStatus.loading));
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
          moduleCode: Constants.eventProtectionModuleCode);
      APSUILabels labels = APSUILabels.fromJson(responseLabels);
      return emit(
        state.copyWith(
          locations: locations,
          regions: regions,
          statuses: statuses,
          commonFilters: commonFilters,
          hasReachedMax: false,
          status: FormStatus.initial,
        ),
      );
    } on Exception {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }

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
    } on Exception {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }

//   FutureOr<void> _fetchList(
//       FetchData event, Emitter<AnnualPowerShutdownListState> emit) async {
//     log('-_fetchMaterialMovements--');
//
//     emit(
//       state.copyWith(
//         status: FormStatus.loading,
//       ),
//     );
//
//     try {
//       // if (state.hasReachedMax) return;
//
//       if (state.status == FormStatus.initial || event.newSearch) {
//         log('-_fetchMaterialMovements--initial--');
//         AnnualPowerShutDownResponse response;
//         response = await _services.getAnnualPowerShutdownListWithFilters(
//           startPosition: '${event.startPos}',
//           maximumRecords: '${event.maxPos}',
//           filters: event.filters,
//         );
//
//         return emit(
//           state.copyWith(
//             items: response.items,
//             hasReachedMax: false,
//             status: FormStatus.success,
//           ),
//         );
//       }
//
//       log('-_fetchMaterialMovements------##--');
//       AnnualPowerShutDownResponse response;
//       response = await _services.getAnnualPowerShutdownListWithFilters(
//         startPosition: '${event.startPos}',
//         maximumRecords: '${event.maxPos}',
//         filters: event.filters,
//       );
//
//       if (response.items?.isEmpty == true) {
//         return emit(state.copyWith(hasReachedMax: true));
//       }
//       return emit(
//         state.copyWith(
//           items: List.of(state.items)..addAll(response.items ?? []),
//           hasReachedMax: false,
//           status: FormStatus.success,
//         ),
//       );
//     } on TokenExpiredException catch (e) {
//       emit(
//         state.copyWith(
//           message: e.message,
//           status: FormStatus.sessionExpired,
//         ),
//       );
//       return;
//     } catch (e) {
//       return emit(state.copyWith(status: FormStatus.failure));
//     }
//   }
// }
  FutureOr<void> _fetchList(
      FetchData event, Emitter<AnnualPowerShutdownListState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial) {
        AnnualPowerShutDownResponse response =
            await _services.getAnnualPowerShutdownListWithFilters(
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

      AnnualPowerShutDownResponse response =
          await _services.getAnnualPowerShutdownListWithFilters(
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
        ),
      );
    } catch (e) {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }
}
