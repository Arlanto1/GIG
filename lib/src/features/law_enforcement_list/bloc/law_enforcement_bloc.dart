import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:db_atom/src/features/law_enforcement_list/controllers/law_enforcement_list_state.dart';
import 'package:db_atom/src/features/law_enforcement_list/services/law_enforcement_list_services.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../models/law_enforcement_list_response.dart';

part 'law_enforcement_event.dart';

part 'law_enforcement_state.dart';

class LawEnforcementBloc
    extends Bloc<LawEnforcementEvent, LawEnforcementState> {
  LawEnforcementBloc() : super(const LawEnforcementState()) {
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

  final LawEnforcementListServices _todoService = LawEnforcementListServices();

  FutureOr<void> _onTodoFetch(
      LawEnforcementFetch event, Emitter<LawEnforcementState> emit) async {
    try {
      if (state.hasReachedMax) return;
      if (state.status == LawEnforcementListStateType.initial) {
        LawEnforcementListResponse lawEnforcementList =
            await _todoService.getLawEnforcementList(
                '${event.startPos}', '${event.maxPos}', '77');
        return emit(
          state.copyWith(
            todos: lawEnforcementList.list,
            hasReachedMax: false,
            status: LawEnforcementListStateType.success,
          ),
        );
      }

      LawEnforcementListResponse lawEnforcementList = await _todoService
          .getLawEnforcementList('${event.startPos}', '${event.maxPos}', '77');
      if (lawEnforcementList.list?.isEmpty == true) {
        return emit(state.copyWith(hasReachedMax: true));
      } else {
        return emit(
          state.copyWith(
            todos: List.of(state.lawEnforceItems)..addAll(lawEnforcementList.list ?? []),
            hasReachedMax: false,
          ),
        );
      }
    } catch (e) {
      //debugPrint("[HATA] [TodoBloc] [_onTodoFetch] --> $e");
      return emit(state.copyWith(status: LawEnforcementListStateType.failure));
    }
  }

  FutureOr<void> _onTodoRefresh(LawEnforcementRefresh event,
  Emitter<LawEnforcementState> emit) async {
    // emit(const TodoState());
    // await Future.delayed(const Duration(seconds: 1));
    // add(const TodoFetch());
  }
}
