import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:db_atom/src/features/material_movement/models/material_movement_model.dart';
import 'package:db_atom/src/features/material_movement/models/material_movements_model.dart';
import 'package:equatable/equatable.dart';

import '../../../../enums/form_status.dart';
import '../../services/contact_details_services.dart';

part 'contact_details_list_event.dart';
part 'contact_details_list_state.dart';

class ContactDetailsListBloc
    extends Bloc<ContactDetailsListEvent, ContactDetailsListState> {

  ContactDetailsListBloc()
      : super(const ContactDetailsListState()) {
    on<FetchData>(
      _fetchMaterialMovements,
      transformer: droppable(),
    );
  }

  final ContactDetailsServices services =
  ContactDetailsServices();

  FutureOr<void> _fetchMaterialMovements(
      FetchData event, Emitter<ContactDetailsListState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial) {
        MaterialMovementsModel response =
            await services.getMaterialMovements(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          userId: '77',
        );

        return emit(
          state.copyWith(
            items: response.items,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );
      }

      MaterialMovementsModel response =
          await services.getMaterialMovements(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
        userId: '77', //TODO: make it dynamic
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
}
