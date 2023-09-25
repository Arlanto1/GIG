part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

abstract class LoginActionState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginActionState {
  final String message;

  LoginSuccessState({required this.message});
}


class LoginVerifyOtpActionState extends LoginActionState {}
class ForgotPwdActionState extends LoginActionState {
}


class LoginFailureState extends LoginState {
  final String message;

  LoginFailureState({required this.message});
}
