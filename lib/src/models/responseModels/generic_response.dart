class GenericResponse {
  GenericResponse({
    this.id,
    this.message,
  });

  String? id;
  String? message;
  String? statusCode;

  GenericResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? json['Id'] ?? '';
    message = json['message'] ?? json['msg'] ?? '';
    statusCode = json['statusCode'] ?? json['statusCode'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['message'] = message;
    data['statusCode'] = statusCode;
    return data;
  }
}
