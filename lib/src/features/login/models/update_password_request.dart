class UpdatePasswordRequest {
  final UpdateRequest? request;

  UpdatePasswordRequest({
    this.request,
  });

  UpdatePasswordRequest.fromJson(Map<String, dynamic> json)
      : request = (json['request'] as Map<String,dynamic>?) != null ? UpdateRequest.fromJson(json['request'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'request' : request?.toJson()
  };
}

class UpdateRequest {
  final String? password;
  final String? newPassword;
  final String? confirmPassword;

  UpdateRequest({
    this.password,
    this.newPassword,
    this.confirmPassword,
  });

  UpdateRequest.fromJson(Map<String, dynamic> json)
      : password = json['password'] as String,
        newPassword = json['newPassword'] as String?,
        confirmPassword = json['confirmPassword'] as String?;

  Map<String, dynamic> toJson() => {
    'password' : password,
    'newPassword' : newPassword,
    'confirmPassword' : confirmPassword
  };
}