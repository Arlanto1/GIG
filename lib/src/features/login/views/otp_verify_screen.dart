import 'dart:developer';

import 'package:db_atom/src/common_widgets/app_bar.dart';
import 'package:db_atom/src/common_widgets/app_button.dart';
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/new_search_textfield.dart';
import 'package:db_atom/src/common_widgets/spinnerdialog.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/login/bloc/login_bloc.dart';
import 'package:db_atom/src/features/login/models/login_request_model.dart';
import 'package:db_atom/src/features/login/services/login_services.dart';
import 'package:db_atom/src/routing/router.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/customalert.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:db_atom/src/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpVerifyScreen extends StatelessWidget {
  String userName = '';
  String password = '';

  OtpVerifyScreen({super.key, this.userName = '', this.password = ''});

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
          icon: SvgPicture.asset(AppIcon.backIcon,
              color: AppColors.backgroundWhitecolor),
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
            // TODO: May be need to clear navigation stack
            Navigator.pushNamedAndRemoveUntil(context, homePageRoute, (route) => false,);
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

                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.03),
                                  Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'Dont you receive any code?',
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
                                              widget.userName, widget.pwd, ''),
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
                                                widget.userName,
                                                widget.pwd,
                                                otp,
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

  LoginRequestModel prepareLoginRequestBody(
      String userName, String pwd, String otp) {
    return LoginRequestModel(
        request: Request(userName: userName, password: pwd, otp: otp));
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
