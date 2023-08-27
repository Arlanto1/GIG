import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:db_atom/src/features/login/models/login_model.dart';
import 'package:db_atom/src/features/login/models/login_request_model.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:meta/meta.dart';

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
  }

  Future<FutureOr<void>> _loginVerifyEvent(
      LoginVerifyEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    try {
      LoginResponseModel loginData =
          await loginService.loginUser(event.requestModel);
      var data = event.requestModel;
      userName = data.request?.id ?? '';
      password = data.request?.password ?? '';

      if (loginData.status == 200) {
        if (!event.isFromLogin) {
          await SharedPrefs.setUsername(userName);
          await SharedPrefs.setUserId('${loginData.user?.userId}');
          await SharedPrefs.setIdentifymenuindex(0);
          emit(LoginVerifyOtpActionState());
        } else {
          emit(LoginSuccessState());
        }
      } else {
        emit(LoginFailureState(errorMsg: '${loginData.msg}' ));
      }
    } catch (e) {
      emit(LoginFailureState(errorMsg: 'Something went wrong'));
    }
  }

  Future<FutureOr<void>> _forgotPwdEvent(
      ForgotPwdEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    try {
      LoginResponseModel loginData =
          await loginService.forgotPwdAPI(event.requestModel);

      if (loginData.status == 200) {
        emit(LoginSuccessState(msg: loginData.msg));
      } else {
        emit(LoginFailureState(errorMsg: loginData.msg ?? ''));
      }
    } catch (e) {
      emit(LoginFailureState(errorMsg: 'Something went wrong'));
    }
  }
}
