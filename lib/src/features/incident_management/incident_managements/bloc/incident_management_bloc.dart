import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import '../../../../enums/form_status.dart';
import '../models/incidents_response.dart';
import '../services/incident_management_services.dart';

part 'incident_management_event.dart';

part 'incident_management_state.dart';

class IncidentManagementsBloc
    extends Bloc<IncidentManagementsEvent, IncidentManagementsState> {
  IncidentManagementsBloc() : super(const IncidentManagementsState()) {
    on<InwardFetch>(
      _fetchList,
      transformer: droppable(),
    );
  }

  final IncidentServices _services = IncidentServices();

  FutureOr<void> _fetchList(
      InwardFetch event, Emitter<IncidentManagementsState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial) {
        IncidentsResponse response = await _services.getIncidents(
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

      IncidentsResponse response = await _services.getIncidents(
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
