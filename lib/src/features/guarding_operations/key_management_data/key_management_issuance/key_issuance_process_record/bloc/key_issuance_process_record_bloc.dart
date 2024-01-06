import 'dart:async';
import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_issuance/models/requestModels/key_issuance_process_request.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_issuance/services/key_management_issuance_services.dart';
import 'package:db_atom/src/services/CommonServices.dart';

part 'key_issuance_process_record_event.dart';

part 'key_issuance_process_record_state.dart';

class KeyIssuanceProcessRecordBloc
    extends Bloc<KeyIssuanceProcessRecordEvent, KeyIssuanceProcessRecordState> {
  final int locationId;
  final int parentId;

  KeyIssuanceProcessRecordBloc({
    required this.locationId,
    required this.parentId,
  }) : super(const KeyIssuanceProcessRecordState()) {
    on<FetchData>(
      _fetchContacts,
      transformer: droppable(),
    );
    on<InitializeValues>(_initializeValues);
    on<SaveRecord>(_saveRecord);
    on<DeleteRecord>(_deleteRecord);
  }

  final KeyManagementIssuanceServices services =
      KeyManagementIssuanceServices();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(InitializeValues event,
      Emitter<KeyIssuanceProcessRecordState> emit) async {
    try {
      // List<Organisation> items =
      //     await commonServices.getOrganisations(name: violationDescription);
      List<Organisation> keyDescriptions = await KeyManagementIssuanceServices()
          .getKeyDescriptionValues(locationId: locationId);

      log('---keyDescriptions-bloc--${keyDescriptions.length}-');
      for(Organisation org in keyDescriptions) {
        log('-keyDescriptions--${org.keyDescription}-');
      }
      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(),
          moduleCode: Constants.slaViolationPenaltyDetailsModuleCode);
      SlaUiLabels labels = SlaUiLabels.fromJson(responseLabels);

      return emit(
        state.copyWith(
          hasReachedMax: false,
          labels: labels,
          keyDescriptions: keyDescriptions,
        ),
      );
    } on Exception {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }

  FutureOr<void> _fetchContacts(
      FetchData event, Emitter<KeyIssuanceProcessRecordState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial) {
        List<KeyIssuanceProcessRecord> response =
            await services.getIssuanceProcessList(
          id: '${event.id}',
          // type: '${event.type}',
        );
        return emit(
          state.copyWith(
            items: response,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );
      }

      List<KeyIssuanceProcessRecord> response =
          await services.getIssuanceProcessList(
        id: '${event.id}',
        // type: '${event.type}',
      );

      if (response.isEmpty == true) {
        return emit(state.copyWith(hasReachedMax: true));
      }
      return emit(
        state.copyWith(
          items: List.of(state.items ?? [])..addAll(response),
          hasReachedMax: false,
        ),
      );
    } catch (e) {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }

  FutureOr<void> _deleteRecord(
      DeleteRecord event, Emitter<KeyIssuanceProcessRecordState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    try {
      await KeyManagementIssuanceServices().deleteVpById(event.id);
      List<KeyIssuanceProcessRecord> response =
          await services.getIssuanceProcessList(
        id: '${event.mainIssuanceId}',
      );
      return emit(
        state.copyWith(items: response, status: FormStatus.success),
      );
    } on GenericResponse catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.error,
        ),
      );
      return;
    } on Exception {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }

  FutureOr<void> _saveRecord(
      SaveRecord event, Emitter<KeyIssuanceProcessRecordState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    try {
      KeyIssuanceProcessRecordRequest request =
          KeyIssuanceProcessRecordRequest();

      request.vp = event.keyIssuanceProcessRecord;
      await KeyManagementIssuanceServices().createIssuanceProcessRecord(
          body: request, isSubmit: false, kmiId: 0);

      /// Refresh list
      List<KeyIssuanceProcessRecord> response =
          await services.getIssuanceProcessList(
        id: '${event.mainIssuanceId}',
        // type: '${event.type}',
      );
      return emit(state.copyWith(
        items: response,
        hasReachedMax: false,
        status: FormStatus.success,
      ));
    } on GenericResponse catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.error,
        ),
      );
      return;
    } on Exception {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }
}
