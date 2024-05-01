import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/login/services/login_services.dart';

class ForgotPwdScreen extends StatelessWidget {
  const ForgotPwdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (_) => LoginBloc(loginService: LoginService()),
      child: const ForgotPwdWidget(),
    );
  }
}

class ForgotPwdWidget extends StatefulWidget {
  const ForgotPwdWidget({super.key});

  @override
  State<ForgotPwdWidget> createState() => _ForgotPwdWidgetState();
}

class _ForgotPwdWidgetState extends State<ForgotPwdWidget> {
  TextEditingController emailTextController = TextEditingController();
  String email = '';

  final GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<LoginBloc>(context);

    final size = MediaQuery.of(context).size;
    final height = size.height;

    return Scaffold(
      appBar: AppHeader(
        isTitleCenter: false,
        backBtn: IconButton(
          onPressed: () {
            Navigator.pop(context);
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
            log('--1--------');
            dismissLoadingDialog(context);
            _showCustomPop(context, state.message);
          } else if (state is LoginSuccessState) {
            log('--1---2-----');
            dismissLoadingDialog(context);
            _showCustomPop(context, state.message);
          } else if (state is LoginLoadingState) {
            log('--1-----3---');
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
                        child: Form(
                          key: emailFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // OTP welcome text and image
                              welcomeLogin(),
                              CommonWidgets.verticalSpacerWidget(height * 0.03),
                              // otp input field

                              /// Status
                              CommonWidgets.textDisplay(
                                  Constants.username, Styles.textStyleBlack14),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                //mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  FlutterInputField(
                                    controller: emailTextController,
                                    textFormKey: Keys.userTextField,
                                    hintText: Constants.hintUserName,
                                    textInputType: TextInputType.text,
                                    onChange: (String text) {
                                      email = text;
                                      setState(() {});
                                    },
                                    validateTextField: (String? user) {
                                      if (!Validator.isValidUserName(user)) {
                                        return Constants.enterusername;
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  // Login button
                                  AppButton(
                                    key: const Key(Keys.loginButton),
                                    buttonText: Constants.send,
                                    buttonTextKey: Keys.loginButtonText,
                                    onTap: () async {
                                      FocusScope.of(context).unfocus();
                                      try {
                                        if (emailFormKey.currentState!
                                            .validate()) {
                                          bloc.add(
                                            ForgotPwdEvent(
                                              requestModel:
                                                  prepareLoginRequestBody(
                                                      email, '', ''),
                                            ),
                                          );
                                        }
                                      } catch (e) {
                                        log('$e');
                                      }
                                    },
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                    height * 0.03,
                                  ),
                                ],
                              ),

                              CommonWidgets.verticalSpacerWidget(
                                height * 0.17,
                              ), // Support numbers
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
        request: Request(userName: userName, password: pwd, otp: otp));
  }

  _showCustomPop(BuildContext context, String msg) {
    var dialog = CustomAlertDialog(
        title: Constants.appname,
        message: msg,
        onPositivePressed: () {
          //Validator.logoutAction(context);
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
        positiveBtnText: Constants.yes,
        negativeBtnText: '');
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => dialog);
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
            Constants.forgotPwdTitle,
            style: Styles.styleHeaderGreyText30,
          ),
        ),
      ],
    );
  }
}
