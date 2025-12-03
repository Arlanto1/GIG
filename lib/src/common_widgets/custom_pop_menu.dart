// import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
// import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
// import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// class CustomPopmenu extends StatelessWidget {
//   final List<PopMenuItems> itemList;
//
//   // final List<String> itemImageList;
//   final Function itemTap;
//   final String popupimagename;
//
//   const CustomPopmenu(
//       {super.key,
//       required this.itemList,
//       required this.itemTap,
//       required this.popupimagename});
//
//   @override
//   Widget build(BuildContext context) {
//     var appBarHeight = AppBar().preferredSize.height;
//
//     return PopupMenuButton(
//       color: AppColors.backgroundWhiteColor,
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(10.0))),
//       icon: SvgPicture.asset(
//         popupimagename,
//         colorFilter: const ColorFilter.mode(
//           AppColors.backgroundWhiteColor,
//           BlendMode.srcIn,
//         ),
//         width: 18,
//         height: 18,
//         //key: const Key(Keys.userIcon),
//       ),
//       offset: Offset(0.0, appBarHeight),
//       onSelected: (value) {
//         // your logic
//         itemTap(value);
//       },
//       itemBuilder: (BuildContext bc) {
//         return _buildPopupMenuItem();
//       },
//     );
//   }
//
//   List<PopupMenuItem> _buildPopupMenuItem() {
//     List<PopupMenuItem> children = [];
//     for (int i = 0; i < itemList.length; i++) {
//       PopMenuItems popItem = itemList[i];
//       children.add(PopupMenuItem(
//         value: i,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             SvgPicture.asset(
//               popItem.imageName,
//               colorFilter: const ColorFilter.mode(
//                 AppColors.textGreyThemeColor,
//                 BlendMode.srcIn,
//               ),
//               width: 15,
//               height: 15,
//               //key: const Key(Keys.userIcon),
//             ),
//             //CommonWidgets.horizontalSpacerWidget(width * 0.03),
//
//             //  const Icon(
//             //             Icons.logout_rounded,
//             //             color: AppColors.textgreyThemecolor,
//             //           ),
//             const SizedBox(
//               width: 13,
//             ),
//             Align(
//               alignment: Alignment.topLeft,
//               child: Text(
//                 popItem.title,
//                 style: Styles.textStyleRegularNormalGrey14,
//               ),
//             ),
//           ],
//         ),
//       ));
//     }
//
//     return children;
//   }
// }
//
// class PopMenuItems {
//   final String title;
//   final String imageName;
//
//   const PopMenuItems(this.title, this.imageName);
// }
import 'dart:ui';
import 'package:db_atom/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';

class CustomPopmenu extends StatelessWidget {
  final List<PopMenuItems> itemList;
  final Function itemTap;
  final String popupimagename;

  const CustomPopmenu({
    super.key,
    required this.itemList,
    required this.itemTap,
    required this.popupimagename,
  });

  @override
  Widget build(BuildContext context) {
    final appBarHeight = AppBar().preferredSize.height;

    return PopupMenuButton(
      elevation: 3,
      offset: Offset(0, appBarHeight),

      // Transparent so our custom glass background shows
      color: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,

      icon: SvgPicture.asset(
        popupimagename,
        width: 18,
        height: 18,
        colorFilter: const ColorFilter.mode(
          Colors.white,
          BlendMode.srcIn,
        ),
      ),

      onSelected: (value) => itemTap(value),

      itemBuilder: (context) {
        return [
          PopupMenuItem(
            enabled: false,
            padding: EdgeInsets.zero,
            child: _buildGlassMenu(context),
          )
        ];
      },
    );
  }

  Widget _buildGlassMenu(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.newColor3.withValues(alpha: 0.9),
                AppColors.newColor3.withValues(alpha: 0.9),

                // Colors.white,
                AppColors.newColor3.withValues(alpha: 0.9),
                // Colors.white.withValues(alpha: 0.2),
                // Color(0xFF6474C6).withOpacity(0.14)
              ],
              stops: [0.02, 0.35, 1],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(27),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.90),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.newColor.withValues(alpha: 0.09),
                blurRadius: 12,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(itemList.length, (i) {
              return _buildGlassItem(itemList[i], i);
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassItem(PopMenuItems item, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withValues(alpha: 0.2),
              Colors.transparent,
              Colors.white.withValues(alpha: 0.2),
              // Color(0xFF6474C6).withOpacity(0.14)
            ],
            stops: [0.02, 0.35, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(27),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.80),
            width: 0.8,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6474C6).withValues(alpha: 0.09),
              blurRadius: 12,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: InkWell(
          onTap: () => itemTap(index),
          borderRadius: BorderRadius.circular(14),
          child: Row(
            children: [
              const SizedBox(width: 12),
              SvgPicture.asset(
                item.imageName,
                width: 18,
                height: 18,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                item.title,
                style: Styles.textStyleRegularNormalWhite18.copyWith(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PopMenuItems {
  final String title;
  final String imageName;

  const PopMenuItems(this.title, this.imageName);
}
