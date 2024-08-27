import 'dart:async';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/vvip_visitor/services/vvip_visitor_services.dart';

import '../../models/vvip_visitor_response_model.dart';

part 'vvip_visitors_event.dart';
part 'vvip_visitors_state.dart';

class VVIPVisitorsBloc extends Bloc<VVIPVisitorsEvent, VVIPVisitorsState> {
  VVIPVisitorsBloc() : super(const VVIPVisitorsState()) {
    on<InitializeValues>(_initializeValues);
    on<FetchData>(
      _fetchVVIPVisitors,
      transformer: droppable(),
    );
    on<RefreshList>(
      _refreshList,
      transformer: droppable(),
    );
  }

  final VVIPVisitorServices services = VVIPVisitorServices();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _refreshList(
      RefreshList event, Emitter<VVIPVisitorsState> emit) async {
    try {
      VVIPVisitorResponseModel response;

      response = await services.getGVVIP(
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

  FutureOr<void> _initializeValues(
      InitializeValues event, Emitter<VVIPVisitorsState> emit) async {
    try {
      emit(state.copyWith(status: FormStatus.loading));

      ExtraProperties extraProperties =
          await UtilsCommon().checkWritePermission(
        moduleCode: Constants.vipVisitorsDetailsModule,
        commonServices: commonServices,
      );

      List<Organisation> statuses = await commonServices.getStatusesByModuleId(
          module: Constants.vipVisitorsDetailsModule);

      List<Organisation> regions =
          await commonServices.getRegionsOrLocationsByRegionId();

      CommonFilters commonFilters =
          CommonFilters(regions: regions, statuses: statuses);

      Locations locations =
          await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');

      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(),
          moduleCode: Constants.vipVisitorsDetailsModule);

      SlaUiLabels labels = SlaUiLabels.fromJson(responseLabels);
      return emit(
        state.copyWith(
          locations: locations,
          regions: regions,
          statuses: statuses,
          labels: labels,
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

  //
  // FutureOr<void> _fetchVVIPVisitors(
  //     FetchData event, Emitter<VVIPVisitorsState> emit) async {
  //   try {
  //     if (state.hasReachedMax) return;
  //
  //     if (state.status == FormStatus.initial) {
  //       VVIPVisitorResponseModel response = await services.getGVVIP(
  //         startPosition: '${event.startPos}',
  //         maximumRecords: '${event.maxPos}',
  //         filters: event.filters
  //       );
  //
  //       return emit(
  //         state.copyWith(
  //           items: response.items,
  //           hasReachedMax: false,
  //           status: FormStatus.success,
  //         ),
  //       );
  //     }
  //
  //     VVIPVisitorResponseModel response = await services.getGVVIP(
  //       startPosition: '${event.startPos}',
  //       maximumRecords: '${event.maxPos}',
  //         filters: event.filters
  //     );
  //
  //     if (response.items?.isEmpty == true) {
  //       return emit(state.copyWith(hasReachedMax: true));
  //     }
  //     return emit(
  //       state.copyWith(
  //         items: List.of(state.items)..addAll(response.items ?? []),
  //         hasReachedMax: false,
  //       ),
  //     );
  //   } on TokenExpiredException catch (e) {
  //     emit(
  //       state.copyWith(
  //         message: e.message,
  //         status: FormStatus.sessionExpired,
  //       ),
  //     );
  //     return;
  //   } catch (e) {
  //     return emit(state.copyWith(status: FormStatus.failure));
  //   }
  // }

  FutureOr<void> _fetchVVIPVisitors(
      FetchData event, Emitter<VVIPVisitorsState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    try {
      // if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial || event.newSearch) {
        VVIPVisitorResponseModel response;
        response = await services.getGVVIP(
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

      VVIPVisitorResponseModel response;
      response = await services.getGVVIP(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
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
