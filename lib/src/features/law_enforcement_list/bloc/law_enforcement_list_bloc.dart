import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:db_atom/src/features/lawenforcement/services/law_enforcement_services.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../enums/form_status.dart';
import '../models/law_enforcement_list_response.dart';

part 'law_enforcement_list_event.dart';
part 'law_enforcement_list_state.dart';

class LawEnforcementListBloc
    extends Bloc<LawEnforcementListEvent, LawEnforcementListState> {
  LawEnforcementListBloc() : super(const LawEnforcementListState()) {
    // Initial Event
    on<LawEnforcementFetch>(
      _onTodoFetch,
      transformer: droppable(),
    );

    // Refresh Event
    on<LawEnforcementRefresh>(
      _onTodoRefresh,
      transformer: droppable(),
    );
  }

  final LawEnforcementServices services = LawEnforcementServices();

  FutureOr<void> _onTodoFetch(
      LawEnforcementFetch event, Emitter<LawEnforcementListState> emit) async {
    String userid = await SharedPrefs.getUserId();
    try {
      if (event.startPos == 0) {
        // state.lawEnforceItems.clear();
        emit(
          state.copyWith(
            todos: [],
            hasReachedMax: false,
            status: FormStatus.initial,
          ),
        );
      }
      if (state.hasReachedMax) return;
      if (state.status == FormStatus.initial) {
        LawEnforcementListResponse lawEnforcementList =
            await services.getList(
                startPosition: '${event.startPos}',
                maximumRecords: '${event.maxPos}',
                userId: userid,
                context: event.cont);
        return emit(
          state.copyWith(
            todos: lawEnforcementList.list,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );
      }

      LawEnforcementListResponse lawEnforcementList =
          await services.getList(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
        userId: userid,
        context: event.cont,
      );
      if (lawEnforcementList.list?.isEmpty == true) {
        return emit(state.copyWith(hasReachedMax: true));
      } else {
        return emit(
          state.copyWith(
            todos: List.of(state.items)
              ..addAll(lawEnforcementList.list ?? []),
            hasReachedMax: false,
          ),
        );
      }
    } catch (e) {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }

  FutureOr<void> _onTodoRefresh(
      LawEnforcementRefresh event, Emitter<LawEnforcementListState> emit) async {
  }
}
