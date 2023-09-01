import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:db_atom/src/features/law_enforcement_list/controllers/law_enforcement_list_state.dart';
import 'package:db_atom/src/features/material_movement/models/material_movements_model.dart';
import 'package:db_atom/src/features/material_movement/services/material_movement_services.dart';
import 'package:equatable/equatable.dart';

part 'material_movement_event.dart';

part 'material_movement_state.dart';

class MaterialMovementBloc
    extends Bloc<MaterialMovementEvent, MaterialMovementState> {
  final bool isInward;

  MaterialMovementBloc({required this.isInward})
      : super(const MaterialMovementState()) {
    on<InwardFetch>(
      _fetchMaterialMovements,
      transformer: droppable(),
    );
  }

  final MaterialMovementServices _materialMovementServices =
      MaterialMovementServices();

  FutureOr<void> _fetchMaterialMovements(
      InwardFetch event, Emitter<MaterialMovementState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == LawEnforcementListStateType.initial) {
        MaterialMovementsModel response =
            await _materialMovementServices.getMaterialMovements(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          userId: '77',
          mmType: isInward ? 1 : 0,
        );

        return emit(
          state.copyWith(
            items: response.items,
            hasReachedMax: false,
            status: LawEnforcementListStateType.success,
          ),
        );
      }

      MaterialMovementsModel response =
          await _materialMovementServices.getMaterialMovements(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
        userId: '77', //TODO: make it dynamic
        mmType: isInward ? 1 : 0,
      );

      if (response.items?.isEmpty == true) {
        return emit(state.copyWith(hasReachedMax: true));
      }
      return emit(
        state.copyWith(
          items: List.of(state.items)..addAll(response.items ?? []),
          hasReachedMax: false,
        ),
      );
    } catch (e) {
      return emit(state.copyWith(status: LawEnforcementListStateType.failure));
    }
  }
}
