import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:db_atom/src/features/createfound/models/get_depositor_model.dart';
import 'package:db_atom/src/models/base_user.dart';
import 'package:db_atom/src/services/CommonServices.dart';
import 'package:equatable/equatable.dart';

import '../../../../enums/form_status.dart';
import '../../models/contacts_list_response_model.dart';
import '../../services/contact_details_services.dart';

part 'contact_listing_event.dart';
part 'contact_listing_state.dart';

class ContactListingBloc
    extends Bloc<ContactListingEvent, ContactListingState> {
  ContactListingBloc() : super(const ContactListingState()) {
    on<FetchData>(
      _fetchMaterialMovements,
      transformer: droppable(),
    );
    on<InitializeValues>(_initializeValues);
  }

  final ContactDetailsServices services = ContactDetailsServices();

  FutureOr<void> _fetchMaterialMovements(
      FetchData event, Emitter<ContactListingState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial) {
        ContactListResponseModel response = await services.getCd(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
        );

        return emit(
          state.copyWith(
            items: response.items,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );
      }

      ContactListResponseModel response =
      await services.getCd(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
      );

      if (response.items?.isEmpty == true) {
        return emit(state.copyWith(hasReachedMax: true));
      }
      return emit(
        state.copyWith(
          items: List.of(state.items)..addAll(response.items ?? []),
          hasReachedMax: false,
        ),
      );
    } catch (e) {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }

  CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeValues event, Emitter<ContactListingState> emit) async {
    try {
      GetDepositor users =
          await commonServices.getAtomStaticUsers(roleName: 'ATOM_STATIC_USER');

      return emit(
        state.copyWith(
          users: users.atomStaticUser,
          hasReachedMax: false,
        ),
      );
    } on Exception catch (e) {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }
}
