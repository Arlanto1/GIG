import 'dart:async';
import 'dart:developer';

import 'package:db_atom/index.dart';

import 'package:db_atom/src/services/CommonServices.dart';
import 'package:db_atom/src/features/guarding_operations/sla_violation_penalty/services/sla_violation_penalty_services.dart';

part 'sla_violation_penalty_list_event.dart';

part 'sla_violation_penalty_list_state.dart';

class SLAViolationPenaltyListBloc
    extends Bloc<SLAViolationPenaltyListEvent, SLAViolationPenaltyListState> {
  SLAViolationPenaltyListBloc() : super(const SLAViolationPenaltyListState()) {
    on<InitializeValues>(_initializeValues);
    on<FetchData>(
      _fetchSLAViolationPenalty,
      transformer: droppable(),
    );
  }

  final SLAViolationPenaltyServices services = SLAViolationPenaltyServices();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeValues event, Emitter<SLAViolationPenaltyListState> emit) async {
    log('_initializeValues');
    try {
      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(), moduleCode: Constants.slaViolationPenaltyDetailsModuleCode);
      log('--default--${responseLabels.toString()}----//Getting Proper response as JSON------');
      SlaUiLabels labels = SlaUiLabels.fromJson(responseLabels);

      return emit(
        state.copyWith(
          labels: labels,
          hasReachedMax: false,
        ),
      );
    }
    on Exception {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }
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
    } on TokenExpiredException catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.sessionExpired,
        ),
      );
      return;
    } catch (e) {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }
}
