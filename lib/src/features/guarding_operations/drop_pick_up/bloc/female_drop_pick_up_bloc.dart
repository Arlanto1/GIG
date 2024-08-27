import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/models/drop_pick_up_response.dart';
import 'package:equatable/equatable.dart';

import '../../../../enums/form_status.dart';
import '../../guarding_rate/services/guarding_services.dart';

part 'female_drop_pick_up_event.dart';
part 'female_drop_pick_up_state.dart';

class FemaleDropPickUpBloc
    extends Bloc<FemaleDropPickUpEvent, FemaleDropPickUpState> {
  FemaleDropPickUpBloc() : super(const FemaleDropPickUpState()) {
    on<FetchList>(
      _fetchList,
      transformer: droppable(),
    );
  }

  final GuardingServices _services = GuardingServices();

  FutureOr<void> _fetchList(
      FetchList event, Emitter<FemaleDropPickUpState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial) {
        DropPickUpResponse response = await _services.getFemaleDropPickUps(
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

      DropPickUpResponse response = await _services.getFemaleDropPickUps(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
        userId: '77', //TODO: make it dynamic
      );

      log('-getMaterialMovements----2-----$response----');

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
