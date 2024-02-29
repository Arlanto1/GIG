import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:db_atom/src/enums/form_status.dart';
import 'package:equatable/equatable.dart';

import '../models/occurrence_response.dart';
import '../services/occurrences_services.dart';

part 'occurrences_event.dart';
part 'occurrences_state.dart';

class OccurrencesBloc extends Bloc<OccurrencesEvent, OccurrencesState> {
  OccurrencesBloc() : super(const OccurrencesState()) {
    on<FetchData>(
      _fetchList,
      transformer: droppable(),
    );
    on<RefreshList>(
      _refreshList,
      transformer: droppable(),
    );
  }

  final OccurrenceServices _services = OccurrenceServices();

  FutureOr<void> _refreshList(
      RefreshList event, Emitter<OccurrencesState> emit) async {
    try {
      OccurrenceResponse response;

      response = await _services.getIncidents(
        startPosition: '${0}',
        maximumRecords: '${20}',
        userId: '7',
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
      FetchData event, Emitter<OccurrencesState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial) {
        OccurrenceResponse response = await _services.getIncidents(
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

      OccurrenceResponse response = await _services.getIncidents(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
        userId: '77',
      );

      if (response.items?.isEmpty == true) {
        return emit(state.copyWith(hasReachedMax: true));
      }
      return emit(
        state.copyWith(
          items: List.of(state.list)..addAll(response.items ?? []),
          hasReachedMax: false,
        ),
      );
    } catch (e) {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }
}
