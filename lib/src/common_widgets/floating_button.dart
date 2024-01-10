import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/screen_size_config.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:flutter/material.dart';

class Flutterfloatingbutton extends StatelessWidget {
  final Function? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const Flutterfloatingbutton(
      {super.key,
      this.onPressed,
      this.backgroundColor,
      this.foregroundColor,});
  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig.init(context);
   // final screenWidth = ScreenSizeConfig.screenWidth;
    return FloatingActionButton(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      onPressed: () {
        // Respond to button press
        onPressed!();
      },
      child: SvgPicture.asset(
                              //AppIcon.dropdownicon,
                              AppIcon.addicon,
                              //fit: BoxFit.,
                              //color: AppColors.textColor,
                              width: 20,
                               height: 20,
                              key: const Key(Keys.userIcon),
                            ),
    );
  }
}
