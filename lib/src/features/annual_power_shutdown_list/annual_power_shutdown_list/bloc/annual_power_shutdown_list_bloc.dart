import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:db_atom/src/features/annual_power_shutdown_list/annual_power_shutdown_list/models/annual_power_shutdown_model.dart';
import 'package:equatable/equatable.dart';

import '../../../../enums/form_status.dart';
import '../../services/annual_power_shutdown_services.dart';

part 'annual_power_shutdown_list_event.dart';

part 'annual_power_shutdown_list_state.dart';

class AnnualPowerShutdownListBloc
    extends Bloc<AnnualPowerShutdownListEvent, AnnualPowerShutdownListState> {
  AnnualPowerShutdownListBloc() : super(const AnnualPowerShutdownListState()) {
    on<FetchData>(
      _fetchList,
      transformer: droppable(),
    );
  }

  final AnnualPowerShutdownListServices _services =
      AnnualPowerShutdownListServices();

  FutureOr<void> _fetchList(
      FetchData event, Emitter<AnnualPowerShutdownListState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial) {
        AnnualPowerShutDownResponse response =
            await _services.getAnnualPowerShutdownList(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          userId: '77',
        );

        return emit(
          state.copyWith(
            items: response.items,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );
      }

      AnnualPowerShutDownResponse response =
          await _services.getAnnualPowerShutdownList(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
        userId: '77',
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
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }
}
