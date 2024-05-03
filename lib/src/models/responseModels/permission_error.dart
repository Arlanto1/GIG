class PermissionError implements Exception {
  PermissionError({
    this.id,
    this.message,
  });

  String? id;
  String? message;

  PermissionError.fromJson(Map<String, dynamic> json) {
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
