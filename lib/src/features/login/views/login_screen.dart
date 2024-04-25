import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/login/services/login_services.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (_) => LoginBloc(loginService: LoginService()),
      child: const Login(),
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController userNameTextController = TextEditingController();
  String username = '';
  String password = '';
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    log('-LoginScreen---initState--');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final bloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
      backgroundColor: AppColors.cardBgColor,
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          Utils().formError(state, context);
          if (state is LoginFailureState) {
            dismissLoadingDialog(context);
            //_showCustomPop(context, );
            //     alert_handler.alertDisplay(
            // context,state.errorMsg);
            var dialog = CustomAlertDialog(
              title: Constants.appname,
              message: state.message,
              onPositivePressed: () {
                //Validator.logoutAction(context);
                Navigator.of(context).pop();
              },
              positiveBtnText: Constants.ok,
              //negativeBtnText: Constants.no
            );
            showDialog(
                context: context, builder: (BuildContext context) => dialog);
          } else if (state is LoginSuccessState) {
            dismissLoadingDialog(context);
            Navigator.pushNamed(context, otpVerificationRoute, arguments: {
              "userDetails": VerifyOTPArguments(
                  bloc.userName, bloc.password, bloc.deviceToken)
            });
          } else if (state is LoginLoadingState) {
            showLoadingDialog(context);
          }
        },
        builder: (context, state) {
          return BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is LoginLoadingState) {
              } else if (state is LoginFailureState) {
              } else if (state is LoginSuccessState) {}
              return Container(
                color: AppColors.navigationSkybluecolor,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: height * 0.1,
                        color: AppColors.navigationSkybluecolor,
                      ),
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: const ShapeDecoration(
                            color: AppColors.backgroundWhitecolor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20.0)),
                            )),

                        // color: Colors.white,
                        child: Form(
                          key: loginFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Login welcome text and image
                              welcomeLogin(),

                              CommonWidgets.verticalSpacerWidget(height * 0.03),

                              /// Username
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                //mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: const Text(
                                      Constants.username,
                                      style: Styles.textStyleBlack16,
                                    ),
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    controller: userNameTextController,
                                    textFormKey: Keys.userTextField,
                                    textCapitalization: false,
                                    hintText: Constants.hintUserName,
                                    textInputAction: TextInputAction.next,
                                    focusNode: _usernameFocus,
                                    textInputType: TextInputType.text,
                                    onFieldSubmitted: (term) {
                                      _usernameFocus.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(_passwordFocus);
                                    },
                                    onChange: (String username) {
                                      this.username = username;
                                      setState(() {});
                                    },
                                    validateTextField: (String? user) {
                                      if (!Validator.isValidUserName(user)) {
                                        return Constants.userError;
                                      }
                                    },
                                    prefixWidget: SvgPicture.asset(
                                      AppIcon.userIcon,
                                      color: AppColors.textColor,
                                      width: 20,
                                      key: const Key(Keys.userIcon),
                                    ),
                                  ),

                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),

                                  /// Password
                                  Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: const Text(
                                          Constants.password,
                                          style: Styles.textStyleBlack16,
                                        ),
                                      ),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.001),
                                      LoginPassword(
                                        passFocusNode: _passwordFocus,
                                        textInputAction: TextInputAction.done,
                                        validatePassword: ((String? password) {
                                          if (!Validator.isValidPassword(
                                              password)) {
                                            return Constants.passwordError;
                                          } else if (!Validator
                                              .passwordValidation(password)) {
                                            return Constants
                                                .passwordLengthError;
                                          }
                                        }),
                                        onFieldSubmitted: (term) {
                                          _passwordFocus.unfocus();
                                          //FocusScope.of(context).requestFocus(_passwordFocus);
                                          _loginButtonAction(bloc);
                                        },
                                        onChange: (String password) {
                                          this.password = password;
                                        },
                                      ),
                                    ],
                                  ),

                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.03),

                                  // Login button
                                  AppButton(
                                    key: const Key(Keys.loginButton),
                                    buttonText: Constants.loginButtonTitle,
                                    buttonTextKey: Keys.loginButtonText,
                                    onTap: () async {
                                      //loginFormKey.currentState!.validate();
                                      _loginButtonAction(bloc);
                                    },
                                  ),

                                  CommonWidgets.verticalSpacerWidget(
                                    height * 0.03,
                                  ),
                                ],
                              ),

                              // Forgot password
                              ForgotPassword(
                                onForgottenPassword: () => {
                                  //widget.onPasswordForgotten()
                                  Navigator.pushNamed(
                                    context,
                                    forgotPwdScreenRoute,
                                  )
                                },
                                title: Constants.ResetPwdTitle,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                height * 0.17,
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          Constants.support,
                                          style: Styles.textStyleBlack16,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            // do action on view
                                          },
                                          icon: SvgPicture.asset(AppIcon.email),
                                        ),
                                        const Text(
                                          Constants.supportContact,
                                          style: Styles.textStyleBlack16,
                                        ),
                                      ],
                                    ),
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                    height * 0.003,
                                  ),
                                  const Center(
                                    child: Text(
                                      Constants.copyrightText,
                                      style: Styles.textStyleRegularGrey14,
                                    ),
                                  ),
                                ],
                              )

                              // Support numbers
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  LoginRequestModel prepareLoginRequestBody(
      String userName, String pwd, String otp) {
    return LoginRequestModel(
        request: Request(userName: username, password: password, otp: otp));
  }

  _showCustomPop(BuildContext context, String title) {
    var dialog = CustomAlertDialog(
        title: Constants.appname,
        message: title,
        onPositivePressed: () {
          //Validator.logoutAction(context);
          //Navigator.of(context).pop();
        },
        positiveBtnText: Constants.yes,
        negativeBtnText: Constants.no);
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }

  _loginButtonAction(LoginBloc bloc) {
    FocusScope.of(context).unfocus();
    try {
      if (loginFormKey.currentState!.validate()) {
        log('username $username password $password');
        bloc.add(LoginVerifyEvent(
          requestModel: prepareLoginRequestBody(username, password, ''),
          isFromLogin: true,
        ));
      }
    } catch (e) {
      // present userwith error message
    }
  }

  Widget welcomeLogin() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20.0),
          child: Image.asset(
            AppIcon.titleLogoLogin,
            width: 200,
            height: 70,
          ),
        ),
        CommonWidgets.verticalSpacerWidget(
            MediaQuery.of(context).size.height * 0.001),
        Container(
          alignment: Alignment.center,
          child: Text(
            Constants.loginButtonTitle,
            style: Styles.styleHeaderGreyText30,
          ),
        ),
      ],
    );
  }
}

class VerifyOTPArguments {
  final String name;
  final String pwd;
  final String deviceToken;

  VerifyOTPArguments(this.name, this.pwd, this.deviceToken);
}
