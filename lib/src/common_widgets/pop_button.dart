import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:flutter/material.dart';

class PopButton extends StatelessWidget {
  final String? buttonText;
  final Function? onTap;
  final String? buttonKey;
  final String? buttonTextKey;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? boarderColor;
  final TextStyle? textStyle;
  final double? width;
  final String? imageText;

  const PopButton(
      {super.key,
      this.buttonText,
      this.onTap,
      this.buttonKey,
      this.buttonTextKey,
      this.backgroundColor,
      this.foregroundColor,
      this.textStyle,
      this.boarderColor,
      this.width,
      this.imageText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 50.00,
      child: TextButton(
        key: Key(buttonKey ?? ''),
        onPressed: () {
          onTap!();
        },
        style: TextButton.styleFrom(
          side: BorderSide(
            color: boarderColor ?? Colors.white,
          ),
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          textStyle: textStyle,
          shape: const StadiumBorder(),
        ),
        child: buttonText != null && buttonText != ''
            ? Text(buttonText ?? '', key: Key(buttonTextKey ?? ''))
            : SvgPicture.asset(
                imageText ?? '',
                color: AppColors.navigationSkybluecolor,
                width: 20,
                //key: const Key(Keys.userIcon),
              ),
      ),
    );
  }
}
