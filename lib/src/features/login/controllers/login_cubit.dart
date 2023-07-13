// Created by Ramesh

import 'package:db_atom/src/features/login/controllers/login_state.dart';
import 'package:db_atom/src/features/login/services/login_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginService loginService;

  LoginCubit({
    required this.loginService,
  }) : super(
          const LoginState(
            stateType: LoginStateType.initial,
          ),
        );

  Future<void> loginButtonPressed() async {
    try {
      //final loginData = await loginService.loginServiceCall();
      emit(
        state.copyWith(
          stateType: LoginStateType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: '', //Constants.error,
          stateType: LoginStateType.failure,
        ),
      );
    }
  }
}

// Finally we need to call this method on login button pressed
