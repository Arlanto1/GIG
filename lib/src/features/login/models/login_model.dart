import '../../createfound/models/user.dart';

class LoginResponseModel {
  final String? message;
  final String? token;
  final User? user;
  final String? refreshToken;
  final bool? requirePasswordChange;

  LoginResponseModel({
    this.message,
    this.token,
    this.user,
    this.refreshToken,
    this.requirePasswordChange,
  });

  LoginResponseModel.fromJson(Map<String, dynamic> json)
      : message = json['message'] as String?,
        token = json['token'] as String?,
        user = (json['user'] as Map<String,dynamic>?) != null ? User.fromJson(json['user'] as Map<String,dynamic>) : null,
        refreshToken = json['refreshToken'] as String?,
        requirePasswordChange = json['requirePasswordChange'] as bool?;

  Map<String, dynamic> toJson() => {
    'message' : message,
    'token' : token,
    'user' : user?.toJson(),
    'refreshToken' : refreshToken,
    'requirePasswordChange' : requirePasswordChange
  };
}



