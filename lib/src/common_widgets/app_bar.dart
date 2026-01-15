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

  @override
  Widget build(BuildContext context) {
    return AppBar(
      /*INFO: Doesn't Let us apply default Back button*/
      automaticallyImplyLeading: false,
      centerTitle: isTitleCenter,
      elevation: 0,
      backgroundColor: backgroundColour ?? AppColors.navigationSkyBlueColor,
      titleSpacing: 0.0,
      title: Transform(
        // you can forcefully translate values left side using Transform
        transform: Matrix4.translationValues(0.0, 0.0, 0.0),

        child: titleWidget ?? // 👈 PRIORITY TO LOGO
            Text(
              title ?? '',
              style: Styles.textStyleRegularNormalWhite18,
            ),
      ),
      leading: backBtn,
      actions: action,
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
