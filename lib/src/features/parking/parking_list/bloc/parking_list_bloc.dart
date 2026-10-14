import 'dart:async';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/parking/models/parking_model.dart';
import 'package:db_atom/src/features/parking/services/parking_service.dart';
part 'parking_list_event.dart';
part 'parking_list_state.dart';

class ParkingListBloc extends Bloc<ParkingListEvent, ParkingListState>{
  ParkingListBloc(): super(const ParkingListState(items: [])){
    on<InitializeValuesParking>(_initializeValues);
    on<RefreshParkingList>(_refreshList);
    on<FetchParkingData>(_fetchArticleList);
  }

  ParkingService services = ParkingService();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeValuesParking event, Emitter<ParkingListState> emit) async {
    try {
      emit(state.copyWith(status: FormStatus.loading));

      ExtraProperties extraProperties =
      await UtilsCommon().checkWritePermission(
        moduleCode: Constants.leoModuleCode,
        commonServices: commonServices,
      );

      List<Organisation> statuses = await commonServices.getStatusesByModuleId(
          module: Constants.articleFoundModuleCode);

      List<Organisation> regions =
      await commonServices.getRegionsOrLocationsByRegionId();

      CommonFilters commonFilters =
      CommonFilters(regions: regions, statuses: statuses);

      Locations locations =
      await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');

      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(),
          moduleCode: Constants.articleFoundModuleCode);

      AFUiLabels labels = AFUiLabels.fromJson(responseLabels);

      return emit(
        state.copyWith(
          location: locations,
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
      RefreshParkingList event, Emitter<ParkingListState> emit) async {
    try {
      final ParkingResponse response = await services
          .getParkingList(
        startPosition: '0',
        maximumRecords: '20',
        filters: BaseFilterModel(),
        // eventId: event.e
      );
      return emit(
        state.copyWith(
          items: response.items,
          hasReachedMax: false,
          status: FormStatus.success,
        ),
      );
    } on Exception catch(e){
      return UtilsCommon().exceptionHandling(e, emit, state);
    }
  }

  Future<void> _fetchArticleList(FetchParkingData event, Emitter<ParkingListState> emit) async {
    emit(
        state.copyWith(
            status: FormStatus.loading
        )
    );

    try {
      if (state.status == FormStatus.initial || event.newSearch) {
        ParkingResponse response;

        response = await services.getParkingList(
            startPosition: '${event.startPos}',
            maximumRecords: '${event.maxPos}',
            filters: event.filters,
        );

        return emit(
          state.copyWith(
            items: response.items,
            hasReachedMax: (response.items?.length ?? 0) < event.maxPos,
            status: FormStatus.success,
          ),
        );
      }

      ParkingResponse response;

      response = await services.getParkingList(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          // passType: 0,
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
    }

    on TokenExpiredException catch(e){
      emit(
          state.copyWith(
              message: e.message,
              status: FormStatus.sessionExpired
          )
      );
    } catch(e){
      return emit(
          state.copyWith(
              status: FormStatus.failure
          )
      );
    }
  }
}