
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';

class CustomPopMenu extends StatelessWidget {
  final List<PopMenuItems> itemList;
  final Function itemTap;
  final String popupImageName;

  const CustomPopMenu({
    super.key,
    required this.itemList,
    required this.itemTap,
    required this.popupImageName,
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
        popupImageName,
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
                AppColors.newColor3.withValues(alpha: 0.9),
              ],
              stops: const [0.02, 0.35, 1],
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
            stops: const [0.02, 0.35, 1],
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
