
import 'dart:async';
import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/passmanagement/models/pass_management_model.dart';
import 'package:db_atom/src/features/passmanagement/models/pm_ui_labels.dart';
import 'package:db_atom/src/features/passmanagement/services/pass_management_services.dart';

part 'day_passmanagement_event.dart';
part 'day_passmanagement_state.dart';

class DayPassManagementBloc
    extends Bloc<DayPassManagementEvent, DayPassManagementState> {
  final bool isInward;
  final bool? returnable;

  DayPassManagementBloc({
    required this.isInward,
    this.returnable,
  }) : super(const DayPassManagementState()) {
    on<InitializeValues>(_initializeValues);
    on<FetchData>(
      _fetchDayPassManagements,
      transformer: droppable(),
    );
    on<RefreshList>(
      _refreshList,
      transformer: droppable(),
    );
  }

  final PassManagementServices services = PassManagementServices();

  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeValues event, Emitter<DayPassManagementState> emit) async {
    try {

      emit(state.copyWith(status: FormStatus.loading));

      ExtraProperties extraProperties =
      await UtilsCommon().checkWritePermission(
        moduleCode: Constants.passManagementModule,
        commonServices: commonServices,
      );

      List<Organisation> statuses = await commonServices.getStatusesByModuleId(
          module: Constants.passManagementModule);

      List<Organisation> regions =
      await commonServices.getRegionsOrLocationsByRegionId();

      CommonFilters commonFilters =
      CommonFilters(regions: regions, statuses: statuses);

      Locations locations =
      await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');

      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(),
          moduleCode: Constants.passManagementModuleCode);

      PMUiLabels labels = PMUiLabels.fromJson(responseLabels);
      return emit(
        state.copyWith(
          locations: locations,
          regions: regions,
          statuses: statuses,
          commonFilters: commonFilters,
          hasReachedMax: false,
          status: FormStatus.initial,
          labels: labels,
          extraProperties: extraProperties,
        ),
      );
    } on GenericResponse catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.formError,
        ),
      );
      return;
    } on Exception catch (e) {
      return UtilsCommon().exceptionHandling(e, emit, state);
    }
  }

  FutureOr<void> _refreshList(
      RefreshList event, Emitter<DayPassManagementState> emit) async {
    try {
      final PassManagementResponseModel response =
      await services.getPassManagementList(
        startPosition: '0',
        maximumRecords: '20',
        mmType: isInward ? 1 : 0,
        filters: BaseFilterModel(),
      );

      return emit(
        state.copyWith(
          items: response.items,
          hasReachedMax: false,
          status: FormStatus.success,
        ),
      );
    } on Exception catch (e) {
      return UtilsCommon().exceptionHandling(e, emit, state);
    }
  }

  FutureOr<void> _fetchDayPassManagements(
      FetchData event, Emitter<DayPassManagementState> emit) async {
    log('-_fetchMaterialMovements--');

    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    try {
      // if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial || event.newSearch) {
        log('-_fetchMaterialMovements--initial--');
        PassManagementResponseModel response;
        // response = await services.getMaterialMovements(
        //   startPosition: '${event.startPos}',
        //   maximumRecords: '${event.maxPos}',
        //   mmType: isInward ? 1 : 0,
        // );

        response = await services.getPassManagementList(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          mmType: isInward ? 1 : 0,
          filters: event.filters,
        );

        return emit(
          state.copyWith(
            items: response.items,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );
      }

      log('-_fetchMaterialMovements------##--');
      PassManagementResponseModel response;
      response = await services.getPassManagementList(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
        mmType: isInward ? 1 : 0,
        filters: event.filters,
      );

      if (response.items?.isEmpty == true) {
        return emit(
            state.copyWith(hasReachedMax: true, status: FormStatus.success));
      }
      return emit(
        state.copyWith(
          items: List.of(state.items)..addAll(response.items ?? []),
          hasReachedMax: false,
          status: FormStatus.success,
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
