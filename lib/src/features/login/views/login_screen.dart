// //
// // import 'dart:developer';
// // import 'dart:ui';
// //
// // import 'package:db_atom/index.dart';
// // import 'package:db_atom/src/features/login/services/login_services.dart';
// // import 'package:db_atom/src/utils/web_sso_msal_handler.dart';
// // import 'package:flutter_appauth/flutter_appauth.dart';
// // import 'package:msal_auth/msal_auth.dart';
// // import '../../../constants/constant_crashlytics_keys.dart';
// //
// // class LoginScreen extends StatelessWidget {
// //   const LoginScreen({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocProvider<LoginBloc>(
// //       create: (_) => LoginBloc(loginService: LoginService()),
// //       child: const Login(),
// //     );
// //   }
// // }
// //
// // class Login extends StatefulWidget {
// //   const Login({super.key});
// //
// //   @override
// //   State<Login> createState() => _LoginState();
// // }
// //
// // class _LoginState extends State<Login> {
// //   TextEditingController userNameTextController = TextEditingController();
// //   String username = '';
// //   String password = '';
// //   final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
// //   final FocusNode _usernameFocus = FocusNode();
// //   final FocusNode _passwordFocus = FocusNode();
// //   bool isPasswordVisible = false;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     log('-LoginScreen---initState--');
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final size = MediaQuery.of(context).size;
// //     // final height = size.height;
// //     final bloc = BlocProvider.of<LoginBloc>(context);
// //     return Scaffold(
// //       backgroundColor: AppColors.cardBgColor,
// //       body: BlocConsumer<LoginBloc, LoginState>(
// //         listener: (context, state) {
// //           Utils().formError(state, context);
// //           if (state is LoginFailureState) {
// //             dismissLoadingDialog(context);
// //             // if (state.status == FormStatus.permissionLocationError) {
// //             //   var dialog = CustomAlertDialog(
// //             //       title: 'Location Permission',
// //             //       message: state.message,
// //             //       onPositivePressed: () async {
// //             //         openAppSettings();
// //             //         Navigator.of(context).pop();
// //             //         setState(() {
// //             //           state.status == FormStatus.success;
// //             //         });
// //             //       },
// //             //       onNegativePressed: () {
// //             //         log('--onNegativePressed--');
// //             //       },
// //             //       positiveBtnText: Constants.settings,
// //             //       negativeBtnText: Constants.no);
// //             //   // showDialog(
// //             //   //     context: context, builder: (BuildContext context) => dialog);
// //             //   return;
// //             // }
// //
// //             var dialog = CustomAlertDialog(
// //               title: Constants.appName,
// //               message: state.message,
// //               onPositivePressed: () {
// //                 //Validator.logoutAction(context);
// //                 Navigator.of(context).pop();
// //               },
// //               positiveBtnText: Constants.ok,
// //               //negativeBtnText: Constants.no
// //             );
// //             showDialog(
// //                 context: context, builder: (BuildContext context) => dialog);
// //           } else if (state is LoginSuccessState) {
// //             dismissLoadingDialog(context);
// //             Navigator.pushNamed(context, otpVerificationRoute, arguments: {
// //               "userDetails": VerifyOTPArguments(
// //                   bloc.userName, bloc.password, bloc.deviceToken)
// //             });
// //           } else if (state is LoginLoadingState) {
// //             showLoadingDialog(context);
// //           } else if (state is LoginVerifyOtpActionState) {
// //             Navigator.pushNamedAndRemoveUntil(
// //               context,
// //               dashboardViewRoute,
// //               (route) => false,
// //             );
// //           }
// //         },
// //         builder: (context, state) {
// //           return BlocBuilder<LoginBloc, LoginState>(
// //             builder: (context, state) {
// //               if (state is LoginLoadingState) {
// //               } else if (state is LoginFailureState) {
// //               } else if (state is LoginSuccessState) {}
// //               return LayoutBuilder(builder: (context, constraints) {
// //                 // final height = constraints.maxHeight;
// //                 // final width = constraints.minHeight;
// //
// //                 // return Scaffold(
// //                 //  body:
// //                 return Stack(children: [
// //                   // Background Gradient + Wavy Image
// //                   SizedBox(
// //                     width: double.infinity,
// //                     height: double.infinity,
// //                     child: Image.asset(
// //                       'assets/images/login4.png',
// //                       fit: BoxFit.cover,
// //                       width: double.infinity,
// //                     ),
// //                   ),
// //                   Align(
// //                     alignment: Alignment.topCenter,
// //                     child: FractionallySizedBox(
// //                       widthFactor: 0.5, // responsive width
// //                       child: Padding(
// //                         padding: EdgeInsets.only(top: size.height * 0.09),
// //                         child: Image.asset(
// //                           'assets/images/GIG.png',
// //                           fit: BoxFit.contain,
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                   SafeArea(
// //                       child: Align(
// //                           // alignment: const Alignment(0, 0.1),
// //                           child: SingleChildScrollView(
// //                     physics: const BouncingScrollPhysics(),
// //                     // padding: EdgeInsets.only(
// //                     //   top: size.height * 0.10,
// //                     //   bottom: 100,
// //                     // ),
// //                     child: Column(
// //                       children: [
// //                         /// MAIN GLASS CARD
// //                         ClipRRect(
// //                           borderRadius: BorderRadius.circular(40),
// //                           child: BackdropFilter(
// //                             filter: ImageFilter.blur(
// //                               sigmaX: 60,
// //                               sigmaY: 60,
// //                             ),
// //                             child: Container(
// //                               width: size.width > 600
// //                                   ? size.width * 0.95
// //                                   : size.width * 0.95,
// //                               padding: const EdgeInsets.symmetric(
// //                                 horizontal: 22,
// //                                 vertical: 10,
// //                               ),
// //                               decoration: BoxDecoration(
// //                                 borderRadius: BorderRadius.circular(40),
// //                                 color: Colors.transparent,
// //                                 border: Border.all(
// //                                   color: Colors.white.withValues(alpha: 0.80),
// //                                 ),
// //                               ),
// //                               child: Form(
// //                                 key: loginFormKey,
// //                                 child: Column(
// //                                   children: [
// //                                     /// LOGIN TITLE
// //                                     Text(
// //                                       "Login",
// //                                       style: TextStyle(
// //                                         color: AppColors.newColor,
// //                                         fontSize: 34,
// //                                         fontWeight: FontWeight.w800,
// //                                       ),
// //                                     ),
// //
// //                                     const SizedBox(height: 10),
// //
// //                                     /// GLOW DIVIDER
// //                                     Row(
// //                                       children: [
// //                                         Expanded(
// //                                           child: Divider(
// //                                             color: Colors.white
// //                                                 .withValues(alpha: 0.25),
// //                                           ),
// //                                         ),
// //                                         Container(
// //                                           margin: const EdgeInsets.symmetric(
// //                                               horizontal: 10),
// //                                           height: 10,
// //                                           width: 10,
// //                                           decoration: BoxDecoration(
// //                                             shape: BoxShape.circle,
// //                                             color: Colors.white,
// //                                             boxShadow: [
// //                                               BoxShadow(
// //                                                 color: Colors.white
// //                                                     .withValues(alpha: 0.7),
// //                                                 blurRadius: 12,
// //                                               ),
// //                                             ],
// //                                           ),
// //                                         ),
// //                                         Expanded(
// //                                           child: Divider(
// //                                             color: Colors.white
// //                                                 .withValues(alpha: 0.25),
// //                                           ),
// //                                         ),
// //                                       ],
// //                                     ),
// //
// //                                     const SizedBox(height: 20),
// //
// //                                     /// USERNAME LABEL
// //                                     const Align(
// //                                       alignment: Alignment.centerLeft,
// //                                       child: Text(
// //                                         "Username",
// //                                         style: TextStyle(
// //                                           color: Colors.black87,
// //                                           fontWeight: FontWeight.w700,
// //                                           fontSize: 18,
// //                                         ),
// //                                       ),
// //                                     ),
// //
// //                                     const SizedBox(height: 10),
// //
// //                                     /// USERNAME FIELD
// //                                     Container(
// //                                       height: 62,
// //                                       decoration: BoxDecoration(
// //                                         borderRadius: BorderRadius.circular(32),
// //                                         color: Colors.black
// //                                             .withValues(alpha: 0.08),
// //                                         border: Border.all(
// //                                           color: Colors.white
// //                                               .withValues(alpha: 0.45),
// //                                         ),
// //                                       ),
// //                                       child: TextFormField(
// //                                         controller: userNameTextController,
// //                                         focusNode: _usernameFocus,
// //                                         style: const TextStyle(
// //                                           color: Colors.white,
// //                                         ),
// //                                         decoration: InputDecoration(
// //                                           border: InputBorder.none,
// //                                           hintText: "Enter username",
// //                                           hintStyle: TextStyle(
// //                                             color: Colors.white
// //                                                 .withValues(alpha: 0.65),
// //                                           ),
// //                                           prefixIcon: const Icon(
// //                                             Icons.person_outline_rounded,
// //                                             color: Colors.white,
// //                                           ),
// //                                           contentPadding:
// //                                               const EdgeInsets.symmetric(
// //                                                   vertical: 18),
// //                                         ),
// //                                         onChanged: (value) {
// //                                           username = value;
// //                                         },
// //                                       ),
// //                                     ),
// //
// //                                     const SizedBox(height: 22),
// //
// //                                     /// PASSWORD LABEL
// //                                     const Align(
// //                                       alignment: Alignment.centerLeft,
// //                                       child: Text(
// //                                         "Password",
// //                                         style: TextStyle(
// //                                           color: Colors.black87,
// //                                           fontWeight: FontWeight.w700,
// //                                           fontSize: 18,
// //                                         ),
// //                                       ),
// //                                     ),
// //
// //                                     const SizedBox(height: 10),
// //
// //                                     /// PASSWORD FIELD
// //                                     Container(
// //                                       height: 62,
// //                                       decoration: BoxDecoration(
// //                                         borderRadius: BorderRadius.circular(32),
// //                                         color: Colors.black
// //                                             .withValues(alpha: 0.08),
// //                                         border: Border.all(
// //                                           color: Colors.white
// //                                               .withValues(alpha: 0.45),
// //                                         ),
// //                                       ),
// //                                       child: TextFormField(
// //                                         obscureText: !isPasswordVisible,
// //                                         focusNode: _passwordFocus,
// //                                         style: const TextStyle(
// //                                           color: Colors.white,
// //                                         ),
// //                                         decoration: InputDecoration(
// //                                           border: InputBorder.none,
// //                                           hintText: "Enter password",
// //                                           hintStyle: TextStyle(
// //                                             color: Colors.white
// //                                                 .withValues(alpha: 0.65),
// //                                           ),
// //
// //                                           prefixIcon: const Icon(
// //                                             Icons.lock_outline_rounded,
// //                                             color: Colors.white,
// //                                           ),
// //
// //                                           /// SHOW / HIDE PASSWORD
// //                                           suffixIcon: IconButton(
// //                                             onPressed: () {
// //                                               setState(() {
// //                                                 isPasswordVisible =
// //                                                     !isPasswordVisible;
// //                                               });
// //                                             },
// //                                             icon: Icon(
// //                                               isPasswordVisible
// //                                                   ? Icons.visibility_rounded
// //                                                   : Icons
// //                                                       .visibility_off_outlined,
// //                                               color: Colors.white,
// //                                             ),
// //                                           ),
// //
// //                                           contentPadding:
// //                                               const EdgeInsets.symmetric(
// //                                             vertical: 18,
// //                                           ),
// //                                         ),
// //                                         onChanged: (value) {
// //                                           password = value;
// //                                         },
// //                                       ),
// //                                     ),
// //
// //                                     const SizedBox(height: 28),
// //
// //                                     /// LOGIN BUTTON
// //                                     Container(
// //                                       width: double.infinity,
// //                                       height: size.height > 600
// //                                           ? size.height * 0.06
// //                                           : size.height * 0.04,
// //                                       // height: 70 ,
// //                                       decoration: BoxDecoration(
// //                                         borderRadius: BorderRadius.circular(32),
// //
// //                                         gradient: LinearGradient(
// //                                           begin: Alignment.topLeft,
// //                                           end: Alignment.bottomRight,
// //                                           colors: [
// //                                             const Color(0xFF0A2A4E)
// //                                                 .withValues(alpha: 0.80),
// //                                             const Color(0xFF001F3F)
// //                                                 .withValues(alpha: 0.98),
// //                                           ],
// //                                         ),
// //
// //                                         border: Border.all(
// //                                           color: Colors.white
// //                                               .withValues(alpha: 0.70),
// //                                         ),
// //
// //                                         // boxShadow: [
// //                                         //   BoxShadow(
// //                                         //     color: const Color(
// //                                         //         0xFF0A2A4E)
// //                                         //         .withValues(
// //                                         //         alpha: 0.15),
// //                                         //     blurRadius: 30,
// //                                         //     offset:
// //                                         //     const Offset(
// //                                         //         0, 15),
// //                                         //   ),
// //                                         // ],
// //                                       ),
// //                                       child: ElevatedButton(
// //                                         style: ElevatedButton.styleFrom(
// //                                           backgroundColor: Colors.transparent,
// //                                           shadowColor: Colors.transparent,
// //                                           shape: RoundedRectangleBorder(
// //                                             borderRadius:
// //                                                 BorderRadius.circular(40),
// //                                           ),
// //                                         ),
// //                                         onPressed: () {
// //                                           _loginButtonAction(bloc);
// //                                         },
// //                                         child: const Text(
// //                                           "Login",
// //                                           style: TextStyle(
// //                                             color: Colors.white,
// //                                             fontSize: 20,
// //                                             fontWeight: FontWeight.w700,
// //                                           ),
// //                                         ),
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   )))
// //                 ]);
// //                 // );
// //               });
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }
// //
// //   final FlutterAppAuth appAuth = const FlutterAppAuth();
// //
// //   LoginRequestModel prepareLoginRequestBody(
// //       String userName, String pwd, String otp) {
// //     return LoginRequestModel(
// //         request: Request(
// //       userName: username.trim(),
// //       password: password.trim(),
// //       otp: otp,
// //     ));
// //   }
// //
// //   _loginButtonAction(LoginBloc bloc) {
// //     FocusScope.of(context).unfocus();
// //     try {
// //       if (loginFormKey.currentState!.validate()) {
// //         log('username $username password $password');
// //         bloc.add(LoginVerifyEvent(
// //           requestModel: prepareLoginRequestBody(username, password, ''),
// //           isFromLogin: true,
// //         ));
// //       }
// //     } catch (e) {
// //       // present userwith error message
// //     }
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
// //             Constants.loginButtonTitle,
// //             style: Styles.styleHeaderGreyText30,
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
// //
// // class VerifyOTPArguments {
// //   final String name;
// //   final String pwd;
// //   final String deviceToken;
// //
// //   VerifyOTPArguments(this.name, this.pwd, this.deviceToken);
// // }
//
// import 'dart:developer';
//
// import 'package:db_atom/index.dart';
// import 'package:db_atom/src/features/login/services/login_services.dart';
//
// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<LoginBloc>(
//       create: (_) => LoginBloc(loginService: LoginService()),
//       child: const Login(),
//     );
//   }
// }
//
// class Login extends StatefulWidget {
//   const Login({super.key});
//
//   @override
//   State<Login> createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//   static const _navy = Color(0xFF0B0B80);
//   static const _indigo = Color(0xFF4A3FA8);
//   static const _labelColor = Color(0xFF111827);
//   static const _hintColor = Color(0xFF6B7280);
//   static const _borderColor = Color(0xFFDCE1F5);
//   static const _maxCardWidth = 500.0;
//
//   final _formKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _isPasswordVisible = false;
//
//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   void _onLogin(LoginBloc bloc) {
//     FocusScope.of(context).unfocus();
//     if (!_formKey.currentState!.validate()) return;
//
//     log('Login requested');
//     bloc.add(
//       LoginVerifyEvent(
//         requestModel: LoginRequestModel(
//           request: Request(
//             userName: _usernameController.text.trim(),
//             password: _passwordController.text.trim(),
//             otp: '',
//           ),
//         ),
//         isFromLogin: true,
//       ),
//     );
//   }
//
//   void _onLoginState(BuildContext context, LoginState state) {
//     final bloc = context.read<LoginBloc>();
//     Utils().formError(state, context);
//
//     if (state is LoginLoadingState) {
//       showLoadingDialog(context);
//     } else if (state is LoginFailureState) {
//       dismissLoadingDialog(context);
//       showDialog(
//         context: context,
//         builder: (_) => CustomAlertDialog(
//           title: Constants.appName,
//           message: state.message,
//           positiveBtnText: Constants.ok,
//           onPositivePressed: () => Navigator.of(context).pop(),
//         ),
//       );
//     } else if (state is LoginSuccessState) {
//       dismissLoadingDialog(context);
//       Navigator.pushNamed(
//         context,
//         otpVerificationRoute,
//         arguments: {
//           'userDetails': VerifyOTPArguments(
//             bloc.userName,
//             bloc.password,
//             bloc.deviceToken,
//           ),
//         },
//       );
//     } else if (state is LoginVerifyOtpActionState) {
//       Navigator.pushNamedAndRemoveUntil(
//         context,
//         dashboardViewRoute,
//             (_) => false,
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final bloc = context.read<LoginBloc>();
//
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background
//           const Positioned.fill(
//             child: DecoratedBox(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [Color(0xFFEEF1FD), Color(0xFFF8F9FE)],
//                 ),
//               ),
//             ),
//           ),
//           _glow(const Alignment(-1.3, -0.8), const Color(0xFFCBD5F8)),
//           _glow(const Alignment(1.4, -0.8), const Color(0xFFFBDDBF)),
//
//           // Content
//           SafeArea(
//             child: BlocListener<LoginBloc, LoginState>(
//               listener: _onLoginState,
//               child: LayoutBuilder(
//                 builder: (context, constraints) => SingleChildScrollView(
//                   keyboardDismissBehavior:
//                   ScrollViewKeyboardDismissBehavior.onDrag,
//                   child: ConstrainedBox(
//                     constraints:
//                     BoxConstraints(minHeight: constraints.maxHeight),
//                     child: Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(0),
//                         child: ConstrainedBox(
//                           constraints:
//                           const BoxConstraints(maxWidth: _maxCardWidth),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               FractionallySizedBox(
//                                 widthFactor: 0.6,
//                                 child: Image.asset(
//                                   'assets/images/GIG.png',
//                                   fit: BoxFit.contain,
//                                 ),
//                               ),
//                               const SizedBox(height: 36),
//                               _buildCard(bloc),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCard(LoginBloc bloc) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white.withValues(alpha: 0.92),
//         borderRadius: BorderRadius.circular(28),
//         boxShadow: [
//           BoxShadow(
//             color: _navy.withValues(alpha: 0.08),
//             blurRadius: 40,
//             offset: const Offset(0, 16),
//           ),
//         ],
//       ),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildHeader(),
//             const SizedBox(height: 20),
//             _buildLabel('Username'),
//             TextFormField(
//               controller: _usernameController,
//               textInputAction: TextInputAction.next,
//               autofillHints: const [AutofillHints.username],
//               decoration: _inputDecoration(
//                 hint: 'Enter username',
//                 icon: Icons.person_outline_rounded,
//               ),
//               validator: (v) =>
//               (v ?? '').trim().isEmpty ? 'Please enter username' : null,
//             ),
//             const SizedBox(height: 16),
//             _buildLabel('Password'),
//             TextFormField(
//               controller: _passwordController,
//               obscureText: !_isPasswordVisible,
//               textInputAction: TextInputAction.done,
//               autofillHints: const [AutofillHints.password],
//               onFieldSubmitted: (_) => _onLogin(bloc),
//               decoration: _inputDecoration(
//                 hint: 'Enter password',
//                 icon: Icons.lock_outline_rounded,
//                 suffix: IconButton(
//                   onPressed: () => setState(
//                           () => _isPasswordVisible = !_isPasswordVisible),
//                   icon: Icon(
//                     _isPasswordVisible
//                         ? Icons.visibility_rounded
//                         : Icons.visibility_off_outlined,
//                     color: _hintColor,
//                   ),
//                 ),
//               ),
//               validator: (v) =>
//               (v ?? '').trim().isEmpty ? 'Please enter password' : null,
//             ),
//             const SizedBox(height: 25),
//             FilledButton(
//               onPressed: () => _onLogin(bloc),
//               style: FilledButton.styleFrom(
//                 backgroundColor: _navy,
//                 foregroundColor: Colors.white,
//                 minimumSize: const Size.fromHeight(56),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//               ),
//               child: const Text(
//                 'Sign in',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeader() {
//     return Row(
//       children: [
//         Container(
//           width: 52,
//           height: 52,
//           decoration: BoxDecoration(
//             color: _navy,
//             borderRadius: BorderRadius.circular(14),
//           ),
//           child: const Icon(Icons.shield_outlined,
//               color: Colors.white, size: 22),
//         ),
//         const SizedBox(width: 14),
//         const Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Welcome back',
//                 style: TextStyle(
//                   color: _navy,
//                   fontSize: 22,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//               SizedBox(height: 2),
//               Text(
//                 'Security Operations Portal',
//                 style: TextStyle(color: _hintColor, fontSize: 13),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildLabel(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: Text(
//         text,
//         style: const TextStyle(
//           color: _labelColor,
//           fontSize: 13,
//           fontWeight: FontWeight.w700,
//         ),
//       ),
//     );
//   }
//
//   InputDecoration _inputDecoration({
//     required String hint,
//     required IconData icon,
//     Widget? suffix,
//   }) {
//     OutlineInputBorder border(Color color, [double width = 1]) =>
//         OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16),
//           borderSide: BorderSide(color: color, width: width),
//         );
//
//     return InputDecoration(
//       hintText: hint,
//       hintStyle: const TextStyle(color: _hintColor, fontSize: 15),
//       prefixIcon: Icon(icon, color: _indigo, size: 20),
//       suffixIcon: suffix,
//       filled: true,
//       fillColor: Colors.white,
//       contentPadding: const EdgeInsets.symmetric(vertical: 18),
//       border: border(_borderColor),
//       enabledBorder: border(_borderColor),
//       focusedBorder: border(_navy, 1.5),
//       errorBorder: border(Colors.redAccent),
//       focusedErrorBorder: border(Colors.redAccent, 1.5),
//     );
//   }
//
//   Widget _glow(Alignment alignment, Color color) {
//     return Align(
//       alignment: alignment,
//       child: Container(
//         width: 990,
//         height: 990,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           gradient: RadialGradient(
//             colors: [color.withValues(alpha: 0.7), color.withValues(alpha: 0)],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class VerifyOTPArguments {
//   final String name;
//   final String pwd;
//   final String deviceToken;
//
//   VerifyOTPArguments(this.name, this.pwd, this.deviceToken);
// }

