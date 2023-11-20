class GenericErrorResponse {
  GenericErrorResponse({
    this.id,
    this.message,
  });

  String? id;
  String? message;

  GenericErrorResponse.fromJson(Map<String, dynamic> json) {
    id = json['id']; // Provide a default value (an empty string in this case)
    message = json['message']; // Provide a default value
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['message'] = message;
    return data;
  }
}
