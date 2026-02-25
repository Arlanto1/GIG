// import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
// import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
// import 'package:flutter/material.dart';
//
// PreferredSizeWidget appBar(
//   String? screenType,
//   String? title,
// ) {
//   return AppBar(
//     title: Text(
//       title ?? '',
//       //style: Styles.textStyleBlue16,
//     ),
//     // leading: IconButton(
//     //   onPressed: () {
//     //     Navigator.pop(context);
//     //   },
//     //   icon: SvgPicture.asset(
//     //     AppIcon.cancelIcon,
//     //     color: getActiveThemeColors(),
//     //     key: const Key(Keys.allocationCancelIcon),
//     //   ),
//     // ),
//   );
// }
//
// class AppHeader extends StatelessWidget implements PreferredSizeWidget {
//   const AppHeader({
//     super.key,
//     this.action,
//     this.title,
//     this.backBtn,
//     this.backgroundColour,
//     this.isTitleCenter,
//     this.isVisible,
//   });
//
//   final String? title;
//   final List<Widget>? action;
//   final Widget? backBtn;
//   final Color? backgroundColour;
//   final bool? isTitleCenter;
//   final bool? isVisible;
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       /*INFO: Doesn't Let us apply default Back button*/
//       automaticallyImplyLeading: false,
//       centerTitle: isTitleCenter,
//       elevation: 0,
//       backgroundColor: backgroundColour ?? AppColors.navigationSkyBlueColor,
//       titleSpacing: 0.0,
//       title: Transform(
//           // you can forcefully translate values left side using Transform
//           transform: Matrix4.translationValues(0.0, 0.0, 0.0),
//           child:
//               Text(title ?? '', style: Styles.textStyleRegularNormalWhite18)),
//       leading: backBtn,
//       actions: action,
//     );
//   }
//
//   @override
//   Size get preferredSize => AppBar().preferredSize;
// }

import 'dart:ui';

import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget appBar(
    String? screenType,
    String? title,
    ) {
  return AppBar(
    title: Text(
      title ?? '',
      //style: Styles.textStyleBlue16,
    ),
    // leading: IconButton(
    //   onPressed: () {
    //     Navigator.pop(context);
    //   },
    //   icon: SvgPicture.asset(
    //     AppIcon.cancelIcon,
    //     color: getActiveThemeColors(),
    //     key: const Key(Keys.allocationCancelIcon),
    //   ),
    // ),
  );
}

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({
    super.key,
    this.action,
    this.title,
    this.backBtn,
    this.backgroundColour,
    this.isTitleCenter,
    this.isVisible,
    this.titleWidget,
  });

  final String? title;
  final List<Widget>? action;
  final Widget? backBtn;
  final Color? backgroundColour;
  final bool? isTitleCenter;
  final bool? isVisible;
  final Widget? titleWidget;

  // @override
  // Widget build(BuildContext context) {
  //   return AppBar(
  //     /*INFO: Doesn't Let us apply default Back button*/
  //     automaticallyImplyLeading: false,
  //     centerTitle: isTitleCenter,
  //     elevation: 0,
  //     backgroundColor: backgroundColour ?? AppColors.navigationSkyBlueColor,
  //     titleSpacing: 0.0,
  //     title: Transform(
  //       // you can forcefully translate values left side using Transform
  //       transform: Matrix4.translationValues(0.0, 0.0, 0.0),
  //
  //       child: titleWidget ?? // 👈 PRIORITY TO LOGO
  //           Text(
  //             title ?? '',
  //             style: Styles.textStyleRegularNormalWhite18,
  //           ),
  //     ),
  //     leading: backBtn,
  //     actions: action,
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return ClipRect(
  //     child: BackdropFilter(
  //       filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
  //       child: Container(
  //         color: Colors.transparent,
  //         // decoration: BoxDecoration(
  //         //   color: (backgroundColour ?? AppColors.newColor)
  //         //       .withOpacity(0.55), // 🔥 glass tint
  //         //   border: Border(
  //         //     bottom: BorderSide(
  //         //       color: Colors.white.withOpacity(0.15),
  //         //       width: 1,
  //         //     ),
  //         //   ),
  //         //   boxShadow: [
  //         //     BoxShadow(
  //         //       color: Colors.black.withOpacity(0.25),
  //         //       blurRadius: 20,
  //         //       offset: const Offset(0, 8),
  //         //     ),
  //         //   ],
  //         // ),
  //         child: AppBar(
  //           automaticallyImplyLeading: false,
  //           centerTitle: isTitleCenter,
  //           elevation: 0,
  //           backgroundColor: Colors.transparent, // 🔥 IMPORTANT
  //           titleSpacing: 0,
  //           leading: backBtn,
  //           actions: action,
  //           title: Transform(
  //             transform: Matrix4.translationValues(0, 0, 0),
  //             child: titleWidget ??
  //                 Text(
  //                   title ?? '',
  //                   style: Styles.textStyleRegularNormalWhite18,
  //                 ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight + 10),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
          child: Container(
            // color: Colors.transparent,
            decoration: BoxDecoration(
             color:  Colors.transparent,
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withValues(alpha: 0.25),
                  width: 0.5,
                ),
              ),
            ),
            child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: isTitleCenter,
              titleSpacing: 0,
              leading: backBtn,
              title: titleWidget ??
                  Text(
                    title ?? '',
                    style: Styles.textStyleRegularNormalWhite18,
                  ),
              actions: action,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
