// Created by Ramesh

import 'package:db_atom/src/common_widgets/new_search_textfield.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPassword extends StatefulWidget {
  final Function(String? password) validatePassword;
  final Function(String onChangeStr) onChange;
  final FocusNode? passFocusNode;
  final Function? onFieldSubmitted;
  final TextInputAction? textInputAction;

  const LoginPassword(
      {super.key,
      required this.validatePassword,
      required this.onChange,
      this.passFocusNode,
      this.onFieldSubmitted,
      this.textInputAction});

  @override
  State<LoginPassword> createState() => _LoginPasswordState();
}

class _LoginPasswordState extends State<LoginPassword> {
  bool _showPassword = false;
  TextEditingController passwordTextController = ObscuringTextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // passwordTextController.text = "123456";
  }

  @override
  Widget build(BuildContext context) {
    return FlutterInputField(
      textFieldController: passwordTextController,
      textFormKey: Keys.passwordTextField,
      hintText: Constants.hintPassword,
      onChange: (String str) => widget.onChange(str),
      isSecure: false,
      validateTextField: (String? pwd) => widget.validatePassword(pwd),
      textInputAction: widget.textInputAction,
      focusNode: widget.passFocusNode,
      onFieldSubmitted: (value) {
        widget.onFieldSubmitted != null
            ? widget.onFieldSubmitted!(value)
            : null;
      },
      prefixWidget: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SvgPicture.asset(
          AppIcon.secureIcon,
          width: 20,
        ),
      ),
      suffixWidget: IconButton(
        icon: !_showPassword
            ? SvgPicture.asset(
                AppIcon.closeEye,
                key: const Key('closed_eye'),
              )
            : SvgPicture.asset(AppIcon.openEye, key: const Key('open_eye')),
        onPressed: () {
          setState(() => _showPassword = !_showPassword);
        },
      ),
    );
  }
}
