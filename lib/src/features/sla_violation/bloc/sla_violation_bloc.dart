import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import '../../../enums/form_status.dart';
import '../../event_protection/models/event_protection_model.dart';
import '../../event_protection/services/event_protection_services.dart';

part 'sla_violation_event.dart';
part 'sla_violation_state.dart';

class SLAViolationBloc
    extends Bloc<SLAViolationEvent, SLAViolationState> {

  SLAViolationBloc()
      : super(const SLAViolationState()) {
    on<InwardFetch>(
      _fetchList,
      transformer: droppable(),
    );
  }

  final EventProtectionServices _services =
  EventProtectionServices();

  FutureOr<void> _fetchList(
      InwardFetch event, Emitter<SLAViolationState> emit) async {
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
