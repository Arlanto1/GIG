// Created by Ramesh
import 'package:db_atom/src/common_widgets/app_button.dart';
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/new_search_textfield.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/login/views/forgot_password.dart';
import 'package:db_atom/src/features/login/views/login_password.dart';
import 'package:db_atom/src/routing/router.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/customalert.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:db_atom/src/utils/validators/validator.dart';
import 'package:flutter/material.dart';

export 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController userNameTextController = TextEditingController();
  String username = '';
  String password = '';
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    userNameTextController.text = 'user2@user2.com';
    username = 'user2@user2.com';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    // final width = size.width;
    return Scaffold(
      backgroundColor: AppColors.backgroundWhitecolor,
      body: Container(
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
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                    )),
                // decoration: BoxDecoration(
                //     border: Border.all(
                //       color: Colors.white,
                //     ),
                //     borderRadius: const BorderRadius.all(Radius.circular(20))),
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

                      // Username input field

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              Constants.email,
                              style: Styles.textStyleBlack16,
                            ),
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            textFieldController: userNameTextController,
                            textFormKey: Keys.userTextField,
                            hintText: Constants.hintUserName,
                            onChange: (String username) {
                              this.username = username;
                              setState(() {});
                            },
                            validateTextField: (String? user) {
                              if (!Validator.isValidEmail(user)) {
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

                          CommonWidgets.verticalSpacerWidget(height * 0.02),

                          // Password field
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              Constants.password,
                              style: Styles.textStyleBlack16,
                            ),
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          LoginPassword(
                            validatePassword: ((String? password) {
                              if (!Validator.isValidPassword(password)) {
                                return Constants.passwordError;
                              } else if (!Validator.passwordValidation(password)) {
                                return Constants.passwordLengthError;
                              }
                            }),
                            onChange: (String password) {
                              this.password = password;
                            },
                          ),

                          CommonWidgets.verticalSpacerWidget(height * 0.03),

                          // Login button
                          AppButton(
                            key: const Key(Keys.loginButton),
                            buttonText: Constants.loginButtonTitle,
                            buttonTextKey: Keys.loginButtonText,
                            onTap: () async {
                              //loginFormKey.currentState!.validate();
                              FocusScope.of(context).unfocus();
                              try {
                                  if (loginFormKey.currentState!.validate())
                                  {
                                  //  final ValidLoginDetails validLoginDetails =
                                  //      ValidLoginDetails(userName: username, password: password);
                                  //  widget.onValidLogin(validLoginDetails);
                                  await SharedPrefs.setUsername(username);
                                  await SharedPrefs.setUserId('14');
                                 await SharedPrefs.setIdentifymenuindex(0);
                                Navigator.pushNamed(context, homePageRoute);
                                  //_loginSuccess(context);
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
                        },
                      ),
                      CommonWidgets.verticalSpacerWidget(
                        height * 0.17,
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Center(
                            child: Text(
                              Constants.supporttext,
                              style: Styles.textStyleBlack16,
                            ),
                          ),
                          CommonWidgets.verticalSpacerWidget(
                            height * 0.003,
                          ),
                          const Center(
                            child: Text(
                              Constants.copyrighttext,
                              style: Styles.textStyleRegularGrey14,
                            ),
                          )
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
      ),
    );
  }

  _loginSuccess(BuildContext context) {
    var dialog = CustomAlertDialog(
        title: Constants.appname,
        message: "Login Sucessfully.",
        onPostivePressed: () {
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
        CommonWidgets.verticalSpacerWidget(MediaQuery.of(context).size.height * 0.001),
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
