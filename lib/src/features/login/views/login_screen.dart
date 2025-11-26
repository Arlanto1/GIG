import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/constants/constant_crashlytics_keys.dart';
import 'package:db_atom/src/features/login/services/login_services.dart';
import 'package:db_atom/src/utils/web_sso_msal_handler.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:msal_auth/msal_auth.dart';
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
            // if (state.status == FormStatus.permissionLocationError) {
            //   var dialog = CustomAlertDialog(
            //       title: 'Location Permission',
            //       message: state.message,
            //       onPositivePressed: () async {
            //         openAppSettings();
            //         Navigator.of(context).pop();
            //         setState(() {
            //           state.status == FormStatus.success;
            //         });
            //       },
            //       onNegativePressed: () {
            //         log('--onNegativePressed--');
            //       },
            //       positiveBtnText: Constants.settings,
            //       negativeBtnText: Constants.no);
            //   // showDialog(
            //   //     context: context, builder: (BuildContext context) => dialog);
            //   return;
            // }

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
          else if(state is LoginVerifyOtpActionState){
            Navigator.pushNamedAndRemoveUntil(
              context,
              dashboardViewRoute,
                  (route) => false,
            );
          }
        },
        builder: (context, state) {
          return BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is LoginLoadingState) {
              } else if (state is LoginFailureState) {
              } else if (state is LoginSuccessState) {}
              // return Scaffold(
              //   body:
              //   Stack(
              //     children: [
              //       Container(
              //         child: Image.asset(
              //           'assets/images/wavy-bg.png', // Replace with your asset
              //           width: size.width,
              //           fit: BoxFit.fitHeight,
              //         ),
              //         decoration: const BoxDecoration(
              //           gradient: LinearGradient(
              //             colors: [
              //               Color(0xFF845EF7), // Top purple
              //               Color(0xFF6A89CC), // Middle blue
              //               Color(0xFF7589E9), // Lighter
              //             ],
              //             begin: Alignment.topLeft,
              //             end: Alignment.bottomRight,
              //           ),
              //         ),
              //       ),
              //
              //       // Main card (Glassmorphism)
              //       Center(
              //         child: ClipRRect(
              //           borderRadius: BorderRadius.circular(30),
              //           child: BackdropFilter(
              //             filter: ImageFilter.blur(),
              //             child: Container(
              //               width: size.width * 0.9,
              //               padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 18),
              //               decoration: BoxDecoration(
              //                 color: Colors.white.withOpacity(0.19),
              //                 borderRadius: BorderRadius.circular(20),
              //                 boxShadow: [
              //                   BoxShadow(
              //                     color: Colors.black.withOpacity(0.07),
              //                     blurRadius: 16,
              //                     offset: const Offset(0, 4),
              //                   ),
              //                 ],
              //                 border: Border.all(color: Colors.white.withOpacity(0.25)),
              //               ),
              //               child: Column(
              //                 mainAxisSize: MainAxisSize.min,
              //                 children: [
              //                   // Header
              //                   const Text(
              //                     "Login",
              //                     style: TextStyle(
              //                       fontSize: 32,
              //                       fontFamily: 'Bungee', // Use decorative Google font
              //                       color: Color(0xFF5026bc),
              //                       fontWeight: FontWeight.w900,
              //                       letterSpacing: 2,
              //                     ),
              //                   ),
              //                   const SizedBox(height: 18),
              //                   // User Name
              //                   Column(
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       const Text(
              //                         "User Name",
              //                         style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
              //                       ),
              //                       const SizedBox(height: 7),
              //                       TextFormField(
              //                         decoration: const InputDecoration(
              //                           hintText: "demo@email.com",
              //                           prefixIcon: Icon(Icons.email_outlined, color: Color(0xFF5026bc)),
              //                           focusedBorder: UnderlineInputBorder(
              //                             borderSide: BorderSide(color: Color(0xFF5026bc), width: 2),
              //                           ),
              //                           enabledBorder: UnderlineInputBorder(
              //                             borderSide: BorderSide(color: Color(0xFF5026bc), width: 1.2),
              //                           ),
              //                         ),
              //                       ),
              //                            ],
              //                   ),
              //                   const SizedBox(height: 18),
              //                   // Password
              //                   Column(
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       const Text(
              //                         "Password",
              //                         style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
              //                       ),
              //                       const SizedBox(height: 7),
              //                       TextFormField(
              //                         obscureText: true,
              //                         decoration: const InputDecoration(
              //                           hintText: "enter your password",
              //                           prefixIcon: Icon(Icons.lock_outline, color: Color(0xFF5026bc)),
              //                           suffixIcon: Icon(Icons.visibility, color: Color(0xFF5026bc)),
              //                           focusedBorder: UnderlineInputBorder(
              //                             borderSide: BorderSide(color: Color(0xFF5026bc), width: 2),
              //                           ),
              //                           enabledBorder: UnderlineInputBorder(
              //                             borderSide: BorderSide(color: Color(0xFF5026bc), width: 1.2),
              //                           ),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                   const SizedBox(height: 20),
              //                   // Login button
              //                   SizedBox(
              //                     width: double.infinity,
              //                     child: ElevatedButton(
              //                       style: ElevatedButton.styleFrom(
              //                         backgroundColor: const Color(0xFF5026bc),
              //                         shape: RoundedRectangleBorder(
              //                           borderRadius: BorderRadius.circular(10),
              //                         ),
              //                         padding: const EdgeInsets.symmetric(vertical: 14),
              //                       ),
              //                       onPressed: () {
              //
              //                       },
              //                       child: const Text(
              //                         'Login',
              //                         style: TextStyle(
              //                           fontSize: 16,
              //                           fontWeight: FontWeight.w700,
              //                           letterSpacing: 1,
              //                           color: Colors.white,
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //       // OR and SSO button
              //       Positioned(
              //         top: size.height * 0.705,
              //         left: 0,
              //         right: 0,
              //         child: Column(
              //           children: [
              //             const Text(
              //               "OR",
              //               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              //             ),
              //             const SizedBox(height: 2),
              //             Container(
              //               width: size.width * 0.9,
              //               padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              //               decoration: BoxDecoration(
              //                 color: Colors.white.withOpacity(0.19),
              //                 borderRadius: BorderRadius.circular(20),
              //                 boxShadow: [
              //                   BoxShadow(
              //                     color: Colors.black.withOpacity(0.07),
              //                     blurRadius: 16,
              //                     offset: const Offset(0, 4),
              //                   ),
              //                 ],
              //                 border: Border.all(color: Colors.white.withOpacity(0.25)),
              //               ),
              //               child: const Text(
              //                   'Login with DB SSO',
              //                   textAlign: TextAlign.center,
              //                   style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15)
              //               ) ,
              //             )
              //           ],
              //         ),
              //       ),
              //       // Copyright
              //       Positioned(
              //         bottom: 50,
              //         left: 0,
              //         right: 0,
              //         child: Center(
              //           child: Text(
              //             'Copyright © 2023 RimaOne',
              //             style: TextStyle(
              //               color: Colors.white.withOpacity(0.74),
              //               fontSize: 14,
              //               fontFamily: 'Quicksand',
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // );

              return LayoutBuilder(
                builder: (context, constraints) {
                  final height = constraints.maxHeight;
                  final width = constraints.minHeight;

                  return Scaffold(
                    body: Stack(
                      children: [
                        // Background Gradient + Wavy Image
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          // decoration: const BoxDecoration(
                          //   gradient: LinearGradient(
                          //     colors: [
                          //       // const Color(0xFF1E40AF),
                          //       // const Color(0xFF2563EB),
                          //       Colors.white,
                          //       const Color(0xFF6366F1),
                          //       Colors.black45,
                          //       const Color(0xFF4B67F2),
                          //       Colors.black45,
                          //       const Color(0xFF3B82F6),
                          //       Colors.white,
                          //       // Color(0xFF845EF7),
                          //       // Color(0xFF6A89CC),
                          //       // Color(0xFF7589E9),
                          //     ],
                          //     begin: Alignment.topLeft,
                          //     end: Alignment.bottomRight,
                          //   ),
                          // ),
                          child: Image.asset(
                            'assets/images/login4.png',
                            fit: BoxFit.fitHeight,
                            width: double.infinity,
                          ),
                        ),
                        // Centered Glassmorphic Card with Blur
                        // Logo or heading text
                        // Positioned(
                        //   top: size.height * 0.11,
                        //   // adjust this value to move up/down
                        //   left: 0,
                        //   right: 0,
                        //   child: Column(
                        //     children: [
                        //       Image.asset(
                        //         'assets/images/logo1.png', // your logo asset
                        //         height: 100,
                        //       ),
                        //       // const SizedBox(height: 2),
                        //       // Text(
                        //       //   "ATOM",
                        //       //   style: TextStyle(
                        //       //     fontSize: 48, // slightly bigger for impact
                        //       //     color: Colors.white,
                        //       //     fontWeight: FontWeight.w900, // extra bold
                        //       //     letterSpacing: 1.5,
                        //       //     shadows: [
                        //       //       Shadow(
                        //       //         color: Colors.black38, // subtle shadow for depth
                        //       //         offset: Offset(2, 2),
                        //       //         blurRadius: 4,
                        //       //       ),
                        //       //       Shadow(
                        //       //         color: Colors.white24, // subtle light glow
                        //       //         offset: Offset(-1, -1),
                        //       //         blurRadius: 6,
                        //       //       ),
                        //       //     ],
                        //       //   ),
                        //       //  )
                        //     ],
                        //   ),
                        // ),

                        Align(
                          alignment: Alignment.topCenter,
                          child: FractionallySizedBox(
                            widthFactor: 0.6,   // responsive width
                            child: Padding(
                              padding: EdgeInsets.only(top: size.height * 0.1),
                              child: Image.asset(
                                'assets/images/logo1.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                              child: Container(
                                width: size.width * 0.9,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 32, horizontal: 18),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.20),
                                  borderRadius: BorderRadius.circular(40),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white10.withValues(
                                          alpha: 0.1),
                                      blurRadius: 16,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                  border: Border.all(
                                      color: Colors.white.withValues(
                                          alpha: 0.3)),
                                ),
                                child: SingleChildScrollView(
                                  child: Form(
                                    key: loginFormKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      children: [
                                        // Title text like "Login" or your welcomeLogin()
                                        const Text(
                                          'Login',
                                          style: TextStyle(
                                            fontSize: 32,
                                            fontFamily: 'Bungee',
                                            // Use your decorative font if any
                                            color: Color(0xFF0000CC),
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: 2,
                                          ),
                                        ),
                                        const SizedBox(height: 18),

                                        // Username Label & TextField
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            Constants.username,
                                            style: Styles.textStyleGrey16
                                                .copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17),
                                          ),
                                        ),
                                        const SizedBox(height: 7),
                                        FlutterInputField(
                                          isLoginScreen: true,
                                          showCounter: false,
                                          controller: userNameTextController,
                                          textFormKey: Keys.userTextField,
                                          textCapitalization: false,
                                          hintText: Constants.hintUserName,
                                          textInputAction: TextInputAction.next,
                                          focusNode: _usernameFocus,
                                          textInputType: TextInputType.text,

                                          onFieldSubmitted: (term) {
                                            _usernameFocus.unfocus();
                                            FocusScope.of(context).requestFocus(
                                                _passwordFocus);
                                          },
                                          onChange: (String username) {
                                            this.username = username;
                                            setState(() {});
                                          },
                                          validateTextField: (String? user) {
                                            if (!Validator.isValidUserName(
                                                user)) {
                                              return Constants.userError;
                                            }
                                            return null;
                                          },
                                          prefixWidget: SvgPicture.asset(
                                            AppIcon.userIcon,
                                            colorFilter: const ColorFilter.mode(
                                                AppColors.textColor,
                                                BlendMode.srcIn),
                                            width: 20,
                                            key: const Key(Keys.userIcon),
                                          ),
                                          // decoration: const InputDecoration(
                                          //   focusedBorder: UnderlineInputBorder(
                                          //     borderSide: BorderSide(color: Color(0xFF5026bc), width: 2),
                                          //   ),
                                          //   enabledBorder: UnderlineInputBorder(
                                          //     borderSide: BorderSide(color: Color(0xFF5026bc), width: 1.2),
                                          //   ),
                                          // ),
                                        ),
                                        const SizedBox(height: 18),

                                        // Password Label & PasswordField
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            Constants.password,
                                            style: Styles.textStyleGrey16
                                                .copyWith(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 18),
                                          ),
                                        ),
                                        const SizedBox(height: 7),
                                        PasswordField(
                                          hintText: '',
                                          passFocusNode: _passwordFocus,
                                          textInputAction: TextInputAction.done,
                                          validatePassword: (String? password) {
                                            if (!Validator.isValidPassword(
                                                password)) {
                                              return 'Password does not meet the criteria.';
                                            } else
                                            if (!Validator.passwordValidation(
                                                password)) {
                                              return 'Password must be at least 8 characters long.';
                                            }
                                            return null;
                                          },
                                          onFieldSubmitted: (term) {
                                            _passwordFocus.unfocus();
                                            _loginButtonAction(bloc);
                                          },
                                          onChange: (String password) {
                                            this.password = password;
                                          },
                                          // decoration: const InputDecoration(
                                          //   prefixIcon: Icon(Icons.lock_outline, color: Color(0xFF5026bc)),
                                          //   suffixIcon: Icon(Icons.visibility, color: Color(0xFF5026bc)),
                                          //   focusedBorder: UnderlineInputBorder(
                                          //     borderSide: BorderSide(color: Color(0xFF5026bc), width: 2),
                                          //   ),
                                          //   enabledBorder: UnderlineInputBorder(
                                          //     borderSide: BorderSide(color: Color(0xFF5026bc), width: 1.2),
                                          //   ),
                                          // ),
                                        ),
                                        const SizedBox(height: 20),

                                        // Login Button styled as in the sample
                                        SizedBox(
                                          width: double.infinity,
                                          child: AppButton(
                                            key: const Key(Keys.loginButton),
                                            buttonText: Constants
                                                .loginButtonTitle,
                                            buttonTextKey: Keys.loginButtonText,
                                            onTap: () async =>
                                                _loginButtonAction(bloc),
                                            // buttonStyle: ElevatedButton.styleFrom(
                                            //   backgroundColor: const Color(0xFF5026bc),
                                            //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                            //   padding: const EdgeInsets.symmetric(vertical: 14),
                                            // ),
                                            // buttonTextStyle: const TextStyle(
                                            //   fontSize: 16,
                                            //   fontWeight: FontWeight.w700,
                                            //   letterSpacing: 1,
                                            //   color: Colors.white,
                                            // ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // ),
                            ),
                          ),),

                        // Positioned OR + SSO block
                        Positioned(
                          top: size.height * 0.730,
                          left: 0,
                          right: 0,
                          child: Column(
                            children: [
                              const Text(
                                "OR",
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: MediaQuery.of(context).size.width* 0.9,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 30, horizontal: 30),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.30),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withValues(
                                          alpha: 0.07),
                                      blurRadius: 16,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                  border: Border.all(
                                      color: Colors.white.withValues(
                                          alpha: 0.25)),
                                ),
                                // Replace ElevatedButton with InkWell or GestureDetector for tap handling
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () async {
                                    try {
                                      final MsalUser? user = await WebSsoMsalHandler()
                                          .getToken(context);
                                      if (user != null) {
                                        bloc.add(LoginSsoVerifyEvent(
                                            user: user, isFromLogin: false));
                                        if (state is LoginVerifyOtpActionState) {
                                          dismissLoadingDialog(context);
                                          await Future.delayed(
                                              const Duration(milliseconds: 20));
                                          Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            dashboardViewRoute,
                                                (route) => false,
                                          );
                                        }
                                      }
                                    } on MsalException catch (e) {
                                      log('MSAL error: ${e.errorMessage}');
                                    } catch (e) {
                                      log('General error: ${e.toString()}');
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                          AppIcon.deutscheBankLogo, height: 20),
                                      CommonWidgets.horizontalSpacerWidget(
                                          height * 0.01),
                                      const Text(
                                        Constants.dbSSO,
                                        style: TextStyle(
                                            color: Color(0xFF000080),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Positioned Copyright and Version
                        Positioned(
                          bottom: 30,
                          left: 0,
                          right: 0,
                          child: Column(
                            children: [
                              Text(
                                Constants.copyrightText,
                                style: Styles.textStyleRegularGrey14.copyWith(
                                    color: Colors.white.withValues(
                                        alpha: 0.74)),
                              ),
                              Text(
                                'Version: ${Platform.isIOS ? ConstantAppVersions
                                    .iOSVersion : ConstantAppVersions
                                    .androidVersion}',
                                style: Styles.textStyleRegularGrey14.copyWith(
                                    color: Colors.white.withValues(
                                        alpha: 0.74)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });


              // return Container(
              //   color: AppColors.navigationSkyBlueColor,
              //   child: SingleChildScrollView(
              //     child: Column(
              //       children: [
              //         Container(
              //           height: height * 0.09,
              //           color: AppColors.navigationSkyBlueColor,
              //         ),
              //         Container(
              //           padding: const EdgeInsets.all(20.0),
              //           // decoration: const BoxDecoration(
              //           //   image: DecorationImage(
              //           //     image: AssetImage('assets/images/ai.png'),
              //           //     opacity: 0/,
              //           //     fit: BoxFit.cover, // Makes it fill the entire background
              //           //   ),
              //           // ),
              //           decoration:
              //           const ShapeDecoration(
              //               color: AppColors.backgroundWhiteColor,
              //               shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.vertical(
              //                     top: Radius.circular(20.0)),
              //               )),
              //
              //           // color: Colors.white,
              //           child: Form(
              //             key: loginFormKey,
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.center,
              //               mainAxisSize: MainAxisSize.max,
              //               mainAxisAlignment: MainAxisAlignment.end,
              //               children: [
              //                 // Login welcome text and image
              //                 welcomeLogin(),
              //
              //                 CommonWidgets.verticalSpacerWidget(height * 0.03),
              //
              //                 /// Username
              //                 Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   //mainAxisAlignment: MainAxisAlignment.end,
              //                   children: [
              //                     Container(
              //                       alignment: Alignment.topLeft,
              //                       child: const Text(
              //                         Constants.username,
              //                         style: Styles.textStyleBlack16,
              //                       ),
              //                     ),
              //                     CommonWidgets.verticalSpacerWidget(
              //                         height * 0.001),
              //                     FlutterInputField(
              //                       controller: userNameTextController,
              //                       textFormKey: Keys.userTextField,
              //                       textCapitalization: false,
              //                       hintText: Constants.hintUserName,
              //                       textInputAction: TextInputAction.next,
              //                       focusNode: _usernameFocus,
              //                       textInputType: TextInputType.text,
              //                       onFieldSubmitted: (term) {
              //                         _usernameFocus.unfocus();
              //                         FocusScope.of(context)
              //                             .requestFocus(_passwordFocus);
              //                       },
              //                       onChange: (String username) {
              //                         this.username = username;
              //                         setState(() {});
              //                       },
              //                       validateTextField: (String? user) {
              //                         if (!Validator.isValidUserName(user)) {
              //                           return Constants.userError;
              //                         }
              //                       },
              //                       prefixWidget: SvgPicture.asset(
              //                         AppIcon.userIcon,
              //                         colorFilter: const ColorFilter.mode(
              //                           AppColors.textColor,
              //                           BlendMode.srcIn,
              //                         ),
              //                         // color: AppColors.textColor,
              //                         width: 20,
              //                         key: const Key(Keys.userIcon),
              //                       ),
              //                     ),
              //
              //                     CommonWidgets.verticalSpacerWidget(
              //                         height * 0.02),
              //
              //                     /// Password
              //                     Column(
              //                       children: [
              //                         Container(
              //                           alignment: Alignment.topLeft,
              //                           child: const Text(
              //                             Constants.password,
              //                             style: Styles.textStyleBlack16,
              //                           ),
              //                         ),
              //                         CommonWidgets.verticalSpacerWidget(
              //                             height * 0.001),
              //                         PasswordField(
              //                           hintText: '',
              //                           passFocusNode: _passwordFocus,
              //                           textInputAction: TextInputAction.done,
              //                           validatePassword: (String? password) {
              //                             if (!Validator.isValidPassword(
              //                                 password)) {
              //                               return 'Password does not meet the criteria.';
              //                             } else if (!Validator
              //                                 .passwordValidation(password)) {
              //                               return 'Password must be at least 8 characters long.';
              //                             }
              //                             return null;
              //                           },
              //                           onFieldSubmitted: (term) {
              //                             _passwordFocus.unfocus();
              //                             _loginButtonAction(bloc);
              //                           },
              //                           onChange: (String password) {
              //                             this.password = password;
              //                           },
              //                         ),
              //                       ],
              //                     ),
              //
              //                     CommonWidgets.verticalSpacerWidget(
              //                         height * 0.03),
              //
              //                     // Login button
              //                     AppButton(
              //                       key: const Key(Keys.loginButton),
              //                       buttonText: Constants.loginButtonTitle,
              //                       buttonTextKey: Keys.loginButtonText,
              //                       onTap: () async {
              //                         //loginFormKey.currentState!.validate();
              //                         _loginButtonAction(bloc);
              //                       },
              //                     ),
              //
              //                     CommonWidgets.verticalSpacerWidget(
              //                       height * 0.03,
              //                     ),
              //                   ],
              //                 ),
              //
              //                 const Center(
              //                   child: Text(
              //                     'OR',
              //                     style: TextStyle(fontWeight: FontWeight.bold),
              //                   ),
              //                 ),
              //                 CommonWidgets.verticalSpacerWidget(
              //                   height * 0.03,
              //                 ),
              //
              //                 /// DB SSO
              //                 ElevatedButton(
              //                   onPressed: () async {
              //                     try {
              //                       final MsalUser? user =
              //                           await WebSsoMsalHandler().getToken(context);
              //                       log('-user-${user?.accessToken}-');
              //
              //                       UtilsCommon().logCustomEvent(
              //                         msg: 'Login via SSO',
              //                         customKey: loginSso,
              //                       );
              //
              //                       if (user != null) {
              //                         UtilsCommon().logCustomEvent(
              //                           msg: user.accessToken,
              //                           customKey: loginSso,
              //                         );
              //                         bloc.add(LoginSsoVerifyEvent(
              //                           user: user,
              //                             isFromLogin:false
              //                         )
              //                         );
              //                         log('state1 ${state is LoginVerifyOtpActionState}');
              //                         if(state is LoginVerifyOtpActionState) {                         dismissLoadingDialog(context);
              //                         // Add a short delay to ensure the dialog is fully dismissed
              //                         await Future.delayed(const Duration(milliseconds: 20));
              //                           Navigator.pushNamedAndRemoveUntil(
              //                             context,
              //                             dashboardViewRoute,
              //                                 (route) => false,
              //                           );
              //                           }
              //                       }
              //                     } on MsalException catch (e) {
              //                       log('MSAL error: ${e.errorMessage}');
              //                       UtilsCommon().logCustomEvent(
              //                         msg: 'MSAL Error: ${e.errorMessage}',
              //                         customKey: loginSsoError,
              //                       );
              //                       // Handle MSAL-specific errors
              //                     } catch (e) {
              //                       log('General error: ${e.toString()}');
              //                       UtilsCommon().logCustomEvent(
              //                         msg: 'General Error: ${e.toString()}',
              //                         customKey: loginSsoError,
              //                       );
              //                       // Handle any other exceptions
              //                     }
              //                   },
              //                   style: ElevatedButton.styleFrom(
              //                     backgroundColor: Colors
              //                         .white, // Set the background color to white
              //                   ),
              //                   child: Row(
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     children: [
              //                       Image.asset(
              //                         AppIcon.deutscheBankLogo,
              //                         fit: BoxFit.cover,
              //                         height: 20,
              //                         // color:
              //                         //     AppColors.navigationSkyBlueColor,
              //                       ),
              //                       CommonWidgets.horizontalSpacerWidget(
              //                         height * 0.01,
              //                       ),
              //                       const Text(
              //                         Constants.dbSSO,
              //                         style: TextStyle(
              //                           color: Color(0xFF000080),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //                 CommonWidgets.verticalSpacerWidget(
              //                   height * 0.03,
              //                 ),
              //                 // AppButton(
              //                 //   // key: const Key(Keys.loginButton),
              //                 //   buttonText: Constants.dbSSO,
              //                 //   buttonTextKey: Keys.loginButtonText,
              //                 //   onTap: () async {
              //                 //     //loginFormKey.currentState!.validate();
              //                 //     // _loginButtonAction(bloc);
              //                 //     _authenticate();
              //                 //   },
              //                 // ),
              //
              //                 // Forgot password
              //                 ForgotPassword(
              //                   onForgottenPassword: () => {
              //                     //widget.onPasswordForgotten()
              //                     Navigator.pushNamed(
              //                       context,
              //                       forgotPwdScreenRoute,
              //                     )
              //                   },
              //                   title: Constants.resetPwdTitle,
              //                 ),
              //
              //                 CommonWidgets.verticalSpacerWidget(
              //                   height * 0.18,
              //                 ),
              //
              //                 /// Support Number
              //                 Column(
              //                   crossAxisAlignment: CrossAxisAlignment.center,
              //                   mainAxisAlignment: MainAxisAlignment.end,
              //                   children: [
              //                     // Center(
              //                     //   child: Row(
              //                     //     mainAxisAlignment:
              //                     //         MainAxisAlignment.center,
              //                     //     children: [
              //                     //       const Text(
              //                     //         Constants.support,
              //                     //         style: Styles.textStyleBlack16,
              //                     //       ),
              //                     //       IconButton(
              //                     //         onPressed: () {
              //                     //           // do action on view
              //                     //         },
              //                     //         icon: SvgPicture.asset(AppIcon.email),
              //                     //       ),
              //                     //       const Text(
              //                     //         Constants.supportContact,
              //                     //         style: Styles.textStyleBlack16,
              //                     //       ),
              //                     //     ],
              //                     //   ),
              //                     // ),
              //                     // CommonWidgets.verticalSpacerWidget(
              //                     //   height * 0.003,
              //                     // ),
              //
              //                     const Center(
              //                       child: Text(
              //                         Constants.copyrightText,
              //                         style: Styles.textStyleRegularGrey14,
              //                       ),
              //                     ),
              //
              //                     Center(
              //                       child: Text(
              //                         'Version: ${Platform.isIOS ? ConstantAppVersions.iOSVersion : ConstantAppVersions.androidVersion}',
              //                         style: Styles.textStyleRegularGrey14,
              //                       ),
              //                     ),
              //                   ],
              //                 )
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

  final FlutterAppAuth appAuth = const FlutterAppAuth();

//   String clientId = 'interactive.public';
// // String redirectUrl = 'https://demo.duendesoftware.com/connect/authorize';
//   String redirectUrl = 'urn:ietf:wg:oauth:2.0:oob';
//   String issuer = 'https://demo.duendesoftware.com';
//   String secret = 'secret';
//   String discoveryUrl = 'https://demo.duendesoftware.com/connect/authorize';

  // final String tenantId = 'f18ecf29-68a6-4697-92fa-0ce29009c210';
  // final String clientId = '4f133b63-2fc9-4770-ad4a-20b6e69ec1ce';
  // // final String redirectUrl =
  // //     'https://login.microsoftonline.com/common/oauth2/nativeclient';
  // final String redirectUrl =
  //     'msauth.com.arlanto.atomedge://auth';

  // final String clientSecret = 'Ly68Q~9VVXRHWeuO7EUWZSDJeH_x-ledldKl4bZ2';
  // final String authority = 'https://login.microsoftonline.com/';
  // final String resource = 'DB-ATOM';
  // final String issuer =
  //     'https://login.microsoftonline.com/f18ecf29-68a6-4697-92fa-0ce29009c210';
  //
  // final String re = 'com.yourapp:/oauthredirect';
  //
  // Future<void> _authenticate() async {
  //   final AuthorizationTokenResponse? result =
  //       await appAuth.authorizeAndExchangeCode(
  //     AuthorizationTokenRequest(
  //       clientId,
  //       redirectUrl,
  //       issuer: issuer,
  //       // clientSecret: secret,
  //       // discoveryUrl: issuer,
  //       scopes: ['openid', 'profile', 'email', 'offline_access', 'api'],
  //     ),
  //   );
  //
  //   setState(() {
  //     log('---${result?.accessToken}---');
  //     // _accessToken = result?.accessToken;
  //     // _idToken = result?.idToken;
  //   });
  // }

  LoginRequestModel prepareLoginRequestBody(
      String userName, String pwd, String otp) {
    return LoginRequestModel(
        request: Request(
      userName: username.trim(),
      password: password.trim(),
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

        // bloc.add(LoginSsoVerifyEvent(
        //   user: MsalUser(
        //     username: 'test@db.com',
        //     displayName: 'testuser',
        //     accessToken: '654asdf576878asdf75jkbm,ansjkdfasd',
        //     tokenCreatedAt: 123435,
        //     tokenExpiresOn: 12345234,
        //   ),
        // ));
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


// import 'dart:ui';
// import 'package:db_atom/index.dart';
// import 'package:flutter/material.dart';
//
// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Stack(
//         children: [
//       Container(
//          child: Image.asset(
//             'assets/images/wavy-bg.png', // Replace with your asset
//             width: size.width,
//             fit: BoxFit.fitHeight,
//           ),
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFF845EF7), // Top purple
//               Color(0xFF6A89CC), // Middle blue
//               Color(0xFF7589E9), // Lighter
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//       ),
//
//           // Main card (Glassmorphism)
//           Center(
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(30),
//               child: BackdropFilter(
//                 filter: ImageFilter.blur(),
//                 child: Container(
//                   width: size.width * 0.9,
//                   padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 18),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.19),
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.07),
//                         blurRadius: 16,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                     border: Border.all(color: Colors.white.withOpacity(0.25)),
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       // Header
//                       const Text(
//                         "Login",
//                         style: TextStyle(
//                           fontSize: 32,
//                           fontFamily: 'Bungee', // Use decorative Google font
//                           color: Color(0xFF5026bc),
//                           fontWeight: FontWeight.w900,
//                           letterSpacing: 2,
//                         ),
//                       ),
//                       const SizedBox(height: 18),
//                       // Email
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             "Email",
//                             style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
//                           ),
//                           const SizedBox(height: 7),
//                           TextFormField(
//                             decoration: const InputDecoration(
//                               hintText: "demo@email.com",
//                               prefixIcon: Icon(Icons.email_outlined, color: Color(0xFF5026bc)),
//                               focusedBorder: UnderlineInputBorder(
//                                 borderSide: BorderSide(color: Color(0xFF5026bc), width: 2),
//                               ),
//                               enabledBorder: UnderlineInputBorder(
//                                 borderSide: BorderSide(color: Color(0xFF5026bc), width: 1.2),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 18),
//                       // Password
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             "Password",
//                             style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
//                           ),
//                           const SizedBox(height: 7),
//                           TextFormField(
//                             obscureText: true,
//                             decoration: const InputDecoration(
//                               hintText: "enter your password",
//                               prefixIcon: Icon(Icons.lock_outline, color: Color(0xFF5026bc)),
//                               suffixIcon: Icon(Icons.visibility, color: Color(0xFF5026bc)),
//                               focusedBorder: UnderlineInputBorder(
//                                 borderSide: BorderSide(color: Color(0xFF5026bc), width: 2),
//                               ),
//                               enabledBorder: UnderlineInputBorder(
//                                 borderSide: BorderSide(color: Color(0xFF5026bc), width: 1.2),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       // Login button
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFF5026bc),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             padding: const EdgeInsets.symmetric(vertical: 14),
//                           ),
//                           onPressed: () {
//
//                           },
//                           child: const Text(
//                             'Login',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w700,
//                               letterSpacing: 1,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           // OR and SSO button
//           Positioned(
//             top: size.height * 0.705,
//             left: 0,
//             right: 0,
//             child: Column(
//               children: [
//                 const Text(
//                   "OR",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                 ),
//                 const SizedBox(height: 2),
//                     Container(
//                       width: size.width * 0.9,
//                       padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.19),
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.07),
//                             blurRadius: 16,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                         border: Border.all(color: Colors.white.withOpacity(0.25)),
//                       ),
//                       child: const Text(
//                          'Login with DB SSO',
//                           textAlign: TextAlign.center,
//                         style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15)
//                       ) ,
//                     )
//               ],
//             ),
//           ),
//           // Copyright
//           Positioned(
//             bottom: 50,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: Text(
//                 'Copyright © 2023 RimaOne',
//                 style: TextStyle(
//                   color: Colors.white.withOpacity(0.74),
//                   fontSize: 14,
//                   fontFamily: 'Quicksand',
//                 ),
//               ),
//             ),
//           ),
//         ],
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

