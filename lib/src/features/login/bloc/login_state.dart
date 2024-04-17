part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

abstract class LoginActionState extends LoginState {}

class LoginLoadingState extends LoginState {
  final FormStatus status;

  LoginLoadingState({required this.status});
}

class LoginSuccessState extends LoginActionState {
  final String message;
  final FormStatus status;

  LoginSuccessState({
    required this.message,
    required this.status,
  });
}

class UpdatePasswordState extends LoginActionState {}

class LoginVerifyOtpActionState extends LoginActionState {}

class ForgotPwdActionState extends LoginActionState {}

class LoginFailureState extends LoginState {
  final String message;
  final FormStatus status;

  LoginFailureState({
    required this.message,
    required this.status,
  });
}
