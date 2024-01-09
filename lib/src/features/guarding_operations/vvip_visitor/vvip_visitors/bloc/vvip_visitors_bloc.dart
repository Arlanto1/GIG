import 'dart:async';
import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/vvip_visitor/services/vvip_visitor_services.dart';

import 'package:db_atom/src/services/common_services.dart';

import '../../models/vvip_visitor_response_model.dart';

part 'vvip_visitors_event.dart';

part 'vvip_visitors_state.dart';

class VVIPVisitorsBloc
    extends Bloc<VVIPVisitorsEvent, VVIPVisitorsState> {
  VVIPVisitorsBloc() : super(const VVIPVisitorsState()) {
    on<InitializeValues>(_initializeValues);
    on<FetchData>(
      _fetchVVIPVisitors,
      transformer: droppable(),
    );
  }

  final VVIPVisitorServices services = VVIPVisitorServices();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeValues event, Emitter<VVIPVisitorsState> emit) async {
    log('_initializeValues');
    try {
      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(), moduleCode: Constants.slaViolationPenaltyDetailsModuleCode);
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
  FutureOr<void> _fetchVVIPVisitors(
      FetchData event, Emitter<VVIPVisitorsState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial) {
        VVIPVisitorResponseModel response = await services.getGVVIP(
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

      VVIPVisitorResponseModel response = await services.getGVVIP(
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
