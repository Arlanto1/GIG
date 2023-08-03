import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import '../../../../main_DEV.dart';
import '../../law_enforcement_list/controllers/law_enforcement_list_state.dart';
import '../../law_enforcement_list/models/law_enforcement_list_response.dart';
import '../../law_enforcement_list/services/law_enforcement_list_services.dart';

part 'inward_event.dart';
part 'inward_state.dart';

class InwardBloc extends Bloc<InwardEvent, InwardState> {
  InwardBloc() : super(const InwardState()) {
    on<InwardFetch>(
      _onTodoFetch,
      transformer: droppable(),
    );

  }

  final LawEnforcementListServices _todoService = LawEnforcementListServices();

  FutureOr<void> _onTodoFetch(
      InwardFetch event, Emitter<InwardState> emit) async {
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
      }
      return emit(
        state.copyWith(
          todos: List.of(state.lawEnforceItems)..addAll(lawEnforcementList.list ?? []),
          hasReachedMax: false,
        ),
      );
    } catch (e) {
      //debugPrint("[HATA] [TodoBloc] [_onTodoFetch] --> $e");
      return emit(state.copyWith(status: LawEnforcementListStateType.failure));
    }
  }
}
