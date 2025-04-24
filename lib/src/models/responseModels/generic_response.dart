class GenericResponse {
  GenericResponse({
    this.id,
    this.message,
    this.Message,
  });

  String? id;
  String? message;
  String? statusCode;
  String? Message;

  GenericResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? json['Id'] ?? '';
    message = json['message'] ?? json['msg'] ?? '';
    statusCode = json['statusCode'] ?? json['statusCode'] ?? '';
    Message = json['Message'] ?? json['Message'] ?? '';

  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['message'] = message;
    data['statusCode'] = statusCode;
    data['Message'] = Message;
    return data;
  }
}
