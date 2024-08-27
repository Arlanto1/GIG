import 'dart:async';
import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_master/services/duty_post_master_services.dart';

part 'duty_post_master_list_event.dart';
part 'duty_post_master_list_state.dart';

class DutyPostMasterListBloc
    extends Bloc<DutyPostMasterListEvent, DutyPostMasterListState> {
  DutyPostMasterListBloc() : super(const DutyPostMasterListState()) {
    on<InitializeValues>(_initializeValues);
    on<FetchDutyPostMasterList>(
      _fetchList,
      transformer: droppable(),
    );
    on<RefreshList>(
      _refreshList,
      transformer: droppable(),
    );
  }

  final DutyPostMasterServices _services = DutyPostMasterServices();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeValues event, Emitter<DutyPostMasterListState> emit) async {
    try {
      emit(state.copyWith(status: FormStatus.loading));

      ExtraProperties extraProperties =
          await UtilsCommon().checkWritePermission(
        moduleCode: Constants.shiftScheduleModuleCode,
        commonServices: commonServices,
      );

      List<Organisation> statuses = await commonServices.getStatusesByModuleId(
          module: Constants.shiftScheduleModuleCode);

      List<Organisation> regions =
          await commonServices.getRegionsOrLocationsByRegionId();

      CommonFilters commonFilters =
          CommonFilters(regions: regions, statuses: statuses);

      Locations locations =
          await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');

      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(),
          moduleCode: Constants.shiftScheduleModuleCode);

      SSUiLabels labels = SSUiLabels.fromJson(responseLabels);
      return emit(
        state.copyWith(
          locations: locations,
          regions: regions,
          labels: labels,
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
      RefreshList event, Emitter<DutyPostMasterListState> emit) async {
    try {
      DutyPostMasterResponse response;

      response = await _services.getList(
        startPosition: '${0}',
        maximumRecords: '${20}',
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

  // FutureOr<void> _fetchList(
  //     FetchDutyPostMasterList event, Emitter<DutyPostMasterListState> emit) async {
  //   try {
  //     if (state.hasReachedMax) return;
  //
  //     if (state.status == FormStatus.initial) {
  //       DutyPostMasterResponse getDutyPostMasters =
  //       await _services.getList(
  //         startPosition: '${event.startPos}',
  //         maximumRecords: '${event.maxPos}',
  //         filters: event.filters,
  //         // userId: '7',
  //         // locationId: '56',
  //       );
  //       return emit(
  //         state.copyWith(
  //           items: getDutyPostMasters.items,
  //           hasReachedMax: false,
  //           status: FormStatus.success,
  //         ),
  //       );
  //     }
  //
  //     DutyPostMasterResponse getDutyPostMaster =
  //     await _services.getList(
  //       startPosition: '${event.startPos}',
  //       maximumRecords: '${event.maxPos}',
  //       filters: event.filters,
  //     );
  //
  //     if (getDutyPostMaster.items?.isEmpty == true) {
  //       return emit(state.copyWith(hasReachedMax: true));
  //     }
  //     return emit(
  //       state.copyWith(
  //         items: List.of(state.list)
  //           ..addAll(getDutyPostMaster.items?.toList() ?? []),
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
  FutureOr<void> _fetchList(FetchDutyPostMasterList event,
      Emitter<DutyPostMasterListState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    try {
      // if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial || event.newSearch) {
        DutyPostMasterResponse response;
        response = await _services.getList(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          filters: event.filters,
        );

        for (DutyPostMasterModel model in response.items ?? []) {
          log('---model.total- ${model.total}-${model.id}---');
        }

        return emit(
          state.copyWith(
            items: response.items,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );
      }

      DutyPostMasterResponse response;
      response = await _services.getList(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
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
