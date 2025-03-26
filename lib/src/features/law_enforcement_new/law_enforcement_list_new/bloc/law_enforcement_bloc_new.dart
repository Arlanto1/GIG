import 'dart:async';
import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/law_enforcement_new/models/law_enforcement_model_new.dart';
import 'package:db_atom/src/features/law_enforcement_new/services/law_enforcement_services_new.dart';

part 'law_enforcement_event_new.dart';
part 'law_enforcement_state_new.dart';

class LawEnforcementBloc
    extends Bloc<LawEnforcementEvent, LawEnforcementNewState> {
  final int passId;

  LawEnforcementBloc({required this.passId})
      : super(const LawEnforcementNewState()) {
    on<InitializeLeoValues>(_initializeValues);
    on<FetchLeoData>(
      _fetchLeo,
      transformer: droppable(),
    );
    on<RefreshLeoList>(
      _refreshList,
      transformer: droppable(),
    );
  }

  final LawEnforcementServicesNew services = LawEnforcementServicesNew();

  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeLeoValues event, Emitter<LawEnforcementNewState> emit) async {
    try {
      emit(state.copyWith(status: FormStatus.loading));

      ExtraProperties extraProperties =
      await UtilsCommon().checkWritePermission(
        moduleCode: Constants.leoModuleCode,
        commonServices: commonServices,
      );

      List<Organisation> statuses = await commonServices.getStatusesByModuleId(
          module: Constants.leoModuleCode);

      List<Organisation> regions =
      await commonServices.getRegionsOrLocationsByRegionId();

      CommonFilters commonFilters =
      CommonFilters(regions: regions, statuses: statuses);

      Locations locations =
      await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');

      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(),
          moduleCode: Constants.passManagementRolesModuleCode);

      LeoUiLabels labels = LeoUiLabels.fromJson(responseLabels);
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
      RefreshLeoList event, Emitter<LawEnforcementNewState> emit) async {
    try {
      LawEnforcementResponseModel response;

      response = await services.getListWithFilters(
        startPosition: '0',
        maximumRecords: '20',
        // passType: 0,
        filters: BaseFilterModel(),
      );

      return emit(
        state.copyWith(
          items: response.list,
          hasReachedMax: false,
          status: FormStatus.success,
        ),
      );
    } on Exception catch (e) {
      return UtilsCommon().exceptionHandling(e, emit, state);
    }
  }

  FutureOr<void> _fetchLeo(
      FetchLeoData event, Emitter<LawEnforcementNewState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    try {

      if (state.status == FormStatus.initial || event.newSearch) {
        LawEnforcementResponseModel response;

        response = await services.getListWithFilters(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          // passType: 0,
          filters: event.filters,
        );

        return emit(
          state.copyWith(
            items: response.list,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );

      }

      LawEnforcementResponseModel response;

      response = await services.getListWithFilters(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
        // passType: 0,
        filters: event.filters,
      );

      if (response.list?.isEmpty == true) {
        return emit(state.copyWith(hasReachedMax: true));
      }
      return emit(
        state.copyWith(
          items: List.of(state.items)..addAll(response.list ?? []),
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
