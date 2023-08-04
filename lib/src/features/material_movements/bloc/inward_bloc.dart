import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import '../../../../main_DEV.dart';
import '../../law_enforcement_list/controllers/law_enforcement_list_state.dart';
import '../../law_enforcement_list/models/law_enforcement_list_response.dart';
import '../models/material_movements_model.dart';
import '../services/material_movement_services.dart';

part 'inward_event.dart';
part 'inward_state.dart';

class InwardBloc extends Bloc<InwardEvent, InwardState> {
  InwardBloc() : super(const InwardState()) {
    on<InwardFetch>(
      _fetchMaterialMovements,
      transformer: droppable(),
    );
  }

  final MaterialMovementServices _materialMovementServices = MaterialMovementServices();

  FutureOr<void> _fetchMaterialMovements(
      InwardFetch event, Emitter<InwardState> emit) async {
    try {
      if (state.hasReachedMax) return;

      log('state.status------------${state.status}');

      if (state.status == LawEnforcementListStateType.initial) {
        MaterialMovementsModel getMaterialMovements =
            await _materialMovementServices.getMaterialMovements(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          userId: '77',
          mmType: 0,
        );


        log('state.sitems?.lengt--------${getMaterialMovements.items?.length}');


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
        userId: '77',
        mmType: 0,
      );
      if (getMaterialMovements.items?.isEmpty == true) {
        return emit(state.copyWith(hasReachedMax: true));
      }
      return emit(
        state.copyWith(
          items: List.of(state.items)
            ..addAll(getMaterialMovements.items ?? []),
          hasReachedMax: false,
        ),
      );
    } catch (e) {
      //debugPrint("[HATA] [TodoBloc] [_onTodoFetch] --> $e");
      return emit(state.copyWith(status: LawEnforcementListStateType.failure));
    }
  }
}
