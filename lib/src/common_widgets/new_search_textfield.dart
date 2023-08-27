import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:flutter/material.dart';

class FlutterInputField extends StatelessWidget {
  final String hintText;
  final Function onChange;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final TextEditingController? textFieldController;
  final Function? suffixTap;
  final Function? onTap;
  final Function? validateTextField;
  final Function? onfieldSubmitted;
  final bool isSecure;
  final int lineHeight;
  final double labelFontSize;
  final double hintFontSize;
  final bool? autoFocus;
  final bool? isEnable;
  final bool? isDisableColor;
  final String textFormKey;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusnode;
  final String? initialValue;

  const FlutterInputField({
    Key? key,
    required this.hintText,
    required this.onChange,
    this.prefixWidget,
    this.suffixWidget,
    this.textFieldController,
    this.suffixTap,
    this.validateTextField,
    this.isSecure = false,
    this.isEnable = true,
    this.lineHeight = 1,
    this.labelFontSize = 16,
    this.hintFontSize = 16,
    this.autoFocus = false,
    required this.textFormKey,
    this.keyboardType = TextInputType.text,
    this.onTap,
    this.isDisableColor,
    this.textInputAction,
    this.onfieldSubmitted,
    this.focusnode,
    this.isDisableColor,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: Key(textFormKey),
      controller: textFieldController,
      textInputAction: textInputAction,
      obscureText: isSecure,
      initialValue: initialValue,
      enabled: isEnable,
      maxLines: lineHeight,
      autofocus: autoFocus!,
      keyboardType: keyboardType,
      focusNode: focusnode,
      decoration: InputDecoration(
        fillColor: (isDisableColor ?? false) ? AppColors.disabletextfieldBackground:AppColors.enabletextfieldBackground,
        filled: true,
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFCACACA), width: 1.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          //<-- SEE HERE
          borderSide: const BorderSide(color: Color(0xFFCACACA), width: 1.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        disabledBorder: OutlineInputBorder(
          //<-- SEE HERE
          borderSide: const BorderSide(color: Color(0xFFCACACA), width: 1.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        hintText: hintText,
        prefixIcon: prefixWidget,
        suffixIcon: suffixWidget,
        hintStyle: TextStyle(
          fontSize: hintFontSize,
        ),
      ),
      onChanged: (String str) {
        onChange(str);
      },
      validator: (String? value) {
        return validateTextField!(value);
      },
      onTap: () {
        onTap != null ? onTap!() : null;
      },
      onFieldSubmitted: (value) {
        // onfieldSubmitted != null ? onfieldSubmitted!() : null;
           onfieldSubmitted!(value);
      },
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
      },
    );
  }
}
