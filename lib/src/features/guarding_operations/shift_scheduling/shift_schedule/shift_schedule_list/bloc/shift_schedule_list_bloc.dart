import 'dart:async';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/models/ss_ui_labels.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/services/shift_schedule_services.dart';
import 'package:db_atom/src/services/common_services.dart';

import '../../../../../../utils/utils_common.dart';

part 'shift_schedule_list_event.dart';
part 'shift_schedule_list_state.dart';

class ShiftScheduleListBloc
    extends Bloc<ShiftScheduleListEvent, ShiftScheduleListState> {
  ShiftScheduleListBloc() : super(const ShiftScheduleListState()) {
    on<InitializeValues>(_initializeValues);
    on<FetchShiftScheduleList>(
      _fetchList,
      transformer: droppable(),
    );
    on<RefreshList>(
      _refreshList,
      transformer: droppable(),
    );
  }

  final ShiftScheduleServices _services = ShiftScheduleServices();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeValues event, Emitter<ShiftScheduleListState> emit) async {
    try {
      emit(state.copyWith(status: FormStatus.loading));
      List<Organisation> statuses = await commonServices.getStatusesByModuleId(
          module: Constants.shiftScheduleModuleCode);

      List<Organisation> regions =
          await commonServices.getRegionsOrLocationsByRegionId();

      CommonFilters commonFilters =
          CommonFilters(regions: regions, statuses: statuses);

      Locations locations =
          await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');

      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(),
          moduleCode: Constants.shiftScheduleModuleCode);

      ExtraProperties extraProperties =
      await UtilsCommon().checkWritePermission(
        moduleCode: Constants.shiftScheduleModuleCode,
        commonServices: commonServices,
      );
      SSUiLabels labels = SSUiLabels.fromJson(responseLabels);
      return emit(
        state.copyWith(
          locations: locations,
          regions: regions,
          labels: labels,
          statuses: statuses,
          commonFilters: commonFilters,
          hasReachedMax: false,
          status: FormStatus.initial,
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

  FutureOr<void> _refreshList(
      RefreshList event, Emitter<ShiftScheduleListState> emit) async {
    try {
      ShiftScheduleResponse response;

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
    } on Exception catch (e) {
      return UtilsCommon().exceptionHandling(e, emit, state);
    }
  }

//   FutureOr<void> _fetchList(FetchShiftScheduleList event,
//       Emitter<ShiftScheduleListState> emit) async {
//     try {
//       if (state.hasReachedMax) return;
//
//       if (state.status == FormStatus.initial) {
//         ShiftScheduleResponse getShiftSchedules = await _services.getList(
//           startPosition: '${event.startPos}',
//           maximumRecords: '${event.maxPos}',
//           filters: BaseFilterModel(),
//         );
//         return emit(
//           state.copyWith(
//             items: getShiftSchedules.items,
//             hasReachedMax: false,
//             status: FormStatus.success,
//           ),
//         );
//       }
//
//       ShiftScheduleResponse getShiftSchedule = await _services.getList(
//         startPosition: '${event.startPos}',
//         maximumRecords: '${event.maxPos}',
//         filters: event.filters
//       );
//
//       if (getShiftSchedule.items?.isEmpty == true) {
//         return emit(state.copyWith(hasReachedMax: true));
//       }
//       return emit(
//         state.copyWith(
//           items: List.of(state.items)
//             ..addAll(getShiftSchedule.items?.toList() ?? []),
//           hasReachedMax: false,
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
  FutureOr<void> _fetchList(FetchShiftScheduleList event,
      Emitter<ShiftScheduleListState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    try {
      // if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial || event.newSearch) {
        ShiftScheduleResponse response;
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

      ShiftScheduleResponse response;
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
