import 'dart:async';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/event_protection/models/ep_ui_labels.dart';

import '../../models/csr_event_model.dart';
import '../../services/csr_event_services.dart';

part 'csr_event_list_event.dart';
part 'csr_event_list_state.dart';

class CSREventBloc
    extends Bloc<CSREventEvent, CSREventState> {
  final bool isCSREvent;

  CSREventBloc({required this.isCSREvent}) : super(const CSREventState()) {
    on<InitializeValuesEP>(_initializeValues);
    on<FetchData>(
      _fetchList,
      transformer: droppable(),
    );
    on<RefreshList>(
      _refreshList,
      transformer: droppable(),
    );
  }

  final CSREventServices _services = CSREventServices();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _refreshList(
      RefreshList event, Emitter<CSREventState> emit) async {
    try {
      CSREventResponse response;

      response = await _services.getCSREventList(
        startPosition: '0',
        maximumRecords: '20',
        filters: BaseFilterModel(),
        type: isCSREvent ? 2 : 3,
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

  FutureOr<void> _initializeValues(
      InitializeValuesEP event, Emitter<CSREventState> emit) async {
    try {
      emit(state.copyWith(status: FormStatus.loading));

      ExtraProperties extraProperties =
      await UtilsCommon().checkWritePermission(
        moduleCode: Constants.eventProtectionModuleCode,
        commonServices: commonServices,
      );

      List<Organisation> statuses = await commonServices.getStatusesByModuleId(
          module: Constants.eventProtectionModule);

      List<Organisation> regions =
      await commonServices.getRegionsOrLocationsByRegionId();

      CommonFilters commonFilters =
      CommonFilters(regions: regions, statuses: statuses);

      Locations locations =
      await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');

      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(),
          moduleCode: Constants.eventProtectionModuleCode);

      EPUiLabels labels = EPUiLabels.fromJson(responseLabels);
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

  FutureOr<void> _fetchList(
      FetchData event, Emitter<CSREventState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    try {
      if (state.status == FormStatus.initial || event.newSearch) {
        CSREventResponse response;
        response = await _services.getCSREventList(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          filters: event.filters,
          type: isCSREvent ? 2 : 3,
        );
        return emit(
          state.copyWith(
            items: response.items,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );
      }

      CSREventResponse response;
      response = await _services.getCSREventList(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
        filters: event.filters,
        type: isCSREvent ? 2 : 3,
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
