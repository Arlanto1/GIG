import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import '../../../../enums/form_status.dart';
import '../../models/incidents_response.dart';
import '../../services/incident_management_services.dart';

part 'incident_management_event.dart';

part 'incident_management_state.dart';

class IncidentManagementsBloc
    extends Bloc<IncidentManagementsEvent, IncidentManagementsState> {
  final String? occId;
  final int? occType;

  IncidentManagementsBloc(this.occType, this.occId,)
      : super(const IncidentManagementsState()) {
    on<FetchData>(
      _fetchList,
      transformer: droppable(),
    );
  }

  final IncidentManagementServices _services = IncidentManagementServices();

  FutureOr<void> _fetchList(
      FetchData event, Emitter<IncidentManagementsState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial) {
        IncidentsResponse response = await _services.getIncidents(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          userId: '7',
          occId: occId,
          occType: occType,
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
        userId: '7',
        occId: occId,
        occType: occType,
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
