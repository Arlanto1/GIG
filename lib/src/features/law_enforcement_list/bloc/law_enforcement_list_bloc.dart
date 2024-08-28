import 'dart:async';
import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/lawenforcement/services/law_enforcement_services.dart';

import '../models/law_enforcement_list_response.dart';

part 'law_enforcement_list_event.dart';

part 'law_enforcement_list_state.dart';

class LawEnforcementListBloc
    extends Bloc<LawEnforcementListEvent, LawEnforcementListState> {
  LawEnforcementListBloc() : super(const LawEnforcementListState()) {
    // Initial Event
    on<InitializeValuesLEO>(_initializeValues);
    on<LawEnforcementFetch>(
      _onTodoFetch,
      transformer: droppable(),
    );

    // Refresh Event
    on<LawEnforcementRefresh>(
      _onTodoRefresh,
      transformer: droppable(),
    );
    on<RefreshList>(
      _refreshList,
      transformer: droppable(),
    );
  }

  final LawEnforcementServices services = LawEnforcementServices();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeValuesLEO event, Emitter<LawEnforcementListState> emit) async {
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

      // dynamic responseLabels = await commonServices.getUiLabels(
      //     language: await SharedPrefs.getLanguageCode(),
      //     moduleCode: Constants.leoModuleCode);

      // CdUiLabels labels = CdUiLabels.fromJson(responseLabels);
      return emit(
        state.copyWith(
          locations: locations,
          regions: regions,
          statuses: statuses,
          commonFilters: commonFilters,
          hasReachedMax: false,
          status: FormStatus.initial,
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
      RefreshList event, Emitter<LawEnforcementListState> emit) async {
    try {
      LawEnforcementListResponse response;

      response = await services.getListWithFilters(
        startPosition: '0',
        maximumRecords: '20',
        filters: BaseFilterModel(),
      );

      return emit(
        state.copyWith(
          todos: response.list,
          hasReachedMax: false,
          status: FormStatus.success,
        ),
      );
    } on Exception catch (e) {
      return UtilsCommon().exceptionHandling(e, emit, state);
    }
  }

  // FutureOr<void> _onTodoFetch(
  //     LawEnforcementFetch event, Emitter<LawEnforcementListState> emit) async {
  //   String userid = await SharedPrefs.getUserId();
  //   try {
  //     if (event.startPos == 0) {
  //       // state.lawEnforceItems.clear();
  //       emit(
  //         state.copyWith(
  //           todos: [],
  //           hasReachedMax: false,
  //           status: FormStatus.initial,
  //         ),
  //       );
  //     }
  //     if (state.hasReachedMax) return;
  //     if (state.status == FormStatus.initial) {
  //       LawEnforcementListResponse lawEnforcementList = await services.getListWithFilters(
  //           startPosition: '${event.startPos}',
  //           maximumRecords: '${event.maxPos}',
  //         filters: BaseFilterModel(),
  //       );
  //       return emit(
  //         state.copyWith(
  //           todos: lawEnforcementList.list,
  //           hasReachedMax: false,
  //           status: FormStatus.success,
  //         ),
  //       );
  //     }
  //
  //     LawEnforcementListResponse lawEnforcementList = await services.getListWithFilters(
  //       startPosition: '${event.startPos}',
  //       maximumRecords: '${event.maxPos}',
  //       filters: BaseFilterModel(),
  //     );
  //     if (lawEnforcementList.list?.isEmpty == true) {
  //       return emit(state.copyWith(hasReachedMax: true));
  //     } else {
  //       return emit(
  //         state.copyWith(
  //           todos: List.of(state.items)..addAll(lawEnforcementList.list ?? []),
  //           hasReachedMax: false,
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     return emit(state.copyWith(status: FormStatus.failure));
  //   }
  // }

  FutureOr<void> _onTodoFetch(
      LawEnforcementFetch event, Emitter<LawEnforcementListState> emit) async {
    log('-_fetchMaterialMovements--');

    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    try {
      // if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial || event.newSearch) {
        LawEnforcementListResponse response;

        response = await services.getListWithFilters(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          filters: event.filters,
        );

        return emit(
          state.copyWith(
            todos: response.list,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );
      }

      LawEnforcementListResponse response;
      response = await services.getListWithFilters(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
        filters: event.filters,
      );

      if (response.list?.isEmpty == true) {
        return emit(state.copyWith(hasReachedMax: true));
      }
      return emit(
        state.copyWith(
          todos: List.of(state.items)..addAll(response.list ?? []),
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

  FutureOr<void> _onTodoRefresh(LawEnforcementRefresh event,
      Emitter<LawEnforcementListState> emit) async {}
}
