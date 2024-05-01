import 'dart:developer';

import 'package:db_atom/index.dart';

// class ResetPasswordScreen extends StatelessWidget {
//   const ResetPasswordScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<LoginBloc>(
//       create: (_) => LoginBloc(loginService: LoginService()),
//       child: const ResetPasswordView(viaNavigationDrawer: false),
//     );
//   }
// }

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key, required this.viaNavigationDrawer});

  final bool viaNavigationDrawer;

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  TextEditingController userNameTextController = TextEditingController();
  String username = '';
  String oldPassword = '';
  String newPassword = '';
  String confirmNewPassword = '';
  final FocusNode oldPasswordFocus = FocusNode();
  final FocusNode newPasswordFocus = FocusNode();
  final FocusNode confirmNewPasswordFocus = FocusNode();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final bloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
      appBar: AppHeader(
        isTitleCenter: false,
        backBtn: IconButton(
          onPressed: () {
            widget.viaNavigationDrawer
                ? Navigator.of(context).pop()
                : Navigator.pushReplacementNamed(context, loginScreenRoute);
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: Colors.white),
        ),
      ),
      backgroundColor: AppColors.cardBgColor,
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          Utils().formError(state, context);
          Utils().errorAndLogout(state, context);
          if (state is LoginFailureState) {
            dismissLoadingDialog(context);
            _showCustomPop(context, state.message);
          } else if (state is LoginSuccessState) {
            dismissLoadingDialog(context);
            Navigator.pushNamedAndRemoveUntil(
              context,
              dashboardViewRoute,
              (route) => false,
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                duration: const Duration(seconds: 3), // Adjust the duration
              ),
            );
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

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                //mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // Container(
                                  //   alignment: Alignment.topLeft,
                                  //   child: const Text(
                                  //     Constants.username,
                                  //     style: Styles.textStyleBlack16,
                                  //   ),
                                  // ),
                                  // CommonWidgets.verticalSpacerWidget(
                                  //     height * 0.001),
                                  // FlutterInputField(
                                  //   textFieldController: userNameTextController,
                                  //   textFormKey: Keys.userTextField,
                                  //   hintText: Constants.hintUserName,
                                  //   onChange: (String username) {
                                  //     this.username = username;
                                  //     setState(() {});
                                  //   },
                                  //   textInputAction: TextInputAction.next,
                                  //   focusnode: _usernameFocus,
                                  //   onfieldSubmitted: (term) {
                                  //     _usernameFocus.unfocus();
                                  //     FocusScope.of(context)
                                  //         .requestFocus(_oldpasswordFocus);
                                  //   },
                                  //   validateTextField: (String? user) {
                                  //     if (!Validator.isValidUserName(user)) {
                                  //       return Constants.userError;
                                  //     }
                                  //   },
                                  //   prefixWidget: SvgPicture.asset(
                                  //     AppIcon.userIcon,
                                  //     color: AppColors.textColor,
                                  //     width: 20,
                                  //     key: const Key(Keys.userIcon),
                                  //   ),
                                  // ),

                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),

                                  /// Old Password field
                                  if (widget.viaNavigationDrawer) ...[
                                    Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: const Text(
                                            Constants.oldPassword,
                                            style: Styles.textStyleBlack16,
                                          ),
                                        ),
                                        CommonWidgets.verticalSpacerWidget(
                                            height * 0.001),
                                        LoginPassword(
                                          passFocusNode: oldPasswordFocus,
                                          textInputAction: TextInputAction.next,
                                          validatePassword:
                                              ((String? password) {
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
                                            oldPasswordFocus.unfocus();
                                            FocusScope.of(context)
                                                .requestFocus(newPasswordFocus);
                                          },
                                          onChange: (String password) {
                                            oldPassword = password;
                                          },
                                        ),
                                      ],
                                    )
                                  ],

                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.03),
                                  Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: const Text(
                                          Constants.newPassword,
                                          style: Styles.textStyleBlack16,
                                        ),
                                      ),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.001),
                                      LoginPassword(
                                        passFocusNode: newPasswordFocus,
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
                                          newPasswordFocus.unfocus();
                                          try {
                                            if (loginFormKey.currentState!
                                                .validate()) {
                                              log('username $username password $oldPassword');
                                              // bloc.add(LoginVerifyEvent(
                                              //     requestModel:
                                              //     prepareLoginRequestBody(
                                              //         username, oldPassword, ''),
                                              //     isFromLogin: true));
                                            }
                                          } catch (e) {
                                            // present userwith error message
                                          }
                                        },
                                        onChange: (String password) {
                                          newPassword = password;
                                        },
                                      ),
                                    ],
                                  ),

                                  /// Confirm New Password
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.03),
                                  Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: const Text(
                                          Constants.confirmNewPassword,
                                          style: Styles.textStyleBlack16,
                                        ),
                                      ),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.001),
                                      LoginPassword(
                                        passFocusNode: confirmNewPasswordFocus,
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
                                          confirmNewPasswordFocus.unfocus();
                                          try {
                                            if (loginFormKey.currentState!
                                                .validate()) {
                                              log('username $username password $oldPassword');
                                            }
                                          } catch (e) {
                                            // present userwith error message
                                          }
                                        },
                                        onChange: (String password) {
                                          confirmNewPassword = password;
                                        },
                                      ),
                                    ],
                                  ),

                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.03),

                                  // Login button
                                  AppButton(
                                    key: const Key(Keys.loginButton),
                                    buttonText: Constants.update,
                                    buttonTextKey: Keys.loginButtonText,
                                    onTap: () async {
                                      //loginFormKey.currentState!.validate();
                                      FocusScope.of(context).unfocus();
                                      try {
                                        if (loginFormKey.currentState!
                                            .validate()) {
                                          log('username $username password $oldPassword');
                                          bloc.add(UpdatePwdEvent(
                                            requestModel: UpdatePasswordRequest(
                                              request: UpdateRequest(
                                                password: oldPassword,
                                                confirmPassword:
                                                    confirmNewPassword,
                                                newPassword: newPassword,
                                              ),
                                            ),
                                          ));
                                        }
                                      } catch (e) {
                                        // present userwith error message
                                      }
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
                                      context, forgotPwdScreenRoute)
                                },
                                title: Constants.forgotPwdTitle,
                              ),
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
      {String? userName, String? pwd, String? otp}) {
    return LoginRequestModel(
        request: Request(userName: username, password: oldPassword, otp: otp));
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
            Constants.resetPwdTitle,
            style: Styles.styleHeaderGreyText30,
          ),
        ),
      ],
    );
  }
}
