import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import '../../../../enums/form_status.dart';
import '../../models/event_protection_model.dart';
import '../../services/event_protection_services.dart';

part 'event_protections_event.dart';
part 'event_protections_state.dart';

class EventProtectionsBloc
    extends Bloc<EventProtectionsEvent, EventProtectionsState> {

  EventProtectionsBloc()
      : super(const EventProtectionsState()) {
    on<FetchData>(
      _fetchList,
      transformer: droppable(),
    );
  }

  final EventProtectionServices _services =
  EventProtectionServices();

  FutureOr<void> _fetchList(
      FetchData event, Emitter<EventProtectionsState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial) {
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
            status: FormStatus.success,
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
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }
}
