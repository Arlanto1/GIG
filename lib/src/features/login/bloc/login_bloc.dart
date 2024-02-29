import 'dart:async';
import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/login/services/login_services.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginService loginService;
  String userName = '';
  String password = '';
  String deviceToken = '';

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

      deviceToken = await SharedPrefs.getDeviceToken();
      log('-1-----');

      /// Verify OTP
      if (!event.isFromLogin) {
        log('-2-----');
        log('email address is ${loginData.user?.email}');
        await SharedPrefs.setUsername(userName);
        await SharedPrefs.setUserId('${loginData.user?.userId}');
        log('-2-22----');
        await SharedPrefs.setEmail(loginData.user?.email ?? '');
        await SharedPrefs.setIdentifymenuindex(0);
        await SharedPrefs.setToken(loginData.token ?? '');
        await SharedPrefs.setRefreshToken(loginData.refreshToken ?? '');
        log('-2-33----');

        if (loginData.user?.displayMenu == null) {
          log('-2-33-44---');
          emit(LoginSuccessState(message: 'Menu Roles are not defined'));
          return null;
        }
        log('-3-----');

        /// Setting Menu Items according to User Role
        await SharedPrefs.setDisplayMenu(loginData.user!.displayMenu!);

        /// Setting Default Location
        await SharedPrefs.setDefaultLocation(loginData.user!.defaultLocation!);

        log('-4-----');
        if (loginData.requirePasswordChange == true) {
          await SharedPrefs.setIsRequiredPasswordChange(true);

          emit(UpdatePasswordState());
        } else {
          emit(LoginVerifyOtpActionState());
        }
      } else {
        log('-5-----');
        emit(LoginSuccessState(message: loginData.message ?? ''));
      }
    } catch (e) {
      // Handle API errors here
      if (e is GenericResponse) {
        emit(LoginFailureState(
            message: e.message ?? 'An unexpected error occurred.'));
      } else {
        // Handle other unexpected errors
        log('An unexpected error occurred---1: $e');
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
      if (e is GenericResponse) {
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
      if (e is GenericResponse) {
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
