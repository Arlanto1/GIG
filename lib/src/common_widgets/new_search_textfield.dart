import 'dart:ui';

import 'package:db_atom/index.dart';

class FlutterInputField extends StatelessWidget {
  final String hintText;
  final Function onChange;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final TextEditingController? controller;
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
  final int? characterLimit;
  final bool? textCapitalization;
  final Color? textFormFieldBackgroundColor;
  final bool showCounter;
  final bool isLoginScreen;


  const FlutterInputField({
    super.key,
    required this.hintText,
    required this.onChange,
    this.prefixWidget,
    this.suffixWidget,
    this.controller,
    this.suffixTap,
    this.validateTextField,
    this.isSecure = false,
    this.isEnable = true,
    this.lineHeight = 1,
    this.labelFontSize = 16,
    this.hintFontSize = 16,
    this.autoFocus = false,
    required this.textFormKey,
    this.textInputType = TextInputType.text,
    this.onTap,
    this.isDisableColor,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
    this.focusNode,
    this.initialValue,
    this.labelText,
    this.suffixIcon,
    this.showBorder,
    this.characterLimit = Constants.characterLimitIdTextFormField,
    this.textCapitalization = true,
    this.textFormFieldBackgroundColor,
    this.showCounter = true,
    this.isLoginScreen = false,
  });
  //
  // @override
  // Widget build(BuildContext context) {
  //   // log('-controller?.text-----${controller?.text}--');
  //   return TextFormField(
  //     key: Key(textFormKey),
  //     controller: controller,
  //     textInputAction: textInputAction,
  //     textCapitalization: textCapitalization ?? true
  //         ? TextCapitalization.sentences
  //         : TextCapitalization.none,
  //     obscureText: isSecure,
  //     initialValue: initialValue,
  //     enabled: isEnable,
  //     maxLines: isEnable == true ? lineHeight : null, // Allow scrolling if not editable
  //     // maxLines: lineHeight,
  //     minLines: isEnable == true ? null : lineHeight, // Adjust min lines when not editable
  //     autofocus: autoFocus!,
  //     // autocorrect: false,
  //     spellCheckConfiguration: const SpellCheckConfiguration(),
  //     enableSuggestions: true,
  //     keyboardType: textInputType,
  //     focusNode: focusNode,
  //     style: const TextStyle(color: Colors.white),
  //     decoration: showBorder ?? true
  //         ? InputDecoration(
  //             fillColor: (isDisableColor ?? false)
  //                 ? Colors.transparent
  //                 : Colors.white12,
  //             filled: true,
  //             border: const OutlineInputBorder(),
  //             focusedBorder: OutlineInputBorder(
  //               borderSide: const BorderSide(
  //                   color: AppColors.white, width: 1.0),
  //               borderRadius: BorderRadius.circular(8.0),
  //             ),
  //             enabledBorder: OutlineInputBorder(
  //               //<-- SEE HERE
  //               borderSide: const BorderSide(
  //                   color: AppColors.white, width: 1.0),
  //               borderRadius: BorderRadius.circular(8.0),
  //             ),
  //             disabledBorder: OutlineInputBorder(
  //               //<-- SEE HERE
  //               borderSide: const BorderSide(
  //                   color: Colors.white, width: 1.0),
  //               borderRadius: BorderRadius.circular(8.0),
  //             ),
  //             hintText: hintText,
  //             prefixIcon: prefixWidget,
  //             suffixIcon: suffixWidget,
  //             // suffixText: '${textFieldController?.text.length}/$characterLimit',
  //             hintStyle: TextStyle(
  //               fontSize: hintFontSize,
  //             ),
  //           )
  //         : InputDecoration(
  //             fillColor: (textFormFieldBackgroundColor != null)
  //                 ? Colors.white
  //                 : Colors.white ,
  //             filled: true,
  //             labelText: labelText,
  //             labelStyle: const TextStyle(
  //               color: Colors.white,
  //             ),
  //             // Initial label color
  //             focusedBorder: const UnderlineInputBorder(
  //               borderSide:
  //                   BorderSide(color: Colors.white), // Color when focused
  //             ),
  //             suffixIcon: Icon(suffixIcon),
  //           ),
  //
  //     onChanged: (String str) {
  //       onChange(str);
  //     },
  //     inputFormatters: [
  //       if (textInputType == TextInputType.number) ...[
  //         FilteringTextInputFormatter.digitsOnly
  //       ]
  //     ],
  //     maxLength: characterLimit,
  //     validator: (String? value) {
  //       if (validateTextField != null) {
  //         return validateTextField!(value);
  //       }
  //       return null;
  //     },
  //     onTap: () {
  //       onTap != null ? onTap!() : null;
  //     },
  //     onFieldSubmitted: (value) {
  //       onFieldSubmitted != null
  //           ? onFieldSubmitted!(value)
  //           : FocusScope.of(context).nextFocus();
  //     },
  //     onEditingComplete: () {
  //       FocusScope.of(context).unfocus();
  //     },
  //   );


// Wrap with gradient background container
//     return Container(
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [
//             Color(0xFFDB2777), // main pink shade
//             Color(0xFFF472B6), // light pink
//             Color(0xFFE9D5FF), // lavender tint
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       child: textFormField, // the widget above
//     );

  // }
  @override
  Widget build(BuildContext context) {
    final textFormField = TextFormField(
      key: Key(textFormKey),
      controller: controller,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization ?? true
          ? TextCapitalization.sentences
          : TextCapitalization.none,
      obscureText: isSecure,
      initialValue: initialValue,
      enabled: isEnable,
      maxLines: isEnable == true ? lineHeight : null,
      minLines: isEnable == true ? null : lineHeight,
      autofocus: autoFocus!,
      textAlign: TextAlign.start,
      spellCheckConfiguration: const SpellCheckConfiguration(),
      enableSuggestions: true,
      keyboardType: textInputType,
      focusNode: focusNode,
      style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
      decoration: showBorder ?? true
          ? InputDecoration(
              filled: true,
              fillColor: Colors.transparent,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 1.0),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 1.0),
              ),
              hintText: hintText,
              prefixIcon: prefixWidget,
              suffixIcon: suffixWidget,
              hintStyle:
                  TextStyle(fontSize: hintFontSize, color: Colors.white70),
            )
          : InputDecoration(
              filled: true,
              labelText: labelText,
              labelStyle: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              suffixIcon: Icon(suffixIcon),
            ),
      onChanged: (String str) {
        onChange(str);
      },
      inputFormatters: [
        if (textInputType == TextInputType.number) ...[
          FilteringTextInputFormatter.digitsOnly
        ]
      ],
      // maxLength: maxLength?  characterLimit: maxLength,
      maxLength: showCounter == true
          ? characterLimit
          : null,
      buildCounter: (
          BuildContext context, {
            required int currentLength,
            required bool isFocused,
            required int? maxLength,
          }) {
        if (maxLength == null) return null; // no counter when maxLength is null
        return Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: Text(
            '$currentLength/$maxLength',
            style: const TextStyle(
              color: Colors.white, // <-- desired counter color
              fontWeight: FontWeight.w400,
              fontSize: 9,
            ),
          ),
        );
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
        onFieldSubmitted != null
            ? onFieldSubmitted!(value)
            : FocusScope.of(context).nextFocus();
      },
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
      },
    );
    // if (isLoginScreen) {
    //   // Simple text field without container
    //   return textFormField;
    // }

    // ✅ Wrap with gradient background container
    // return Container(
    //   decoration: BoxDecoration(
    //     gradient: LinearGradient(
    //       colors: [
    //         Colors.white.withValues(alpha: 0), // subtle white glow
    //         const Color(0xFF6474C6).withValues(alpha: 0), // lavender-blue
    //         const Color(0xFFD6D6FF).withValues(alpha: 0), // soft white-purple
    //         Colors.white.withValues(alpha: 0.8),
    //         // const Color(0xFFD6D6FF).withValues(alpha: 0)
    //       ],
    //       stops: const [0, 0.9, 0.7, 3],
    //       begin: Alignment.topLeft,
    //       end: Alignment.bottomRight,
    //     ),
    //     boxShadow: [
    //       BoxShadow(
    //         color: Colors.white.withValues(alpha: 0),
    //         blurRadius: 10,
    //         offset: const Offset(-3, -3), // white glow on top-left
    //       ),
    //       BoxShadow(
    //         color: AppColors.lavender.withValues(alpha: 2),
    //         blurRadius: 0,
    //         offset: const Offset(3, 3), // soft shadow bottom-right
    //       ),
    //     ],
    //     borderRadius: BorderRadius.circular(20),
    //     border: Border.all(
    //       color: Colors.white.withValues(alpha: 1.5),
    //       width: 1.5,
    //     ),
    //   ),
    //   child: textFormField,
    // );
    // ✅ Clean Glass Container Wrapper
