import 'dart:async';
import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/services/key_management_master_services.dart';
import 'package:db_atom/src/services/common_services.dart';

part 'key_management_master_list_event.dart';
part 'key_management_master_list_state.dart';

class KeyManagementMasterListBloc
    extends Bloc<KeyManagementMasterListEvent, KeyManagementMasterListState> {
  KeyManagementMasterListBloc() : super(const KeyManagementMasterListState()) {
    on<InitializeValues>(_initializeValues);
    on<FetchKeyMasterList>(
      _fetchList,
      transformer: droppable(),
    );
  }

  final KeyManagementMasterServices _services = KeyManagementMasterServices();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(InitializeValues event,
      Emitter<KeyManagementMasterListState> emit) async {
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
      FetchKeyMasterList event, Emitter<KeyManagementMasterListState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial) {
        KeyManagementMasterResponse getKeyManagementMasters =
            await _services.getList(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
        );
        log('--getKeyManagementMasters----${getKeyManagementMasters.items?.length}-');
        return emit(
          state.copyWith(
            items: getKeyManagementMasters.items,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );
      }

      KeyManagementMasterResponse getKeyManagementMaster =
          await _services.getList(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
      );

      if (getKeyManagementMaster.items?.isEmpty == true) {
        return emit(state.copyWith(hasReachedMax: true));
      }
      return emit(
        state.copyWith(
          items: List.of(state.list)
            ..addAll(getKeyManagementMaster.items?.toList() ?? []),
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
