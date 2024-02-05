import 'package:flutter/material.dart';

import '../utils/app_themes/colors/app_color.dart';

class FlutterInputField extends StatelessWidget {
  final String hintText;
  final Function onChange;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final TextEditingController? textFieldController;
  final Function? suffixTap;
  final Function? onTap;
  final Function? validateTextField;
  final Function? onFieldSubmitted;
  final bool isSecure;
  final int lineHeight;
  final double labelFontSize;
  final double hintFontSize;
  final bool? autoFocus;
  final bool? isEnable;
  final bool? isDisableColor;
  final String textFormKey;
  final TextInputType textInputType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final String? initialValue;
  final String? labelText;
  final IconData? suffixIcon;
  final bool? showBorder;

  const FlutterInputField({
    super.key,
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
    this.textInputType =TextInputType.text,
    this.onTap,
    this.isDisableColor,
    this.textInputAction,
    this.onFieldSubmitted,
    this.focusNode,
    this.initialValue,
    this.labelText,
    this.suffixIcon,
    this.showBorder,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: Key(textFormKey),
      controller: textFieldController,
      textInputAction: textInputAction,
      textCapitalization: TextCapitalization.words,
      obscureText: isSecure,
      initialValue: initialValue,
      enabled: isEnable,
      maxLines: lineHeight,
      autofocus: autoFocus!,
      // autocorrect: false,
      enableSuggestions: false,
      keyboardType: textInputType,
      focusNode: focusNode,
      decoration: showBorder ?? false
          ? InputDecoration(
              fillColor: (isDisableColor ?? false)
                  ? AppColors.disabletextfieldBackground
                  : AppColors.enabletextfieldBackground,
              filled: true,
              border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: AppColors.gerylightBackground, width: 1.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              enabledBorder: OutlineInputBorder(
                //<-- SEE HERE
                borderSide: const BorderSide(
                    color: AppColors.gerylightBackground, width: 1.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              disabledBorder: OutlineInputBorder(
                //<-- SEE HERE
                borderSide: const BorderSide(
                    color: AppColors.gerylightBackground, width: 1.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              hintText: hintText,
              prefixIcon: prefixWidget,
              suffixIcon: suffixWidget,
              hintStyle: TextStyle(
                fontSize: hintFontSize,
              ),
            )
          : InputDecoration(
              labelText: labelText,
              labelStyle: const TextStyle(
                color: Colors.grey,
              ),
              // Initial label color
              focusedBorder: const UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.blue), // Color when focused
              ),
              suffixIcon: Icon(suffixIcon),
            ),
      onChanged: (String str) {
        onChange(str);
      },
      validator: (String? value) {
        if (validateTextField != null) {
          return validateTextField!(value);
        }
        return null;
      },
      onTap: () {
        onTap != null ? onTap!() : null;
      },
      onFieldSubmitted: (value) {
        onFieldSubmitted != null ? onFieldSubmitted!(value) : null;
      },
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
      },
    );
  }
}

class ObscuringTextEditingController extends TextEditingController {
  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      required bool withComposing,
      TextStyle? style}) {
    var displayValue = '•' * value.text.length;
    if (!value.composing.isValid || !withComposing) {
      return TextSpan(style: style, text: displayValue);
    }
    final TextStyle? composingStyle = style?.merge(
      const TextStyle(decoration: TextDecoration.none),
    );
    return TextSpan(
      style: style,
      children: <TextSpan>[
        TextSpan(text: value.composing.textBefore(displayValue)),
        TextSpan(
          style: composingStyle,
          text: value.composing.textInside(displayValue),
        ),
        TextSpan(text: value.composing.textAfter(displayValue)),
      ],
    );
  }
}