// ✅ Glassmorphism Container Wrapper
    // ✅ Lavender Glassmorphism Container Wrapper
    // return ClipRRect(
    //   borderRadius: BorderRadius.circular(25
    //   ),
    //   child: BackdropFilter(
    //     filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
    //     child: Container(
    //       decoration: BoxDecoration(
    //         // gradient: LinearGradient(
    //         //   colors: [
    //         //     Colors.white.withValues(alpha: 0), // subtle white glow
    //         //     const Color(0xFF6474C6).withValues(alpha: 0), // lavender-blue
    //         //     const Color(0xFFD6D6FF)
    //         //         .withValues(alpha: 0), // soft white-purple
    //         //     Colors.white.withValues(alpha: 0.4), // white edge tint
    //         //   ],
    //         //   begin: Alignment.topLeft,
    //         //   end: Alignment.bottomRight,
    //         // ),
    //         // gradient: LinearGradient(
    //         //   colors: [
    //         //     // Colors.white.withValues(alpha: 0.2),
    //         //     Colors.white.withValues(alpha: 0.28),
    //         //     const Color(0xFF6474C6).withValues(alpha: 0.2),
    //         //     const Color(0xFF6474C6).withValues(alpha: 0),
    //         //     // Colors.white.withValues(alpha: 0.5),
    //         //
    //         //   ],
    //         //   // stops: [0.02, 0.35, 0.9,],
    //         //   begin: Alignment.topRight,
    //         //   end: Alignment.bottomCenter,
    //         // ),
    //         gradient: LinearGradient(
    //           colors: [
    //             // Colors.white.withValues(alpha: 0.2),
    //             // Colors.white.withValues(alpha: 0.28),
    //             const Color(0xFF6474C6).withValues(alpha: 0.2),
    //             // const Color(0xFF6474C6).withValues(alpha: 0),
    //             Colors.white.withValues(alpha: 0.3),
    //
    //           ],
    //           // stops: [0.02, 0.35, 0.9,],
    //           begin: Alignment.topRight,
    //           end: Alignment.bottomCenter,
    //         ),
    //         borderRadius: BorderRadius.circular(25),
    //         border: Border.all(
    //           color: Colors.white.withValues(alpha: 90),
    //           width: 0.7,
    //         ),
    //         boxShadow: [
    //           BoxShadow(
    //             color: Colors.white.withValues(alpha: 3),
    //             blurRadius: 90,
    //             offset: const Offset(3, 3), // white glow on top-left
    //           ),
    //           BoxShadow(
    //             color: AppColors.lavender.withValues(alpha: 20),
    //             blurRadius: 30,
    //             offset: const Offset(6, 7), // soft shadow bottom-right
    //           ),
    //         ],
    //       ),
    //       // padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
    //       child: textFormField,
    //     ),
    //   ),
    // );

    return
      // isLoginScreen
    //     ? TextFormField(
    //   decoration: const InputDecoration(
    //     labelStyle: TextStyle(
    //       color: Colors.black,
    //     ),
    //     focusedBorder: UnderlineInputBorder(
    //       borderSide: BorderSide(color: Color(0xFF5026bc)),
    //     ),
    //   ),
    //     controller: controller,
    //     child: textFormField,
    //     style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black)
    // )
    //     :
    ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
  //       child: Container(
  //           decoration: isLoginScreen ?
  // InputDecoration(
  //             labelStyle: TextStyle(
  //               color: Colors.black,
  //             ),
  //             // focusedBorder: UnderlineInputBorder(
  //             //   borderSide: BorderSide(color: Color(0xFF5026bc)),
  //             // ),
  //           ): BoxDecoration(
  //           gradient: LinearGradient(
  //             colors: [
  //               const Color(0xFF6474C6).withValues(alpha: 0.2),
  //               Colors.white.withValues(alpha: 0.3),
  //             ],
  //             begin: Alignment.topRight,
  //             end: Alignment.bottomCenter,
  //           ),
  //           borderRadius: BorderRadius.circular(25),
  //           border: Border.all(
  //             color: Colors.white.withValues(alpha: 90),
  //             width: 0.7,
  //           ),
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.white.withValues(alpha: 3),
  //               blurRadius: 90,
  //               offset: const Offset(3, 3),
  //             ),
  //             BoxShadow(
  //               color: AppColors.lavender.withValues(alpha: 20),
  //               blurRadius: 30,
  //               offset: const Offset(6, 7),
  //             ),
  //           ],
  //         ),
  //         child: textFormField,
  //       ),
        child: Container(
          decoration: isLoginScreen
              ?   BoxDecoration(
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
              color: Colors.white.withValues(alpha: 0.6),
              width: 0.7,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.03),
                blurRadius: 90,
                offset: const Offset(3, 3),
              ),
              BoxShadow(
                color: AppColors.lavender.withValues(alpha: 0.0),
                blurRadius: 30,
                offset: const Offset(6, 7),
              ),
            ],
          )
              : BoxDecoration(
            gradient:
            (isDisableColor ?? false) ?
            LinearGradient( colors: [
              AppColors.disableTextFieldBackground.withValues(alpha: 0.1),
              AppColors.disableTextFieldBackground.withValues(alpha: 0.1),
            ],)
                :
            LinearGradient(
              colors: [
                // Colors.white.withValues(alpha: 0.2),
                // Colors.white.withValues(alpha: 0.28),
                const Color(0xFF6474C6).withValues(alpha: 0.4),
                // const Color(0xFF6474C6).withValues(alpha: 0),
                Colors.white.withValues(alpha: 0.35),

              ],
              // stops: [0.02, 0.35, 0.9,],
              begin: Alignment.topRight,
              end: Alignment.bottomCenter,
            ) ,
            // gradient:  isDisableColor ? : LinearGradient(
            //   colors: [
            //     const Color(0xFF6474C6).withValues(alpha: 0.2),
            //     Colors.white.withValues(alpha: 0.3),
            //   ],
            //   begin: Alignment.topRight,
            //   end: Alignment.bottomCenter,
            // ),
            borderRadius: BorderRadius.circular(25),
            border: isDisableColor ?? false ? Border.all(
              color: Colors.white.withValues(alpha: 0.5),
              width: 0.4,
            ) : Border.all(
              color: Colors.white.withValues(alpha: 0.9),
              width: 0.7,
            ) ,
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
          child: textFormField,
        ),

      ),
    );


  }
}

// class ObscuringTextEditingController extends TextEditingController {
//   @override
//   TextSpan buildTextSpan({
//     required BuildContext context,
//     required bool withComposing,
//     TextStyle? style,
//   }) {
//     var displayValue = '•' * value.text.length;
//     if (!value.composing.isValid || !withComposing) {
//       return TextSpan(style: style, text: displayValue);
//     }
//     final TextStyle? composingStyle = style?.merge(
//       const TextStyle(decoration: TextDecoration.none),
//     );
//     return TextSpan(
//       style: style,
//       children: <TextSpan>[
//         TextSpan(text: value.composing.textBefore(displayValue)),
//         TextSpan(
//           style: composingStyle,
//           text: value.composing.textInside(displayValue),
//         ),
//         TextSpan(text: value.composing.textAfter(displayValue)),
//       ],
//     );
//   }
// }
