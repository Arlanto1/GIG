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
  final bool? disableColor;

  const AppButton({
    Key? key,
    this.buttonText,
    this.onTap,
    this.buttonKey,
    this.buttonTextKey,
    this.width,
    this.height,
    this.disableColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig.init(context);
    final screenWidth = ScreenSizeConfig.screenWidth;
    return SizedBox(
      width: width ?? (screenWidth! * 1.0),
      height: height ?? 50.00,
      child: TextButton(
        key: Key(buttonKey ?? ''),
        child: Text(buttonText ?? '', key: Key(buttonTextKey ?? '')),
        onPressed: () {
          onTap!();
        },
        style: TextButton.styleFrom(
          backgroundColor: disableColor ?? false ? AppColors.disabletextfieldBackground:AppColors.navigationSkybluecolor,
          foregroundColor: Colors.white,
          textStyle: Styles.textStyleSemiBold16White,
          shape: const StadiumBorder(),
        ),
      ),
    );
  }
}
