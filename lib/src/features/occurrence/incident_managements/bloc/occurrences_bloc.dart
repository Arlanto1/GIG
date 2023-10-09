import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import '../../../law_enforcement_list/controllers/law_enforcement_list_state.dart';
import '../models/incidents_response.dart';
import '../services/occurrences_services.dart';

part 'occurrences_event.dart';
part 'occurrences_state.dart';

class OccurrencesBloc
    extends Bloc<OccurrencesEvent, OccurrencesState> {

  OccurrencesBloc()
      : super(const OccurrencesState()) {
    on<InwardFetch>(
      _fetchList,
      transformer: droppable(),
    );
  }

  final IncidentServices _services =
  IncidentServices();

  FutureOr<void> _fetchList(
      InwardFetch event, Emitter<OccurrencesState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == LawEnforcementListStateType.initial) {
        IncidentsResponse response =
        await _services.getIncidents(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          userId: '77',
        );

        return emit(
          state.copyWith(
            items: response.items,
            hasReachedMax: false,
            status: LawEnforcementListStateType.success,
          ),
        );
      }

      IncidentsResponse response =
      await _services.getIncidents(
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
      return emit(state.copyWith(status: LawEnforcementListStateType.failure));
    }
  }
}
