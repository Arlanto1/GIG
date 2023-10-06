import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import '../../event_protection/models/event_protection_model.dart';
import '../../event_protection/services/event_protection_services.dart';
import '../../law_enforcement_list/controllers/law_enforcement_list_state.dart';


part 'incident_management_event.dart';
part 'incident_management_state.dart';

class IncidentManagementsBloc
    extends Bloc<IncidentManagementsEvent, IncidentManagementsState> {

  IncidentManagementsBloc()
      : super(const IncidentManagementsState()) {
    on<InwardFetch>(
      _fetchList,
      transformer: droppable(),
    );
  }

  final EventProtectionServices _services =
  EventProtectionServices();

  FutureOr<void> _fetchList(
      InwardFetch event, Emitter<IncidentManagementsState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == LawEnforcementListStateType.initial) {
        EventProtectionResponse response =
        await _services.getEventProtections(
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

      EventProtectionResponse response =
      await _services.getEventProtections(
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
