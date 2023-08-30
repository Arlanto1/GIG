import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import '../../../../law_enforcement_list/controllers/law_enforcement_list_state.dart';
import '../../models/rates_response.dart';
import '../../services/guarding_services.dart';

part 'guarding_rates_event.dart';

part 'guarding_rates_state.dart';

class GuardingRatesBloc extends Bloc<GuardingRatesEvent, GuardingRatesState> {
  GuardingRatesBloc() : super(const GuardingRatesState()) {
    on<FetchList>(
      _fetchList,
      transformer: droppable(),
    );
  }

  final GuardingServices _services = GuardingServices();

  FutureOr<void> _fetchList(
      FetchList event, Emitter<GuardingRatesState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == LawEnforcementListStateType.initial) {
        RatesResponse response = await _services.getRates(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          userId: '77',
        );

        return emit(
          state.copyWith(
            items: response.items,
            hasReachedMax: response.items!.length < event.maxPos ? true : false,
            status: LawEnforcementListStateType.success,
          ),
        );
      }

      RatesResponse response = await _services.getRates(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
        userId: '77', //TODO: make it dynamic
      );

      log('-response----2-----$response----');

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
