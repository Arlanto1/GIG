
import 'package:db_atom/src/common_widgets/screen_size_config.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String? buttonText;
  final Function? onTap;
  final String? buttonKey;
  final String? buttonTextKey;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final bool? disableColor;

  const AppButton({
    super.key,
    this.buttonText,
    this.onTap,
    this.buttonKey,
    this.buttonTextKey,
    this.width,
    this.height,
    this.backgroundColor,
    this.disableColor,
  });

  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig.init(context);
    final screenWidth = ScreenSizeConfig.screenWidth;
    Color background = backgroundColor ?? AppColors.navigationSkyBlueColor;
    Color foreground = Colors.white;
    Color border = Colors.transparent;

    // For Cancel Button
    if (background != AppColors.white) {
      border = Colors.white54;
      foreground = Colors.blue;
    }
    return SizedBox(
      width: width ?? (screenWidth! * 1.0),
      height: height ?? 70.00,
      // child: TextButton(
      //   key: Key(buttonKey ?? ''),
      //   onPressed: () {
      //     onTap!();
      //   },
      //   autofocus: true,
      //   style: TextButton.styleFrom(
      //     backgroundColor: disableColor ?? false
      //         ? AppColors.disableTextFieldBackground
      //         : const Color(0xFF071130),
      //     // :Colors.white,
      //     foregroundColor: Colors.white,
      //     // backgroundColor: background,
      //     // foregroundColor: foreground,
      //     textStyle: Styles.textStyleSemiBold16DarkBlue,
      //     shape: const StadiumBorder(),
      //     side: BorderSide(color: border), // Add a border color if needed
      //   ),
      //   child: Text(buttonText ?? '', key: Key(buttonTextKey ?? '')),
      // ),
      child: TextButton(
        key: Key(buttonKey ?? ''),
        onPressed: () {
          onTap!();
        },
        autofocus: true,
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          textStyle: Styles.textStyleSemiBold16DarkBlue,
          // shape: const StadiumBorder(),
          side: BorderSide(
            color: border.withValues(alpha: disableColor ?? false ? 0.2 : 0.2),
          ),
          // padding: EdgeInsets.zero,
        // ).copyWith(
        //   overlayColor: MaterialStateProperty.all(Colors.white.withOpacity(0.1)),
        ),
        child: Ink(
          decoration: BoxDecoration(
          //   gradient: disableColor ?? false
          //       ? LinearGradient(
          //     colors: [
          //       AppColors.disableTextFieldBackground.withOpacity(0.6),
          //       AppColors.disableTextFieldBackground.withOpacity(0.8),
          //     ],
          //   )
          //       : const LinearGradient(
          //     begin: Alignment.topLeft,
          //     end: Alignment.bottomRight,
          //     colors: [
          //       Color(0xFF071130),
          //       Colors.white70.w,
          //       Color(0xFF071130),
          //     ],
          //   ),
          //   borderRadius: BorderRadius.circular(25),
          // ),
            gradient: disableColor ?? false
              ? LinearGradient(
              colors: [
                AppColors.disableTextFieldBackground.withValues(alpha: 0.6),
                AppColors.disableTextFieldBackground.withValues(alpha: 0.8),
              ],
            ) : LinearGradient(
              colors: [
                // const Color(0xFF6474C6).withValues(alpha: 0.2),
                // const Color(0xFF071130).withValues(alpha: 0.9),
                // Color(0xFF0C4C99),
                // Color(0xFF0C4C99),
                // Color(0xFF071130),
                // Color(0xFF071130),
                AppColors.newColor,
                AppColors.newColor,
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
          ),
          child: Center(
            child: Text(
              buttonText ?? '',
              key: Key(buttonTextKey ?? ''),
            ),
          ),
        ),
      ),
    );

  }
}

