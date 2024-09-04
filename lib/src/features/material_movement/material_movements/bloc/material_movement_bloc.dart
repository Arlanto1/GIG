import 'dart:async';
import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/material_movement/models/material_movements_model.dart';

part 'material_movement_event.dart';
part 'material_movement_state.dart';

class MaterialMovementBloc
    extends Bloc<MaterialMovementEvent, MaterialMovementState> {
  final bool isInward;
  final bool? returnable;

  MaterialMovementBloc({
    required this.isInward,
    this.returnable,
  }) : super(const MaterialMovementState()) {
    on<InitializeValuesMM>(_initializeValues);
    on<FetchData>(
      _fetchMaterialMovements,
      transformer: droppable(),
    );
    on<RefreshList>(
      _refreshList,
      transformer: droppable(),
    );
  }

  final MaterialMovementServices services = MaterialMovementServices();

  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeValuesMM event, Emitter<MaterialMovementState> emit) async {
    try {
      emit(state.copyWith(status: FormStatus.loading));

      ExtraProperties extraProperties =
          await UtilsCommon().checkWritePermission(
        moduleCode: Constants.materialMovementModuleCode,
        commonServices: commonServices,
      );

      List<Organisation> statuses = await commonServices.getStatusesByModuleId(
          module: Constants.materialMovementModuleCode);

      List<Organisation> regions =
          await commonServices.getRegionsOrLocationsByRegionId();

      CommonFilters commonFilters =
          CommonFilters(regions: regions, statuses: statuses);

      Locations locations =
          await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');

      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(),
          moduleCode: Constants.materialMovementModuleCode);

      MmUiLabels labels = MmUiLabels.fromJson(responseLabels);
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
      RefreshList event, Emitter<MaterialMovementState> emit) async {
    try {
      final MaterialMovementsModel response =
          await services.getMaterialMovementsWithFilters(
        startPosition: '0',
        maximumRecords: '20',
        mmType: isInward ? 1 : 0,
        filters: BaseFilterModel(),
        returnable: returnable,
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

  FutureOr<void> _fetchMaterialMovements(
      FetchData event, Emitter<MaterialMovementState> emit) async {
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
        MaterialMovementsModel response;
        // response = await services.getMaterialMovements(
        //   startPosition: '${event.startPos}',
        //   maximumRecords: '${event.maxPos}',
        //   mmType: isInward ? 1 : 0,
        // );

        response = await services.getMaterialMovementsWithFilters(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          mmType: isInward ? 1 : 0,
          filters: event.filters,
          returnable: returnable,
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
      MaterialMovementsModel response;
      response = await services.getMaterialMovementsWithFilters(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
        mmType: isInward ? 1 : 0,
        filters: event.filters,
        returnable: returnable,
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
