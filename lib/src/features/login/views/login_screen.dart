import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/login/services/login_services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:permission_handler/permission_handler.dart';

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
            if (state.status == FormStatus.permissionLocationError) {
              var dialog = CustomAlertDialog(
                  title: 'Location Permission',
                  message: state.message,
                  onPositivePressed: () async {
                    openAppSettings();
                    Navigator.of(context).pop();
                    setState(() {
                      state.status == FormStatus.success;
                    });
                  },
                  onNegativePressed: () {
                    log('--onNegativePressed--');
                  },
                  positiveBtnText: Constants.settings,
                  negativeBtnText: Constants.no);
              // showDialog(
              //     context: context, builder: (BuildContext context) => dialog);
              return;
            }

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
                color: AppColors.navigationSkyBlueColor,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: height * 0.1,
                        color: AppColors.navigationSkyBlueColor,
                      ),
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: const ShapeDecoration(
                            color: AppColors.backgroundWhiteColor,
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
                                      colorFilter: const ColorFilter.mode(
                                        AppColors.textColor,
                                        BlendMode.srcIn,
                                      ),
                                      // color: AppColors.textColor,
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

                              const Center(
                                child: Text(
                                  'OR',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                height * 0.03,
                              ),
                              ElevatedButton(
                                onPressed: _authenticate,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors
                                      .white, // Set the background color to white
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      AppIcon.deutscheBankLogo,
                                      fit: BoxFit.cover,
                                      height: 20,
                                      // color:
                                      //     AppColors.navigationSkyBlueColor,
                                    ),
                                    CommonWidgets.horizontalSpacerWidget(
                                      height * 0.01,
                                    ),
                                    const Text(
                                      Constants.dbSSO,
                                      style: TextStyle(
                                        color: Color(0xFF000080),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                height * 0.03,
                              ),
                              // AppButton(
                              //   // key: const Key(Keys.loginButton),
                              //   buttonText: Constants.dbSSO,
                              //   buttonTextKey: Keys.loginButtonText,
                              //   onTap: () async {
                              //     //loginFormKey.currentState!.validate();
                              //     // _loginButtonAction(bloc);
                              //     _authenticate();
                              //   },
                              // ),

                              // Forgot password
                              ForgotPassword(
                                onForgottenPassword: () => {
                                  //widget.onPasswordForgotten()
                                  Navigator.pushNamed(
                                    context,
                                    forgotPwdScreenRoute,
                                  )
                                },
                                title: Constants.resetPwdTitle,
                              ),

                              CommonWidgets.verticalSpacerWidget(
                                height * 0.18,
                              ),

                              /// Support Number
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // Center(
                                  //   child: Row(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.center,
                                  //     children: [
                                  //       const Text(
                                  //         Constants.support,
                                  //         style: Styles.textStyleBlack16,
                                  //       ),
                                  //       IconButton(
                                  //         onPressed: () {
                                  //           // do action on view
                                  //         },
                                  //         icon: SvgPicture.asset(AppIcon.email),
                                  //       ),
                                  //       const Text(
                                  //         Constants.supportContact,
                                  //         style: Styles.textStyleBlack16,
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // CommonWidgets.verticalSpacerWidget(
                                  //   height * 0.003,
                                  // ),

                                  Center(
                                    child: Text(
                                      Constants.copyrightText,
                                      style: Styles.textStyleRegularGrey14,
                                    ),
                                  ),
                                ],
                              )
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

  final FlutterAppAuth appAuth = const FlutterAppAuth();

//   String clientId = 'interactive.public';
// // String redirectUrl = 'https://demo.duendesoftware.com/connect/authorize';
//   String redirectUrl = 'urn:ietf:wg:oauth:2.0:oob';
//   String issuer = 'https://demo.duendesoftware.com';
//   String secret = 'secret';
//   String discoveryUrl = 'https://demo.duendesoftware.com/connect/authorize';

  final String tenantId = 'f18ecf29-68a6-4697-92fa-0ce29009c210';
  final String clientId = '4f133b63-2fc9-4770-ad4a-20b6e69ec1ce';
  // final String redirectUrl =
  //     'https://login.microsoftonline.com/common/oauth2/nativeclient';
  final String redirectUrl =
      'com.arlanto.atomedge:/oauthredirect';

  final String clientSecret = 'Ly68Q~9VVXRHWeuO7EUWZSDJeH_x-ledldKl4bZ2';
  final String authority = 'https://login.microsoftonline.com/';
  final String resource = 'DB-ATOM';
  final String issuer =
      'https://login.microsoftonline.com/f18ecf29-68a6-4697-92fa-0ce29009c210';

  final String re = 'com.yourapp:/oauthredirect';

  Future<void> _authenticate() async {
    final AuthorizationTokenResponse? result =
        await appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(
        clientId,
        redirectUrl,
        issuer: issuer,
        // clientSecret: secret,
        // discoveryUrl: issuer,
        scopes: ['openid', 'profile', 'email', 'offline_access', 'api'],
      ),
    );

    setState(() {
      log('---${result?.accessToken}---');
      // _accessToken = result?.accessToken;
      // _idToken = result?.idToken;
    });
  }

  LoginRequestModel prepareLoginRequestBody(
      String userName, String pwd, String otp) {
    return LoginRequestModel(
        request: Request(
      userName: username,
      password: password,
      otp: otp,
    ));
  }

  // _showCustomPop(BuildContext context, String title) {
  //   var dialog = CustomAlertDialog(
  //       title: Constants.appname,
  //       message: title,
  //       onPositivePressed: () {
  //         //Validator.logoutAction(context);
  //         //Navigator.of(context).pop();
  //       },
  //       positiveBtnText: Constants.yes,
  //       negativeBtnText: Constants.no);
  //   showDialog(context: context, builder: (BuildContext context) => dialog);
  // }

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
