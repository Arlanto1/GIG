part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

abstract class LoginActionState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginActionState {}

class LoginFailureState extends LoginState {
  final String errorMsg;

  LoginFailureState({required this.errorMsg});
}

class LoginVerifyOtpActionState extends LoginActionState {}
