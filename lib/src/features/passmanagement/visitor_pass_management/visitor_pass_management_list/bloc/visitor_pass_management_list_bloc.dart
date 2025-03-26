import 'dart:async';
import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/passmanagement/visitor_pass_management/models/visitor_pass_management_model.dart';
import 'package:db_atom/src/features/passmanagement/visitor_pass_management/services/visitor_pass_management_service.dart';
import 'package:db_atom/src/features/passmanagement/models/pm_ui_labels.dart';


part 'visitor_pass_management_list_event.dart';
part 'visitor_pass_management_list_state.dart';

class VisitorPassManagementListBloc
    extends Bloc<VisitorPassManagementListEvent, VisitorPassManagementListState> {
final int passId;
  VisitorPassManagementListBloc({required this.passId})
      : super(const VisitorPassManagementListState()) {
    on<InitializeVisitorPassValues>(_initializeValues);
    on<FetchVisitorPassData>(
      _fetchVisitorPassManagements,
      transformer: droppable(),
    );
    on<RefreshVisitorPassList>(
      _refreshList,
      transformer: droppable(),
    );
  }

  final VisitorPassManagementServices services = VisitorPassManagementServices();

  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeVisitorPassValues event, Emitter<VisitorPassManagementListState> emit) async {
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
      RefreshVisitorPassList event, Emitter<VisitorPassManagementListState> emit) async {
    try {
      VisitorPassManagementResponse response;

      response = await services.getVisitorPassManagementList(
        startPosition: '0',
        maximumRecords: '20',
        passType: 1,
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

  FutureOr<void> _fetchVisitorPassManagements(
      FetchVisitorPassData event, Emitter<VisitorPassManagementListState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    try {

      if (state.status == FormStatus.initial || event.newSearch) {
        VisitorPassManagementResponse response;

        response = await services.getVisitorPassManagementList(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          passType: 1,
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

      VisitorPassManagementResponse response;

      response = await services.getVisitorPassManagementList(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
        passType: 1,
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
