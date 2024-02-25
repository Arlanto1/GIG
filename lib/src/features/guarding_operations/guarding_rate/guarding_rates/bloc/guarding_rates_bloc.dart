import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import '../../../../../enums/form_status.dart';
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
    on<RefreshList>(
      _refreshList,
      transformer: droppable(),
    );
  }

  final GuardingServices _services = GuardingServices();

  FutureOr<void> _refreshList(
      RefreshList event, Emitter<GuardingRatesState> emit) async {
    try {
      RatesResponse response;

      response = await _services.getRates(
        startPosition: '${0}',
        maximumRecords: '${20}',
        userId: '77',
        // filters: BaseFilterModel(),
      );

      return emit(
        state.copyWith(
          items: response.items,
          hasReachedMax: false,
          status: FormStatus.success,
        ),
      );
    } on Exception {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }

  FutureOr<void> _fetchList(
      FetchList event, Emitter<GuardingRatesState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial) {
        RatesResponse response = await _services.getRates(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          userId: '77',
        );

        return emit(
          state.copyWith(
            items: response.items,
            hasReachedMax: response.items!.length < event.maxPos ? true : false,
            status: FormStatus.success,
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
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }
}
