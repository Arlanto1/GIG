import 'dart:async';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/security_systems/models/ssla_ui_labels.dart';
import 'package:db_atom/src/services/common_services.dart';

import '../../models/requestModel/general_info_request.dart';
import '../../models/sst_incident_response.dart';
import '../../services/sst_incident_services.dart';

part 'sst_incident_event.dart';
part 'sst_incident_state.dart';

class SstIncidentBloc extends Bloc<SstIncidentEvent, SstIncidentState> {
  final int ticketType;
  final int staffType;
  final String? occId;
  final SstIncident? model;

  SstIncidentBloc(
      {required this.ticketType,
      required this.staffType,
      this.occId,
      this.model})
      : super(const SstIncidentState()) {
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

  final SstIncidentServices _services = SstIncidentServices();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeValues event, Emitter<SstIncidentState> emit) async {
    try {
      emit(state.copyWith(status: FormStatus.loading));
      List<Organisation> statuses = await commonServices.getStatusesByModuleId(
          module: Constants.securitySystemModule);

      List<Organisation> regions =
          await commonServices.getRegionsOrLocationsByRegionId();

      CommonFilters commonFilters =
          CommonFilters(regions: regions, statuses: statuses);

      Locations locations =
          await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');

      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(),
          moduleCode: Constants.securitySystemModule);

      ExtraProperties extraProperties =
          await UtilsCommon().checkWritePermission(
        moduleCode: Constants.securitySystemModule,
        commonServices: commonServices,
      );
      SSLAUiLabels labels = SSLAUiLabels.fromJson(responseLabels);
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
      return UtilsCommon().eHandling(e, emit, state);
    }
  }

  FutureOr<void> _refreshList(
      RefreshList event, Emitter<SstIncidentState> emit) async {
    try {
      SstIncidentResponse response;

      response = await _services.get(
        startPosition: '${0}',
        maximumRecords: '${20}',
        // userId: '77',
        ticketType: ticketType,
        staffType: staffType,
        occId: occId,
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
      return UtilsCommon().eHandling(e, emit, state);
    }
  }

  FutureOr<void> _fetchList(
      FetchData event, Emitter<SstIncidentState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    try {
      // if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial || event.newSearch) {
        SstIncidentResponse response;
        response = await _services.get(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          filters: event.filters,
          ticketType: ticketType,
          staffType: staffType,
          occId: occId,
        );

        return emit(
          state.copyWith(
            items: response.items,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );
      }
      SstIncidentResponse response;
      response = await _services.get(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
        filters: event.filters,
        ticketType: ticketType,
        staffType: staffType,
        occId: occId,
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

  void sendRemainder(SstIncident model) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    SstIncidentServices services = SstIncidentServices();
    SecuritySystemTicketIncidentRequest request =
        SecuritySystemTicketIncidentRequest(sstIncident: model);

    GenericResponse response;
    try {
      response = await services.sendRemainder(
        body: request,
      );
      return emit(
        state.copyWith(
          message: response.message,
          status: FormStatus.sendEmail,
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
      emit(
        state.copyWith(
          message: e.toString(),
          status: FormStatus.error,
        ),
      );
      return;
    }
  }
}
