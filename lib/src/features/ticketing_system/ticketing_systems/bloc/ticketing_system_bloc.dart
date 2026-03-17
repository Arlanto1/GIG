import 'dart:async';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/ticketing_system/models/ticketing_system_list_model.dart';
import 'package:db_atom/src/features/ticketing_system/models/ticketing_system_model.dart';
import 'package:db_atom/src/features/ticketing_system/services/ticketing_system_services.dart';

part 'ticketing_system_event.dart';
part 'ticketing_system_state.dart';

class TicketingSystemBloc
    extends Bloc<TicketingSystemEvent, TicketingSystemState> {
  TicketingSystemBloc() : super(const TicketingSystemState()) {
    on<InitializeValues>(_initializeValues);
    on<FetchTicketingSystemData>(
      _fetchList,
      transformer: droppable(),
    );
    on<RefreshList>(
      _refreshList,
      transformer: droppable(),
    );
  }

  final TicketingSystemServices _services = TicketingSystemServices();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeValues event, Emitter<TicketingSystemState> emit) async {
    try {
      emit(state.copyWith(status: FormStatus.loading));

      // ExtraProperties extraProperties =
      // await UtilsCommon().checkWritePermission(
      //   moduleCode: Constants.shiftScheduleModuleCode,
      //   commonServices: commonServices,
      // );

      List<Organisation> statuses = await commonServices.getStatusesByModuleId(
          module: Constants.ticketingSystemModuleCode);

      List<Organisation> regions =
      await commonServices.getRegionsOrLocationsByRegionId();

      CommonFilters commonFilters =
      CommonFilters(regions: regions, statuses: statuses);

      Locations locations =
      await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');

      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(),
          moduleCode: Constants.shiftScheduleModuleCode);

      return emit(
        state.copyWith(
          locations: locations,
          regions: regions,
          // labels: labels,
          statuses: statuses,
          commonFilters: commonFilters,
          hasReachedMax: false,
          status: FormStatus.initial,
          // extraProperties: extraProperties,
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
      RefreshList event, Emitter<TicketingSystemState> emit) async {
    try {
      TicketingSystemListResponse response;

      response = await _services.getTicketingSystemList(
        startPosition: '0',
        maximumRecords: '20',
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
  FutureOr<void> _fetchList(FetchTicketingSystemData event,
      Emitter<TicketingSystemState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    try {
      // if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial || event.newSearch) {
        TicketingSystemListResponse response;
        response = await _services.getTicketingSystemList(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          filters: event.filters,
        );

        // for (TicketingSystemModel model in response.items ?? []) {
        // }

        return emit(
          state.copyWith(
            items: response.items,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );
      }

      TicketingSystemListResponse response;
      response = await _services.getTicketingSystemList(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
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
