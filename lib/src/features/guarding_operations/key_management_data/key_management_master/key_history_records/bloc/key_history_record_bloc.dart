import 'dart:async';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_issuance/models/km_ui_labels.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/services/key_management_master_services.dart';
import 'package:db_atom/src/services/common_services.dart';

part 'key_history_record_event.dart';
part 'key_history_record_state.dart';

class KeyHistoryRecordBloc
    extends Bloc<KeyHistoryRecordEvent, KeyHistoryRecordState> {
  KeyHistoryRecordBloc() : super(const KeyHistoryRecordState()) {
    on<FetchData>(
      _fetchContacts,
      transformer: droppable(),
    );
    on<InitializeValues>(_initializeValues);
    on<SaveRecord>(_saveRecord);
    on<DeleteRecord>(_deleteRecord);
  }

  final KeyManagementMasterServices services = KeyManagementMasterServices();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeValues event, Emitter<KeyHistoryRecordState> emit) async {
    try {
      // TODO: Labels API call
      ExtraProperties extraProperties =
          await UtilsCommon().checkWritePermission(
        moduleCode: Constants.keyManagementMasterModule,
        commonServices: commonServices,
      );
      return emit(
        state.copyWith(
          hasReachedMax: false,
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

  FutureOr<void> _fetchContacts(
      FetchData event, Emitter<KeyHistoryRecordState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial) {
        List<KeyManagementMasterModel> response =
            await services.getKeyHistoryListByType(
          id: event.id,
          type: event.type,
        );
        return emit(
          state.copyWith(
            items: response,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );
      }

      List<KeyManagementMasterModel> response =
          await services.getKeyHistoryListByType(
        id: event.id,
        type: event.type,
      );

      if (response.isEmpty == true) {
        return emit(state.copyWith(hasReachedMax: true));
      }
      return emit(
        state.copyWith(
          items: List.of(state.list)..addAll(response),
          hasReachedMax: false,
        ),
      );
    } catch (e) {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }

  FutureOr<void> _deleteRecord(
      DeleteRecord event, Emitter<KeyHistoryRecordState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    try {
      await KeyManagementMasterServices().deleteKHdById(event.id);
      // ContactsListModel response = await services.getContactListByType(
      //   id: '${event.mainContactId}',
      //   type: '${event.type}',
      // );
      //
      // return emit(
      //   state.copyWith(items: response.contacts, status: FormStatus.success),
      // );
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

  FutureOr<void> _saveRecord(
      SaveRecord event, Emitter<KeyHistoryRecordState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    try {
      KeyHistoryRecordRequest request = KeyHistoryRecordRequest();

      // request.keyLossGi = event.contactInfo;
      // await KeyManagementMasterServices()
      //     .createKeyHistoryRecord(body: request, isSubmit: false);
      //
      // /// Refresh list
      // ContactsListModel response = await services.getContactListByType(
      //   id: '${event.mainContactId}',
      //   type: '${event.type}',
      // );
      // return emit(
      //   state.copyWith(items: response.contacts, status: FormStatus.success),
      // );
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
}
