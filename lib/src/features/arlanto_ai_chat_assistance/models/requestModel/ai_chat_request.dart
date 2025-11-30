
import 'package:db_atom/src/features/arlanto_ai_chat_assistance/models/ai_chat_model.dart' show AiChatModel, AiChatResponseAnswerModel;

class AiChatRequest {
  AiChatRequest({
    required this.aiChatModel,
  });

  late final AiChatModel aiChatModel;

  AiChatRequest.fromJson(Map<String, dynamic> json) {
    aiChatModel = AiChatModel.fromJson(json['aai']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['aai'] = aiChatModel.toJson();
    return data;
  }
}


class ChatMessage {
  final String message;
  final bool isUser;

  ChatMessage({
    required this.message,
    required this.isUser,
  });
}




class AiChatRequestModel {
  AiChatRequestModel({
    required this.aiChatModel,
  });

  late final AiChatResponseAnswerModel aiChatModel;

  AiChatRequestModel.fromJson(Map<String, dynamic> json) {
    aiChatModel = AiChatResponseAnswerModel.fromJson(json['aai']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['aai'] = aiChatModel.toJson();
    return data;
  }
}
