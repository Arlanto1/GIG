import 'dart:async';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_name_master/models/dpn_ui_labels.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_name_master/services/duty_post_name_master_services.dart';
import 'package:db_atom/src/services/common_services.dart';

part 'duty_post_name_master_list_event.dart';

part 'duty_post_name_master_list_state.dart';

class DutyPostNameMasterListBloc
    extends Bloc<DutyPostNameMasterListEvent, DutyPostNameMasterListState> {
  DutyPostNameMasterListBloc() : super(const DutyPostNameMasterListState()) {
    on<InitializeValue>(_initializeValues);
    on<FetchDutyPostNameMasterList>(
      _fetchList,
      transformer: droppable(),
    );
    on<RefreshDPNList>(
      _refreshList,
      transformer: droppable(),
    );
  }

  final DutyPostNameMasterServices _services = DutyPostNameMasterServices();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeValue event, Emitter<DutyPostNameMasterListState> emit) async {
    try {
      emit(state.copyWith(status: FormStatus.loading));
      List<Organisation> statuses = await commonServices.getStatusesByModuleId(
          module: Constants.dutyPostNameMasterModuleCode);

      List<Organisation> regions =
          await commonServices.getRegionsOrLocationsByRegionId();

      CommonFilters commonFilters =
          CommonFilters(regions: regions, statuses: statuses);

      Locations locations =
          await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');

      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(),
          moduleCode: Constants.dutyPostNameMasterModuleCode);
      DPNUiLabels labels = DPNUiLabels.fromJson(responseLabels);
      return emit(
        state.copyWith(
          labels: labels,
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
      RefreshDPNList event, Emitter<DutyPostNameMasterListState> emit) async {
    try {
      DutyPostNameMasterResponse response;

      response = await _services.getList(
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

  // FutureOr<void> _fetchList(FetchDutyPostNameMasterList event,
  //     Emitter<DutyPostNameMasterListState> emit) async {
  //   try {
  //     if (state.hasReachedMax) return;
  //
  //     if (state.status == FormStatus.initial) {
  //       DutyPostNameMasterResponse getDutyNamePostMasters =
  //           await _services.getList(
  //         startPosition: '${event.startPos}',
  //         maximumRecords: '${event.maxPos}',
  //       );
  //       return emit(
  //         state.copyWith(
  //           items: getDutyNamePostMasters.items,
  //           hasReachedMax: false,
  //           status: FormStatus.success,
  //         ),
  //       );
  //     }
  //
  //     DutyPostNameMasterResponse getDutyNamePostMaster =
  //         await _services.getList(
  //       startPosition: '${event.startPos}',
  //       maximumRecords: '${event.maxPos}',
  //     );
  //
  //     if (getDutyNamePostMaster.items?.isEmpty == true) {
  //       return emit(state.copyWith(hasReachedMax: true));
  //     }
  //     return emit(
  //       state.copyWith(
  //         items: List.of(state.list)
  //           ..addAll(getDutyNamePostMaster.items?.toList() ?? []),
  //         hasReachedMax: false,
  //       ),
  //     );
  //   }
  //   // on TokenExpiredException catch (e) {
  //   //   emit(
  //   //     state.copyWith(
  //   //       message: e.message,
  //   //       status: FormStatus.sessionExpired,
  //   //     ),
  //   //   );
  //   //   return;
  //   // }
  //   catch (e) {
  //     return emit(state.copyWith(status: FormStatus.failure));
  //   }
  // }
  FutureOr<void> _fetchList(FetchDutyPostNameMasterList event,
      Emitter<DutyPostNameMasterListState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    try {
      // if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial || event.newSearch) {
        DutyPostNameMasterResponse response;
        response = await _services.getList(
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

      DutyPostNameMasterResponse response;
      response = await _services.getList(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
        filters: event.filters,
      );

      if (response.items?.isEmpty == true) {
        return emit(state.copyWith(hasReachedMax: true));
      }
      return emit(
        state.copyWith(
          items: List.of(state.list)..addAll(response.items ?? []),
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
