import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/models/base_filter_model.dart';
import 'package:db_atom/src/models/organisation.dart';
import 'package:db_atom/src/models/responseModels/token_expired.dart';
import 'package:db_atom/src/services/common_services.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:equatable/equatable.dart';

import '../../../../enums/form_status.dart';
import '../../models/incidents_response.dart';
import '../../services/incident_management_services.dart';

part 'incident_management_event.dart';
part 'incident_management_state.dart';

class IncidentManagementsBloc
    extends Bloc<IncidentManagementsEvent, IncidentManagementsState> {
  final String? occId;
  final int? occType;

  IncidentManagementsBloc(
    this.occType,
    this.occId,
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
          module: Constants.eventProtectionModule);

      List<Organisation> regions =
          await commonServices.getRegionsOrLocationsByRegionId();

      CommonFilters commonFilters =
          CommonFilters(regions: regions, statuses: statuses);

      Locations locations =
          await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');

      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(),
          moduleCode: Constants.eventProtectionModuleCode);
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
      RefreshList event, Emitter<IncidentManagementsState> emit) async {
    try {
      IncidentsResponse response;

      response = await _services.getIncidents(
        startPosition: '${0}',
        maximumRecords: '${20}',
        userId: '7',
        filters: BaseFilterModel(),
      );

      return emit(
        state.copyWith(
          items: response.items,
          hasReachedMax: false,
          status: FormStatus.success,
        ),
      );
    } on Exception {
      return emit(state.copyWith(status: FormStatus.failure));
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
          userId: '7',
          occId: occId,
          occType: occType,
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
        userId: '7',
        occId: occId,
        occType: occType,
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
