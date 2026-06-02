import 'dart:ui';
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
    this.titleColor,
  });

  final String? title;
  final List<Widget>? action;
  final Widget? backBtn;
  final Color? backgroundColour;
  final bool? isTitleCenter;
  final bool? isVisible;
  final Widget? titleWidget;
  final Color? titleColor;
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
                    style: Styles.textStyleRegularNormalWhite18.copyWith(
                      color: titleColor ?? Colors.white,  // ← use titleColor
                    ),
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
