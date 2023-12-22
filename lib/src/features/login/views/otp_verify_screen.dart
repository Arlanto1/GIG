import 'dart:developer';
import 'dart:io';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/login/services/login_services.dart';

class OtpVerifyScreen extends StatelessWidget {
  final String userName;
  final String password;

  const OtpVerifyScreen({
    super.key,
    this.userName = '',
    this.password = '',
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (_) => LoginBloc(loginService: LoginService()),
      child: OtpVerify(
        userName: userName,
        pwd: password,
      ),
    );
  }
}

class OtpVerify extends StatefulWidget {
  final String userName;
  final String pwd;

  const OtpVerify({super.key, required this.userName, required this.pwd});

  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  TextEditingController otpTextController = TextEditingController();
  String otp = '';

  final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();

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
          if (state is LoginFailureState) {
            dismissLoadingDialog(context);
            _showCustomPop(context, state.message);
          } else if (state is LoginSuccessState) {
            dismissLoadingDialog(context);
            _showCustomPop(context, state.message);
          } else if (state is LoginVerifyOtpActionState) {
            dismissLoadingDialog(context);
            Navigator.pushNamedAndRemoveUntil(
              context,
              dashboardViewRoute,
              (route) => false,
            );
          } else if (state is UpdatePasswordState) {
            log('--LoginFailureState---');
            dismissLoadingDialog(context);
            // TODO: May be need to clear navigation stack
            Navigator.pushNamed(
              context,
              resetPwdScreenRoute,
              // (route) => false,
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
                          ),
                        ),
                        child: Form(
                          key: otpFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // OTP welcome text and image
                              welcomeLogin(),
                              CommonWidgets.verticalSpacerWidget(height * 0.03),
                              // otp input field
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                //mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Enter OTP sent to this user ${widget.userName}',
                                      style: Styles.textStyleRegularGrey14,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 30,
                                  ),
                                  FlutterInputField(
                                    textFieldController: otpTextController,
                                    textFormKey: Keys.userTextField,
                                    hintText: Constants.hintOtp,
                                    keyboardType: TextInputType.number,
                                    onChange: (String text) {
                                      otp = text;
                                      setState(() {});
                                    },
                                    validateTextField: (String? user) {
                                      if (!Validator.isValidUserName(user)) {
                                        return Constants.otpError;
                                      }
                                    },
                                  ),
                                  // OTPTextField(
                                  //   length: 6,
                                  //   width: MediaQuery.of(context).size.width,
                                  //   fieldWidth: 40,
                                  //   style: const TextStyle(fontSize: 17),
                                  //   textFieldAlignment:
                                  //       MainAxisAlignment.spaceAround,
                                  //   fieldStyle: FieldStyle.box,
                                  //   onCompleted: (pin) {
                                  //     print("Completed: " + pin);
                                  //     bloc.add(
                                  //       LoginVerifyEvent(
                                  //         requestModel:
                                  //         prepareLoginRequestBody(
                                  //           widget.userName,
                                  //           widget.pwd,
                                  //           pin,
                                  //         ),
                                  //         isFromLogin: false,
                                  //       ),
                                  //     );
                                  //   },
                                  // ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.03),
                                  Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'Don\'t you receive any code?',
                                      style: Styles.textStyleRegularGrey14,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 8,
                                  ),

                                  InkWell(
                                    onTap: () {
                                      bloc.add(LoginVerifyEvent(
                                          requestModel: prepareLoginRequestBody(
                                              userName: widget.userName,
                                              pwd: widget.pwd,
                                              otp: ''),
                                          isFromLogin: true));
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Resend OTP?',
                                        style: Styles.textStyleNavigator16,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 30,
                                  ),

                                  // Login button
                                  AppButton(
                                    key: const Key(Keys.loginButton),
                                    buttonText: Constants.loginVerifyOtpTitle,
                                    buttonTextKey: Keys.loginButtonText,
                                    onTap: () async {
                                      FocusScope.of(context).unfocus();
                                      try {
                                        if (otpFormKey.currentState!
                                            .validate()) {
                                          log('username ${widget.userName} password ${widget.pwd}');
                                          bloc.add(
                                            LoginVerifyEvent(
                                              requestModel:
                                                  prepareLoginRequestBody(
                                                userName: widget.userName,
                                                pwd: widget.pwd,
                                                otp: otp,
                                                deviceToken: await SharedPrefs
                                                    .getDeviceToken(),
                                                deviceType: Platform.isIOS
                                                    ? '1'
                                                    : (Platform.isAndroid
                                                        ? '0'
                                                        : '-1'),
                                              ),
                                              isFromLogin: false,
                                            ),
                                          );
                                        }
                                      } catch (e) {}
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

  LoginRequestModel prepareLoginRequestBody({
    required String userName,
    required String pwd,
    String? otp,
    String? deviceToken,
    String? deviceType,
  }) {
    return LoginRequestModel(
        request: Request(
      userName: userName,
      password: pwd,
      otp: otp,
      deviceToken: deviceToken,
      deviceType: deviceType,
    ));
  }

  _showCustomPop(BuildContext context, String msg) {
    var dialog = CustomAlertDialog(
        title: Constants.appname,
        message: msg,
        onPostivePressed: () {
          //Validator.logoutAction(context);
          Navigator.of(context).pop();
        },
        positiveBtnText: Constants.yes,
        negativeBtnText: '');
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
            Constants.otpVerificationTitle,
            style: Styles.styleHeaderGreyText30,
          ),
        ),
      ],
    );
  }
}
