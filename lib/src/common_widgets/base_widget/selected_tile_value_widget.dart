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
              // Colors.white.withValues(alpha: 0.2),
              // Colors.white.withValues(alpha: 0.28),
              const Color(0xFF6474C6).withValues(alpha: 0.3),
              // const Color(0xFF6474C6).withValues(alpha: 0),
              Colors.white.withValues(alpha: 0.3),

            ],
            // stops: [0.02, 0.35, 0.9,],
            begin: Alignment.topRight,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: Colors.white.withValues(alpha: 90),
            width: 0.7,
          ),
          boxShadow: [
            // BoxShadow(
            //   color: AppColors.lavender.withValues(alpha: 4),
            //   // blurRadius: 1,
            //   offset: const Offset(3, 3), // white glow on top-left
            // ),
            BoxShadow(
              color: AppColors.lavender.withValues(alpha: 20),
              blurRadius: 30,
              offset: const Offset(6, 7), // soft shadow bottom-right
            ),
          ],
        ),
            // border: Border.all(
            //   color: const Color(0xFFCACACA),
            // ),
            // borderRadius: const BorderRadius.all(Radius.circular(8))),
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
                    color: Colors.white.withValues(alpha: 0.15),
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
                        Colors.black.withValues(alpha: 0.1),
                      ),
                      padding: const WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                      backgroundColor: const WidgetStatePropertyAll(
                        Colors.transparent,
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      name,
                      style: Styles.textStyleBlack14.copyWith(
                        color: Colors.black,
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
