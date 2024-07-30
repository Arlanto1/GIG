import 'dart:async';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_issuance/models/km_ui_labels.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_reconciliation_list/models/key_reconciliation_list_model.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_reconciliation_list/services/key_reconciliation_list_services.dart';

part 'key_reconciliation_list_event.dart';

part 'key_reconciliation_list_state.dart';

class KeyReconciliationListBloc
    extends Bloc<KeyReconciliationListEvent, KeyReconciliationListState> {
  KeyReconciliationListBloc() : super(const KeyReconciliationListState()) {
    on<InitializeValues>(_initializeValues);
    on<FetchKeyReconciliationList>(
      _fetchList,
      transformer: droppable(),
    );
    on<RefreshList>(
      _refreshList,
      transformer: droppable(),
    );
  }

  final KeyReconciliationListServices _services =
      KeyReconciliationListServices();
  final CommonServices commonServices = CommonServices();

  // FutureOr<void> _initializeValues(
  //     InitializeValues event, Emitter<KeyReconciliationListState> emit) async {
  //   try {
  //     dynamic responseLabels = await commonServices.getUiLabels(
  //         language: await SharedPrefs.getLanguageCode(),
  //         moduleCode: Constants.guardingMasterModuleCode);
  //     // GmUiLabels labels = GmUiLabels.fromJson(responseLabels);
  //     return emit(
  //       state.copyWith(
  //         //labels: labels,
  //         hasReachedMax: false,
  //       ),
  //     );
  //   } on Exception {
  //     return emit(state.copyWith(status: FormStatus.failure));
  //   }
  // }
  FutureOr<void> _initializeValues(
      InitializeValues event, Emitter<KeyReconciliationListState> emit) async {
    try {
      emit(state.copyWith(status: FormStatus.loading));

      ExtraProperties extraProperties =
          await UtilsCommon().checkWritePermission(
        moduleCode: Constants.keyReconciliationModule,
        commonServices: commonServices,
      );

      List<Organisation> statuses = await commonServices.getStatusesByModuleId(
          module: Constants.keyReconciliationModule);

      List<Organisation> regions =
          await commonServices.getRegionsOrLocationsByRegionId();

      CommonFilters commonFilters =
          CommonFilters(regions: regions, statuses: statuses);

      Locations locations =
          await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');

      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(),
          moduleCode: Constants.keyReconciliationModule);

      KMUiLabels labels = KMUiLabels.fromJson(responseLabels);
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
          status: FormStatus.error,
        ),
      );
      return;
    } on Exception catch (e) {
      return UtilsCommon().exceptionHandling(e, emit, state);
    }
  }

  FutureOr<void> _refreshList(
      RefreshList event, Emitter<KeyReconciliationListState> emit) async {
    try {
      KeyReconciliationListResponse response;

      response = await _services.getList(
        startPosition: '${0}',
        maximumRecords: '${20}',
        userId: '7',
        locationId: '56',
        filters: BaseFilterModel(),
      );

      return emit(
        state.copyWith(
          items: response.items,
          hasReachedMax: false,
          status: FormStatus.initial,
        ),
      );
    } on Exception catch (e) {
      return UtilsCommon().exceptionHandling(e, emit, state);
    }
  }

  // FutureOr<void> _fetchList(FetchKeyReconciliationList event,
  //     Emitter<KeyReconciliationListState> emit) async {
  //   try {
  //     if (state.hasReachedMax) return;
  //
  //     if (state.status == FormStatus.initial) {
  //       KeyReconciliationListResponse getKeyReconciliationLists =
  //           await _services.getList(
  //         startPosition: '${event.startPos}',
  //         maximumRecords: '${event.maxPos}',
  //         userId: '7',
  //         locationId: '56',
  //             filters: BaseFilterModel(),
  //
  //           );
  //       return emit(
  //         state.copyWith(
  //           items: getKeyReconciliationLists.items,
  //           hasReachedMax: false,
  //           status: FormStatus.success,
  //         ),
  //       );
  //     }
  //
  //     KeyReconciliationListResponse getKeyReconciliationList =
  //         await _services.getList(
  //       startPosition: '${event.startPos}',
  //       maximumRecords: '${event.maxPos}',
  //       userId: '7',
  //       locationId: '56',
  //           filters: BaseFilterModel(),
  //
  //         );
  //
  //     if (getKeyReconciliationList.items?.isEmpty == true) {
  //       return emit(state.copyWith(hasReachedMax: true));
  //     }
  //     return emit(
  //       state.copyWith(
  //         items: List.of(state.list)
  //           ..addAll(getKeyReconciliationList.items?.toList() ?? []),
  //         hasReachedMax: false,
  //       ),
  //     );
  //   }
  //   // on TokenExpiredException catch (e) {
  //   //   emit(
  //   //     state.copyWith(
  //   //       message: e.message,
  //   //       status: FormStatus.sessionExpired,
  //   //     ),
  //   //   );
  //   //   return;
  //   // }
  //   catch (e) {
  //     return emit(state.copyWith(status: FormStatus.failure));
  //   }
  // }
  FutureOr<void> _fetchList(FetchKeyReconciliationList event,
      Emitter<KeyReconciliationListState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    try {
      // if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial || event.newSearch) {
        KeyReconciliationListResponse response;
        response = await _services.getList(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          userId: '7',
          locationId: '56',
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

      KeyReconciliationListResponse response;
      response = await _services.getList(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
        userId: '7',
        locationId: '56',
        filters: event.filters,
      );

      if (response.items?.isEmpty == true) {
        return emit(state.copyWith(hasReachedMax: true));
      }
      return emit(
        state.copyWith(
          items: List.of(state.list)..addAll(response.items ?? []),
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
