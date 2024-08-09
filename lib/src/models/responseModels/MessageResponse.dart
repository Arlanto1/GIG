class MessageResponse {
  final String? message;

  MessageResponse({
    this.message,
  });

  MessageResponse.fromJson(Map<String, dynamic> json)
      : message = json['message'] as String?;

  Map<String, dynamic> toJson() => {
    'message' : message
  };
}