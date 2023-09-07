import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import '../../../law_enforcement_list/controllers/law_enforcement_list_state.dart';
import '../../../material_movement/models/material_movements_model.dart';
import '../../../material_movement/services/material_movement_services.dart';

part 'event_protections_event.dart';
part 'event_protections_state.dart';

class EventProtectionsBloc
    extends Bloc<EventProtectionsEvent, EventProtectionsState> {

  EventProtectionsBloc()
      : super(const EventProtectionsState()) {
    on<InwardFetch>(
      _fetchMaterialMovements,
      transformer: droppable(),
    );
  }

  final MaterialMovementServices _materialMovementServices =
  MaterialMovementServices();

  FutureOr<void> _fetchMaterialMovements(
      InwardFetch event, Emitter<EventProtectionsState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == LawEnforcementListStateType.initial) {
        MaterialMovementsModel response =
        await _materialMovementServices.getMaterialMovements(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          userId: '77',
          mmType: 0,
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
        mmType: 0,
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
