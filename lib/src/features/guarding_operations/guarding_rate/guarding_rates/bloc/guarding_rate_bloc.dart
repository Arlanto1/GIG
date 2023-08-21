import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import '../../../../law_enforcement_list/controllers/law_enforcement_list_state.dart';
import '../../../../material_movement/models/material_movements_model.dart';
import '../../../../material_movement/services/material_movement_services.dart';

part 'guarding_rate_event.dart';
part 'guarding_rate_state.dart';

class GuardingRateBloc extends Bloc<GuardingRateEvent, GuardingRateState> {

  GuardingRateBloc()
      : super(const GuardingRateState()) {
    on<FetchList>(
      _fetchMaterialMovements,
      transformer: droppable(),
    );
  }

  final MaterialMovementServices _materialMovementServices =
  MaterialMovementServices();

  FutureOr<void> _fetchMaterialMovements(
      FetchList event, Emitter<GuardingRateState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == LawEnforcementListStateType.initial) {
        MaterialMovementsModel getMaterialMovements =
        await _materialMovementServices.getMaterialMovements(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          userId: '77',
          mmType: 1,
        );

        return emit(
          state.copyWith(
            items: getMaterialMovements.items,
            hasReachedMax: false,
            status: LawEnforcementListStateType.success,
          ),
        );
      }

      MaterialMovementsModel getMaterialMovements =
      await _materialMovementServices.getMaterialMovements(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
        userId: '77',   //TODO: make it dynamic
        mmType: 1,
      );

      if (getMaterialMovements.items?.isEmpty == true) {
        return emit(state.copyWith(hasReachedMax: true));
      }
      return emit(
        state.copyWith(
          items: List.of(state.items)..addAll(getMaterialMovements.items ?? []),
          hasReachedMax: false,
        ),
      );
    } catch (e) {
      return emit(state.copyWith(status: LawEnforcementListStateType.failure));
    }
  }
}
