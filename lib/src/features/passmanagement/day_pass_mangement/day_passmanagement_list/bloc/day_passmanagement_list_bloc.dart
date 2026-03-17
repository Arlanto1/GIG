import 'dart:async';

import 'package:db_atom/src/features/passmanagement/day_pass_mangement/models/day_pass_management_model.dart';
import 'package:db_atom/src/features/passmanagement/day_pass_mangement/services/day_passmanagement_service.dart';
import 'package:db_atom/src/features/passmanagement/models/pm_ui_labels.dart';
import '../../../../../../index.dart';

part 'day_passmanagement_list_event.dart';
part 'day_passmanagement_list_state.dart';

class DayPassManagementListBloc
    extends Bloc<DayPassManagementListEvent, DayPassManagementListState> {
  final int passId;

  DayPassManagementListBloc({required this.passId})
      : super(const DayPassManagementListState()) {
    on<InitializeDayPassValues>(_initializeValues);
    on<FetchDayPassData>(
      _fetchDayPassManagements,
      transformer: droppable(),
    );
    on<RefreshDayPassList>(
      _refreshList,
      transformer: droppable(),
    );
  }

  final DayPassManagementServices services = DayPassManagementServices();

  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeDayPassValues event, Emitter<DayPassManagementListState> emit) async {
    try {
      emit(state.copyWith(status: FormStatus.loading));

      ExtraProperties extraProperties =
      await UtilsCommon().checkWritePermission(
        moduleCode: Constants.passManagementRolesModuleCode,
        commonServices: commonServices,
      );

      List<Organisation> statuses = await commonServices.getStatusesByModuleId(
          module: Constants.passManagementModuleCode);

      List<Organisation> regions =
      await commonServices.getRegionsOrLocationsByRegionId();

      CommonFilters commonFilters =
      CommonFilters(regions: regions, statuses: statuses);

      Locations locations =
      await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');

      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(),
          moduleCode: Constants.passManagementRolesModuleCode);

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
      RefreshDayPassList event, Emitter<DayPassManagementListState> emit) async {
    try {
      DayPassManagementResponseModel response;

      response = await services.getPassManagementList(
        startPosition: '0',
        maximumRecords: '20',
        passType: 0,
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
      FetchDayPassData event, Emitter<DayPassManagementListState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    try {

      if (state.status == FormStatus.initial || event.newSearch) {
        DayPassManagementResponseModel response;

        response = await services.getPassManagementList(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          passType: 0,
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

      DayPassManagementResponseModel response;

      response = await services.getPassManagementList(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
        passType: 0,
        filters: event.filters,
      );

      if (response.items?.isEmpty == true) {
        return emit(state.copyWith(hasReachedMax: true));
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
