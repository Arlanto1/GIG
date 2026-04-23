
import 'dart:async';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/incident_management/models/im_ui_labels.dart';
import 'package:db_atom/src/features/transport_medical_incident/models/transport_medical_incident_model.dart';
import 'package:db_atom/src/features/transport_medical_incident/services/transport_medical_service.dart';
part 'transport_medical_list_event.dart';
part 'transport_medical_list_state.dart';

class TransportMedicalBloc
    extends Bloc<TransportMedicalEvent, TransportMedicalState> {
  final bool isTransport;
  TransportMedicalBloc({required this.isTransport}
      ) : super(const TransportMedicalState()) {
    on<InitializeValuesTM>(_initializeValues);
    on<FetchTMData>(
      _fetchList,
      transformer: droppable(),
    );
    on<RefreshList>(
      _refreshList,
      transformer: droppable(),
    );
  }

  final TransportMedicalServices _services = TransportMedicalServices();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeValuesTM event, Emitter<TransportMedicalState> emit) async {


    try {
      emit(state.copyWith(status: FormStatus.loading));

      ExtraProperties extraProperties =
      await UtilsCommon().checkWritePermission(
        moduleCode: Constants.incidentManagementModule,
        commonServices: commonServices,
      );

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

      IMUiLabels labels = IMUiLabels.fromJson(responseLabels);
      return emit(
        state.copyWith(
          locations: locations,
          regions: regions,
          statuses: statuses,
          commonFilters: commonFilters,
          hasReachedMax: false,
          status: FormStatus.success,
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
      RefreshList event, Emitter<TransportMedicalState> emit) async {
    try {
      TransportMedicalResponse response;

      response = await _services.getTransportMedicalList(
        startPosition: '0',
        maximumRecords: '20',
        // userId: '7',
        filters: BaseFilterModel(), incidentType: isTransport? 0 :1,

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


  FutureOr<void> _fetchList(
      FetchTMData event, Emitter<TransportMedicalState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    try {
      if (state.status == FormStatus.initial || event.newSearch) {
        TransportMedicalResponse response;
        response = await _services.getTransportMedicalList(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          incidentType: isTransport? 0 :1,
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

      TransportMedicalResponse response;
      response = await _services.getTransportMedicalList(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
        // userId: '7',
        incidentType: isTransport? 0 :1,
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
