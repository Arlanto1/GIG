import '../../createfound/models/user.dart';

class LoginResponseModel {
  final String? msg;
  final String? token;
  final User? user;
  final String? refreshToken;
  final bool? requirePasswordChange;

  LoginResponseModel({
    this.msg,
    this.token,
    this.user,
    this.refreshToken,
    this.requirePasswordChange,
  });

  LoginResponseModel.fromJson(Map<String, dynamic> json)
      : msg = json['msg'] as String?,
        token = json['token'] as String?,
        user = (json['user'] as Map<String,dynamic>?) != null ? User.fromJson(json['user'] as Map<String,dynamic>) : null,
        refreshToken = json['refreshToken'] as String?,
        requirePasswordChange = json['requirePasswordChange'] as bool?;

  Map<String, dynamic> toJson() => {
    'msg' : msg,
    'token' : token,
    'user' : user?.toJson(),
    'refreshToken' : refreshToken,
    'requirePasswordChange' : requirePasswordChange
  };
}



