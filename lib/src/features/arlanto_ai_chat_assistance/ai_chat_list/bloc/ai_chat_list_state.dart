part of 'ai_chat_list_bloc.dart';

class AIChatListState extends Equatable {
  final List<AiChatModel> items;
  final FormStatus status;
  final String? message;

  const AIChatListState({
    this.items = const [],
    this.status = FormStatus.initial,
    this.message,
  });

  AIChatListState copyWith({
    List<AiChatModel>? items,
    FormStatus? status,
    String? message,
  }) {
    return AIChatListState(
      items: items ?? this.items,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [items, status, message];
}
