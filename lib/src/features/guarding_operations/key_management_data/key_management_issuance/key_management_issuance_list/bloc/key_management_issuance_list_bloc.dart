import 'dart:async';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_issuance/services/key_management_issuance_services.dart';
import 'package:db_atom/src/services/CommonServices.dart';

part 'key_management_issuance_list_event.dart';

part 'key_management_issuance_list_state.dart';

class KeyManagementIssuanceListBloc extends Bloc<KeyManagementIssuanceListEvent,
    KeyManagementIssuanceListState> {
  KeyManagementIssuanceListBloc()
      : super(const KeyManagementIssuanceListState()) {
    on<InitializeValues>(_initializeValues);
    on<FetchKeyIssuanceList>(
      _fetchList,
      transformer: droppable(),
    );
  }

  final KeyManagementIssuanceServices _services =
      KeyManagementIssuanceServices();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(InitializeValues event,
      Emitter<KeyManagementIssuanceListState> emit) async {
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

  FutureOr<void> _fetchList(FetchKeyIssuanceList event,
      Emitter<KeyManagementIssuanceListState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial) {
        KeyManagementIssuanceResponseModel getKeyReconciliationLists =
            await _services.getList(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
        );
        return emit(
          state.copyWith(
            items: getKeyReconciliationLists.items,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );
      }

      KeyManagementIssuanceResponseModel getKeyReconciliationList =
          await _services.getList(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
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
