import 'dart:async';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_master/models/duty_post_master_model.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_master/services/duty_post_master_services.dart';
import 'package:db_atom/src/services/common_services.dart';

part 'duty_post_master_list_event.dart';
part 'duty_post_master_list_state.dart';

class DutyPostMasterListBloc
    extends Bloc<DutyPostMasterListEvent, DutyPostMasterListState> {
  DutyPostMasterListBloc() : super(const DutyPostMasterListState()) {
    on<InitializeValues>(_initializeValues);
    on<FetchDutyPostMasterList>(
      _fetchList,
      transformer: droppable(),
    );
  }

  final DutyPostMasterServices _services = DutyPostMasterServices();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(InitializeValues event,
      Emitter<DutyPostMasterListState> emit) async {
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

  FutureOr<void> _fetchList(
      FetchDutyPostMasterList event, Emitter<DutyPostMasterListState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial) {
        DutyPostMasterResponse getDutyPostMasters =
        await _services.getList(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          userId: '7',
          locationId: '56',
        );
        return emit(
          state.copyWith(
            items: getDutyPostMasters.items,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );
      }

      DutyPostMasterResponse getDutyPostMaster =
      await _services.getList(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
        userId: '7',
        locationId: '56',
      );

      if (getDutyPostMaster.items?.isEmpty == true) {
        return emit(state.copyWith(hasReachedMax: true));
      }
      return emit(
        state.copyWith(
          items: List.of(state.list)
            ..addAll(getDutyPostMaster.items?.toList() ?? []),
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
