import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/lawenforcement/services/law_enforcement_services.dart';
import 'package:db_atom/src/models/base_filter_model.dart';
import 'package:db_atom/src/models/organisation.dart';
import 'package:db_atom/src/models/responseModels/token_expired.dart';
import 'package:db_atom/src/services/common_services.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../enums/form_status.dart';
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
          moduleCode: Constants.contactDetailsModuleCode);
      // CdUiLabels labels = CdUiLabels.fromJson(responseLabels);
      return emit(
        state.copyWith(
          locations: locations,
          regions: regions,
          statuses: statuses,
          commonFilters: commonFilters,
          hasReachedMax: false,
          status: FormStatus.initial,
        ),
      );
    } on Exception {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }
  FutureOr<void> _refreshList(
      RefreshList event, Emitter<LawEnforcementListState> emit) async {
    try {
      LawEnforcementListResponse response;

      response = await services.getListWithFilters(
        startPosition: '${0}',
        maximumRecords: '${20}',
        filters: BaseFilterModel(),
      );

      return emit(
        state.copyWith(
          todos: response.list,
          hasReachedMax: false,
          status: FormStatus.success,
        ),
      );
    } on Exception {
      return emit(state.copyWith(status: FormStatus.failure));
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
        log('-_fetchMaterialMovements--initial--');
        LawEnforcementListResponse response;
        // response = await services.getMaterialMovements(
        //   startPosition: '${event.startPos}',
        //   maximumRecords: '${event.maxPos}',
        //   mmType: isInward ? 1 : 0,
        // );

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

      log('-_fetchMaterialMovements------##--');
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
