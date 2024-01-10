import 'dart:async';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_loss_destruction_list/models/key_loss_destruction_list_model.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_loss_destruction_list/services/key_loss_destruction_list_services.dart';
import 'package:db_atom/src/services/common_services.dart';

part 'key_loss_destruction_list_event.dart';
part 'key_loss_destruction_list_state.dart';

class KeyLossDestructionListBloc
    extends Bloc<KeyLossDestructionListEvent, KeyLossDestructionListState> {
  KeyLossDestructionListBloc() : super(const KeyLossDestructionListState()) {
    on<InitializeValues>(_initializeValues);
    on<FetchKeyLossList>(
      _fetchList,
      transformer: droppable(),
    );
  }

  final KeyLossDestructionListServices _services = KeyLossDestructionListServices();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(InitializeValues event,
      Emitter<KeyLossDestructionListState> emit) async {
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
      FetchKeyLossList event, Emitter<KeyLossDestructionListState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial) {
        KeyLossDestructionListResponse getKeyLossDestructionLists =
        await _services.getList(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',

        );
        return emit(
          state.copyWith(
            items: getKeyLossDestructionLists.items,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );
      }

      KeyLossDestructionListResponse getKeyLossDestructionList =
      await _services.getList(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',

      );

      if (getKeyLossDestructionList.items?.isEmpty == true) {
        return emit(state.copyWith(hasReachedMax: true));
      }
      return emit(
        state.copyWith(
          items: List.of(state.list)
            ..addAll(getKeyLossDestructionList.items?.toList() ?? []),
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
