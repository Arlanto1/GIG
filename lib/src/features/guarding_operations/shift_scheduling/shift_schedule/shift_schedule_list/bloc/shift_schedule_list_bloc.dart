import 'dart:async';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/services/shift_schedule_services.dart';
import 'package:db_atom/src/services/common_services.dart';

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
  }

  final ShiftScheduleServices _services = ShiftScheduleServices();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeValues event, Emitter<ShiftScheduleListState> emit) async {
    try {
      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(),
          moduleCode: Constants.guardingMasterModuleCode);
      // GmUiLabels labels = GmUiLabels.fromJson(responseLabels);
      return emit(
        state.copyWith(
          //labels: labels,
          hasReachedMax: false,
        ),
      );
    } on Exception {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }

  FutureOr<void> _fetchList(FetchShiftScheduleList event,
      Emitter<ShiftScheduleListState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial) {
        ShiftScheduleResponse getShiftSchedules = await _services.getList(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
        );
        return emit(
          state.copyWith(
            items: getShiftSchedules.items,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );
      }

      ShiftScheduleResponse getShiftSchedule = await _services.getList(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
      );

      if (getShiftSchedule.items?.isEmpty == true) {
        return emit(state.copyWith(hasReachedMax: true));
      }
      return emit(
        state.copyWith(
          items: List.of(state.items)
            ..addAll(getShiftSchedule.items?.toList() ?? []),
          hasReachedMax: false,
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
