// Created by Ramesh
import 'package:equatable/equatable.dart';

enum LoginStateType {
  initial,
  loading,
  success,
  failure,
}

class LoginState extends Equatable {
  final bool? isNew;
  final String? errorMessage;
  final LoginStateType stateType;

  const LoginState({
    required this.stateType,
    this.isNew,
    this.errorMessage,
  });

  LoginState copyWith({
    bool? isNew,
    String? errorMessage,
    LoginStateType? stateType,
  }) {
    return LoginState(
      isNew: isNew ?? this.isNew,
      errorMessage: errorMessage ?? this.errorMessage,
      stateType: stateType ?? this.stateType,
    );
  }

  @override
  List<Object?> get props => [
        isNew,
        errorMessage,
        stateType,
      ];
}
