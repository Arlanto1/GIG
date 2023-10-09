import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import '../../../../../enums/form_status.dart';
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
            ..addAll(getGuardingMasterData.items?.toList()??[]),
          hasReachedMax: false,
        ),
      );
    } catch (e) {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }
}
