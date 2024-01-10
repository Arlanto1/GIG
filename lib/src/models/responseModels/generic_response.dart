class GenericResponse {
  GenericResponse({
    this.id,
    this.message,
  });

  String? id;
  String? message;

  GenericResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? json['Id'] ?? '';
    message = json['message'] ?? json['msg'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['message'] = message;
    return data;
  }
}
