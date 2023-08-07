part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginVerifyEvent extends LoginEvent {
  final LoginRequestModel requestModel;
  final bool isFromLogin;

  LoginVerifyEvent({required this.requestModel, required this.isFromLogin});
}
