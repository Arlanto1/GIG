import 'dart:async';

import '../../../../../index.dart';
import '../../models/material_items_model.dart';
import '../../models/material_items_response_model.dart';
import '../../models/requestModels/material_items_request.dart';

part 'material_items_event.dart';
part 'material_items_state.dart';

class MaterialItemsBloc extends Bloc<MaterialItemsEvent, MaterialItemsState> {
  final List<Organisation> units;
  final String unit;

  MaterialItemsBloc({required this.units, required this.unit}) : super(const MaterialItemsState()) {
    on<FetchItemData>(_fetchItems, transformer: droppable());
    on<InitializeValues>(_initializeValues);
    on<SaveRecord>(_saveRecord);
    on<DeleteRecord>(_deleteRecord);
  }

  final MaterialMovementServices services = MaterialMovementServices();
  final CommonServices commonServices = CommonServices();

  /// Initialize any default values
  FutureOr<void> _initializeValues(
      InitializeValues event, Emitter<MaterialItemsState> emit) async {

    List<Organisation> units =
    await commonServices.getOrganisations(name: 'ATOM_MATERIAL_MOVEMENT_UNIT');

    emit(state.copyWith(
      status: FormStatus.initial,
      // items: [],
      units: units,
      hasReachedMax: false,
    ));
  }

  // /// Fetch Material Items by ID
  // FutureOr<void> _fetchItems(
  //     FetchItemData event, Emitter<MaterialItemsState> emit) async {
  //   try {
  //     if (state.hasReachedMax) return;
  //
  //     emit(state.copyWith(status: FormStatus.loading));
  //
  //     final response = await services.getMMListById(event.id);
  //
  //     emit(state.copyWith(
  //       items: response.items ?? [],
  //       hasReachedMax: (response.items ?? []).isEmpty,
  //       status: FormStatus.success,
  //     ));
  //   } catch (e) {
  //     emit(state.copyWith(status: FormStatus.failure, message: e.toString()));
  //   }
  // }


  FutureOr<void> _fetchItems(
      FetchItemData event, Emitter<MaterialItemsState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial) {
        List<MaterialMovementItem> response =
        await services.getViolationPenaltyList(
          id: '${event.id}',
          // type: '${event.type}',
        );
        return emit(
          state.copyWith(
            items: response,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );
      }

      // List<ViolationPenaltyRecord> response =
      //     await services.getViolationPenaltyList(
      //   id: '${event.id}',
      //   // type: '${event.type}',
      // );
      //
      // if (response.isEmpty == true) {
      //   return emit(state.copyWith(hasReachedMax: true));
      // }
      // return emit(
      //   state.copyWith(
      //     items: List.of(state.items ?? [])..addAll(response),
      //     hasReachedMax: false,
      //   ),
      // );
    } catch (e) {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }


  FutureOr<void> _deleteRecord(
      DeleteRecord event, Emitter<MaterialItemsState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    try {
      await MaterialMovementServices().deleteVpById(event.id);
      List<MaterialMovementItem> response =
      await services.getViolationPenaltyList(
        id: '${event.mainContactId}',
      );
      return emit(
        state.copyWith(items: response, status: FormStatus.success),
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

  FutureOr<void> _saveRecord(
      SaveRecord event, Emitter<MaterialItemsState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    try {
      MaterialItemsRequest request = MaterialItemsRequest();

      request.items = event.itemsModel;
      await MaterialMovementServices()
          .createMaterialItems(body: request,  id: '${event.mainContactId}',);

      /// Refresh list
      List<MaterialMovementItem> response =
      await services.getViolationPenaltyList(
        id: '${event.mainContactId}',
        // type: '${event.type}',
      );
      return emit(state.copyWith(
        items: response,
        hasReachedMax: false,
        status: FormStatus.success,
      ));
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
}





