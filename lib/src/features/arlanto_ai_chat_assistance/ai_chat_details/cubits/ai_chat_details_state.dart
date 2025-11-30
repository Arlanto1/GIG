part of 'ai_chat_details_cubit.dart';

class AiChatDetailsState extends Equatable {
   final List<ChatMessage> messages;// {'sender': 'user'/'bot', 'text': '...'}
  final bool isLoading;
  final String? error;

  const AiChatDetailsState({
    this.messages = const [],
    this.isLoading = false,
    this.error,
  });

  AiChatDetailsState copyWith({
        List<ChatMessage>? messages,
    bool? isLoading,
    String? error,
  }) {
    return AiChatDetailsState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [messages, isLoading, error];
}
// class AiChatDetailsState {
//   final List<ChatMessage> messages;
//
//   AiChatDetailsState({required this.messages});
//
//   AiChatDetailsState copyWith({
//     List<ChatMessage>? messages,
//   }) {
//     return AiChatDetailsState(
//       messages: messages ?? this.messages,
//     );
//   }
// }
