// //
// // import 'package:db_atom/index.dart';
// // import 'package:db_atom/src/features/arlanto_ai_chat_assistance/models/ai_chat_model.dart';
// // import 'package:db_atom/src/features/arlanto_ai_chat_assistance/models/requestModel/ai_chat_request.dart';
// // import 'package:db_atom/src/features/arlanto_ai_chat_assistance/services/ai_chat_service.dart';
// //
// part 'ai_chat_details_state.dart';
// //
// // class AiChatDetailsCubit extends Cubit<AiChatDetailsState> {
// //   final AiChatService service; // inject your service
// //
// //   AiChatDetailsCubit({required this.service}) : super(const AiChatDetailsState());
// //
// //   Future<void> sendMessage(String message) async {
// //     if (message.trim().isEmpty) return;
// //
// //     final updatedMessages = List<Map<String, String>>.from(state.messages)
// //       ..add({'sender': 'user', 'text': message.trim()});
// //
// //     emit(
// //       state.copyWith(
// //         messages: [
// //           ...state.messages,
// //           ChatMessage(
// //             text: response.result ?? "",
// //             isUser: false,
// //           )
// //         ],
// //       ),
// //     );
// //
// //     try {
// //       final body = AiChatRequest(
// //         aiChatModel: AiChatModel(
// //           id: null,                         // required
// //           // promptShortName: "Atom",        // required
// //           prePrompt: message.trim(),      // required (user chat text)
// //           createdBy: "Pooja S",           // required
// //         ),
// //       );
// //
// //       final GenericResponse response = await service.createAiChat(body: body);
// //
// //       final botReply = response.result ?? "No response from AI";
// //
// //       final messagesWithBot = List<Map<String, String>>.from(updatedMessages)
// //         ..add({'sender': 'bot', 'text': botReply});
// //
// //       emit(state.copyWith(messages: messagesWithBot, isLoading: false));
// //     } catch (e) {
// //       emit(state.copyWith(isLoading: false, error: e.toString()));
// //     }
// //   }
// //
// // }
import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/arlanto_ai_chat_assistance/models/ai_chat_model.dart';
import 'package:db_atom/src/features/arlanto_ai_chat_assistance/models/requestModel/ai_chat_request.dart';
import 'package:db_atom/src/features/arlanto_ai_chat_assistance/services/ai_chat_service.dart';

part 'ai_chat_details_state.dart';
//
// class AiChatDetailsCubit extends Cubit<AiChatDetailsState> {
//   final AiChatService service;
//
//   AiChatDetailsCubit({required this.service})
//       : super( AiChatDetailsState(messages: []));
//
//   Future<void> sendMessage(String message) async {
//     emit(state.copyWith(isLoading: true));
//
//     final AiChatRequest request = AiChatRequest(
//       aiChatModel: AiChatModel(
//         id: 14,
//         createdBy: "Pooja S",
//         promptType: "PT_MY_STORED",
//         promptShortName: "Atom",
//         selectedLanguages: "English",
//         selectedAISystem: "openAI",
//         promptStatus: 0,
//         prePrompt: message,
//       ),
//     );
//
//     final response = await service.createAiChat(body: request);
//
//     final aiReply = response.results ?? "No reply from AI";
//
//     emit(state.copyWith(
//       isLoading: false,
//       messages: [
//         ...state.messages,
//         ChatMessage(message: message, isUser: true),
//         ChatMessage(message: aiReply.toString(), isUser: false),
//       ],
//     ));
//   }
//
// }
//


class AiChatDetailsCubit extends Cubit<AiChatDetailsState> {
  final AiChatService service;

  AiChatDetailsCubit({required this.service})
      : super(AiChatDetailsState(messages: []));

  // Future<void> sendMessage(String message) async {
  //   emit(state.copyWith(isLoading: true));
  //
  //   final AiChatRequestModel request = AiChatRequestModel(
  //     aiChatModel: AiChatResponseAnswerModel(
  //       id: null,
  //       promptShortName: "Atom",
  //       prePrompt: message,
  //     ),
  //   );
  //
  //   try {
  //     final response = await service.createAiChat(body: request);
  //
  //     String aiReply = "No reply from AI";
  //     if (response.result != null) {
  //       // Extract text after 'Answer:' if it exists
  //       final answerIndex = response.result!.indexOf("Answer:");
  //       if (answerIndex != -1) {
  //         aiReply = response.result!.substring(answerIndex + 7).trim();
  //       } else {
  //         aiReply = response.result!;
  //       }
  //     }
  //
  //     emit(state.copyWith(
  //       isLoading: false,
  //       messages: [
  //         ...state.messages,
  //         ChatMessage(message: message, isUser: true), // user question
  //         ChatMessage(message: aiReply, isUser: false), // AI answer
  //       ],
  //     ));
  //   } catch (e) {
  //     emit(state.copyWith(isLoading: false, error: e.toString()));
  //   }
  // }
  Future<void> sendMessage(String message) async {
    // 1️⃣ Add user message immediately
    emit(state.copyWith(
      messages: [
        ...state.messages,
        ChatMessage(message: message, isUser: true),
      ],
      isLoading: true,
      error: null,
    ));

    try {
      final AiChatRequestModel request = AiChatRequestModel(
        aiChatModel: AiChatResponseAnswerModel(
          id: null,
          promptShortName: "Atom",
          prePrompt: message,
        ),
      );

      final response = await service.createAiChat(body: request);

      // 2️⃣ Extract only the answer part
      String aiReply = "No reply from AI";
      if (response.result != null) {
        final answerIndex = response.result!.indexOf("Answer:");
        if (answerIndex != -1) {
          aiReply = response.result!.substring(answerIndex + 7).trim();
        } else {
          aiReply = response.result!;
        }
      }

      // 3️⃣ Add AI reply to state
      emit(state.copyWith(
        isLoading: false,
        messages: [
          ...state.messages,
          ChatMessage(message: aiReply, isUser: false),
        ],
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
