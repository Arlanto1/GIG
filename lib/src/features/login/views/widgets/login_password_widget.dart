import 'package:db_atom/index.dart';

class LoginPassword extends StatefulWidget {
  final Function(String? password) validatePassword;
  final Function(String onChangeStr) onChange;
  final FocusNode? passFocusNode;
  final Function? onFieldSubmitted;
  final TextInputAction? textInputAction;

  const LoginPassword({
    super.key,
    required this.validatePassword,
    required this.onChange,
    this.passFocusNode,
    this.onFieldSubmitted,
    this.textInputAction,
  });

  @override
  State<LoginPassword> createState() => _LoginPasswordState();
}

class _LoginPasswordState extends State<LoginPassword> {
  bool _showPassword = false;
  TextEditingController passwordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterInputField(
      controller: passwordTextController,
      textFormKey: Keys.passwordTextField,
      hintText: Constants.hintPassword,
      onChange: (String str) => widget.onChange(str),
      textCapitalization: false,
      isSecure: !_showPassword,
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
        icon: _showPassword
            ? const Icon(Icons.visibility_off)
            : const Icon(Icons.visibility),
        onPressed: () {
          setState(() {
            _showPassword = !_showPassword;
          });
        },
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  final String hintText;
  final Function(String? password) validatePassword;
  final Function(String onChangeStr) onChange;
  final FocusNode? passFocusNode;
  final Function? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final bool isEnable;
  final bool? showBorder;
  final bool? isDisableColor;
  final int lineHeight;
  final double hintFontSize;
  final bool textCapitalization;

  const PasswordField({
    super.key,
    required this.hintText,
    required this.validatePassword,
    required this.onChange,
    this.passFocusNode,
    this.onFieldSubmitted,
    this.textInputAction,
    this.isEnable = true,
    this.showBorder = false,
    this.isDisableColor,
    this.lineHeight = 1,
    this.hintFontSize = 16.0,
    this.textCapitalization = true,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _showPassword = false;
  late TextEditingController passwordTextController;

  @override
  void initState() {
    super.initState();
    passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return TextFormField(
    //   controller: passwordTextController,
    //   focusNode: widget.passFocusNode,
    //   obscureText: !_showPassword,
    //   textInputAction: widget.textInputAction,
    //   textCapitalization: widget.textCapitalization
    //       ? TextCapitalization.sentences
    //       : TextCapitalization.none,
    //   enabled: widget.isEnable,
    //   maxLines: widget.lineHeight,
    //   decoration: InputDecoration(
    //     labelText: widget.hintText,
    //     labelStyle: const TextStyle(
    //       color: Colors.black,
    //     ),
    //     focusedBorder: const UnderlineInputBorder(
    //       borderSide: BorderSide(color: Color(0xFF5026bc)),
    //     ),
    //     suffixIcon: IconButton(
    //       icon: Icon(
    //         !_showPassword ? Icons.visibility_off : Icons.visibility,
    //       ),
    //       onPressed: () {
    //         setState(() {
    //           _showPassword = !_showPassword;
    //         });
    //       },
    //     ),
    //   ),
    //   style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black),
    //   onChanged: widget.onChange,
    //   validator: (password) => widget.validatePassword(password),
    //   onFieldSubmitted: (value) {
    //     if (widget.onFieldSubmitted != null) {
    //       widget.onFieldSubmitted!(value);
    //     }
    //   },
    // );
    return Container(
     decoration:  BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF6474C6).withValues(alpha: 0.0),
            Colors.white.withValues(alpha: 0.3),
          ],
          begin: Alignment.topCenter,
          end: Alignment.topCenter,
        ),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 0.7,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.03),
            blurRadius: 90,
            offset: const Offset(3, 3),
          ),
          BoxShadow(
            color: AppColors.lavender.withValues(alpha: 0.2),
            blurRadius: 30,
            offset: const Offset(6, 7),
          ),
        ],
      ),
      child: TextFormField(
        controller: passwordTextController,
        focusNode: widget.passFocusNode,
        obscureText: !_showPassword,
        textInputAction: widget.textInputAction,
        textCapitalization: widget.textCapitalization
            ? TextCapitalization.sentences
            : TextCapitalization.none,
        enabled: widget.isEnable,
        maxLines: widget.lineHeight,
        decoration: InputDecoration(
          labelText: widget.hintText,
          labelStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w100,
          ),
          contentPadding: const EdgeInsets.only(left: 0, right: 10, top: 0, bottom: 14),
          isDense: true,
          border: InputBorder.none, // removes the underline
          prefixIcon: IconButton(
            icon: Icon(
              _showPassword ? Icons.visibility : Icons.visibility_off,
              color: Colors.black.withOpacity(0.4),
              size: 25,
            ),
            onPressed: () {
              setState(() {
                _showPassword = !_showPassword;
              });
            },
          ),
        ),
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: Colors.black,
        ),
        onChanged: widget.onChange,
        validator: (password) => widget.validatePassword(password),
        onFieldSubmitted: (value) {
          if (widget.onFieldSubmitted != null) {
            widget.onFieldSubmitted!(value);
          }
        },
      ),
    );

  }
}
