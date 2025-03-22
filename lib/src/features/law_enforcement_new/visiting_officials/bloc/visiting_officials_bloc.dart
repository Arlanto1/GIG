import 'dart:async';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/vvip_visitor/models/vvip_ui_labels.dart';
import 'package:db_atom/src/features/law_enforcement_new/services/law_enforcement_services_new.dart';
import 'package:db_atom/src/features/law_enforcement_new/visiting_officials/models/requestModels/visitingOfficialsRequest.dart';

part 'visiting_officials_event.dart';
part 'visiting_officials_state.dart';

class VisitingOfficialsBloc
    extends Bloc<VisitingOfficialsEvent, VisitingOfficialsState> {
  VisitingOfficialsBloc() : super(const VisitingOfficialsState()) {
    on<FetchVisitingOfficialsData>(
      _fetchContacts,
      transformer: droppable(),
    );
    on<InitializeValues>(_initializeValues);
    on<SaveRecord>(_saveRecord);
    on<DeleteRecord>(_deleteRecord);
  }

  final LawEnforcementServicesNew services = LawEnforcementServicesNew();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeValues event, Emitter<VisitingOfficialsState> emit) async {}

  FutureOr<void> _fetchContacts(
      FetchVisitingOfficialsData event, Emitter<VisitingOfficialsState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial) {
        List<VisitingOfficialsModel> response =
        await services.getLeoVisitingOfficials(
          id: event.id,
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

      // List<VIVPVisitorRecordModel> response =
      //     await services.getVVIPVisitorRecordsList(
      //   id: '${event.id}',
      //   // type: '${event.type}',
      // );
      //
      // if (response.isEmpty == true) {
      //   return emit(state.copyWith(hasReachedMax: true));
      // }
      // return emit(
      //   state.copyWith(
      //     items: List.of(state.items ?? [])..addAll(response),
      //     hasReachedMax: false,
      //   ),
      // );
    } catch (e) {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }

  FutureOr<void> _deleteRecord(
      DeleteRecord event, Emitter<VisitingOfficialsState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    try {
      await LawEnforcementServicesNew().deleteVisitingOfficial(event.id);
      List<VisitingOfficialsModel> response =
      await services.getLeoVisitingOfficials(
        id: event.mainContactId,
      );
      return emit(
        state.copyWith(items: response, status: FormStatus.success),
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

  FutureOr<void> _saveRecord(
      SaveRecord event, Emitter<VisitingOfficialsState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    try {
      VisitingOfficialsRequest request = VisitingOfficialsRequest();

      request.visitingOfficials = event.visitingOfficialsModel;
      await LawEnforcementServicesNew().createVisitingOfficial(
          body: request, parentId: event.mainContactId);

      /// Refresh list
      List<VisitingOfficialsModel> response =
      await services.getLeoVisitingOfficials(
        id: event.mainContactId,
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
          status: FormStatus.formError,
        ),
      );
      return;
    } on Exception catch (e) {
      return UtilsCommon().exceptionHandling(e, emit, state);
    }
  }
}
