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

  const AppButton({
    Key? key,
    this.buttonText,
    this.onTap,
    this.buttonKey,
    this.buttonTextKey,
    this.width,
    this.height,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig.init(context);
    final screenWidth = ScreenSizeConfig.screenWidth;
    Color background = backgroundColor ?? AppColors.navigationSkybluecolor;
    Color foreground = Colors.white;
    Color border = Colors.transparent;

    // For Cancel Button
    if (background != AppColors.navigationSkybluecolor) {
      border = Colors.grey;
      foreground = Colors.black;
    }

    return SizedBox(
      width: width ?? (screenWidth! * 1.0),
      height: height ?? 50.00,
      child: TextButton(
        key: Key(buttonKey ?? ''),
        onPressed: () {
          onTap!();
        },
        style: TextButton.styleFrom(
          backgroundColor: background,
          foregroundColor: foreground,
          textStyle: Styles.textStyleSemiBold16White,
          shape: const StadiumBorder(),
          side: BorderSide(color: border), // Add a border color if needed
        ),
        child: Text(buttonText ?? '', key: Key(buttonTextKey ?? '')),
      ),
    );
  }
}
