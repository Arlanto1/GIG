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
  final bool isSecure;
  final int lineHeight;
  final double labelFontSize;
  final double hintFontSize;
  final bool? autoFocus;
  final bool? isEnable;
  final bool? isDisableColor;
  final String textFormKey;
  final TextInputType keyboardType;
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
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: Key(textFormKey),
      controller: textFieldController,
      obscureText: isSecure,
      initialValue: initialValue,
      enabled: isEnable,
      maxLines: lineHeight,
      autofocus: autoFocus!,
      keyboardType: keyboardType,
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
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
      },
    );
  }
}
