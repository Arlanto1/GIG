import 'package:flutter/material.dart';

import '../../constants/app_icon.dart';
import '../../utils/app_themes/colors/app_color.dart';
import '../../utils/helpers/keys/keys.dart';
import '../basic_reusable_widgets.dart';

class AddButtonWidget extends StatelessWidget {
  const AddButtonWidget({
    super.key,
     this.isDisableColor,  this.height,
  });

  final bool? isDisableColor;
final double? height;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height??60,
      width: 50,
      decoration: BoxDecoration(
          color: (isDisableColor ?? false)
              ? AppColors.disabletextfieldBackground
              : AppColors.navigationSkybluecolor,
          border: Border.all(
            color: (isDisableColor ?? false)
                ? AppColors.disabletextfieldBackground
                : AppColors.navigationSkybluecolor,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child:
          Center(
        child: SvgPicture.asset(
          AppIcon.addicon,
          width: 20,
          height: 20,
          key: const Key(Keys.userIcon),
        ), //Icon(Icons.add,color: AppColors.backgroundWhitecolor,size: 60,)
      ),
    );
  }
}
