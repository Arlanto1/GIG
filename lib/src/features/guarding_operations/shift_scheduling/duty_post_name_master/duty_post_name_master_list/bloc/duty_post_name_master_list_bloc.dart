import 'dart:async';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_name_master/services/duty_post_name_master_services.dart';
import 'package:db_atom/src/services/common_services.dart';

part 'duty_post_name_master_list_event.dart';
part 'duty_post_name_master_list_state.dart';

class DutyPostNameMasterListBloc
    extends Bloc<DutyPostNameMasterListEvent, DutyPostNameMasterListState> {
  DutyPostNameMasterListBloc() : super(const DutyPostNameMasterListState()) {
    on<InitializeValues>(_initializeValues);
    on<FetchDutyPostNameMasterList>(
      _fetchList,
      transformer: droppable(),
    );
  }

  final DutyPostNameMasterServices _services = DutyPostNameMasterServices();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeValues event, Emitter<DutyPostNameMasterListState> emit) async {
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

  FutureOr<void> _fetchList(FetchDutyPostNameMasterList event,
      Emitter<DutyPostNameMasterListState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial) {
        DutyPostNameMasterResponse getDutyNamePostMasters =
            await _services.getList(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
        );
        return emit(
          state.copyWith(
            items: getDutyNamePostMasters.items,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );
      }

      DutyPostNameMasterResponse getDutyNamePostMaster =
          await _services.getList(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
      );

      if (getDutyNamePostMaster.items?.isEmpty == true) {
        return emit(state.copyWith(hasReachedMax: true));
      }
      return emit(
        state.copyWith(
          items: List.of(state.list)
            ..addAll(getDutyNamePostMaster.items?.toList() ?? []),
          hasReachedMax: false,
        ),
      );
    }
    // on TokenExpiredException catch (e) {
    //   emit(
    //     state.copyWith(
    //       message: e.message,
    //       status: FormStatus.sessionExpired,
    //     ),
    //   );
    //   return;
    // }
    catch (e) {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }
}
