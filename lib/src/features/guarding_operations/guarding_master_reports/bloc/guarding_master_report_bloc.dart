import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import '../../../../enums/form_status.dart';
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
    on<RefreshListGMR>(
      _refreshList,
      transformer: droppable(),
    );
  }

  final GuardingMasterReportServices _services = GuardingMasterReportServices();

  FutureOr<void> _refreshList(
      RefreshListGMR event, Emitter<GuardingMasterReportState> emit) async {
    try {
      GuardingMasterReportModel response;

      response = await _services.getGuardingMasterReport(
        startPosition: '${0}',
        maximumRecords: '${20}',
        // filters: BaseFilterModel(),
      );

      return emit(
        state.copyWith(
          items: response.list,
          hasReachedMax: false,
          status: FormStatus.success,
        ),
      );
    } on Exception {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }

  FutureOr<void> _fetchList(
      FetchReportList event, Emitter<GuardingMasterReportState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial) {
        GuardingMasterReportModel getGuardingMaterialReports =
            await _services.getGuardingMasterReport(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          // userId: '7',
        );
        return emit(
          state.copyWith(
            items: getGuardingMaterialReports.data,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );
      }

      GuardingMasterReportModel getGuardingMasterReport =
          await _services.getGuardingMasterReport(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
        // userId: '7',
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
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }
}
