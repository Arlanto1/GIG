import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:db_atom/src/features/login/models/login_model.dart';
import 'package:db_atom/src/features/login/models/login_request_model.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:meta/meta.dart';

import '../../../models/responseModels/generic_create_response.dart';
import '../models/update_password_request.dart';
import '../services/login_services.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginService loginService;
  String userName = '';
  String password = '';

  LoginBloc({required this.loginService}) : super(LoginLoadingState()) {
    on<LoginVerifyEvent>(_loginVerifyEvent);
    on<ForgotPwdEvent>(_forgotPwdEvent);
    on<UpdatePwdEvent>(_updatePwdEvent);
  }

  Future<FutureOr<void>> _loginVerifyEvent(
      LoginVerifyEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    LoginResponseModel loginData = LoginResponseModel();
    try {
      loginData = await loginService.loginUser(event.requestModel);
      var data = event.requestModel;
      userName = data.request?.userName ?? '';
      password = data.request?.password ?? '';

      if (!event.isFromLogin) {
        log('email address is ${loginData.user?.email}');
        await SharedPrefs.setUsername(userName);
        await SharedPrefs.setUserId('${loginData.user?.userId}');
        await SharedPrefs.setEmail('${loginData.user?.email}');
        await SharedPrefs.setIdentifymenuindex(0);
        await SharedPrefs.setToken(loginData.token ?? '');
        await SharedPrefs.setRefreshToken(loginData.refreshToken ?? '');
        if (loginData.requirePasswordChange == true) {
          await SharedPrefs.setIsRequiredPasswordChange(true);

          emit(UpdatePasswordState());
        } else {
          emit(LoginVerifyOtpActionState());
        }
      } else {
        emit(LoginSuccessState(message: loginData.message ?? ''));
      }
    } catch (e) {
      // Handle API errors here
      if (e is GenericCreateResponse) {
        emit(LoginFailureState(message: e.message ?? 'errrrorrrrr'));
      } else {
        // Handle other unexpected errors
        log('An unexpected error occurred: $e');
        emit(LoginFailureState(message: 'An unexpected error occurred.'));
      }
      // Problem: not able to read the response here because loginData.msg is null
      // log('response--------$e-----');
      // emit(LoginFailureState(errorMsg: '${loginData.msg}' ));
    }
  }

  Future<FutureOr<void>> _forgotPwdEvent(
      ForgotPwdEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    try {
      LoginResponseModel loginData =
          await loginService.forgotPwdAPI(event.requestModel);

      emit(
        LoginSuccessState(message: loginData.message ?? ''),
      );
    } catch (e) {
      if (e is GenericCreateResponse) {
        emit(
          LoginFailureState(message: e.message ?? 'Please try after sometime'),
        );
      } else {
        // Handle other unexpected errors
        log('An unexpected error occurred: $e');
        emit(
          LoginFailureState(message: 'An unexpected error occurred.'),
        );
      }
    }
  }

  Future<FutureOr<void>> _updatePwdEvent(
      UpdatePwdEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    try {
      LoginResponseModel loginData =
          await loginService.updatePassword(event.requestModel);
      await SharedPrefs.setIsRequiredPasswordChange(false);

      emit(LoginSuccessState(message: loginData.message ?? ''));
    } catch (e) {
      if (e is GenericCreateResponse) {
        emit(LoginFailureState(
            message: e.message ?? 'Please try after sometime'));
      } else {
        // Handle other unexpected errors
        log('An unexpected error occurred: $e');
        emit(LoginFailureState(message: 'An unexpected error occurred.'));
      }
    }
  }
}