// import 'dart:developer';
//
// import 'package:db_atom/index.dart';
// import 'package:db_atom/src/features/login/services/login_services.dart';
//
// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<LoginBloc>(
//       create: (_) => LoginBloc(loginService: LoginService()),
//       child: const Login(),
//     );
//   }
// }
//
// class Login extends StatefulWidget {
//   const Login({super.key});
//
//   @override
//   State<Login> createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//   static const _navy = Color(0xFF0B0B80);
//   static const _indigo = Color(0xFF4A3FA8);
//   static const _labelColor = Color(0xFF111827);
//   static const _hintColor = Color(0xFF6B7280);
//   static const _borderColor = Color(0xFFDCE1F5);
//   static const _tabletBreakpoint = 600.0;
//
//   final _formKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _isPasswordVisible = false;
//
//   late Size _size;
//   late double _cardWidth;
//
//   /// Fraction of the card width (fonts, radii, icons, field/button sizes).
//   double width(double fraction) => _cardWidth * fraction;
//
//   /// Fraction of the screen height (vertical gaps).
//   double height(double fraction) => _size.height * fraction;
//
//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   void _onLogin(LoginBloc bloc) {
//     FocusScope.of(context).unfocus();
//     if (!_formKey.currentState!.validate()) return;
//
//     log('Login requested');
//     bloc.add(
//       LoginVerifyEvent(
//         requestModel: LoginRequestModel(
//           request: Request(
//             userName: _usernameController.text.trim(),
//             password: _passwordController.text.trim(),
//             otp: '',
//           ),
//         ),
//         isFromLogin: true,
//       ),
//     );
//   }
//
//   void _onLoginState(BuildContext context, LoginState state) {
//     final bloc = context.read<LoginBloc>();
//     Utils().formError(state, context);
//
//     if (state is LoginLoadingState) {
//       showLoadingDialog(context);
//     } else if (state is LoginFailureState) {
//       dismissLoadingDialog(context);
//       showDialog(
//         context: context,
//         builder: (_) => CustomAlertDialog(
//           title: Constants.appName,
//           message: state.message,
//           positiveBtnText: Constants.ok,
//           onPositivePressed: () => Navigator.of(context).pop(),
//         ),
//       );
//     } else if (state is LoginSuccessState) {
//       dismissLoadingDialog(context);
//       Navigator.pushNamed(
//         context,
//         otpVerificationRoute,
//         arguments: {
//           'userDetails': VerifyOTPArguments(
//             bloc.userName,
//             bloc.password,
//             bloc.deviceToken,
//           ),
//         },
//       );
//     } else if (state is LoginVerifyOtpActionState) {
//       Navigator.pushNamedAndRemoveUntil(
//         context,
//         dashboardViewRoute,
//             (_) => false,
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     _size = MediaQuery.of(context).size;
//     final isTablet = _size.shortestSide >= _tabletBreakpoint;
//     _cardWidth = _size.shortestSide * (isTablet ? 0.6 : 0.92);
//     final bloc = context.read<LoginBloc>();
//
//     return Scaffold(
//       body: Stack(
//         children: [
//           const Positioned.fill(
//             child: DecoratedBox(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [Color(0xFFEEF1FD), Color(0xFFF8F9FE)],
//                 ),
//               ),
//             ),
//           ),
//           _glow(const Alignment(-1.2, -0.8), const Color(0xFFCBD5F8)),
//           _glow(const Alignment(1.3, -0.1), const Color(0xFFFBDDBF)),
//           SafeArea(
//             child: BlocListener<LoginBloc, LoginState>(
//               listener: _onLoginState,
//               child: LayoutBuilder(
//                 builder: (context, constraints) => SingleChildScrollView(
//                   keyboardDismissBehavior:
//                   ScrollViewKeyboardDismissBehavior.onDrag,
//                   child: ConstrainedBox(
//                     constraints:
//                     BoxConstraints(minHeight: constraints.maxHeight),
//                     child: Center(
//                       child: SizedBox(
//                         width: _cardWidth,
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             FractionallySizedBox(
//                               widthFactor: 0.6,
//                               child: Image.asset(
//                                 'assets/images/GIG.png',
//                                 fit: BoxFit.contain,
//                               ),
//                             ),
//                             SizedBox(height: height(0.03)),
//                             _buildCard(bloc),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCard(LoginBloc bloc) {
//     return Container(
//       padding: EdgeInsets.all(width(0.055)),
//       decoration: BoxDecoration(
//         color: Colors.white.withValues(alpha: 0.92),
//         borderRadius: BorderRadius.circular(width(0.078)),
//         boxShadow: [
//           BoxShadow(
//             color: _navy.withValues(alpha: 0.08),
//             blurRadius: width(0.11),
//             offset: Offset(0, width(0.045)),
//           ),
//         ],
//       ),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildHeader(),
//             SizedBox(height: height(0.025)),
//             _buildLabel('Username'),
//             TextFormField(
//               controller: _usernameController,
//               textInputAction: TextInputAction.next,
//               autofillHints: const [AutofillHints.username],
//               style: TextStyle(fontSize: width(0.042)),
//               decoration: _inputDecoration(
//                 hint: 'Enter username',
//                 icon: Icons.person_outline_rounded,
//               ),
//               validator: (v) =>
//               (v ?? '').trim().isEmpty ? 'Please enter username' : null,
//             ),
//             SizedBox(height: height(0.02)),
//             _buildLabel('Password'),
//             TextFormField(
//               controller: _passwordController,
//               obscureText: !_isPasswordVisible,
//               textInputAction: TextInputAction.done,
//               autofillHints: const [AutofillHints.password],
//               onFieldSubmitted: (_) => _onLogin(bloc),
//               style: TextStyle(fontSize: width(0.042)),
//               decoration: _inputDecoration(
//                 hint: 'Enter password',
//                 icon: Icons.lock_outline_rounded,
//                 suffix: IconButton(
//                   onPressed: () => setState(
//                           () => _isPasswordVisible = !_isPasswordVisible),
//                   icon: Icon(
//                     _isPasswordVisible
//                         ? Icons.visibility_rounded
//                         : Icons.visibility_off_outlined,
//                     color: _hintColor,
//                     size: width(0.06),
//                   ),
//                 ),
//               ),
//               validator: (v) =>
//               (v ?? '').trim().isEmpty ? 'Please enter password' : null,
//             ),
//             // Align(
//             //   alignment: Alignment.centerRight,
//             //   child: TextButton(
//             //     onPressed: () {
//             //       // TODO: navigate to forgot password
//             //     },
//             //     style: TextButton.styleFrom(foregroundColor: _navy),
//             //     child: Text(
//             //       'Forgot password?',
//             //       style: TextStyle(
//             //         fontSize: _w(0.036),
//             //         fontWeight: FontWeight.w700,
//             //         decoration: TextDecoration.underline,
//             //         decorationColor: _navy,
//             //       ),
//             //     ),
//             //   ),
//             // ),
//             SizedBox(height: height(0.05)),
//             FilledButton(
//               onPressed: () => _onLogin(bloc),
//               style: FilledButton.styleFrom(
//                 backgroundColor: _navy,
//                 foregroundColor: Colors.white,
//                 minimumSize: Size.fromHeight(width(0.155)),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(width(0.045)),
//                 ),
//               ),
//               child: Text(
//                 'Sign in',
//                 style: TextStyle(
//                   fontSize: width(0.045),
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeader() {
//     return Row(
//       children: [
//         Container(
//           width: width(0.145),
//           height: width(0.145),
//           decoration: BoxDecoration(
//             color: _navy,
//             borderRadius: BorderRadius.circular(width(0.04)),
//           ),
//           child: Icon(
//             Icons.shield_outlined,
//             color: Colors.white,
//             size: width(0.06),
//           ),
//         ),
//         SizedBox(width: width(0.04)),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Welcome back',
//                 style: TextStyle(
//                   color: _navy,
//                   fontSize: width(0.061),
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//               SizedBox(height: height(0.003)),
//               Text(
//                 'Security Operations Portal',
//                 style: TextStyle(color: _hintColor, fontSize: width(0.036)),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildLabel(String text) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: height(0.01)),
//       child: Text(
//         text,
//         style: TextStyle(
//           color: _labelColor,
//           fontSize: width(0.036),
//           fontWeight: FontWeight.w700,
//         ),
//       ),
//     );
//   }
//
//   InputDecoration _inputDecoration({
//     required String hint,
//     required IconData icon,
//     Widget? suffix,
//   }) {
//     OutlineInputBorder border(Color color, [double width = 1]) =>
//         OutlineInputBorder(
//           borderRadius: BorderRadius.circular(width(0.045)),
//           borderSide: BorderSide(color: color, width: width),
//         );
//
//     return InputDecoration(
//       hintText: hint,
//       hintStyle: TextStyle(color: _hintColor, fontSize: width(0.042)),
//       prefixIcon: Icon(icon, color: _indigo, size: width(0.055)),
//       suffixIcon: suffix,
//       filled: true,
//       fillColor: Colors.white,
//       contentPadding: EdgeInsets.symmetric(vertical: width(0.05)),
//       border: border(_borderColor),
//       enabledBorder: border(_borderColor),
//       focusedBorder: border(_navy, 1.5),
//       errorBorder: border(Colors.redAccent),
//       focusedErrorBorder: border(Colors.redAccent, 1.5),
//     );
//   }
//
//   Widget _glow(Alignment alignment, Color color) {
//     final glowSize = _size.shortestSide * 1.1;
//     return Align(
//       alignment: alignment,
//       child: Container(
//         width: glowSize,
//         height: glowSize,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           gradient: RadialGradient(
//             colors: [color.withValues(alpha: 0.7), color.withValues(alpha: 0)],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class VerifyOTPArguments {
//   final String name;
//   final String pwd;
//   final String deviceToken;
//
//   VerifyOTPArguments(this.name, this.pwd, this.deviceToken);
// }

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
  static const _tabletBreakpoint = 600.0;
  static const _phoneCardWidthFactor = 0.92;
  static const _tabletCardWidthFactor = 0.6;
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  late Size _screenSize;
  late double _cardWidth;

  /// Used for fonts, icons, radii, paddings, field and button sizes,
  /// so everything inside the card scales together.
  double _ofCardWidth(double fraction) => _cardWidth * fraction;

  /// Used for vertical gaps between sections.
  double _ofScreenHeight(double fraction) => _screenSize.height * fraction;


  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin(LoginBloc bloc) {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    log('Login requested');
    bloc.add(
      LoginVerifyEvent(
        requestModel: LoginRequestModel(
          request: Request(
            userName: _usernameController.text.trim(),
            password: _passwordController.text.trim(),
            otp: '',
          ),
        ),
        isFromLogin: true,
      ),
    );
  }

  void _onLoginState(BuildContext context, LoginState state) {
    final bloc = context.read<LoginBloc>();
    Utils().formError(state, context);

    if (state is LoginLoadingState) {
      showLoadingDialog(context);
    } else if (state is LoginFailureState) {
      dismissLoadingDialog(context);
      showDialog(
        context: context,
        builder: (_) => CustomAlertDialog(
          title: Constants.appName,
          message: state.message,
          positiveBtnText: Constants.ok,
          onPositivePressed: () => Navigator.of(context).pop(),
        ),
      );
    } else if (state is LoginSuccessState) {
      dismissLoadingDialog(context);
      Navigator.pushNamed(
        context,
        otpVerificationRoute,
        arguments: {
          'userDetails': VerifyOTPArguments(
            bloc.userName,
            bloc.password,
            bloc.deviceToken,
          ),
        },
      );
    } else if (state is LoginVerifyOtpActionState) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        dashboardViewRoute,
            (_) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    final isTablet = _screenSize.shortestSide >= _tabletBreakpoint;
    _cardWidth = _screenSize.shortestSide *
        (isTablet ? _tabletCardWidthFactor : _phoneCardWidthFactor);
    final bloc = context.read<LoginBloc>();

    debugPrint('size=$_screenSize '
        'orientation=${MediaQuery.of(context).orientation}');
    log('Log1 ${_screenSize}');
    log('Log2 ${MediaQuery.of(context).orientation}');

    return Scaffold(
      body: Stack(
        children: [
          _buildBackgroundGlow(const Alignment(-1.2, -0.8), const Color(0xFFCBD5F8)),
          _buildBackgroundGlow(const Alignment(1.9, -0.9), const Color(0xFFFBDDBF)),
          SafeArea(
            child: BlocListener<LoginBloc, LoginState>(
              listener: _onLoginState,
              child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
                  child: ConstrainedBox(
                    constraints:
                    BoxConstraints(minHeight: constraints.maxHeight),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(top: _ofScreenHeight(0.1)),
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
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: _ofScreenHeight(0.025)),
            _buildLabel('Username'),
            TextFormField(
              controller: _usernameController,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.username],
              style: TextStyle(fontSize: _ofCardWidth(0.042)),
              decoration: _inputDecoration(
                hint: 'Enter username',
                icon: Icons.person_outline_rounded,
              ),
              validator: (v) =>
              (v ?? '').trim().isEmpty ? 'Please enter username' : null,
            ),
            SizedBox(height: _ofScreenHeight(0.02)),
            _buildLabel('Password'),
            TextFormField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.password],
              onFieldSubmitted: (_) => _onLogin(bloc),
              style: TextStyle(fontSize: _ofCardWidth(0.042)),
              decoration: _inputDecoration(
                hint: 'Enter password',
                icon: Icons.lock_outline_rounded,
                suffix: IconButton(
                  onPressed: () => setState(
                          () => _isPasswordVisible = !_isPasswordVisible),
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_outlined,
                    color: AppColors.hintColor,
                    size: _ofCardWidth(0.06),
                  ),
                ),
              ),
              validator: (v) =>
              (v ?? '').trim().isEmpty ? 'Please enter password' : null,
            ),
            SizedBox(height: _ofScreenHeight(0.05)),
            FilledButton(
              onPressed: () => _onLogin(bloc),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.navy,
                foregroundColor: Colors.white,
                minimumSize: Size.fromHeight(_ofCardWidth(0.155)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(_ofCardWidth(0.045)),
                ),
              ),
              child: Text(
                'Sign in',
                style: TextStyle(
                  fontSize: _ofCardWidth(0.045),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
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
            Icons.login,
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
                'Login',
                style: TextStyle(
                  color: AppColors.navy,
                  fontSize: _ofCardWidth(0.061),
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: _ofScreenHeight(0.003)),
              Text(
                'Security Operations Login',
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

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: _ofScreenHeight(0.01)),
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.labelColor,
          fontSize: _ofCardWidth(0.036),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    OutlineInputBorder border(Color color, [double borderWidth = 1]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(_ofCardWidth(0.045)),
          borderSide: BorderSide(color: color, width: borderWidth),
        );

    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: AppColors.hintColor, fontSize: _ofCardWidth(0.042)),
      prefixIcon: Icon(icon, color: AppColors.indigo, size: _ofCardWidth(0.055)),
      suffixIcon: suffix,
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(vertical: _ofCardWidth(0.05)),
      border: border(AppColors.borderColor),
      enabledBorder: border(AppColors.borderColor),
      focusedBorder: border(AppColors.navy, 1.5),
      errorBorder: border(Colors.redAccent),
      focusedErrorBorder: border(Colors.redAccent, 1.5),
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
}

class VerifyOTPArguments {
  final String name;
  final String pwd;
  final String deviceToken;

  VerifyOTPArguments(this.name, this.pwd, this.deviceToken);
}