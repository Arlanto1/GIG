import 'dart:async';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_reconciliation_list/models/key_reconciliation_list_model.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_reconciliation_list/services/key_reconciliation_list_services.dart';
import 'package:db_atom/src/services/common_services.dart';

part 'key_reconciliation_list_event.dart';
part 'key_reconciliation_list_state.dart';

class KeyReconciliationListBloc
    extends Bloc<KeyReconciliationListEvent, KeyReconciliationListState> {
  KeyReconciliationListBloc() : super(const KeyReconciliationListState()) {
    on<InitializeValues>(_initializeValues);
    on<FetchKeyReconciliationList>(
      _fetchList,
      transformer: droppable(),
    );
  }

  final KeyReconciliationListServices _services =
      KeyReconciliationListServices();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeValues event, Emitter<KeyReconciliationListState> emit) async {
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

  FutureOr<void> _fetchList(FetchKeyReconciliationList event,
      Emitter<KeyReconciliationListState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial) {
        KeyReconciliationListResponse getKeyReconciliationLists =
            await _services.getList(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          userId: '7',
          locationId: '56',
        );
        return emit(
          state.copyWith(
            items: getKeyReconciliationLists.items,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );
      }

      KeyReconciliationListResponse getKeyReconciliationList =
          await _services.getList(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
        userId: '7',
        locationId: '56',
      );

      if (getKeyReconciliationList.items?.isEmpty == true) {
        return emit(state.copyWith(hasReachedMax: true));
      }
      return emit(
        state.copyWith(
          items: List.of(state.list)
            ..addAll(getKeyReconciliationList.items?.toList() ?? []),
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
