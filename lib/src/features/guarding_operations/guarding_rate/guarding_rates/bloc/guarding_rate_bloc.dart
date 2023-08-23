import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import '../../../../law_enforcement_list/controllers/law_enforcement_list_state.dart';
import '../../models/rates_response.dart';
import '../../services/guarding_services.dart';

part 'guarding_rate_event.dart';
part 'guarding_rate_state.dart';

class GuardingRateBloc extends Bloc<GuardingRateEvent, GuardingRateState> {

  GuardingRateBloc()
      : super(const GuardingRateState()) {
    on<FetchList>(
      _fetchList,
      transformer: droppable(),
    );
  }

  final GuardingServices _materialMovementServices =
  GuardingServices();

  FutureOr<void> _fetchList(
      FetchList event, Emitter<GuardingRateState> emit) async {
    try {
      if (state.hasReachedMax) return;

      log('----_fetchList----');

      if (state.status == LawEnforcementListStateType.initial) {
        RatesResponse getMaterialMovements =
        await _materialMovementServices.getRates(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          userId: '77',
        );

        log('-getMaterialMovements----1-----$getMaterialMovements----');

        return emit(
          state.copyWith(
            items: getMaterialMovements.items,
            hasReachedMax: false,
            status: LawEnforcementListStateType.success,
          ),
        );
      }
      log('----_fetchList--22--');

      RatesResponse getMaterialMovements =
      await _materialMovementServices.getRates(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
        userId: '77',   //TODO: make it dynamic
      );

      log('-getMaterialMovements----2-----$getMaterialMovements----');

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
