//
// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
//
// //
// // class OtpVerifyScreen extends StatelessWidget {
// //   final String userName;
// //   final String password;
// //   final String deviceToken;
// //
// //   const OtpVerifyScreen({
// //     super.key,
// //     this.userName = '',
// //     this.password = '',
// //     this.deviceToken = '',
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocProvider<LoginBloc>(
// //       create: (_) => LoginBloc(loginService: LoginService()),
// //       child: OtpVerify(
// //         userName: userName,
// //         pwd: password,
// //         deviceToken: deviceToken,
// //       ),
// //     );
// //   }
// // }
// //
// // class OtpVerify extends StatefulWidget {
// //   final String userName;
// //   final String pwd;
// //   final String deviceToken;
// //
// //   const OtpVerify(
// //       {super.key,
// //       required this.userName,
// //       required this.pwd,
// //       required this.deviceToken});
// //
// //   @override
// //   State<OtpVerify> createState() => _OtpVerifyState();
// // }
// //
// // class _OtpVerifyState extends State<OtpVerify> {
// //   TextEditingController otpTextController = TextEditingController();
// //   String otp = '';
// //
// //   final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final bloc = BlocProvider.of<LoginBloc>(context);
// //
// //     final size = MediaQuery.of(context).size;
// //     final height = size.height;
// //
// //     return Scaffold(
// //       // appBar: AppHeader(
// //       //   isTitleCenter: false,
// //       //   backBtn: IconButton(
// //       //     onPressed: () {
// //       //       Navigator.pop(context);
// //       //     },
// //       //     icon: const Icon(Icons.arrow_back_ios_new_outlined,
// //       //         color: Colors.white),
// //       //   ),
// //       // ),
// //       // Positioned(
// //       //   top: MediaQuery.of(context).padding.top + 8,
// //       //   left: 8,
// //       //   child: SafeArea(
// //       //     child: BackButton(
// //       //       color: Colors.white, // Ensure contrast color for visibility
// //       //       onPressed: () {
// //       //         Navigator.of(context).pop();
// //       //       },
// //       //     ),
// //       //   ),
// //       // ),
// //       backgroundColor: AppColors.cardBgColor,
// //       body: BlocConsumer<LoginBloc, LoginState>(
// //         listener: (context, state) {
// //           if (state is LoginFailureState) {
// //             dismissLoadingDialog(context);
// //             log('-state.status-${state.status}---');
// //             if (state.status == FormStatus.permissionLocationError) {
// //               var dialog = CustomAlertDialog(
// //                   title: 'Location Permission',
// //                   message: state.message,
// //                   onPositivePressed: () async {
// //                     openAppSettings();
// //                     Navigator.of(context).pop();
// //                     setState(() {
// //                       state.status == FormStatus.success;
// //                     });
// //                   },
// //                   onNegativePressed: () {
// //                     log('--onNegativePressed--');
// //                   },
// //                   positiveBtnText: Constants.settings,
// //                   negativeBtnText: Constants.no);
// //               // showDialog(
// //               //     context: context, builder: (BuildContext context) => dialog);
// //               return;
// //             }
// //
// //             _showCustomPop(context, state.message);
// //           } else if (state is LoginSuccessState) {
// //             dismissLoadingDialog(context);
// //             _showCustomPop(context, state.message);
// //           } else if (state is LoginVerifyOtpActionState) {
// //             dismissLoadingDialog(context);
// //             Navigator.pushNamedAndRemoveUntil(
// //               context,
// //               dashboardViewRoute,
// //               (route) => false,
// //             );
// //           } else if (state is UpdatePasswordState) {
// //             log('--LoginFailureState---');
// //             dismissLoadingDialog(context);
// //             // TODO: May be need to clear navigation stack
// //             Navigator.pushNamed(
// //               context,
// //               resetPwdScreenRoute,
// //               // (route) => false,
// //             );
// //           } else if (state is LoginLoadingState) {
// //             showLoadingDialog(context);
// //           }
// //         },
// //         builder: (context, state) {
// //           return BlocBuilder<LoginBloc, LoginState>(
// //             builder: (context, state) {
// //               if (state is LoginLoadingState) {
// //               } else if (state is LoginFailureState) {
// //               } else if (state is LoginSuccessState) {}
// //               return Scaffold(
// //                 body: Stack(
// //                   children: [
// //                     Positioned(
// //                       // top: MediaQuery.of(context).padding.top + 10, // to avoid notch/status bar
// //                       // left: 10,
// //                       child: BackButton(
// //                         color: Colors.white, // or choose suitable color
// //                         onPressed: () {
// //                           Navigator.of(context).pop();
// //                         },
// //                       ),
// //                     ),
// //                     // Background Gradient + Wavy Image
// //                     Container(
// //                       width: double.infinity,
// //                       height: double.infinity,
// //                       decoration: const BoxDecoration(
// //                         gradient: LinearGradient(
// //                           colors: [
// //                             Color(0xFF845EF7),
// //                             Color(0xFF6A89CC),
// //                             Color(0xFF7589E9),
// //                           ],
// //                           begin: Alignment.topLeft,
// //                           end: Alignment.bottomRight,
// //                         ),
// //                       ),
// //                       child: Image.asset(
// //                         'assets/images/login4.png',
// //                         fit: BoxFit.fitHeight,
// //                         width: double.infinity,
// //                       ),
// //                     ),
// //
// //                     // Logo or heading text
// //                     // Positioned(
// //                     //   top: size.height * 0.11, // adjust this value to move up/down
// //                     //   left: 0,
// //                     //   right: 0,
// //                     //   child: Column(
// //                     //     children: [
// //                     //       Image.asset(
// //                     //         'assets/images/logo1.png', // your logo asset
// //                     //         height: 100,
// //                     //       ),
// //                     //     ],
// //                     //   ),
// //                     // ),
// //                     Align(
// //                       alignment: Alignment.topCenter,
// //                       child: FractionallySizedBox(
// //                         widthFactor: 0.6,   // responsive width
// //                         child: Padding(
// //                           padding: EdgeInsets.only(top: size.height * 0.1),
// //                           child: Image.asset(
// //                             'assets/images/logo1.png',
// //                             fit: BoxFit.contain,
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //
// //
// //
// //
// //                     // Centered OTP Form Container
// //                     Padding(
// //                       padding: const EdgeInsets.only(),
// //                       child: Center(
// //                         child: ClipRRect(
// //                           borderRadius: BorderRadius.circular(30),
// //                           child: BackdropFilter(
// //                             filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
// //                             child: Container(
// //                               width: MediaQuery.of(context).size.width * 0.9,
// //                               // height: MediaQuery.of(context).size.width * 0.9,
// //                               padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 13.4),
// //                               decoration: BoxDecoration(
// //                                 color: Colors.white.withOpacity(0.30),
// //                                 borderRadius: BorderRadius.circular(20),
// //                                 boxShadow: [
// //                                   BoxShadow(
// //                                     color: Colors.black.withOpacity(0.07),
// //                                     blurRadius: 16,
// //                                     offset: const Offset(0, 4),
// //                                   ),
// //                                 ],
// //                                 border: Border.all(color: Colors.white.withOpacity(0.25)),
// //                               ),
// //                               child: SingleChildScrollView(
// //                                 child: Form(
// //                                   key: otpFormKey,
// //                                   child: Column(
// //                                     mainAxisSize: MainAxisSize.min,
// //                                     crossAxisAlignment: CrossAxisAlignment.center,
// //                                     children: [
// //                                       // Heading text
// //                                       const Text(
// //                                         'OTP Verification',
// //                                         style: TextStyle(
// //                                           fontSize: 32,
// //                                           fontFamily: 'Bungee',
// //                                           color: Color(0xFF000080),
// //                                           fontWeight: FontWeight.w900,
// //                                           letterSpacing: 2,
// //                                         ),
// //                                       ),
// //                                       const SizedBox(height: 20),
// //
// //                                       // Instruction text
// //                                       Text(
// //                                         'Enter OTP sent to this user ${widget.userName}',
// //                                         style: Styles.textStyleBlack14.copyWith(fontSize: 16),
// //                                         textAlign: TextAlign.center,
// //                                       ),
// //
// //                                       const SizedBox(height: 30),
// //
// //                                       // 6-box OTP Field
// //                                       OtpTextField(
// //                                         numberOfFields: 6,
// //                                         borderColor: const Color(0xFF000080),
// //                                         showFieldAsBox: true,
// //                                         fieldWidth: MediaQuery.of(context).size.width * 0.12,
// //                                         fillColor: Colors.blueAccent,
// //                                         hasCustomInputDecoration: true,
// //                                         decoration: InputDecoration(
// //                                           filled: true,
// //                                           fillColor: Colors.white.withOpacity(0.4),
// //                                           border: OutlineInputBorder(
// //                                             borderRadius: BorderRadius.circular(4.0),
// //                                             // borderSide: BorderSide(color: const Color(0xFF512DA8)),
// //                                           ),
// //                                           counterText: '',
// //                                         ),
// //                                         textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //                                         // textFieldAlignment: MainAxisAlignment.spaceEvenly,
// //                                         onCodeChanged: (String code) {
// //                                           otp = code;
// //                                           setState(() {});
// //                                         },
// //                                         onSubmit: (String verificationCode) {
// //                                           otp = verificationCode;
// //                                           bloc.add(
// //                                             LoginVerifyEvent(
// //                                               requestModel: prepareLoginRequestBody(
// //                                                 userName: widget.userName,
// //                                                 pwd: widget.pwd,
// //                                                 otp: otp,
// //                                                 deviceToken: widget.deviceToken,
// //                                                 deviceType: Platform.isIOS
// //                                                     ? '1'
// //                                                     : (Platform.isAndroid ? '0' : '-1'),
// //                                               ),
// //                                               isFromLogin: false,
// //                                             ),
// //                                           );
// //                                         },
// //                                       ),
// //
// //
// //                                       const SizedBox(height: 24),
// //                                       const Text(
// //                                         "Didn't receive any code?",
// //                                         style: Styles.textStyleBlack14,
// //                                       ),
// //                                       const SizedBox(height: 8),
// //
// //                                       // Resend link
// //                                       InkWell(
// //                                         onTap: () {
// //                                           otp = '';
// //                                           bloc.add(LoginVerifyEvent(
// //                                             requestModel: prepareLoginRequestBody(
// //                                               userName: widget.userName,
// //                                               pwd: widget.pwd,
// //                                               otp: '',
// //                                             ),
// //                                             isFromLogin: true,
// //                                           ));
// //                                         },
// //                                         child: const Text(
// //                                           'Resend OTP?',
// //                                           style: Styles.textStyleBlack14,
// //                                         ),
// //                                       ),
// //
// //                                       const SizedBox(height: 30),
// //
// //                                       // Verify Button
// //                                       // SizedBox(
// //                                       //   width: double.infinity,
// //                                       //   child: AppButton(
// //                                       //     key: const Key(Keys.loginButton),
// //                                       //     buttonText: Constants.loginVerifyOtpTitle,
// //                                       //     buttonTextKey: Keys.loginButtonText,
// //                                       //     onTap: () async {
// //                                             // FocusScope.of(context).unfocus();
// //                                             // try {
// //                                             //   if (otpFormKey.currentState!.validate()) {
// //                                             //     log('username ${widget.userName} password ${widget.pwd}');
// //                                             //     bloc.add(
// //                                             //       LoginVerifyEvent(
// //                                             //         requestModel: prepareLoginRequestBody(
// //                                             //           userName: widget.userName,
// //                                             //           pwd: widget.pwd,
// //                                             //           otp: otp,
// //                                             //           deviceToken: widget.deviceToken,
// //                                             //           deviceType: Platform.isIOS
// //                                             //               ? '1'
// //                                             //               : (Platform.isAndroid ? '0' : '-1'),
// //                                             //         ),
// //                                             //         isFromLogin: false,
// //                                             //       ),
// //                                             //     );
// //                                             //   }
// //                                             // } catch (e) {
// //                                             //   log('Error: $e');
// //                                             // }
// //                                           // },
// //                                         // ),
// //                                       // ),
// //                                       CommonWidgets.verticalSpacerWidget(height * 0.03),
// //                                     ],
// //                                   ),
// //                                 ),
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //
// //                     // Footer
// //                     Positioned(
// //                       bottom: 30,
// //                       left: 0,
// //                       right: 0,
// //                       child: Column(
// //                         children: [
// //                           Text(
// //                             Constants.copyrightText,
// //                             style: Styles.textStyleRegularGrey14.copyWith(color: Colors.white.withOpacity(0.74)),
// //                           ),
// //                           Text(
// //                             'Version: ${Platform.isIOS ? ConstantAppVersions.iOSVersion : ConstantAppVersions.androidVersion}',
// //                             style: Styles.textStyleRegularGrey14.copyWith(color: Colors.white.withOpacity(0.74)),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               );
// //
// //               // return Container(
// //               //   color: AppColors.navigationSkyBlueColor,
// //               //   child: SingleChildScrollView(
// //               //     child: Column(
// //               //       children: [
// //               //         Container(
// //               //           padding: const EdgeInsets.all(20.0),
// //               //           decoration: const ShapeDecoration(
// //               //             color: AppColors.backgroundWhiteColor,
// //               //             shape: RoundedRectangleBorder(
// //               //               borderRadius: BorderRadius.vertical(
// //               //                   top: Radius.circular(20.0)),
// //               //             ),
// //               //           ),
// //               //           child: Form(
// //               //             key: otpFormKey,
// //               //             child: Column(
// //               //               crossAxisAlignment: CrossAxisAlignment.center,
// //               //               mainAxisSize: MainAxisSize.max,
// //               //               mainAxisAlignment: MainAxisAlignment.end,
// //               //               children: [
// //               //                 // OTP welcome text and image
// //               //                 welcomeLogin(),
// //               //                 CommonWidgets.verticalSpacerWidget(height * 0.03),
// //               //                 // otp input field
// //               //                 Column(
// //               //                   crossAxisAlignment: CrossAxisAlignment.start,
// //               //                   //mainAxisAlignment: MainAxisAlignment.end,
// //               //                   children: [
// //               //                     Container(
// //               //                       alignment: Alignment.center,
// //               //                       child: Text(
// //               //                         'Enter OTP sent to this user ${widget.userName}',
// //               //                         style: Styles.textStyleRegularGrey14,
// //               //                       ),
// //               //                     ),
// //               //
// //               //                     const SizedBox(
// //               //                       height: 30,
// //               //                     ),
// //               //                     FlutterInputField(
// //               //                       controller: otpTextController,
// //               //                       textFormKey: Keys.userTextField,
// //               //                       hintText: Constants.hintOtp,
// //               //                       textInputType: TextInputType.number,
// //               //                       characterLimit: 6,
// //               //                       onChange: (String text) {
// //               //                         otp = text;
// //               //                         setState(() {});
// //               //                       },
// //               //                       validateTextField: (String? user) {
// //               //                         if (!Validator.isValidUserName(user)) {
// //               //                           return Constants.otpError;
// //               //                         }
// //               //                       },
// //               //                     ),
// //               //                     // OTPTextField(
// //               //                     //   length: 6,
// //               //                     //   width: MediaQuery.of(context).size.width,
// //               //                     //   fieldWidth: 40,
// //               //                     //   style: const TextStyle(fontSize: 17),
// //               //                     //   textFieldAlignment:
// //               //                     //       MainAxisAlignment.spaceAround,
// //               //                     //   fieldStyle: FieldStyle.box,
// //               //                     //   onCompleted: (pin) {
// //               //                     //     print("Completed: " + pin);
// //               //                     //     bloc.add(
// //               //                     //       LoginVerifyEvent(
// //               //                     //         requestModel:
// //               //                     //         prepareLoginRequestBody(
// //               //                     //           widget.userName,
// //               //                     //           widget.pwd,
// //               //                     //           pin,
// //               //                     //         ),
// //               //                     //         isFromLogin: false,
// //               //                     //       ),
// //               //                     //     );
// //               //                     //   },
// //               //                     // ),
// //               //                     CommonWidgets.verticalSpacerWidget(
// //               //                         height * 0.03),
// //               //                     Container(
// //               //                       alignment: Alignment.center,
// //               //                       child: const Text(
// //               //                         'Don\'t you receive any code?',
// //               //                         style: Styles.textStyleRegularGrey14,
// //               //                       ),
// //               //                     ),
// //               //                     // TODO: need to remove it
// //               //                     // Text(
// //               //                     //   'Device Token: ${widget.deviceToken}',
// //               //                     //   style: Styles.textStyleRegularGrey14,
// //               //                     // ),
// //               //                     const SizedBox(
// //               //                       height: 8,
// //               //                     ),
// //               //
// //               //                     InkWell(
// //               //                       onTap: () {
// //               //                         otpTextController.text = '';
// //               //                         bloc.add(LoginVerifyEvent(
// //               //                             requestModel: prepareLoginRequestBody(
// //               //                                 userName: widget.userName,
// //               //                                 pwd: widget.pwd,
// //               //                                 otp: ''),
// //               //                             isFromLogin: true));
// //               //                       },
// //               //                       child: Container(
// //               //                         alignment: Alignment.center,
// //               //                         child: const Text(
// //               //                           'Resend OTP?',
// //               //                           style: Styles.textStyleNavigator16,
// //               //                         ),
// //               //                       ),
// //               //                     ),
// //               //
// //               //                     const SizedBox(
// //               //                       height: 30,
// //               //                     ),
// //               //
// //               //                     // Login button
// //               //                     AppButton(
// //               //                       key: const Key(Keys.loginButton),
// //               //                       buttonText: Constants.loginVerifyOtpTitle,
// //               //                       buttonTextKey: Keys.loginButtonText,
// //               //                       onTap: () async {
// //               //                         FocusScope.of(context).unfocus();
// //               //                         try {
// //               //                           if (otpFormKey.currentState!
// //               //                               .validate()) {
// //               //                             log('username ${widget.userName} password ${widget.pwd}');
// //               //                             bloc.add(
// //               //                               LoginVerifyEvent(
// //               //                                 requestModel:
// //               //                                     prepareLoginRequestBody(
// //               //                                   userName: widget.userName,
// //               //                                   pwd: widget.pwd,
// //               //                                   otp: otp,
// //               //                                   deviceToken: widget.deviceToken,
// //               //                                   deviceType: Platform.isIOS
// //               //                                       ? '1'
// //               //                                       : (Platform.isAndroid
// //               //                                           ? '0'
// //               //                                           : '-1'),
// //               //                                 ),
// //               //                                 isFromLogin: false,
// //               //                               ),
// //               //                             );
// //               //                           }
// //               //                         } catch (e) {
// //               //                           log('Error: $e');
// //               //                         }
// //               //                       },
// //               //                     ),
// //               //
// //               //                     CommonWidgets.verticalSpacerWidget(
// //               //                       height * 0.03,
// //               //                     ),
// //               //                   ],
// //               //                 ),
// //               //
// //               //                 CommonWidgets.verticalSpacerWidget(
// //               //                   height * 0.17,
// //               //                 ), // Support numbers
// //               //               ],
// //               //             ),
// //               //           ),
// //               //         ),
// //               //       ],
// //               //     ),
// //               //   ),
// //               // );
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }
// //
// //   LoginRequestModel prepareLoginRequestBody({
// //     required String userName,
// //     required String pwd,
// //     String? otp,
// //     String? deviceToken,
// //     String? deviceType,
// //   }) {
// //     return LoginRequestModel(
// //         request: Request(
// //       userName: userName,
// //       password: pwd,
// //       otp: otp,
// //       deviceToken: deviceToken,
// //       deviceType: deviceType,
// //     ));
// //   }
// //
// //   _showCustomPop(BuildContext context, String msg) {
// //     var dialog = CustomAlertDialog(
// //       title: Constants.appname,
// //       message: msg,
// //       onPositivePressed: () {
// //         Navigator.of(context).pop();
// //       },
// //       positiveBtnText: Constants.ok,
// //     );
// //     showDialog(context: context, builder: (BuildContext context) => dialog);
// //   }
// //
// //   Widget welcomeLogin() {
// //     return Column(
// //       children: [
// //         Container(
// //           padding: const EdgeInsets.all(20.0),
// //           child: Image.asset(
// //             AppIcon.titleLogoLogin,
// //             width: 200,
// //             height: 70,
// //           ),
// //         ),
// //         CommonWidgets.verticalSpacerWidget(
// //             MediaQuery.of(context).size.height * 0.001),
// //         Container(
// //           alignment: Alignment.center,
// //           child: Text(
// //             Constants.otpVerificationTitle,
// //             style: Styles.styleHeaderGreyText30,
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
//
// import 'dart:developer';
// import 'dart:io';
// import 'dart:ui';
//
// import 'package:db_atom/index.dart';
// import 'package:db_atom/src/features/login/services/login_services.dart';
// import 'package:permission_handler/permission_handler.dart';
// // import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
//
// class OtpVerifyScreen extends StatelessWidget {
//   final String userName;
//   final String password;
//   final String deviceToken;
//
//   const OtpVerifyScreen({
//     super.key,
//     this.userName = '',
//     this.password = '',
//     this.deviceToken = '',
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<LoginBloc>(
//       create: (_) => LoginBloc(loginService: LoginService()),
//       child: OtpVerify(
//         userName: userName,
//         pwd: password,
//         deviceToken: deviceToken,
//       ),
//     );
//   }
// }
//
// class OtpVerify extends StatefulWidget {
//   final String userName;
//   final String pwd;
//   final String deviceToken;
//
//   const OtpVerify(
//       {super.key,
//       required this.userName,
//       required this.pwd,
//       required this.deviceToken});
//
//   @override
//   State<OtpVerify> createState() => _OtpVerifyState();
// }
//
// class _OtpVerifyState extends State<OtpVerify> {
//   TextEditingController otpTextController = TextEditingController();
//   String otp = '';
//
//   final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     final bloc = BlocProvider.of<LoginBloc>(context);
//
//     final size = MediaQuery.of(context).size;
//     // double screenWidth = MediaQuery.of(context).size.width;
//     // double fieldWidth = (screenWidth - 180) / 5.4; // subtract spacing
//     double screenWidth = MediaQuery.of(context).size.width;
//
// // Detect device type
//     bool isTablet = screenWidth > 600;
//
// // Responsive field width
// //     double horizontalPadding = isTablet ? 120.0 : 48.0;
// //     double spacingBetweenFields = isTablet ? 60.0 : 36.0;
//     return Scaffold(
//       backgroundColor: AppColors.cardBgColor,
//       body: BlocConsumer<LoginBloc, LoginState>(
//         listener: (context, state) {
//           if (state is LoginFailureState) {
//             dismissLoadingDialog(context);
//             log('-state.status-${state.status}---');
//             if (state.status == FormStatus.permissionLocationError) {
//               var dialog = CustomAlertDialog(
//                   title: 'Location Permission',
//                   message: state.message,
//                   onPositivePressed: () async {
//                     openAppSettings();
//                     Navigator.of(context).pop();
//                     setState(() {
//                       state.status == FormStatus.success;
//                     });
//                   },
//                   onNegativePressed: () {
//                     log('--onNegativePressed--');
//                   },
//                   positiveBtnText: Constants.settings,
//                   negativeBtnText: Constants.no);
//               // showDialog(
//               //     context: context, builder: (BuildContext context) => dialog);
//               return;
//             }
//
//             _showCustomPop(context, state.message);
//           } else if (state is LoginSuccessState) {
//             dismissLoadingDialog(context);
//             _showCustomPop(context, state.message);
//           } else if (state is LoginVerifyOtpActionState) {
//             dismissLoadingDialog(context);
//             Navigator.pushNamedAndRemoveUntil(
//               context,
//               dashboardViewRoute,
//               (route) => false,
//             );
//           } else if (state is UpdatePasswordState) {
//             log('--LoginFailureState---');
//             dismissLoadingDialog(context);
//             // TODO: May be need to clear navigation stack
//             Navigator.pushNamed(
//               context,
//               resetPwdScreenRoute,
//               // (route) => false,
//             );
//           } else if (state is LoginLoadingState) {
//             showLoadingDialog(context);
//           }
//         },
//         builder: (context, state) {
//           return BlocBuilder<LoginBloc, LoginState>(
//             builder: (context, state) {
//               if (state is LoginLoadingState) {
//               } else if (state is LoginFailureState) {
//               } else if (state is LoginSuccessState) {}
//               return Scaffold(
//                 body: Stack(
//                   children: [
//                     Positioned(
//                       // top: MediaQuery.of(context).padding.top + 10, // to avoid notch/status bar
//                       // left: 10,
//                       child: BackButton(
//                         color: Colors.white, // or choose suitable color
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                       ),
//                     ),
//                     // Background Gradient + Wavy Image
//                     SizedBox(
//                       width: double.infinity,
//                       height: double.infinity,
//                       // decoration: const BoxDecoration(
//                       //   gradient: LinearGradient(
//                       //     colors: [
//                       //       Color(0xFF845EF7),
//                       //       Color(0xFF6A89CC),
//                       //       Color(0xFF7589E9),
//                       //     ],
//                       //     begin: Alignment.topLeft,
//                       //     end: Alignment.bottomRight,
//                       //   ),
//                       // ),
//                       child: Image.asset(
//                         'assets/images/login4.png',
//                         fit: BoxFit.cover,
//                         width: double.infinity,
//                       ),
//                     ),
//
//                     Align(
//                       alignment: Alignment.topCenter,
//                       child: FractionallySizedBox(
//                         widthFactor: 0.5, // responsive width
//                         child: Padding(
//                           padding: EdgeInsets.only(top: size.height * 0.15),
//                           child: Image.asset(
//                             'assets/images/GIG.png',
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                       ),
//                     ),
//
//                     SafeArea(
//                       child: Align(
//                         // alignment: const Alignment(0, 0.1),
//                         child: SingleChildScrollView(
//                             physics: const BouncingScrollPhysics(),
//                             // padding: EdgeInsets.only(
//                             //   top: size.height * 0.10,
//                             //   bottom: 100,
//                             // ),
//                             child: Column(
//                               children: [
//                                 /// MAIN GLASS CARD
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(40),
//                                   child: BackdropFilter(
//                                     filter: ImageFilter.blur(
//                                       sigmaX: 22,
//                                       sigmaY: 22,
//                                     ),
//                                     child: Container(
//                                       width: size.width > 600
//                                           ? size.width * 0.99
//                                           : size.width * 0.95,
//                                       padding: const EdgeInsets.symmetric(
//                                         horizontal: 22,
//                                         vertical: 80,
//                                       ),
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(40),
//                                         color: Colors.transparent,
//                                         border: Border.all(
//                                           color: Colors.white
//                                               .withValues(alpha: 0.50),
//                                         ),
//                                       ),
//                                       child: Form(
//                                         key: otpFormKey,
//                                         child: Column(
//                                           children: [
//                                             /// LOGIN TITLE
//                                             Text(
//                                               "OTP Verification",
//                                               style: TextStyle(
//                                                 color: AppColors.newColor,
//                                                 fontSize: 34,
//                                                 fontWeight: FontWeight.w800,
//                                               ),
//                                             ),
//
//                                             const SizedBox(height: 10),
//
//                                             /// GLOW DIVIDER
//                                             Row(
//                                               children: [
//                                                 Expanded(
//                                                   child: Divider(
//                                                     color: Colors.white
//                                                         .withValues(
//                                                             alpha: 0.25),
//                                                   ),
//                                                 ),
//                                                 Container(
//                                                   margin: const EdgeInsets
//                                                       .symmetric(
//                                                       horizontal: 10),
//                                                   height: 10,
//                                                   width: 10,
//                                                   decoration: BoxDecoration(
//                                                     shape: BoxShape.circle,
//                                                     color: Colors.white,
//                                                     boxShadow: [
//                                                       BoxShadow(
//                                                         color: Colors.white
//                                                             .withValues(
//                                                                 alpha: 0.7),
//                                                         blurRadius: 12,
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 Expanded(
//                                                   child: Divider(
//                                                     color: Colors.white
//                                                         .withValues(
//                                                             alpha: 0.25),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//
//                                             Text(
//                                               'Enter OTP sent to this user ${widget.userName}',
//                                               style: Styles.textStyleWhite14
//                                                   .copyWith(fontSize: 16),
//                                               textAlign: TextAlign.center,
//                                             ),
//
//                                             const SizedBox(height: 10),
//                                              // 6-box OTP Field
//                                             OtpTextField(
//                                               numberOfFields: 6,
//                                               borderColor:
//                                                   const Color(0xFF000080),
//                                               showFieldAsBox: true,
//                                               fieldWidth:
//                                                   isTablet ? 80.0 : 50.0,
//                                               fieldHeight:
//                                                   isTablet ? 64.0 : 50.0,
//                                               // ✅ responsive height
//                                               fillColor: Colors.blueAccent,
//                                               hasCustomInputDecoration: true,
//                                               decoration: InputDecoration(
//                                                 filled: true,
//                                                 fillColor: Colors.white
//                                                     .withValues(alpha: 0.4),
//                                                 border: OutlineInputBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           4.0),
//                                                   // borderSide: BorderSide(color: const Color(0xFF512DA8)),
//                                                 ),
//                                                 counterText: '',
//                                               ),
//                                               textStyle: const TextStyle(
//                                                   fontSize: 18,
//                                                   fontWeight: FontWeight.bold),
//                                               // textFieldAlignment: MainAxisAlignment.spaceEvenly,
//                                               onCodeChanged: (String code) {
//                                                 otp = code;
//                                                 setState(() {});
//                                               },
//                                               onSubmit:
//                                                   (String verificationCode) {
//                                                 otp = verificationCode;
//                                                 bloc.add(
//                                                   LoginVerifyEvent(
//                                                     requestModel:
//                                                         prepareLoginRequestBody(
//                                                       userName: widget.userName,
//                                                       pwd: widget.pwd,
//                                                       otp: otp,
//                                                       deviceToken:
//                                                           widget.deviceToken,
//                                                       deviceType: Platform.isIOS
//                                                           ? '1'
//                                                           : (Platform.isAndroid
//                                                               ? '0'
//                                                               : '-1'),
//                                                     ),
//                                                     isFromLogin: false,
//                                                   ),
//                                                 );
//                                               },
//                                             ),
//
//                                                                   const SizedBox(height: 20),
//
//                                                                   // Resend link
//                                                                   InkWell(
//                                                                     onTap: () {
//                                                                       otp = '';
//                                                                       bloc.add(LoginVerifyEvent(
//                                                                         requestModel: prepareLoginRequestBody(
//                                                                           userName: widget.userName,
//                                                                           pwd: widget.pwd,
//                                                                           otp: '',
//                                                                         ),
//                                                                         isFromLogin: true,
//                                                                       ));
//                                                                     },
//                                                                     child: const Text(
//                                                                       'Resend OTP?',
//                                                                       style: Styles.textStyleWhite14,
//                                                                     ),
//                                                                   ),
//
//                                                                   const SizedBox(height: 30),
//
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             )),
//                       ),
//                     ),
//                     const SizedBox(height: 40),
//                     // Footer
//                     Positioned(
//                       bottom: 30,
//                       left: 0,
//                       right: 0,
//                       child: Column(
//                         children: [
//                           Text(
//                             Constants.copyrightText,
//                             style: Styles
//                                 .textStyleRegularGrey14
//                                 .copyWith(
//                                 color: Colors.white
//                                     .withValues(
//                                     alpha:
//                                     0.74)),
//                           ),
//                           Text(
//                             'Version: ${Platform.isIOS ? ConstantAppVersions.iOSVersion : ConstantAppVersions.androidVersion}',
//                             style: Styles
//                                 .textStyleRegularGrey14
//                                 .copyWith(
//                                 color: Colors.white
//                                     .withValues(
//                                     alpha:
//                                     0.74)),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   LoginRequestModel prepareLoginRequestBody({
//     required String userName,
//     required String pwd,
//     String? otp,
//     String? deviceToken,
//     String? deviceType,
//   }) {
//     return LoginRequestModel(
//         request: Request(
//       userName: userName,
//       password: pwd,
//       otp: otp,
//       deviceToken: deviceToken,
//       deviceType: deviceType,
//     ));
//   }
//
//   _showCustomPop(BuildContext context, String msg) {
//     var dialog = CustomAlertDialog(
//       title: Constants.appName,
//       message: msg,
//       onPositivePressed: () {
//         Navigator.of(context).pop();
//       },
//       positiveBtnText: Constants.ok,
//     );
//     showDialog(context: context, builder: (BuildContext context) => dialog);
//   }
//
//   Widget welcomeLogin() {
//     return Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(20.0),
//           child: Image.asset(
//             AppIcon.titleLogoLogin,
//             width: 200,
//             height: 70,
//           ),
//         ),
//         CommonWidgets.verticalSpacerWidget(
//             MediaQuery.of(context).size.height * 0.001),
//         Container(
//           alignment: Alignment.center,
//           child: Text(
//             Constants.otpVerificationTitle,
//             style: Styles.styleHeaderGreyText30,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'dart:developer';
import 'dart:io';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/login/services/login_services.dart';
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

  const OtpVerify({
    super.key,
    required this.userName,
    required this.pwd,
    required this.deviceToken,
  });

  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {

  static const _tabletBreakpoint = 600.0;
  static const _phoneCardWidthFactor = 0.92;
  static const _tabletCardWidthFactor = 0.6;
  static const _otpLength = 6;

  String otp = '';

  late Size _screenSize;
  late double _cardWidth;

  /// Returns [fraction] of the card's width.
  /// Used for fonts, icons, radii, paddings and field sizes.
  double _ofCardWidth(double fraction) => _cardWidth * fraction;

  /// Returns [fraction] of the screen's height. Used for vertical gaps.
  double _ofScreenHeight(double fraction) => _screenSize.height * fraction;

  String get _deviceType => Platform.isIOS ? '1' : (Platform.isAndroid ? '0' : '-1');

  void _onLoginState(BuildContext context, LoginState state) {
    if (state is LoginFailureState) {
      dismissLoadingDialog(context);
      log('-state.status-${state.status}---');
      if (state.status == FormStatus.permissionLocationError) return;
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
      dismissLoadingDialog(context);
      // TODO: May be need to clear navigation stack
      Navigator.pushNamed(context, resetPwdScreenRoute);
    } else if (state is LoginLoadingState) {
      showLoadingDialog(context);
    }
  }

  void _onOtpSubmit(LoginBloc bloc, String verificationCode) {
    otp = verificationCode;
    bloc.add(
      LoginVerifyEvent(
        requestModel: prepareLoginRequestBody(
          userName: widget.userName,
          pwd: widget.pwd,
          otp: otp,
          deviceToken: widget.deviceToken,
          deviceType: _deviceType,
        ),
        isFromLogin: false,
      ),
    );
  }

  void _onResendOtp(LoginBloc bloc) {
    otp = '';
    bloc.add(
      LoginVerifyEvent(
        requestModel: prepareLoginRequestBody(
          userName: widget.userName,
          pwd: widget.pwd,
          otp: '',
        ),
        isFromLogin: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    final isTablet = _screenSize.shortestSide >= _tabletBreakpoint;
    _cardWidth = _screenSize.shortestSide *
        (isTablet ? _tabletCardWidthFactor : _phoneCardWidthFactor);
    final bloc = BlocProvider.of<LoginBloc>(context);

    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFEEF1FD), Color(0xFFF8F9FE)],
                ),
              ),
            ),
          ),
          _buildBackgroundGlow(const Alignment(-1.2, -0.8), AppColors.lavenderGlowColor),
          _buildBackgroundGlow(const Alignment(1.3, -0.9), AppColors.peachGlowColor),
          SafeArea(
            child: BlocListener<LoginBloc, LoginState>(
              listener: _onLoginState,
              child: Stack(
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) => SingleChildScrollView(
                      keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                      child: ConstrainedBox(
                        constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: _ofScreenHeight(0.16),
                              bottom: _ofScreenHeight(0.12),
                            ),
                            child: SizedBox(
                              width: _cardWidth,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FractionallySizedBox(
                                    widthFactor: 0.6,
                                    child: Image.asset(
                                      'assets/images/GIG.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  SizedBox(height: _ofScreenHeight(0.03)),
                                  _buildCard(bloc),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: BackButton(
                      color: AppColors.navy,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: _buildFooter(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(LoginBloc bloc) {
    return Container(
      padding: EdgeInsets.all(_ofCardWidth(0.055)),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(_ofCardWidth(0.078)),
        boxShadow: [
          BoxShadow(
            color: AppColors.navy.withValues(alpha: 0.08),
            blurRadius: _ofCardWidth(0.11),
            offset: Offset(0, _ofCardWidth(0.045)),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: _ofScreenHeight(0.03)),
          _buildOtpField(bloc),
          SizedBox(height: _ofScreenHeight(0.02)),
          Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () => _onResendOtp(bloc),
              style: TextButton.styleFrom(foregroundColor: AppColors.navy),
              child: Text(
                'Resend OTP?',
                style: TextStyle(
                  fontSize: _ofCardWidth(0.042),
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.navy,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: _ofCardWidth(0.145),
          height: _ofCardWidth(0.145),
          decoration: BoxDecoration(
            color: AppColors.navy,
            borderRadius: BorderRadius.circular(_ofCardWidth(0.04)),
          ),
          child: Icon(
            Icons.verified_user_outlined,
            color: Colors.white,
            size: _ofCardWidth(0.06),
          ),
        ),
        SizedBox(width: _ofCardWidth(0.04)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'OTP Verification',
                style: TextStyle(
                  color: AppColors.navy,
                  fontSize: _ofCardWidth(0.061),
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: _ofScreenHeight(0.003)),
              Text(
                'Enter OTP sent to this user ${widget.userName}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.hintColor,
                  fontSize: _ofCardWidth(0.036),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOtpField(LoginBloc bloc) {
    final fieldGap = _ofCardWidth(0.02);
    final cardInnerWidth = _cardWidth - 2 * _ofCardWidth(0.055);
    final fieldWidth = cardInnerWidth / _otpLength - fieldGap;

    return OtpTextField(
      numberOfFields: _otpLength,
      showFieldAsBox: true,
      fieldWidth: fieldWidth,
      fieldHeight: fieldWidth * 1.15,
      margin: EdgeInsets.only(right: fieldGap),
      filled: true,
      fillColor: Colors.white,
      borderColor: AppColors.borderColor,
      enabledBorderColor: AppColors.borderColor,
      focusedBorderColor: AppColors.navy,
      borderWidth: 1.5,
      borderRadius: BorderRadius.circular(_ofCardWidth(0.035)),
      cursorColor: AppColors.navy,
      textStyle: TextStyle(
        color: AppColors.labelColor,
        fontSize: _ofCardWidth(0.055),
        fontWeight: FontWeight.w700,
      ),
      onCodeChanged: (String code) => setState(() => otp = code),
      onSubmit: (String verificationCode) =>
          _onOtpSubmit(bloc, verificationCode),
    );
  }

  Widget _buildFooter() {
    final footerStyle = TextStyle(
      color: AppColors.hintColor,
      fontSize: _ofCardWidth(0.036),
    );

    return Padding(
      padding: EdgeInsets.only(bottom: _ofScreenHeight(0.02)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(Constants.copyrightText, style: footerStyle),
          Text(
            'Version: ${Platform.isIOS ? ConstantAppVersions.iOSVersion : ConstantAppVersions.androidVersion}',
            style: footerStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundGlow(Alignment alignment, Color color) {
    final glowSize = _screenSize.shortestSide * 1.1;
    return Align(
      alignment: alignment,
      child: Container(
        width: glowSize,
        height: glowSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color.withValues(alpha: 0.7), color.withValues(alpha: 0)],
          ),
        ),
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
      ),
    );
  }

  _showCustomPop(BuildContext context, String msg) {
    var dialog = CustomAlertDialog(
      title: Constants.appName,
      message: msg,
      onPositivePressed: () {
        Navigator.of(context).pop();
      },
      positiveBtnText: Constants.ok,
    );
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }
}