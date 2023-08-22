import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../law_enforcement_list/controllers/law_enforcement_list_state.dart';
import '../../../models/rates_response.dart';
import '../../../services/guarding_services.dart';

part 'pay_rate_event.dart';
part 'pay_rate_state.dart';

class PayRateBloc extends Bloc<PayRateEvent, PayRateState> {
  PayRateBloc()
      : super(const PayRateState()) {
    on<FetchList>(
      _fetchMaterialMovements,
      transformer: droppable(),
    );
  }

  final GuardingServices _materialMovementServices =
  GuardingServices();

  FutureOr<void> _fetchMaterialMovements(
      FetchList event, Emitter<PayRateState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == LawEnforcementListStateType.initial) {
        RatesResponse getMaterialMovements =
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

      RatesResponse getMaterialMovements =
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
