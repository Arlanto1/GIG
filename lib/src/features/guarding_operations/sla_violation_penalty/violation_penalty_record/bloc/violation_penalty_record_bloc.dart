import 'dart:async';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/sla_violation_penalty/services/sla_violation_penalty_services.dart';
import 'package:db_atom/src/services/common_services.dart';

part 'violation_penalty_record_event.dart';
part 'violation_penalty_record_state.dart';

class ViolationPenaltyRecordBloc
    extends Bloc<ViolationPenaltyRecordEvent, ViolationPenaltyRecordState> {
  final String violationDescription;
  final List<Organisation> violationDescriptions;

  ViolationPenaltyRecordBloc(
      {required this.violationDescription, required this.violationDescriptions})
      : super(ViolationPenaltyRecordState(
            violationDescriptions: violationDescriptions)) {
    on<FetchData>(
      _fetchContacts,
      transformer: droppable(),
    );
    on<InitializeValues>(_initializeValues);
    on<SaveRecord>(_saveRecord);
    on<DeleteRecord>(_deleteRecord);
  }

  final SLAViolationPenaltyServices services = SLAViolationPenaltyServices();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeValues event, Emitter<ViolationPenaltyRecordState> emit) async {
    try {
      List<Organisation> violationDescriptions =
          await commonServices.getOrganisations(name: violationDescription);

      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(),
          moduleCode: Constants.slaViolationPenaltyDetailsModuleCode);
      SlaUiLabels labels = SlaUiLabels.fromJson(responseLabels);
      Map<String, dynamic> staffCategoriesValues =
          await SLAViolationPenaltyServices().getStaffCategoriesValues();
      return emit(
        state.copyWith(
          violationDescriptions: violationDescriptions,
          hasReachedMax: false,
          labels: labels,
          staffCategoriesValues: staffCategoriesValues,
        ),
      );
    } on Exception {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }

  FutureOr<void> _fetchContacts(
      FetchData event, Emitter<ViolationPenaltyRecordState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial) {
        List<ViolationPenaltyRecord> response =
            await services.getViolationPenaltyList(
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

      List<ViolationPenaltyRecord> response =
          await services.getViolationPenaltyList(
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
      DeleteRecord event, Emitter<ViolationPenaltyRecordState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    try {
      await SLAViolationPenaltyServices().deleteVpById(event.id);
      List<ViolationPenaltyRecord> response =
          await services.getViolationPenaltyList(
        id: '${event.mainContactId}',
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
      SaveRecord event, Emitter<ViolationPenaltyRecordState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    try {
      ViolationPenaltyRecordRequest request = ViolationPenaltyRecordRequest();

      request.vp = event.violationPenaltyRecord;
      await SLAViolationPenaltyServices()
          .createViolationPenaltyRecord(body: request, isSubmit: false);

      /// Refresh list
      List<ViolationPenaltyRecord> response =
          await services.getViolationPenaltyList(
        id: '${event.mainContactId}',
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
