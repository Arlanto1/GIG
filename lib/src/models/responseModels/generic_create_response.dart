class GenericCreateResponse {
  GenericCreateResponse({
    this.id,
    this.message,
  });

  String? id;
  String? message;

  GenericCreateResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'] ??
        json['Id'] ??
        ''; // Provide a default value (an empty string in this case)
    message = json['message'] ?? json['msg'] ?? ''; // Provide a default value
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['message'] = message;
    return data;
  }
}
