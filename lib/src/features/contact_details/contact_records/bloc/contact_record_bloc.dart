import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:db_atom/src/enums/form_status.dart';
import 'package:db_atom/src/features/contact_details/models/contact_info.dart';
import 'package:db_atom/src/models/organisation.dart';
import 'package:db_atom/src/models/responseModels/generic_response.dart';
import 'package:db_atom/src/services/CommonServices.dart';
import 'package:equatable/equatable.dart';

import '../../models/contacts_list_response_model.dart';
import '../../models/requestModels/contacts_request.dart';
import '../../services/contact_details_services.dart';

part 'contact_record_event.dart';
part 'contact_record_state.dart';

class ContactRecordBloc extends Bloc<ContactRecordEvent, ContactRecordState> {
  final String rankType;

  ContactRecordBloc({required this.rankType})
      : super(const ContactRecordState(ranks: [])) {
    on<FetchData>(
      _fetchContacts,
      transformer: droppable(),
    );
    on<InitializeValues>(_initializeValues);
    on<SaveRecord>(_saveRecord);
    on<DeleteRecord>(_deleteRecord);
  }
  final ContactDetailsServices services = ContactDetailsServices();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeValues event, Emitter<ContactRecordState> emit) async {
    try {
      List<Organisation> items =
          await commonServices.getOrganisations(name: rankType);

      return emit(
        state.copyWith(
          ranks: items,
          hasReachedMax: false,
        ),
      );
    } on Exception {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }


  FutureOr<void> _fetchContacts(
      FetchData event, Emitter<ContactRecordState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial) {
        ContactsListModel response = await services.getContactListByType(
          id: '${event.id}',
          type: '${event.type}',
        );
        return emit(
          state.copyWith(
            items: response.contacts,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );
      }

      ContactsListModel response = await services.getContactListByType(
        id: '${event.id}',
        type: '${event.type}',
      );

      if (response.contacts?.isEmpty == true) {
        return emit(state.copyWith(hasReachedMax: true));
      }
      return emit(
        state.copyWith(
          items: List.of(state.items ?? [])..addAll(response.contacts ?? []),
          hasReachedMax: false,
        ),
      );
    } catch (e) {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }

  FutureOr<void> _deleteRecord(
      DeleteRecord event, Emitter<ContactRecordState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    try {
      await ContactDetailsServices().deleteCdById(event.id);
      ContactsListModel response = await services.getContactListByType(
        id: '${event.mainContactId}',
        type: '${event.type}',
      );

      return emit(
        state.copyWith(items: response.contacts, status: FormStatus.success),
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
      SaveRecord event, Emitter<ContactRecordState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    try {
      ContactRecordRequest request = ContactRecordRequest();

      request.cit = event.contactInfo;
      await ContactDetailsServices()
          .createContactRecord(body: request, isSubmit: false);

      /// Refresh list
      ContactsListModel response = await services.getContactListByType(
        id: '${event.mainContactId}',
        type: '${event.type}',
      );
      return emit(
        state.copyWith(items: response.contacts, status: FormStatus.success),
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
