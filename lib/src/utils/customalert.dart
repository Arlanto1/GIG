// // import 'dart:ui';
// //
// // import 'package:db_atom/src/constants/constants.dart';
// // import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
// // import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
// // import 'package:flutter/material.dart';
// //
// // class CustomAlertDialog extends StatelessWidget {
// //   final Color? bgColor;
// //   final String? title;
// //   final String? message;
// //   final String? positiveBtnText;
// //   final String? negativeBtnText;
// //   final void Function()? onPositivePressed;
// //   final Function? onNegativePressed;
// //   final double? circularBorderRadius;
// //
// //   const CustomAlertDialog({
// //     super.key,
// //     this.title,
// //     this.message,
// //     this.circularBorderRadius = 20.0,
// //     this.bgColor = Colors.transparent,
// //     this.positiveBtnText,
// //     this.negativeBtnText,
// //     this.onPositivePressed,
// //     this.onNegativePressed,
// //   })  : assert(bgColor != null),
// //         assert(circularBorderRadius != null);
// //   @override
// //   Widget build(BuildContext context) {
// //     return Dialog(
// //       backgroundColor: Colors.transparent, // Ensure background is see-through for glass effect
// //       shape: RoundedRectangleBorder(
// //         borderRadius: BorderRadius.circular(circularBorderRadius ?? 20.0),
// //       ),
// //       child: ClipRRect(
// //         borderRadius: BorderRadius.circular(circularBorderRadius ?? 20.0),
// //         child: BackdropFilter(
// //           filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20), // Glass blur effect
// //           child: Container(
// //             decoration: BoxDecoration(
// //               gradient: LinearGradient(
// //                 colors: [
// //                   Colors.white.withValues(alpha: 0.2),
// //                   Colors.transparent,
// //                   Colors.white.withValues(alpha: 0.2),
// //                   // Color(0xFF6474C6).withOpacity(0.14)
// //                 ],
// //                 stops: const [0.02, 0.35, 1],
// //                 begin: Alignment.topCenter,
// //                 end: Alignment.bottomCenter,
// //               ),
// //               borderRadius: BorderRadius.circular(27),
// //               border: Border.all(
// //                 color: Colors.white.withValues(alpha: 0.80),
// //                 width: 0.8,
// //               ),
// //               boxShadow: [
// //                 BoxShadow(
// //                   color: const Color(0xFF6474C6).withValues(alpha: 0.09),
// //                   blurRadius: 12,
// //                   offset: const Offset(0, 2),
// //                 ),
// //               ],
// //             ),
// //             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
// //             child: Column(
// //               mainAxisSize: MainAxisSize.min,
// //               crossAxisAlignment: CrossAxisAlignment.stretch,
// //               children: [
// //                 if (title != null)
// //                   Text(
// //                     title!,
// //                     style: Styles.textFontSet(18, AppColors.white,
// //                         FontWeight.w900, Constants.customFontMediumFamily),
// //                   ),
// //                 if (title != null) const SizedBox(height: 8),
// //                 if (message != null)
// //                   Text(
// //                     message!,
// //                     style: Styles.textFontSet(16, Colors.white, FontWeight.w900,
// //                         Constants.customFontBoldFamily),
// //                   ),
// //                 const SizedBox(height: 20),
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.end,
// //                   children: [
// //                     if (negativeBtnText != null)
// //                       TextButton(
// //                         child: Text(
// //                           negativeBtnText!,
// //                           style: Styles.textFontSet(
// //                             16,
// //                             AppColors.white,
// //                             FontWeight.normal,
// //                             Constants.customFontMediumFamily,
// //                           ),
// //                         ),
// //                         onPressed: () {
// //                           Navigator.of(context).pop();
// //                           if (onNegativePressed != null) {
// //                             onNegativePressed!();
// //                           }
// //                         },
// //                       ),
// //                     if (positiveBtnText != null)
// //                       TextButton(
// //                         onPressed: onPositivePressed,
// //                         child: Text(
// //                           positiveBtnText!,
// //                           style: Styles.textFontSet(
// //                             16,
// //                             AppColors.white,
// //                             FontWeight.normal,
// //                             Constants.customFontMediumFamily,
// //                           ),
// //                         ),
// //                       ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// // }
//
// import 'package:db_atom/src/constants/constants.dart';
// import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
// import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
// import 'package:flutter/material.dart';
//
// class CustomAlertDialog extends StatelessWidget {
//   final Color? bgColor;
//   final String? title;
//   final String? message;
//   final String? positiveBtnText;
//   final String? negativeBtnText;
//   final void Function()? onPositivePressed;
//   final Function? onNegativePressed;
//   final double? circularBorderRadius;
//
//   const CustomAlertDialog({
//     super.key,
//     this.title,
//     this.message,
//     this.circularBorderRadius = 28.0,
//     this.bgColor = Colors.transparent,
//     this.positiveBtnText,
//     this.negativeBtnText,
//     this.onPositivePressed,
//     this.onNegativePressed,
//   })  : assert(bgColor != null),
//         assert(circularBorderRadius != null);
//
//   static const _navy = Color(0xFF12065A);
//   static const _navyLight = Color(0xFF2A1A8C);
//   static const _gold = Color(0xFFD9BB91);
//   static const _body = Color(0xFFF3F1FA);
//   static const _green = Color(0xFF5DB87A);
//
//   static const _navyGradient = LinearGradient(
//     colors: [_navy, _navyLight],
//     begin: Alignment.centerLeft,
//     end: Alignment.centerRight,
//   );
//
//   TextStyle _style(double size, FontWeight weight, Color color) =>
//       Styles.textFontSet(size, color, weight, Constants.customFontMediumFamily);
//
//   @override
//   Widget build(BuildContext context) {
//     final radius = circularBorderRadius ?? 28.0;
//     final hasActions = positiveBtnText != null || negativeBtnText != null;
//     final bodyColor =
//     (bgColor == null || bgColor == Colors.transparent) ? _body : bgColor!;
//
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       insetPadding: const EdgeInsets.symmetric(horizontal: 16),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(radius),
//         child: Container(
//           color: bodyColor,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               // Header
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: const BoxDecoration(gradient: _navyGradient),
//                 child: Row(
//                   children: [
//                     Container(
//                       width: 50,
//                       height: 50,
//                       decoration: BoxDecoration(
//                         color: _gold,
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: const Icon(Icons.info_rounded,
//                           color: Colors.white, size: 28),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           if (title != null)
//                             Text(title!,
//                                 style: _style(
//                                     26, FontWeight.w700, AppColors.white)),
//                         ],
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () => Navigator.of(context).pop(),
//                       customBorder: const CircleBorder(),
//                       child: Container(
//                         width: 44,
//                         height: 44,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(
//                               color: Colors.white.withValues(alpha: 0.4)),
//                         ),
//                         child: const Icon(Icons.close,
//                             color: Colors.white, size: 22),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               // Gold line
//               Container(height: 3, color: _gold),
//
//               // Message
//               if (message != null)
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//                   child: Text(message!,
//                       style: _style(16, FontWeight.w500, _navy)),
//                 ),
//
//               // Actions
//               if (hasActions)
//                 Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       gradient: _navyGradient,
//                       borderRadius: BorderRadius.circular(22),
//                     ),
//                     child: Row(
//                       children: [
//                         if (negativeBtnText != null)
//                           Expanded(
//                             child: OutlinedButton(
//                               style: OutlinedButton.styleFrom(
//                                 minimumSize: const Size.fromHeight(46),
//                                 side: BorderSide(
//                                     color:
//                                     Colors.white.withValues(alpha: 0.5)),
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(14)),
//                               ),
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                                 onNegativePressed?.call();
//                               },
//                               child: Text(negativeBtnText!,
//                                   style: _style(
//                                       16, FontWeight.w600, AppColors.white)),
//                             ),
//                           ),
//                         if (negativeBtnText != null && positiveBtnText != null)
//                           const SizedBox(width: 12),
//                         if (positiveBtnText != null)
//                           Expanded(
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 minimumSize: const Size.fromHeight(46),
//                                 backgroundColor: _green,
//                                 elevation: 0,
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(14)),
//                               ),
//                               onPressed: onPositivePressed,
//                               child: Text(positiveBtnText!,
//                                   style: _style(
//                                       16, FontWeight.w600, AppColors.white)),
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                 )
//               else
//                 const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final Color? bgColor;
  final String? title;
  final String? message;
  final String? positiveBtnText;
  final String? negativeBtnText;
  final void Function()? onPositivePressed;
  final Function? onNegativePressed;
  final double? circularBorderRadius;

  const CustomAlertDialog({
    super.key,
    this.title,
    this.message,
    this.circularBorderRadius = 28.0,
    this.bgColor = Colors.transparent,
    this.positiveBtnText,
    this.negativeBtnText,
    this.onPositivePressed,
    this.onNegativePressed,
  })  : assert(bgColor != null),
        assert(circularBorderRadius != null);

  static const _navy = Color(0xFF12065A);
  static const _navyLight = Color(0xFF2A1A8C);
  static const _gold = Color(0xFFD9BB91);
  static const _body = Color(0xFFF3F1FA);
  static const _green = Color(0xFF5DB87A);

  static const _navyGradient = LinearGradient(
    colors: [_navy, _navyLight],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  TextStyle _style(double size, FontWeight weight, Color color) =>
      Styles.textFontSet(size, color, weight, Constants.customFontMediumFamily);

  @override
  Widget build(BuildContext context) {
    final radius = circularBorderRadius ?? 28.0;
    final hasActions = positiveBtnText != null || negativeBtnText != null;
    final bodyColor =
    (bgColor == null || bgColor == Colors.transparent) ? _body : bgColor!;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          color: bodyColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(gradient: _navyGradient),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: _gold,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.info_rounded,
                          color: Colors.white, size: 28),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DETAILS',
                            style: _style(12, FontWeight.w500,
                                Colors.white.withValues(alpha: 0.7))
                                .copyWith(letterSpacing: 2),
                          ),
                          if (title != null)
                            Text(title!,
                                style: _style(
                                    26, FontWeight.w700, AppColors.white)),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      customBorder: const CircleBorder(),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.white.withValues(alpha: 0.4)),
                        ),
                        child: const Icon(Icons.close,
                            color: Colors.white, size: 22),
                      ),
                    ),
                  ],
                ),
              ),

              // Gold line
              Container(height: 3, color: _gold),

              // Message
              if (message != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Text(message!,
                      style: _style(16, FontWeight.w500, _navy)),
                ),

              // Actions (no container, just buttons)
              if (hasActions)
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      if (negativeBtnText != null)
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size.fromHeight(46),
                              foregroundColor: _navy,
                              side: const BorderSide(color: _navy),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              onNegativePressed?.call();
                            },
                            child: Text(negativeBtnText!,
                                style: _style(16, FontWeight.w600, _navy)),
                          ),
                        ),
                      if (negativeBtnText != null && positiveBtnText != null)
                        const SizedBox(width: 12),
                      if (positiveBtnText != null)
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(46),
                              backgroundColor: _gold,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                            ),
                            onPressed: onPositivePressed,
                            child: Text(positiveBtnText!,
                                style: _style(
                                    16, FontWeight.w600, AppColors.white)),
                          ),
                        ),
                    ],
                  ),
                )
              else
                const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}