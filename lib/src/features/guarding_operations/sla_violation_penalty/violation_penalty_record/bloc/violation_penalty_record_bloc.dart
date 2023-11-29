import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:db_atom/src/enums/form_status.dart';
import 'package:db_atom/src/features/guarding_operations/sla_violation_penalty/services/sla_violation_penalty_services.dart';
import 'package:db_atom/src/models/organisation.dart';
import 'package:db_atom/src/models/responseModels/generic_response.dart';
import 'package:db_atom/src/services/CommonServices.dart';
import 'package:equatable/equatable.dart';
import '../../models/requestModels/violation_penalty_request.dart';
import '../../models/violation_penalty_list_response_model.dart';
import '../../models/violation_penalty_model.dart';


part 'violation_penalty_record_event.dart';

part 'violation_penalty_record_state.dart';

class ViolationPenaltyRecordBloc extends Bloc<ViolationPenaltyRecordEvent, ViolationPenaltyRecordState> {
  ViolationPenaltyRecordBloc() : super(const ViolationPenaltyRecordState()) {
    on<FetchData>(
      _fetchContacts,
      transformer: droppable(),
    );
    on<InitializeValues>(_initializeValues);
    on<SaveRecord>(_saveRecord);
    on<DeleteRecord>(_deleteRecord);
  }

  final SLAViolationPenaltyServices services = SLAViolationPenaltyServices();

  FutureOr<void> _fetchContacts(
      FetchData event, Emitter<ViolationPenaltyRecordState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial) {
        ViolationPenaltyListModel response = await services.getViolationPenaltyListByType(
          id: '${event.id}',
         // type: '${event.type}',
        );
        return emit(
          state.copyWith(
            items: response.violationPenalties,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );
      }

      ViolationPenaltyListModel response = await services.getViolationPenaltyListByType(
        id: '${event.id}',
       // type: '${event.type}',
      );

      if (response.violationPenalties?.isEmpty == true) {
        return emit(state.copyWith(hasReachedMax: true));
      }
      return emit(
        state.copyWith(
          items: List.of(state.items ?? [])..addAll(response.violationPenalties ?? []),
          hasReachedMax: false,
        ),
      );
    } catch (e) {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }

  CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeValues event, Emitter<ViolationPenaltyRecordState> emit) async {
    // try {
      // ContactRankResponse response =
      // await commonServices.getRanks(name: 'CONTACT_GENERAL_RANK');
      //
      // return emit(
      //   state.copyWith(
      //     ranks: response.ranks,
      //     hasReachedMax: false,
      //   ),
      // );
    // } on Exception {
    //   return emit(state.copyWith(status: FormStatus.failure));
    // }
  }

  FutureOr<void> _deleteRecord(
      DeleteRecord event, Emitter<ViolationPenaltyRecordState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    try {
      await SLAViolationPenaltyServices().deleteCdById(event.id);
      ViolationPenaltyListModel response = await services.getViolationPenaltyListByType(
        id: '${event.mainContactId}',
      //  type: '${event.type}',
      );

      return emit(
        state.copyWith(
            items: response.violationPenalties,
            status: FormStatus.success),
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

      //request.cit = event.contactInfo;
      await SLAViolationPenaltyServices()
          .createContactRecord(body: request, isSubmit: false);

      /// Refresh list
      ViolationPenaltyListModel response = await services.getViolationPenaltyListByType(
        id: '${event.mainContactId}',
       // type: '${event.type}',
      );
      return emit(
        state.copyWith(
            items: response.violationPenalties,
            status: FormStatus.success),
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
