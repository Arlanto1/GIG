import 'dart:async';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_master_data/models/gm_ui_labels.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_master_data/services/guarding_master_data_services.dart';
import 'package:db_atom/src/services/CommonServices.dart';

part 'guarding_master_data_event.dart';
part 'guarding_master_data_state.dart';

class GuardingMasterDataBloc
    extends Bloc<GuardingMasterDataEvent, GuardingMasterDataState> {
  GuardingMasterDataBloc() : super(const GuardingMasterDataState()) {
    on<InitializeValues>(_initializeValues);
    on<FetchDataList>(
      _fetchList,
      transformer: droppable(),
    );
  }

  final GuardingMasterDataServices _services = GuardingMasterDataServices();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeValues event, Emitter<GuardingMasterDataState> emit) async {
    try {
      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(), moduleCode: Constants.guardingMasterModuleCode);
      GmUiLabels labels = GmUiLabels.fromJson(responseLabels);
      return emit(
        state.copyWith(
          labels: labels,
          hasReachedMax: false,
        ),
      );
    } on Exception {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }

  FutureOr<void> _fetchList(
      FetchDataList event, Emitter<GuardingMasterDataState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial) {
        GuardingMasterDataResponse getGuardingMaterialDatas =
            await _services.getGuardingMasterData(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          userId: '7',
          locationId: '56',
        );
        return emit(
          state.copyWith(
            items: getGuardingMaterialDatas.items,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );
      }

      GuardingMasterDataResponse getGuardingMasterData =
          await _services.getGuardingMasterData(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
        userId: '7',
        locationId: '56',
      );

      if (getGuardingMasterData.items?.isEmpty == true) {
        return emit(state.copyWith(hasReachedMax: true));
      }
      return emit(
        state.copyWith(
          items: List.of(state.list)
            ..addAll(getGuardingMasterData.items?.toList() ?? []),
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
