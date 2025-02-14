part of 'login_bloc.dart';


@immutable
abstract class LoginEvent {}

class LoginVerifyEvent extends LoginEvent {
  final LoginRequestModel requestModel;
  final bool isFromLogin;

  LoginVerifyEvent({required this.requestModel, required this.isFromLogin});
}

class LoginSsoVerifyEvent extends LoginEvent {
  final MsalUser user;
  final bool isFromLogin;


  LoginSsoVerifyEvent({required this.user,required this.isFromLogin});
}

class ForgotPwdEvent extends LoginEvent {
  final LoginRequestModel requestModel;

  ForgotPwdEvent({required this.requestModel});
}

class UpdatePwdEvent extends LoginEvent {
  final UpdatePasswordRequest requestModel;

  UpdatePwdEvent({required this.requestModel});
}
