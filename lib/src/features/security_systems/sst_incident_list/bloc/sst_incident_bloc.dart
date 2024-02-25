import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import '../../../../enums/form_status.dart';
import '../../models/sst_incident_response.dart';
import '../../services/sst_incident_services.dart';

part 'sst_incident_event.dart';

part 'sst_incident_state.dart';

class SstIncidentBloc extends Bloc<SstIncidentEvent, SstIncidentState> {
  final int ticketType;
  final int staffType;
  final String? occId;

  SstIncidentBloc(
      {required this.ticketType, required this.staffType, this.occId})
      : super(const SstIncidentState()) {
    on<FetchData>(
      _fetchList,
      transformer: droppable(),
    );
    on<RefreshList>(
      _refreshList,
      transformer: droppable(),
    );
  }

  final SstIncidentServices _services = SstIncidentServices();

  FutureOr<void> _refreshList(
      RefreshList event, Emitter<SstIncidentState> emit) async {
    try {
      SstIncidentResponse response;

      response = await _services.get(
        startPosition: '${0}',
        maximumRecords: '${20}',
        userId: '77',
        ticketType: ticketType,
        staffType: staffType,
        occId: occId,
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
      FetchData event, Emitter<SstIncidentState> emit) async {
    try {
      if (state.hasReachedMax) return;

      log('-bloc-occId-$occId----');
      if (state.status == FormStatus.initial) {
        SstIncidentResponse response = await _services.get(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          userId: '77',
          ticketType: ticketType,
          staffType: staffType,
          occId: occId,
        );

        return emit(
          state.copyWith(
            items: response.items,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );
      }

      SstIncidentResponse response = await _services.get(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
        userId: '77',
        ticketType: ticketType,
        staffType: staffType,
        occId: occId,
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
