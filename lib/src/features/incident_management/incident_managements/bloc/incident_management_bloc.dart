import 'dart:async';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/incident_management/models/im_ui_labels.dart';
import 'package:db_atom/src/services/common_services.dart';

import '../../models/incidents_response.dart';
import '../../services/incident_management_services.dart';

part 'incident_management_event.dart';
part 'incident_management_state.dart';

class IncidentManagementsBloc
    extends Bloc<IncidentManagementsEvent, IncidentManagementsState> {
  final String? occId;
  final int? occType;
  final int? kldId;

  IncidentManagementsBloc(
    this.occType,
    this.occId,
    this.kldId,
  ) : super(const IncidentManagementsState()) {
    on<InitializeValues>(_initializeValues);
    on<FetchData>(
      _fetchList,
      transformer: droppable(),
    );
    on<RefreshList>(
      _refreshList,
      transformer: droppable(),
    );
  }

  final IncidentManagementServices _services = IncidentManagementServices();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeValues event, Emitter<IncidentManagementsState> emit) async {
    try {
      emit(state.copyWith(status: FormStatus.loading));
      List<Organisation> statuses = await commonServices.getStatusesByModuleId(
          module: Constants.incidentManagementModule);

      List<Organisation> regions =
          await commonServices.getRegionsOrLocationsByRegionId();

      CommonFilters commonFilters =
          CommonFilters(regions: regions, statuses: statuses);

      Locations locations =
          await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');

      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(),
          moduleCode: Constants.incidentManagementModule);

      ExtraProperties extraProperties =
          await UtilsCommon().checkWritePermission(
        moduleCode: Constants.incidentManagementModule,
        commonServices: commonServices,
      );
      IMUiLabels labels = IMUiLabels.fromJson(responseLabels);
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
      RefreshList event, Emitter<IncidentManagementsState> emit) async {
    try {
      IncidentsResponse response;

      response = await _services.getIncidents(
        startPosition: '${0}',
        maximumRecords: '${20}',
        // userId: '7',
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

//   FutureOr<void> _fetchList(
//       FetchData event, Emitter<IncidentManagementsState> emit) async {
//     try {
//       if (state.hasReachedMax) return;
//       if (state.status == FormStatus.initial) {
//         IncidentsResponse response = await _services.getIncidents(
//           startPosition: '${event.startPos}',
//           maximumRecords: '${event.maxPos}',
//           userId: '7',
//           occId: occId,
//           occType: occType,
//           filters: event.filters,
//         );
//
//         return emit(
//           state.copyWith(
//             items: response.items,
//             hasReachedMax: false,
//             status: FormStatus.success,
//           ),
//         );
//       }
//
//       IncidentsResponse response = await _services.getIncidents(
//         startPosition: '${event.startPos}',
//         maximumRecords: '${event.maxPos}',
//         userId: '7',
//         occId: occId,
//         occType: occType,
//       );
//
//       if (response.items?.isEmpty == true) {
//         return emit(state.copyWith(hasReachedMax: true));
//       }
//       return emit(
//         state.copyWith(
//           items: List.of(state.items)..addAll(response.items ?? []),
//           hasReachedMax: false,
//         ),
//       );
//     } catch (e) {
//       return emit(state.copyWith(status: FormStatus.failure));
//     }
//   }
// }
  FutureOr<void> _fetchList(
      FetchData event, Emitter<IncidentManagementsState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    try {
      if (state.status == FormStatus.initial || event.newSearch) {
        IncidentsResponse response;
        response = await _services.getIncidents(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          // userId: '7',
          occId: occId,
          occType: occType,
          kldId: kldId,
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

      IncidentsResponse response;
      response = await _services.getIncidents(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
        // userId: '7',
        occId: occId,
        occType: occType,
        kldId: kldId,
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
