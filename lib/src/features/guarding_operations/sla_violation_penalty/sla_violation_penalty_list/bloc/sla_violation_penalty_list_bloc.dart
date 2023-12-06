import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:db_atom/src/features/guarding_operations/sla_violation_penalty/models/sla_ui_labels.dart';
import 'package:equatable/equatable.dart';

import '../../../../../enums/form_status.dart';
import '../../models/sla_violation_penalty_response_model.dart';
import '../../services/sla_violation_penalty_services.dart';


part 'sla_violation_penalty_list_event.dart';
part 'sla_violation_penalty_list_state.dart';

class SLAViolationPenaltyListBloc
    extends Bloc<SLAViolationPenaltyListEvent, SLAViolationPenaltyListState> {
  SLAViolationPenaltyListBloc() : super(const SLAViolationPenaltyListState()) {
    on<FetchData>(
      _fetchSLAViolationPenalty,
      transformer: droppable(),
    );
  }

  final SLAViolationPenaltyServices services = SLAViolationPenaltyServices();

  FutureOr<void> _fetchSLAViolationPenalty(
      FetchData event, Emitter<SLAViolationPenaltyListState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial) {
        SLAViolationPenaltyResponseModel response = await services.getGSvp(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
        );


        return emit(
          state.copyWith(
            items: response.items,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );
      }

      SLAViolationPenaltyResponseModel response = await services.getGSvp(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
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
