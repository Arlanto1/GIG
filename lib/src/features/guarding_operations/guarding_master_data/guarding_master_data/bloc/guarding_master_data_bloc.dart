import 'dart:async';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_master_data/services/guarding_master_data_services.dart';
import 'package:db_atom/src/services/common_services.dart';

part 'guarding_master_data_event.dart';
part 'guarding_master_data_state.dart';

class GuardingMasterDataBloc
    extends Bloc<GuardingMasterDataEvent, GuardingMasterDataState> {
  GuardingMasterDataBloc() : super(const GuardingMasterDataState()) {
    on<InitializeValuesGMD>(_initializeValues);
    on<FetchDataList>(
      _fetchList,
      transformer: droppable(),
    );
    on<RefreshLists>(
      _refreshList,
      transformer: droppable(),
    );
  }

  final GuardingMasterDataServices _services = GuardingMasterDataServices();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeValuesGMD event, Emitter<GuardingMasterDataState> emit) async {
    try {
      emit(state.copyWith(status: FormStatus.loading));
      List<Organisation> statuses = await commonServices.getStatusesByModuleId(
          module: Constants.guardingMasterDataModule);

      List<Organisation> regions =
          await commonServices.getRegionsOrLocationsByRegionId();

      CommonFilters commonFilters =
          CommonFilters(regions: regions, statuses: statuses);

      Locations locations =
          await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');

      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(),
          moduleCode: Constants.guardingMasterModuleCode);

      ExtraProperties extraProperties =
          await UtilsCommon().checkWritePermission(
        moduleCode: Constants.guardingMasterModuleCode,
        commonServices: commonServices,
      );
      GmUiLabels labels = GmUiLabels.fromJson(responseLabels);
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
      RefreshLists event, Emitter<GuardingMasterDataState> emit) async {
    try {
      GuardingMasterDataResponse response;

      response = await _services.getGuardingMasterData(
        startPosition: '${0}',
        maximumRecords: '${20}',
        // locationId: '56',
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
  //     FetchDataList event, Emitter<GuardingMasterDataState> emit) async {
  //   try {
  //     if (state.hasReachedMax) return;
  //
  //     if (state.status == FormStatus.initial) {
  //       GuardingMasterDataResponse getGuardingMaterialDatas =
  //           await _services.getGuardingMasterData(
  //         startPosition: '${event.startPos}',
  //         maximumRecords: '${event.maxPos}',
  //         filters: event.filters,
  //         // locationId: '56',
  //       );
  //       return emit(
  //         state.copyWith(
  //           items: getGuardingMaterialDatas.items,
  //           hasReachedMax: false,
  //           status: FormStatus.success,
  //         ),
  //       );
  //     }
  //
  //     GuardingMasterDataResponse getGuardingMasterData =
  //         await _services.getGuardingMasterData(
  //       startPosition: '${event.startPos}',
  //       maximumRecords: '${event.maxPos}',
  //       filters: event.filters,
  //       // locationId: '56',
  //     );
  //
  //     if (getGuardingMasterData.items?.isEmpty == true) {
  //       return emit(state.copyWith(hasReachedMax: true));
  //     }
  //     return emit(
  //       state.copyWith(
  //         items: List.of(state.list)
  //           ..addAll(getGuardingMasterData.items?.toList() ?? []),
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
  FutureOr<void> _fetchList(
      FetchDataList event, Emitter<GuardingMasterDataState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    try {
      if (state.status == FormStatus.initial || event.newSearch) {
        GuardingMasterDataResponse response;
        response = await _services.getGuardingMasterData(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
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

      GuardingMasterDataResponse response;
      response = await _services.getGuardingMasterData(
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
