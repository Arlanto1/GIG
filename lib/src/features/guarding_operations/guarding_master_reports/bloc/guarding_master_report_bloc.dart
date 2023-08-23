import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:db_atom/src/features/law_enforcement_list/controllers/law_enforcement_list_state.dart';
import 'package:equatable/equatable.dart';

import '../models/guarding_master_report_model.dart';
import '../services/guarding_master_report_services.dart';

part 'guarding_master_report_event.dart';

part 'guarding_master_report_state.dart';

class GuardingMasterReportBloc
    extends Bloc<GuardingMasterReportEvent, GuardingMasterReportState> {
  GuardingMasterReportBloc() : super(const GuardingMasterReportState()) {
    on<FetchReportList>(
      _fetchList,
      transformer: droppable(),
    );
  }

  final GuardingMasterReportServices _services = GuardingMasterReportServices();

  FutureOr<void> _fetchList(
      FetchReportList event, Emitter<GuardingMasterReportState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == LawEnforcementListStateType.initial) {
        GuardingMasterReportModel getGuardingMaterialReports =
            await _services.getGuardingMasterReport(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          userId: '7',
        );
        return emit(
          state.copyWith(
            items: getGuardingMaterialReports.data,
            hasReachedMax: false,
            status: LawEnforcementListStateType.success,
          ),
        );
      }

      GuardingMasterReportModel getGuardingMasterReport =
          await _services.getGuardingMasterReport(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
        userId: '7',
      );

      if (getGuardingMasterReport.data?.isEmpty == true) {
        return emit(state.copyWith(hasReachedMax: true));
      }
      return emit(
        state.copyWith(
          items: List.of(state.list)
            ..addAll(getGuardingMasterReport.data ?? []),
          hasReachedMax: false,
        ),
      );
    } catch (e) {
      return emit(state.copyWith(status: LawEnforcementListStateType.failure));
    }
  }
}
