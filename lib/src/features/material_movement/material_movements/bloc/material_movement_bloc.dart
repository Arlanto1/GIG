import 'dart:async';
import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/material_movement/models/material_movements_model.dart';

import '../../models/approval_model.dart';
import '../../models/requestModels/approval_request.dart';

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
    on<SaveRecord>(_saveRecord);
    on<FetchApprovalById>(_fetchApprovalById);
  }

  final MaterialMovementServices services = MaterialMovementServices();

  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(InitializeValuesMM event,
      Emitter<MaterialMovementState> emit) async {
    try {
      log('Retu${returnable}');
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

  FutureOr<void> _refreshList(RefreshList event,
      Emitter<MaterialMovementState> emit) async {
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

  FutureOr<void> _fetchMaterialMovements(FetchData event,
      Emitter<MaterialMovementState> emit) async {
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
          items: List.of(state.items)
            ..addAll(response.items ?? []),
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

  //
  // FutureOr<void> _saveRecord(
  //     SaveRecord event, Emitter<MaterialMovementState> emit) async {
  //   emit(
  //     state.copyWith(
  //       status: FormStatus.loading,
  //     ),
  //   );
  //   try {
  //     MaterialApprovalRequest request = MaterialApprovalRequest();
  //
  //     request.items = event.model;
  //     await MaterialMovementServices()
  //         .createMaterialApproval(body: request);
  //   } on GenericResponse catch (e) {
  //     emit(
  //       state.copyWith(
  //         message: e.message,
  //         status: FormStatus.formError,
  //       ),
  //     );
  //     return;
  //   } on Exception catch (e) {
  //     return UtilsCommon().exceptionHandling(e, emit, state);
  //   }
  // }


  FutureOr<void> _fetchApprovalById(FetchApprovalById event,
      Emitter<MaterialMovementState> emit,) async {
    emit(state.copyWith(status: FormStatus.loading));

    try {

      final approval = await services.getApprovalById(event.apStepId);

      emit(
        state.copyWith(
            status: FormStatus.success,
            approvalModel: approval,
            selectedId: event.apStepId
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          message: e.toString(),
        ),
      );
    }
  }

  FutureOr<void> _saveRecord(SaveRecord event,
      Emitter<MaterialMovementState> emit,) async {
    emit(state.copyWith(status: FormStatus.loading));

    try {

      log('GET objectId: ${state.approvalModel?.objectId}');
      log('POST objectId: ${event.model.objectId}');
      event.model.apStepId =
          state.selectedId ?? state.approvalModel?.apStepId;
      // event.model.objectId =
      //     state.approvalModel?.objectId ?? state.objectId?.toString();
      if (event.model.apStepId == null) {
        throw Exception('apStepId is null');
      }

      final request = MaterialApprovalRequest()
        ..items = event.model;

      await services.createMaterialApproval(body: request);

      emit(state.copyWith(status: FormStatus.success));
    } on GenericResponse catch (e) {
      emit(state.copyWith(
        message: e.message,
        status: FormStatus.formError,
      ));
    } on Exception catch (e) {
      UtilsCommon().exceptionHandling(e, emit, state);
    }
  }
  }
