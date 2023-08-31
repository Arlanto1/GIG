
class GenericCreateResponse {
  final String? id;
  final String? message;

  GenericCreateResponse({
    this.id,
    this.message,
  });

  GenericCreateResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        message = json['message'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'message' : message
  };
}