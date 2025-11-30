import 'dart:async';
import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/arlanto_ai_chat_assistance/models/ai_chat_model.dart';
import 'package:db_atom/src/features/arlanto_ai_chat_assistance/services/ai_chat_service.dart';
part 'ai_chat_list_event.dart';
part 'ai_chat_list_state.dart';

class AiChatListBloc extends Bloc<AiChatListEvent, AIChatListState> {
  AiChatListBloc() : super(const AIChatListState()) {
    on<FetchAIData>(_fetchList);
  }

  AiChatService service = AiChatService();

  Future<void> _fetchList(
      FetchAIData event, Emitter<AIChatListState> emit) async {
    emit(state.copyWith(status: FormStatus.loading));

    try {
      final response = await service.getList();

      emit(state.copyWith(
        items: response.results ?? [],
        status: FormStatus.success,
      ));

    } catch (e) {
      emit(state.copyWith(
        status: FormStatus.failure,
        message: e.toString(),
      ));
    }
  }
}
