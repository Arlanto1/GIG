import 'dart:async';
import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/login/services/key_clock_services.dart';
import 'package:db_atom/src/features/login/services/login_services.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginService loginService;
  String userName = '';
  String password = '';
  String deviceToken = '';

  LoginBloc({required this.loginService})
      : super(LoginLoadingState(status: FormStatus.loading)) {
    on<LoginVerifyEvent>(_loginVerifyEvent);
    on<ForgotPwdEvent>(_forgotPwdEvent);
    on<UpdatePwdEvent>(_updatePwdEvent);
    on<LoginSsoVerifyEvent>(_loginSsoVerifyEvent);
  }

  final KeyClockServices keyClockServices = KeyClockServices();

  Future<FutureOr<void>> _loginVerifyEvent(
      LoginVerifyEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState(status: FormStatus.loading));
    LoginResponseModel loginData = LoginResponseModel();
    try {
      if ((Environment().config.apiHost.contains('api.uat.')) || (Environment().config.apiHost.contains('api.qa.'))) {
        var tokenData = await keyClockServices.authenticate(
          event.requestModel.request!.userName!,
          event.requestModel.request!.password!,
        );
        String accessToken = tokenData['access_token'];

        if (accessToken.isEmptyOrNull) {
          log('-Failure---');

          // emit(LoginFailureState(
          //   message: e.message ?? 'An unexpected error occurred.',
          //   status: FormStatus.error,
          // ));
        }
      }
      loginData = await loginService.loginUser(event.requestModel);

      log('--loginData---${loginData.toString()}----');
      // LogService.add('--loginData---${loginData.toString()}----');

      var data = event.requestModel;
      userName = data.request?.userName?.trim() ?? '';
      password = data.request?.password ?? '';

      deviceToken = await SharedPrefs.getDeviceToken();

      /// Verify OTP
      if (!event.isFromLogin) {
        log('email address is ${loginData.user?.email}');
        await SharedPrefs.setUsername(userName);
        await SharedPrefs.setUserId('${loginData.user?.userId}');
        await SharedPrefs.setEmail(loginData.user?.email ?? '');
        await SharedPrefs.setIdentifymenuindex(0);
        await SharedPrefs.setToken(loginData.token ?? '');
        await SharedPrefs.setRefreshToken(loginData.refreshToken ?? '');

        if (loginData.user?.displayMenu == null) {
          emit(LoginFailureState(
            message: 'Menu Roles are not defined',
            status: FormStatus.formError,
          ));
          return null;
        }

        /// Setting Menu Items according to User Role
        await SharedPrefs.setDisplayMenu(loginData.user!.displayMenu!);

        if (loginData.user?.defaultLocation == null) {
          emit(LoginFailureState(
            message: 'Roles/Default Location is not defined!',
            status: FormStatus.formError,
          ));
          return null;
        }

        /// Setting Default Location
        await SharedPrefs.setDefaultLocation(loginData.user!.defaultLocation!);

        if (loginData.requirePasswordChange == true) {
          await SharedPrefs.setIsRequiredPasswordChange(true);

          emit(UpdatePasswordState());
        } else {
          emit(LoginVerifyOtpActionState(
            message: loginData.message ?? '',
            status: FormStatus.success,
          ));
        }
      } else {
        emit(LoginSuccessState(
          message: loginData.message ?? '',
          status: FormStatus.success,
        ));
      }

    } catch (e) {
      // Handle API errors here

      log('--e-$e-------to-${e.toString()}-');
      if (e is GenericResponse) {
        emit(LoginFailureState(
          message: e.message ?? 'An unexpected error occurred.',
          status: FormStatus.error,
        ));
      } else if (e is PermissionError) {
        emit(LoginFailureState(
          message: e.message ?? 'An unexpected error occurred.',
          status: FormStatus.success,
        ));
      } else {
        UtilsCommon().logCustomEvent(
            msg: e.toString(),
            customKey: 'LOGIN'
        );
        InactivityFunctions().logoutUser(navigatorKey);
        // Handle other unexpected errors
        log('Server Might Be Restarting: $e');
        emit(LoginFailureState(
          message:
              'Please check your network connection and try again. Reason: ${e.toString()}',
          status: FormStatus.error,
        ));
      }
      // Problem: not able to read the response here because loginData.msg is null
      // log('response--------$e-----');
      // emit(LoginFailureState(errorMsg: '${loginData.msg}' ));
    }
  }

  /// Login via DB SSO
  Future<FutureOr<void>> _loginSsoVerifyEvent(
      LoginSsoVerifyEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState(status: FormStatus.loading));
    LoginResponseModel loginData = LoginResponseModel();
    try {
      UtilsCommon().logCustomEvent(
          msg: event.user.toString(),
          customKey: 'LOGIN_SSO'
      );
      loginData = await loginService.ssoLoginUser(event.user);

      UtilsCommon().logCustomEvent(
          msg: loginData.toString(),
          customKey: 'LOGIN_SSO'
      );
      log('--loginData---${loginData.toString()}----');

      var data = event.user;
      userName = data.username.trim();

      deviceToken = await SharedPrefs.getDeviceToken();

      log('email address is ${loginData.user?.email}');
      await SharedPrefs.setUsername(userName);
      await SharedPrefs.setUserId('${loginData.user?.userId}');
      await SharedPrefs.setEmail(loginData.user?.email ?? '');
      await SharedPrefs.setIdentifymenuindex(0);
      await SharedPrefs.setToken(loginData.token ?? '');
      await SharedPrefs.setRefreshToken(loginData.refreshToken ?? '');

      if (loginData.user?.displayMenu == null) {
        emit(LoginFailureState(
          message: 'Menu Roles are not defined',
          status: FormStatus.formError,
        ));
        return null;
      }

      /// Setting Menu Items according to User Role
      await SharedPrefs.setDisplayMenu(loginData.user!.displayMenu!);

      if (loginData.user?.defaultLocation == null) {
        emit(LoginFailureState(
          message: 'Roles/Default Location is not defined!',
          status: FormStatus.formError,
        ));
        return null;
      }

      /// Setting Default Location
      await SharedPrefs.setDefaultLocation(loginData.user!.defaultLocation!);

      if (loginData.requirePasswordChange == true) {
        await SharedPrefs.setIsRequiredPasswordChange(true);

        emit(UpdatePasswordState());
      } else {
        emit(LoginVerifyOtpActionState(
          message: loginData.message ?? '',
          status: FormStatus.success,
        ));
      }
    } catch (e) {
      // Handle API errors here

      log('--e-$e-------to-${e.toString()}-');
      if (e is GenericResponse) {
        emit(LoginFailureState(
          message: e.message ?? 'An unexpected error occurred.',
          status: FormStatus.error,
        ));
      } else if (e is PermissionError) {
        emit(LoginFailureState(
          message: e.message ?? 'An unexpected error occurred.',
          status: FormStatus.success,
        ));
      } else {
        InactivityFunctions().logoutUser(navigatorKey);
        // Handle other unexpected errors
        log('Server Might Be Restarting: $e');
        emit(LoginFailureState(
          message:
              'Please check your network connection and try again. Reason: ${e.toString()}',
          status: FormStatus.error,
        ));
      }
      // Problem: not able to read the response here because loginData.msg is null
      // log('response--------$e-----');
      // emit(LoginFailureState(errorMsg: '${loginData.msg}' ));
    }
  }

  Future<FutureOr<void>> _forgotPwdEvent(
      ForgotPwdEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState(status: FormStatus.loading));
    try {
      LoginResponseModel loginData =
          await loginService.forgotPwdAPI(event.requestModel);

      emit(
        LoginSuccessState(
          message: loginData.message ?? '',
          status: FormStatus.success,
        ),
      );
    } catch (e) {
      if (e is GenericResponse) {
        emit(
          LoginFailureState(
            message: e.message ?? 'Please try after sometime',
            status: FormStatus.error,
          ),
        );
      } else {
        // Handle other unexpected errors
        UtilsCommon().logCustomEvent(
            msg: e.toString(),
            customKey: 'LOGIN'
        ); log('An unexpected error occurred: $e');
        emit(
          LoginFailureState(
            message: 'An unexpected error occurred.',
            status: FormStatus.error,
          ),
        );
      }
    }
  }

  Future<FutureOr<void>> _updatePwdEvent(
      UpdatePwdEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState(status: FormStatus.loading));
    try {
      LoginResponseModel loginData =
          await loginService.updatePassword(event.requestModel);
      await SharedPrefs.setIsRequiredPasswordChange(false);

      emit(
        LoginSuccessState(
          message: loginData.message ?? '',
          status: FormStatus.success,
        ),
      );
    } catch (e) {
      if (e is GenericResponse) {
        emit(LoginFailureState(
          message: e.message ?? 'Please try after sometime',
          status: FormStatus.error,
        ));
      } else {
        // Handle other unexpected errors
        UtilsCommon().logCustomEvent(
            msg: e.toString(),
            customKey: 'LOGIN'
        );
        log('An unexpected error occurred: $e');
        emit(LoginFailureState(
          message: 'An unexpected error occurred.',
          status: FormStatus.error,
        ));
      }
    }
  }
}
