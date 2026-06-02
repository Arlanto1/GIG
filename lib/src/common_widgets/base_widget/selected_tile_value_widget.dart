import 'dart:ui';

import 'package:flutter/material.dart';

import '../../utils/app_themes/colors/app_color.dart';
import '../../utils/app_themes/styles/app_styles.dart';

class SelectedTileValueWidget extends StatelessWidget {
  const SelectedTileValueWidget({
    super.key,
    required this.name,
    this.width,
  });

  final String name;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 75,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withValues(alpha: 0.09),
              Colors.transparent,
              Colors.white.withValues(alpha: 0.09),
            ],
            stops: const [0.02, 0.35, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.7),
            width: 0.6,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.0),
              blurRadius: 12,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child:
            name.isEmpty ? Container() : TileWidget(width: width, name: name));
  }
}

class TileWidget extends StatelessWidget {
  const TileWidget({
    super.key,
    required this.width,
    required this.name,
  });

  final double? width;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 50,
          width: width ?? 200,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.newColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.3),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextButton(
                    style: ButtonStyle(
                      overlayColor: WidgetStatePropertyAll(
                        AppColors.newColor.withValues(alpha: 2.9),
                      ),
                      padding: const WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                      backgroundColor: WidgetStatePropertyAll(
                        AppColors.newColor,
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      name,
                      style: Styles.textStyleBlack14.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
