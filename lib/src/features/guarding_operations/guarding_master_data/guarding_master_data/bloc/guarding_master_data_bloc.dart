import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:db_atom/src/features/law_enforcement_list/controllers/law_enforcement_list_state.dart';
import 'package:equatable/equatable.dart';

import '../../models/guarding_master_data_model.dart';
import '../../services/guarding_master_data_services.dart';

part 'guarding_master_data_event.dart';

part 'guarding_master_data_state.dart';

class GuardingMasterDataBloc
    extends Bloc<GuardingMasterDataEvent, GuardingMasterDataState> {
  GuardingMasterDataBloc() : super(const GuardingMasterDataState()) {
    on<FetchDataList>(
      _fetchList,
      transformer: droppable(),
    );
  }

  final GuardingMasterDataServices _services = GuardingMasterDataServices();

  FutureOr<void> _fetchList(
      FetchDataList event, Emitter<GuardingMasterDataState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == LawEnforcementListStateType.initial) {
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
            status: LawEnforcementListStateType.success,
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

      if (getGuardingMasterData.items.isEmpty == true) {
        return emit(state.copyWith(hasReachedMax: true));
      }
      return emit(
        state.copyWith(
          items: List.of(state.list)
            ..addAll(getGuardingMasterData.items),
          hasReachedMax: false,
        ),
      );
    } catch (e) {
      return emit(state.copyWith(status: LawEnforcementListStateType.failure));
    }
  }
}
