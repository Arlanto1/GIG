import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import '../../../../enums/form_status.dart';
import '../../../event_protection/models/event_protection_model.dart';
import '../../../incident_management/incident_managements/models/incidents_response.dart';
import '../../models/general_info_model.dart';
import '../../services/sst_incident_services.dart';

part 'sst_incident_event.dart';
part 'sst_incident_state.dart';

class SstIncidentBloc
    extends Bloc<SstIncidentEvent, SstIncidentState> {

  SstIncidentBloc()
      : super(const SstIncidentState()) {
    on<FetchData>(
      _fetchList,
      transformer: droppable(),
    );
  }

  final SstIncidentServices _services =
  SstIncidentServices();

  FutureOr<void> _fetchList(
      FetchData event, Emitter<SstIncidentState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial) {
        SstIncidentResponse response =
        await _services.get(
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

      SstIncidentResponse response =
      await _services.get(
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
