import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/login/services/login_services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpVerifyScreen extends StatelessWidget {
  final String userName;
  final String password;
  final String deviceToken;

  const OtpVerifyScreen({
    super.key,
    this.userName = '',
    this.password = '',
    this.deviceToken = '',
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (_) => LoginBloc(loginService: LoginService()),
      child: OtpVerify(
        userName: userName,
        pwd: password,
        deviceToken: deviceToken,
      ),
    );
  }
}

class OtpVerify extends StatefulWidget {
  final String userName;
  final String pwd;
  final String deviceToken;

  const OtpVerify(
      {super.key,
      required this.userName,
      required this.pwd,
      required this.deviceToken});

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
      // appBar: AppHeader(
      //   isTitleCenter: false,
      //   backBtn: IconButton(
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //     icon: const Icon(Icons.arrow_back_ios_new_outlined,
      //         color: Colors.white),
      //   ),
      // ),
      // Positioned(
      //   top: MediaQuery.of(context).padding.top + 8,
      //   left: 8,
      //   child: SafeArea(
      //     child: BackButton(
      //       color: Colors.white, // Ensure contrast color for visibility
      //       onPressed: () {
      //         Navigator.of(context).pop();
      //       },
      //     ),
      //   ),
      // ),
      backgroundColor: AppColors.cardBgColor,
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailureState) {
            dismissLoadingDialog(context);
            log('-state.status-${state.status}---');
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
              return Scaffold(
                body: Stack(
                  children: [
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 10, // to avoid notch/status bar
                      left: 10,
                      child: BackButton(
                        color: Colors.white, // or choose suitable color
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    // Background Gradient + Wavy Image
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF845EF7),
                            Color(0xFF6A89CC),
                            Color(0xFF7589E9),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Image.asset(
                        'assets/images/login4.png',
                        fit: BoxFit.fitHeight,
                        width: double.infinity,
                      ),
                    ),

                    // Logo or heading text
                    Positioned(
                      top: size.height * 0.11, // adjust this value to move up/down
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/logo1.png', // your logo asset
                            height: 100,
                          ),
                          // const SizedBox(height: 2),
                          // Text(
                          //   "ATOM",
                          //   style: TextStyle(
                          //     fontSize: 48, // slightly bigger for impact
                          //     color: Colors.white,
                          //     fontWeight: FontWeight.w900, // extra bold
                          //     letterSpacing: 1.5,
                          //     shadows: [
                          //       Shadow(
                          //         color: Colors.black38, // subtle shadow for depth
                          //         offset: Offset(2, 2),
                          //         blurRadius: 4,
                          //       ),
                          //       Shadow(
                          //         color: Colors.white24, // subtle light glow
                          //         offset: Offset(-1, -1),
                          //         blurRadius: 6,
                          //       ),
                          //     ],
                          //   ),
                          //  )
                        ],
                      ),
                    ),


                    // Centered OTP Form Container
                    Padding(
                      padding: const EdgeInsets.only(top: 60.0),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                            child: Container(
                              width: size.width * 0.9,
                              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 18),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.30),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.07),
                                    blurRadius: 16,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                                border: Border.all(color: Colors.white.withOpacity(0.25)),
                              ),
                              child: SingleChildScrollView(
                                child: Form(
                                  key: otpFormKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      // Heading text
                                      const Text(
                                        'OTP Verification',
                                        style: TextStyle(
                                          fontSize: 32,
                                          fontFamily: 'Bungee',
                                          color: Color(0xFF000080),
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                      const SizedBox(height: 20),

                                      // Instruction text
                                      Text(
                                        'Enter OTP sent to this user ${widget.userName}',
                                        style: Styles.textStyleBlack14.copyWith(fontSize: 16),
                                        textAlign: TextAlign.center,
                                      ),

                                      const SizedBox(height: 30),

                                      // 6-box OTP Field
                                      OtpTextField(
                                        numberOfFields: 6,
                                        borderColor: const Color(0xFF000080),
                                        showFieldAsBox: true,
                                        fieldWidth: 48,
                                        fillColor: Colors.blueAccent,
                                        hasCustomInputDecoration: true,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white.withOpacity(0.4),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(4.0),
                                            // borderSide: BorderSide(color: const Color(0xFF512DA8)),
                                          ),
                                          counterText: '',
                                        ),
                                        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                        // textFieldAlignment: MainAxisAlignment.spaceEvenly,
                                        onCodeChanged: (String code) {
                                          otp = code;
                                          setState(() {});
                                        },
                                        onSubmit: (String verificationCode) {
                                          otp = verificationCode;
                                          bloc.add(
                                            LoginVerifyEvent(
                                              requestModel: prepareLoginRequestBody(
                                                userName: widget.userName,
                                                pwd: widget.pwd,
                                                otp: otp,
                                                deviceToken: widget.deviceToken,
                                                deviceType: Platform.isIOS
                                                    ? '1'
                                                    : (Platform.isAndroid ? '0' : '-1'),
                                              ),
                                              isFromLogin: false,
                                            ),
                                          );
                                        },
                                      ),


                                      const SizedBox(height: 24),
                                      const Text(
                                        "Didn't receive any code?",
                                        style: Styles.textStyleBlack14,
                                      ),
                                      const SizedBox(height: 8),

                                      // Resend link
                                      InkWell(
                                        onTap: () {
                                          otp = '';
                                          bloc.add(LoginVerifyEvent(
                                            requestModel: prepareLoginRequestBody(
                                              userName: widget.userName,
                                              pwd: widget.pwd,
                                              otp: '',
                                            ),
                                            isFromLogin: true,
                                          ));
                                        },
                                        child: const Text(
                                          'Resend OTP?',
                                          style: Styles.textStyleBlack14,
                                        ),
                                      ),

                                      const SizedBox(height: 30),

                                      // Verify Button
                                      // SizedBox(
                                      //   width: double.infinity,
                                      //   child: AppButton(
                                      //     key: const Key(Keys.loginButton),
                                      //     buttonText: Constants.loginVerifyOtpTitle,
                                      //     buttonTextKey: Keys.loginButtonText,
                                      //     onTap: () async {
                                            // FocusScope.of(context).unfocus();
                                            // try {
                                            //   if (otpFormKey.currentState!.validate()) {
                                            //     log('username ${widget.userName} password ${widget.pwd}');
                                            //     bloc.add(
                                            //       LoginVerifyEvent(
                                            //         requestModel: prepareLoginRequestBody(
                                            //           userName: widget.userName,
                                            //           pwd: widget.pwd,
                                            //           otp: otp,
                                            //           deviceToken: widget.deviceToken,
                                            //           deviceType: Platform.isIOS
                                            //               ? '1'
                                            //               : (Platform.isAndroid ? '0' : '-1'),
                                            //         ),
                                            //         isFromLogin: false,
                                            //       ),
                                            //     );
                                            //   }
                                            // } catch (e) {
                                            //   log('Error: $e');
                                            // }
                                          // },
                                        // ),
                                      // ),
                                      CommonWidgets.verticalSpacerWidget(height * 0.03),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Footer
                    Positioned(
                      bottom: 30,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Text(
                            Constants.copyrightText,
                            style: Styles.textStyleRegularGrey14.copyWith(color: Colors.white.withOpacity(0.74)),
                          ),
                          Text(
                            'Version: ${Platform.isIOS ? ConstantAppVersions.iOSVersion : ConstantAppVersions.androidVersion}',
                            style: Styles.textStyleRegularGrey14.copyWith(color: Colors.white.withOpacity(0.74)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );

              // return Container(
              //   color: AppColors.navigationSkyBlueColor,
              //   child: SingleChildScrollView(
              //     child: Column(
              //       children: [
              //         Container(
              //           padding: const EdgeInsets.all(20.0),
              //           decoration: const ShapeDecoration(
              //             color: AppColors.backgroundWhiteColor,
              //             shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.vertical(
              //                   top: Radius.circular(20.0)),
              //             ),
              //           ),
              //           child: Form(
              //             key: otpFormKey,
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.center,
              //               mainAxisSize: MainAxisSize.max,
              //               mainAxisAlignment: MainAxisAlignment.end,
              //               children: [
              //                 // OTP welcome text and image
              //                 welcomeLogin(),
              //                 CommonWidgets.verticalSpacerWidget(height * 0.03),
              //                 // otp input field
              //                 Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   //mainAxisAlignment: MainAxisAlignment.end,
              //                   children: [
              //                     Container(
              //                       alignment: Alignment.center,
              //                       child: Text(
              //                         'Enter OTP sent to this user ${widget.userName}',
              //                         style: Styles.textStyleRegularGrey14,
              //                       ),
              //                     ),
              //
              //                     const SizedBox(
              //                       height: 30,
              //                     ),
              //                     FlutterInputField(
              //                       controller: otpTextController,
              //                       textFormKey: Keys.userTextField,
              //                       hintText: Constants.hintOtp,
              //                       textInputType: TextInputType.number,
              //                       characterLimit: 6,
              //                       onChange: (String text) {
              //                         otp = text;
              //                         setState(() {});
              //                       },
              //                       validateTextField: (String? user) {
              //                         if (!Validator.isValidUserName(user)) {
              //                           return Constants.otpError;
              //                         }
              //                       },
              //                     ),
              //                     // OTPTextField(
              //                     //   length: 6,
              //                     //   width: MediaQuery.of(context).size.width,
              //                     //   fieldWidth: 40,
              //                     //   style: const TextStyle(fontSize: 17),
              //                     //   textFieldAlignment:
              //                     //       MainAxisAlignment.spaceAround,
              //                     //   fieldStyle: FieldStyle.box,
              //                     //   onCompleted: (pin) {
              //                     //     print("Completed: " + pin);
              //                     //     bloc.add(
              //                     //       LoginVerifyEvent(
              //                     //         requestModel:
              //                     //         prepareLoginRequestBody(
              //                     //           widget.userName,
              //                     //           widget.pwd,
              //                     //           pin,
              //                     //         ),
              //                     //         isFromLogin: false,
              //                     //       ),
              //                     //     );
              //                     //   },
              //                     // ),
              //                     CommonWidgets.verticalSpacerWidget(
              //                         height * 0.03),
              //                     Container(
              //                       alignment: Alignment.center,
              //                       child: const Text(
              //                         'Don\'t you receive any code?',
              //                         style: Styles.textStyleRegularGrey14,
              //                       ),
              //                     ),
              //                     // TODO: need to remove it
              //                     // Text(
              //                     //   'Device Token: ${widget.deviceToken}',
              //                     //   style: Styles.textStyleRegularGrey14,
              //                     // ),
              //                     const SizedBox(
              //                       height: 8,
              //                     ),
              //
              //                     InkWell(
              //                       onTap: () {
              //                         otpTextController.text = '';
              //                         bloc.add(LoginVerifyEvent(
              //                             requestModel: prepareLoginRequestBody(
              //                                 userName: widget.userName,
              //                                 pwd: widget.pwd,
              //                                 otp: ''),
              //                             isFromLogin: true));
              //                       },
              //                       child: Container(
              //                         alignment: Alignment.center,
              //                         child: const Text(
              //                           'Resend OTP?',
              //                           style: Styles.textStyleNavigator16,
              //                         ),
              //                       ),
              //                     ),
              //
              //                     const SizedBox(
              //                       height: 30,
              //                     ),
              //
              //                     // Login button
              //                     AppButton(
              //                       key: const Key(Keys.loginButton),
              //                       buttonText: Constants.loginVerifyOtpTitle,
              //                       buttonTextKey: Keys.loginButtonText,
              //                       onTap: () async {
              //                         FocusScope.of(context).unfocus();
              //                         try {
              //                           if (otpFormKey.currentState!
              //                               .validate()) {
              //                             log('username ${widget.userName} password ${widget.pwd}');
              //                             bloc.add(
              //                               LoginVerifyEvent(
              //                                 requestModel:
              //                                     prepareLoginRequestBody(
              //                                   userName: widget.userName,
              //                                   pwd: widget.pwd,
              //                                   otp: otp,
              //                                   deviceToken: widget.deviceToken,
              //                                   deviceType: Platform.isIOS
              //                                       ? '1'
              //                                       : (Platform.isAndroid
              //                                           ? '0'
              //                                           : '-1'),
              //                                 ),
              //                                 isFromLogin: false,
              //                               ),
              //                             );
              //                           }
              //                         } catch (e) {
              //                           log('Error: $e');
              //                         }
              //                       },
              //                     ),
              //
              //                     CommonWidgets.verticalSpacerWidget(
              //                       height * 0.03,
              //                     ),
              //                   ],
              //                 ),
              //
              //                 CommonWidgets.verticalSpacerWidget(
              //                   height * 0.17,
              //                 ), // Support numbers
              //               ],
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // );
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
      onPositivePressed: () {
        Navigator.of(context).pop();
      },
      positiveBtnText: Constants.ok,
    );
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
