import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/models/base_filter_model.dart';
import 'package:db_atom/src/models/organisation.dart';
import 'package:db_atom/src/services/common_services.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:equatable/equatable.dart';

import '../../../../enums/form_status.dart';
import '../models/guarding_master_report_model.dart';
import '../services/guarding_master_report_services.dart';

part 'guarding_master_report_event.dart';

part 'guarding_master_report_state.dart';

class GuardingMasterReportBloc
    extends Bloc<GuardingMasterReportEvent, GuardingMasterReportState> {
  GuardingMasterReportBloc() : super(const GuardingMasterReportState()) {
    on<InitializeValuesGMR>(_initializeValues);
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
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeValuesGMR event, Emitter<GuardingMasterReportState> emit) async {
    try {
      emit(state.copyWith(status: FormStatus.loading));
      List<Organisation> statuses = await commonServices.getStatusesByModuleId(
          module: Constants.guardingMasterDataModule);

      List<Organisation> regions =
      await commonServices.getRegionsOrLocationsByRegionId();

      CommonFilters commonFilters =
      CommonFilters(regions: regions, statuses: statuses);

      Locations locations =
      await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');

      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(),
          moduleCode: Constants.guardingMasterModuleCode);
      // GmUiLabels labels = GmUiLabels.fromJson(responseLabels);
      return emit(
        state.copyWith(
          locations: locations,
          regions: regions,
          statuses: statuses,
          commonFilters: commonFilters,
          hasReachedMax: false,
          status: FormStatus.initial,
        ),
      );
    } on Exception {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }
  FutureOr<void> _refreshList(
      RefreshListGMR event, Emitter<GuardingMasterReportState> emit) async {
    try {
      GuardingMasterReportModel response;

      response = await _services.getGuardingMasterReport(
        startPosition: '${0}',
        maximumRecords: '${20}',
        filters: BaseFilterModel(),
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
              filters: event.filters,
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
            filters: event.filters,
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
