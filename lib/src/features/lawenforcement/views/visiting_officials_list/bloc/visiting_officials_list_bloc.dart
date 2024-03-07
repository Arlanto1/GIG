import 'dart:async';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/lawenforcement/services/law_enforcement_services.dart';
import 'package:db_atom/src/services/common_services.dart';

part 'visiting_officials_list_event.dart';
part 'visiting_officials_list_state.dart';

class VisitingOfficialListBloc
    extends Bloc<VisitingOfficialListEvent, VisitingOfficialListState> {
  final int parentId;
  List<Organisation> departments;

  VisitingOfficialListBloc({
    required this.parentId,
    required this.departments,
  }) : super(VisitingOfficialListState(departments: departments)) {
    on<FetchData>(
      _fetchContacts,
      transformer: droppable(),
    );
    on<InitializeValues>(_initializeValues);
    on<SaveRecord>(_saveRecord);
    on<DeleteRecord>(_deleteRecord);
  }

  final LawEnforcementServices services = LawEnforcementServices();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeValues event, Emitter<VisitingOfficialListState> emit) async {
    try {
      List<LawVisitingOfficial> items =
          await services.getLeoVisitingOfficials(id: parentId);

      LeoDepartments leodepartments =
          await services.getLeodepartments('ATOM_LEO_DEPARTMENTS');

      return emit(
        state.copyWith(
          items: items,
          departments: departments,
          hasReachedMax: false,
        ),
      );
    } on Exception {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }

  FutureOr<void> _fetchContacts(
      FetchData event, Emitter<VisitingOfficialListState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial) {
        List<LawVisitingOfficial> response =
            await services.getLeoVisitingOfficials(
          id: event.id,
        );
        return emit(
          state.copyWith(
            items: response,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );
      }

      List<LawVisitingOfficial> response =
          await services.getLeoVisitingOfficials(
        id: event.id,
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

  FutureOr<void> refreshList() async {
    emit(state.copyWith(status: FormStatus.loading));
    List<Organisation> departments = await commonServices.getOrganisations(
        name: parentId == Constants.contactGeneralRank
            ? 'CONTACT_GENERAL_RANK'
            : parentId == Constants.contactGuardingAgencyEscalationRank
                ? 'CONTACT_GUARDING_AGENCY_ESCALATION_RANK'
                : parentId == Constants.contactSystemEscalationRank
                    ? 'CONTACT_SYSTEM_ESCALATION_RANK'
                    : parentId == Constants.contactSupervisorRank
                        ? 'CONTACT_SUPERVISOR_RANK'
                        : parentId == Constants.contactZone
                            ? 'CONTACT_ZONE'
                            : '');
    emit(
      state.copyWith(
        status: FormStatus.initial,
        // ranks: departments,
      ),
    );
  }

  FutureOr<void> _deleteRecord(
      DeleteRecord event, Emitter<VisitingOfficialListState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    try {
      await services.deleteVisitingOfficial(event.id);

      List<LawVisitingOfficial> response =
          await services.getLeoVisitingOfficials(
        id: event.parentId,
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
      SaveRecord event, Emitter<VisitingOfficialListState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    try {
      LawVisitingOfficialRequest request = LawVisitingOfficialRequest();

      request.visitingOfficials = event.model;
      await services.createVisitingOfficial(
        parentId: event.parentId,
        body: request,
      );

      List<LawVisitingOfficial> response =
          await services.getLeoVisitingOfficials(
        id: event.parentId,
      );

      /// Refresh list
      // ContactsListModel response = await services.getContactListByType(
      //   id: '${event.parentId}',
      //   type: '${event.type}',
      // );
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
}
